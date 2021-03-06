#' Initialise a project
#'
#' \code{prInit} should be used in a Rstudio project. The function creates
#' the basic structure of a data analysis project that will help you keep your
#' your work organised and increase your productivity.
#'
#' @param dir Directory where project files will be stored. By default, it is
#'   the current working directory.
#' @param instructions Should instructions added in the scripts created by the
#'   the function?
#' @author Francois Guillem
#' @details
#' The function creates by default five folders :
#'
#' \itemize{
#'   \item scripts: Folder where the scripts are stored
#'   \item data: Folder where the source and intermediate data files are stored
#'   \item output: Folder where the output of the project are stored
#'   \item run: Folder for temporary data files
#'   \item docs: Folder for all kind of documentation
#' }
#'
#' These three folders are essential so do not remove them. But you can add any
#' other folders you desire ("latex", "presentation", etc.)
#'
#' Additionally, three scripts are created:
#'
#' \itemize{
#'   \item control.R: This is the main control script of your project. Ideally, just by
#'   looking at this script you should remember how your project is organised
#'   For small projects most code can go in this script. But for larger project,
#'   it should mostly contain comments what each script is supposed to do. You
#'   can use the function \code{\link{prScript}} to programatically open the
#'   scripts you are referring to.
#'
#'   \item setup_data.R: This script should contain instructions to import data in the
#'   project and/or transform the source data in processed data that will be
#'   studied/analysed. As for the script "control.R", for large project, this script
#'   should not contain code, but make reference to the scripts that do the job.
#'
#'   \item initialize_project.R: script that is executed every time the project is opened. It
#'   should load the packages used in the project, define constant values, ...
#'   More generally it should include all technical instructions that do not
#'   directly participate to the creation, manipulation or analysis of data.
#' }
#'
#' @seealso
#' \code{\link{prLibrary}}, \code{\link{prSource}}, \code{\link{prSave}},
#' \code{\link{prLoad}}, \code{\link{prScript}}
#'
#' @examples
#' projectPath <- file.path(tempdir(), "test")
#' prInit(projectPath)
#'
#' list.files(tempdir(), recursive = TRUE, include.dirs = TRUE)
#'
#' @export
#'
prInit <- function(dir = ".", instructions = TRUE,
                   folders = c("data/", "scripts/","output/","run/","docs/"),
                   folder_names = NULL,
                   git = TRUE,
                   path_prefix = "path_",
                   global = FALSE,
                   alt_env_id = NULL,
                   alt_env_value = NULL,
                   alt_env_root_folder = NULL,
                   create_folders = TRUE){

  # Create directories and scripts if they do not exist
  # dirCreate <- function(x) {
  #   x <- file.path(dir, x)
  #   if(! file.exists(x)) dir.create(x) else warning("Directory '", x, "' already exists.")
  # }


  proj_env<-createEnvi(root_folder = dir,
                       folders = folders,
                       folder_names = folder_names,
                       path_prefix = path_prefix,
                       global = global,
                       alt_env_id = alt_env_id,
                       alt_env_value = alt_env_value,
                       alt_env_root_folder = alt_env_root_folder,
                       create_folders = create_folders)
  templatePath = system.file(sprintf("scriptTemplates/%s.brew", "projfile"),
                             package = "tpEnvima")
  brew::brew(templatePath, file.path(dir,paste0(basename(dir),".Rproj")))
  templatePath = system.file(sprintf("scriptTemplates/%s.brew", "gitignore"),
                             package = "tpEnvima")
  brew::brew(templatePath, file.path(dir,".gitignore"))
  templatePath = system.file(sprintf("scriptTemplates/%s.brew", "HowTo"),
                             package = "tpEnvima")
  brew::brew(templatePath, file.path(dir,"docs/HowTo.md"))

  #if (dir != ".") dirCreate("")

  # dirCreate ("data")
  # dirCreate ("output")
  # dirCreate ("scripts")

  if (!is.null(packageDescription("tpEnvima")$Date)) {
    pkgDate = as.Date(packageDescription("tpEnvima")$Date) + 1
  } else {
    pkgDate = as.character(Sys.Date())
  }

  brew::brew(system.file("Rprofile.brew", package = "tpEnvima"),
             file.path(dir,"./.Rprofile"))

  options(projectRoot = normalizePath(dir))

  tpEnvima::prScript("setup_data", template = "setup_data", instructions = instructions)
  tpEnvima::prScript("control", template = "control", instructions = instructions)
  tpEnvima::prScript("setup_project", template = "setup_project", instructions = instructions)

  prSave(proj_env,replace=TRUE)

  if (git){
    repo<- git2r::init(path = dir)
    git2r::add(repo = repo, paste0(basename(dir),"*.Rproj"))
    git2r::add(repo = repo, "scripts/control.r")
    git2r::add(repo = repo, "scripts/setup_project.r")
    git2r::add(repo = repo, "scripts/setup_data.r")
    git2r::commit(repo = repo,message = "initial commit")

  }
}

