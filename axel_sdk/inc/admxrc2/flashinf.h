/*
** flashinf.h - structures and types used in ADM-XRC API calls
**
** (C) Copyright 2003 Alpha Data Parallel Systems Ltd.
**
** Do not #include this file - #include <admxrc2/flash.h> instead.
*/

#ifndef _ADATA_ADMXRC2_FLASHINF_H
#define _ADATA_ADMXRC2_FLASHINF_H

/*
** Flash information structure
*/
typedef struct _ADMXRC2_FLASH_INFO {
	char	 DeviceName[32];    /* Freeform string of device name         */
	uint32_t DeviceSize;        /* Size of device                         */
	uint32_t DeviceBlockSize;   /* Device normal block size               */
	uint32_t UseableStart;      /* Region of device for target bitstreams */
	uint32_t UseableLength;     /* Region of device for target bitstreams */
} ADMXRC2_FLASH_INFO;

/*
** Flash block information structure
*/
#define ADMXRC2_FLASHBLOCKFLAG_BOOT (0x1U) /* Block is a boot block */
typedef struct _ADMXRC2_FLASHBLOCK_INFO {
	uint32_t Flags;             /* See flags definitions above */
	uint32_t Start;             /* Size of block               */
	uint32_t Length;            /* Length of block             */
} ADMXRC2_FLASHBLOCK_INFO;

#endif
