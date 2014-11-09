//
//  CDRAppDelegate.h
//  CoreData+DI+RAC
//
//  Created by 和泉田 領一 on 2013/12/23.
//  Copyright (c) 2013年 CAPH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDRAppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@end
