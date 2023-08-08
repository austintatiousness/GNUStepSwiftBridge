This project is a Swift interface for GNUStep's version of AppKit. 

This project assumes that you are running OnFlapp's GNUStep Desktop project. To build, you need to install GNUStep Desktop [https://onflapp.github.io/gs-desktop/index.html] on Debian, then install Swift version 5.8.1 on Debian.

IMPORTANT: This assumes that file system layout of Onflapp's GNUstep Desktop environment. 

# GORM File and Info_gnustep.plist

I haven't yet figured out how to configure Swift to copy the files into the a folder called ```Resources``` within the same folder holds the built Swift executable. For now, just copy in the Resources folder into the .build/build/debug folder. 


# Targets
AppKit is a Swif tlibrary that wraps GNUStep's gui library. 
HelloWorld is my playground. It is often not working. 
NSWindowTest is to strictly test the code that creates NSWindow. It runs well!

# NOTES, ISSUES, IDEAS

### class GNUStepNSObjectWrapper
This is a class written in Swfit that is responsible to instantiate GNUStep ObjC classes. When it instantiates a new NSObject, it always calls retain. If it is just wrapping a alreday made pointer, currently it does not call retain. 

If you intend to wrap a new subclass of an existing NSObject, Objective-C object, then you need to implement ```GNUStepNSObjectSubclassConstructor``` first, then you can wrap that subclass.

### class GNUStepNSObjectSubclassConstructor
This class is responsible for adding new objects to the GNUStep ObjC runtime. Every new object that it creates gets an additional Ivar called ```___swiftPtr``` that hols a pointer to the Swift object that it wraps.

### objc_msgSend()
objc_msgSend() is a c function used by the Objective-C runtime to send messages. Unfortunately it has a variable arguments which cannot be imported into Swift. To overcome this, I have created some specialized versions of of objc_msgSend that have different number of arguments. These can be found in the ObjCSwiftInterop.c file.

Ultimately, I would like a swift version of this which more intelligently decides how to map the values. I started work on this, in the AppKit.swift file called ```func objc_smart_sendMessage<T>(object: NSObjectGNUStepSwiftBridge, selector: String,  value1: Any?, value2: Any?, value3: Any?, value4: Any?, value5: Any?, value6: Any?, value7: Any?, value8: Any?, value9: Any?) -> T?```

There is a lot of work to be done here. 

### retain and release
Currently, I have a class called ```GNUStepNSObjectWrapper``` that holds a reference to a NSObject in the GNUStep ObjC runtime. This object retains any NSObjects that is creates. However, we may get that same object back in the form of an ```id``` from the GNUStep ObjC2 runtime via a call to ```objc_msgSend``` or ```smart_swift_lookupIvar```. 

When we recieve that object we either have to (a) construct a new wrapper calss. This is easy, we can just call ```object_getClassName()``` and use the retrieved name to map it to a Swift class that will wrap that ```id``` or (b) we can take the ```id``` value and look up a Swift object that was already instantiated and wraps it. 

**Question 1:**
How do we manage retains? 

**Question 2**
What is the best way to store a table of the objects? How 
