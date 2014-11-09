//
// Created by rizumita on 2013/12/23.
//


#import <Foundation/Foundation.h>


@interface CDRCoreDataComponents : TyphoonAssembly

- (id)mainManagedObjectContext;

- (id)managedObjectContext;

- (id)persistentStoreCoordinator;

- (id)fileManager;

- (id)applicationDocumentsDirectories;

- (id)applicationDocumentsDirectory;

- (id)storeURL;

- (id)managedObjectModel;

- (id)mainBundle;

- (id)modelURL;

@end