PATH=C:\Users\User\node_modules\level\node_modules\leveldown\deps\leveldb\Release;%PATH%
SET DB_DIRECTORY=c:\users\user\downloads\electrum
SET DAEMON_URL=http://user:password@127.0.0.1:18333/
SET TCP_PORT=50001
SET SSL_PORT=50002
SET SSL_CERTFILE=C:\Users\User\Downloads\openssl-1.0.2k-x64_86-win64\server.crt
SET SSL_KEYFILE=C:\Users\User\Downloads\openssl-1.0.2k-x64_86-win64\server.key
SET COIN=Bitcoin
SET NET=mainnet
py -3.6 electrumx_server.py
