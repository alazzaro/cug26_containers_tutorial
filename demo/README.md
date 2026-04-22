
# Demo Commands

For convenience, you can copy&paste the commands on your terminal on LUMI.

## Table of Contents

- [Demo Commands](#demo-commands)
  - [LUMI](#lumi)
    - [Access](#access)
    - [Check your projects](#check-your-projects)
    - [Directories](#directories)
    - [Environment setup](#environment-setup)
    - [Modules](#modules)
    - [Check Singularity version](#check-singularity-version)
  - [Basic Singularity Commands: Use Pre-built Images](#basic-singularity-commands-use-pre-built-images)
    - [How to get help](#how-to-get-help)
    - [Use-case Example](#use-case-example)


## LUMI

### Access

Replace `<username>` with your LUMI username.

```console
ssh <username>@lumi.csc.fi
```
Output:
```text
 *  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  *   *      *  
                                                       *      *  *    
   * ████       ████   ████   █████▄    ▄█████   ████     *     *     
 *   ████       ████   ████   ████ █▄  ▄█ ████   ████         ,    *, 
     ████       ████   ████   ████  ████  ████   ████  *   *  |\_ _/| 
     ████       ████   ████   ████   ▀▀   ████   ████   *    .| ." ,| 
  *  ████       ████   ████   ████        ████   ████        /(  \_\) 
     ████       ████   ████   ████        ████   ████       /    ,-,| 
 *   ████▄▄▄▄▄  ▀███   ███▀   ████        ████   ████ *    * /      \ 
     █████████    ▀▀███▀▀     ████        ████   ████  * ,/  (      * 
 *                                                     ,/       |  /  
  * ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒/    \  * || |  
                 *              *               ,_   (       )| || |  
*   *    *    The Supercomputer of the North  * | `\_|   __ /_| || |  
        **               *            * *       \_____\______)\__)__) 
   .********----------*******-------******----------****************. 
```


### Check your projects

```console
groups
```
Output example:
```text
pepr_alfiolaz project_465000454 project_465002727 project_465002906
```
Make sure you are part of the project `project_465002906`.

Another way to check projects with the corresponding compute and storage usage is to use the `lumi-workspaces` command.
```console
lumi-workspaces
```
Output example:
```text
Quota for your projects:

Disk area                          Capacity(used/max)  Files(used/max)
----------------------------------------------------------------------
Personal home folder
Home folder is hosted on lustrep2

/users/alfiolaz                               19G/22G         62K/100K
----------------------------------------------------------------------
Project: project_465002906
Project is hosted on lustrep3

/projappl/project_465002906                   13K/54G           3/100K
/scratch/project_465002906                   8.2K/55T           2/2.0M
/flash/project_465002906                     8.2K/2.2T          2/1.0M
----------------------------------------------------------------------

Status of your allocations:

Data updated: 2026-04-22 14:47:17
Project             |                    CPU (used/allocated)|               GPU (used/allocated)|           Storage (used/allocated)
--------------------------------------------------------------------------------------------------------------------------------------
project_465002906   |              0/1000   (0.0%) core/hours|           0/300   (0.0%) gpu/hours|             0/10   (0.0%) TB/hours
```

### Directories

There are 4 main areas on LUMI (all based on the LUSTRE filesystem):
* Home
* Project: `/project/project_465002906`
* Scratch: `/scratch/project_465002906`
* Flash: `/flash/project_465002906`

The project area is for sharing data. We will use scratch and flash areas. We can create our user directories:
```console
mkdir /scratch/project_465002906/$USER
mkdir /flash/project_465002906/$USER
```

### Environment setup

For convenience, we provide a script to setup your environment for SLURM (project, partition, and reservation):
```console
cp /project/project_465002906/setup/lumi_g.sh /scratch/project_465002906/$USER
cd /scratch/project_465002906/$USER
source lumi_g.sh
```
It will change the prompt:

```text
INFO: Use reservation cug_tutorial
LUMI_G-RES [15:32:41] alfiolaz@uan02:/scratch/project_465002906/alfiolaz >
```
The reservation is only available during the tutorial, otherwise you will get the following output:

```text
INFO: No SLURM reservation is used
LUMI_G [15:32:41] alfiolaz@uan02:/scratch/project_465002906/alfiolaz >
```

### Modules
Enable the `PrgEnv-gnu` and `rocm` modules:
```console
module load PrgEnv-gnu
module load rocm
```

We can add these two lines to the `lumi_g.sh` script.


### Check Singularity version

LUMI uses singularity to run containers:

```console
singularity --version
which singularity
```

Output example:
```text
singularity-ce version 4.1.3-150500.10.7
/usr/bin/singularity
```

## Basic Singularity Commands: Use Pre-built Images

### How to get help

Use `--help` flag to check the list of Singularity commands and flags:
```console
singularity --help
```

Commands are also available via autocompletion via the tab key:
```text
singularity <press tab key twice>
```

Output example:
```text
build       config      inspect     keyserver   plugin      registry    run-help    sif         verify      
cache       delete      instance    oci         pull        remote      search      sign        version     
capability  exec        key         overlay     push        run         shell       test    
```

Further help per each command via `--help` flag after the command, e.g. 
```console
singularity build --help
```
it will show the help specific for the build command.

Official documentation is available on the Singularity [webpage](https://sylabs.io/docs/).

### Use-case Example




