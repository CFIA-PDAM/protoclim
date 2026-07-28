# Calculate a weed species' climate suitability across covariate levels

**\[experimental\]**

## Usage

``` r
calculate_climate_suitability(
  gbif_occurrence_data = NULL,
  covariate_summary = NULL,
  covariate = c("kgc", "pb", "phz")
)
```

## Arguments

- gbif_occurrence_data:

  a data frame of occurrence data extracted from GBIF. Augmented with
  covariate data via
  [`add_covariates()`](https://cfia-pdam.github.io/wracs/reference/add_covariates.md)

- covariate_summary:

  a data frame summarizing the area, in square miles, of each level of
  the specified covariate

- covariate:

  a string representing the covariate, either 'kgc', 'pb', or phz'
