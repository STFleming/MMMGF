/*
** struct.h - structures and types used in ADM-XRC API calls
**
** (C) Copyright 2000-2007 Alpha Data Ltd.
**
** Do not #include this file in an application - #include <admxrc2.h> instead.
*/

#ifndef _ADATA_ADMXRC2_STRUCT_H
#define _ADATA_ADMXRC2_STRUCT_H

/*
** Handle to a card
*/
typedef int ADMXRC2_HANDLE;
#define ADMXRC2_HANDLE_INVALID_VALUE (-1)

/*
** A type that holds a Card ID
*/
typedef unsigned long ADMXRC2_CARDID;

/*
** Card enumeration function type
*/
typedef void (*ADMXRC2_ENUM_FUNCTION)(unsigned int index, ADMXRC2_HANDLE card);

/*
** Handle to a DMA descriptor
*/
typedef unsigned long ADMXRC2_DMADESC;

/*
** FPGA bitstream image
*/
typedef void* ADMXRC2_IMAGE;

/*
** Error handler function type
*/
typedef void (*ADMXRC2_ERROR_HANDLER)(const char* FnName, ADMXRC2_STATUS Status);

/*
** DMA direction options
*/
typedef enum _ADMXRC2_DMADIR
{
    ADMXRC2_PCITOLOCAL    = 0,
    ADMXRC2_LOCALTOPCI    = 1,
    ADMXRC2_DMADIR_32BITS = 0x7FFFFFFF
} ADMXRC2_DMADIR;

/*
** Bus width value
*/
typedef enum _ADMXRC2_IOWIDTH
{
    ADMXRC2_IOWIDTH_8      = 0,
    ADMXRC2_IOWIDTH_16     = 1,
    ADMXRC2_IOWIDTH_32     = 2,
    ADMXRC2_IOWIDTH_64     = 3,
    ADMXRC2_IOWIDTH_32BITS = 0x7FFFFFFF
} ADMXRC2_IOWIDTH;

/*
** Misc DMA mode options for ADMXRC2_BuildDmaModeWord()
*/
#define ADMXRC2_DMAMODE_IGNOREREADY     (0x0 << 6)      /* default */
#define ADMXRC2_DMAMODE_USEREADY        (0x1 << 6)
#define ADMXRC2_DMAMODE_IGNOREBTERM     (0x0 << 7)      /* default */
#define ADMXRC2_DMAMODE_USEBTERM        (0x1 << 7)
#define ADMXRC2_DMAMODE_BURSTDISABLE    (0x0 << 8)      /* default */
#define ADMXRC2_DMAMODE_BURSTENABLE     (0x1 << 8)
#define ADMXRC2_DMAMODE_INCREMENTLOCAL  (0x0 << 11)     /* default */
#define ADMXRC2_DMAMODE_FIXEDLOCAL      (0x1 << 11)
#define ADMXRC2_DMAMODE_NONDEMAND       (0x0 << 12)     /* default */
#define ADMXRC2_DMAMODE_DEMAND          (0x1 << 12)
#define ADMXRC2_DMAMODE_IGNOREEOT       (0x0 << 14)     /* default */
#define ADMXRC2_DMAMODE_USEEOT          (0x1 << 14)

/*
** This special value for a DMA channel allows a DMA transfer
** to take place on the first free DMA channel.
*/
#define ADMXRC2_DMACHAN_ANY (0xFFU)

/*
** ADMXRC2_DoDMA() flags
*/
#define ADMXRC2_DMAFLAG_CANQUEUE	(0x0 << 0)      /* default */
#define ADMXRC2_DMAFLAG_DONOTQUEUE	(0x1 << 0)
#define ADMXRC2_DMAFLAG_TIMEOUT         (2)

/*
** Flags for ADMXRC2_Read and ADMXRC2_Write
*/
#define ADMXRC2_IOFIXED	  (1 << 0)
#define ADMXRC2_IOLOCAL	  (0 << 0) /* default */
#define ADMXRC2_IOADAPTER (1 << 1)

