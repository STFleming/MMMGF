#ifndef _ADATA_ADMXRC2_FLASH_H
#define _ADATA_ADMXRC2_FLASH_H

/*
** flash.h - structures and types used in ADM-XRC API calls
**
** (C) Copyright 2003 Alpha Data Parallel Systems Ltd.
*/

#include <admxrc2/status.h>
#include <admxrc2/struct.h>
#include <admxrc2/flashinf.h>

/*
** Function prototypes
*/
#ifdef __cplusplus
extern "C"{
#endif

ADMXRC2_STATUS
ADMXRC2_EraseFlash(                             ADMXRC2_HANDLE           card,
                                                unsigned long            start,
                                                unsigned long            length);

ADMXRC2_STATUS
ADMXRC2_GetFlashInfo(                           ADMXRC2_HANDLE           card,
                                                ADMXRC2_FLASH_INFO*      info);

ADMXRC2_STATUS
ADMXRC2_GetFlashBlockInfo(                      ADMXRC2_HANDLE           card,
                                                unsigned long            location,
                                                ADMXRC2_FLASHBLOCK_INFO* info);

ADMXRC2_STATUS
ADMXRC2_ReadFlash(                              ADMXRC2_HANDLE           card,
                                                unsigned long            start,
                                                unsigned long            length,
                                                void*                    buffer);

ADMXRC2_STATUS
ADMXRC2_WriteFlash(                             ADMXRC2_HANDLE           card,
                                                unsigned long            start,
                                                unsigned long            length,
                                                const void*              data);

#ifdef __cplusplus
} 
#endif

#endif

