##' The directory path of the application folder will contain the dictionaries and setting files. You can set a user-defined folder permanently. 
##' We suggest setting the folder of 'APPDATA' environment variable by running 'setAppDir(\"APPDATA\")'.
##' 
##' @title Set the application path.
##' @param appdir The directory path of the application folder. Default is 'tempdir()'.
##' @return No results.
##' 
setAppDir <- function(appdir) {
	if (missing(appdir)) {
		appdir <- tempdir()
		message("Invalid directory path! 'tempdir()' was used instead.")
		message("For permanent change, you can run 'setAppDir(\"APPDATA\")'.")
	}
	isappdata <- FALSE
	if (identical(appdir, "APPDATA")) {
		appdir <- Sys.getenv("APPDATA")
		isappdata <- TRUE
	}
	if (!file.exists(appdir)) {
		appdir <- tempdir()
		message("Invalid directory path! 'tempdir()' was used instead.")
		message("For permanent change, you can run 'setAppDir(\"APPDATA\")'.")
	}
	appdir <- .verifyFolder(appdir, "Rwordseg")
	options(app.dir = appdir)
	if (isappdata) {
		if (!file.exists(file.path(appdir, "option.rds"))) {
			option <- list(app.dir = appdir)
			try(saveRDS(option, file = file.path(appdir, "option.rds")), silent = TRUE)
		} else {
			option <- readRDS(file.path(appdir, "option.rds"))
			option[["app.dir"]] <- appdir
			try(saveRDS(option, file = file.path(appdir, "option.rds")), silent = TRUE)
		}
	}
}

