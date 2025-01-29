#Package version control system for the project

## Current state of all packages used in the project
renv::snapshot()

## Restore all required packages and dependencies according to renv.lock
renv::restore() 
