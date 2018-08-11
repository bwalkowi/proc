// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2_70 TOP LEVEL 
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
//   V1.1 :| Johnny FAN        :| 07/07/09  :| 1.change fpga device from 
//                                               ep2c70896c8 to ep2c70896c6
//											   2.change module name from DE2P_TOP
//                                               to DE2_70_TOP		
//   V1.2 :| Johnny FAN        :| 07/07/09  :| 1. change for pcb v1.1
//											   2. modify PS2 interface i/o
//											   3. modify GPIO,VGA, and UART interface
//										  		  pin assignment
//											   4. change GPIO_CLKOUT from output to inout
//   V1.21 :| Johnny FAN       :| 07/07/09  :| 1.remove ssram address bus oSRAM_A[19]and oSRAM_A[20]
//											   2.remove flash address bus oFLASH_A[25:22]		
// --------------------------------------------------------------------

module DE2_70_TOP
	(
		////////////////////	Clock Input	 	////////////////////	 
		iCLK_28,						//  28.63636 MHz
		iCLK_50,						//	50 MHz
		iCLK_50_2,						//	50 MHz
		iCLK_50_3,						//	50 MHz
		iCLK_50_4,						//	50 MHz
		iEXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		iKEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		iSW,							//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		oHEX0_D,						//	Seven Segment Digit 0
		oHEX0_DP,						//  Seven Segment Digit 0 decimal point
		oHEX1_D,						//	Seven Segment Digit 1
		oHEX1_DP,						//  Seven Segment Digit 1 decimal point
		oHEX2_D,						//	Seven Segment Digit 2
		oHEX2_DP,						//  Seven Segment Digit 2 decimal point
		oHEX3_D,						//	Seven Segment Digit 3
		oHEX3_DP,						//  Seven Segment Digit 3 decimal point
		oHEX4_D,						//	Seven Segment Digit 4
		oHEX4_DP,						//  Seven Segment Digit 4 decimal point
		oHEX5_D,						//	Seven Segment Digit 5
		oHEX5_DP,						//  Seven Segment Digit 5 decimal point
		oHEX6_D,						//	Seven Segment Digit 6
		oHEX6_DP,						//  Seven Segment Digit 6 decimal point
		oHEX7_D,						//	Seven Segment Digit 7
		oHEX7_DP,						//  Seven Segment Digit 7 decimal point
		////////////////////////	LED		////////////////////////
		oLEDG,							//	LED Green[8:0]
		oLEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		oUART_TXD,						//	UART Transmitter
		iUART_RXD,						//	UART Receiver
		oUART_CTS,          			//	UART Clear To Send
		iUART_RTS,          			//	UART Requst To Send
		////////////////////////	IRDA	////////////////////////
		oIRDA_TXD,						//	IRDA Transmitter
		iIRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 32 Bits
		oDRAM0_A,						//	SDRAM0 Address bus 13 Bits
		oDRAM1_A,						//	SDRAM1 Address bus 13 Bits
		oDRAM0_LDQM0,					//	SDRAM0 Low-byte Data Mask 
		oDRAM1_LDQM0,					//	SDRAM1 Low-byte Data Mask 
		oDRAM0_UDQM1,					//	SDRAM0 High-byte Data Mask
		oDRAM1_UDQM1,					//	SDRAM1 High-byte Data Mask
		oDRAM0_WE_N,					//	SDRAM0 Write Enable
		oDRAM1_WE_N,					//	SDRAM1 Write Enable
		oDRAM0_CAS_N,					//	SDRAM0 Column Address Strobe
		oDRAM1_CAS_N,					//	SDRAM1 Column Address Strobe
		oDRAM0_RAS_N,					//	SDRAM0 Row Address Strobe
		oDRAM1_RAS_N,					//	SDRAM1 Row Address Strobe
		oDRAM0_CS_N,					//	SDRAM0 Chip Select
		oDRAM1_CS_N,					//	SDRAM1 Chip Select
		oDRAM0_BA,						//	SDRAM0 Bank Address
		oDRAM1_BA,	 					//	SDRAM1 Bank Address
		oDRAM0_CLK,						//	SDRAM0 Clock
		oDRAM1_CLK,						//	SDRAM1 Clock
		oDRAM0_CKE,						//	SDRAM0 Clock Enable
		oDRAM1_CKE,						//	SDRAM1 Clock Enable
		////////////////////	Flash Interface		////////////////
		FLASH_DQ,						//	FLASH Data bus 15 Bits (0 to 14)
		FLASH_DQ15_AM1,					//  FLASH Data bus Bit 15 or Address A-1
		oFLASH_A,						//	FLASH Address bus 26 Bits
		oFLASH_WE_N,					//	FLASH Write Enable
		oFLASH_RST_N,					//	FLASH Reset
		oFLASH_WP_N,					//	FLASH Write Protect /Programming Acceleration 
		iFLASH_RY_N,					//	FLASH Ready/Busy output 
		oFLASH_BYTE_N,					//	FLASH Byte/Word Mode Configuration
		oFLASH_OE_N,					//	FLASH Output Enable
		oFLASH_CE_N,					//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data Bus 32 Bits
		SRAM_DPA, 						//  SRAM Parity Data Bus
		oSRAM_A,						//	SRAM Address bus 22 Bits
		oSRAM_ADSC_N,       			//	SRAM Controller Address Status 	
		oSRAM_ADSP_N,                   //	SRAM Processor Address Status
		oSRAM_ADV_N,                    //	SRAM Burst Address Advance
		oSRAM_BE_N,                     //	SRAM Byte Write Enable
		oSRAM_CE1_N,        			//	SRAM Chip Enable
		oSRAM_CE2,          			//	SRAM Chip Enable
		oSRAM_CE3_N,        			//	SRAM Chip Enable
		oSRAM_CLK,                      //	SRAM Clock
		oSRAM_GW_N,         			//  SRAM Global Write Enable
		oSRAM_OE_N,         			//	SRAM Output Enable
		oSRAM_WE_N,         			//	SRAM Write Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_D,							//	ISP1362 Data bus 16 Bits
		oOTG_A,							//	ISP1362 Address 2 Bits
		oOTG_CS_N,						//	ISP1362 Chip Select
		oOTG_OE_N,						//	ISP1362 Read
		oOTG_WE_N,						//	ISP1362 Write
		oOTG_RESET_N,					//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		iOTG_INT0,						//	ISP1362 Interrupt 0
		iOTG_INT1,						//	ISP1362 Interrupt 1
		iOTG_DREQ0,						//	ISP1362 DMA Request 0
		iOTG_DREQ1,						//	ISP1362 DMA Request 1
		oOTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		oOTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		oLCD_ON,						//	LCD Power ON/OFF
		oLCD_BLON,						//	LCD Back Light ON/OFF
		oLCD_RW,						//	LCD Read/Write Select, 0 = Write, 1 = Read
		oLCD_EN,						//	LCD Enable
		oLCD_RS,						//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_D,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		oSD_CLK,						//	SD Card Clock
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		oI2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_KBDAT,						//	PS2 Keyboard Data
		PS2_KBCLK,						//	PS2 Keyboard Clock		
		PS2_MSDAT,						//	PS2 Mouse Data
		PS2_MSCLK,						//	PS2 Mouse Clock
		////////////////////	VGA		////////////////////////////
		oVGA_CLOCK,   					//	VGA Clock
		oVGA_HS,						//	VGA H_SYNC
		oVGA_VS,						//	VGA V_SYNC
		oVGA_BLANK_N,					//	VGA BLANK
		oVGA_SYNC_N,					//	VGA SYNC
		oVGA_R,   						//	VGA Red[9:0]
		oVGA_G,	 						//	VGA Green[9:0]
		oVGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_D,						//	DM9000A DATA bus 16Bits
		oENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		oENET_CS_N,						//	DM9000A Chip Select
		oENET_IOW_N,					//	DM9000A Write
		oENET_IOR_N,					//	DM9000A Read
		oENET_RESET_N,					//	DM9000A Reset
		iENET_INT,						//	DM9000A Interrupt
		oENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		iAUD_ADCDAT,					//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		oAUD_DACDAT,					//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		oAUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		iTD1_CLK27,						//	TV Decoder1 Line_Lock Output Clock 
		iTD1_D,    					    //	TV Decoder1 Data bus 8 bits
		iTD1_HS,						//	TV Decoder1 H_SYNC
		iTD1_VS,						//	TV Decoder1 V_SYNC
		oTD1_RESET_N,					//	TV Decoder1 Reset
		iTD2_CLK27,						//	TV Decoder2 Line_Lock Output Clock 		
		iTD2_D,    					    //	TV Decoder2 Data bus 8 bits
		iTD2_HS,						//	TV Decoder2 H_SYNC
		iTD2_VS,						//	TV Decoder2 V_SYNC
		oTD2_RESET_N,					//	TV Decoder2 Reset
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0 I/O
		GPIO_CLKIN_N0,     				//	GPIO Connection 0 Clock Input 0
		GPIO_CLKIN_P0,          		//	GPIO Connection 0 Clock Input 1
		GPIO_CLKOUT_N0,     			//	GPIO Connection 0 Clock Output 0
		GPIO_CLKOUT_P0,                 //	GPIO Connection 0 Clock Output 1
		GPIO_1,							//	GPIO Connection 1 I/O
		GPIO_CLKIN_N1,                  //	GPIO Connection 1 Clock Input 0
		GPIO_CLKIN_P1,                  //	GPIO Connection 1 Clock Input 1
		GPIO_CLKOUT_N1,                 //	GPIO Connection 1 Clock Output 0
		GPIO_CLKOUT_P1                  //	GPIO Connection 1 Clock Output 1
	   
	);

