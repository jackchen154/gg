#include <pthread.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <unistd.h>

#define EXIT_SUCCESS 0
// 参数结构体 
struct argument
{
  int num;
  char string[30];
};

// 声明两个线程函数
void *thread1_func( void * );
void *thread2_func( void * );

int main(int argc, char *argv[])
{
  //定义两个线程标识符
  pthread_t thread1, thread2;
  //定义用来接收两个线程退出后的返回值,用作pthread_join的第二个参数
  void *thread1_return, *thread2_return;
  //传递的参数结构体
  struct argument arg1, arg2;
  int i;
  int wait_thread_end; //判断线程退出成功与否
  //参数结构体值初始化
  arg1.num = 1949;
  strcpy( arg1.string, "中华人民共和国" );
  
  arg2.num = 2012;
  strcpy( arg2.string, "建国63周年" );
  
  // 创建两个线程
  pthread_create(&thread1, NULL, thread1_func, (void*)&arg1 );
  pthread_create( &thread2, NULL, thread2_func, (void*)&arg2 );
  
  for( i = 0; i < 2; i++ )
  {
    printf("我是最初的进程！\n");
    sleep(2);  //主统线程睡眠，调用其他线程
  }
  
  //等待第一个线程退出，并接收它的返回值(返回值存储在thread1_return)
  wait_thread_end = pthread_join( thread1, &thread1_return );
  if( wait_thread_end != 0 ) 
  {
    printf("调用 pthread_join 获取线程1的返回值出现错误!\n");
  }
  else
  {
    printf("调用 pthread_join 成功！线程1退出后的返回值是 %s\n", (char)thread1_return);
  }
  
  //等待第二个线程退出，并接收它的返回值(返回值存储在thread2_return)
  wait_thread_end = pthread_join( thread2, &thread2_return);
  if( wait_thread_end != 0 ) 
  {
    printf("调用 pthread_join 获取线程2的返回值出现错误!\n");
  }
  else
  {
    printf("调用 pthread_join 成功！线程2退出后的返回值是 %d\n",(int)(long)thread2_return );
  }

  return EXIT_SUCCESS;
}

/**
 *线程1函数实现 
 */
 void *thread1_func( void *arg )
{
  int i;
  //static 
  unsigned char a[]="jackchen";
  struct argument *arg_thread1; // 接收传递过来的参数结构体
  
  arg_thread1 = ( struct argument * )arg;
  
  for( i = 0; i < 3; i++)
  {
    printf( "我来自线程1，传递给我的参数是 %d, %s\n", arg_thread1->num, arg_thread1->string);
    sleep(2); // 投入睡眠，调用其它线程
  }
  //return (void *)123;
  pthread_exit( (void *)(long)a );
  //return (void *)(long)a;
}

 void *thread2_func( void *arg )
{
  int i;
  struct argument *arg_thread2; // 接收传递过来的参数结构体
  
  arg_thread2 = ( struct argument * )arg;
  
  for( i = 0; i < 3; i++)
  {
    printf( "我来自线程2，传递给我的参数是 %d, %s\n", arg_thread2->num, arg_thread2->string);
    sleep(2); // 投入睡眠，调用其它线程
  }
  return (void *)456;
}
