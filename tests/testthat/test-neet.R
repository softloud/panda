context("check each function for non-empty thing of expected type")

test_that({"panda"},
          expect_is(panda(), "ggplot")
)

test_that({'msg'},
          expect_is(panda(msg = "Quack, quack, said the duck."), "ggplot")
)

test_that({"descriptor"},
          expect_is(panda(descriptor = "Buttons"), "ggplot"),
          expect_is(panda(descriptor = "declaratory"), "ggplot")
          )

test_that({"panda"},
          expect_is(panda(panda = 5), "ggplot")
)

test_that({"stamp"},
          expect_is(panda(stamp = FALSE), "ggplot")

          )


test_that({"pandas"},
          expect_is(pandas, "data.frame")
          )
