# Coding 101
**As simple as possible introduction/application of programming pragmatically applied to iOS programming**
<br />

1. [universal concepts](#101)
2. [C](#C)
3. [Obj-C](#ObjC)
4. [inheritance](#classes)
5. [IDE](#IDE)
6. [VC](#VC)
7. [Languages](#languages)

<!-- 101 .................................................................. -->
<a name="101"></a>
## universal concepts
#### binary
bit / nibble / octet / byte / word 
<!-- defacto byte===8 bits -->
```
0 or 1, 4 bits, 8 bits, *8 bits, *32-bits
```
<!-- nybble -->
MSB...LSB
<br/>
_All counting starts at 0_
<br/>

#### counting
<br/>
**binary, ie CS**

| BINARY NAME | PREFIX |     SIZE     |        LONG          |
|-------------|--------|--------------|----------------------|
| kiloByte    | KiB    | 2^10 bytes   | 1024 bytes           |
| megaByte | MiB | 2^20 bytes | 1048576 bytes |
| gigaByte | GiB | 2^30 bytes | 1073741824 bytes |
| teraByte | TiB | 2^40 bytes | 1099511627776 bytes |
| petaByte | PiB | 2^50 bytes | 1125899906842624 bytes |
| exaByte | EiB | 2^60 bytes | 1152921504606846976 bytes |
| zettaByte | ZiB | 2^70 bytes | 1180591620717411303424 bytes |
| yottaByte | YiB | 2^80 bytes | 1208925819614629174706176 bytes |
| ninaByte | NiB | 2^90 bytes | 1237940039285380274899124224 bytes |
| tenaByte | UiB | 2^100 bytes | 1267650600228229401496703205376 bytes |


<br/>
**metric, ie business**

| METRIC NAME | PREFIX |     SIZE     |        LONG          |
|-------------|--------|--------------|----------------------|
| kilobyte | kB | 1E3 bytes | 1000 bytes |
| megabyte | MB | 1E6 bytes | 1000000 bytes |
| gigabyte | GB | 1E9 bytes | 1000000000 bytes |
| terabyte | TB | 1E12 bytes | 1000000000000 bytes |
| petabyte | PB | 1E15 bytes | 1000000000000000 bytes |
| exabyte | EB | 1E18 bytes | 1000000000000000000 bytes |
| zettabyte | ZB | 1E21 bytes | 1000000000000000000000 bytes |
| yottabyte | YB | 1E24 bytes | 1000000000000000000000000 bytes |
<br/>

binary = base 2 =  0% = 0b
<br/>
```EX: 0b101010```
<br/>
hexidecimal = base 16 = hex = 0x = #
<br/>
```EX: 0x2A```
<br/>
(no one uses octal)
<br/>

#### table

| DECIMAL |      BINARY    | HEXIDECIMAL | POWER OF 2 |
|---------|----------------|-------------|------------|
|       0 |              0 |           0 | 0 |
|       1 |              1 |           1 | 2^0 |
|       2 |             10 |           2 | 2^1 |
|       3 |             11 |           3 | |
|       4 |            100 |           4 | 2^2 |
|       5 |            101 |           5 | |
|       6 |            110 |           6 | |
|       7 |            111 |           7 | |
|       8 |           1000 |           8 | 2^3 |
|       9 |           1001 |           9 | |
|      10 |           1010 |           A | |
|      11 |           1011 |           B | |
|      12 |           1100 |           C | |
|      13 |           1101 |           D | |
|      14 |           1110 |           E | |
|      15 |           1111 |           F | |
|      16 |          10000 |          10 |2^4 |
|      17 |          10001 |          11 | |
|      18 |          10010 |          12 | |
|   ...   |         ...    |      ...    | |
|     100 |      0b1100100 |        0x64 | |
|    1024 |  0b10000000000 |       0x400 | 2^10 |






_we decide what the meanings of the bits are_


#### primitive types
integer: whole numbers
```
0b00001010 (10)
0b10101010 (170)
```
<br/>
unsigned: always considered positive
<br/>
signed: 2s compliment signing (if negative, flip the bits + add 1)
```
0b00001010 (+10)
0b10101010 (-86)
(0b01010101+1 = 0b10101010 = 86 )
   0b00001010 (+10)
 + 0b10101010 (-86)
=  0b10110100 (-76)
(0b01001011+1 = 0b01001100 = 76 )
```
<br/>
<!-- scientific notation -->
floating point: allow to use wide range of numbers, different sections of bits mean different things, certain values have specific meanings (+inf,-inf,NaN,+0,-0)
<!-- http://steve.hollasch.net/cgindex/coding/ieeefloat.html -->
```
IEEE 32-bit FP:
[sign|exponent|mantissa]
      3|322 2222 2|222 1111 1111 1000 0000 0000
      1|098 7654 3|210 9876 5432 1098 7654 3210
      s|eee eeee e|mmm mmmm mmmm mmmm mmmm mmmm
   0: s|000 0000 0|000 0000 0000 0000 0000 0000
 inf: s|111 1111 1|000 0000 0000 0000 0000 0000
 NaN: s|111 1111 1|xxx xxxx xxxx xxxx xxxx xxxx
```
- range: the exponent can only be between -127,126
      - &plusmn; 10^38.58
- precision: a number is only as precise as the first few digits (decimal ~6 in 32-bit)
      - adding a relatively small value to a relatively large value results in no change
      - eg: 1.5E10 + 1.1E-10 = 1.5E10 [not 15,000,000,000.0000000001]
- &epsilon; (epsilon) = smallest representable number (in magnitude)
<br/>
character
<br/>
<!-- character strings -->
strings
<br/>



#### bitwise operations
NOT: ~
```
 ~ 0b010101
=  0b101010
```
AND: &
```
   0b010101
 & 0b111000
=  0b010000
```
OR: |
```
   0b010101
 | 0b111000
=  0b111101
```
XOR: ^
```
   0b010101
 ^ 0b111000
=  0b101101
```
SHIFT-LEFT: <<
```
<<2 0b010101
=   0b010100
```
SHIFT-RIGHT: >>
```
>>2 0b010101
=   0b000101
```

#### math operations
addition +
```
9 + 5   // 14
```
subtraction -
```
9 - 5   // 4
```
multiplication *
```
9 * 5   // 45
```
modulo (remainder) %
```
9 % 5   // 4
```
increment (pre/post) ++
```
b = 5
++b   // b = 6
b = 5
b++   // b = 6
```
decrement (pre/post) --
```
b = 5
--b   // b = 4
b = 5
b--   // b = 4
```

#### logical operators
AND &&
OR ||
EQ ==
NE !=
GT >
LT < 
GTE >=
LTE <=

#### assignment
ASSIGN =

#### combinitorics
+=, -=, /=, *=, %=, ^=, |=, &=, <<=, >>=

#### unary other
pointer *
address &
negate -

#### tertiary other
conditional ?:


#### exceptions
overflow
underflow


#### collections
array
hash = key/value




### RAM
giant 1-dimensional list of bits
```
...011010110101000010101010001...
```
internally, each (referencing each bit of RAM is comparatively wasteful)
```
```
"Address Space"
smallest addressable space = byte

#### data

#### instructions
statements
variables
jumping

#### ALU
operates using small set of local registers (32~64)
program counter

#### code chain
visual programming
human-readable languages
compiler / interpretr
assembly code
machine code


#### caching
it takes time to access data, so to 

CPU registers [words]
CPU L1 cache [~8MB]
CPU L2 cache [~16MB]
RAM [~32GB]
HDD [~2TB]
backup tape-drives [~100TB]
internet [~PB]
- cold-start
- cache-hit
- cache-miss

#### main()

<!-- C Examples .................................................................. -->
<a name="C"></a>
## C

### 

#### primitives

#### pointers

#### structs

#### main

<!-- Objective-C Examples .................................................................. -->
<a name="ObjC"></a>
## Obj-C
#### objects
- operations / interactions

<!-- closure = env+control -->

#### main
- 
#### libraries

<!-- Classes Examples .................................................................. -->
<a name="classes"></a>
## inheritance

extending/reusing code

#### Classes

#### prototype chain
*JavaScript*

<!-- IDE Examples .................................................................. -->
<a name="IDE"></a>
## IDE
*Integrated Development Environment*

#### XCode


#### Eclipse

#### text editors / alternatives
**Notepad**
<br/>
- 

**SublimeText**
<br/>
- syntax highlighting, auto-completion

combine with command-line / OS calls

<!-- Collaborative Programming Examples .................................................................. -->
<a name="VC"></a>
## VC
*Version Control / Collaborative Programming*

#### git


#### SVN

#### P4


<!-- Languages Examples .................................................................. -->
<a name="languages"></a>
## languages
<!-- Object-Oriented | Declarative | Imperative = bullshit -->

#### machine
hardware-specific, proprietary, ... RISC, 

#### assembly
NASM, TASM, ASM, proprietary
```
main: 
    MOV $R1,0x1234
	MOV $R2,0xABCD
	ADD $R1,$R2
```

#### lower-level
COBOL
```
```
Pascal
```
```
Fortran
```
```
C
```
```


#### scripting
> shell / bash
```bash
ls -lah
```
> matlab / octave
> ruby
> python
> perl

#### higher-level
C#
Objective-C
JAVA : object oriented crazy
ActionScript

#### ?
JavaScript


#### lambda
Clojure
Haskell
LISP

#### ...
GO

#### formatting / presentation
HTML
markdown
CSS

#### data
binary
- bit-level decisions of what is to be interpreted
```
...000010101...
```
XML
- fat, hard to read, how to decided attribute vs nesting, slow processing
```
<!-- comment -->
...
<container>
	<tagName attribute="value" />
</container>
...
```
JSON/JSONP
- good 1:1 relationship with internal objects
```
...
	"property":[
		{"key":"value"}
	]
...
```






does that
>! Spoiler text
do something?



