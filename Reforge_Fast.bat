@echo off
call %~dp0Reforge.bat --pin-shared-memory --allow-fp16-accumulation %*