/*
** FPGA Type
*/
typedef enum _ADMXRC2_FPGA_TYPE
{
  ADMXRC2_FPGA_RESVD0      = 0,
  ADMXRC2_FPGA_RESVD1      = 1,
  ADMXRC2_FPGA_RESVD2      = 2,
  ADMXRC2_FPGA_RESVD3      = 3,
  ADMXRC2_FPGA_V1000       = 4,
  ADMXRC2_FPGA_V400        = 5,
  ADMXRC2_FPGA_V600        = 6,
  ADMXRC2_FPGA_V800        = 7,
  ADMXRC2_FPGA_V2000E      = 8,
  ADMXRC2_FPGA_V1000E      = 9,
  ADMXRC2_FPGA_V1600E      = 10,
  ADMXRC2_FPGA_V3200E      = 11,
  ADMXRC2_FPGA_V812E       = 12,
  ADMXRC2_FPGA_V405E       = 13,
  ADMXRC2_FPGA_RESVD14     = 14,
  ADMXRC2_FPGA_RESVD15     = 15,
  ADMXRC2_FPGA_RESVD16     = 16,
  ADMXRC2_FPGA_RESVD17     = 17,
  ADMXRC2_FPGA_RESVD18     = 18,
  ADMXRC2_FPGA_RESVD19     = 19,
  ADMXRC2_FPGA_RESVD20     = 20,
  ADMXRC2_FPGA_RESVD21     = 21,
  ADMXRC2_FPGA_RESVD22     = 22,
  ADMXRC2_FPGA_RESVD23     = 23,
  ADMXRC2_FPGA_RESVD24     = 24,
  ADMXRC2_FPGA_RESVD25     = 25,
  ADMXRC2_FPGA_RESVD26     = 26,
  ADMXRC2_FPGA_RESVD27     = 27,
  ADMXRC2_FPGA_RESVD28     = 28,
  ADMXRC2_FPGA_RESVD29     = 29,
  ADMXRC2_FPGA_RESVD30     = 30,
  ADMXRC2_FPGA_RESVD31     = 31,
  ADMXRC2_FPGA_2V1000      = 32,
  ADMXRC2_FPGA_2V1500      = 33,
  ADMXRC2_FPGA_2V2000      = 34,
  ADMXRC2_FPGA_2V3000      = 35,
  ADMXRC2_FPGA_2V4000      = 36,
  ADMXRC2_FPGA_2V6000      = 37,
  ADMXRC2_FPGA_2V8000      = 38,
  ADMXRC2_FPGA_2V10000     = 39,
  ADMXRC2_FPGA_RESVD40     = 40,
  ADMXRC2_FPGA_RESVD41     = 41,
  ADMXRC2_FPGA_RESVD42     = 42,
  ADMXRC2_FPGA_RESVD43     = 43,
  ADMXRC2_FPGA_RESVD44     = 44,
  ADMXRC2_FPGA_RESVD45     = 45,
  ADMXRC2_FPGA_RESVD46     = 46,
  ADMXRC2_FPGA_RESVD47     = 47,
  ADMXRC2_FPGA_RESVD48     = 48,
  ADMXRC2_FPGA_RESVD49     = 49,
  ADMXRC2_FPGA_RESVD50     = 50,
  ADMXRC2_FPGA_RESVD51     = 51,
  ADMXRC2_FPGA_RESVD52     = 52,
  ADMXRC2_FPGA_RESVD53     = 53,
  ADMXRC2_FPGA_RESVD54     = 54,
  ADMXRC2_FPGA_RESVD55     = 55,
  ADMXRC2_FPGA_RESVD56     = 56,
  ADMXRC2_FPGA_RESVD57     = 57,
  ADMXRC2_FPGA_RESVD58     = 58,
  ADMXRC2_FPGA_RESVD59     = 59,
  ADMXRC2_FPGA_RESVD60     = 60,
  ADMXRC2_FPGA_RESVD61     = 61,
  ADMXRC2_FPGA_RESVD62     = 62,
  ADMXRC2_FPGA_RESVD63     = 63,
  ADMXRC2_FPGA_2VP2        = 64,
  ADMXRC2_FPGA_2VP4        = 65,
  ADMXRC2_FPGA_2VP7        = 66,
  ADMXRC2_FPGA_2VP20       = 67,
  ADMXRC2_FPGA_2VP30       = 68,
  ADMXRC2_FPGA_2VP40       = 69,
  ADMXRC2_FPGA_2VP50       = 70,
  ADMXRC2_FPGA_2VP100      = 71,
  ADMXRC2_FPGA_2VP125      = 72,
  ADMXRC2_FPGA_2VP70       = 73,
  ADMXRC2_FPGA_RESVD74     = 74,
  ADMXRC2_FPGA_RESVD75     = 75,
  ADMXRC2_FPGA_RESVD76     = 76,
  ADMXRC2_FPGA_RESVD77     = 77,
  ADMXRC2_FPGA_RESVD78     = 78,
  ADMXRC2_FPGA_RESVD79     = 79,
  ADMXRC2_FPGA_RESVD80     = 80,
  ADMXRC2_FPGA_RESVD81     = 81,
  ADMXRC2_FPGA_RESVD82     = 82,
  ADMXRC2_FPGA_RESVD83     = 83,
  ADMXRC2_FPGA_RESVD84     = 84,
  ADMXRC2_FPGA_RESVD85     = 85,
  ADMXRC2_FPGA_RESVD86     = 86,
  ADMXRC2_FPGA_RESVD87     = 87,
  ADMXRC2_FPGA_RESVD88     = 88,
  ADMXRC2_FPGA_RESVD89     = 89,
  ADMXRC2_FPGA_RESVD90     = 90,
  ADMXRC2_FPGA_RESVD91     = 91,
  ADMXRC2_FPGA_RESVD92     = 92,
  ADMXRC2_FPGA_RESVD93     = 93,
  ADMXRC2_FPGA_RESVD94     = 94,
  ADMXRC2_FPGA_RESVD95     = 95,
  ADMXRC2_FPGA_4VLX15      = 96,
  ADMXRC2_FPGA_4VLX25      = 97,
  ADMXRC2_FPGA_4VLX40      = 98,
  ADMXRC2_FPGA_4VLX60      = 99,
  ADMXRC2_FPGA_4VLX100     = 100,
  ADMXRC2_FPGA_4VLX160     = 101,
  ADMXRC2_FPGA_4VLX200     = 102,
  ADMXRC2_FPGA_4VLX80      = 103,
  ADMXRC2_FPGA_4VSX25      = 104,
  ADMXRC2_FPGA_4VSX35      = 105,
  ADMXRC2_FPGA_4VSX55      = 106,
  ADMXRC2_FPGA_RESVD107    = 107,
  ADMXRC2_FPGA_RESVD108    = 108,
  ADMXRC2_FPGA_RESVD109    = 109,
  ADMXRC2_FPGA_RESVD110    = 110,
  ADMXRC2_FPGA_RESVD111    = 111,
  ADMXRC2_FPGA_4VFX12      = 112,
  ADMXRC2_FPGA_4VFX20      = 113,
  ADMXRC2_FPGA_4VFX40      = 114,
  ADMXRC2_FPGA_4VFX60      = 115,
  ADMXRC2_FPGA_4VFX100     = 116,
  ADMXRC2_FPGA_4VFX140     = 117,
  ADMXRC2_FPGA_RESVD118    = 118,
  ADMXRC2_FPGA_RESVD119    = 119,
  ADMXRC2_FPGA_RESVD120    = 120,
  ADMXRC2_FPGA_RESVD121    = 121,
  ADMXRC2_FPGA_RESVD122    = 122,
  ADMXRC2_FPGA_RESVD123    = 123,
  ADMXRC2_FPGA_RESVD124    = 124,
  ADMXRC2_FPGA_RESVD125    = 125,
  ADMXRC2_FPGA_RESVD126    = 126,
  ADMXRC2_FPGA_RESVD127    = 127,
  ADMXRC2_FPGA_5VLX30      = 128,
  ADMXRC2_FPGA_5VLX50      = 129,
  ADMXRC2_FPGA_5VLX85      = 130,
  ADMXRC2_FPGA_5VLX110     = 131,
  ADMXRC2_FPGA_5VLX220     = 132,
  ADMXRC2_FPGA_5VLX330     = 133,
  ADMXRC2_FPGA_RESVD134    = 134,
  ADMXRC2_FPGA_RESVD135    = 135,
  ADMXRC2_FPGA_5VLX30T     = 136,
  ADMXRC2_FPGA_5VLX50T     = 137,
  ADMXRC2_FPGA_5VLX85T     = 138,
  ADMXRC2_FPGA_5VLX110T    = 139,
  ADMXRC2_FPGA_5VLX330T    = 140,
  ADMXRC2_FPGA_5VLX220T    = 141,
  ADMXRC2_FPGA_5VLX155T    = 142,
  ADMXRC2_FPGA_RESVD143    = 143,
  ADMXRC2_FPGA_5VSX35T     = 144,
  ADMXRC2_FPGA_5VSX50T     = 145,
  ADMXRC2_FPGA_5VSX95T     = 146,
  ADMXRC2_FPGA_5VSX240T    = 147,
  ADMXRC2_FPGA_RESVD148    = 148,
  ADMXRC2_FPGA_RESVD149    = 149,
  ADMXRC2_FPGA_RESVD150    = 150,
  ADMXRC2_FPGA_RESVD151    = 151,
  ADMXRC2_FPGA_5VFX100T    = 152,
  ADMXRC2_FPGA_5VFX130T    = 153,
  ADMXRC2_FPGA_5VFX200T    = 154,
  ADMXRC2_FPGA_5VFX30T     = 155,
  ADMXRC2_FPGA_5VFX70T     = 156,
  ADMXRC2_FPGA_UNKNOWN     = 157,
  ADMXRC2_FPGA_FORCE32BITS = 0x7FFFFFFFU
} ADMXRC2_FPGA_TYPE;

