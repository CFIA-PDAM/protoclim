#' Classify each layer of climate data into suitability classes
#'
#' `r lifecycle::badge("experimental")`
#'
#' Based on the proportion of a taxon's occurrence records within each level of
#' each layer of climate data, classify each level into one of four suitability
#' classifications: "Not suitable", "Not likely to be suitable",
#' "Likely to be suitable", and "Suitable".
#'
#' @param climate_data a `SpatRaster` object containing climate data layers.
#'
#' @param occurrence_data a tibble of GBIF occurrence records
#'
#' @returns a list of tibbles, one per climate layer, each with level-wise
#' suitability classifications
#'
#' @examples
#' classify_layers(climate_layers_ssp370_2011_2040(), bryonia_alba)
#'
#' @export
classify_layers <- function(climate_data, occurrence_data) {
  check_climate_data(climate_data)
  check_occurrence_data(occurrence_data)

  df <- add_climate_layers(climate_data, occurrence_data)

  # We need a way to package the range of possible values for each climate layer
  # with the occurrence data. It's virtually impossible that a given taxon's
  # occurrence records span every level of each layer, so packaging with the
  # unique levels of each layer is required for downstream processing to work.
  layer_ranges <- climate_data |>
    terra::minmax() |>
    asplit(2) |>
    purrr::map(\(x) seq(x[[1]], x[[2]]))

  df <- purrr::imap(
    layer_ranges,
    \(range, layer) {
      df |>
        dplyr::filter_out(is.na(!!rlang::sym(layer))) |>
        dplyr::count("level" := !!rlang::sym(layer), name = "occurrence") |>
        tidyr::complete(level = range, fill = list(occurrence = 0))
    }
  )

  df <- purrr::map(
    df,
    \(x) {
      dplyr::mutate(
        x,
        proportion = .data$occurrence / sum(.data$occurrence) * 1e2
      )
    }
  )

  df <- purrr::map(
    df,
    \(x) {
      dplyr::mutate(
        x,
        suitability = cut(
          .data$proportion,
          breaks = c(-Inf, 0, 0.5, 1, 100),
          labels = c(
            "Not suitable",
            "Not likely to be suitable",
            "Likely to be suitable",
            "Suitable"
          ),
          ordered = TRUE
        )
      )
    }
  )

  return(df)
}
