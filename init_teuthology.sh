virtualenv ./virtualenv
source virtualenv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
python setup.py develop
