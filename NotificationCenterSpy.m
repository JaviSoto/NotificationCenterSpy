//
//  NotificationCenterSpy.m
//
//  Created by Javier Soto on 9/13/11.
//

#import "NotificationCenterSpy.h"

static NotificationCenterSpy *sharedInstance = nil;

@interface NotificationCenterSpy ()

@property (nonatomic, assign, getter=isSpying) BOOL spying;
- (void)toggleSpyingAllNotifications;

@end

@implementation NotificationCenterSpy

@synthesize spying;

+ (NotificationCenterSpy *)sharedNotificationCenterSpy {
	
	static dispatch_once_t sharedToken;
	dispatch_once(&sharedToken, ^{
		sharedInstance = [[self alloc] init];
	});
	
    return sharedInstance;
}

+ (void)toggleSpyingAllNotifications {    
    [[self sharedNotificationCenterSpy] toggleSpyingAllNotifications];
}

- (void)toggleSpyingAllNotifications {
	
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
	if (self.spying) {
		[nc removeObserver:self];
		self.spying = NO;
	} else { 
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:) name:nil object:nil];
		self.spying = YES;
	}
}

- (void)receivedNotification:(NSNotification *)notification {
	NSLog(@"Received notification: %@", [notification name]);
	//NSLog(@"Received notification: %@ from object: %@", [notification name], [notification object]);
}

@end