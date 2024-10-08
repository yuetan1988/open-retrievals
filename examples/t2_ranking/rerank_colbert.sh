MODEL_NAME='BAAI/bge-m3'
TRAIN_DATA="./t2/t2_ranking.jsonl"
OUTPUT_DIR="./t2/ft_out"


torchrun --nproc_per_node 1 \
  --module retrievals.pipelines.rerank \
  --output_dir $OUTPUT_DIR \
  --overwrite_output_dir \
  --model_name_or_path $MODEL_NAME \
  --tokenizer_name $MODEL_NAME \
  --model_type colbert \
  --do_train \
  --data_name_or_path $TRAIN_DATA \
  --positive_key positive \
  --negative_key negative \
  --learning_rate 5e-6 \
  --fp16 \
  --num_train_epochs 3 \
  --per_device_train_batch_size 32 \
  --dataloader_drop_last True \
  --query_max_length 128 \
  --max_length 256 \
  --train_group_size 4 \
  --unfold_each_positive false \
  --save_total_limit 1 \
  --logging_steps 100 \
  --use_inbatch_negative False \
  --gradient_accumulation_steps 1