//===========================================================================
// PARAMETER declarations
//===========================================================================


//===========================================================================
// PORT declarations
//===========================================================================
////////////////////////	Clock Input	 	////////////////////////
input			iCLK_28;				//  28.63636 MHz
input			iCLK_50;				//	50 MHz
input			iCLK_50_2;				//	50 MHz
input           iCLK_50_3;				//	50 MHz
input           iCLK_50_4;				//	50 MHz
input           iEXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	iKEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	iSW;					//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	oHEX0_D;				//	Seven Segment Digit 0
output			oHEX0_DP;				//  Seven Segment Digit 0 decimal point
output	[6:0]	oHEX1_D;				//	Seven Segment Digit 1
output			oHEX1_DP;				//  Seven Segment Digit 1 decimal point
output	[6:0]	oHEX2_D;				//	Seven Segment Digit 2
output			oHEX2_DP;				//  Seven Segment Digit 2 decimal point
output	[6:0]	oHEX3_D;				//	Seven Segment Digit 3
output			oHEX3_DP;				//  Seven Segment Digit 3 decimal point
output	[6:0]	oHEX4_D;				//	Seven Segment Digit 4
output			oHEX4_DP;				//  Seven Segment Digit 4 decimal point
output	[6:0]	oHEX5_D;				//	Seven Segment Digit 5
output			oHEX5_DP;				//  Seven Segment Digit 5 decimal point
output	[6:0]	oHEX6_D;				//	Seven Segment Digit 6
output			oHEX6_DP;				//  Seven Segment Digit 6 decimal point
output	[6:0]	oHEX7_D;				//	Seven Segment Digit 7
output			oHEX7_DP;				//  Seven Segment Digit 7 decimal point
////////////////////////////	LED		////////////////////////////
output	[8:0]	oLEDG;					//	LED Green[8:0]
output	[17:0]	oLEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			oUART_TXD;				//	UART Transmitter
input			iUART_RXD;				//	UART Receiver
output			oUART_CTS;          	//	UART Clear To Send
input			iUART_RTS;          	//	UART Requst To Send
////////////////////////////	IRDA	////////////////////////////
output			oIRDA_TXD;				//	IRDA Transmitter
input			iIRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[31:0]	DRAM_DQ;				//	SDRAM Data bus 32 Bits
output	[12:0]	oDRAM0_A;				//	SDRAM0 Address bus 13 Bits
output	[12:0]	oDRAM1_A;				//	SDRAM1 Address bus 13 Bits
output			oDRAM0_LDQM0;			//	SDRAM0 Low-byte Data Mask 
output			oDRAM1_LDQM0;			//	SDRAM1 Low-byte Data Mask 
output			oDRAM0_UDQM1;			//	SDRAM0 High-byte Data Mask
output			oDRAM1_UDQM1;			//	SDRAM1 High-byte Data Mask
output			oDRAM0_WE_N;			//	SDRAM0 Write Enable
output			oDRAM1_WE_N;			//	SDRAM1 Write Enable
output			oDRAM0_CAS_N;			//	SDRAM0 Column Address Strobe
output			oDRAM1_CAS_N;			//	SDRAM1 Column Address Strobe
output			oDRAM0_RAS_N;			//	SDRAM0 Row Address Strobe
output			oDRAM1_RAS_N;			//	SDRAM1 Row Address Strobe
output			oDRAM0_CS_N;			//	SDRAM0 Chip Select
output			oDRAM1_CS_N;			//	SDRAM1 Chip Select
output	[1:0]	oDRAM0_BA;				//	SDRAM0 Bank Address
output	[1:0]	oDRAM1_BA;		 		//	SDRAM1 Bank Address
output			oDRAM0_CLK;				//	SDRAM0 Clock
output			oDRAM1_CLK;				//	SDRAM1 Clock
output			oDRAM0_CKE;				//	SDRAM0 Clock Enable
output			oDRAM1_CKE;				//	SDRAM1 Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[14:0]	FLASH_DQ;				//	FLASH Data bus 15 Bits (0 to 14)
inout			FLASH_DQ15_AM1;			//  FLASH Data bus Bit 15 or Address A-1
output	[21:0]	oFLASH_A;				//	FLASH Address bus 22 Bits
output			oFLASH_WE_N;			//	FLASH Write Enable
output			oFLASH_RST_N;			//	FLASH Reset
output			oFLASH_WP_N;			//	FLASH Write Protect /Programming Acceleration 
input			iFLASH_RY_N;			//	FLASH Ready/Busy output 
output			oFLASH_BYTE_N;			//	FLASH Byte/Word Mode Configuration
output			oFLASH_OE_N;			//	FLASH Output Enable
output			oFLASH_CE_N;			//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[31:0]	SRAM_DQ;				//	SRAM Data Bus 32 Bits
inout	[3:0]	SRAM_DPA; 				//  SRAM Parity Data Bus
output	[18:0]	oSRAM_A;				//	SRAM Address bus 21 Bits
output			oSRAM_ADSC_N;       	//	SRAM Controller Address Status 	
output			oSRAM_ADSP_N;           //	SRAM Processor Address Status
output			oSRAM_ADV_N;            //	SRAM Burst Address Advance
output	[3:0]	oSRAM_BE_N;             //	SRAM Byte Write Enable
output			oSRAM_CE1_N;        	//	SRAM Chip Enable
output			oSRAM_CE2;          	//	SRAM Chip Enable
output			oSRAM_CE3_N;        	//	SRAM Chip Enable
output			oSRAM_CLK;              //	SRAM Clock
output			oSRAM_GW_N;         	//  SRAM Global Write Enable
output			oSRAM_OE_N;         	//	SRAM Output Enable
output			oSRAM_WE_N;         	//	SRAM Write Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	[15:0]	OTG_D;					//	ISP1362 Data bus 16 Bits
output	[1:0]	oOTG_A;					//	ISP1362 Address 2 Bits
output			oOTG_CS_N;				//	ISP1362 Chip Select
output			oOTG_OE_N;				//	ISP1362 Read
output			oOTG_WE_N;				//	ISP1362 Write
output			oOTG_RESET_N;			//	ISP1362 Reset
inout			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
inout			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			iOTG_INT0;				//	ISP1362 Interrupt 0
input			iOTG_INT1;				//	ISP1362 Interrupt 1
input			iOTG_DREQ0;				//	ISP1362 DMA Request 0
input			iOTG_DREQ1;				//	ISP1362 DMA Request 1
output			oOTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			oOTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	[7:0]	LCD_D;					//	LCD Data bus 8 bits
output			oLCD_ON;				//	LCD Power ON/OFF
output			oLCD_BLON;				//	LCD Back Light ON/OFF
output			oLCD_RW;				//	LCD Read/Write Select, 0 = Write, 1 = Read
output			oLCD_EN;				//	LCD Enable
output			oLCD_RS;				//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout			SD_DAT;					//	SD Card Data
inout			SD_DAT3;				//	SD Card Data 3
inout			SD_CMD;					//	SD Card Command Signal
output			oSD_CLK;				//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			oI2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
inout		 	PS2_KBDAT;				//	PS2 Keyboard Data
inout			PS2_KBCLK;				//	PS2 Keyboard Clock
inout		 	PS2_MSDAT;				//	PS2 Mouse Data
inout			PS2_MSCLK;				//	PS2 Mouse Clock
////////////////////////	VGA			////////////////////////////
output			oVGA_CLOCK;   			//	VGA Clock
output			oVGA_HS;				//	VGA H_SYNC
output			oVGA_VS;				//	VGA V_SYNC
output			oVGA_BLANK_N;			//	VGA BLANK
output			oVGA_SYNC_N;			//	VGA SYNC
output	[9:0]	oVGA_R;   				//	VGA Red[9:0]
output	[9:0]	oVGA_G;	 				//	VGA Green[9:0]
output	[9:0]	oVGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_D;					//	DM9000A DATA bus 16Bits
output			oENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			oENET_CS_N;				//	DM9000A Chip Select
output			oENET_IOW_N;			//	DM9000A Write
output			oENET_IOR_N;			//	DM9000A Read
output			oENET_RESET_N;			//	DM9000A Reset
input			iENET_INT;				//	DM9000A Interrupt
output			oENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			iAUD_ADCDAT;			//	Audio CODEC ADC Data
inout			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			oAUD_DACDAT;			//	Audio CODEC DAC Data
inout			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			oAUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input			iTD1_CLK27;				//	TV Decoder1 Line_Lock Output Clock 
input	[7:0]	iTD1_D;    				//	TV Decoder1 Data bus 8 bits
input			iTD1_HS;				//	TV Decoder1 H_SYNC
input			iTD1_VS;				//	TV Decoder1 V_SYNC
output			oTD1_RESET_N;			//	TV Decoder1 Reset
input			iTD2_CLK27;				//	TV Decoder2 Line_Lock Output Clock 		
input	[7:0]	iTD2_D;    				//	TV Decoder2 Data bus 8 bits
input			iTD2_HS;				//	TV Decoder2 H_SYNC
input			iTD2_VS;				//	TV Decoder2 V_SYNC
output			oTD2_RESET_N;			//	TV Decoder2 Reset

