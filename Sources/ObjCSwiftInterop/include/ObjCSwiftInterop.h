#import "../../../Headers/objc/runtime.h"
#import "../../../Headers/objc/objc.h"
#import "../../../Headers/objc/message.h"
#import "../../../Headers/objc/objc-runtime.h"
#import "../../../Headers/objc/runtime.h"
#import "../../../Headers/objc/objc-arc.h"
#import "../../../Headers/objc/objc-class.h"
#import "../../../Headers/objc/capabilities.h"
#import "../../../Headers/objc/encoding.h"
#import "../../../Headers/objc/objc-auto.h"
#import "../../../Headers/objc/hooks.h"

#import "../../../Headers/objc/objc-visibility.h"

typedef unsigned long NSUInteger;

id forSwift_objcSendMessage(id ID, SEL cmd);
id forSwift_objcSendMessage1(id ID, SEL cmd, void const *arg1);
id forSwift_objcSendMessageCString(id ID, SEL cmd, const char* bytes);
id forSwift_objcSendMessage2(id ID, SEL cmd, void const *arg1, void const *arg2);
id forSwift_objcSendMessage3(id ID, SEL cmd, void const *arg1, void const *arg2, void const *arg3);
id forSwift_objcSendMessage4(id ID, SEL cmd, void const *arg1, void const *arg2, void const *arg3, void const *arg4);