library(tidyverse)

describe("add_tilt", {
  raw_data <- tibble(
    Date = rep(c("a", "b", "c"), 2),
    Passes_to_final_third_accurate = 1:6
  )
  expected <- tibble(
    Date = rep(c("a", "b", "c"), 2),
    Passes_to_final_third_accurate = 1:6,
    total_passes_to_final_third = rep(c(5, 7, 9), 2),
    tilt = c(100 / 5, 200 / 7, 300 / 9, 400 / 5, 500 / 7, 600 / 9)
  )
  obtained <- add_tilt(raw_data)
  expect_equal(obtained, expected)

  it("add_tilt.team_stats_from_json()", {
    match <- tibble::tibble(date = c("2021-01-01", "2021-01-02", "2021-01-03"))
    team_stats <- tibble::tibble(passToFinalThirdSuccess = c(1, 2, 3))
    opponent_team_stats <- tibble::tibble(passToFinalThirdSuccess = c(2, 3, 4))
    team_stats_from_json <- list(
      match = match,
      teamStats = team_stats,
      opponentTeamStats = opponent_team_stats
    )
    class(team_stats_from_json) <- "team_stats_from_json"

    expected <- tibble::tibble(
      passToFinalThirdSuccess = c(1, 2, 3),
	  date = c("2021-01-01", "2021-01-02", "2021-01-03"),
	  total_passes_to_final_third = c(3, 5, 7),
      tilt = c(100 * 1 / 3, 100 * 2 / 5, 100 * 3 / 7)
    )
    obtained <- add_tilt.team_stats_from_json(team_stats_from_json)
    expect_equal(obtained, expected)
  })
})
