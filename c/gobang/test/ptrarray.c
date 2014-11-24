#include <stdio.h>


int main()
{
    char a[] = "hello world!";
    char *p  = "pointer string";
    
    //数组名 a 的地址, 与首元素 a[0] 的地址相同.
    printf("&a   = %x\n", &a);
    printf("&a[0]= %x\n", &a[0]);
    printf("a    = %x, also = %s\n", a, a);
    
    printf("\n");
    
    printf("&p   = %x\n", &p);
    printf("&p[0]= %x\n", &p[0]);
    printf("p    = %x, also = %s\n", p, p);
    
    printf("\n");
    
    //数组的元素可以可变内容.
    a[2] = '#';
    printf("After change, a = %s\n", a);
    
    //指针所指向的字符串 "pointer string" 是常量, 不可以通过此种方式修改其值.
    p[2] = '#'; //将返回错误.
    printf("After change, p = %s\n", p);
    
    return 0;
}

/*

    char a[];
    char *p;
    a 为此数组的首地址
    p 为指针, 其指向的存储内容为一个字符串变量的首地址.
