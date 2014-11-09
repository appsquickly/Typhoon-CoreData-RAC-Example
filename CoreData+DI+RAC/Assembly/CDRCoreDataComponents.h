//
// Created by rizumita on 2013/12/23.
//


#import <Foundation/Foundation.h>


@interface CDRCoreDataComponents : TyphoonAssembly

- (NSManagedObjectContext *)mainManagedObjectContext;

- (NSManagedObjectContext *)managedObjectContext;

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (NSFileManager *)fileManager;

- (NSArray *)applicationDocumentsDirectories;

- (id)applicationDocumentsDirectory;

- (NSURL *)storeURL;

- (NSManagedObjectModel *)managedObjectModel;

- (NSBundle *)mainBundle;

- (NSURL *)modelURL;

@end