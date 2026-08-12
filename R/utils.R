#' Add layers of climate data to GBIF occurrence data
#'
#' For all layers (i.e. climate variables) within `climate_data`, add each
#' layers' values in a given raster cell to all GBIF occurrence records with
#' coordinates contained by the cell.
#'
#' GBIF records (i.e. rows) with missing values in `decimalLongitude` and
#' `decimalLatitude` are returned without the addition of climate layers.
#'
#' `add_climate_layers()` is an internal function and is not intended to be
#' called directly by users.
#'
#' @param climate_data a SpatRaster of climate layers
#'
#' @param occurrence_data a tibble of GBIF occurrence data
#'
#' @returns the original `occurrence_data` with an additional column for each
#' layer in `climate_data`
#'
#' @keywords internal
add_climate_layers <- function(climate_data, occurrence_data) {
  # Convert the occurrence data to a vector object
  occurrence_data_vect <- terra::vect(
    as.data.frame(occurrence_data),
    geom = base::c("decimalLongitude", "decimalLatitude"),
    "EPSG:4326"
  )

  # To each row of occurrence data with valid coordinates, extract the layer
  # values of the containing climate_data cell. Supress the ID column since it's
  # never needed.
  df <- dplyr::mutate(
    occurrence_data,
    terra::extract(climate_data, occurrence_data_vect, ID = FALSE)
  )

  return(df)
}

#' Perform checks of the climate data
#'
#' @keywords internal
check_climate_data <- function(climate_data) {
  # Abort if climate_data is missing
  rlang::check_required(climate_data)

  # Abort if climate_data is not a SpatRaster
  if (!inherits(climate_data, "SpatRaster")) {
    cli::cli_abort(
      "{.arg climate_data} must be a {.cls SpatRaster}, not {.obj_type_friendly {climate_data}}"
    )
  }

  # Abort if climate_data is not in EPSG:4326
  if (!terra::same.crs(climate_data, "EPSG:4326")) {
    cli::cli_abort(
      "{.arg climate_data} must be in the EPSG:4326 coordinate reference system"
    )
  }

  return(invisible(NULL))
}

#' Perform checks of the occurrence data
#'
#' @keywords internal
check_occurrence_data <- function(occurrence_data) {
  # Abort if occurrence_data is missing
  rlang::check_required(occurrence_data)

  # Abort if occurrence_data is not a dataframe
  rlang::check_data_frame(occurrence_data)

  # Check if expected column names are available
  missing_columns <- setdiff(
    c("decimalLongitude", "decimalLatitude"),
    names(occurrence_data)
  )

  is_missing_columns <- !rlang::is_empty(missing_columns)

  if (is_missing_columns) {
    cli::cli_abort(
      "{.arg occurrence_data} is missing the following required columns: {.val {missing_columns}}",
      class = "missing_occurrence_columns"
    )
  }

  # Check if all rows are missing from either decimalLongitude or
  # decimalLatitude
  is_missing_coords <- any(
    all(is.na(occurrence_data$decimalLongitude)),
    all(is.na(occurrence_data$decimalLatitude))
  )

  # Abort if all rows are missing coordinates
  if (is_missing_coords) {
    cli::cli_abort(
      "{.arg occurrence_data} contains no valid pair of coordinates in {.field decimalLongitude} and {.field decimalLatitude}",
      class = "no_valid_coords"
    )
  }

  return(invisible(NULL))
}

#' Compute the area covered by each level within each layer of climate data
#'
#' For all layers (i.e. climate variables) within `climate_data`, calculate the
#' area of the Earth's surface covered by each level (i.e. category). By
#' default, area is calculated in squared meters, but any valid unit of
#' measurement in `units::valid_udunits()` can be supplied to the `unit`
#' argument.
#'
#' @param climate_data a terra SpatRaster containing one or more layers of
#' categorical climate data
#'
#' @param unit optional, the abbreviation of the areal unit of measurement
#'
#' @returns a list of tibbles, one per layer of climate data
#'
#' @keywords internal
compute_area <- function(climate_data = NULL, unit = NULL) {
  # Calculate the area for every layer in climate_data

  level_area <- terra::expanse(
    climate_data,
    unit = "m",
    byValue = TRUE,
    usename = TRUE
  )

  level_area <- dplyr::rename(level_area, level = "value")

  # Set the units of area to meters squared, the default in terra::expanse()
  level_area <- dplyr::mutate(
    level_area,
    area = units::set_units(.data$area, "m^2")
  )

  # If the unit argument is provided, try to set the units of area. An error is
  # raised if the units are not within units::valid_udunits()
  if (!rlang::is_null(unit)) {
    level_area <- dplyr::mutate(
      level_area,
      area = units::set_units(.data$area, unit, mode = "standard")
    )
  }

  # Coerce to tibble
  level_area <- tibble::as_tibble(level_area)

  # Split the layers into list elements
  level_area <- split(level_area, ~layer)

  # Drop the layer from each tibble since it's encoded in the name of the list
  # element
  level_area <- purrr::map(level_area, \(x) dplyr::select(x, !"layer"))

  return(level_area)
}