////////////////////////	GPIO	////////////////////////////////
inout	[31:0]	GPIO_0;					//	GPIO Connection 0 I/O
input			GPIO_CLKIN_N0;     		//	GPIO Connection 0 Clock Input 0
input			GPIO_CLKIN_P0;          //	GPIO Connection 0 Clock Input 1
inout			GPIO_CLKOUT_N0;     	//	GPIO Connection 0 Clock Output 0
inout			GPIO_CLKOUT_P0;         //	GPIO Connection 0 Clock Output 1
inout	[31:0]	GPIO_1;					//	GPIO Connection 1 I/O
input			GPIO_CLKIN_N1;          //	GPIO Connection 1 Clock Input 0
input			GPIO_CLKIN_P1;          //	GPIO Connection 1 Clock Input 1
inout			GPIO_CLKOUT_N1;         //	GPIO Connection 1 Clock Output 0
inout			GPIO_CLKOUT_P1;         //	GPIO Connection 1 Clock Output 1
///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================
`define HLT 		4'b0000
`define JXX 		4'b0001
	`define JZ  	4'b0000
	`define JNZ 	4'b0001
	`define JG  	4'b0010
	`define JGE 	4'b0011
	`define JL  	4'b0100
	`define JLE 	4'b0101
	`define JC  	4'b0110
	`define JNC 	4'b0111
	`define JO  	4'b1000
	`define JNO 	4'b1001
	`define JN  	4'b1010
	`define JNN 	4'b1011
	`define JMP 	4'b1100
`define AND 		4'b0010
`define OR  		4'b0011
`define XOR			4'b0100
`define NXX 		4'b0101
	`define NOT 	1'b0
	`define NEG 	1'b1
`define ADD 		4'b0110
`define SUB 		4'b0111
`define CMP 		4'b1000
`define TEST 		4'b1001
`define LEA 		4'b1010
`define SHX 		4'b1011
	`define SHR 	1'b0
	`define SHL 	1'b1
`define MOV 		4'b1100
`define PXX 		4'b1101
	`define PUSH    3'b000
	`define POP     3'b000
	`define PUSHF   3'b100
	`define POPF    3'b100
	`define PUSHIP  3'b010
	`define POPIP   3'b010
`define NOP 		4'b1110

