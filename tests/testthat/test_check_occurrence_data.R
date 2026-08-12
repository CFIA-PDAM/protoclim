testthat::test_that("add_climate_layers() raises an error when all occurrence records are missing geographic coordinates", {
  occurrence_data <- tibble::tibble(decimalLongitude = NA, decimalLatitude = NA)

  testthat::expect_error(
    check_occurrence_data(occurrence_data),
    class = "no_valid_coords"
  )
})
