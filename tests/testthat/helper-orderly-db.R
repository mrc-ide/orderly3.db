mtcars_db <- cbind(name = rownames(mtcars), mtcars)
rownames(mtcars_db) <- NULL

test_prepare_example <- function(examples, data) {
  tmp <- tempfile()
  withr::defer_parent(unlink(tmp, recursive = TRUE))
  orderly2:::orderly_init(tmp, logging_console = FALSE)

  cfg_base <- "minimum_orderly_version: 1.99.0"

  if (identical(examples, "instance")) {
    fmt <- paste(
      "        %s:",
      "          dbname: %s.sqlite",
      sep = "\n")
    cfg <- c(
      "plugins:",
      "  orderly.db:",
      "    db:",
      "      driver: RSQLite::SQLite",
      "      args: ~",
      "      instances:",
      sprintf(fmt, names(data), names(data)))
  } else {
    fmt <- paste(
      "    %s:",
      "      driver: RSQLite::SQLite",
      "      args:",
      "        dbname: %s.sqlite",
      sep = "\n")
    cfg <- c(
      "plugins:",
      "  orderly.db:",
      sprintf(fmt, names(data), names(data)))
  }
  writeLines(c(cfg_base, cfg), file.path(tmp, "orderly_config.yml"))

  for (nm_db in names(data)) {
    con <- DBI::dbConnect(RSQLite::SQLite(),
                          dbname = file.path(tmp, paste0(nm_db, ".sqlite")))
    for (nm_data in names(data[[nm_db]])) {
      DBI::dbWriteTable(con, nm_data, data[[nm_db]][[nm_data]])
    }
    DBI::dbDisconnect(con)
  }

  fs::dir_create(file.path(tmp, "src"))
  for (i in examples) {
    fs::dir_copy(file.path("examples", i), file.path(tmp, "src"))
  }

  tmp
}


clear_local_connections <- function() {
  rm(list = names(local), envir = local)
}
