@setlocal
@echo off

call %~dp0build-native.cmd Release x64
call %~dp0build-native.cmd Release x86
call %~dp0build-native.cmd Release ARM64
call %~dp0build-native.cmd Release ARM
© 2022 GitHub, Inc.
Terms
Privacy
Securit