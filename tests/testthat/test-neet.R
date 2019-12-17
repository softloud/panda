context("check each function for non-empty thing of expected type")

test_that({"panda"},
          expect_is(panda(), "ggplot"),
          expect_is(panda(msg = "Quack, quack, said the duck."), "ggplot"),
          expect_is(panda(descriptor = "Buttons"), "ggplot")
)

test_that({"pandas"},
          expect_is(pandas, "data.frame")
          )
