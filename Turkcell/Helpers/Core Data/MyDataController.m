//
//  MyDataController.m
//  Turkcell
//
//  Created by Alaattin Bedir on 19.11.2017.
//  Copyright © 2017 Turkcell. All rights reserved.
//

#import "MyDataController.h"
#import <UIKit/UIKit.h>


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
    NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Turkcell.sqlite"];
    
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

- (void) saveProduct:(ProductMO *)product{
    NSManagedObjectContext *moc = self.managedObjectContext;
    
    ProductMO *productMO = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:moc];
    [productMO setValue:productMO.productId forKey:@"productId"];
    [productMO setValue:productMO.name forKey:@"name"];
    [productMO setValue:productMO.price forKey:@"price"];
    [productMO setValue:productMO.image forKey:@"image"];
    
    NSError *error;
    if (![moc save:&error]) {
        NSLog(@"Failed to save - error: %@", [error localizedDescription]);
    }

}

- (ProductMO*) getProduct:(NSNumber*) productId {
        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        NSManagedObjectContext *moc = self.managedObjectContext;
        fetch.entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:moc];
        fetch.predicate = [NSPredicate predicateWithFormat:@"productId == %@", productId];
        NSArray *array = [moc executeFetchRequest:fetch error:nil];
    
        if ([array count] > 0) {
            NSLog(@"%lu",(unsigned long)[array count]);
            ProductMO *product = (ProductMO*)moc;
            return product;
        }else{
            return nil;
        }
}


- (NSArray*) getProducts {
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *moc = self.managedObjectContext;
    fetch.entity = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:moc];
    NSArray *array = [moc executeFetchRequest:fetch error:nil];
    
    return array;
}



@end
