#' @title
#' Classify the suitability of each cell of climate data
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Using the suitability classifications in `layer_classes`, assign each cell of
#' climate `climate_data` a suitability classification for each layer of data.
#' Take the minimum suitability classification across all layers to assign an
#' overall classification to each cell.
#'
#' @param climate_data a `SpatRaster` object containing climate data layers.
#'
#' @param layer_classes a list of tibbles, one per climate layer, each with
#' level-wise suitability classifications
#'
#' @returns a list of tibbles, one per climate layer, each with level-wise
#' suitability classifications
#'
#' @details
#' details go here
#'
#' @examples
#' layer_classes <- classify_levels(
#'   climate_layers_ssp370_2011_2040(),
#'   bryonia_alba
#' )
#'
#' classify_cells(climate_layers_ssp370_2011_2040(), layer_classes)
#'
#' @export
classify_cells <- function(climate_data, layer_classes) {
  df <- climate_data

  purrr::iwalk(
    layer_classes,
    \(x, name) {
      df[[name]] <<- terra::subst(
        df[[name]],
        layer_classes[[name]]$level,
        layer_classes[[name]]$suitability
      )
    }
  )

  df$overall <- min(df)

  purrr::walk(
    names(df),
    \(x) {
      levels(df[[x]]) <<- tibble::tribble(
        ~level , ~suitability                ,
             1 , "Not suitable"              ,
             2 , "Not likely to be suitable" ,
             3 , "Likely to be suitable"     ,
             4 , "Suitable"
      )
    }
  )

  return(df)
}
