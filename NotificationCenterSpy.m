//
//  NotificationCenterSpy.m
//
//  Created by Javier Soto on 9/13/11.
//

#import "NotificationCenterSpy.h"
#import <objc/runtime.h> 
#import <objc/message.h>

@implementation NSNotificationCenter (NotificationCenterSpy)

+ (void)swizzleMethods {
    Class c = [NSNotificationCenter class];
    SEL originalMethodSelector = @selector(postNotificationName:object:userInfo:);
    SEL newMethodSelector = @selector(spyNotificationName:object:userInfo:);
    
    Method newMethodImp = class_getInstanceMethod(self, newMethodSelector);
    if (newMethodImp != NULL) {
        class_addMethod(c, newMethodSelector, method_getImplementation(newMethodImp), method_getTypeEncoding(newMethodImp));
        newMethodImp = class_getInstanceMethod(c, newMethodSelector);
        
        if (newMethodImp != NULL) {
            Method originalMethodImp = class_getInstanceMethod(c, originalMethodSelector);
            method_exchangeImplementations(originalMethodImp, newMethodImp);
        }
    }
}

+ (void)toggleSpyingAllNotifications {    
    [self swizzleMethods];    
}

- (void)spyNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    NSLog(@"Posting notification %@", aName);

    [self spyNotificationName:aName object:anObject userInfo:aUserInfo];
}

@end