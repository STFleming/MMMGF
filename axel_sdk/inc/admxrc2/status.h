/*
** status.h - status codes returned by ADM-XRC API calls
**
** (C) Copyright 2001 Alpha Data Parallel Systems Ltd.
**
** Do not #include this file in an application - #include <admxrc2.h> instead.
*/

#ifndef _ADATA_ADMXRC2_STATUS_H
#define _ADATA_ADMXRC2_STATUS_H

/*
** Base value for error status codes
*/
#define ADMXRC2_STATUS_ERROR_CODE  (0x1000)

/*
** Status and error codes
*/
typedef enum _ADMXRC2_STATUS
{
    ADMXRC2_SUCCESS             = 0,

    /* An error in the API logic occurred */
    ADMXRC2_INTERNAL_ERROR      = ADMXRC2_STATUS_ERROR_CODE,

    /* Couldn't allocate memory required to complete operation */
    ADMXRC2_NO_MEMORY,

    /* Failed to open the card with specified CardID */
    ADMXRC2_CARD_NOT_FOUND,

    /* Failed to open bitstream file */
    ADMXRC2_FILE_NOT_FOUND,

    /* The bitstream file appears to be corrupt */
    ADMXRC2_INVALID_FILE,

    /* The bitstream file does not match the FPGA on the card */
    ADMXRC2_FPGA_MISMATCH,

    /* The handle to the card passed was invalid */
    ADMXRC2_INVALID_HANDLE,

    /* The operation was not completed within the timeout period */
    ADMXRC2_TIMEOUT,

    /* Card could not be opened because it was already open */
    ADMXRC2_CARD_BUSY,

    /* An invalid parameter was supplied to the call */
    ADMXRC2_INVALID_PARAMETER,

    /* The card was closed before the operation was completed */
    ADMXRC2_CLOSED,

    /* A hardware error occurred on the card */
    ADMXRC2_CARD_ERROR,

    /* An operation was requested which is not supported or implemented */
    ADMXRC2_NOT_SUPPORTED,

    /* The requested device or resource was in use */
    ADMXRC2_DEVICE_BUSY,

    /* The DMA descriptor passed was invalid */
    ADMXRC2_INVALID_DMADESC,

    /* No free DMA descriptors left */
    ADMXRC2_NO_DMADESC,

    /* The operation failed */
    ADMXRC2_FAILED,

    /* The operation is still in progress */
    ADMXRC2_PENDING,

    /* The operation failed for reasons unknown */
    ADMXRC2_UNKNOWN_ERROR,

    /* A null pointer was supplied in the call */
    ADMXRC2_NULL_POINTER,

    /* The operation was cancelled because requesting thread terminated */
    ADMXRC2_CANCELLED,

    /* The driver revision level is too low */
    ADMXRC2_BAD_DRIVER,

    ADMXRC_STATUS_32BITS = 0x7FFFFFFF
} ADMXRC2_STATUS;

#define ADMXRC2_IS_ERROR(Status) ((Status) >= ADMXRC2_STATUS_ERROR_CODE)

#endif

