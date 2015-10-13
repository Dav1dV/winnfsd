:: Build after installing Visual Studio 2015
::
::   Usage:  %0  [upgrade | build | rebuild]
@echo off

set default_commands=(upgrade build)
set     all_commands=(upgrade build rebuild)
set   all_commands_n=rebuild
set            env="C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\Tools\VsDevCmd.bat"
set upgrade_script=devenv  src\WinNFSd.sln /upgrade
::set   build_script=msbuild src\WinNFSd.sln /property:Configuration=Release /property:Platform=x64 /m
:: 64-bit builds currently crash for me on Windows 8.1
set   build_script=msbuild src\WinNFSd.sln /property:Configuration=Release /property:Platform=Win32 /m
:: /m - parallel build
set rebuild_script=%build_script% /t:Rebuild


:: Fancy way to enable command extensions, where available
:: http://technet.microsoft.com/en-us/library/bb491001.aspx OR http://www.robvanderwoude.com/allhelpw2ksp4_en.php#SETLOCAL
verify other 2>nul
setlocal enableextensions
setlocal EnableDelayedExpansion
if errorlevel 1 echo Unable to enable command extensions


::cd src
if "%1" neq "" (
  if "!%1_script!" neq "" (

    rem Exec specified command
    call :run_script env
    call :run_script %1_script

  ) else (

    rem Usage:  %0  [ command_1 | ... | command_N ]
    rem TODO: "echo|set /p="  is slow
    echo(
    echo|set /p="Usage:  %0  [ "
    for %%c in %all_commands% do (
      echo|set /p=" %%c "
      if %%c neq %all_commands_n% (
        echo|set /p=" | "
      )
    )
    echo ]

    rem TODO Wrong errorlevel 1st time
    exit /b 1
  )
) else (

  rem Exec default commands
  call :run_script env
  for %%c in %default_commands% do (
    call :run_script %%c_script
  )
)
exit /b 0

:run_script
  echo(
  echo(
  echo !%1!
  !%1!
  goto :eof
