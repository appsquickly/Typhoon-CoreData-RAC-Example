//
//  CDRViewController.m
//  CoreData+DI+RAC
//
//  Created by 和泉田 領一 on 2013/12/23.
//  Copyright (c) 2013年 CAPH. All rights reserved.
//

#import "CDRViewController.h"
#import "CDRDataSource.h"
#import "OCLogTemplate.h"

@interface CDRViewController ()

@end

@implementation CDRViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapped:(id)sender
{
    NSLog(@"My datasource is: %@", _dataSource);
}

@end
