#!/bin/bash
#source C:/Anaconda3/etc/profile.d/conda.sh
#source ~/anaconda3/etc/profile.d/conda.sh
eval "$(conda shell.bash hook)"
conda activate tf-gpu-py37

TF_INC=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_include())')
TF_LIB=$(python -c 'import tensorflow as tf; print(tf.sysconfig.get_lib())')
GLM_INC='#### Absolute path to glm library (the folder including folder "glm") ####'
CODE_PATH='C:\Users\Eduardo\Documents\Github\edualvarado\InexactSA\render'
CUDA_PATH='C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2\lib\x64'

nvcc -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0 -c -o render_all_fast.cu.o render_all_fast.cu.cc -I ${GLM_INC},${CODE_PATH} -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC
g++ -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0 -shared -o render_all_fast.so render_all_fast.cc render_all_fast.cu.o -I ${TF_INC} -I${TF_INC}/external/nsync/public -L ${CUDA_PATH} -L $TF_LIB -ltensorflow_framework -fPIC -lcudart

# nvcc -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0 -c -o render_all_point.cu.o render_all_point.cu.cc -I ${GLM_INC},${CODE_PATH} -D GOOGLE_CUDA=1 -x cu -Xcompiler -fPIC
# g++ -std=c++11 -D_GLIBCXX_USE_CXX11_ABI=0 -shared -o render_all_point.so render_all_point.cc render_all_point.cu.o -I ${TF_INC} -L ${CUDA_PATH} -fPIC -lcudart