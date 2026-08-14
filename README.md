

<!-- badges: start -->

[![Codecov test coverage](https://codecov.io/gh/CFIA-PDAM/protoclim/graph/badge.svg)](https://app.codecov.io/gh/CFIA-PDAM/protoclim) [![R-CMD-check](https://github.com/CFIA-PDAM/protoclim/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CFIA-PDAM/protoclim/actions/workflows/R-CMD-check.yaml) [![status](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

<!-- badges: end -->

<!-- README.md is generated from README.qmd. Please edit that file -->

# protoclim

## Overview

`{protoclim}` is an R package for estimating a plant species’ potential geographic distribution on the basis of the species’ known distribution in climatically similar areas elsewhere in the world (i.e. climate matching). The `{protoclim}` package is designed to be used by biologists from regulatory agencies as they perform a formal [pest risk analysis](https://openknowledge.fao.org/server/api/core/bitstreams/547258dd-7817-4cb0-bb49-ff362ee5215c/content). To this end, the `{protoclim}` package is designed to quickly and easily produce mappable estimates of a plants species’ potential geographic distribution. Inspiration for `{protoclim}` was drawn heavily from [`Proto3`](https://link.springer.com/article/10.1007/s10530-017-1567-1), a GIS workflow developed and used by the United States Department of Agriculture in their [weed risk assessment](https://www.aphis.usda.gov/sites/default/files/wra-guidelines.pdf) process.

As per `Proto3`, `{protoclim}` estimates a plant species’ geographic distribution based on its global occurrence in each level of the following categorical climate classification systems.

1.  Köppen-Geiger classes
2.  Plant hardiness zones
3.  Precipitation bands

Multiple high-resolution global rasters containing each of these climate variables are available for download from [Zenodo](https://zenodo.org/records/21400412). At present, rasters are available for a combination of time periods (present vs. future) and emission scenarios (high vs. very-high). For more details, please see the associated repository [`protoclimData`](https://github.com/CFIA-PDAM/protoclimData).

Besides a raster of climate data, the only other data required to use `{protoclim}` is species occurrence data from the Global Biodiversity Information Facility (GBIF).

Users are encouraged to download the climate rasters from Zenodo and the occurrence data of their focal species from GBIF. For demonstration purposes, `{protoclim}` comes with two example datasets:

1.  `bryonia_alba`, GBIF occurrence data for *Bryonia alba*, the [eastern white-bryony](https://www.gbif.org/taxon/NJ97)

2.  `climate_layers_ssp370_2011_2040()`, downscaled Köppen-Geiger classes, plant hardiness zones, and precipitation bands for present day (2011-2040) climate under the SSP3-7.0 high emission scenario.

## Installation

The easiest way to get `{protoclim}` is to install it from CRAN:

``` r
install.packages("protoclim")
```

### Development version

To get a bug fix or to use a feature from the development version, you can install the development version of protoclim from GitHub:

``` r
# install.packages("pak")
pak::pkg_install("CFIA-PDAM/protoclim")
```

## Usage

The main workflow of `{protoclim}` is:

1.  classify the levels of each categorical climate variable by their level of suitability. These suitability levels are based on the proportion of occurrence records that fall within each level of the climate variable. At present, the suitability levels and their associated cutoffs are:

| Proportion       | Suitability               |
|:-----------------|:--------------------------|
| \>1%             | Suitable                  |
| ≥0.5% and \<1%   | Likely to be suitable     |
| \>0% and \<0.05% | Not likely to be suitable |
| 0%               | Not suitable              |

``` r
level_suitability <- classify_levels(
  climate_layers_ssp370_2011_2040(),
  bryonia_alba
)
```

1.  relabel each level of each climate variable within the original climate raster with the corresponding suitability classification, taking the minimum suitability level across variables to be the overall suitability

``` r
cell_suitability <- classify_cells(
  climate_layers_ssp370_2011_2040(),
  level_suitability
)
```

## Getting help

If you encounter a clear bug, please file an issue with a minimal reproducible example on [Github](https://github.com/CFIA-PDAM/protoclim/issues).
