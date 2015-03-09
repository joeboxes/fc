
--------------------------------------------------
==================================================
--------------------------------------------------



# DROPPED FOR MORE INVOLVED



1. [universal concepts](#101)
2. [C](#C)
3. [Obj-C](#ObjC)
4. [inheritance](#classes)
5. [IDE](#IDE)
6. [VC](#VC)
7. [Languages](#languages)




<!-- arithmetic and logic unit -->
#### ALU
<!-- very close and very fast -->
operates using small set of local registers (32~64), only some of which may be available for a program to use.
<br />
```
    +----------+     +----------+      \    \    /    /            |
 A: | xxxxxxxx |  B: | yyyyyyyy |       \    |  |    /         [ CLOCK]---..
    +----------+     +----------+        \   |  |   /
         |                 |              |  |  |  |
         ------\   /--------              |  |  |  |
                [x]--------------------- [ OPERATION ]---..
                 |                             ^
                 v                             |              |   |   |  
    +-------------------+     +-------------------+     +-------------------+
  D:| zzzzzzzz zzzzzzzz |  PC:| xxxxxxxx xxxxxxxx |  IR:| xxxxxxxx xxxxxxxx |
    +-------------------+     +-------------------+     +-------------------+
           |   |   |                 |   |   |                |   |   |
```
<br />
operation registers: inputs to be used in an operation
<br />
accumulator register: result of operation
<br />
program counter: keeps track of current location in program. You can jump around in 
<br />
<!-- 0s and 1s of IR correspond to circuitry to de/activate appropriate channels -->
instruction register: keeps track of the currecnt instruction

#### code chain
```
                           (more general)
visual programming          ^ more human-friendly   
human-readable languages    ^                          v
[compiler / interpreter]    ^                          v
assembly code               ^                          v
machine code                    more control/exactness v
                            (more HW-circuit-correlation)
```

#### caching
It takes time to access data, so instead of throwing away data that might be used again (in the near future), why not keep it around if you have some space to put it locally?
```
CPU registers      [words]          faster, smaller, expensive
CPU L1 cache       [~8MB]            ^
CPU L2 cache       [~16MB]           |
CPU L3 cache       [~16MB]           |
RAM                [~32GB]           |
HDD Cache          [~32MB]           |
HDD                [~2TB]            |
backup tape-drives [~100TB]          v
internet           [~EB]            slower, bigger, cheap
```


- cold-start
- cache-hit
- cache-miss




<!-- Objective-C Examples .................................................................. -->
<a name="ObjC"></a>
## Obj-C
### objects
- operations / interactions


#### class vs instance


<!-- closure = env+control -->
#### blocks

pseudo-objects (NSInteger, CGFloat, NSNumber, ...)


#### complex equality
address? (exact object)
equalness of separate objects

### main
- 
```
int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([DIAppDelegate class]));
    }
}
```
AppAdelegate
```
...
-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
-(void)applicationWillEnterForeground:(UIApplication *)application;
-(void)applicationDidEnterBackground:(UIApplication *)application;
-(void)applicationWillTerminate:(UIApplication *)application;
...
```

### libraries


.framework (general container)



- "frameworks" ~ templates
    - certain way of doing things
- APIs (Application Programmer Interface)
    - set of calls / classes / operations you can used focused around some purpose



<!-- Classes Examples .................................................................. -->
<a name="classes"></a>
## inheritance

extending/reusing code

#### Classes

#### prototype chain
*JavaScript*

#### singletons
   - sharedInstance, defaultInstance, 

<!-- IDE Examples .................................................................. -->
<a name="IDE"></a>
## IDE
*Integrated Development Environment*

#### XCode vs AppCode


#### Eclipse vs Android Studio

#### text editors / alternatives
**Notepad**
<br/>
- 

**SublimeText**
<br/>
- syntax highlighting, auto-completion

combine with command-line / OS calls




<!--  .................................................................. -->
## Concurrency / Parallelism

#### processes

#### threads

#### asynchronous calls


#### events
   - message bus
   - dispatch
   - notification center
   - 


## preprocessing

### compiler directives

#### import

#### macros

#### pragma

#### if/def

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
YAML
- human readable, 1:1 data-to-objects, complex referencing/indexing, spacing semantics
```
myobj &myObject
    "A" : "val"
    "B" : 5
ref *myObject

```


#### methods
<!-- method and function = synonyms -->
methods are functions that are oriented toward objects
```
```



#### NULL
Ways to represent 'nothingness' or object does not exist
<br/>
0, null, NULL, nil, Nil, undefined

#### functions as variables (and typedef)
<!-- notice how cumbersome and tedius and confusing C can get -->
```
```

#### void-star (and type-casting)
```
void* pointer;
int original = 0x1234567890;
pointer = &original;
float floatVal = (float)pointer;
```



##### memory management
<!-- pointer / array equivalence -->
```
// double array

```

