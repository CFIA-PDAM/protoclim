# example-workflow

``` r

# library(protoclim)
```

Start by specifying where the data lives…

Then run add QC codes

``` r

# add_quality_control_flags()
```

There’s a whole world of ways to check for quality control issues. One
way like is

coordinatecleaner

Then run add covariates

``` r

# add_covariates()
```

Then run
[`calculate_covariate_area()`](https://cfia-pdam.github.io/protoclim/reference/calculate_covariate_area.md)

``` r

# calculate_covariate_area()
```

Then run
[`calculate_climate_suitability()`](https://cfia-pdam.github.io/protoclim/reference/calculate_climate_suitability.md)

``` r

# calculate_climate_suitability()
```
