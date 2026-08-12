df <- protoclim::classify_layers(
  climate_layers_ssp370_2011_2040(),
  bryonia_alba
)

testthat::test_that("classify_layers() returns a list of length three", {
  testthat::expect_type(df, "list")

  testthat::expect_length(df, 3)
})

testthat::test_that("classify_layers() returns tibbles with the expected number of rows and columns", {
  purrr::walk(df, \(x) testthat::expect_s3_class(x, "tbl_df"))

  purrr::walk2(
    df,
    c(30, 11, 28),
    \(x, y) testthat::expect_shape(x, dim = c(y, 4))
  )
})

testthat::test_that("classify_layers() returns tibbles with no missing values", {
  purrr::walk(
    df,
    \(x) {
      x <- dplyr::filter(x, dplyr::if_any(tidyselect::everything(), is.na))

      testthat::expect_equal(nrow(x), 0)
    }
  )
})

testthat::test_that("classify_layers() returns tibbles with proportion values all between 0 and 100", {
  purrr::walk(
    df,
    \(x) testthat::expect_all_true(dplyr::between(x$proportion, 0, 100))
  )
})


testthat::test_that("classify_layers() returns tibbles with suitability values one of four expected values", {
  purrr::walk(
    df,
    \(x) {
      testthat::expect_in(
        x$suitability,
        c(
          "Suitable",
          "Likely to be suitable",
          "Not likely to be suitable",
          "Not suitable"
        )
      )
    }
  )
})
