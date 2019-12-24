#' Preset pandas
#'
#' Select [panda] by mood or name.
"pandas"

pandas <-
  tibble::tribble( ~ descriptor,    ~ seed, ~ type,  ~ adopted_by,
                   "declaratory",   73,     "mood",  NA,
                   "wondering",     26,     "mood",  NA,
                   "Mittens",       52,     "name",  "softloud",
                   "Boots",         26,     "name",  NA,
                   "Buttons",       26,     "name",  "softloud",
                   "Beanie",        17,     "name",  "jenrichmond",
                   "Alia",          42,     "name", "anca"
                   )

# usethis::use_data(pandas, overwrite = TRUE)
