//#import "MBProxyObjC.h"
//
//@interface MBProxyObjC
//
//@property (nonatomic, readonly) id object;
//
//@end
//
//@implementation MBProxyObjC
//
//- (instancetype)initWithObject:(id)object {
//    self.object = object
//    return self;
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if ([self.object respondsToSelector:aSelector]) {
//        return self.object;
//    } else {
//        return nil;
//    }
//}
//
//- (BOOL)respondsToSelector:(SEL)aSelector {
//    if ([self.object respondsToSelector:aSelector]) {
//        return YES;
//    } else {
//        return NO;
//    }
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation {
//    [invocation invokeWithTarget:self.object];
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
//    return [self.object methodSignatureForSelector:sel];
//}
//
//@end
