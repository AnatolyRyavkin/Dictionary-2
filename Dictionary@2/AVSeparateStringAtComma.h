//
//  AVSeparateStringAtComma.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 22.01.2020.
//  Copyright © 2020 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@class ViewController;


NS_ASSUME_NONNULL_BEGIN

@interface AVSeparateStringAtComma : NSObject

@property NSString *stringInput;
@property UINavigationController * nc;

@property UIViewController *vcCurrent;
@property ViewController *vcMain;

@property NSInteger numberObject;
@property NSInteger numberArrayRusObject;
@property NSInteger numberString;
@property NSInteger numberCheckComma;

@property NSArray *JSONReady;

@property NSMutableArray *JSONTemp;
@property NSMutableArray *arrayObjectsRusObjectsTemp;
@property NSMutableArray *arrayStringsRusMeaningTemp;
@property NSString *stringRusTemp;

@property NSMutableDictionary *dictionaryObjectTemp;
@property NSMutableDictionary *dictionaryRusMeaningTemp;
@property NSMutableDictionary *dictionaryRusMeaningRusTemp;


-(id)initNavigationController:(UINavigationController*) nc  andViewController:(UIViewController*) vc;
-(void)changeJSON: (NSArray*) JSONObjects;

-(void)needSeparate;
-(void)leaveAsIs;

@end

NS_ASSUME_NONNULL_END