/*
** In this interface, programmable clocks are referred to by
** an index.
**
** Index 0 always corresponds to the local bus clock
*/
#define ADMXRC2_CLOCK_LCLK	(0)

/*
** ADM-XRC board types, used in ADMXRC2_CARD_INFO2::BoardType
*/
typedef enum _ADMXRC2_BOARD_TYPE {
  ADMXRC2_BOARD_ADMXRC             = 0,  /* ADM-XRC           */
  ADMXRC2_BOARD_ADMXRC_P           = 1,  /* ADM-XRC-P         */
  ADMXRC2_BOARD_ADMXRC2L           = 2,  /* ADM-XRC-II-Lite   */
  ADMXRC2_BOARD_ADMXRC2            = 3,  /* ADM-XRC-II        */
  ADMXRC2_BOARD_ADMXP              = 4,  /* ADM-XP            */
  ADMXRC2_BOARD_ADMXPL             = 5,  /* ADM-XPL           */
  ADMXRC2_BOARD_ADPWRC2            = 6,  /* ADP-WRC-II        */
  ADMXRC2_BOARD_ADPDRC2            = 7,  /* ADP-DRC-II        */
  ADMXRC2_BOARD_ADPXPI             = 8,  /* ADP-XPI           */
  ADMXRC2_BOARD_ADMXRC4LS          = 9,  /* ADM-XRC-4LS       */
  ADMXRC2_BOARD_ADMXRC4LX          = 10, /* ADM-XRC-4LX       */
  ADMXRC2_BOARD_ADMXRC4SX          = 11, /* ADM-XRC-4SX       */
  ADMXRC2_BOARD_ADPEXRC4FX         = 12, /* ADPE-XRC-4FX      */
  ADMXRC2_BOARD_ADMXRC4FX          = 13, /* ADM-XRC-4FX       */
  ADMXRC2_BOARD_ADMXRC5LX          = 14, /* ADM-XRC-5LX       */
  ADMXRC2_BOARD_ADMXRC5T1          = 15, /* ADM-XRC-5T1       */
  ADMXRC2_BOARD_ADMXRC5T2          = 16, /* ADM-XRC-5T2       */
  ADMXRC2_BOARD_ADCPXRC4LX         = 17, /* ADCP-XRC-4LX      */
  ADMXRC2_BOARD_ADMAMC5A2          = 18, /* ADM-AMC-5A2       */
  ADMXRC2_BOARD_ADMXRC5TZ          = 19, /* ADM-XRC-5TZ       */
  ADMXRC2_BOARD_ADCBBP             = 20, /* ADC-BBP           */
  ADMXRC2_BOARD_ADMXRC5T2ADV       = 21, /* ADM-XRC-5T2-ADV   */
  ADMXRC2_BOARD_ADMXRC5TDA1        = 22, /* ADM-XRC-5T-DA1    */
  ADMXRC2_BOARD_UNKNOWN            = 23,
  ADMXRC2_BOARD_TYPE_32BITS        = 0x7FFFFFFF
} ADMXRC2_BOARD_TYPE;

