#' Meet the pandas, adopt a panda
#'
#' Meet all the pandas
#'
#' @export

gallery <- function() {
  pandas %>%
    purrr::pluck('descriptor') %>%
    purrr::map(.f = function(x) {
      panda(msg = x, descriptor = x)
    })

}

#' Meet the moods of the pandas.
#'
#' @export

gallery_moods <- function() {
  pandas %>%
    dplyr::filter(type == "mood") %>%
    purrr::pluck('descriptor') %>%
    purrr::map(.f = function(x) {
      panda(msg = x, descriptor = x)
    })
}


#' Meet the adopted pandas.
#'
#' These pandas have names.
#'
#' @export

gallery_adopted <- function() {
  pandas %>%
    dplyr::filter(type == "name") %>%
    purrr::pluck('descriptor') %>%
    purrr::map(.f = function(x) {
      panda(msg = x, descriptor = x)
    }) %>% patchwork::wrap_plots()
}
