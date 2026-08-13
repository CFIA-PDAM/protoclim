# Compute the area covered by each level within each layer of climate data

For all layers (i.e. climate variables) within `climate_data`, calculate
the area of the Earth's surface covered by each level (i.e. category).
By default, area is calculated in squared meters, but any valid unit of
measurement in
[`units::valid_udunits()`](https://r-quantities.github.io/units/reference/valid_udunits.html)
can be supplied to the `unit` argument.

## Usage

``` r
compute_area(climate_data = NULL, unit = NULL)
```

## Arguments

- climate_data:

  a terra SpatRaster containing one or more layers of categorical
  climate data

- unit:

  optional, the abbreviation of the areal unit of measurement

## Value

a list of tibbles, one per layer of climate data
