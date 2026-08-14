# Climate layers averaged over 2011 - 2040 under the SSP370 emission scenario

**\[experimental\]**

Loads a categorical raster containing global Köppen-Geiger classes,
precipitation bands, and plant hardiness zones. Downscaled and used for
illustrative purposes only. For higher resolution data, see
<https://zenodo.org/records/21400412>

## Usage

``` r
climate_layers_ssp370_2011_2040()
```

## Source

Derived from <https://zenodo.org/records/21400412>

## Value

A
[`terra::SpatRaster`](https://rspatial.github.io/terra/reference/SpatRaster-class.html)
with three categorical layers, in lon/lat WGS 84 (EPSG:4326).

## Details

A terra raster with three layers

- `kgc_mode`:

  Köppen-Geiger climate classes (1-30).

- `pb_mode`:

  Precipitation bands (0-11).

- `phz_mode`:

  Plant hardiness zone (1-28).

details go here

## Examples

``` r
library(terra)
#> terra 1.9.34

plot(climate_layers_ssp370_2011_2040()$pb_mode)

```
