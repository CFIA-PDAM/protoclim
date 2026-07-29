#' Calculate a weed species' climate suitability across covariate levels
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param gbif_occurrence_data a data frame of occurrence data extracted from
#' GBIF. Augmented with covariate data via `add_covariates()`
#
#' @export
calculate_climate_suitability <- function(gbif_occurrence_data = NULL) {
  # Abort if gbif_occurrence_data is not provided
  rlang::check_required(gbif_occurrence_data)

  # Abort if gbif_occurrence_data is not a data frame
  rlang::check_data_frame(gbif_occurrence_data)

  # Create a boolean that is TRUE if gbif_occurrence_data is missing any of the
  # required columns
  is_missing_cols <- !all(
    rlang::has_name(
      gbif_occurrence_data,
      c("kgc_mode", "pb_mode", "phz_mode")
    )
  )

  # Abort if gbif_occurrence_data is missing required columns
  if (is_missing_cols) {
    cli::cli_abort(c(
      "x" = "{.arg gbif_occurrence_data} is missing covariate data",
      "i" = "Did you run {.fn add_covariates} first?"
    ))
  }

  # Create a list covariate summaries - one per covariate with each summarizing
  # the number of GBIF occurrence records per level of the specified covariate
  # fmt: skip
  covariate_summaries <- base::list(
    kgc_summary = dplyr::count(gbif_occurrence_data, .data$kgc_mode),
    pb_summary  = dplyr::count(gbif_occurrence_data, .data$pb_mode),
    phz_summary = dplyr::count(gbif_occurrence_data, .data$phz_mode)
  )

  # Create a list of levels per covariate
  # fmt: skip
  covariate_ranges <- base::list(
    kgc_range = 1:30,
    pb_range  = 1:11,
    phz_range = 1:28
  )

  # Expand the summaries for each covariate to include levels of the covariate
  # that had no GBIF occurrence records
  covariate_summaries <- purrr::map2(
    covariate_summaries,
    covariate_ranges,
    \(x, y) {
      # Extract the name of the covariate
      covariate_name <- names(x)[[1]]

      # Expand the covariate summary to include zeros for missing levels
      x <- tidyr::complete(
        x,
        !!rlang::sym(covariate_name) := y,
        fill = list(n = 0)
      )

      x <- dplyr::filter_out(x, is.na(!!rlang::sym(covariate_name)))

      return(x)
    }
  )

  # Calculate the relative frequency of occurrences for each level of each
  # covariate
  covariate_summaries <- purrr::map(
    covariate_summaries,
    \(x) {
      x <- dplyr::mutate(
        x,
        relative_frequency = .data$n / base::sum(.data$n) * 1e2
      )

      return(x)
    }
  )

  # Assign climate suitability classifications to each level of each covariate
  covariate_summaries <- purrr::map(
    covariate_summaries,
    \(x) {
      x <- dplyr::mutate(
        x,
        climate_suitability = dplyr::case_when(
          .data$relative_frequency > 1 ~ 1L,
          .data$relative_frequency > 0.5 & .data$relative_frequency <= 1 ~ 2L,
          .data$relative_frequency > 0 & .data$relative_frequency <= 0.5 ~ 3L,
          .data$relative_frequency == 0 ~ 4L
        )
      )

      x <- dplyr::mutate(
        x,
        climate_suitability = factor(
          .data$climate_suitability,
          levels = c(1, 2, 3, 4),
          labels = c(
            "Suitable",
            "Likely to be suitable",
            "Not likely to be suitable",
            "Not suitable"
          )
        )
      )

      return(x)
    }
  )

  return(covariate_summaries)
}
