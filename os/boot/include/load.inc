; FILE NAME
;     load.inc
;
; DESCRIPTION
;     pubic labels during load
;
; NOTE
;     代码重点参考了<自己动手写操作系统>一书, 自己做了些简单的修改, 增加了些注释.


BaseOfLoader              equ     09000h               ; LOADER.BIN 被加载到的位置 ---- 段地址
OffsetOfLoader            equ      0100h               ; LOADER.BIN 被加载到的位置 ---- 偏移地址

BaseOfLoaderPhyAddr       equ    BaseOfLoader * 10h    ; LOADER.BIN 被加载到的位置 ---- 物理地址 (= BaseOfLoader * 10h)


BaseOfKernelFile          equ     08000h               ; KERNEL.BIN 被加载到的位置 ---- 段地址
OffsetOfKernelFile        equ         0h               ; KERNEL.BIN 被加载到的位置 ---- 偏移地址

BaseOfKernelFilePhyAddr   equ    BaseOfKernelFile * 10h
KernelEntryPointPhyAddr   equ    030400h               ; 注意：1、必须与 MAKEFILE 中参数 -Ttext 的值相等!!
                                                       ;       2、这是个地址而非仅仅是个偏移，如果 -Ttext 的值为 0x400400，则它的值也应该是 0x400400。

PageDirBase               equ    200000h               ; 页目录开始地址:  2M
PageTblBase               equ    201000h               ; 页表开始地址:    2M + 4K

