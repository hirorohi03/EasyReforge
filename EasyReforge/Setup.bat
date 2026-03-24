@echo off
chcp 65001 > NUL

call %~dp0Reforge\Reforge.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0Reforge\ReforgeExtension.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

call %~dp0Reforge\ReforgeLink.bat
if %ERRORLEVEL% neq 0 ( exit /b 1 )

if exist %~dp0vc_redist.x64.exe ( goto :EXIST_VC_REDIST_X64 )
echo.
echo %CURL_CMD% -o %~dp0vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
%CURL_CMD% -o %~dp0vc_redist.x64.exe https://aka.ms/vs/17/release/vc_redist.x64.exe
if %ERRORLEVEL% neq 0 ( pause & exit /b 1 )
:EXIST_VC_REDIST_X64

if exist %~dp0Reforge\Update_DisableMinimumDownload.txt ( exit /b 0 )

if exist %~dp0..\Model\Stable-diffusion\NoobE\ (
	@REM call %~dp0..\Download\NoobAiEpsilonPred_Minimum.bat
	call %~dp0..\Download\src\NoobAiCommon_Minimum.bat
	@REM リンク切れ対策としてダウンロードの結果は確認しない
)
