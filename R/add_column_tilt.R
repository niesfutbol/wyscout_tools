add_tilt <- function(team_stats) {
  total_passes <- obtain_passes_to_final_third_of_two_teams_by_match(team_stats)
  team_stats_with_tilt <- team_stats |>
    left_join(total_passes, by = "Date") |>
    mutate(tilt = 100 * Passes_to_final_third_accurate / total_passes_to_final_third)
}

add_tilt.team_stats_from_json <- function(team_stats) {
  total_passes <- obtain_passes_to_final_third_of_two_teams_by_match.team_stats_from_json(team_stats)
  ts <- team_stats$teamStats |>
    dplyr::bind_cols(team_stats$match)

  team_stats <- ts |>
    dplyr::left_join(total_passes, by = "date") |>
    dplyr::mutate(tilt = 100 * passToFinalThirdSuccess / total_passes_to_final_third)
}
