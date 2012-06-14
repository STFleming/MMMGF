#ifndef _ADATA_ADMXRC2_H
#define _ADATA_ADMXRC2_H

/*
** admxrc2.h -  ADM-XRC SDK API header file (ADMXRC2 interface)
**
** (C) Copyright 2001-2002 Alpha Data Parallel Systems Ltd.
*/

/*
** Function prototypes
*/
#ifdef __cplusplus
extern "C"{
#endif

/*
** Get the 'standard' sized integer types such as uint32_t etc.
**
** These are part of the ISOC99 standard. If your compiler doesn't
** define them, you'll have to make them yourself.
*/
#include <stdint.h>

#include <admxrc2/status.h>
#include <admxrc2/struct.h>

uint32_t
ADMXRC2_BuildDMAModeWord(
    ADMXRC2_BOARD_TYPE                       boardtype,
    ADMXRC2_IOWIDTH                          buswidth,
    unsigned int                             waitstates,
    uint32_t                                 misc);

ADMXRC2_STATUS
ADMXRC2_CancelWaitForInterrupt(
    ADMXRC2_HANDLE                           card);

ADMXRC2_STATUS
ADMXRC2_CloseCard(
    ADMXRC2_HANDLE                           card);
  
ADMXRC2_STATUS
ADMXRC2_ConfigureFromBuffer(
    ADMXRC2_HANDLE                           card,
    const void*                              buffer,
    unsigned long                            length);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromBufferExt(
    ADMXRC2_HANDLE                           card,
    unsigned int                             index,
    const void*                              buffer,
    unsigned long                            length);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromBufferDMA(
    ADMXRC2_HANDLE                           card,
    const void*                              buffer,
    unsigned long                            length,
    unsigned int                             dmachan,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromBufferDMAExt(
    ADMXRC2_HANDLE                           card,
    unsigned int                             index,
    const void*                              buffer,
    unsigned long                            length,
    unsigned int                             dmachan,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromFile(
    ADMXRC2_HANDLE                           card,
    const char*                              filename);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromFileExt(
    ADMXRC2_HANDLE                           card,
    unsigned int                             index,
    const char*                              filename);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromFileDMA(
    ADMXRC2_HANDLE                           card,
    const char*                              filename,
    unsigned int                             dmachan,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_ConfigureFromFileDMAExt(
    ADMXRC2_HANDLE                           card,
    unsigned int                             index,
    const char*                              filename,
    unsigned int                             dmachan,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_DoDMA(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_DMADESC                          dmadesc,
    unsigned long                            offset,
    unsigned long                            length,
    uint32_t                                 local,
    ADMXRC2_DMADIR                           direction,
    unsigned int                             channel,
    uint32_t                                 mode,
    uint32_t                                 flags,
    unsigned long*                           timeout,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_DoDMA2D(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_DMADESC                          dmadesc,
    unsigned long                            offset,
    unsigned long                            length,
    uint32_t                                 local,
    unsigned long                            width,
    unsigned long                            skip,
    unsigned long                            local_skip,
    ADMXRC2_DMADIR                           direction,
    unsigned int                             channel,
    uint32_t                                 mode,
    uint32_t                                 flags,
    unsigned long*                           timeout,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_DoDMAImmediate(
    ADMXRC2_HANDLE                           card,
    void*                                    buffer,
    unsigned long                            length,
    uint32_t                                 local,
    ADMXRC2_DMADIR                           direction,
    unsigned int                             channel,
    uint32_t                                 mode,
    uint32_t                                 flags,
    unsigned long*                           timeout,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_DoDMAImmediate2D(
    ADMXRC2_HANDLE                           card,
    void*                                    buffer,
    unsigned long                            length,
    uint32_t                                 local,
    unsigned long                            width,
    unsigned long                            skip,
    unsigned long                            local_skip,
    ADMXRC2_DMADIR                           direction,
    unsigned int                             channel,
    uint32_t                                 mode,
    uint32_t                                 flags,
    unsigned long*                           timeout,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_EnumerateCards(
    ADMXRC2_ENUM_FUNCTION                    enum_func);

ADMXRC2_STATUS
ADMXRC2_GetBankInfo(
    ADMXRC2_HANDLE                           card,
    unsigned int                             bank_index,
    ADMXRC2_BANK_INFO*                       info);

ADMXRC2_STATUS
ADMXRC2_GetCardInfo(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_CARD_INFO*                       info);

ADMXRC2_STATUS
ADMXRC2_GetFPGAInfo(
    ADMXRC2_HANDLE                           card,
    unsigned int                             index,
    ADMXRC2_FPGA_INFO*                       info);

ADMXRC2_STATUS
ADMXRC2_GetSpaceConfig(
    ADMXRC2_HANDLE                           card,
    unsigned int                             space_index,
    uint32_t*                                flags);

ADMXRC2_STATUS
ADMXRC2_GetSpaceInfo(
    ADMXRC2_HANDLE                           card,
    unsigned int                             space_index,
    ADMXRC2_SPACE_INFO*                      info);
  
const char*
ADMXRC2_GetStatusString(
    ADMXRC2_STATUS Status);

ADMXRC2_STATUS
ADMXRC2_GetVersionInfo(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_VERSION_INFO*                    info);

ADMXRC2_STATUS
ADMXRC2_InstallErrorHandler(
    ADMXRC2_ERROR_HANDLER                    handler);

ADMXRC2_STATUS
ADMXRC2_LoadBitstream(
    ADMXRC2_HANDLE                           card,
    const char*                              filename,
    ADMXRC2_IMAGE*                           image,
    unsigned long*                           bytes_read);

ADMXRC2_STATUS
ADMXRC2_LoadBitstreamExt(
    ADMXRC2_HANDLE                           card,
    unsigned int                             index,
    const char*                              filename,
    ADMXRC2_IMAGE*                           image,
    unsigned long*                           bytes_read);

ADMXRC2_STATUS
ADMXRC2_LocalBusReset(
    ADMXRC2_HANDLE                           card);

ADMXRC2_STATUS
ADMXRC2_MapDirectMaster(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_DMADESC                          dmadesc,
    unsigned long                            offset,
    unsigned long                            length,
    ADMXRC2_BUFFERMAP*                       map);

ADMXRC2_STATUS
ADMXRC2_OpenCard(
    ADMXRC2_CARDID                           card_ID,
    ADMXRC2_HANDLE*                          card);

ADMXRC2_STATUS
ADMXRC2_OpenCardShared(
    ADMXRC2_CARDID                           card_ID,
    ADMXRC2_HANDLE*                          card);

ADMXRC2_STATUS
ADMXRC2_OpenCardByIndex(
    unsigned int                             card_index,
    ADMXRC2_HANDLE*                          card);

ADMXRC2_STATUS
ADMXRC2_OpenCardByIndexShared(
    unsigned int                             card_index,
    ADMXRC2_HANDLE*                          card);

ADMXRC2_STATUS
ADMXRC2_ProgramBytes(
    ADMXRC2_HANDLE                           card,
    const uint32_t*                          program,
    unsigned long                            length);

ADMXRC2_STATUS
ADMXRC2_Read(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_IOWIDTH                          width,
    uint32_t                                 flags,
    uint32_t                                 local,
    void*                                    buffer,
    unsigned long                            len);

ADMXRC2_STATUS
ADMXRC2_ReadConfig(
    ADMXRC2_HANDLE                           card,
    unsigned long                            index,
    uint32_t*                                value);


ADMXRC2_STATUS
ADMXRC2_SetClockRate(
    ADMXRC2_HANDLE                           card,
    unsigned int                             clock_index,
    double                                   rate,
    double*                                  actual);

ADMXRC2_STATUS
ADMXRC2_SetSpaceConfig(
    ADMXRC2_HANDLE                           card,
    unsigned int                             space_index,
    uint32_t                                 flags);

ADMXRC2_STATUS
ADMXRC2_SetupDMA(
    ADMXRC2_HANDLE                           card,
    void*                                    buffer,
    unsigned long                            size,
    uint32_t                                 flags,
    ADMXRC2_DMADESC*                         dmadesc);

ADMXRC2_STATUS
ADMXRC2_StatusToString(
    ADMXRC2_STATUS                           status,
    char*                                    string,
    unsigned long                            length);

ADMXRC2_STATUS
ADMXRC2_SyncDirectMaster(
    ADMXRC2_HANDLE                           card,
    ADMXRC2_DMADESC                          dmadesc,
    unsigned long                            offset,
    unsigned long                            length,
    ADMXRC2_SYNCMODE                         syncmode);

ADMXRC2_STATUS
ADMXRC2_UnloadBitstream(
    ADMXRC2_IMAGE                            image);


ADMXRC2_STATUS
ADMXRC2_UnsetupDMA(	
    ADMXRC2_HANDLE                           card,
    ADMXRC2_DMADESC                          dmadesc);

ADMXRC2_STATUS
ADMXRC2_WaitForInterrupt(
    ADMXRC2_HANDLE                           card,
    unsigned long*                           timeout_us,
    unsigned long                            flags,
    void*                                    ignored);

ADMXRC2_STATUS
ADMXRC2_Write(		
    ADMXRC2_HANDLE                           card,
    ADMXRC2_IOWIDTH                          width,
    uint32_t                                 flags,
    uint32_t                                 local,
    void*                                    data,
    unsigned long                            len);

ADMXRC2_STATUS
ADMXRC2_WriteConfig(
    ADMXRC2_HANDLE                           card,
    unsigned long                            index,
    uint32_t                                 value);

void*
ADMXRC2_Malloc(
    unsigned long                            size);

void
ADMXRC2_Free(
    void*                                    ptr);

#ifdef __cplusplus
} 
#endif

#endif /* ADMXRC2_H */

