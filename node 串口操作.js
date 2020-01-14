var SerialPort = require('serialport');
var port = new SerialPort('COM1',{
	baudRate:115200,
	autoOpen: false
});

//手动打开串口
port.open(function (err) {
  if (err) {
    return console.log('手动打开串口错误: ', err.message)
  }
})

//关闭串口
function close_port(){
port.close(function (err) {
  if (err) {
     console.log('手动关闭串口错误: ', err.message)
  }
})
} 
/*/状态读取部分

SerialPort.list()//罗列设备
.then(fanhui =>{ 
	console.log(fanhui)
})
console.log("端口绑定状态:",port.binding)
console.log("端口波特率:",port.baudRate)
console.log("端口开启状况:",port.isOpen)
console.log("端口名称:",port.path)*/

function writeport()
{
	//支持的编码格式：ascii , utf8 , utf16le , ucs2 , base64 ,latin1 ,binary ,hex
    port.write("你好你叫什么名字\n",'utf8', function (err) {
        if (err) {
            return console.log('Error on write: ', err.message);
        }
    });
}


//---------------------------------------------------------------------------------------------
// 端口打开情况监控
port.on('open', function () {
	console.log('串口'+port.path+'已经打开')
	//对已经打开的端口进行波特率更新
    port.update({baudRate:9600}, err => {
        if(err){ 
		console.log("波特率更新出现错误:",err)}
		})
});

// 端口关闭状态监控
port.on('close', function (err) {

    console.log('串口'+port.path+'已经关闭');
})

// 端口错误监控
port.on('error', function (err) {
    console.log('Error: ', err.message);
})


//监控有数据传过来(Buffer object)
port.on('data', function (data) {
    console.log('recv: ' + data.toString('utf8'));

  });
  