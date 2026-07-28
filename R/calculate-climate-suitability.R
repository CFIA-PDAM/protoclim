#' Calculate a weed species' climate suitability across covariate levels
#'
#' `r lifecycle::badge('experimental')`
#'
#' @param gbif_occurrence_data a data frame of occurrence data extracted from
#' GBIF. Augmented with covariate data via `add_covariates()`
#'
#' @param covariate_summary a data frame summarizing the area, in square miles,
#' of each level of the specified covariate
#'
#' @param covariate a string representing the covariate, either 'kgc', 'pb', or
#' phz'
#
#' @export
calculate_climate_suitability <- function(
  gbif_occurrence_data = NULL,
  covariate_summary = NULL,
  covariate = c("kgc", "pb", "phz")
) {
  # Abort if the gbif occurrence data is not provided
  rlang::check_required(gbif_occurrence_data)

  # Abort if the covariate raster is not provided
  rlang::check_required(covariate_summary)

  # Abort if the gbif occurrence data is not a data frame
  rlang::check_data_frame(gbif_occurrence_data)

  # Abort if the covariate summary is not a data frame
  rlang::check_data_frame(covariate_summary)

  # Append _mode to the covariate so it matches the specification of the
  covariate <- glue::glue("{covariate}_mode")

  if (!covariate %in% names(covariate_summary)) {
    cli::cli_abort(c(
      "x" = "The column {.val {covariate}} is missing from {.arg gbif_occurrence_data}",
      "i" = "Did you run {.fn add_covariates} first?"
    ))
  }

  df <- dplyr::count(
    gbif_occurrence_data,
    !!rlang::sym(covariate),
    name = "num_occurrences"
  )

  df <- dplyr::left_join(
    covariate_summary,
    df,
    by = dplyr::join_by("value" == !!rlang::sym(covariate))
  )

  df <- dplyr::mutate(
    df,
    num_occurrences = tidyr::replace_na(.data$num_occurrences, 0)
  )

  # Calculate the relative frequency of occurrences across the levels of the
  # covariate
  df <- dplyr::mutate(
    df,
    relative_frequency = .data$num_occurrences /
      base::sum(.data$num_occurrences) *
      1e2
  )

  # Relative frequency is constrainted between 0 and 100. If relative frequency
  # is greater than 1 in a given level of the covriate it is considered
  # climatically suitable.
  df <- dplyr::mutate(
    df,
    climate_suitability = dplyr::case_when(
      .data$relative_frequency > 1 ~ 1L,
      .data$relative_frequency > 0.5 & .data$relative_frequency <= 1 ~ 2L,
      .data$relative_frequency > 0 & .data$relative_frequency <= 0.5 ~ 3L,
      .data$relative_frequency == 0 ~ 4L
    )
  )

  # Assign factor labels
  df <- dplyr::mutate(
    df,
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

  return(df)
}
