
# Demo Commands

For convenience, you can copy&paste the commands on your terminal on LUMI.

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




# Check Singularity version
```

```
