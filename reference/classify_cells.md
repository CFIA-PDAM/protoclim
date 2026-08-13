# Classify each cell of climate data into suitability classes

Using the suitability classifications in `layer_classes`, assign each
cell of climate `climate_data` a suitability classification for each
layer of data. Take the minimum suitability classification across all
layers to assign an overall classification to each cell.

## Usage

``` r
classify_cells(climate_data, layer_classes)
```

## Arguments

- climate_data:

  a `SpatRaster` object containing climate data layers.

- layer_classes:

  a list of tibbles, one per climate layer, each with level-wise
  suitability classifications

## Value

a list of tibbles, one per climate layer, each with level-wise
suitability classifications

## Examples

``` r
layer_classes <- classify_layers(
  climate_layers_ssp370_2011_2040(),
  bryonia_alba
)

classify_cells(climate_layers_ssp370_2011_2040(), layer_classes)
#> class       : SpatRaster
#> size        : 2088, 4320, 4  (nrow, ncol, nlyr)
#> resolution  : 0.08333333, 0.08333333  (x, y)
#> extent      : -180.0001, 179.9999, -90.00014, 83.99986  (xmin, xmax, ymin, ymax)
#> coord. ref. : lon/lat WGS 84 (EPSG:4326)
#> source(s)   : memory
#> varnames    : climate_layers_ssp370_2011_2040
#>               climate_layers_ssp370_2011_2040
#>               climate_layers_ssp370_2011_2040
#>               
#> names       :     kgc_mode,      pb_mode,     phz_mode,      overall
#> min values  : Not suitable, Not suitable, Not suitable, Not suitable
#> max values  :     Suitable,     Suitable,     Suitable,     Suitable
```
