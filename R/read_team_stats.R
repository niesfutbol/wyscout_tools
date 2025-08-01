#' Read the team stats of wyscout data
#'
#' @param path A character with the path of the data.
#'
#' @return A tibble with the stats of some team.
#' @export
read_team_stats <- function(path) {
  team <- readr::read_csv(path, show_col_types = FALSE, col_names = all_names$column_names, skip = 1)
  return(team)
}

#' @export
read_team_stats_from_json <- function(path) {
  team <- jsonlite::fromJSON(path)
  stats_from_json <- team$matches
  class(stats_from_json) <- "team_stats_from_json"
  return(stats_from_json)
}
