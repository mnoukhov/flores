#!/bin/sh

checkpoint_dir=$1
output_dir=$checkpoint_dir/output
#parent_dir="$(dirname -- "$(realpath -- "$checkpoint_path")")"

fairseq-generate \
    data-bin/wiki_ne_en_bpe5000/ \
    --source-lang ne --target-lang en \
    --path $checkpoint_dir/checkpoint_best.pt \
    --beam 5 --lenpen 1.2 \
    --gen-subset valid \
    --remove-bpe=sentencepiece \
    --results-path $output_dir

cat $output_dir/generate-valid.txt  | grep -P '^H-'  | cut -c 3- | sort -n -k 1 | awk -F "\t" '{print $NF}' > $output_dir/sys-valid.txt
sacrebleu $DATA_ROOT/floresv1.dataset/valid.en -i $output_dir/sys-valid.txt -tok spm

#fairseq-generate \
    #data-bin/wiki_ne_en_bpe5000/ \
    #--source-lang ne --target-lang en \
    #--path $1 \
    #--beam 5 --lenpen 1.2 \
    #--gen-subset valid \
    #--remove-bpe=sentencepiece \
    #--sacrebleu
