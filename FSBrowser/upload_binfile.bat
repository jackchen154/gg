@echo off
set bin_file=FSBrowser.ino.nodemcu.bin
set upload_tool=C:\Users\Administrator\AppData\Local\Arduino15\packages\esp8266\hardware\esp8266\2.7.4\tools\upload.py

python3 %upload_tool% --chip esp8266 --port COM27 --baud 921600 erase_flash --before default_reset --after hard_reset write_flash 0x0 %bin_file%
pause