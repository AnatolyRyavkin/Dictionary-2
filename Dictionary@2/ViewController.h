//
//  ViewController.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 29/09/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "AVCreateBaseObjects.h"
#import "AVConstants.h"

@class AVSeparateStringAtComma;


NS_ASSUME_NONNULL_BEGIN


typedef void (^BlockExecution) (NSString* string, NSArray *array, int i, int j, NSArray *arrayMain);

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property BlockExecution block;

@property (nonatomic) AVMainManager*manager;

@property BOOL flagName;

@property (nonatomic) AVMeaningShortWords* sharedMeaningShortWords;

@property (nonatomic) NSArray* JSONObjects;

@property (nonatomic) NSArray* JSONObjectsReady;

@property UINavigationController *nc;

@property BOOL isCycle;

@property UIBarButtonItem *barButtonSeparateComma;
@property UIBarButtonItem *barButtonPrintRusMeaning;

@property AVSeparateStringAtComma *objectSeparateStringAtComma;

-(void)inputTable;

//-(NSArray*)makeJSONFromArrayObjectsAVEngWord: (NSArray<AVEnglWord*>*) arrayEngWordObjects;
-(NSArray*)makeJSONFromArrayObjectsAVEngWord1: (NSArray<AVEnglWord*>*) arrayEngWordObjects;

-(void)printObjectJSON: (NSDictionary*) objectDictionaryJSON;

-(void)printObjectJSONOnleEngMeaningAndRusMeaning: (NSDictionary*) objectDictionaryJSON;

-(void)printObjectJSONWithShortWord: (NSDictionary*) objectDictionaryJSON;

-(void)beginSeparateComma;

-(void)writeJSONInFile:(NSArray *) arrayWriting;



@end

NS_ASSUME_NONNULL_END
