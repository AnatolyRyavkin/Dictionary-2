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
        //for real devace ->
    //NSString* nameTextFileInBandle = [[NSBundle mainBundle] pathForResource:@"arrayCommit.txt" ofType:nil];

    static AVMainManager*manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AVMainManager alloc]init];
        NSString*nameFileForArrayWork = @"/Users/ryavkinto/Documents/Objective C/Dictionary@2/Dictionary@2/arrayCommit.txt";
        manager.mainArray = [[NSArray alloc]initWithContentsOfFile:nameFileForArrayWork];

        //manager.mainArray = [[NSArray alloc]initWithContentsOfFile:nameTextFileInBandle];

        manager.arrayObjectWords = [[NSArray alloc]init];
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