`define OPCODE 		IR[15:12]
`define TYPE   		IR[11]
`define REG_A  		IR[10:8]
`define COND 		IR[11:8]
`define NUM    		IR[7:0]
`define REG_B  		IR[7:5]
`define REG_C  		IR[4:2]

`define REG_REG 	3'b000
`define MEM_REG 	3'b001
`define REG_MEM 	3'b010

reg [7:0] 	REGS [0:7];

reg [7:0] 	REG;
assign oLEDG[7:0] = REG[7:0];

reg O;		// overflow flag
reg C;		// carry flag
reg Z;		// zero flag
reg N;		// negative/sign flag

reg [1:0] FLAGS;
assign oLEDR[17:16] = FLAGS[1:0];

reg [15:0] IR; 	// instruction register

assign oLEDR[15:0] = IR[15:0];

reg  [7:0]	 IP;					// instruction pointer
wire [15:0]  CODE_DATA_OUT;
wire [15:0]  CODE_IN;
wire		 CODE_READ;

reg  [7:0]	 CODE_ADDRESS;
wire [15:0]  CODE_OUT;

assign CODE_IN = 0;
assign CODE_READ = 0;

code_seg CODE
(
	.address_a(IP),
	.address_b(CODE_ADDRESS),
	.clock(iCLK_28),
	.data_a(CODE_IN),
	.data_b(CODE_IN),
	.wren_a(CODE_READ),
	.wren_b(CODE_READ),
	.q_a(CODE_DATA_OUT),
	.q_b(CODE_OUT)
);

