/* 
**  File      plx.h
**  Title     PLX Header File for PCI9080 and ADM-XRC Registers
**  Version   1.1
**  Date      JUL-99
**  (C) Copyright  Alpha Data Parallel Systems Ltd. 1999-2001
*/

#ifndef _ADATA_ADMXRC2_PLX_H
#define _ADATA_ADMXRC2_PLX_H

#define EE_ADDR_MASK   0x003f  /* for combining addresses with instructions */
#define EE_CMD_LEN     9       /* bits in instructions */
#define EE_READ        0x0180  /* 01 1000 0000 read instruction */
#define EE_WRITE       0x0140  /* 01 0100 0000 write instruction */
#define EE_WREN        0x0130  /* 01 0011 0000 write enable instruction */
#define EE_WRALL       0x0110  /* 01 0001 0000 write all registers */
#define EE_PRREAD      0x0180  /* 01 1000 0000 reads address stored in
                                  Protect Register */
#define EE_PRWRITE     0x0140  /* 01 0100 0000 write address into PR */
#define EE_WDS         0x0100  /* 01 0000 0000 write disable instruction */
#define EE_PREN        0x0130  /* 01 0011 0000 protect enable instruction */
#define EE_PRCLEAR     0x01FF  /* 01 1111 1111 clear protect register instr */
#define EE_PRDS        0x0100  /* 01 0000 0000 ONE TIME ONLY, permenant change */

#define PLX_CNTRL_GPO		(1<<16)
#define PLX_CNTRL_GPI		(1<<17)
#define PLX_CNTRL_RST		(1<<30)

#define INTCSR_PCI_IE		(1<<8)
#define INTCSR_DB_IE		(1<<9)
#define INTCSR_LOC_IE		(1<<11)
#define INTCSR_DMA0_IE	(1<<18)
#define INTCSR_DMA1_IE	(1<<19)

#define INTCSR_LOC_INT	(1<<15)
#define INTCSR_DMA0_INT	(1<<21)
#define INTCSR_DMA1_INT	(1<<22)

#define DMACSR_ENABLE		(1<<0)
#define DMACSR_START		(1<<1)
#define DMACSR_ABORT		(1<<2)
#define DMACSR_CLRINT		(1<<3)
#define DMACSR_DONE			(1<<4)

#define FCON_PROG	(1<<0)
#define FCON_INIT	(1<<1)
#define FCON_DONE	(1<<2)

typedef struct _CONTROLXRC
{
	UCHAR	FCON;
	UCHAR	CCON;
	UCHAR	IMSET;
	UCHAR	IMCLR;
	UCHAR	ICON;
	UCHAR	PSTAT;
	UCHAR	RES6;
	UCHAR	RES7;
	UCHAR	SELECTMAP;
} CONTROLXRC, *PCONTROLXRC;

struct _DMACON
{
  ULONG   MODE;
  ULONG   PADR;
  ULONG   LADR;
  ULONG   SIZE;
  ULONG   DPR;
};
typedef struct _DMACON DMACON;

typedef struct _REGISTER_BASE 
{
  ULONG   LAS0RR;       /*  00 */
  ULONG   LAS0BA;       /*  04 */
  ULONG   MARBR;        /*  08 */
  ULONG   BIGEND;       /*  0C */
  ULONG   EROMRR;       /*  10 */
  ULONG   EROMBA;       /*  14 */
  ULONG   LBRD0;        /*  18 */
  ULONG   DMRR;         /*  1C */
  ULONG   DMLBAM;       /*  20 */
  ULONG   DMLBAI;       /*  24 */
  ULONG   DMPBAM;       /*  28 */
  ULONG   DMCFGA;       /*  2C */

  ULONG   OPLFIS;       /*  30 */
  ULONG   OPLFIM;       /*  34 */
  ULONG   RES38;        /*  38 */
  ULONG   RES3C;        /*  3C */

  ULONG   MAILBOX[8];   /*  40-5F */
  ULONG   P2LDBELL;     /*  60 */
  ULONG   L2PDBELL;     /*  64 */
  ULONG   INTCSR;       /*  68 */
  ULONG   CNTRL;        /*  6C */
  ULONG   PCIHDR;       /*  70 */
  USHORT  PCIHREV;      /*  74 */
  USHORT  RES76;        /*  76 */

  ULONG   MBOX0;        /*  78  always present */
  ULONG   MBOX1;        /*  7C  always present */

  DMACON  DMA[2];       /*  80 */
  UCHAR   DMACSR[2];    /*  A8,A9 */
  UCHAR   RESAA,RESAB;  /*  AA,AB */
  ULONG   DMAARB;       /*  AC */
  ULONG   DMATHR;       /*  B0 */
  ULONG   RESB4[3];     /*  B4,B8,BC */

  ULONG   MQCR;         /*  C0 */
  ULONG   QBAR;         /*  C4 */
  ULONG   IFHPR;        /*  C8 */
  ULONG   IFTPR;        /*  CC */
  ULONG   IPHPR;        /*  D0 */
  ULONG   IPTPR;        /*  D4 */
  ULONG   OFHPR;        /*  D8 */
  ULONG   OFTPR;        /*  DC */
  ULONG   OPHPR;        /*  E0 */
  ULONG   OPTPR;        /*  E4 */
  ULONG   QSR;          /*  E8 */
  ULONG   RESEC;        /*  EC */
  
  ULONG   LAS1RR;       /*  F0 */
  ULONG   LAS1BA;       /*  F4 */
  ULONG   LBRD1;        /*  F8 */

} REGISTER_BASE, *PREGISTER_BASE;

typedef struct _REGISTER_BASE ADMXRC_PLX;

/************************************************************************/
/*              PCI9080 next DMA ptr bit definitions                    */
/************************************************************************/

#define PLXDESCF_LOCAL			(0<<0)
#define PLXDESCF_PCI			(1<<0)
#define PLXDESCF_ENDCHAIN		(1<<1)
#define PLXDESCF_INTERRUPT		(1<<2)
#define PLXDESCF_PCI2LOC		(0<<3)
#define PLXDESCF_LOC2PCI		(1<<3)

/************************************************************************/
/*  PCI9080 Chaining DMA Descriptor format which is similar to          */
/*  the internal registers of the device.                               */
/*                                                                      */
/*  Format of "next" is                                                 */
/*  Bit   value   function                                              */
/*    0     0     Descriptors are in local memory                       */
/*          1     Descriptors are in PCI memory                         */
/*    1     0     fetch next descriptor                                 */
/*          1     this is the last in the chain                         */
/*    2     0     no interrupt                                          */
/*          1     interrupt on completion of chain                      */
/*    3     0     direction is from PCI to local                        */
/*          1     direction is from local to PCI                        */
/* 31:4           the base address of the next descriptor quad aligned  */
/************************************************************************/

typedef struct _PLXDESC {
  ULONG   pci;
  ULONG   local;
  ULONG   count;
  ULONG   link;
} PLXDESC;

#endif /* _ADATA_ADMXRC2_PLX_H */
