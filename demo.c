#if defined(_WINDOWS) || defined(WIN32)
#include <windows.h>
#include <tchar.h>
#else
#define _tmain main
#define __cdecl
#endif
#include <stdio.h>
#include "export.h"

void do_print(DWORD type)
{
	DWORD a;
	//char *p;
	//FILE *fp;
	if(TxOpenPrinter(type,0))
	{
		if(TX_TYPE_COM==type)
			TxSetupSerial(TX_SER_BAUD38400|TX_SER_DATA_8BITS|TX_SER_PARITY_NONE|TX_SER_STOP_1BITS|TX_SER_FLOW_HARD);
		printf("open printer success\n");
		a=TxGetStatus();
		printf("status=%lXh\n",a);
        #if 1
		TxInit();//打印机初始化
		//设置下划线
		TxDoFunction(TX_FONT_ULINE,TX_ON,0);//打开下划线
		TxOutputStringLn("This is Font A with underline.");//输出字符串
		//设置字体
		TxDoFunction(TX_SEL_FONT,TX_FONT_B,0);//设置字体的分辨率font_b为9x17点阵
		TxDoFunction(TX_FONT_ULINE,TX_OFF,0);//关闭下划线
		TxDoFunction(TX_FONT_BOLD,TX_ON,0);//字体加粗
		TxOutputStringLn("This is Font B with bold.");
		TxResetFont();//恢复字体效果（大小、粗体等）为原始状态
		//设置对齐方式
		TxDoFunction(TX_ALIGN,TX_ALIGN_CENTER,0);//设置为居中
		TxOutputStringLn("center");
		TxDoFunction(TX_ALIGN,TX_ALIGN_RIGHT,0);//右对齐
		TxOutputStringLn("right");
		TxDoFunction(TX_ALIGN,TX_ALIGN_LEFT,0);//左对齐
		TxDoFunction(TX_FONT_ROTATE,TX_ON,0);//字体右旋转90度
		TxOutputStringLn("left & rotating");
		TxResetFont();
		//中文显示方式
		TxDoFunction(TX_CHINESE_MODE,TX_ON,0);//设置为中文
		TxOutputStringLn("中文");
		TxDoFunction(TX_FONT_SIZE,TX_SIZE_3X,TX_SIZE_2X);//字体放大倍数，宽3倍(最大为7倍)，高2倍(最大为7倍)
		TxDoFunction(TX_UNIT_TYPE,TX_UNIT_MM,0);//设置放大的单位(毫米，像素)，无效
		TxDoFunction(TX_HOR_POS,20,0);//距离左边20mm的位置开始打印
		TxOutputStringLn("放大Abc");
		TxResetFont();
		//走纸操作
		TxDoFunction(TX_FEED,30,0);//走纸30mm
		TxOutputStringLn("feed 30mm");
		//打印条码
		TxDoFunction(TX_BARCODE_HEIGHT,15,0);//设置条码的高度为15个像素点
		TxPrintBarcode(TX_BAR_UPCA,"12345678901");//打印 UPCA 的条码，数据为“12345678901”
		//打印图形文件
		TxPrintImage("a1.png");//参数为图片的绝对路径		
		TxDoFunction(TX_UNIT_TYPE,TX_UNIT_PIXEL,0);//设置放大的单位(毫米，像素)，无效

		TxDoFunction(TX_FEED,140,0);//走纸140mm
		//切纸操作
		TxDoFunction(TX_CUT,TX_CUT_FULL,0);//全切
		//a=TxGetStatus();
		//printf("status=%u\n", a);
		//p=malloc(a);
		//TxReadPrinter(p,a);
		//fp=fopen("dump","wb");
		//fwrite(p,1,a,fp);
		//free(p);
		
		//打印QR码
		TxDoFunction(TX_QR_DOTSIZE,6,0);
		TxDoFunction(TX_QR_ERRLEVEL,TX_QR_ERRLEVEL_M,0);
		TxPrintQRcode("ABCD",4);
        #endif
		//关闭打印机
		TxClosePrinter();
	}
	else
		printf("open printer failure\n");
}

int __cdecl _tmain(int argc, char* argv[])
{
	int in;
	puts("select one port to output:");
	puts("1. USB");
	puts("2. LPT");
	puts("3. COM (38400,8,N,1)");
	printf("choose: ");
	fflush(stdout);
	in=getchar();
	if('1'==in)
		do_print(TX_TYPE_USB);
	else if('2'==in)
		do_print(TX_TYPE_LPT);
	else if('3'==in)
		do_print(TX_TYPE_COM);
	//else if('4'==in)
	//	do_print(4);
	else
		puts("wrong selection!");
	return 0;
}
