//
//  ViewController.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 29/09/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"


typedef void (^BlockExecution) (NSString* string, NSArray *array, int i, int j, NSArray *arrayMain);

@interface ViewController : UIViewController

@property BlockExecution block;

@property (nonatomic) AVMainManager*manager;

@property BOOL flagName;

@property (nonatomic) AVMeaningShortWords* sharedMeaningShortWords;

-(void)inputTable;


@end

