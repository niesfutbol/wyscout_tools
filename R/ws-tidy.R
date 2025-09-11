filter_premier_league <- function(team_stats) {
  team_stats |>
    dplyr::filter(grepl("Premier", Competition))
}

obtain_passes_to_final_third_of_two_teams_by_match <- function(team_stats) {
  team_stats |>
    dplyr::group_by(Date) |>
    dplyr::summarize(total_passes_to_final_third = sum(Passes_to_final_third_accurate))
}

obtain_passes_to_final_third_of_two_teams_by_match.team_stats_from_json <- function(team_stats) {
  ts <- team_stats$teamStats |>
    dplyr::bind_cols(team_stats$match)
  ots <- team_stats$opponentTeamStats |>
  dplyr::bind_cols(team_stats$match)

  team_stats <- ts |>
    dplyr::bind_rows(ots) |>
    dplyr::group_by(date) |>
    dplyr::summarize(total_passes_to_final_third = sum(passToFinalThirdSuccess))
}
