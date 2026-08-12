level_area <- compute_area(climate_data)

testthat::test_that("compute_area() produces a list of length three", {
  testthat::expect_type(level_area, "list")

  testthat::expect_length(level_area, 3)
})

testthat::test_that("each element of level_area() is a tibble", {
  purrr::walk(level_area, \(x) {
    testthat::expect_s3_class(x, c("tbl_df", "tbl", "data.frame"))
  })
})

testthat::test_that("each element of level_area() has 2 columns", {
  purrr::walk(level_area, \(x) testthat::expect_shape(x, ncol = 2))
})

testthat::test_that("each element of level_area() has level and area columns", {
  purrr::walk(level_area, \(x) {
    testthat::expect_equal(names(x), c("level", "area"))
  })
})
