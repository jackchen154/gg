在homebridge-aqara源代码 AqaraPlatform.js最上面可以看到端口与组播信息.
    const dgram = require('dgram');
    const inherits = require('util').inherits;
    const crypto = require('crypto');
    const iv = Buffer.from([0x17, 0x99, 0x6d, 0x09, 0x3d, 0x28, 0xdd, 0xb3, 0xba, 0x69, 0x5a, 0x2e, 0x6f, 0x58, 0x56, 0x2e]);
    const serverSocket = dgram.createSocket('udp4');
    const multicastAddress = '224.0.0.50';//组播地址
    const multicastPort = 4321;//组播端口
    const serverPort = 9898;
    var AqaraAccessoryFactory;

serverPort = 9898 这个端口比较重要,用于与homebridge-aqara通信的端口,网关可以使用任意端口与这个端口建立UDP连接即可通信.

homebridge发送:
{"cmd": "whois"}
 
device回复:
{
"cmd": "iam", 
"ip": "192.168.0.111",
"port": "4322"
}
homebridge发送:
{"cmd":"get_id_list"}
device回复:
{
    "cmd": "get_id_list_ack",
    "sid": "6409802da3ca",
    "token": "1234567812345678",
    "data": "[11,12,15]"
}
{"cmd": "get_id_list_ack", "sid": "6409802da3ca","token": "1234567812345678","data": "[11,12,15]"}

//传感器列表
homebridge发送:
{"cmd":"read", "sid":"11"}//温湿度传感器
{"cmd":"read", "sid":"12"}//插座
{"cmd":"read", "sid":"15"}//开关
//我要读取这些传感器的信息


//当按下插座图标时bride向设备回复如下
{
	"cmd":"write",
	"model":"plug",
	"sid":"12",
	"data":"{
	      \"status\":\"off\", //不论是开还是关都回复关，这个要处理一下
		  \"key\": \"bbf5624a816f7f2702512d6c1cd55e53\"
		  }"
}
{"cmd":"write","model":"plug","sid":"12","data":"{\"status\":\"off\",\"key\": \"bbf5624a816f7f2702512d6c1cd55e53\"}"}
//设备回复插座图标状态
{
    "cmd": "return_read",
    "model": "plug",
    "sid": "12",
    "data": "{\"status\": \"on\"}"
}
{"cmd": "return_read","model": "plug", "sid": "12","data": "{\"status\": \"on\"}"}

//控制插座下发的数据
{
    "cmd": "write",
    "model": "plug",
    "sid": "12",
    "data": "{\"status\":\"off\", \"key\": \"bbf5624a816f7f2702512d6c1cd55e53\"}"
}



//按下电灯开关图标时bridge向设备回复
{
	"cmd":"write",
	"model":"ctrl_neutral1",
	"sid":"15",
	"data":"{
		     \"channel_0\":\"off\", 
			 \"key\": \"bbf5624a816f7f2702512d6c1cd55e53\"
			 }"
}
//设备回复开关图标状态
{
    "cmd": "return_read",
    "model": "ctrl_neutral1",
    "sid": "15",
    "data": "{\"channel_0\": \"on\",\"channel_1\": \"off\"}"
}
{ "cmd": "return_read","model": "ctrl_neutral1", "sid": "15","data": "{\"channel_0\": \"on\",\"channel_1\": \"off\"}"}
{"cmd":"write_ack","model":"ctrl_neutral2","sid":"158d0000123456","short_id":4343,"data":"{\"channel_0\":\"on\",\"channel_1\":\"off\"}"}
//温湿度
{
    "cmd": "return_read",
    "model": "sensor_ht",
    "sid": "11",
    "data": "{\"temperature\": 2500,\"humidity\": 6501}"
}
{"cmd": "return_read", "model": "sensor_ht","sid": "11","data": "{\"temperature\": 2500,\"humidity\": 6501}"}

