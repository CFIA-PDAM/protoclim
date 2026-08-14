testthat::test_that("add_climate_layers() produces a tibble", {
  testthat::expect_s3_class(
    add_climate_layers(climate_data, bryonia_alba),
    c("tbl_df", "tbl", "data.frame")
  )
})

testthat::test_that("add_climate_layers() produces the expected shape when run
with packaged data", {
  testthat::expect_shape(
    add_climate_layers(climate_data, bryonia_alba),
    dim = c(10023, 8)
  )
})

testthat::test_that("add_climate_layers() does not raise an error when some of, but not all, occurrence records are missing geographic coordinates ", {
  occurrence_data <- tibble::tibble(
    decimalLongitude = c(NA, 45),
    decimalLatitude = c(NA, 90)
  )

  testthat::expect_no_error(
    add_climate_layers(climate_data, occurrence_data)
  )
})

testthat::test_that("add_climate_layers() does not raise an error when some of, but not all, occurrence records are missing geographic coordinates ", {
  occurrence_data <- tibble::tibble(
    decimalLongitude = c(NA, 45),
    decimalLatitude = c(NA, 90)
  )

  testthat::expect_no_error(
    add_climate_layers(climate_data, occurrence_data)
  )
})
