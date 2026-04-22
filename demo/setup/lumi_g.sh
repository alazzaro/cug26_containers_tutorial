
if [ -z "${RECURSIVE_CALL}" ]; then

    # Start a new fresh shell
    RECURSIVE_CALL=1 bash --init-file ${BASH_SOURCE[0]}
elif [ "${RECURSIVE_CALL}" -eq "1" ]; then

    source $HOME/.bashrc

    export SLURM_ACCOUNT=project_465002906
    export SLURM_PARTITION=standard-g
    USE_RES=
    if $(scontrol show res cug_tutorial | grep -q State=ACTIVE); then
        USE_RES=cug_tutorial
    fi

    RES=""
    if [ -n "$USE_RES" ]; then
        export SLURM_RESERVATION=${USE_RES}
	RES="-RES"
        echo "INFO: Use reservation ${SLURM_RESERVATION}"
    else
        echo "INFO: No SLURM reservation is used"
    fi

    export SBATCH_ACCOUNT=${SLURM_ACCOUNT}
    export SBATCH_PARTITION=${SLURM_PARTITION}

    export SALLOC_ACCOUNT=${SLURM_ACCOUNT}
    export SALLOC_PARTITION=${SLURM_PARTITION}

    if [ -n "${SLURM_RESERVATION}" ]; then
	export SBATCH_RESERVATION=${SLURM_RESERVATION}
	export SALLOC_RESERVATION=${SLURM_RESERVATION}
    fi

    export PS1="LUMI_G$RES $PS1"
    RECURSIVE_CALL=0
else
    echo "Environment already set!"
fi