reg  [7:0]	SP;				// stack pointer
reg  [7:0]  STACK_DATA_IN;
wire [7:0]  STACK_DATA_OUT;
reg 		STACK_WRITE;

reg [7:0]	STACK_ADDRESS;
wire [7:0]  STACK_IN;
wire [7:0]  STACK_OUT;
wire		STACK_READ;

assign STACK_READ = 0;
assign STACK_IN = 0;

stack_seg STACK
(
	.address_a(SP),
	.address_b(STACK_ADDRESS),
	.clock(iCLK_28),
	.data_a(STACK_DATA_IN),
	.data_b(STACK_IN),
	.wren_a(STACK_WRITE),
	.wren_b(STACK_READ),
	.q_a(STACK_DATA_OUT),
	.q_b(STACK_OUT)
);

reg  [7:0]	MP;				// memory pointer
reg  [7:0]  MEM_DATA_IN;
wire [7:0]  MEM_DATA_OUT;
reg 		MEM_WRITE;

reg  [7:0]	MEM_ADDRESS;
wire [7:0]  MEM_IN;
wire [7:0]  MEM_OUT;
wire		MEM_READ;

assign MEM_READ = 0;
assign MEM_IN = 0;

data_seg DATA
(
	.address_a(MP),
	.address_b(MEM_ADDRESS),
	.clock(iCLK_28),
	.data_a(MEM_DATA_IN),
	.data_b(MEM_IN),
	.wren_a(MEM_WRITE),
	.wren_b(MEM_READ),
	.q_a(MEM_DATA_OUT),
	.q_b(MEM_OUT)
);

