:: Build after installing Visual Studio 2015
cd src
"C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat" 
devenv  WinNFSd.sln /upgrade
::msbuild WinNFSd.sln /property:Configuration=Release /property:Platform=x64 /m
:: 64-bit builds currently crash for me on Windows 8.1
msbuild WinNFSd.sln /property:Configuration=Release /property:Platform=Win32 /m
:: /m - parallel build
