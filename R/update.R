#' Update a package
#'
#' @param packages Packages to update
#' @param remotes Remotes to update
#' @export
#' @examples \dontrun{
#'
#' jetpack::update("randomForest")
#'
#' jetpack::update(c("randomForest", "DBI"))
#'
#' jetpack::update()
#' }
update <- function(packages=c(), remotes=c()) {
  sandbox({
    prepCommand()

    if (length(packages) == 0) {
      status <- getStatus()
      packages <- names(status$lockfile$Package)
      packages <- packages[!packages %in% c("renv")]

      deps <- remotes::package_deps(packages)
      outdated <- deps[deps$diff < 0, ]

      if (nrow(outdated) > 0) {
        desc <- updateDesc(packages, remotes)

        installHelper(update_all=TRUE, desc=desc)

        for (i in 1:nrow(outdated)) {
          row <- outdated[i, ]
          if (is.na(row$installed)) {
            success(paste0("Installed ", row$package, " ", row$available))
          } else {
            success(paste0("Updated ", row$package, " to ", row$available, " (was ", row$installed, ")"))
          }
        }
      } else {
        success("All packages are up-to-date!")
      }
    } else {
      # store starting versions
      status <- getStatus()

      versions <- list()
      for (package in packages) {
        package <- getName(package)
        versions[package] <- pkgVersion(status, package)
      }

      desc <- updateDesc(packages, remotes)

      installHelper(remove=packages, desc=desc)

      # show updated versions
      status <- getStatus()
      for (package in packages) {
        package <- getName(package)
        currentVersion <- versions[package]
        newVersion <- pkgVersion(status, package)
        success(paste0("Updated ", package, " to ", newVersion, " (was ", currentVersion, ")"))
      }
    }
  })
}