reg [7:0] reg1;
reg [7:0] reg2;
reg [7:0] result;
reg jump;

reg [1:0] STAGE;
reg RUN;

wire START;
debouncer start
(
	.button(iKEY[1]),
	.clk(iCLK_28),
	.bt_act(START)
);

wire button_clk;
debouncer bt_clk
(
	.button(iKEY[0]),
	.clk(iCLK_28),
	.bt_act(button_clk)
);

wire auto_clk;
prescaler pres
(
	.clkin(iCLK_28),
	.clkout(auto_clk)
);

wire clk_switch;
assign clk_switch = iSW[15];

wire clock;
assign clock = (clk_switch == 1'b0) ? button_clk : auto_clk;
 
dek7seg decCODE_1
(
	.data_in(CODE_OUT[15:12]),
	.data_out(oHEX3_D)
);
dek7seg decCODE_2
(
	.data_in(CODE_OUT[11:8]),
	.data_out(oHEX2_D)
);
dek7seg decCODE_3(
	.data_in(CODE_OUT[7:4]),
	.data_out(oHEX1_D)
);
dek7seg decCODE_4(
	.data_in(CODE_OUT[3:0]),
	.data_out(oHEX0_D)
);

dek7seg decDATA_1
(
	.data_in(MEM_OUT[7:4]),
	.data_out(oHEX5_D)
);
dek7seg decDATA_2
(
	.data_in(MEM_OUT[3:0]),
	.data_out(oHEX4_D)
);

dek7seg decSTACK_1
(
	.data_in(STACK_OUT[7:4]),
	.data_out(oHEX7_D)
);
dek7seg decSTACK_2
(
	.data_in(STACK_OUT[3:0]),
	.data_out(oHEX6_D)
);

wire [9:0] DISPLAY;
assign DISPLAY = iSW[9:0];
//=============================================================================
// Structural coding
//=============================================================================
always@(iSW[12:10]) begin
	REG <= REGS[iSW[12:10]];
end

always@(iSW[17:16]) begin
	case(iSW[17:16])
		2'b00:	FLAGS[1:0] <= {C, Z};
		2'b01:	FLAGS[1:0] <= {C, N};
		2'b10:	FLAGS[1:0] <= {O, Z};
		2'b11:	FLAGS[1:0] <= {O, N};
	endcase
end

always@(DISPLAY) begin
	case(DISPLAY[9:8])
		2'b00: 
			CODE_ADDRESS <= DISPLAY[7:0];
		2'b01: 
			MEM_ADDRESS <= DISPLAY[7:0];
		2'b10: 
			STACK_ADDRESS <= DISPLAY[7:0];
	endcase
end

always@(posedge clock, negedge START) begin
	if(START == 0) begin
		RUN <= 1;
		STAGE <= 0;
		SP <= 0;
		IP <= 0;
		O <= 0;
		C <= 0;
		Z <= 0;
		N <= 0;
	end	
	else begin
		if(RUN == 1) begin
			if(STAGE == 2'b00) begin
				IR <= CODE_DATA_OUT;
				IP <= IP + 1;
				STAGE <= STAGE + 1;
			end
			else begin	
				case(`OPCODE)
					
					`HLT: begin
						RUN <= 0;
						STAGE <= 0;
					end

					`JXX: begin
						case(STAGE)
							2'b01: begin
								case(`COND)
									`JMP: jump <= 1'b1;
									`JZ: jump <= Z;
									`JNZ: jump <= ~Z;
									`JG: jump <= ~Z & ((~N & ~O) | (N & O));
									`JGE: jump <= (~N & ~O) | (N & O);
									`JL: jump <= (N & ~O) | (~N & O);
									`JLE: jump <= Z | ((N & ~O) | (~N & O));
									`JC: jump <= C;
									`JNC: jump <= ~C;
									`JO: jump <= O;
									`JNO: jump <= ~O;
									`JN: jump <= N;
									`JNN: jump <= ~N;
								endcase
								STAGE <= STAGE + 1;
							end
							2'b10: begin
								if(jump == 1)
									IP <= `NUM;
								STAGE <= 0;
							end
						endcase
					end

					`AND: begin
						if(`TYPE == 1)
							REGS[`REG_A] <= REGS[`REG_A] & `NUM;
						else
							REGS[`REG_A] <= REGS[`REG_A] & REGS[`REG_B];
						STAGE <= 0;
					end

					`OR: begin
						if(`TYPE == 1)
							REGS[`REG_A] <= REGS[`REG_A] | `NUM;
						else
							REGS[`REG_A] <= REGS[`REG_A] | REGS[`REG_B];
						STAGE <= 0;
					end

					`XOR: begin
						if(`TYPE == 1)
							REGS[`REG_A] <= REGS[`REG_A] ^ `NUM;
						else
							REGS[`REG_A] <= REGS[`REG_A] ^ REGS[`REG_B];
						STAGE <= 0;
					end

					`NXX: begin
						if(`TYPE == `NOT)
							REGS[`REG_A] <= ~REGS[`REG_A];
						else
							REGS[`REG_A] <= 0 - REGS[`REG_A];
						STAGE <= 0;
					end

					`ADD: begin
						case(STAGE)
							2'b01: begin
								reg1 <= REGS[`REG_A];
								if(`TYPE == 1)
									reg2 <= `NUM;
								else
									reg2 <= REGS[`REG_B];
								STAGE <= STAGE + 1;
							end
							2'b10: begin
								{C, result} <= reg1 + reg2;
								STAGE <= STAGE + 1;
							end
							2'b11: begin
								REGS[`REG_A] <= result;
								Z <= ~|(result);
								N <= result[7];
								case({C, reg1[7], reg2[7]})
									3'b001: O <= 1;
									3'b110: O <= 1;
								endcase
								STAGE <= 0;
							end
						endcase
					end

					`SUB: begin
						case(STAGE)
							2'b01: begin
								reg1 <= REGS[`REG_A];
								if(`TYPE == 1)
									reg2 <= `NUM;
								else
									reg2 <= REGS[`REG_B];
								STAGE <= STAGE + 1;
							end
							2'b10: begin
								{C, result} <= reg1 - reg2;
								STAGE <= STAGE + 1;
							end
							2'b11: begin
								REGS[`REG_A] <= result;
								Z <= ~|(result);
								N <= result[7];
								case({C, reg1[7], reg2[7]})
									3'b011: O <= 1;
									3'b100: O <= 1;
								endcase
								STAGE <= 0;
							end
						endcase
					end

					`CMP: begin
						case(STAGE)
							2'b01: begin
								reg1 <= REGS[`REG_A];
								if(`TYPE == 1)
									reg2 <= `NUM;
								else
									reg2 <= REGS[`REG_B];
								STAGE <= STAGE + 1;
							end
							2'b10: begin
								{C, result} <= reg1 - reg2;
								STAGE <= STAGE + 1;
							end
							2'b11: begin
								Z <= ~|(result);
								N <= result[7];
								case({C, reg1[7], reg2[7]})
									3'b011: O <= 1;
									3'b100: O <= 1;
								endcase	
								STAGE <= 0;
							end
						endcase
					end

					`TEST: begin
						if(`TYPE == 1)
							Z <= ~|(REGS[`REG_A] & `NUM);
						else
							Z <= ~|(REGS[`REG_A] & REGS[`REG_B]);
						STAGE <= 0;
					end

					`LEA: begin
						REGS[`REG_A] <= `NUM;
						STAGE <= 0;
					end

					`SHX: begin
						if(`TYPE == `SHL)
							{C, REGS[`REG_A]} <= {C, REGS[`REG_A]} << `REG_B;
						else
							{REGS[`REG_A], C} <= {REGS[`REG_A], C} >> `REG_B;
						STAGE <= 0;
					end

					`MOV: begin
						if(`TYPE == 1) begin
							REGS[`REG_A] <= `NUM;
							STAGE <= 0;
						end
						else begin
							case(`REG_A)
								`REG_REG: begin
										REGS[`REG_B] <= REGS[`REG_C];
										STAGE <= 0;
								end 
								`MEM_REG: begin
									case(STAGE)
										2'b01: begin
											MP <= REGS[`REG_B];
											MEM_DATA_IN <= REGS[`REG_C];
											STAGE <= STAGE + 1;
										end
										2'b10: begin
											MEM_WRITE <= 1;
											STAGE <= 0;
										end
									endcase
								end
								`REG_MEM: begin
									case(STAGE)
										2'b01: begin
											MEM_WRITE <= 0;
											MP <= REGS[`REG_C];
											STAGE <= STAGE + 1;
										end
										2'b10: begin
											REGS[`REG_B] <= MEM_DATA_OUT;
											STAGE <= 0;
										end
									endcase
								end
							endcase
						end
					end

					`PXX: begin
						if(`TYPE == 1) begin
							case(STAGE)
								2'b01: begin
									STACK_WRITE <= 1;
									STAGE <= STAGE + 1;
								end
								2'b10: begin
									case(`REG_A)
										`PUSH:
												STACK_DATA_IN <= REGS[`REG_B];
										`PUSHF:
												STACK_DATA_IN <= {1'b0, 1'b0, 1'b0, 1'b0, O, C, Z, N};
										`PUSHIP:
												STACK_DATA_IN <= IP + 1;
									endcase
									STAGE <= STAGE + 1;
								end
								2'b11: begin
									SP <= SP + 1;
									STAGE <= 0;
								end
							endcase
						end
							
						else begin
							case(STAGE)
								2'b01: begin
									STACK_WRITE <= 0;
									SP <= SP - 1;
									STAGE <= STAGE + 1;
								end
								2'b10: begin
									case(`REG_A)
										`POP: 		
												REGS[`REG_B] <= STACK_DATA_OUT;
										`POPF:
												{result[7:4], O, C, Z, N} <= STACK_DATA_OUT;
										`POPIP:
												IP <= STACK_DATA_OUT;
									endcase
									STAGE <= 0;
								end
							endcase
						end

					end

					`NOP: begin
						REGS[0] <= REGS[0];
						STAGE <= 0;
					end
				
				endcase
			end
		end
	end
end


endmodule
