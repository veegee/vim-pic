" Vim syntax file
" Language:     PIC16F84 Assembler (Microchip's microcontroller)
" Maintainer:   Aleksandar Veselinovic <aleksa@cs.cmu.com>
" Last Change:  2003 May 11
" URL:		http://galeb.etf.bg.ac.yu/~alexa/vim/syntax/pic.vim
" Revision:     1.01

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax") && !exists ("g:plugin_dev_mode")
  finish
endif

syn case match
syn keyword picTodo NOTE TODO XXX contained
syn case ignore

syn match picIdentifier "[a-z_$][a-z0-9_$]*"
syn match picLabel      "^[A-Z_$][A-Z0-9_$]*"
syn match picLabel      "^[A-Z_$][A-Z0-9_$]*:"me=e-1

syn match picASCII      "A\='.'"
syn match picBinary     "B'[0-1]\+'"
syn match picDecimal    "D'\d\+'"
syn match picDecimal    "\d\+"
syn match picHexadecimal "0x\x\+"
syn match picHexadecimal "H'\x\+'"
syn match picHexadecimal "[0-9]\x*h"
syn match picOctal      "O'[0-7]\o*'"

syn match picComment    ";.*" contains=picTodo

syn region picString    start=+"+ end=+"+

syn keyword picRegister		INDF TMR0 PCL STATUS FSR PORTA PORTB
syn keyword picRegister		EEDATA EEADR PCLATH INTCON INDF OPTION_REG PCL
syn keyword picRegister		FSR TRISA TRISB EECON1 EECON2 INTCON OPTION



" Register --- bits

" STATUS
syn keyword picRegisterPart     IRP RP1 RP0 TO PD Z DC C

" PORTA
syn keyword picRegisterPart     T0CKI
syn match   picRegisterPart     "RA[0-4]"

" PORTB
syn keyword picRegisterPart     INT
syn match   picRegisterPart     "RB[0-7]"

" INTCON
syn keyword picRegisterPart     GIE EEIE T0IE INTE RBIE T0IF INTF RBIF

" OPTION
syn keyword picRegisterPart     RBPU INTEDG T0CS T0SE PSA PS2 PS1 PS0

" EECON2
syn keyword picRegisterPart     EEIF WRERR WREN WR RD

" INTCON
syn keyword picRegisterPart     GIE EEIE T0IE INTE RBIE T0IF INTF RBIF


" OpCodes
syn keyword picOpcode
\ ADDFSR ADDLW ADDULNK ADDWF ADDWFC ANDLW ANDWF BC BCF BN BNC BNN BNOV BNZ BOV BRA
\ BSF BTFSC BTFSS BTG BZ CALL CALLW CLRF CLRW CLRWDT COMF CPFSEQ CPFSGT CPFSLT DAW
\ DCFSNZ DECF DECFSZ GOTO INCF INCFSZ INFSNZ IORLW IORWF LFSR MOVF MOVFF MOVLB MOVLW
\ MOVSF MOVSS MOVWF MULLW MULWF NEGF NOP POP PUSH PUSHL RCALL RESET RETFIE RETLW RETURN
\ RLCF RLF RLNCF RRCF RRF RRNCF SETF SLEEP SUBFSR SUBFWB SUBLW SUBULNK SUBWF SUBWFB
\ SWAPF TBLRD TBLWT TSTFSZ XORLW XORWF

" Directives
syn keyword picDirective
\ __BADRAM __BADROM __CONFIG __FUSES __IDLOCS __MAXRAM __MAXROM
\ BANKISEL BANKSEL CBLOCK CODE CONSTANT DATA DB DE DT DW END ENDC
\ ENDM ENDW EQU ERROR ERRORLEVEL EXITM EXPAND EXTERN FILL GLOBAL IDATA
\ LOCAL MESSG NOEXPAND NOLIST ORG PAGE PAGESEL PROCESSOR RADIX
\ RES SET SPACE SUBTITLE TITLE UDATA UDATA_OVR UDATA_SHR VARIABLE WHILE
syn keyword picDirective if endif ifdef else endif

syn keyword picPreProc  macro endm
syn match picDefine     "\v^\s*#define .*$"

syn match picInclude    display "^\s*\(%:\|#\)\?\s*include\>\s*["<]" contains=picIncluded
syn match picIncluded   display contained "<[^>]*>"
syn region picIncluded  display contained start=+"+ skip=+\\\\\|\\"+ end=+"+

syn match picList       display "\v^\s*list>\s+.*" contains=picList2
syn match picList2      display contained "\v(list.*)@<=\S+"

syn match picProc       display "\v^\s*processor>\s+.*" contains=picProc2
syn match picProc2      display contained "\v(processor.*)@<=\w+"

" macro name
syn match picMacro "\v(\w+)( MACRO)@="


" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_pic16f84_syntax_inits")
  if version < 508
    let did_pic16f84_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink picTodo		Todo
  HiLink picComment		Comment
  HiLink picDirective		Statement
  HiLink picLabel		Label
  HiLink picString		String

  HiLink picPreProc             PreProc
  HiLink picInclude             Include
  HiLink picIncluded            String
  HiLink picMacro               Macro
  HiLink picDefine              Macro

  HiLink picOpcode		Normal
  HiLink picRegister		Structure
  HiLink picRegisterPart	Special

  HiLink picASCII		String
  HiLink picBinary		Number
  HiLink picDecimal		Number
  HiLink picHexadecimal		Number
  HiLink picOctal		Number

  HiLink picList                Statement
  HiLink picList2               String
  HiLink picProc                Statement
  HiLink picProc2               String

  HiLink picIdentifier		Identifier

  delcommand HiLink
endif

let b:current_syntax = "pic8"

" vim: ts=8
