PYTHON_VERSION=3.12
TORCH_VERSION=2.7.0
CUDA_VERSION=cu128
TORCH_SCATTER_VERSION=2.1.2

ENV_NAME="test_env_${TORCH_VERSION}_py${PYTHON_VERSION}_${CUDA_VERSION}"

rm -rf ./$ENV_NAME

uv venv $ENV_NAME --python $PYTHON_VERSION
source ./$ENV_NAME/bin/activate

uv pip install torch==$TORCH_VERSION --index-url  https://download.pytorch.org/whl/$CUDA_VERSION

PYTHON_VERSION_SHORT=`echo $PYTHON_VERSION | sed "s/\.//g"`
uv pip install ./dist/torch_scatter-$TORCH_SCATTER_VERSION+pt27${CUDA_VERSION}-cp${PYTHON_VERSION_SHORT}-cp${PYTHON_VERSION_SHORT}-linux_x86_64.whl

python -c "import torch; print(torch.__version__)"
python -c "import torch_scatter; print(torch_scatter.__version__)"
