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
    - [Singularity Cache Directory](#singularity-cache-directory)
    - [How to Pull an Image from DockerHub and Inspect it](#how-to-pull-an-image-from-dockerhub-and-inspect-it)
    - [Sandbox Image](#sandbox-image)
    - [Run/Interacting with the Container](#runinteracting-with-the-container)
    - [Host Environment Variables](#host-environment-variables)
    - [Export Selected Host Environment Variables](#export-selected-host-environment-variables)
    - [Exported Host Directories](#exported-host-directories)
    - [Binding Host Directories](#binding-host-directories)
    - [Binding Host Files](#binding-host-files)
    - [Build and Run Interactively an Application](#build-and-run-interactively-an-application)
  - [Images Building](#images-building)
    - [Writeable Sandbox Image](#writeable-sandbox-image)
    - [Installing PROOT](#installing-proot)
    - [LUMI Base Image](#lumi-base-image)
    - [Definition File](#definition-file)


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


### Sandbox Image

Build the sandbox image from a SIF one:

```console
singularity build --sandbox gcc_15.2.0.imgdir gcc_15.2.0.sif
```

Output example:

```text
INFO:    Starting build...
INFO:    Verifying bootstrap image gcc_15.2.0.sif
WARNING: integrity: signature not found for object group 1
WARNING: Bootstrap image could not be verified, but build will continue.
INFO:    Creating sandbox directory...
INFO:    Build complete: gcc_15.2.0.imgdir
```

We can inspect the created directory:

```console
cd gcc_15.2.0.imgdir
ls
cd ..
```

Output example:

```text
bin  boot  dev  environment  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  singularity  srv  sys  tmp  usr  var
```

Run the sandbox, just like the SIF image, e.g.:

```console
singularity run gcc_15.2.0.imgdir
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

	Exit the shell by typing `exit` or hitting `Ctrl-D`.


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

> **Tip:** It is possible to change the default prompt `Singularity>` by setting the environment variable `SINGULARITYENV_PS1`.


### Host Environment Variables

Check the exported host environment variables:

```console
singularity run gcc_15.2.0.sif env
```

Isolate the container from the host environment:

```console
singularity run --cleanenv gcc_15.2.0.sif env
```

Output example:

```text
GCC_MIRRORS=https://ftpmirror.gnu.org/gcc \t\thttps://mirrors.kernel.org/gnu/gcc \t\thttps://bigsearcher.com/mirrors/gcc/releases \t\thttp://www.netgull.com/gcc/releases \t\thttps://ftpmirror.gnu.org/gcc \t\thttps://sourceware.org/pub/gcc/releases \t\tftp://ftp.gnu.org/gnu/gcc
GCC_VERSION=15.2.0
GPG_KEYS=B215C1633BCA0477615F1B35A5B3A004745C015A \tB3C42148A44E6983B3E4CC0793FA9B1AB75C61B8 \t90AA470469D3965A87A5DCB494D03953902C9419 \t80F98B2E0DAB6C8281BDF541A7C8C3B2F71EDF1C \t7F74F97C103468EE5D750B583AB00996FC26A641 \t33C235A34C46AA3FFB293709A328C3A2C3C45C06 \tD3A93CAD751C2AF4F8C7AD516C35B99309B5FA62
HOME=/users/alfiolaz
LANG=C
LD_LIBRARY_PATH=/.singularity.d/libs
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
PROMPT_COMMAND=PS1="Singularity> "; unset PROMPT_COMMAND
PS1=Singularity>
PWD=/scratch/project_465002906/alfiolaz
SINGULARITY_BIND=
SINGULARITY_COMMAND=run
SINGULARITY_CONTAINER=/scratch/project_465002906/alfiolaz/gcc_15.2.0.sif
SINGULARITY_ENVIRONMENT=/.singularity.d/env/91-environment.sh
SINGULARITY_NAME=gcc_15.2.0.sif
TERM=xterm-256color
```

Escape variables on the command line if you want to check their value within the container, e.g.

```console
singularity run --cleanenv gcc_15.2.0.sif echo \${GCC_VERSION}
```

or

```console
singularity run --cleanenv gcc_15.2.0.sif bash -c 'echo ${GCC_VERSION}'
```

Output example:

```text
15.2.0
```


### Export Selected Host Environment Variables

There are 3 ways:

1. Setting the `SINGULARITYENV_<variable name>` environment variable on the host, e.g.:

	```console
	export SINGULARITYENV_MY_IMAGE_VAR="foo"
	singularity run --cleanenv gcc_15.2.0.sif echo \${MY_IMAGE_VAR}
	```

	Output example:

	```text
	foo
	```

	Special case is the `PATH` variable for which there are two more possbilities: `SINGULARITYENV_APPEND_PATH` and `SINGULARITYENV_PREPEND_PATH`, e.g.

	```console
	singularity run --cleanenv gcc_15.2.0.sif echo \${PATH}
	export SINGULARITYENV_PREPEND_PATH="$PWD"
	singularity run --cleanenv gcc_15.2.0.sif echo \${PATH}
	```

	Output example:

	```text
	/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	/scratch/project_465002906/alfiolaz:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
	```

	**Example: prepend to `LD_LIBRARY_PATH`**

	Normally `LD_LIBRARY_PATH` automatically append the internal libraries (if correctly configured):

	```console
	singularity run --cleanenv gcc_15.2.0.sif echo \${LD_LIBRARY_PATH}
	export SINGULARITYENV_LD_LIBRARY_PATH="$PWD"
	singularity run --cleanenv gcc_15.2.0.sif echo \${LD_LIBRARY_PATH}
	```

	Output example:

	```text
	/.singularity.d/libs
	/scratch/project_465002906/alfiolaz:/.singularity.d/libs
	```

	**Example: general prepend to an existing image variable**

	```console
	singularity run --cleanenv gcc_15.2.0.sif echo \${MY_IMAGE_VAR}
	export SINGULARITYENV_MY_IMAGE_VAR="$PWD:\$MY_IMAGE_VAR"
	singularity run --cleanenv gcc_15.2.0.sif echo \${MY_IMAGE_VAR}
	```

2. Setting `--env` option, e.g.:

	```console
	singularity run --cleanenv --env MY_IMAGE_VAR="foo" gcc_15.2.0.sif echo \${MY_IMAGE_VAR}
	```

	Output example:

	```text
	foo
	```

3. Setting `--env-file` option, e.g.:

	```console
	echo "MY_IMAGE_VAR1=\"A\"" > myenvs
	echo "MY_IMAGE_VAR2=\"B\"" >> myenvs
	singularity run --cleanenv --env-file myenvs gcc_15.2.0.sif echo \${MY_IMAGE_VAR1}
	```

	Output example:

	```text
	A
	```


### Exported Host Directories

Common list of user directories:

* The user’s home directory (`$HOME`)

	```console
	ls ~
	singularity run --cleanenv gcc_15.2.0.sif ls ~
	```

* The current working directory, *unless its path contains symlinks resolving to different locations on the host vs inside the container*

	```console
	echo $PWD ; ls # Host directory
	singularity run --cleanenv gcc_15.2.0.sif bash -c 'echo $PWD ; ls'
	```

	Output example:

	```text
	/scratch/project_465002906/alfiolaz
	gcc_15.2.0.imgdir  gcc_15.2.0.sif  lumi_g.sh  myenvs
	/scratch/project_465002906/alfiolaz
	```

	We are missing the output of the `ls` of the container!
	The reason is that `/scratch` is a symlink:

	```console
	ls -l /scratch/project_465002906
	```

	Output example:

	```text
	lrwxrwxrwx 1 root root 39 Apr 14 17:12 /scratch/project_465002906 -> /pfs/lustrep3/scratch/project_465002906
	```

	It is the same for `/project/project_465002906` and `/flash/project_465002906`, they are all pointing to `/pfs`. We will see in the next section how we can properly bind these directories.


### Binding Host Directories

There are 2 ways:

1. Setting `SINGULARITY_BIND=src[:dest[:opts]]`, where

	* `src` is the host directory path
	* `dest` is the optional mounting point within the container. If `dest` is not given, it is set equal to `src`
	* `opts` may be specified as `ro` (read-only) or `rw` (read/write, which is the default).

	```console
	echo $PWD ; ls # Host directory
	export SINGULARITY_BIND="/pfs,/scratch,/project,/flash"
	singularity run --cleanenv gcc_15.2.0.sif bash -c 'echo $PWD ; ls'
	```

	Output example:

	```text
	/scratch/project_465002906/alfiolaz
	gcc_15.2.0.imgdir  gcc_15.2.0.sif  lumi_g.sh  myenvs
	/pfs/lustrep3/scratch/project_465002906/alfiolaz
	gcc_15.2.0.imgdir  gcc_15.2.0.sif  lumi_g.sh  myenvs
	```
	
	We can add `SINGULARITY_BIND` to the `lumi_g.sh` script.

2. Setting the `-B src[:dest[:opts]]` option (`src`, `dest`, `opts` as in case 1).

	```console
	singularity run --cleanenv -B /pfs,/scratch,/project,/flash gcc_15.2.0.sif bash -c 'echo $PWD ; ls'
	```


### Binding Host Files

Same procedure used for directories. The entire path to the file will be added, only the specific files will be mounted, e.g.:

```console
echo $PWD ; ls # Host directory
singularity run --cleanenv -B $PWD/myenv gcc_15.2.0.sif bash -c 'echo $PWD ; ls'
```

Output example:

```text
/scratch/project_465002906/alfiolaz
gcc_15.2.0.imgdir  gcc_15.2.0.sif  lumi_g.sh  myenvs
/scratch/project_465002906/alfiolaz
myenvs
```

### Build and Run Interactively an Application

Let's build an `helloworld` example:

```console
cat << EOF > helloworld.cxx
#include <iostream> 
int main() 
{ 
  std::cout << "Hello World!" << std::endl;
  return 0; 
}
EOF
singularity run --cleanenv gcc_15.2.0.sif
g++ helloworld.cxx -o helloworld.x
exit
singularity run --cleanenv gcc_15.2.0.sif ./helloworld.x
```

Output example:

```text
Hello World!
```

## Images Building

### Writeable Sandbox Image

```console
SINGULARITY_BIND="" singularity run --cleanenv --writable --home $PWD:/home gcc_15.2.0.imgdir
mkdir -p /opt/myapp
cp helloworld.x /opt/myapp
chmod -R u=rwX,go=rX /opt/myapp
exit
singularity build gcc_15.2.0_myapp.sif gcc_15.2.0.imgdir
singularity run --cleanenv gcc_15.2.0_myapp.sif /opt/myapp/helloworld.x
```

Output example:

```text
INFO:    Starting build...
INFO:    Creating SIF file...
INFO:    Build complete: gcc_15.2.0_myapp.sif
Hello World!
```

### Installing PROOT

```console
mkdir proot_install
pushd proot_install
curl -LO https://proot.gitlab.io/proot/bin/proot
chmod +x proot
export PATH=$PWD:$PATH
popd
proot --version
```

Output example:

```text
 _____ _____              ___
|  __ \  __ \_____  _____|   |_
|   __/     /  _  \/  _  \    _|
|__|  |__|__\_____/\_____/\____| v5.3.1-99a84175

built-in accelerators: process_vm = yes, seccomp_filter = yes

Visit https://proot-me.github.io for help, bug reports, suggestions, patches, ...
Copyright (C) 2022 PRoot Developers, licensed under GPL v2 or later.
```

We can add the path to PROOT in the `lumi_g.sh` script.


### LUMI Base Image

* **Definition file:** Copy&paste in `lumi_base.def` file:

```bash
Bootstrap: docker
From: ubuntu:25.04

%post -c /bin/bash
# fake some of the commands not available with proot
for f in /usr/sbin/group add /usr/sbin/addgroup /bin/chgrp; do
    rm -rf $f
    ln-s /bin/true $f
done
# More workarounds, based on https://github.com/opencontainers/runc/issues/2517#issuecomment-1030859646
apt-config dump | grep Sandbox::User
cat <<EOF > /etc/apt/apt.conf.d/sandbox-disable
APT::Sandbox::User "root";
EOF
cat <<EOF>/etc/apt/apt.conf.d/99-disable-sandbox
APT::Sandbox::User "root";
APT::Sandbox::Verify "0";
APT::Sandbox::Verify::IDs "0";
APT::Sandbox::Verify::Groups "0";
APT::Sandbox::Verify::Regain "0";
EOF

# Package installations
apt-get update && apt-get -y upgrade --no-install-recommends
apt-get -y install --no-install-recommends \
	  	build-essential wget file ca-certificates \
	 	gfortran

# Cleanup
apt-get autoremove -y
apt-get clean && rm -rf /var/lib/apt/lists/*

# Installation dir
export INSTALL_DIR=/container
mkdir -p ${INSTALL_DIR}

# Save paths for next steps
echo "export INSTALL_DIR=${INSTALL_DIR}" >> ${SINGULARITY_ENVIRONMENT}
echo "export PATH=\${INSTALL_DIR}/bin:\$PATH" >> ${SINGULARITY_ENVIRONMENT}
echo "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:\${INSTALL_DIR}/lib" >> ${SINGULARITY_ENVIRONMENT}

# Make bindings placeholders
echo BIND_DIRS = {{ BIND_DIRS }}
echo BIND_FILES = {{ BIND_FILES }}

for var in {{ BIND_DIRS }}; do
    echo "Make stub directory $var"
    mkdir -p $var
done

for var in {{ BIND_FILES }}; do
    echo "Make stub file $var"
    mkdir -p $(dirname $var)
    touch $var
done


```

* **Script for building:**  Copy&paste in `lumi_base.sh` file and run `chmod +x lumi_base.sh`:

```bash
export SINGULARITY_BIND_DIRS=""
export SINGULARITY_BIND_FILES=""
for var in ${SINGULARITY_BINDPATH//,/ }; do
    host_container=(${var//:/ })
    host_var=${host_container[0]}
    container_var=${host_container[1]}
    if [ -d "$host_var" ]; then
        SINGULARITY_BIND_DIRS+=${container_var:-$host_var}" "
    else
        SINGULARITY_BIND_FILES+=${container_var:-$host_var}" "
    fi

done

echo SINGULARITY_BIND_DIRS = $SINGULARITY_BIND_DIRS
echo SINGULARITY_BIND_FILES = $SINGULARITY_BIND_FILES

SINGULARITY_BIND="" singularity build --cleanenv --sandbox --build-arg BIND_DIRS="${SINGULARITY_BIND_DIRS}" --build-arg BIND_FILES="${SINGULARITY_BIND_FILES}" lumi_base.imgdir lumi_base.def
```


### Definition File

* MPI test case:

```console
cat << EOF > mpitest.c

#include <mpi.h>
#include <stdio.h>

int main( int argc, char *argv[])
{
	int myrank = -1, nranks = -1, len = 0;
	char version[MPI_MAX_LIBRARY_VERSION_STRING];
	MPI_Init(&argc,&argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &myrank); MPI_Comm_size(MPI_COMM_WORLD, &nranks);
	if (myrank == 0) {
	    printf("%d\n", nranks);
	    MPI_Get_library_version(version, &len);
	    printf("%s\n", version);
	}
	MPI_Finalize();
	return 0;
}
EOF
```

* Recipe, install `MPICH 3.4a2`, ABI compatible with `Cray MPI` (version 8.1.x):

```console
cat << 'EOF' > mpich.def
Bootstrap: docker
From: ubuntu:24.04
	
%files
    mpitest.c /container/test_mpi/

	
%post -c /bin/bash
	apt-get update && apt-get -y upgrade --no-install-recommends
	apt-get -y install --no-install-recommends \
	  	    build-essential wget file ca-certificates \
	 	    gfortran
	  
	 # Cleanup 
	 apt-get autoremove -y 
	 apt-get clean && rm -rf /var/lib/apt/lists/* 
	 
	 # Installation dir 
	 export INSTALL_DIR=/container 
	 mkdir -p ${INSTALL_DIR} 
	 
	 VER=3.4a2
	 wget -q http://www.mpich.org/static/downloads/$VER/mpich-$VER.tar.gz
	 tar xvf mpich-${VER}.tar.gz && rm mpich-${VER}.tar.gz 
	 pushd mpich-${VER} 
	 sed -i 's/libmpi_so_version="0:0:0"/libmpi_so_version="12:0:0"/g' configure
	 chmod +x configure
	 FFLAGS='-fallow-argument-mismatch' \
	   ./configure --prefix=${INSTALL_DIR}/mpi --disable-static \
	              --disable-rpath --disable-wrapper-rpath \
	              --enable-fast=all,O3 --with-device=ch3 \
	              --mandir=/usr/share/man
	  make -j$(getconf _NPROCESSORS_ONLN) install
	  popd && rm -rf mpich-${VER}
	  echo "export PATH=${INSTALL_DIR}/mpi/bin:\$PATH" >> ${SINGULARITY_ENVIRONMENT}
	  echo "export LD_LIBRARY_PATH=\${LD_LIBRARY_PATH}:${INSTALL_DIR}/mpi/lib" >> ${SINGULARITY_ENVIRONMENT}

EOF
```

* Build the image:

```console
SINGULARITY_BIND="" singularity build mpich.sif mpich.def
```





