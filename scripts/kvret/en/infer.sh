#!/bin/bash
set -ux

# CUDA environment settings.
export CUDA_VISIBLE_DEVICES=3

# Parameters.
DATA_NAME=kvret
PROJECT_NAME=GALAXY
MODEL=UnifiedTransformer
PROJECT_ROOT=.
SAVE_ROOT=.
VOCAB_PATH=${PROJECT_ROOT}/model/Bert/vocab.txt
LOAD_MODEL_DIR=en
LOAD_MODEL_NAME=state_epoch_15 # change this
INIT_CHECKPOINT=${SAVE_ROOT}/outputs/${DATA_NAME}/${LOAD_MODEL_DIR}/${LOAD_MODEL_NAME}
WITH_JOINT_ACT=false
USE_TRUE_PREV_BSPN=true
USE_TRUE_PREV_ASPN=false
USE_TRUE_PREV_RESP=true
USE_TRUE_CURR_BSPN=false
USE_TRUE_CURR_ASPN=false
USE_TRUE_DB_POINTER=false
USE_ALL_PREVIOUS_CONTEXT=true
BATCH_SIZE=64
BEAM_SIZE=5
NUM_GPU=1
SEED=10
SAVE_DIR=${SAVE_ROOT}/outputs/${DATA_NAME}/en.infer
EXP_SETTING=en
MODE=infer

# Main run.
python -u run.py \
  --do_infer=true \
  --model=${MODEL} \
  --save_dir=${SAVE_DIR} \
  --data_name=${DATA_NAME} \
  --data_root=${PROJECT_ROOT} \
  --vocab_path=${VOCAB_PATH} \
  --init_checkpoint=${INIT_CHECKPOINT} \
  --with_joint_act=${WITH_JOINT_ACT} \
  --use_true_prev_bspn=${USE_TRUE_PREV_BSPN} \
  --use_true_prev_aspn=${USE_TRUE_PREV_ASPN} \
  --use_true_prev_resp=${USE_TRUE_PREV_RESP} \
  --use_true_curr_bspn=${USE_TRUE_CURR_BSPN} \
  --use_true_curr_aspn=${USE_TRUE_CURR_ASPN} \
  --use_true_db_pointer=${USE_TRUE_DB_POINTER} \
  --use_all_previous_context=${USE_ALL_PREVIOUS_CONTEXT} \
  --batch_size=${BATCH_SIZE} \
  --beam_size=${BEAM_SIZE} \
  --gpu=${NUM_GPU} \
  --seed=${SEED} \
  --max_len=1024 \
  --max_ctx_turn=16 \
  --num_act=20 \
  --num_type_embeddings=2 \
  --data_processed=data_for_galaxy_encoded.data.json \
  --exp_setting=${EXP_SETTING} \
  --mode=${MODE}
