team_name <- "toluca"
match_path <- glue::glue("/workdir/tests/data/liga_mx/{team_name}.json")
san_luis_data <- jsonlite::fromJSON(match_path)

matches_path <- glue::glue("/workdir/results/{team_name}_matches.csv")
matches <- san_luis_data$matches$match |>
  tibble::as_tibble() |>
  janitor::clean_names() |>
  readr::write_csv(matches_path)

the_team_path <- glue::glue("/workdir/results/{team_name}_team.csv")
the_team <- san_luis_data$matches$teamStats |>
  tibble::as_tibble() |>
  janitor::clean_names() |>
  dplyr::select(-c(schemes, intervals)) |>
  readr::write_csv(the_team_path)

the_opponent_path <- glue::glue("/workdir/results/{team_name}_opponents.csv")
the_opponent <- san_luis_data$matches$opponentTeamStats |>
  tibble::as_tibble() |>
  janitor::clean_names() |>
  dplyr::select(-c(schemes, intervals)) |>
  readr::write_csv(the_opponent_path)
