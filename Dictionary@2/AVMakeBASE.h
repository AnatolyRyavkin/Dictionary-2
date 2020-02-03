//
//  AVMakeBASE.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 14/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVMainManager.h"
//#import "NSStrign+extension.m"


NS_ASSUME_NONNULL_BEGIN

@interface AVMakeBASE : NSObject

@property AVMeaningShortWords *managerMeaningShort;

@property AVMainManager *manager;
@property NSArray<AVEnglWord*>* arrayEngWords;


-(void)makeEngWordsObjFromArrayStrings:(NSArray*) array;
-(NSArray<AVEnglWord*>*)makeArrayEngWordFromArrayArrray: (NSArray*)mainArray;
@end

NS_ASSUME_NONNULL_END
