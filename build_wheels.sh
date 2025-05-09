PYTHON_VERSION=3.12
TORCH_VERSION=2.7.0
CUDA_VERSION=cu126

ENV_NAME="torch_${TORCH_VERSION}_cuda_${CUDA_VERSION}_py${PYTHON_VERSION}_env"

uv venv $ENV_NAME --python=$PYTHON_VERSION

source ./$ENV_NAME/bin/activate
uv pip install numpy
uv pip install torch==$TORCH_VERSION --index-url  https://download.pytorch.org/whl/$CUDA_VERSION
uv pip install setuptools wheel

VERSION=`sed -n "s/^__version__ = '\(.*\)'/\1/p" torch_scatter/__init__.py`
TORCH_VERSION=`echo "pt$TORCH_VERSION" | sed "s/..$//" | sed "s/\.//g"`

sed -i "s/$VERSION/$VERSION+$TORCH_VERSION$CUDA_VERSION/" setup.py
sed -i "s/$VERSION/$VERSION+$TORCH_VERSION$CUDA_VERSION/" torch_scatter/__init__.py


source ./.github/workflows/cuda/${CUDA_VERSION}-Linux-env.sh
python setup.py develop
python setup.py bdist_wheel --dist-dir=dist

sed -i "s/$VERSION+$TORCH_VERSION$CUDA_VERSION/$VERSION/" setup.py
sed -i "s/$VERSION+$TORCH_VERSION$CUDA_VERSION/$VERSION/" torch_scatter/__init__.py

source deactivate
