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

+ Firstly you should make your own project template and put it in the template directory.
Each project_template contains a yaml formatted config file called `.config.yml`.  The config file contains the project's name
in `name` filed and a series necessary args.
the file like that

        ```yaml
        ---
        name: thrift_go_server
        necessary_args:
        - SERVER_PORT

        ```

see the directory `template` for more information


+ then you build the index: `./start_code index`
+ to generate a project `./start_code project -n PROJECT_NAME -t PROJECT_TYPE`
