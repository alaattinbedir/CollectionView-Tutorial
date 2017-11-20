//
//  Utilities.m
//  Turkcell
//
//  Created by Alaattin Bedir on 20.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "Utilities.h"
#import <UIKit/UIKit.h>



@implementation Utilities

//////////////////////////////////////////////////////
#pragma mark - Singleton Factory
//////////////////////////////////////////////////////

+ (instancetype)sharedClient {
    static Utilities *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Utilities alloc] init];
    });
    
    return _sharedClient;
}


-(void)showMessage:(NSString*)message withTitle:(NSString *)title
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:title
                                  message:message
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        //do something when click button
    }];
    [alert addAction:okAction];
    UIViewController *vc = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
