//
// Created by rizumita on 2013/12/23.
//


#import "CDRCoreDataComponents.h"


NSString *const NSManagedObjectContextSchedulerKey = @"NSManagedObjectContextSchedulerKey";

static char *NSManagedObjectContextAssociateKey;

@interface NSManagedObjectContext (InjectedInitialization)

@property(nonatomic, readwrite) RACScheduler *scheduler;

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
    persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type parentContext:(NSManagedObjectContext *)parentContext;

@end

@implementation NSManagedObjectContext (InjectedInitialization)

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
    persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    self = [self initWithConcurrencyType:type];
    if (self) {
        [self setPersistentStoreCoordinator:persistentStoreCoordinator];
    }
    return self;
}

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type parentContext:(NSManagedObjectContext *)parentContext
{
    self = [self initWithConcurrencyType:type];
    if (self) {
        self.parentContext = parentContext;
    }
    return self;
}

- (RACScheduler *)scheduler
{
    return self.userInfo[NSManagedObjectContextSchedulerKey];
}

- (void)setScheduler:(RACScheduler *)scheduler
{
    objc_setAssociatedObject(scheduler, NSManagedObjectContextAssociateKey, self, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@interface NSPersistentStoreCoordinator (InjectedInitialization)
- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model type:(NSString *)type URL:(NSURL *)storeURL
    options:(NSDictionary *)options;
@end


@implementation NSPersistentStoreCoordinator (InjectedInitialization)

- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model type:(NSString *)type URL:(NSURL *)storeURL
    options:(NSDictionary *)options
{
    self = [self initWithManagedObjectModel:model];
    if (self) {
        [self addPersistentStoreWithType:type configuration:nil URL:storeURL options:options error:nil];
    }
    return self;
}

@end


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