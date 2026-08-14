# GBIF occurrence data for Bryonia alba

**\[experimental\]** Occurrence data for the plant Bryonia alba, the
eastern white-bryony, from the Global Biodiversity Information Facility.

## Usage

``` r
bryonia_alba
```

## Format

A data frame with 10,023 rows and 5 variables:

- basisOfRecord:

  The specific nature of the data record.

- species:

  The scientific name of the species.

- countryCode:

  The ISO 3166-1 alpha-2 country code where the occurrence was recorded.

- decimalLatitude:

  The geographic latitude (in decimal degrees, using the WGS84 datum) of
  the geographic centre of the location of the occurrence.

- decimalLongitude:

  The geographic longitude (in decimal degrees, using the WGS84 datum)
  of the geographic centre of the location of the occurrence.

## Source

GBIF.org (12 August 2026) GBIF Occurrence Download
https://doi.org/10.15468/dl.pgvhfj

## Examples

``` r
bryonia_alba
#> # A tibble: 10,023 × 5
#>    basisOfRecord     species      countryCode decimalLatitude decimalLongitude
#>    <chr>             <chr>        <chr>                 <dbl>            <dbl>
#>  1 HUMAN_OBSERVATION Bryonia alba SE                     59.3             18.1
#>  2 HUMAN_OBSERVATION Bryonia alba SE                     59.0             18.3
#>  3 HUMAN_OBSERVATION Bryonia alba SE                     57.2             12.2
#>  4 HUMAN_OBSERVATION Bryonia alba SE                     57.2             12.2
#>  5 HUMAN_OBSERVATION Bryonia alba SE                     57.1             12.4
#>  6 HUMAN_OBSERVATION Bryonia alba SE                     57.1             12.2
#>  7 HUMAN_OBSERVATION Bryonia alba SE                     57.1             12.2
#>  8 HUMAN_OBSERVATION Bryonia alba SE                     57.1             12.3
#>  9 HUMAN_OBSERVATION Bryonia alba SE                     57.0             12.4
#> 10 HUMAN_OBSERVATION Bryonia alba SE                     56.9             16.8
#> # ℹ 10,013 more rows
```
