//
//  NotificationCenterSpy.h
// 
//  Created by Javier Soto on 9/13/11.
//
//  Description:
//  Allows you to see all notifications being posted by the Cocoa frameworks and by yourself before they get delivered.
//
//  Usage:
//  #import NotificationCenterSpy.h
//  [NSNotificationCenter toggleSpyingAllNotifications] to enable NSLogging all notifications being posted.
//  Call the method again to disable

#import <Foundation/Foundation.h>

@interface NotificationCenterSpy : NSObject

+ (void)toggleSpyingAllNotifications;

@end
