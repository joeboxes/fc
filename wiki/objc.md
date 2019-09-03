# objc.md





OBJC SUMMARY:
https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Introduction/introObjectiveC.html

id anObject;


typedef struct objc_object {
    Class isa;
} *id;

typedef struct objc_class *Class;


[receiver message]

accessors:
self.age = 10;
[self setAge:10];


id rectClass = [Rectangle class];



#import <Foundation/Foundation.h>


.h: ..........................................................................................

@interface UrlConnection : NSObject
@property NSString *url;
- (void)connect;
+ (BOOL)canHandleRequest:(NSString *)type forUrl:(NSString *)url;

+ alloc;
- (void)display;

@end




.m: ..........................................................................................

#import "Rectangle.h"

@class Rectangle, Circle;


static MyClass *MCLSSharedInstance;
 

@interface ClassName : ItsSuperclass
// Method and property declarations.
@end

@implementation MyClass
{
	// instance variables
// default @package
	    char *name;
@private
    int age;
    char *evaluation;
@protected
    id job;
    float wage;
@public
    id boss;
}

 
+ (MyClass *)sharedInstance{
    // check for existence of shared instance
    // create if necessary
    return MCLSSharedInstance;
}

+ (void)initialize // static class initilizer
{
  if (self == [ThisClass class]) {
        // Perform initialization here.
        ...
    }
}

+ (id)rectangleOfColor:(NSColor *)color
{
    id newInstance = [[self alloc] init]; // EXCELLENT
    [newInstance setColor:color];
    return newInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        // Initialize self
    }
    return self;
}

- (void)dealloc {
    [myArray release];
    [super dealloc];
}

@end

protocol .............................................................................................

@protocol MyXMLSupport

// default required
- (void)requiredMethod;
- initFromXMLRepresentation:(NSXMLElement *)XMLElement;
- (NSXMLElement *)XMLRepresentation;
 
@optional
- (void)anOptionalMethod;
- (void)anotherOptionalMethod;
 
@required
- (void)anotherRequiredMethod;
@end
Unlike class names, protocol names don’t have global visibility. They live in their own namespace.


// informal

@interface NSObject ( MyXMLSupport )
- initFromXMLRepresentation:(NSXMLElement *)XMLElement;
- (NSXMLElement *)XMLRepresentation;
@end




@protocol ProtocolName < protocol list >

Protocol *myXMLSupportProtocol = @protocol(MyXMLSupport);


@interface ClassName : ItsSuperclass < protocol list >
...
@interface ClassName ( CategoryName ) < protocol list >
...



[object conformsToProtocol:...]

[object respondsToSelector:...]


id <MyXMLSupport> anObject;


@protocol B;

 .............................................................................................

@property (attributes) type name;

attributes: nonatomic weak strong assign copy retain readonly readwrite

getter=getterName
setter=setterName

==


@property float value;

//is equivalent to:

- (float)value;
- (void)setValue:(float)newValue;


- (void)setValue:(NSInteger)newX {
    value = newX;
    ???
    _value

}


@synthesize .. old
@synthesize someProperty = _someProperty = 10;

@dynamic



 .............................................................................................

// category
#import "ClassName.h"
 
@interface ClassName ( CategoryName )
// method declarations
@end



// Private extension, typically hidden in the main implementation file.
@interface MyClass ()
@property (retain, readwrite) float value;
@end



@interface MyClass : NSObject
- (float)value;
@end
 
 
@interface MyClass () {
    float value;
}
- (void)setValue:(float)newValue;
@end
 
@implementation MyClass
 
- (float)value {
    return value;
}
 
- (void)setValue:(float)newValue {
    value = newValue;
}
 
@end




@implementation XYZPerson (XYZPersonNameDisplayAdditions)
- (NSString *)lastNameFirstNameString {
    return [NSString stringWithFormat:@"%@, %@", self.lastName, self.firstName];
}
@end

...

#import "XYZPerson+XYZPersonNameDisplayAdditions.h"

 .............................................................................................
association ... ?

objc_setAssociatedObject

objc_getAssociatedObject

 .............................................................................................
NSArray *array = [NSArray arrayWithObjects:@"one", @"two", @"three", @"four", nil];
for (NSString *element in array){
	NSLog(@"element: %@", element);
}

NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"quattuor", @"four", @"quinque", @"five", @"sex", @"six", nil];
 
NSString *key;
for (key in dictionary) {
    NSLog(@"English: %@, Latin: %@", key, [dictionary objectForKey:key]);
}


NSEnumerator *enumerator = [array reverseObjectEnumerator];
for (NSString *element in enumerator) {
    if ([element isEqualToString:@"three"]) {
        break;
    }
}
 
NSString *next = [enumerator nextObject];


NSArray *array = <#Get an array#>;
NSUInteger index = 0;
 
for (id element in array) {
    NSLog(@"Element at index %u is: %@", index, element);
    index++;
}

 .............................................................................................

