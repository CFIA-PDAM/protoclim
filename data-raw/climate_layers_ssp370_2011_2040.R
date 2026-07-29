temp_file <- fs::file_temp(ext = ".tif")

withr::with_options(
  list(timeout = 1e9),
  curl::curl_download(
    "https://zenodo.org/records/21400412/files/raster.ensemble.2011.2040.ssp370.tif",
    temp_file,
    quiet = FALSE
  )
)

r <- terra::rast(temp_file)

r <- r[[c("kgc_mode", "pb_mode", "phz_mode")]]

r <- terra::aggregate(r, fact = 10, fun = "modal")

terra::writeRaster(
  r,
  fs::path(
    fs::path_wd(),
    "inst",
    "extdata",
    "climate_layers_ssp370_2011_2040.tif"
  ),
  datatype = "INT1U",
  gdal = c("COMPRESS=DEFLATE", "PREDICTOR=2")
)