/* The following are depreciated synonyms of certain model names */
#define ADMXRC2_BOARD_ADMXRC2_LITE (ADMXRC2_BOARD_ADMXRC2L)
#define ADMXRC2_BOARD_ADPXRC2_N (ADMXRC2_BOARD_ADPWRC2)
#define ADMXRC2_BOARD_ADPXRC2_EMP (ADMXRC2_BOARD_ADPDRC2)
#define ADMXRC2_BOARD_ADMXRC2_PRO (ADMXRC2_BOARD_ADMXP)
#define ADMXRC2_BOARD_ADMXRC2_PRO_LITE (ADMXRC2_BOARD_ADMXPL)
#define ADMXRC2_BOARD_ADMXRC4_LITE (ADMXRC2_BOARD_ADMXRC4LS)
#define ADMXRC2_BOARD_ADPEDEV (ADMXRC2_BOARD_ADPEXRC4FX)

/*
** Card information structure
*/
typedef struct _ADMXRC2_CARD_INFO
{
  ADMXRC2_CARDID           CardID;           /* ID of card                               */
  uint32_t                 SerialNum;        /* serial number of card                    */
  ADMXRC2_BOARD_TYPE       BoardType;        /* type of card                             */
  ADMXRC2_FPGA_TYPE        FPGAType;         /* type of FPGA fitted                      */
  unsigned long            NumClock;         /* number of programmable clocks            */
  unsigned long            NumDMAChan;       /* number of DMA channels                   */
  unsigned long            NumRAMBank;       /* number of RAM banks (fitted or not)      */
  unsigned long            NumSpace;         /* number of spaces                         */
  uint32_t                 RAMBanksFitted;   /* bitmap of banks fitted (max 32 banks)    */
  uint8_t                  BoardRevision;    /* board rev, 0xab, a = major, b = minor    */
  uint8_t                  LogicRevision;    /* logic rev, 0xab, a = major, b = minor    */
} ADMXRC2_CARD_INFO;

