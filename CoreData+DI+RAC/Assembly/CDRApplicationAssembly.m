//
// Created by rizumita on 2013/12/23.
//


#import "CDRApplicationAssembly.h"
#import "CDRCoreDataComponents.h"
#import "CDRDataSource.h"
#import "CDRAppDelegate.h"
#import "CDRViewController.h"


@implementation CDRApplicationAssembly

- (id)config
{
    return [TyphoonDefinition configDefinitionWithName:@"Configuration.properties"];
}

- (CDRAppDelegate *)appDelegate
{
    return [TyphoonDefinition withClass:[CDRAppDelegate class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(managedObjectContext) with:[self.coreDataAssembly managedObjectContext]];
        [definition injectProperty:@selector(managedObjectModel) with:[self.coreDataAssembly managedObjectModel]];
        [definition injectProperty:@selector(persistentStoreCoordinator) with:[self.coreDataAssembly persistentStoreCoordinator]];
    }];
}

- (CDRViewController *)mainViewController
{
    return [TyphoonDefinition withClass:[CDRViewController class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(dataSource) with:[self dataSource]];
    }];
}


- (CDRDataSource *)dataSource
{
    return [TyphoonDefinition withClass:[CDRDataSource class] configuration:^(TyphoonDefinition *definition) {
        [definition injectProperty:@selector(context) with:[self.coreDataAssembly mainManagedObjectContext]];
        definition.scope = TyphoonScopeSingleton;
    }];
}

@end