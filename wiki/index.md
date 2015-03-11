# Coding 101
**As simple as possible introduction to /application of programming, pragmatically applied to iOS platform**
<br />
_There are lots of intricacies and technicalities, but without nitty-gritty details the summaries cover fair assumptions_
<br />


# Schedule
1. Binary/Computer Architecture/Data+Operations [white board]
2. General Programming Overview/DIY-C programming [white board + laptops]
3. DIY XCode + Swift Programming/Example App [laptops]
<br />


# Table of Contents

1. [universal concepts](#101) [1](#LESSON1) [2](#LESSON2)
2. [C](#C) [2](#LESSON2)
3. [Swift](#SWIFT) [2](#LESSON3)

3. [Obj-C](#ObjC)
4. [inheritance](#classes)
5. [IDE](#IDE)
6. [VC](#VC)
7. [Languages](#languages)


<!-- 101 .................................................................. -->
<a name="LESSON1"></a>
<a name="101"></a>
## universal concepts
#### binary
<!-- high and low voltages -->
<!-- basic counting: 0, 1, 10, 11, 100, ... -->
bit / nibble / octet / byte / word 
<!-- defacto byte===8 bits -->
<!-- use spacing or symbols for readability -->
```
0 or 1, 4 bits, 8 bits, *8 bits, *32-bits
```
<!-- nybble -->
MSB...LSB <!-- 'significance' -->
<!-- little vs *big endian -->
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
<!-- colors: 0-255, #AABBCC -->
hexidecimal = base 16 = hex = 0x = #
<!-- try counting: 0,1,2,...8,9,A,B,C,D,E,F,10... -->
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





<!-- what does some set of bits represent? -->
_we decide what the meanings of the bits are_

<!-- deal with bits in sets of 8 (coming up) -->
#### primitive types

boolean : true / false
```
0b11111111 (true)
0b00000000 (false)
```
<br/>

integer: whole numbers
```
0b00001010 (10)
0b10101010 (170)

   0b00001010 (10)
 + 0b10101010 (170)
=  0b10110100 (180)
```
<br/>
<!-- how would you tell if a binary number is even or odd ? (example of some LL operations being easy) -->

unsigned: always considered positive
<br/>
<!-- simple sign example vs 2s compliment -->
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
floating point: allow to use wide range of numbers, different sections of bits mean
<!-- represent smaller number in terms of larger number -- common exponent -->
```
+1.141E6 + +2.694E-4
1,141,000 + 0.0002694
   1141000
 + 0000000.0002694E6
=  1141000.0002694E6
(truncate/rounding here)
=  1.14100002694E6
=  1,141,000.0002694
```
<!-- might not have enough bits to keep all precision) -->
different things, certain values have specific meanings (+inf,-inf,NaN,+0,-0)
<!-- http://steve.hollasch.net/cgindex/coding/ieeefloat.html -->
```
IEEE 32-bit FP:
[sign|exponent|mantissa] [1|8|23]
      3|322 2222 2|222 1111 1111 1100 0000 0000
      1|098 7654 3|210 9876 5432 1098 7654 3210
-------------------------------------------------      
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
ASCII (7 bits) / Extended ASCII (8 bits), Unicode (16 bits)
<br/>
```
0b01000001 (65) == 'A'
...
0b01111010 (122) == 'z'
```
<!-- American Standard Code for Information Interchange -->
[ASCII Table](http://www.asciitable.com/index/asciifull.gif)
<!-- ![ASCII](http://www.asciitable.com/index/asciifull.gif) -->
<br/>

<!-- character strings -->
strings
<br/>
```
0b01001000 01100101 01101100 01101100 01101111 (72,101,108,108,111) == "Hello"
```
<br/>

<!-- DIY -->
#### bitwise operations
<!-- bit masking -->
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
SHIFT-RIGHT: >> (>>> arithmetic / sign extend)
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
<!-- 17%2==0 18%2==1 19%2==0 ... -->
```
9 % 5   // 4
```
increment (pre/post) ++
<!-- op(++b) ne op(b++) -->
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
NOT !
```
! false  == true
! true   == false 
! 9      == 0 == false
! 5      == 0 == false
! 0      == 1 ==  true      *
```
<br/>
AND &&
```
false && false  == false 
false &&  true  == false 
 true && false  == false 
 true &&  true  ==  true 
    9 &&     4  == false (0b00001001(!=0) && 0b00000100(!=0) == true)
    5 &&     0  == false (0b00000101(!=0) && 0b00000000(==0) == false)
```
<br/>
OR ||
```
false || false  == false 
false ||  true  ==  true 
 true || false  ==  true 
 true ||  true  ==  true 
    9 ||     4  ==  true (0b00001001(!=0) || 0b00000100(!=0) == true)
    5 ||     0  == false (0b00000101(!=0) && 0b00000000(==0) == true)
```
<br/>
EQ ==
```
false == false  ==  true
false ==  true  == false 
 true == false  == false 
 true ==  true  ==  true 
    9 ==     4  == false (0b00001001 == 0b00000100 == false)
```
<br/>
NE !=
```
false != false  == false
false !=  true  ==  true 
 true != false  ==  true 
 true !=  true  == false 
    9 !=     4  ==  true (0b00001001 != 0b00000100 == true)
```
<br/>
GT >
```
    9 >     4  ==  true 
    5 >     9  == false 
    5 >     5  == false 
```
<br/>
LT < 
```
    9 <     4  == false 
    5 <     9  ==  true 
    5 <     5  == false 
```
<br/>
GTE >=
```
    9 >=    4  ==  true 
    5 >=    9  == false 
    5 >=    5  ==  true 
```
<br/>
LTE <=
```
    9 <=    4  == false 
    5 <=    9  ==  true 
    5 <=    5  ==  true 
```
<br/>
negate - (unary)
```
a = -b
```
<br/>
#### assignment
<!-- := -->
ASSIGN =
```
a,b,c       # a=0,b=0,c=0
a = 4       # a=4,b=0,c=0
b = 9       # a=4,b=9,c=0
c = a       # a=4,b=9,c=4
```
<!-- need temporary variable -->
SWAP Example
```
a,b,c       # a=0,b=0
a = 4       # a=4,b=0
b = 9       # a=4,b=9
a = b       # a=9,b=9
b = a       # a=9,b=9
            # a == b == 9
```

#### combinatorics
+=, -=, /=, *=, %=, ^=, |=, &=, <<=, >>=


<a name="LESSON2"></a>
# LESSON 2:

### Computer
- CPU (registers, ALU)
- memory (volatile)
- storage (long term - CD,HDD)
- peripherals (keyboard,mouse,monitor[graphics card])
- Motherboard connects all these components <!-- BUS -->
<!-- graphics cards are computers in own right -->

### RAM
giant 1-dimensional list of bits
```
...011010110101000010101010001...
```
<!-- random vs sequential -->
<!-- can't address single bit : shift + mask -->
Internally, memory is actually 'chunk'ed into small groupings, because having a unique address for every bit of RAM is wasteful, when compared to referencing say, 8-bit-chunks at a time. Almost never does a programmer care about only a single bit -- typically you would deal with objects that are at least dozens of bits in size.
<br/>
<br/>
<!-- may have much less memory, but OS abstracts that from us -->
**"Address Space"**: Set of all addresses that can be referenced, modern systems: 4GB+ (4294967296 bytes, max location: 0xFFFFFFFF), smallest addressable space = &lowast;byte
```
|   RAM VALUE  | < RAM ADDRESS
|      ...     | < ...
|  0b00001000  | < 0x06FF
|  0b00001000  | < 0x0700
|  0b01001000  | < 0x0701
|  0b11111111  | < 0x0702
|      ...     | < ...
|  0b00000000  | < 0x07FF
|  0b00000000  | < 0x0800 --         EX 32 bit integer starting at index 0x0800
|  0b00010010  | < 0x0801  | ------\ (binary: 0b0100101101011010000111)
|  0b11010110  | < 0x0802  | ------/ (hex: 0x12D687)
|  0b10000111  | < 0x0803 --         (decimal: 1234567)
|  0b00000000  | < 0x0804
|      ...     | < ...
```

<!-- what is a variable? location + value -->
address &
```
&variable      # this gets the address (location in memory of a variable), eg 0x7fd0 80cc 5ff0
```
<br/>
pointer *
```
*pointer       # pointer is a variable that holds the address of a variable, effectively pointing to it
```
<!-- optimimal use of memory, single 'object' multiple variables pointing to it -->
dereference * (also asterisk)
```
*pointer       # get the value of the object being pointed at
```
<!-- give me the value of the object at the address of my value = of the object I'm pointing at -->
<!--
#### tertiary other
conditional ?:
<br/>
&lt;expression to evaluate&gt; ? &lt;expression to use if true&gt; : &lt;expression to use if false&gt;
```
(a==b) ? 5 : 9
```
#### exceptions
**overflow** : reach a number too large to be represented
<br/>
**underflow** : reach a number too tiny to be represented
<br/>
**defined** : system/user defined, used to change flow of program (eg list length is zero)
<br/>
-->

#### collections
**array** : ordered list of values
```
var array = new Array() # ordered list
array[0] = 9
array[1] = 100
array[2] = 6
array[3] = 0x00FF00
array[4] = 0
                        # array = {9,100,6,65280,0}
```
operations: push, pop, update
<br/>

<!-- some features may/not be available for certain languages out-of-the-box -->
**hash** : unordered key/value list of values (keyed array, map, dictionary, table)
<br/>
```
var hash = {}                    # unordered list
hash["birthday"] = "07/18/1987"
hash["age"] = "27"
hash["key"] = "value"
                                # hash = {"birthday":"07/18/1987","age":"27","key":"value"}
```
operations: insert, update, delete


#### data
The data at a particular address can be interpreted as any type of data object (eg int, float, string), depending on the variable used to point at it. The data itself could be used to store the address of another variable, or the address to an address to an address...

#### instructions
The data at an address can be interpreted as one of various (low-level) instructions, from simple statements like add the data from two addresses and put the result into a third address. The data could also be the address of a statement to be executed, or an offset to let the program counter 'jump' to a nearby memory location.
<!-- instructions are very HW dependent -->

#### main()
main (or similar) is the entry point of a program.
<br/>
parameters can be passed to it via the OS or other programs - _argument count_ and _argument values_ . 
<br/>
```C
// C, Obj-C, C++, ..
int main(int argc, char **argv){
   ...
   return 0;
}
```
```C
// C#
static int Main(string[] args){
    ...
  return 0;
}
```
```JAVA
// JAVA
public static void main(String[] args){
   ...
}
```
```Ruby
# ruby
#!/usr/bin/env ruby 
  ARGV.length
  ...
```
```Python
# Python
#!/usr/bin/env python3
def main(argv):
    ...
```

<!-- C Examples .................................................................. -->
<a name="C"></a>
## C

### variable types

#### primitives
most basic building blocks
```C
    int i = 9;                          // 32 bit integer (signed)
    unsigned int nosign = -20;          // 32 bit integer unsigned
    long j = 0x08FF009900;              // 64 bit integer (signed)
    long int higher;                    // 64 bit integer (signed)
    short int small = 0xFFFF;           // 16 bit integer (signed)
    float num = 3.1415926;              // 32 bit float ~6 useful digits
    double prec2 = 1.41421356237095048; // 64 bit float ~16 useful digits
    long double highPrec = 1.1E-40;     // 80,96,128 bit float 19~34 useful digits
    char letter = 'R';                  // 8 bit character
    char *text = "hello buddy";         // variable-length c-string
    char fixedText[10] = "3.141";       // fixed-length c-string
    BOOL boolean = false;               // 8-bit boolean
    // no such thing as unsigned float --- unsigned float
    // C does not have a short float --- short float
```
[C Types](http://en.wikipedia.org/wiki/C_data_types)


#### example compile/run
main: entry point for application - hello world
 > example0.c
 
```C
int main(int argc, char **argv) {
    int i;
    for(i=0; i<argc; ++i){
        printf("arg %d: %s \n",i,argv[i]);
    }
}
```

#### example compile/run
pointers: multiple references to same object
 > example1.c

<!-- referencing, dereferencing --> 
```C
    int i;
    int *j;
    j = &i;
    fprintf(stdout, "example1: \n");
    printf("A) i: %d, j: %d \n",i,*j); // A) i: 0, j: 0
    i = 5;
    printf("B) i: %d, j: %d \n",i,*j); // B) i: 5, j: 5
    *j = 9;
    printf("C) i: %d, j: %d \n",i,*j); // C) i: 9, j: 9
```
#### structs
<!-- typedef lets you create aliases for things -->
<!-- structs are just larger blocks of memory -->
```C
// need to declare variable as "struct person variable;"
struct person {
    char name[16];
    int age;
};

// cleaner: declare variable as "person variable;"
typedef struct {
    char name[16];
    int age;
} person;

    person richie;
    strcpy(richie.name,"Richie");
    richie.age = 27;
    printf("name: %s, age:%d \n",richie.name,richie.age);
```

<!-- diagram of RAM -->
### allocated space
- compiletime
    - program instructions
    - constants
- runtime
    - memory allocation
- stack/heap
    - stack grows based on functions calling functions
    - heap grows as more memory is required to store objects
<!-- trade off where the overhead goes, and tedium -->
- cleanup
  - manual: alloc, free
  - 'manual' reference counting: retain, release, (autorelease)
  - auto reference counting (ARC): reference code is injected by compiler at compile time
  - garbage collecting: periodic reference counting
```
---------
CONSTANTS
---------
PROGRAM
---------
STACK
v

(trash)

^
HEAP
---------
```

#### example compile/run
pointer referencing (location + value) and memory management (allocation, freeing)
 > example2.c

<!-- ? --> 
```C
int main(int argc, char **argv) {
    int i;
  printf("MAIN\n");
  // show input arguments to program
  for (i=0; i<argc; ++i){
    printf("argv[%d]: %s \n",i,argv[i]);
  }
    
  // show addressing
  int variable; // integer
  int *pointer; // pointer to an integer
    pointer = &variable; // point to same location
    
  printf("\nCHECK A:\n");
  printf("variable address: %p \n", &variable); // 0xX...X
  printf("variable value: %d \n", variable); // 0
  printf("pointer address: %p \n", &pointer); // 0xX...X
  printf("pointer value: %p (%ld == %lx) \n", pointer,pointer,pointer); // 0xX...X
  printf("pointer reference value: %d \n", *pointer); // 0

  variable = 5;
  
  printf("\nCHECK B:\n");
  printf("variable address: %p \n", &variable); // 0xX...X
  printf("variable value: %d \n", variable); // 5
  printf("pointer address: %p \n", &pointer); // 0xX...X
  printf("pointer value: %p (%ld == %lx) \n", pointer,pointer,pointer); // 0xX...X
  printf("pointer reference value: %d \n", *pointer); // 5
  
  *pointer = 9;

  printf("\nCHECK C:\n");
  printf("variable address: %p \n", &variable); // 0xX...X
  printf("variable value: %d \n", variable); // 9
  printf("pointer address: %p \n", &pointer); // 0xX...X
  printf("pointer value: %p (%ld == %lx) \n", pointer,pointer,pointer); // 0xX...X
  printf("pointer reference value: %d \n", *pointer); // 9


  // indexing
  printf("\narray indexing:\n");
  int list[] = {1,2,3,4};
  int len = 5; // should be 4
  for(i=0;i<len;++i) {
    pointer = &list[i];
    printf("(%d) [%p] = %d\n", i, pointer, *pointer);
  }
  printf("^ accessing values post array end ^\n");
  printf("...\n");

  // memory management - int
  printf("\n dynamic int array\n");
  pointer = NULL;
  len = 10;
  pointer = (int*) malloc( sizeof(int)*len );
  for(i=0;i<len;++i) {
    printf("pointer[%d] = [%p] = %d\n", i, &pointer[i], pointer[i]);
  }
  free(pointer);
  pointer = NULL;

  // memory management - double
  printf("\n dynamic double array\n");
  double *pointerDouble = NULL;
  len = 10;
  pointerDouble = (double*) malloc( sizeof(double)*len ); // vs calloc
  for(i=0;i<len;++i) {
    printf("pointer[%d] = [%p] = %lf\n", i, &pointerDouble[i], pointerDouble[i]);
  }
  free(pointerDouble);
    pointer = NULL;

  printf("...\n");

  // success
  return 0;
}
```
<!-- SEGV -->
<!-- typecasting -->
<!-- setting pointers to NULL when done -->

### reserved words
- can't use for variable/function names
```
 int 4chan; // can't start with number
 double for; // for is a reserved word
 double For; // case sensitive, For is valid
```




<a name="LESSON3"></a>
# LESSON 3:

# xcode intro

- interface
    - left: file, compile & run feedback,  <!-- source code, images, storyboards/xib, sounds, config files -->
    - center: source <!-- code, image, config -->
    - right: attributes of left/center object
    - bottom: console, feedback, debugging
    - top-top: toolbar: settings, targets, run/stop

<a name="SWIFT"></a>
## SWIFT
<!-- swift => obj-c => code -->
<!-- main.c 'under the hood' -->
<!--  -->

- app lifecycle:
    - start : application(application:didFinishLaunchingWithOptions:)
    - inactive : applicationWillResignActive(application) - (phonecall, message, on way to BG)
    - to background: applicationDidEnterBackground(application:)
    - from background : applicationWillEnterForeground(application)
    - to active : applicationDidBecomeActive(application:)
    - exit : applicationWillTerminate(application:)

<!-- controller & view lifecycles -->
<!-- MVC design => keep as seperate as possible (encapsulate) -->

<!-- show steps: Info(plist)=>Main.storyboard=>ViewController.swift (window) -->
- simple examples

#### variables
```
var myVariable:Int = 5
myVariable = 9
```

#### constants
```
let MY_CONSTANT:Float = 3.141
```

#### if conditional
```
// IF + ELSE IF + ELSE
i = 2
if (i==0) {
    println("i==0")
} else if (i==1) {
    println("i==1")
} else {
    println("i==\(i)")
}
```

#### switch
```
var char:String = "A"
switch (char) {
    case "A":
        println("char == A");
    case "B":
        println("char == B");
    default:
        println("unknown value");
}
```

#### do while loop
```
var len:Int = 0
var i:Int = 0
do {
    println("i: \(i)")
    ++i
} while (i<len)
```
<!-- ensure loop is run at least once -->
#### while loop
```
var len:Int = 5
var i:Int = 0
while (i<len) {
    println("i: \(i)")
    ++i
}
```

#### for loop
```
var len:Int = 5
var i:Int = 0
for (i=0; i<len; ++i) {
    println("i: \(i)")
    if (i==2) {
        break; // stop early
    }
}
```

#### for-in loop
```
var stringList:Array = ["A","B","C","D","E"]
for (index, value) in enumerate(stringList) {
    if (index==1) {
        continue; // skip
    }
    println("\(index) = \(value)")
}
```

#### functions
_no parameters, no return value_
```
func printHelloWorld (Void) -> Void { // declaration / definition
    println("Hello World")
}

printHelloWorld() // call
```
<!-- don't need to specify voids -->
_parameters and return value_
```
func addIntegers (let integer a:Int,let toInteger b:Int) -> Int {
    var added:Int;
    added = a + b
    return added
}

var numberA:Int = 4;
var numberB:Int = 5;
var numberC:Int = addIntegers(integer:numberA, toInteger:numberB)
```
<!-- don't need to specify let, external param names-->

_functions as variables_
```
var functionVariable:(Int,Int)->Int = addIntegers
var result:Int = functionVariable(1,2)
```

_pass by reference_
```
func addIntegersByReference (inout result c:Int, inout integer a:Int, inout toInteger b:Int) -> Void {
    c = a + b
    a = 0
    b = 0
}

addIntegersByReference(result: &localC, integer: &localA, toInteger: &localB)
```

*example: random number*
```
var randomInt:Int = Int(arc4random_uniform(100)) // random number in [0,99]
println("random number: \(randomInt)")
```

#### objects & methods
_constants vs optional vs auto-unwrapped optional
```

```
<!-- auto unwrapped is closest think to a pointer -->

#### pass by value
- primitives, structs, arrays*

#### pass by reference
- objects (implicitly)

#### classes & inheritence & encapsulation
<!-- code reuse -->
_base class_
```
class Animal {
    var name:String!
    private var description:String! // println
    private var age:Int
    var sound:String!
    init (name:String="[Unnamed]", desc:String="An Animal", age:Int=0, sound:String="Garble") {
        self.name = name
        self.description = desc
        self.age = age
        self.sound = sound
    }
    deinit {
        name = nil
        description = nil
        age = -1
        sound = nil
    }
    func speak (Void) -> Void {
        println("\(name): \(sound)")
    }
    final func addYear(Void) -> Void {
        age += 1
    }
}
```
<!-- designated / convenience initializers -->
_inherited class_
```
class Cat: Animal {
    private var wiskerCount:Int;
    init (name:String="Kitty", desc:String="A Kitty Cat", age:Int=9, sound:String="Meow", wiskers:Int=0) {
        self.wiskerCount = wiskers
        super.init(name:name, desc:desc, age:age, sound:sound)
    }
    deinit {
        wiskerCount = 0
    }
    override func speak(Void) -> Void {
        println("Kitty Kat \(name) goes: \(sound) [wiskers: \(wiskerCount)]")
    }
    func wiskerUp(var add:Int){
        add = max(add,0)
        wiskerCount = wiskerCount + Int(add)
    }
}
```

_examples_
```
var animal:Animal!
var cat:Cat!
animal = Animal()
    animal.name = "Dragon"
    animal.addYear()
cat = Cat() // default 
cat = Cat(name:"Spot", desc:"Cute Kitty Cat", age:4, sound:"Mrrrrow", wiskers:24)
cat.wiskerUp(100)
    cat.wiskerUp(200)
animal.speak()
cat.speak()
```

_referencing_
```
animal = cat // general can point to specific [Cat isa Animal]
cat = animal // error - 
println("animal is Cat: \(animal is Cat)") // true
```


#### example project
SpriteKit: 2D rendering and physics
<!-- lot of different libraries, frameworks, etc -->

- physics / collisions ?



#### Other frameworks/libraries:


- box2d (physics)
- SceneKit (SpriteKit 3D Version)
- sparrow (open source obj-c)

- openglES (rendering : shader level)
- metal (rendering : shader level)

- Unity (3rd party multi-platform $)







## Where to go:

### Tutorials:
http://www.raywenderlich.com/tutorials
<br/>
https://itunes.apple.com/us/course/developing-ios-8-apps-swift/id961180099
<br/>

### Reference:
https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIKit_Framework/index.html
<br/>

### C to Swift Cheat Sheet:
http://appdesignvault.com/downloads/swift-cheat-sheet.pdf
<br/>
















