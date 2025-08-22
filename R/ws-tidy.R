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
  team_stats$teamStats |>
    dplyr::bind_rows(team_stats$opponentTeamStats) |>
    dplyr::group_by(date) |>
    dplyr::summarize(total_passes_to_final_third = sum(pass_to_final_third_success))
}
