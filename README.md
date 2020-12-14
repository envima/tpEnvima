<img src="https://avatars0.githubusercontent.com/u/44788932?s=200&v=4" align="right" title="Logo">
Environmental Informatics Lab @ Marburg University

# Organise  R data analysis workflows and projects

When working with R on any kind of more complex projects as algorithm development, applied data analysis or data processing chains, data-, script- and output files  are increasing in number very quickly. This is even more the case when working with remote sensing or gis data via the command line. The purpose of this package is to structurally encourage the user to organize his work in a standardized way and to use established best practice workflows to improve transparency, maintainability and reproducibility of R-projects. The central goal is to support collaboration and reproducibility within projects. This package can also be used with the Rstudio project system.

## Background
Basically, the `tpEnvima` package is intended to evaluate a straightforward workflow and project functionality and what is the best praxis of integration. The `tinyProject`is a great base due to it's  lean and flat organised data analysis workflow  while the former `envimaR` package provides deeper and more specific project structures, more complex working environments and a simpler handling of more diverse data sets. 

Is a merge of the `envimaR` package and other Helpers for setting up working environments and data flows which focus on using the same initialization parameters and the same basic workflows across different computers and team members of the environmental informatics working group at Marburg University. 

The core unit is provided by the the slightly modified `tinyProject` package by Francois Guillem (guillem.francois@gmail.com) which is completely integrated.  

##  Introduction
A data analysis project uses one or several data sources and a bunch of scripts to answer questions about some subject and to generate material that will help the diffusion of the results of the project. Ths quality of the answers is not the only critorion of quality of a project: it should also be easy to read and the results should be easy to reproduce. The purpose of this package is to improve these two aspects by encouraging the user to adopt some simple conventions: every project has the same structure, the scripts always do the same type of operations and are heavily commented, the data is always in the same folder and is also documented, etc.

## Initial Project Setup
First create an empty project using the Rstudio template or the  function `prScript`. Both possibilities will setup a project root directory and a bisic file tree. `prInit` generates by default five directories: `data` for storing data files, `scripts` for storing R scripts, `output` for storing output files, `run` for runtime calculations and files and `docs` for all kind of project related documentation. Additionally, three scripts are created and opened in the script editor: `setup_data.R` for the import and processing of data, `control.R` for the analysis of the data and `setup_project` for all instructions and environment setup that have to be exetuted everytime the project is opened (load libraries, define constants and functions, etc.). When the user opens the project in Rstudio, the script `setup_project.R` is automatically executed, hence it can used  to automatically load important specific functions or constants etc..

## Script Management
The user can open and/or create scripts with the function `prScript`. The function needs the name of the script (without the extention ".R") and if needed a subdirectory, then searches in the folder "scripts" for an existing  file and if not existing it will be created.

In all cases it is opened in the script editor. The scripts created by `prScript` are offering a template for basic documentaion. It is strongly recommended that the integrated naming conventions of `prScript` are used. For example that data processing scripts start with the prefix "preprop_" while a script that analyses data should start with prefix "analysis_". Other scripts generally contain helper functions and their name should start with "tools_". Data operations and analysis operations must be put in different scripts. If the data operations are complex, split the preprocessing data script and save the the final data objects in appropriate levelling folders (level1 for first level final products). In this case analysis script should CHECK AND LOAD existing level data.

Scripts can be sourced with function `prSource`. It is a wrapper to the function `source` but with the same interface as `prScript`.

## Data Management

Every R object can be saved with `prSave`. The function just needs the name of the object (quoted) and it will save it in the right place so one has not to remember the location where objects are saved. `prSave` can also attach to an object a description that will be displayed when the object is loaded. To load data, simply use `prLoad`.

