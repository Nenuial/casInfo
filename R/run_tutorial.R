#' Run the tutorial for Project 1
#'
#' @export
project1_tutorial <- function() {
  learnr::run_tutorial(
    name = "intro_variables",
    package = "casInfo",
    shiny_args = list(
      host = "0.0.0.0",
      port = 8088
    )
  )
}
