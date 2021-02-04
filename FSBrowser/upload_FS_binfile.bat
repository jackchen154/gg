@echo off

@rem sizeΪҪ���ɵ�FS�Ĵ�С
set /a size=2024  
::set /a size=3048
set port=COM27


set start_addr=0
if %size%==2024 (set start_addr=0x200000)
if %size%==3048 (set start_addr=0x100000)
echo shi:%start_addr%
set /a size_res=%size%*1024
set file_name=%size%KB_FS_file.bin
echo ��������FS_bin.......
mklittlefs.exe -c ./data -s %size_res% -p 256 -b 8192 %file_name%
echo �Ѿ���ɣ������ļ�Ϊ%file_name%,���ڽ�����д����......

set upload_tool=C:\Users\Administrator\AppData\Local\Arduino15\packages\esp8266\hardware\esp8266\2.7.4\tools\upload.py
python3 %upload_tool% --chip esp8266 --port %port% --baud 921600 --before default_reset --after hard_reset write_flash %start_addr% %file_name%
echo ��д������
pause