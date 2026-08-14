#' @title
#' Climate layers averaged over 2011 - 2040 under the SSP370 emission scenario
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' Loads a categorical raster containing global Köppen-Geiger classes,
#' precipitation  bands, and plant hardiness zones. Downscaled and used for
#' illustrative purposes only. For higher resolution data, see
#' \url{https://zenodo.org/records/21400412}
#'
#' @details A terra raster with three layers
#' \describe{
#'   \item{\code{kgc_mode}}{Köppen-Geiger climate classes (1-30).}
#'   \item{\code{pb_mode}}{Precipitation bands (0-11).}
#'   \item{\code{phz_mode}}{Plant hardiness zone (1-28).}
#' }
#'
#' @return A \code{terra::SpatRaster} with three categorical layers, in
#'   lon/lat WGS 84 (EPSG:4326).
#'
#' @details
#' details go here
#'
#' @concept example data sets
#'
#' @source Derived from \url{https://zenodo.org/records/21400412}
#'
#' @examples
#' library(terra)
#'
#' plot(climate_layers_ssp370_2011_2040()$pb_mode)
#'
#' @export
climate_layers_ssp370_2011_2040 <- function() {
  r <- terra::rast(system.file(
    "extdata",
    "climate_layers_ssp370_2011_2040.tif",
    package = "protoclim"
  ))

  return(r)
}
