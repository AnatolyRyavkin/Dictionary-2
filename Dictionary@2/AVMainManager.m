//
//  AVMainManager.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 01/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVMainManager.h"
#import <UIKit/UIKit.h>

@implementation AVMainManager

@synthesize mainArray = _mainArray;

+(id)managerData{
    static AVMainManager*manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AVMainManager alloc]init];
        manager.mainArray = [[NSArray alloc]initWithContentsOfFile:@"/Users/ryavkinto/Documents/Objective C/1/savedStringEndingData.txt"];
    });
    return manager;
}


-(void)removeStringAtIndexPath:(NSIndexPath*)indexPath{
    NSMutableArray*mainArr = [NSMutableArray arrayWithArray:self.mainArray];
    NSMutableArray*arr = [NSMutableArray arrayWithArray:self.mainArray[indexPath.section]];
    [arr removeObjectAtIndex:indexPath.row];
    [mainArr replaceObjectAtIndex:indexPath.section withObject:arr];
    self.mainArray = [NSArray arrayWithArray:mainArr];
}

@end
