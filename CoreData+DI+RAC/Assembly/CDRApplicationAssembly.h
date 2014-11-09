//
// Created by rizumita on 2013/12/23.
//


#import <Foundation/Foundation.h>
#import "TyphoonAssembly.h"

@class CDRCoreDataComponents;
@class CDRDataSource;
@class CDRAppDelegate;
@class CDRViewController;


@interface CDRApplicationAssembly : TyphoonAssembly

@property(nonatomic, strong, readonly) CDRCoreDataComponents *coreDataAssembly;

- (CDRAppDelegate *)appDelegate;

- (CDRViewController *)mainViewController;

- (CDRDataSource *)dataSource;

@end