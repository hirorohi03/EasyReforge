@echo off
call %~dp0Reforge_NoOptions.bat --cuda-malloc --cuda-stream --skip-torch-cuda-test --use-sage-attention %*