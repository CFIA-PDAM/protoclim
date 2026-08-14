df <- protoclim::classify_cells(
  climate_layers_ssp370_2011_2040(),
  protoclim::classify_levels(climate_layers_ssp370_2011_2040(), bryonia_alba)
)

testthat::test_that("classify_cells() returns a SpatRaster with the expected dimensionality", {
  testthat::expect_s4_class(df, "SpatRaster")

  testthat::expect_equal(dim(df), c(2088, 4320, 4))
})

testthat::test_that("classify_cells() returns a SpatRaster with the expected layer names", {
  testthat::expect_equal(
    names(df),
    c("kgc_mode", "pb_mode", "phz_mode", "overall")
  )
})

testthat::test_that("classify_cells() returns a SpatRaster with each layer's values as expected", {
  purrr::walk(
    terra::cats(df),
    \(x) {
      testthat::expect_all_true(dplyr::between(x$level, 1, 4))

      testthat::expect_all_true(
        x$suitability %in%
          c(
            "Not suitable",
            "Not likely to be suitable",
            "Likely to be suitable",
            "Suitable"
          )
      )
    }
  )
})
