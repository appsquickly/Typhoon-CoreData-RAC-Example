//
//  main.m
//  CoreData+DI+RAC
//
//  Created by 和泉田 領一 on 2013/12/23.
//  Copyright (c) 2013年 CAPH. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CDRAppDelegate.h"
#import "OCLogTemplate.h"

int main(int argc, char * argv[])
{
    @autoreleasepool
    {
        int returnValue;
        @try
        {
            returnValue = UIApplicationMain(argc, argv, nil, NSStringFromClass([CDRAppDelegate class]));
        }
        @catch (NSException* exception)
        {
            LogError(@"Uncaught exception: %@, %@", [exception description], [exception callStackSymbols]);
            @throw exception;
        }
        return returnValue;
    }
}