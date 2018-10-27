//
//  ViewController.m
//  LocalNotificationExampleiOS10
//
//  Created by Arasuvel Theerthapathy on 04/11/16.
//  Copyright © 2016 Arasuvel Theerthapathy. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - View Life Cycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scheduleLocalNotifications) name:@"SnoozeNotifcation" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods

- (IBAction)sampleButtonPressed:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            // Notifications allowed
             [self scheduleLocalNotifications];
        } else {
           // Notifications not allowed
        }
    }];
}

- (IBAction)sampleImageButtonPressed:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            // Notifications allowed
            [self scheduleLocalNotificationImage];
        } else {
            // Notifications not allowed
        }
    }];
}

- (IBAction)sampleVideoButtonPressed:(id)sender {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            // Notifications allowed
            [self scheduleLocalNotificationVideo];
        } else {
            // Notifications not allowed
        }
    }];
}

#pragma mark - Custom Methods

- (void)scheduleLocalNotifications {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    UNNotificationAction *snoozeAction = [UNNotificationAction actionWithIdentifier:@"Snooze"
                                                                              title:@"Snooze" options:UNNotificationActionOptionNone];
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"Delete"
                                                                              title:@"Delete" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"UYLReminderCategory"
                                                                              actions:@[snoozeAction,deleteAction] intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionNone];
    NSSet *categories = [NSSet setWithObject:category];
    
    [center setNotificationCategories:categories];
    
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Don't forget";
    content.body = @"Buy some milk";
    content.categoryIdentifier = @"UYLReminderCategory";
    content.sound = [UNNotificationSound defaultSound];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    NSString *identifier = @"UYLLocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
}

- (void)scheduleLocalNotificationImage {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"Close"
                                                                              title:@"Close" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"UYLReminderCategoryImage"
                                                                              actions:@[deleteAction] intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionNone];
    NSSet *categories = [NSSet setWithObject:category];
    
    [center setNotificationCategories:categories];
    
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"watch" ofType:@"png"];
    UNNotificationAttachment *imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"UYLReminderAttachmentImage" URL:[NSURL fileURLWithPath:moviePath] options:nil error:nil];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Watch";
    content.body = @"Watch is not paired";
    content.categoryIdentifier = @"UYLReminderCategoryImage";
    content.sound = [UNNotificationSound defaultSound];
    content.attachments = @[imageAttachment];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    NSString *identifier = @"UYLLocalNotificationImage";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
}

- (void)scheduleLocalNotificationVideo {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNNotificationAction *deleteAction = [UNNotificationAction actionWithIdentifier:@"Close"
                                                                              title:@"Close" options:UNNotificationActionOptionDestructive];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"UYLReminderCategoryVideo"
                                                                              actions:@[deleteAction] intentIdentifiers:@[]
                                                                              options:UNNotificationCategoryOptionNone];
    NSSet *categories = [NSSet setWithObject:category];
    
    [center setNotificationCategories:categories];
    
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"superquest" ofType:@"mp4"];
    UNNotificationAttachment *movieAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"UYLReminderAttachmentVideo" URL:[NSURL fileURLWithPath:moviePath] options:nil error:nil];
    
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"Demo";
    content.body = @"Description";
    content.categoryIdentifier = @"UYLReminderCategoryVideo";
    content.sound = [UNNotificationSound defaultSound];
    content.attachments = @[movieAttachment];
    
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    NSString *identifier = @"UYLLocalNotificationVideo";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
}

@end
