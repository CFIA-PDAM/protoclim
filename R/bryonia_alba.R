#' @title
#' GBIF occurrence data for Bryonia alba
#'
#' @description
#' `r lifecycle::badge("experimental")`

#' Occurrence data for the plant Bryonia alba, the eastern white-bryony, from
#' the Global Biodiversity Information Facility.
#'
#' @format A data frame with 10,023 rows and 5 variables:
#' \describe{
#'   \item{basisOfRecord}{The specific nature of the data record.}
#'   \item{species}{The scientific name of the species.}
#'   \item{countryCode}{The ISO 3166-1 alpha-2 country code where the occurrence was recorded.}
#'   \item{decimalLatitude}{The geographic latitude (in decimal degrees, using the WGS84 datum) of the geographic centre of the location of the occurrence.}
#'   \item{decimalLongitude}{The geographic longitude (in decimal degrees, using the WGS84 datum) of the geographic centre of the location of the occurrence.}
#' }
#'
#' @concept example data sets
#'
#' @examples
#' bryonia_alba
#'
#' @source GBIF.org (12 August 2026) GBIF Occurrence Download https://doi.org/10.15468/dl.pgvhfj
"bryonia_alba"
