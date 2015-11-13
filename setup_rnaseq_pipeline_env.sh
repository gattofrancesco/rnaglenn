#!/bin/bash

VIRTUALENV_ROOT=$HOME/.rnaglenn

module load python/py27/2.7.6
module load virtualenv/1.11.6

echo -n "Creating virtual environment..."

if [ ! -d $VIRTUALENV_ROOT ]
then
    virtualenv $VIRTUALENV_ROOT > rnaseq_pipeline_virtualenv.log 2>&1
fi

source $VIRTUALENV_ROOT/bin/activate
echo "OK"

echo -n "Setting up rnaseq_pipeline..."

if [ ! -d DE_RNAseq ]
then
    git clone https://github.com/agata-sm/DE_RNAseq.git > rnaseq_deps.log 2>&1
fi

if [ ! -d rnaseq_pipeline ]
then
    git clone git@github.com:SysBioChalmers/rnaseq_pipeline.git >> rnaseq_deps.log 2>&1
fi

cd rnaseq_pipeline
pip install -r requirements.txt > ../rnaseq_pipeline_install.log 2>&1
pip install -e . >> ../rnaseq_pipeline_install.log 2>&1
echo "OK"

echo ""
echo "Now execute the following commands:"
echo "    cd rnaseq_pipeline"
echo "    source $VIRTUALENV_ROOT/bin/activate"
echo ""
echo "You can now generate the batch script by executing the following command "
echo "with the suitable arguments:"
echo "    bin/build_rna_pipeline"
echo ""
echo "Once you have generated the batch script, run this command to leave the"
echo "virtual environment:"
echo "    deactivate"
echo ""


