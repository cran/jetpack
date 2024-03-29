context("bioconductor")

test_that("it works", {
  # fails on R-hub Ubuntu
  # possibly due to this warning:
  # 'getOption("repos")' replaces Bioconductor standard repositories
  skip_on_cran()

  setup({
    jetpack::init()

    jetpack::add("BiocManager")
    expectFileContains("DESCRIPTION", "BiocManager")

    jetpack::add("Biobase", remote="bioc::release/Biobase")
    expectFileContains("DESCRIPTION", "Biobase")
    expectFileContains("DESCRIPTION", "bioc::release/Biobase")

    jetpack::remove("Biobase", remote="bioc::release/Biobase")
    jetpack::remove("BiocManager")
  })
})
