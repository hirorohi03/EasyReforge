@echo off
chcp 65001 > NUL

set "PROJECT_NAME=EasyReforge"
set "PROJECT_SETUP_BAT=%~dp0%PROJECT_NAME%\Setup.bat"
set "PROJECT_MODEL_DOWNLOAD_BAT=%~dp0Download\NoobAiEpsilonPred_Minimum.bat"

set PROJECT_URL=https://github.com/hirorohi03/%PROJECT_NAME%
set PROJECT_BRANCH=main
set "PROJECT_DIR=%~dp0."
set "EASY_TOOLS_DIR=%~dp0EasyTools"

set "EASY_GIT_DIR=%EASY_TOOLS_DIR%\Git"
set EASY_TOOLS_URL=https://github.com/hirorohi03/EasyTools
set EASY_TOOLS_BRANCH=main

if not exist "C:\Windows\System32\where.exe" (
	echo "[ERROR] C:\Windows\System32\where.exe が見つかりません。"
	pause & exit /b 1
)

set PS_EXE=PowerShell
where /Q %PS_EXE%
if %ERRORLEVEL% neq 0 (
	echo "[ERROR] %PS_EXE% が見つかりません。"
	pause & exit /b 1
)

@REM Windows 10 でプリインストールされているバージョンが 5.1
set PS_CMD=PowerShell -Version 5.1 -NoProfile -ExecutionPolicy Bypass

%PS_CMD% -c "if ('%~dp0' -match '^[a-zA-Z0-9:_\\/-]+$') {exit 0}; exit 1"
if %ERRORLEVEL% neq 0 (
	echo "[ERROR] 現在のフォルダパス %~dp0 に英数字・ハイフン・アンダーバー以外が含まれています。"
	echo "英数字・ハイフン・アンダーバーのフォルダパスに bat ファイルを移動して、再実行してください。"
	pause & exit /b 1
)

set CURL_EXE=C:\Windows\System32\curl.exe
if not exist %CURL_EXE% (
	echo "[ERROR] %CURL_EXE% が見つかりません。"
	pause & exit /b 1
)
set CURL_CMD=C:\Windows\System32\curl.exe -kL

if exist %~dp0stable-diffusion-webui\ (
	echo "%~dp0stable-diffusion-webui がすでに存在します。別のフォルダにインストールしてください。"
	pause & exit /b 1
)
if exist %~dp0stable-diffusion-webui-forge\ (
	echo "%~dp0stable-diffusion-webui-forge がすでに存在します。別のフォルダにインストールしてください。"
	pause & exit /b 1
)
if exist %~dp0stable-diffusion-webui-reForge\ (
	echo "%~dp0stable-diffusion-webui-reForge がすでに存在します。別のフォルダにインストールしてください。"
	pause & exit /b 1
)

echo "未成年の方は利用できません。"
echo "動作に必要なモデルなどをダウンロードします。よろしいですか？ [y/n]（空欄なら y）"
echo "Download Model etc. Are you sure? [y/n] (default: y)"
set /p DOWNLOAD_MDOEL_YES_OR_NO=

@REM ---- ここから Git/Git_SetPath.bat と同期 ----
where /Q git
if %ERRORLEVEL% equ 0 ( goto :EASY_GIT_FOUND )
cd > NUL

set PORTABLE_GIT_BIN=%EASY_GIT_DIR%\env\PortableGit\bin
set PORTABLE_GIT_VERSION=2.53.0.2

