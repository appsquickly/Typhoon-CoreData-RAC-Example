//
// Created by rizumita on 2013/12/23.
//


#import "CDRCoreDataComponents.h"
#import "CoreData+DI+RAC.h"


@implementation CDRCoreDataComponents

- (NSManagedObjectContext *)mainManagedObjectContext
{
    return [TyphoonDefinition withClass:[NSManagedObjectContext class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithConcurrencyType:persistentStoreCoordinator:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@(NSMainQueueConcurrencyType)];
            [initializer injectParameterWith:self.persistentStoreCoordinator];
        }];
        definition.scope = TyphoonScopeLazySingleton;
    }];
}

- (NSManagedObjectContext *)managedObjectContext
{
    return [TyphoonDefinition withClass:[NSManagedObjectContext class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithConcurrencyType:parentContext:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:@(NSPrivateQueueConcurrencyType)];
            [initializer injectParameterWith:self.mainManagedObjectContext];
        }];
    }];
}

#pragma mark - Persistent store coordinator

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    return [TyphoonDefinition withClass:[NSPersistentStoreCoordinator class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithManagedObjectModel:type:URL:options:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:self.managedObjectModel];
            [initializer injectParameterWith:NSSQLiteStoreType];
            [initializer injectParameterWith:self.storeURL];
            [initializer injectParameterWith:nil];
        }];
    }];
}

- (NSFileManager *)fileManager
{
    return [TyphoonDefinition withClass:[NSFileManager class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(defaultManager)];
    }];
}

- (NSArray *)applicationDocumentsDirectories
{
    return [TyphoonDefinition withFactory:[self fileManager] selector:@selector(URLsForDirectory:inDomains:)
        parameters:^(TyphoonMethod *factoryMethod) {
            [factoryMethod injectParameterWith:@(NSDocumentationDirectory)];
            [factoryMethod injectParameterWith:@(NSUserDomainMask)];
        }];
}

- (id)applicationDocumentsDirectory
{
    return [TyphoonDefinition withFactory:[self applicationDocumentsDirectories] selector:@selector(lastObject)];
}

- (NSURL *)storeURL
{
    return [TyphoonDefinition withFactory:[self applicationDocumentsDirectory] selector:@selector(URLByAppendingPathComponent:)
        parameters:^(TyphoonMethod *factoryMethod) {
            [factoryMethod injectParameterWith:TyphoonConfig(@"coredata.sqlite")];
        }];
}

#pragma mark - Managed object model

- (NSManagedObjectModel *)managedObjectModel
{
    return [TyphoonDefinition withClass:[NSManagedObjectModel class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(initWithContentsOfURL:) parameters:^(TyphoonMethod *initializer) {
            [initializer injectParameterWith:self.modelURL];
        }];
    }];
}

- (NSBundle *)mainBundle
{
    return [TyphoonDefinition withClass:[NSBundle class] configuration:^(TyphoonDefinition *definition) {
        [definition useInitializer:@selector(mainBundle)];
    }];
}

- (NSURL *)modelURL
{
    return [TyphoonDefinition withFactory:[self mainBundle] selector:@selector(URLForResource:withExtension:)
        parameters:^(TyphoonMethod *factoryMethod) {
            [factoryMethod injectParameterWith:TyphoonConfig(@"coredata.filename")];
            [factoryMethod injectParameterWith:@"momd"];
        }];
}

@end


