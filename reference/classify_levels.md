# Classify the suitability of each level of climate data

**\[experimental\]**

Based on the proportion of a taxon's occurrence records within each
level of each layer of climate data, classify each level into one of
four suitability classifications: "Not suitable", "Not likely to be
suitable", "Likely to be suitable", and "Suitable".

## Usage

``` r
classify_levels(climate_data, occurrence_data)
```

## Arguments

- climate_data:

  a `SpatRaster` object containing climate data layers.

- occurrence_data:

  a tibble of GBIF occurrence records

## Value

a list of tibbles, one per climate layer, each with level-wise
suitability classifications

## Details

details go here

## Examples

``` r
classify_levels(climate_layers_ssp370_2011_2040(), bryonia_alba)
#> $kgc_mode
#> # A tibble: 30 × 4
#>    level occurrence proportion suitability              
#>    <int>      <int>      <dbl> <ord>                    
#>  1     1          0     0      Not suitable             
#>  2     2          0     0      Not suitable             
#>  3     3          4     0.0460 Not likely to be suitable
#>  4     4        365     4.19   Suitable                 
#>  5     5          6     0.0689 Not likely to be suitable
#>  6     6          0     0      Not suitable             
#>  7     7         43     0.494  Not likely to be suitable
#>  8     8         59     0.678  Likely to be suitable    
#>  9     9         32     0.368  Not likely to be suitable
#> 10    10          0     0      Not suitable             
#> # ℹ 20 more rows
#> 
#> $pb_mode
#> # A tibble: 11 × 4
#>    level occurrence proportion suitability              
#>    <int>      <int>      <dbl> <ord>                    
#>  1     1         21     0.241  Not likely to be suitable
#>  2     2        768     8.83   Suitable                 
#>  3     3       5901    67.8    Suitable                 
#>  4     4       1542    17.7    Suitable                 
#>  5     5        342     3.93   Suitable                 
#>  6     6         76     0.873  Likely to be suitable    
#>  7     7         39     0.448  Not likely to be suitable
#>  8     8         11     0.126  Not likely to be suitable
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
