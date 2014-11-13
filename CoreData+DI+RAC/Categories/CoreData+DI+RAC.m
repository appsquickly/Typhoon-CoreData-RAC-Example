////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2014 Code Monastery Pty Ltd
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of Code Monastery
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////



#import "CoreData+DI+RAC.h"

NSString *const NSManagedObjectContextSchedulerKey = @"NSManagedObjectContextSchedulerKey";
static char *NSManagedObjectContextAssociateKey;


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