if not exist %PORTABLE_GIT_BIN%\ (
	setlocal enabledelayedexpansion
	if not exist "%EASY_GIT_DIR%\env\" ( mkdir "%EASY_GIT_DIR%\env" )
	echo https://github.com/git-for-windows/git/

	echo %CURL_CMD% -o %EASY_GIT_DIR%\env\PortableGit.7z.exe https://github.com/git-for-windows/git/releases/download/v%PORTABLE_GIT_VERSION%.windows.1/PortableGit-%PORTABLE_GIT_VERSION%-64-bit.7z.exe
	%CURL_CMD% -o %EASY_GIT_DIR%\env\PortableGit.7z.exe https://github.com/git-for-windows/git/releases/download/v%PORTABLE_GIT_VERSION%.windows.1/PortableGit-%PORTABLE_GIT_VERSION%-64-bit.7z.exe
	if !ERRORLEVEL! neq 0 ( pause & endlocal & exit /b 1 )

	start "" %PS_CMD% -Command "Start-Sleep -Seconds 5; $title='Portable Git for Windows 64-bit'; $window=Get-Process | Where-Object { $_.MainWindowTitle -eq $title } | Select-Object -First 1; if ($window -ne $null) { [void][System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic'); [Microsoft.VisualBasic.Interaction]::AppActivate($window.Id); Start-Sleep -Seconds 1; Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}') }"

	echo "操作せずに、そのまま Portable Git for Windows をインストールしてください。"
	%EASY_GIT_DIR%\env\PortableGit.7z.exe
	if !ERRORLEVEL! neq 0 ( pause & endlocal & exit /b 1 )

	echo del %EASY_GIT_DIR%\env\PortableGit.7z.exe
	del %EASY_GIT_DIR%\env\PortableGit.7z.exe
	if !ERRORLEVEL! neq 0 ( pause & endlocal & exit /b 1 )
	endlocal
)

set "PATH=%PORTABLE_GIT_BIN%;%PATH%"

where /Q git
if %ERRORLEVEL% equ 0 ( goto :EASY_GIT_FOUND )
echo "[Error] Git をインストールできませんでした。手動で Git for Windows をインストールしてください。"
pause & exit /b 1

:EASY_GIT_FOUND
@REM ---- ここまで Git/Git_SetPath.bat と同期 --------

call :INIT_REPO %EASY_TOOLS_DIR% %EASY_TOOLS_URL% %EASY_TOOLS_BRANCH%
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call :INIT_REPO %PROJECT_DIR% %PROJECT_URL% %PROJECT_BRANCH%
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %PROJECT_SETUP_BAT%
if %ERRORLEVEL% neq 0 ( exit /b 1 )

if /i "%DOWNLOAD_MDOEL_YES_OR_NO%" == "n" ( goto :FINALIZE )
call %PROJECT_MODEL_DOWNLOAD_BAT%
@REM if %ERRORLEVEL% neq 0 ( exit /b 1 )

goto :FINALIZE

:INIT_REPO
set INIT_REPO_DIR=%~1
set INIT_REPO_URL=%~2
set INIT_REPO_BRANCH=%~3

if not exist %INIT_REPO_DIR%\ ( mkdir %INIT_REPO_DIR% )
pushd %INIT_REPO_DIR%

echo git init -q
git init -q
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

git remote get-url origin > NUL 2>&1
if %ERRORLEVEL% neq 0 (
	cd > NUL
	setlocal enabledelayedexpansion
	echo git remote add origin %INIT_REPO_URL%
	git remote add origin %INIT_REPO_URL%
	if !ERRORLEVEL! neq 0 ( pause & endlocal % popd & exit /b 1 )
	endlocal
)

echo git fetch
git fetch
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

echo "git switch %INIT_REPO_BRANCH% 2>NUL || git checkout -b %INIT_REPO_BRANCH%"
git switch %INIT_REPO_BRANCH% 2>NUL || git checkout -b %INIT_REPO_BRANCH%
if %ERRORLEVEL% neq 0 ( pause & popd & exit /b 1 )

exit /b 0

:FINALIZE
@REM HKEY_LOCAL_MACHINE の変更には管理者権限が必要
echo reg add "HKCU\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
reg add "HKCU\SYSTEM\CurrentControlSet\Control\FileSystem" /v LongPathsEnabled /t REG_DWORD /d 1 /f
if %ERRORLEVEL% neq 0 (
	echo "Windows の長いパス対応を有効にできませんでした。"
	echo "Windows の管理者権限で EasyTools/EnableLongPaths.bat を実行してください。"
	pause
)

if exist "%~0" ( del "%~0" )