/*
** RAM type flags, used in ADMXRC2_BANK_INFO::Type bitmask
*/
#define ADMXRC2_RAM_ZBTFT      (0x1U << 0)   /* ZBT flowthrough        */
#define ADMXRC2_RAM_ZBTP       (0x1U << 1)   /* ZBT pipelined          */
#define ADMXRC2_RAM_SDRAM_DDR  (0x1U << 2)   /* DDR SDRAM              */
#define ADMXRC2_RAM_SRAM_DDR2  (0x1U << 3)   /* DDR-II SRAM            */
#define ADMXRC2_RAM_SDRAM_SDR  (0x1U << 4)   /* SDR SDRAM              */
#define ADMXRC2_RAM_SDRAM_DDR2 (0x1U << 5)   /* DDR-II SDRAM           */

/*
** RAM bank information structure
*/
typedef struct _ADMXRC2_BANK_INFO {
  unsigned long      Type;      /* bitmask of RAM mode(s) supported      */
  unsigned long      Width;     /* in bits, valid whether fitted or not  */
  unsigned long      Size;      /* in words, valid whether fitted or not */
  int                Fitted;    /* TRUE if present (fitted to card)      */
} ADMXRC2_BANK_INFO;

/*
** FPGA information structure
*/
typedef struct _ADMXRC2_FPGA_INFO
{
  ADMXRC2_FPGA_TYPE        Type;             /* Device; see ADMXRC2_FPGA_TYPE                     */
  char                     Package[32];      /* package as a string, e.g. "FF1738"                */
  int                      Speed;            /* speed grade, or -1 if not known                   */
  int                      Stepping;         /* stepping level, or -1 if not known                */
  int                      Industrial;       /* 1 => industrial, 0 => commerical, -1 => not known */
  int                      SCD;              /* SCD, or -1 if not known                           */
} ADMXRC2_FPGA_INFO;

