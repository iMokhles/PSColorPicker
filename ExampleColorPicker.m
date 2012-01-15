//
//  ExampleColorPicker.m
//  
//
//  Created by Ryan Coffman on 1/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExampleColorPicker.h"

@implementation ExampleColorPicker
-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Example Color";
    
}
-(NSString *)key {
    return @"ExampleColor";
    
}
-(NSString *)prefsPath {
    return @"/var/mobile/Library/Preferences/com.fr0zensun.example.plist";
    
}
-(UIColor *)defaultColor {
    return [UIColor colorWithRed:.14 green:.14 blue:.14 alpha:.5];
    
}
-(void)updateDict {
    [super updateDict];
    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterPostNotification(r,CFSTR("com.fr0zensun.example.updatePrefs"),NULL,NULL,kCFNotificationDeliverImmediately);
}

@end
