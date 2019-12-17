#' Preset pandas
#'
#' Select [panda] by mood or name.
"pandas"

pandas <-
  tibble::tribble( ~ descriptor,    ~ seed, ~ type,
                   "declaratory",   73,     "mood",
                   "wondering",     26,     "mood",
                   "Mittens",       52,     "name",
                   "Boots",         26,     "name",
                   "Buttons",       26,     "name"
                   )

# usethis::use_data(pandas)
