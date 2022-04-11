#!/bin/bash
#SBATCH --gres gpu:1
#SBATCH --cpus-per-task 4
#SBATCH --time 12:00:00
#SBATCH --mem-per-cpu 8G
#SBATCH --job-name preprocess-mono
#SBATCH --partition main
#SBATCH -o logs/preprocess-mono-%j.out

cd ~/fairseq-emecom
source scripts/variables.sh
cd ~/flores/floresv1

#SRC=ne
#TGT=en
#INPUT=$DATA_ROOT/floresv1_mono_neen.spm
#OUTPUT=$DATA_ROOT/floresv1_mono_neen.bin

#fairseq-preprocess \
  #--source-lang $SRC --target-lang $TGT \
  #--trainpref $INPUT/mono.bpe \
  #--destdir $OUTPUT \
  #--joined-dictionary \
  #--workers 4

SRC=si
TGT=en
INPUT=$DATA_ROOT/floresv1_mono_sien.spm
OUTPUT=$DATA_ROOT/floresv1_mono_sien.bin

fairseq-preprocess \
  --source-lang $SRC --target-lang $TGT \
  --trainpref $INPUT/mono.bpe \
  --destdir $OUTPUT \
  --joined-dictionary \
  --workers 4
