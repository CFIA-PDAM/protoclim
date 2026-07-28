#' Calculate the area for each value of a covariate
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param covariate_raster a terra raster object of covariate data
#'
#' @param covariate a string representing the covariate, either 'kgc', 'pb', or
#' phz'
#
#' @export
calculate_covariate_area <- function(
  covariate_raster = NULL,
  covariate = c("kgc", "pb", "phz")
) {
  # Abort if the covariate is not an acceptable value
  rlang::arg_match(covariate)

  # Abort if the covariate raster is not provided
  rlang::check_required(covariate_raster)

  # Abort if the covariate raster is not a SpatRaster
  if (!rlang::inherits_all(covariate_raster, "SpatRaster")) {
    cli::cli_abort(
      "{.arg covariate_raster} must be a {.cls SpatRaster}, not 
      {.obj_type_friendly {covariate_raster}}"
    )
  }

  # Append _mode to the covariate so it matches the specification of the
  covariate <- glue::glue("{covariate}_mode")

  # Calculate the area per value within the covariate
  covariate_raster <- terra::expanse(
    covariate_raster[[covariate]],
    unit = "km",
    byValue = TRUE,
    usename = TRUE
  )

  # Drop the unnecessary layer column
  covariate_raster <- dplyr::select(covariate_raster, !.data$layer)

  # Convert area in square kilometers to square miles
  covariate_raster <- dplyr::mutate(
    covariate_raster,
    area = .data$area * 0.386102159
  )

  return(covariate_raster)
}
