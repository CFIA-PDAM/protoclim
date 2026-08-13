# Classify each layer of climate data into suitability classes

Based on the proportion of a taxon's occurrence records within each
level of each layer of climate data, classify each level into one of
four suitability classifications: "Not suitable", "Not likely to be
suitable", "Likely to be suitable", and "Suitable".

## Usage

``` r
classify_layers(climate_data, occurrence_data)
```

## Arguments

- climate_data:

  a `SpatRaster` object containing climate data layers.

- occurrence_data:

  a tibble of GBIF occurrence records

## Value

a list of tibbles, one per climate layer, each with level-wise
suitability classifications

## Examples

``` r
classify_layers(climate_layers_ssp370_2011_2040(), bryonia_alba)
#> $kgc_mode
#> # A tibble: 30 × 4
#>    level occurrence proportion suitability              
#>    <int>      <int>      <dbl> <ord>                    
#>  1     1          0     0      Not suitable             
#>  2     2          0     0      Not suitable             
#>  3     3          4     0.0461 Not likely to be suitable
#>  4     4        365     4.21   Suitable                 
#>  5     5          6     0.0692 Not likely to be suitable
#>  6     6          0     0      Not suitable             
#>  7     7         43     0.496  Not likely to be suitable
#>  8     8         59     0.680  Likely to be suitable    
#>  9     9         32     0.369  Not likely to be suitable
#> 10    10          0     0      Not suitable             
#> # ℹ 20 more rows
#> 
#> $pb_mode
#> # A tibble: 11 × 4
#>    level occurrence proportion suitability              
#>    <int>      <int>      <dbl> <ord>                    
#>  1     1         21     0.242  Not likely to be suitable
#>  2     2        764     8.81   Suitable                 
#>  3     3       5881    67.8    Suitable                 
#>  4     4       1541    17.8    Suitable                 
#>  5     5        341     3.93   Suitable                 
#>  6     6         76     0.876  Likely to be suitable    
#>  7     7         39     0.450  Not likely to be suitable
#>  8     8         11     0.127  Not likely to be suitable
#>  9     9          1     0.0115 Not likely to be suitable
#> 10    10          1     0.0115 Not likely to be suitable
#> 11    11          0     0      Not suitable             
#> 
#> $phz_mode
#> # A tibble: 28 × 4
#>    level occurrence proportion suitability 
#>    <int>      <int>      <dbl> <ord>       
#>  1     1          0          0 Not suitable
#>  2     2          0          0 Not suitable
#>  3     3          0          0 Not suitable
#>  4     4          0          0 Not suitable
#>  5     5          0          0 Not suitable
#>  6     6          0          0 Not suitable
#>  7     7          0          0 Not suitable
#>  8     8          0          0 Not suitable
#>  9     9          0          0 Not suitable
#> 10    10          0          0 Not suitable
#> # ℹ 18 more rows
#> 
```