SEL setWidthHeight;
setWidthHeight = @selector(setWidth:height:);

setWidthHeight = NSSelectorFromString(aBuffer);

NSString *method;
method = NSStringFromSelector(setWidthHeight);

id   helper = getTheReceiver();
SEL  request = getTheSelector();
[helper performSelector:request];
 .............................................................................................

@try {
    [cup fill];
}
@catch (CustomException *ce) {   // 1
    ...
}
@catch (NSException *exception) { // 2
    NSLog(@"main: Caught %@: %@", [exception name], [exception reason]);
}
@finally {
    [cup release];
}



NSException *exception = [NSException exceptionWithName: @"HotTeaException"
                                                 reason: @"The tea is too hot"
                                               userInfo: nil];
@throw exception;



 .............................................................................................

- (void)criticalMethod
{
    @synchronized(self) {
        // Critical code.
        ...
    }
}

 .............................................................................................
	NSNumber *magicNumber = @42;
    NSNumber *longNumber = @42l;
    NSNumber *boolNumber = @YES;
    NSNumber *simpleFloat = @3.14f;
    NSNumber *betterDouble = @3.1415926535;
    NSNumber *someChar = @'T';

        int scalarMagic = [magicNumber intValue];
    unsigned int scalarUnsigned = [unsignedNumber unsignedIntValue];
    long scalarLong = [longNumber longValue];
 
    BOOL scalarBool = [boolNumber boolValue];
 
    float scalarSimpleFloat = [simpleFloat floatValue];
    double scalarBetterDouble = [betterDouble doubleValue];
 
    char scalarChar = [someChar charValue];


        NSString *mainString = @"This is a long string";
    NSRange substringRange = [mainString rangeOfString:@"long"];
    NSValue *rangeValue = [NSValue valueWithRange:substringRange];


        NSArray *someArray = @[firstObject, secondObject, thirdObject];

	NSNull

	NSArray *array = @[ @"string", @42, [NSNull null] ];

	NSArray *unsortedStrings = @[@"gammaString", @"alphaString", @"betaString"];
    NSArray *sortedStrings = [unsortedStrings sortedArrayUsingSelector:@selector(compare:)];
	
	[mutableArray sortUsingSelector:@selector(caseInsensitiveCompare:)];

	NSSet *simpleSet = [NSSet setWithObjects:@"Hello, World!", @42, aValue, anObject, nil];

	NSDictionary *dictionary = @{
		@"anObject" : someObject,
		};

	BOOL success = [array writeToURL:fileURL atomically:YES];
	NSArray *array = [NSArray arrayWithContentsOfURL:fileURL];




 .............................................................................................
^{
         NSLog(@"This is a block");
 }

 void (^simpleBlock)(void);

simpleBlock = ^{
        NSLog(@"This is a block");
    };

void (^simpleBlock)(void) = ^{
        NSLog(@"This is a block");
    };

simpleBlock();

...

double (^multiplyTwoValues)(double, double);

^ (double firstValue, double secondValue) {
    return firstValue * secondValue;
}
^ double (double firstValue, double secondValue) {
    return firstValue * secondValue;
}
double result = multiplyTwoValues(2,4);


__block int anInteger = 42;
void (^testBlock)(void) = ^{
    NSLog(@"Integer is: %i", anInteger);
};
anInteger = 84;
testBlock(); // Integer is: 84

typedef void (^XYZSimpleBlock)(void);

XYZSimpleBlock anotherBlock = ^{
    ...
};

@interface XYZObject : NSObject
@property (copy) void (^blockProperty)(void);
@end

...
self.block = ^{
    [weakSelf doSomething];   // capture the weak reference to avoid the reference cycle
}

NSArray *array = ...
    [array enumerateObjectsUsingBlock:^ (id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"Object at index %lu is %@", idx, obj);
    }];


 .............................................................................................

NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
    ...
}];

// schedule task on main queue:
NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
[mainQueue addOperation:operation];
 
// schedule task on background queue:
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
[queue addOperation:operation];

dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

dispatch_async(queue, ^{
    NSLog(@"Block for asynchronous execution");
});



if (NSThread.isMainThread) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}



 .............................................................................................

	NSString *domain = @"com.MyCompany.MyApplication.ErrorDomain";
	NSString *desc = NSLocalizedString(@"Unable to…", @"");
	NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : desc };
NSError *error = [NSError errorWithDomain:domain code:-101 userInfo:userInfo];
 .............................................................................................



 .............................................................................................



 .............................................................................................

NSWindow

CAAnimation

NSWindowController

NSManagedObjectContext


NSMutableArray *array = [[NSMutableArray alloc] init];
NSMutableArray *array = [NSMutableArray new];
NSMutableArray *array = [NSMutableArray array];
 .............................................................................................






https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Category.html


https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/CustomizingExistingClasses/CustomizingExistingClasses.html


https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/Blocks/Articles/bxGettingStarted.html






...