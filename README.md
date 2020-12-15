<img src="https://avatars0.githubusercontent.com/u/44788932?s=200&v=4" align="right" title="Logo">
Environmental Informatics Lab @ Marburg University

# Motivation to organise R data analysis workflows and projects including the documentation

When working with R on any kind of more complex projects as algorithm development, applied data analysis or data processing chains, data-, script- and output files  are increasing in number very quickly. This is even more the case when working with remote sensing or GI data via the command line. The purpose of this package is to structurally encourage the user to organize his work in a standardized way and to use established (best practice) workflows to improve transparency, maintainability and reproducibility of R-projects. The central goal is to support collaboration and reproducibility within projects and publications based on a version control system as github. This package is designed to be used with the Rstudio project template system.



## Background 
The `tinyProject` package is a great base due to it's lean and flat organised data analysis workflow  while the former `envimaR` package provides deeper and more specific project structures, more complex working environments and a simpler handling of more diverse e.g. remote sensing and spatial data sets. Basically, the advanced merge of both called `tpEnvima.

The essential goal of `tpEnvima`  is the support of a fully replicable project structure and workflow, i.e. from data acquisition and pre-processing to analysis and the finished manuscript, a functional package with `tpEnvima` will provide the necessary support and best practice examples.

The core unit is provided by the the slightly modified `tinyProject` package by Francois Guillem (guillem.francois@gmail.com) which is slightly modified and completely integrated.  



## Initial Project Setup



So follow this instruction in the beginning of *each new project*:

- create a new project in RStudio using the templates of `tpEnvima` on your computer
- create a GitHub/GitLab repository and connect your local project to the remote repository. (for help see [Happy Git With R](http://happygitwithr.com/))

Your naming must follow some rules for everything to work, it must:
- contain only ASCII letters, numbers, and ‘.’
- have at least two characters
- start with a letter (not a number)
- must not  end with ‘.’


## Current Functionality

The upper way may be done also using the `prInit` function. 
It create by default five directories: 
- `data` for storing data files, 
- `scripts` for storing R scripts, 
- `output` for storing output files, 
- `run` for runtime calculations and temporary files 
- `docs` for all kind of project related documentation. 

Additionally, three default scripts are created and opened in the script editor: 
-`setup_project` for all instructions and environment setup that have to be exetuted everytime the project is opened (load libraries, define constants and functions, etc.),
- `setup_data.R` for the pre-processing and cleaning of data,
- `control.R` for the analysis of the data and . 

Everytime when the user opens the project in Rstudio, the script `setup_project.R` is automatically executed, hence it reproduce an reliable starting environment.

## Script Management
The user can open and/or create scripts with the function `prScript`. The function needs the name of the script (without the extention ".R") and if needed a subdirectory, then searches in the folder "scripts" for an existing  file and if not existing it will be created.

In all cases it is opened in the script editor. The scripts created by `prScript` are offering a template for basic documentaion. It is strongly recommended that the integrated naming conventions of `prScript` are used. For example that data processing scripts start with the prefix "preprop_" while a script that analyses data should start with prefix "analysis_". Other scripts generally contain helper functions and their name should start with "tools_". Data operations and analysis operations must be put in different scripts. If the data operations are complex, split the preprocessing data script and save the the final data objects in appropriate levelling folders (level1 for first level final products). In this case analysis script should CHECK AND LOAD existing level data.

Scripts can be sourced with function `prSource`. It is a wrapper to the function `source` but with the same interface as `prScript`.

## Data Management

Every R object can be saved with `prSave`. The function just needs the name of the object (quoted) and it will save it in the right place so one has not to remember the location where objects are saved. `prSave` can also attach to an object a description that will be displayed when the object is loaded. To load data, simply use `prLoad`.

