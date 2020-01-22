//
//  ViewController.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 29/09/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "NSStrign+extension.h"
#import "AVCreateBaseObjects.h"
#import "AVSeparateStringAtComma.h"

#import "AVConstants.h"

typedef void (^BlockExecution) (NSString* string, NSArray *array, int i, int j, NSArray *arrayMain);

@interface ViewController : UIViewController

@property BlockExecution block;

@property (nonatomic) AVMainManager*manager;

@property BOOL flagName;

@property (nonatomic) AVMeaningShortWords* sharedMeaningShortWords;

@property (nonatomic) NSArray* JSONObjects;

@property (nonatomic) NSArray* JSONObjectsReady;

@property UINavigationController *nc;

@property BOOL isCycle;



@property UIBarButtonItem *barButtonSeparateComma;

-(void)inputTable;

//-(NSArray*)makeJSONFromArrayObjectsAVEngWord: (NSArray<AVEnglWord*>*) arrayEngWordObjects;
-(NSArray*)makeJSONFromArrayObjectsAVEngWord1: (NSArray<AVEnglWord*>*) arrayEngWordObjects;

-(void)printObjectJSON: (NSDictionary*) objectDictionaryJSON;

-(void)printObjectJSONOnleEngMeaningAndRusMeaning: (NSDictionary*) objectDictionaryJSON;

-(void)printObjectJSONWithShortWord: (NSDictionary*) objectDictionaryJSON;

-(void)beginSeparateComma;

-(NSArray *)separateArrayRusMeaning: (NSArray *) arrayOld;

-(void)writeJSONInFile:(NSArray *) arrayWriting;

-(void)isCycleEnd;

@end

