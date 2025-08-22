describe("filter_premier_league", {
  chelsea <- read_team_stats("/workdir/tests/data/Chelsea.csv")
  chelsea_in_premier <- filter_premier_league(chelsea)
  expected <- "England. Premier League"
  obtained <- chelsea_in_premier$Competition |>
    unique()
  expect_equal(obtained, expected)
})

describe("obtain_passes_to_final_third_of_two_teams_by_match", {
  raw_data <- tibble(
    Date = rep(c("a", "b", "c"), 2),
    Passes_to_final_third_accurate = 1:6
  )
  expected <- tibble(
    Date = c("a", "b", "c"),
    total_passes_to_final_third = c(5, 7, 9)
  )
  obtained <- obtain_passes_to_final_third_of_two_teams_by_match(raw_data)
  expect_equal(obtained, expected)
})

describe("obtain_passes_to_final_third_of_two_teams_by_match.team_stats_from_json", {
  match <- tibble::tibble(date = c("2021-01-01", "2021-01-02", "2021-01-03"))
  team_stats <- tibble::tibble(pass_to_final_third_success = c(1, 2, 3), date = c("2021-01-01", "2021-01-02", "2021-01-03"))
  opponent_team_stats <- tibble::tibble(pass_to_final_third_success = c(2, 3, 4), date = c("2021-01-01", "2021-01-02", "2021-01-03"))
  team_stats_from_json <- list(
    match = match,
    teamStats = team_stats,
    opponentTeamStats = opponent_team_stats
  )
  class(team_stats_from_json) <- "team_stats_from_json"
  expected <- tibble::tibble(
    date = c("2021-01-01", "2021-01-02", "2021-01-03"),
    total_passes_to_final_third = c(3, 5, 7)
  )
  it("returns the expected tibble", {
    obtained <- obtain_passes_to_final_third_of_two_teams_by_match.team_stats_from_json(team_stats_from_json)
    expect_equal(obtained, expected)
  })
})
