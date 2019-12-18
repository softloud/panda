#' Preset pandas
#'
#' Select [panda] by mood or name.
"pandas"

pandas <-
  tibble::tribble( ~ descriptor,    ~ seed, ~ type,  ~ adopted_by,
                   "declaratory",   73,     "mood",  NA,
                   "wondering",     26,     "mood",  NA,
                   "Mittens",       52,     "name",  NA,
                   "Boots",         26,     "name",  NA,
                   "Buttons",       26,     "name",  NA,
                   "Beanie",        17,     "name",  "jenrichmond"
                   )

# usethis::use_data(pandas, overwrite = TRUE)
