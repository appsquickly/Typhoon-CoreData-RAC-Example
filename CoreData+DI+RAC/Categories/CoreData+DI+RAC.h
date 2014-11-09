////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2014 Code Monastery Pty Ltd
//  All Rights Reserved.
//
//  NOTICE: This software is the proprietary information of Code Monastery
//  Use is subject to license terms.
//
////////////////////////////////////////////////////////////////////////////////



#import <Foundation/Foundation.h>

@interface NSManagedObjectContext (InjectedInitialization)

@property(nonatomic, readwrite) RACScheduler *scheduler;

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type
    persistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

- (instancetype)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)type parentContext:(NSManagedObjectContext *)parentContext;

@end


@interface NSPersistentStoreCoordinator (InjectedInitialization)

- (instancetype)initWithManagedObjectModel:(NSManagedObjectModel *)model type:(NSString *)type URL:(NSURL *)storeURL
    options:(NSDictionary *)options;

@end