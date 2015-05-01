# code_snap
## Description
An project auto generate tool

Almost all the time, we start a kind of  project with a *fixed* series of *Directory Structure*
In each fixed Directory we may have some fixed file.

Just like `django` we use `django-admin.py startproject <project_name>` to start a django project,
How about others.

Then code_snaps is your choice.

You Predefined each project's structure, and store it in the directory `template` then you can auto
generate the code

## Usage

+ to build index: `./start_code index`
+ to generate a project `./start_code project -n PROJECT_NAME -t PROJECT_TYPE`
