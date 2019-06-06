# Coding 102

<br />

<br />

## Object Oriented Programming (OOP)
_All programming is done on 'objects' (purely functional languages are objects in the abstract too)_


The distinction is more about the support languages have for typical (organizational) ways of handling object-based tasks

- an object's state is more of a concept in OOP, whereas state is more inferred in FP


contrasting OOP & 'functional' (FP):

OOP:
```
class Person {
    var name: String
    var age: Int
    var male: Boolean
    var speak = function(){
        console.log("hi "+name);
    }
}
person.speak();
```

FUNCTIONAL:
```
person = ["Richie", 30, true]
var speak = function(person){
    console.log("hi "+person[0]);
}
```

C-structs are sort of an in-between of OOP and FP:
- entities with common attributes are organized in contiguous memory chunks
- entities are still passed to functions

swift-structs fuzzy the waters even more


There are benefits you get from OOP:
- object inheritance / extensions
- encapsulation
- reference semantics (language dependent)
- isolating purposes/functionality -- do one thing well, reusable




## Protocols / Interfaces

An interface is the set of functions/methods/properties you can do to an object, eg:
```
cat.jump();
cap.name = "steve";
```

- All you really care about an object is what operations you can do to/on it
- An interface is an agreed-upon list, declared in statically-typed languages
- A CLASS is an interface PLUS other stuff (inheritance paradigm, state/encapsulation, ...)



## Closures

A Closure is a:
- executing context (variables/references)
- list of instructions/statements/operations

- all references are copied at time of 'creation'
    - capture


- some 'suggested' uses:
    - data privacy

-



## Reference / Value | Types / Semantics


array of references:
```
[ #12345, #12346 , ... ]
```

array of values:
```
[ ["Sam"|16|false] , ["Jim"|20|false] , ... ]
```

reference:
- create when needed: efficient memory management
- uniqueness
- single reference on stack frame


value:
-
- security / immutability
- add to stack frame





## Memory Stack / Heap

function calls increase the stack

allocated items increase the heap




```

++++++++++++++++++++++
Stack   [call stack, execution stack, runtime stack]
|
v
------------------------ ^-outer v-inner
Stack Frame:            < frame pointer (register) |

- return address [next execution statement location]
- passed parameters [arguments, this]
- local variables [i, computed] (compile time size / small enough)
- OS/arch stuff [eg: red zone, debugger] (leaf fxns)
------------------------ < stack pointer



------------------------
...
object
...
------------------------
s
t
r
i
n
g
------------------------
double-float
...
------------------------
int
------------------------
^
|
Heap
++++++++++++++++++++++++

```



# Dependency injection
- allow to change object's internal params / objects / dependencies
- programming paradigm for loose-coupling allowing for more general reuse
- allow for testing - check that methods were accessed / correct values get/set


# Delegates
- objects of a particular interface (protocol)
- important/useful events (messages/functions) sent
- responsible for acting on behalf / complete tasks


# Access control
- open: public + extending/overriding
- public: available to outside modules
- internal: (default) inside module
- private: edit inside the scope
- file-private: edit inside the entire file


# Recursion
- divide the problem into a core part with attachments to same operation
- examples:
    - JSON / YAML / ... parsing
    - neighborhood system: cells
- ending conditions
- possibly not-directly recursive (callA->callB->callC->callA)


# Big O
- way to estimate the time it takes for algorithm to run
- helps determine minimum possible algorithm time
- c , log(n), n, n*log(n), n^2, n^i, ..., i^n
- examples:
    - linear search (find maximum): N = O(n)
    - binary search: lg(N) = O(log(n))
    - lookup search: c = O(1)
    - pairing 2 arrays: N^2 (N*(N-1)/2)
    - ?: N*logN
- Theta = lower bound (minimum)
- O = upper bound
- Sigma = typical/exact
- amortized ~ averaged [eg sort/update before searches]



# Completion Handlers
- blocking / nonblocking
- want to perform an operation when some async task has completed
    - networking, reading file, complicated processing, other resource preparing/initing
- fxns / blocks / closures


# Class-Level properties / methods
- static
- classes are defined at compile-time and avail for referencing







# Unowned self
- reference cycles
strong = add to ARC
weak = don't add to ARC  (optionals nil pointerswhen deallocated)
unowned = don't add to ARC + nonoptional (non-optional, possibly dangling pointers) [unsafe_unretained]
    - used for mutual dependence
...


TODO: BLOCK EXAMPLE


# When to use: do, try, catch, throws

- utility function and really not sure what do do if something isn't in the correct state


func functionThrows() throws -> Int {
    ...
}

do {
    let str = try functionThrows()
} catch is ErrorType.A {
    print("error A")
} catch is ErrorType.B {
    print("error B")
} catch let error {
    print("error other")
}


*try*: let str = try functionThrows()
=> either inside a do-catch OR the containing block/func must state `throws`

*try?*: let str = try? functionThrows()
=> if an error is thrown, it is ignored

*try!*: let str = try! functionThrows()
=> force crash the app



# DispatchQueue and threads

https://developer.apple.com/documentation/dispatch/dispatchqueue
https://developer.apple.com/library/archive/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html
https://www.raywenderlich.com/5370-grand-central-dispatch-tutorial-for-swift-4-part-1-2
https://www.raywenderlich.com/5371-grand-central-dispatch-tutorial-for-swift-4-part-2-2
https://theswiftdev.com/2018/07/10/ultimate-grand-central-dispatch-tutorial-in-swift/


Grand Central Dispatch (GCD) -- perform sync / async operations
- thread pool
- serial / concurrent
- sync / async -- blocking / nonblocking
- completion blocks
[sync on the main queue === crash]

THREADS / THREADING:
- start order vs complete order
- semaphore: ?



main queue: serial
global queues: high, default, low, background - [priority]
custom queues

```
DispatchQueue.main.async {
    ...
}

DispatchQueue.concurrentPerform(iterations: 5) { (i) in
    print(i)
}
```

DispatchWorkItem / .notify() / .cancel()
DispatchGroup / .enter / .leave / .wait
DispatchSemaphore / .signal() / .wait()
DispatchQueue
DispatchSource



https://gist.github.com/sgr-ksmt/4880c5df5aeec9e558622cd6d5b477cb





# LAZY VARIABLES
- aren't closures...
```
lazy var name: String = {
    return "lazy"
}()
```



design patterns:
	singleton
	factory methods
	builder
	decorator
	adapter
	facade
	bridge
	wrapper
	observer
	memento
	MVC | MVVM | MVI | VIPER
	dependency injection > testing

	extensions
	delegate
	composite
	iterator
	mediator
	proxy
	template


objectivec runtime:
	/usr/lib/libobjc.A.dylib.
	https://cocoasamurai.blogspot.com/2010/01/understanding-objective-c-runtime.html
	https://cocoasamurai.blogspot.com/2010/01/understanding-objective-c-runtime.html




References:
<br/>
https://en.wikipedia.org/wiki/Call_stack
<br/>
http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch10s07.html
<br/>
https://eli.thegreenplace.net/2011/09/06/stack-frame-layout-on-x86-64
<br/>

<br/>
















































...
