# Add layers of climate data to GBIF occurrence data

For all layers (i.e. climate variables) within `climate_data`, add each
layers' values in a given raster cell to all GBIF occurrence records
with coordinates contained by the cell.

## Usage

``` r
add_climate_layers(climate_data, occurrence_data)
```

## Arguments

- climate_data:

  a SpatRaster of climate layers

- occurrence_data:

  a tibble of GBIF occurrence data

## Value

the original `occurrence_data` with an additional column for each layer
in `climate_data`

## Details

GBIF records (i.e. rows) with missing values in `decimalLongitude` and
`decimalLatitude` are returned without the addition of climate layers.

`add_climate_layers()` is an internal function and is not intended to be
called directly by users.
