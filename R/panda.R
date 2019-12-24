#' Make a panda
#'
#' @param msg The panda can speak your words.
#' @param descriptor Select descriptor from [pandas].
#' @param panda Set a random seed to reproduce a panda.
#' @param stamp Set to `FALSE` if you wish to remove details text in bottom
#' right of image.
#'
#' @export

panda <- function(msg = NULL,
                  input_descriptor = NULL,
                  panda = "random",
                  stamp = TRUE) {
  # seed
  panda_seed <-
    if (!is.numeric(panda) && is.null(input_descriptor)) {
      seq(1, 100) %>% sample(1)
    } else if (!is.null(input_descriptor)) {
      pandas %>%
        dplyr::filter(descriptor == !!input_descriptor) %>%
        purrr::pluck("seed")
    } else {
      panda
    }

  set.seed(panda_seed)

  # panda body coords
  panda_body_df <- tibble::tibble(
    # x = c( 0.5, 0.6),
    x = rnorm(2, 0.5, 0.05),
    # y = c(0.55, 0.23),
    y = rnorm(2, c(0.5, 0.2), 0.02),
    radius = c(0.25, 0.15),
    part = c("head", "body")
  ) %>%
    dplyr::arrange(y)

  panda_body_coord <- function(part, coord) {
    panda_body_df %>%
      dplyr::filter(part == !!part) %>%
      purrr::pluck(coord)
  }

  ears <-     # ears
    tibble::tibble(
      x = panda_body_coord("head", "x") +
        c(-1, 1) * (panda_body_coord("head", "radius") * 0.9),
      y = panda_body_coord("head", "y") +
        panda_body_coord("head", "radius") * 0.6 +
        rnorm(2, mean = 0, sd = panda_body_coord("head", "radius") * 0.1),
      radius = panda_body_coord("head", "radius") * 0.5,
      part = "ears"
    )

  panda_ears <- ears %>%
    ggplot2::ggplot(ggplot2::aes(x0 = x, y0 = y, r = radius)) +
    ggforce::geom_circle(fill = "grey", colour = "grey")

  panda_body <- panda_ears +
    ggforce::geom_circle(fill = "white",
                         colour = "grey",
                         data = panda_body_df)



  # eyes
  dots_data <- tibble::tibble(
    x = panda_body_coord("head", "x") +
      c(-1, 1) * panda_body_coord("head", "radius") / 2.2,
    y = panda_body_coord("head", "y") +
      panda_body_coord("head", "radius") * 0.1,
    radius = 0.02,
    part = "eyes"
  ) %>%

    # paws
    dplyr::add_row(
      x = panda_body_coord("body", "x") +
        c(-1, 1) * panda_body_coord("body", "radius") * 0.9 +
        rnorm(2, sd = panda_body_coord("body", "radius") * 0.2),
      y = panda_body_coord("body", "y") +
        panda_body_coord("body", "radius") * 0.1 +
        rnorm(2, sd = panda_body_coord("body", "radius") * 0.2),
      radius = panda_body_coord("head", "radius") * 0.2,
      part = "front_paws"
    ) %>%
    dplyr::add_row(
      x = panda_body_coord("body", "x") +
        c(-1, 1) * panda_body_coord("body", "radius") * 0.9 +
        rnorm(2, sd = panda_body_coord("body", "radius") * 0.1),
      y = panda_body_coord("body", "y") -
        panda_body_coord("body", "radius") * 0.9 +
        rnorm(2, sd = panda_body_coord("body", "radius") * 0.1),
      radius = panda_body_coord("head", "radius") * 0.2,
      part = "back_paws"
    )

  panda_plot <- panda_body +
    ggforce::geom_circle(
      data = dots_data,
      ggplot2::aes(x0 = x, y0 = y, r = radius),
      fill = "grey",
      colour = "grey"
    )


  # add text

  stamp_text <- dplyr::if_else(
    stamp,
    paste(
      "panda ",
      panda_seed,
      " is created by the R function softloud/panda::panda,
      coded with:
      tidyverse:: and
      ggforce::geom_circle.
      "
    ),
    NULL
  )

  add_msg <- if (is.null(msg)) {
    panda_plot
  } else {
    panda_plot +
      ggplot2::annotate(
        "text",
        x =  panda_body_coord("head", "x") +
          (panda_body_coord("head", "radius") * 2.3),
        y = panda_body_coord("head", "y"),
        colour = "black",
        label = stringr::str_wrap(msg, width = 25)
      ) + ggplot2::xlim(c(0, 1.4))

  }

  pandas_panda <- if (!is.null(input_descriptor)) {
    pandas %>%
      dplyr::filter(descriptor == !!input_descriptor)
  }

  # if the panda is named and adopted
  tagged_adopted <- ""
    # dplyr::case_when(
    #   is.null(input_descriptor) ~ pandas_panda,
    #   !is.null(input_descriptor) &&
    #   input_descriptor %in%
    #     (pandas %>% purrr::pluck("descriptor")) &&
    #     is.na(adopted_by) ~ paste(input_descriptor,
    #                               " ((adopt me!))"),
    #   !is.null(input_descriptor) &&
    #     input_descriptor %in%
    #     (pandas %>% purrr::pluck("descriptor")) &&
    #     !is.na(adopted_by) ~ paste(input_descriptor,
    #                               ", adopted by )",
    #                               pandas_panda %>% purrr::pluck("adopted_by")),
    #   TRUE ~ "error"
    #
    # )


  name_tag <- add_msg +
    ggplot2::annotate(
      "text",
      x = panda_body_coord("head", "x") +
        (panda_body_coord("head", "radius") * 2.3),
      y = panda_body_coord("body", "y") - panda_body_coord("body", "radius"),
      colour = "black",
      label = stringr::str_wrap(paste("--", tagged_adopted), width = 25)
    )


  output_plot <- name_tag +
    ggplot2::annotate(
      "text",
      x =  panda_body_coord("head", "x") -
        (panda_body_coord("head", "radius") * 1.4),
      y = panda_body_coord("body", "y"),
      colour = "lightgrey",
      size = 2.7,
      label = stringr::str_wrap(stamp_text, width = 15)
    ) +
    ggplot2::theme_void()

  # output seed
  cat(paste("Set panda =", panda_seed, "to reproduce this panda.\n"))
  output_plot

}