/*
** Structure returning version information
*/
typedef struct _ADMXRC2_VERSION_INFO {
  uint8_t DriverMinor;
  uint8_t DriverMajor;
  uint8_t APIMinor;
  uint8_t APIMajor;
} ADMXRC2_VERSION_INFO;

/*
** A structure used to map a user buffer for Direct Master
** access by the FPGA.
*/
typedef struct _ADMXRC2_BUFFERMAP {
  unsigned long  MaxPages;        /* User initialises to length of PCI address buffer      */
  uint32_t*      PagesPci;        /* User initialises to point to PCI address buffer       */
  unsigned long  PageLength;      /* Receives size in bytes of a page                      */
  unsigned long  PageBits;        /* Number of bits representing a page offset             */
  unsigned long  PagesSpanned;    /* Receives number of pages spanned                      */
  unsigned long  BytesSpanned;    /* Receives number of bytes spanned                      */
  unsigned long  InitOffset;      /* Receives page offset within 1st page of start of span */
} ADMXRC2_BUFFERMAP;

/*
** Type of syncing to be done by ADMXRC2_SyncDirectMaster()
*/
typedef enum _ADMXRC2_SYNCMODE
{
  ADMXRC2_SYNC_CPUTOFPGA = 0x1,    /* CPU has set up buffer for FPGA to access */
  ADMXRC2_SYNC_FPGATOCPU = 0x2,    /* FPGA has modified buffer                 */
  ADMXRC2_SYNC_32BITS    = 0x7FFFFFFF
} ADMXRC2_SYNCMODE;

typedef struct _ADMXRC2_SPACE_INFO
{
  void*         VirtualBase;      /* Application space window         */
  unsigned long VirtualSize;	    /* Size of application space window	*/
  unsigned long PhysicalBase;	    /* Host I/O bus address             */
  unsigned long LocalBase;        /* Local bus address                */
  unsigned long LocalSize;        /* Size in bytes of local bus space	*/
} ADMXRC2_SPACE_INFO;

/*
** Flags applicable to ADMXRC2_GetSpaceConfig() and
** ADMXRC2_SetSpaceConfig()
*/
#define ADMXRC2_SPACE_SET_WIDTH            (0x1U << 0)
#define ADMXRC2_SPACE_MASK_WIDTH           (0x7U << 1)
#define ADMXRC2_SPACE_WIDTH_DEFAULT        (0x0U << 5)
#define ADMXRC2_SPACE_WIDTH_8              (0x1U << 1)
#define ADMXRC2_SPACE_WIDTH_16             (0x2U << 1)
#define ADMXRC2_SPACE_WIDTH_32             (0x3U << 1)
#define ADMXRC2_SPACE_WIDTH_64             (0x4U << 1)

#define ADMXRC2_SPACE_SET_PREFETCH         (0x1U << 4)
#define ADMXRC2_SPACE_MASK_PREFETCH        (0x7U << 5)
#define ADMXRC2_SPACE_PREFETCH_DEFAULT     (0x0U << 5)
#define ADMXRC2_SPACE_PREFETCH_MINIMUM     (0x1U << 5)
#define ADMXRC2_SPACE_PREFETCH_NORMAL      (0x2U << 5)
#define ADMXRC2_SPACE_PREFETCH_MAXIMUM     (0x3U << 5)

#define ADMXRC2_SPACE_SET_BURST            (0x1U << 8)
#define ADMXRC2_SPACE_MASK_BURST           (0x7U << 9)
#define ADMXRC2_SPACE_BURST_DEFAULT        (0x0U << 9)
#define ADMXRC2_SPACE_BURST_DISABLED       (0x1U << 9)
#define ADMXRC2_SPACE_BURST_ENABLED        (0x2U << 9)

#endif
