context("Function prInit")

dir <- tempdir()
setwd(dir)

if (dir.exists("project-test")) unlink("project-test", recursive = TRUE)
dir.create("project-test")
setwd("project-test")

test_that("prInit creates folders and files", {
  expect_silent(prInit())
  expect_true(dir.exists("data"))
  expect_true(dir.exists("scripts"))
  expect_true(dir.exists("output"))
  expect_true(file.exists(".Rprofile"))
  expect_true(file.exists("scripts/setup_project.R"))
  expect_true(file.exists("scripts/setup_data.R"))
  expect_true(file.exists("scripts/control.R"))
})

test_that("The .Rprofile scripts can be sourced", {
  expect_output(source(".Rprofile"), "Sourcing setup_project.R")
})

test_that(".Rprofile runs setup_project.R script", {
  cat("\nprint(\"Hello World\")\n", file = "scripts/setup_project.R", append = TRUE)
  expect_output(source(".Rprofile"), "Hello World")
})

test_that(".Rprofile runs scripts with prefix 'tools'", {
  cat('print("Tools")\n', file = "scripts/toolsTest.R")
  expect_output(source(".Rprofile"), "Tools")
})

test_that("prInit can init a project in a another folder", {
  expect_silent(prInit("project_dir"))
  expect_true(dir.exists("project_dir/data"))
  expect_true(dir.exists("project_dir/scripts"))
  expect_true(dir.exists("project_dir/output"))
  expect_true(dir.exists("project_dir/run"))
  expect_true(dir.exists("project_dir/docs"))
  expect_true(file.exists("project_dir/.Rprofile"))
  expect_true(file.exists("project_dir/scripts/setup_project.R"))
  expect_true(file.exists("project_dir/scripts/setup_data.R"))
  expect_true(file.exists("project_dir/scripts/control.R"))
})