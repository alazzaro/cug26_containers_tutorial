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


### Singularity Cache Directory

Set to the flash directory:

```console
export SINGULARITY_CACHEDIR=/flash/project_465002906/$USER/.singularity
```

We can add these two lines to the `lumi_g.sh` script.

Commands to manage the cache are:

```console
singularity cache clean
singularity cache list
```


### How to Pull an Image from DockerHub and Inspect it

> **_Example:_** We want to test a recent GNU compiler version.

```console
cd /scratch/project_465002906/$USER
singularity pull docker://gcc:15.2.0
```

Output example:

```text
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
225.1MiB / 225.1MiB [============================================================================================================] 100 % 35.6 MiB/s 0s
64.6MiB / 64.6MiB [==============================================================================================================] 100 % 35.6 MiB/s 0s
24.4MiB / 24.4MiB [==============================================================================================================] 100 % 35.6 MiB/s 0s
4.4MiB / 4.4MiB [================================================================================================================] 100 % 35.6 MiB/s 0s
47.0MiB / 47.0MiB [==============================================================================================================] 100 % 35.6 MiB/s 0s
160.4MiB / 160.4MiB [============================================================================================================] 100 % 35.6 MiB/s 0s
INFO:    Extracting OCI image...
INFO:    Inserting Singularity configuration...
INFO:    Creating SIF file...
```

Check the size of the image:

```console
du -sh gcc_15.2.0.sif
```

Output example:

```text
497M	gcc_15.2.0.sif
```

You can use the Singularity `inspect` command to check the image recipe file.
See `singularity inspect --help` for more info.

You can also check the Singularity cache after the `pull`:

```console
singularity cache list -v
```

Output example:

```text
NAME                     DATE CREATED           SIZE             TYPE
1e1bb20756a85e159dfb79   2026-04-22 21:30:25    225.14 MiB       blob
20d12c8f3f3fbb5bd2b836   2026-04-22 21:30:23    64.65 MiB        blob
39b143cd1af9f4fe00885c   2026-04-22 21:30:26    7.25 KiB         blob
3b32e3bb7338c216b077e9   2026-04-22 21:30:23    47.02 MiB        blob
5467f93954cfe1451f4333   2026-04-22 21:30:22    24.44 MiB        blob
6ac84d64ea646236b4d710   2026-04-22 21:30:22    10.38 KiB        blob
73527f5d1721303008fbf3   2026-04-22 21:30:24    160.35 MiB       blob
7c7782df5e7281b07fbd61   2026-04-22 21:30:20    7.45 KiB         blob
8b127759eafed7c645be1b   2026-04-22 21:30:22    1.96 KiB         blob
b798e1a34cb3cdf7749533   2026-04-22 21:30:22    4.38 MiB         blob
efebbe38852e8d563c3ab1   2026-04-22 21:30:26    2.43 KiB         blob
sha256:efebbe38852e8d5   2026-04-22 21:31:32    497.85 MiB       oci-tmp

There are 1 container file(s) using 497.85 MiB and 11 oci blob file(s) using 526.00 MiB of space
Total space used: 1023.85 MiB
```


### Run/Interacting with the Container

There are 3 ways for running/interacting with the container:

1. **Open a shell**

```console
singularity shell gcc_15.2.0.sif 
```

It will open a shell within the container. Output example:

```text
Singularity> 
```

For example, we can check the OS version:

```console
cat /etc/os-release 
```

Output example:

```text
PRETTY_NAME="Debian GNU/Linux 13 (trixie)"
NAME="Debian GNU/Linux"
VERSION_ID="13"
VERSION="13 (trixie)"
VERSION_CODENAME=trixie
DEBIAN_VERSION_FULL=13.4
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```

This is different from the host OS (you can execute the same command on the host that reports SLES 15.6).

2. **Execute a command**

```console
singularity exec gcc_15.2.0.sif <command>
```

For example, we can run the same command above:

```console
singularity exec gcc_15.2.0.sif cat /etc/os-release
```

3. **Run the default action**

```console
singularity run gcc_15.2.0.sif
```

If the default action is not specified in the recipe file, the default is to open a shell (same of the `shell` command). Alternatively, you can pass a command to execute (same of the `exec` command). You can check the default action by running the command:

```console
singularity inspect -r gcc_15.2.0.sif
```

> **Trick:** It is possible to change the default prompt `Singularity>` by setting the environment variable `SINGULARITYENV_PS1`.


### Environment Variables

Check the exported host environment variables:

```console
singularity run gcc_15.2.0.sif env
```

Those variables can conflict with the container execution. 