//
//  MyDataController.h
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MyDataController : NSObject

@property (strong) NSManagedObjectContext *managedObjectContext;

+ (instancetype)sharedClient;
- (void)initializeCoreData;
-(void)showMessage:(NSString*)message withTitle:(NSString *)title;
//- (void) saveProgram:(MetaProgram *)program withCourse:(MetaCourse *)course;
//- (void) saveCourse:(MetaCourse *)course;

@end
