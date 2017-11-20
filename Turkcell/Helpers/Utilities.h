//
//  Utilities.h
//  Turkcell
//
//  Created by Alaattin Bedir on 20.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
+ (instancetype)sharedClient;
-(void)showMessage:(NSString*)message withTitle:(NSString *)title;

@end
