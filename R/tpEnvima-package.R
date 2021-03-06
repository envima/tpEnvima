
#' @name tpEnvima-package
#' @docType package
#' @title Organise  R data analysis workflows and projects
#' @description  When working with R on any kind of more complex projects as algorithm development applied data analysis or data processing chains                 data files, scripts and output files multiply very quickly. This is even more the case if one deal with remote sensing or GIS data sets.                 The purpose of this package is to support and softly force the user to keep this things first organised                  second to used well established best practice workflows and hence improve readibility, maintainability an reusability of its R projects.                 The major result of using the package is an increase in reproducible productivity. This package can also be used with the Rstudio projects system.
#' @author François Guillem, Marvin Ludwig, Thomas Nauss, Chris Reudenbach\cr
#' \emph{Maintainer:} Chris Reudenbach \email{reudenbach@@uni-marburg.de}
#' @details
#'   \tabular{ll}{
#'     Package: \tab tpEnvima\cr
#'     Type: \tab Package\cr
#'     Version: \tab 0.1\cr
#'     Date: \tab 2020-03-15\cr
#'     License: \tab GPL (>= 2)\cr}
#'@section Background: Basically, the \code{tpEnvima} package is intended to evaluate a straightforward workflow and project functionality
#'                    and what is the best praxis of integration. The \code{tinyProject} package is a great base due to it's lean and flat
#'                    organised data analysis workflow while the former \code{envimaR} package provides deeper and more specific project structures,
#'                     more complex working environments and a simpler handling of more diverse data sets. \cr\cr
#'                     As a result the \code{tpEnvima} is a merge of the \code{envimaR} package, an increasing number of other helper
#'                     functions based on the \code{tinyProject} package which provides the core functionality.
#'                     It is designed to provide reproducible environments, data flows and anaysis using the same initialization parameters and functions
#'                     across different computers and team members of the environmental informatics working group at Marburg University.\cr\cr
#'                     The working horse is the slightly adapted `tinyProject` package by Francois Guillem (guillem.francois@gmail.com)
#'                     which is completly integrated.

#'@section Introduction: A data analysis project uses one or several data sources and a bunch of scripts to answer questions about some subject and to generate material that will help the diffusion of the results of the project. Ths quality of the answers is not the only critorion of quality of a project: it should also be easy to read and the results should be easy to reproduce. The purpose of this package is to improve these two aspects by encouraging the user to adopt some simple conventions: every project has the same structure, the scripts always do the same type of operations and are heavily commented, the data is always in the same folder and is also documented, etc.
#'
#'@section  Initial Project Setup: First create an empty project using the Rstudio template or the  function \code{\link{prScript}}.
#'         Both possibilities will setup a project root directory and a basic file tree.
#'         \code{\link{prInit}} generates by default five directories: \code{data} for storing data files,
#'         \code{scripts} for storing R scripts, \code{output} for storing output files, \code{run} for runtime calculations and files
#'         and \code{docs} for all kind of project related documentation.
#'         Additionally, three scripts are created and opened in the script editor: \code{setup_data.R} for the import and processing of data,
#'         \code{analyze} for the analysis of the data and \code{setup_project} for all instructions and environment setup that have to be exetuted
#'          everytime the project is opened (load libraries, define constants and functions, etc.).
#'          When the user opens the project in Rstudio, the script \code{setup_project} is automatically executed, hence it can used  to automatically load important specific functions or constants.

#'@section Script Management: The user can open and/or create scripts with the function \code{\link{prScript}}.
#'         The function needs the name of the script (without the extention ".R") and if needed a subdirectory,
#'         then searches in the folder "scripts" for an existing  file and if not existing it will be created.
#'         \cr\cr
#'         In all cases it is opened in the script editor. The scripts created by \code{\link{prScript}} are offering a template for basic documentaion.
#' It is strongly recommended that the integrated naming conventions of \code{\link{prScript}} are used. For example that data processing scripts start
#' with the prefix "preprop_" while a script that analyses data should start with prefix "analysis_". Other scripts generally contain helper functions and their name should start with "tools_".
#'     Data operations and analysis operations must be put in different scripts. If the data operations are complex, split the preprocessing data script
#'    and save the the final data objects in appropriate levelling folders (level1 for first level final products).
#'    In this case analysis script should CHECK AND LOAD existing level data.\cr\cr
#'     Scripts can be sourced with function \code{\link{prSource}}. It is a wrapper to the function \code{\link{source}} but with the same interface as \code{\link{prScript}}.
#' @section Data Management:
#'     Every R object can be saved with \code{\link{prSave}}. The function just needs the name of the object (quoted) and it will save it in the right place so one has not to remember the location where objects are saved. \code{\link{prSave}} can also attach to an object a description that will be displayed when the object is loaded.
#'     To load data, simply use \code{\link{prLoad}}.
NULL
