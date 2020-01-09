//
//  AVCreateBaseObjects.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 26/11/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVMainManager.h"
#import "NSStrign+extension.m"
#import "AVPhrasalVerb.h"

NS_ASSUME_NONNULL_BEGIN

@interface AVCreateBaseObjects : NSObject

@property AVMeaningShortWords *managerMeaningShort;

@property AVMainManager *manager;

@property NSArray<AVEnglWord*>* arrayEngWords;

-(NSArray<AVEnglWord*>*)makeArrayEngFromMainArrayAtArrayWords: (NSArray*)mainArray;


@end

NS_ASSUME_NONNULL_END
