context("init")

test_that("keeps DESCRIPTION", {
  setup({
    write("Package: app\nImports:\n    DBI", file="DESCRIPTION")

    jetpack::init()

    expectFileContains("DESCRIPTION", "DBI")
  })
})

test_that("can be called multiple times", {
  setup({
    jetpack::init()

    rprofile <- readFile(".Rprofile")

    jetpack::init()

    expect_equal(readFile(".Rprofile"), rprofile)
  })
})

test_that("not initialized", {
  setup({
    expect_error(jetpack::add("DBI"), "This project has not yet been initialized.\nRun 'jetpack::init()' to init.", fixed=TRUE)
  })
})