#' Initialise a project
#'
#' \code{prInitCourses} should be used in a Rstudio project. The function creates
#' the basic structure of a data analysis project that will help you keep your
#' your work organised and increase your productivity.
#'
#' @param dir Directory where project files will be stored. By default, it is
#'   the current working directory.
#' @param instructions Should instructions added in the scripts created by the
#'   the function?
#' @author Francois Guillem
#' @details
#' The function creates by default five folders :
#'
#' \itemize{
#'   \item scripts: Folder where the scripts are stored
#'   \item data: Folder where the source and intermediate data files are stored
#'   \item output: Folder where the output of the project are stored
#'   \item run: Folder for temporary data files
#'   \item docs: Folder for all kind of documentation
#' }
#'
#' These three folders are essential so do not remove them. But you can add any
#' other folders you desire ("latex", "presentation", etc.)
#'
#' Additionally, three scripts are created:
#'
#' \itemize{
#'   \item control.R: This is the main control script of your project. Ideally, just by
#'   looking at this script you should remember how your project is organised
#'   For small projects most code can go in this script. But for larger project,
#'   it should mostly contain comments what each script is supposed to do. You
#'   can use the function \code{\link{prScript}} to programatically open the
#'   scripts you are referring to.
#'
#'   \item setup_data.R: This script should contain instructions to import data in the
#'   project and/or transform the source data in processed data that will be
#'   studied/analysed. As for the script "control.R", for large project, this script
#'   should not contain code, but make reference to the scripts that do the job.
#'
#'   \item initialize_project.R: script that is executed every time the project is opened. It
#'   should load the packages used in the project, define constant values, ...
#'   More generally it should include all technical instructions that do not
#'   directly participate to the creation, manipulation or analysis of data.
#' }
#'
#' @seealso
#' \code{\link{prLibrary}}, \code{\link{prSource}}, \code{\link{prSave}},
#' \code{\link{prLoad}}, \code{\link{prScript}}
#'
#' @examples
#' projectPath <- file.path(tempdir(), "test")
#' prInit(projectPath)
#'
#' list.files(tempdir(), recursive = TRUE, include.dirs = TRUE)
#'
#' @export
#'
prInitCourses <- function(dir = ".", instructions = TRUE,
                   folders = c("data/",                # datafolders for all kind of date
                               "data/auxdata/",        # the following used by scripts however
                               "data/aerial/",     # you may add whatever you like
                               "data/aerial/org/",     # you may add whatever you like
                               "data/lidar/org/",
                               "data/lidar/",
                               "data/lidar/level0/",
                               "data/lidar/level1/",
                               "data/lidar/level2/",
                               "data/data_mof",
                               "run/",                # temporary data storage
                               "log/",                # logging
                               "src/",                # scripts
                               "/doc/")   ,
                   folder_names = NULL,
                   git = TRUE,
                   path_prefix = "path_",
                   global = FALSE,
                   alt_env_id = NULL,
                   alt_env_value = NULL,
                   alt_env_root_folder = NULL,
                   create_folders = TRUE){

  #----
  # install/check from github
  devtools::install_github("envima/tpEnvima")
  devtools::install_github("r-spatial/link2GI")

  packagesToLoad = c("lidR", "link2GI", "mapview", "raster", "rgdal", "rlas", "sp",  "sf", "tidyverse","tpEnvima")

  mvTop<-mapview::mapviewPalette("mapviewTopoColors")
  mvSpec<-mapviewTopoColors<-mapview::mapviewPalette("mapviewSpectralColors")

  # get viridris color palette
  pal<-mapview::mapviewPalette("mapviewTopoColors")

  # get rootdir
  rootDir = tpEnvima::alternativeEnvi(root_folder = "/home/creu/edu/mpg-envinsys-plygrnd/",
                                      alt_env_id = "COMPUTERNAME",
                                      alt_env_value = "PCRZP",
                                      alt_env_root_folder = "F:/BEN/edu")


  # Set project specific subfolders



  # setup of root directory, folder structure and loading libraries
  # returns "envrmt" list which contains the folder structure as short cuts
  envrmt = tpEnvima::createEnvi(root_folder = rootDir,
                                folders = folders,
                                path_prefix = "path_",
                                libs = packagesToLoad,
                                alt_env_id = "COMPUTERNAME",
                                alt_env_value = "PCRZP",
                                alt_env_root_folder = "F:/BEN/edu")
  # set raster temp path
  raster::rasterOptions(tmpdir = envrmt$path_tmp)
  prSave(envrmt,replace=TRUE)


  templatePath = system.file(sprintf("scriptTemplates/%s.brew", "projfile"),
                             package = "tpEnvima")
  brew::brew(templatePath, file.path(dir,paste0(basename(dir),".Rproj")))
  templatePath = system.file(sprintf("scriptTemplates/%s.brew", "gitignore"),
                             package = "tpEnvima")
  brew::brew(templatePath, file.path(dir,".gitignore"))
  templatePath = system.file(sprintf("scriptTemplates/%s.brew", "HowTo"),
                             package = "tpEnvima")
  brew::brew(templatePath, file.path(dir,"docs/HowTo.md"))

  if (!is.null(packageDescription("tpEnvima")$Date)) {
    pkgDate = as.Date(packageDescription("tpEnvima")$Date) + 1
  } else {
    pkgDate = as.character(Sys.Date())
  }

  brew::brew(system.file("Rprofile.brew", package = "tpEnvima"),
             file.path(dir,"./.Rprofile"))

  options(projectRoot = normalizePath(dir))

  tpEnvima::prScript("setup_data", template = "setup_data", instructions = instructions)
  tpEnvima::prScript("control", template = "control", instructions = instructions)
  tpEnvima::prScript("setup_project", template = "setup_courses", instructions = instructions)

  #prSave(proj_env,replace=TRUE)

  if (git){
    repo<- git2r::init(path = dir)
    git2r::add(repo = repo, paste0(basename(dir),"*.Rproj"))
    git2r::add(repo = repo, "scripts/control.R")
    git2r::add(repo = repo, "scripts/000_setup.R")
    git2r::add(repo = repo, "scripts/setup_data.R")
    git2r::commit(repo = repo,message = "initial commit")

  }
}
