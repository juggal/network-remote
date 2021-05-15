# network-remote

### clone repo
`git clone https://github.com/juggal/network-remote.git`

### go to services directory
```
cd services
```

### create new virtual environment
make sure virtualenv is installed in your global packages

```
python -m venv [environment-name]
```
```
source [environement-name]/bin/activate
```

### Install python packages
```
pip install -r requirements.txt
```

### Run websocket server
```
python mouse_controller.py
```

### Run api server
```
python api.py
```

**on app's first screen add ip address and port shown on api server logs**
