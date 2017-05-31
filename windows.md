##Running your Bitcoin node

You can't prune your node. This is the reason why so many people don't like blocksize increase. Running pruned node is simply not an option for them.

You need to run bitcoin node, either bitcoin-qt or bitcoind with the following option

txindex=1
server=1
rpcuser=username
rpcpassword=password
rpcport=18333

You can either put these options with - character in front of them without newline if you are running from command line or alternatively you can save them in %APPDATA%\Bitcoin folder as bitcoin.conf

#Download and install everything. I used powershell but you can just simply open the link in browser and save them yourselves

First get a copy of python 3.6.1

powershell
wget https://www.python.org/ftp/python/3.6.1/python-3.6.1-amd64.exe -Outfile python-3.6.1-amd64.exe 

And then install or just doubleclick on it, make sure to check put python in path
./python-3.6.1-amd64 -Wait

Get git-for-windows

wget https://github.com/git-for-windows/git/releases/download/v2.13.0.windows.1/Git-2.13.0-64-bit.exe

Install them, if it asks you whether to place it in PATH answer yes
./Git-2.13.0-64-bit.exe

Get visual c++ 2015 (it has to be that version, it is the only version that works with python 3.6)

wget http://go.microsoft.com/fwlink/?LinkId=691126 -Outfile visualcppbuildtool_full.exe
./visualcppbuildtool_full -Wait

At this stage you will need to open a command prompt if you haven't already opened them

First upgrade pip

python -m pip install -U pip

Then install aiohttp

py -3.6 -m pip install aiohttp

Then install pylru

py -3.6 -m pip install pylru

#Build leveldb.lib and leveldb.dll

I found these from nodejs module level. It's the only fork that I can get it to compile. It requires nw.lib and libuv. I've included them inside for your convenience. However if you don't want to use them you can get them from nwjs directly. Just follow the procedure listed in https://github.com/nwjs/nw-gyp. Normally it will be saved inside %USERPROFILE%\.nw-gyp folder
Header is in deps\uv and library is in x64 folder

Open up Visual C++ 2015 Native Build Tools Command Prompt

git clone https://github.com/sontol/leveldb

Go to snappy directory
msbuild

Go to leveldb directory
msbuild /t:Rebuild /p:Configuration=Release /p:PlatformToolset=v140 leveldb.vcxproj

You can then find the .dll and .lib in the Release folder

I think you can use the IDE as well, I've never tried them though.

#Build plyvel, replace the include and library directory with the appropriate directory for leveldb include and leveldb.lib

py -3.6 -m pip install --global-option=build_ext --global-option="-IC:\Users\User\node_modules\level\node_modules\leveldown\deps\leveldb\leveldb-1.18.0\include" --global-option="-LC:\Users\User\node_modules\level\node_modules\leveldown\deps\leveldb\Release" plyvel

#Get electrumx

I created my own branch of electrumx. Basically I made 3 modifications: remove maximum file handle check because Windows has pretty big limit, remove access level check so you need to make sure on your own that you don't run with Administrator privilege, and finally remove keyboard interrupt check although CTRL+C and CTRL+BREAK will still work

git clone https://github.com/sontol/electrumx -b windows

Go to your electrum folder
Edit electrumx.bat

Make sure that your leveldb.dll is inside the PATH, edits them if necessary
Put SSL_CERTFILE and SSL_KEYFILE where you generate them with openssl
Change DB_DIRECTORY into where you want to save the electrum database
Make sure that DAEMON_URL is the same as your bitcoind/bitcoin-qt setting with username, password, and port equals to what you save in bitcoin.conf
Save it
Run electrumx.bat
If you want to end running press CTRL+C or CTRL+BREAK
