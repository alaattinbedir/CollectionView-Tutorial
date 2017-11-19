//
//  MyDataController.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "MyDataController.h"
#import <UIKit/UIKit.h>

#define PROGRAM 1
#define COURSE 2

@implementation MyDataController


//////////////////////////////////////////////////////
#pragma mark - Singleton Factory
//////////////////////////////////////////////////////

+ (instancetype)sharedClient {
    static MyDataController *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MyDataController alloc] init];
    });
    
    return _sharedClient;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initializeCoreData];
    }
    
    return self;
}

- (void)initializeCoreData
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Turkcell" withExtension:@"momd"];
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom != nil, @"Error initializing Managed Object Model");
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [moc setPersistentStoreCoordinator:psc];
    [self setManagedObjectContext:moc];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Akademim.sqlite"];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSError *error = nil;
        NSPersistentStoreCoordinator *psc = [[self managedObjectContext] persistentStoreCoordinator];
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
        NSAssert(store != nil, @"Error initializing PSC: %@\n%@", [error localizedDescription], [error userInfo]);
    });
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

//-(void) saveProgram:(MetaProgram *)program withCourse:(MetaCourse *)course{
//
//    NSManagedObjectContext *moc = APPDELEGATE.dataController.managedObjectContext;
//    NSMutableData *mdata = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mdata];
//    [archiver encodeObject:program.response forKey:@"program"];
//    [archiver finishEncoding];
//
//    // Check if program is saved before
//    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
//    fetch.entity = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:moc];
//    fetch.predicate = [NSPredicate predicateWithFormat:@"contentId == %ld", program.pageId];
//    NSArray *array = [moc executeFetchRequest:fetch error:nil];
//    if ([array count] == 0) {
//        // Save program
//        VideoMO *videoMO = [NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:moc];
//        [videoMO setValue:[NSNumber numberWithLong:program.pageId] forKey:@"contentId"];
//        [videoMO setValue:[NSNumber numberWithInt:0] forKey:@"parentId"];
//        [videoMO setValue:[NSNumber numberWithInt:PROGRAM] forKey:@"contentType"];
//        [videoMO setValue:mdata forKey:@"program"];
//        [videoMO setValue:[NSNumber numberWithLong:course.size] forKey:@"size"];
//
//    }else if ([array count] == 1){
//        // birden fazla egitim varsa total size hesaplaniyor
//        long totalBoyut = course.size;
//        for (NSManagedObject *managedObject in array){
//            VideoMO *video = (VideoMO*)managedObject;
//            totalBoyut += [[video valueForKey:@"size"] longValue];
//            [video setValue:[NSNumber numberWithLong:totalBoyut] forKey:@"size"];
//        }
//    }
//
//    fetch.predicate = [NSPredicate predicateWithFormat:@"contentId == %ld", course.pageId];
//    NSArray *arrayCourse = [moc executeFetchRequest:fetch error:nil];
//    if ([arrayCourse count] == 0) {
//        // Save course
//        VideoMO *courseVdeoMO = [NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:moc];
//        [courseVdeoMO setValue:[NSNumber numberWithLong:course.pageId] forKey:@"contentId"];
//        [courseVdeoMO setValue:mdata forKey:@"course"];
//        [courseVdeoMO setValue:[NSNumber numberWithInt:COURSE] forKey:@"contentType"];
//        [courseVdeoMO setValue:[NSNumber numberWithLong:program.pageId] forKey:@"parentId"];
//        [courseVdeoMO setValue:[NSNumber numberWithDouble:course.size] forKey:@"size"];
//        [courseVdeoMO setValue:course.videoId forKey:@"videoCode"];
//        [courseVdeoMO setValue:course.filePath forKey:@"path"];
//    }
//
//    NSError *error;
//    if (![moc save:&error]) {
//        DLog(@"Failed to save - error: %@", [error localizedDescription]);
//    }
//
////    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
////    fetch.entity = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:moc];
////    //fetch.predicate = [NSPredicate predicateWithFormat:@"telNo == %@", loggedInUser.msisdn];
////    NSArray *array = [moc executeFetchRequest:fetch error:nil];
////
////    if ([array count] > 0) {
////        DLog(@"%lu",(unsigned long)[array count]);
////
////        for (NSManagedObject *managedObject in array) {
////            VideoMO *video = (VideoMO*)managedObject;
////
////            NSData *data = [[NSMutableData alloc] initWithData:[video valueForKey:@"program"]];
////            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
////            NSDictionary *programDist=[unarchiver decodeObjectForKey:@"program"];
////            [unarchiver finishDecoding];
////
////            DLog(@"Program: %@",programDist);
////
////        }
////    }
//}
//
//-(void) saveCourse:(MetaCourse *)course{
//
//    NSManagedObjectContext *moc = APPDELEGATE.dataController.managedObjectContext;
//    NSMutableData *mdata = [[NSMutableData alloc] init];
//    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:mdata];
//    [archiver encodeObject:course.response forKey:@"course"];
//    [archiver finishEncoding];
//
//    VideoMO *videoMO = [NSEntityDescription insertNewObjectForEntityForName:@"Video" inManagedObjectContext:moc];
//    [videoMO setValue:[NSNumber numberWithLong:course.pageId] forKey:@"contentId"];
//    [videoMO setValue:mdata forKey:@"course"];
//    [videoMO setValue:[NSNumber numberWithInt:COURSE] forKey:@"contentType"];
//    [videoMO setValue:[NSNumber numberWithInt:0] forKey:@"parentId"];
//    [videoMO setValue:[NSNumber numberWithDouble:course.size] forKey:@"size"];
//    [videoMO setValue:course.videoId forKey:@"videoCode"];
//    [videoMO setValue:course.filePath forKey:@"path"];
//
//    NSError *error;
//    if (![moc save:&error]) {
//        DLog(@"Failed to save - error: %@", [error localizedDescription]);
//    }
//
////    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
////    fetch.entity = [NSEntityDescription entityForName:@"Video" inManagedObjectContext:moc];
////    //fetch.predicate = [NSPredicate predicateWithFormat:@"telNo == %@", loggedInUser.msisdn];
////    NSArray *array = [moc executeFetchRequest:fetch error:nil];
////
////    if ([array count] > 0) {
////        DLog(@"%lu",(unsigned long)[array count]);
////
////        for (NSManagedObject *managedObject in array) {
////            VideoMO *video = (VideoMO*)managedObject;
////
////            NSData *data = [[NSMutableData alloc] initWithData:[video valueForKey:@"course"]];
////            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
////            NSDictionary *courseDist=[unarchiver decodeObjectForKey:@"course"];
////            [unarchiver finishDecoding];
////
////            DLog(@"Course: %@",courseDist);
////
////        }
////    }
//}




@end
