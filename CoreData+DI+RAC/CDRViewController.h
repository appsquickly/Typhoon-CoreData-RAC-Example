//
//  CDRViewController.h
//  CoreData+DI+RAC
//
//  Created by 和泉田 領一 on 2013/12/23.
//  Copyright (c) 2013年 CAPH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CDRDataSource;

@interface CDRViewController : UIViewController

@property(nonatomic, strong) CDRDataSource *dataSource;

- (IBAction)buttonTapped:(id)sender;

@end
