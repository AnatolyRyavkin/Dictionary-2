//
//  AVEnglWord.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 30/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVMeaningShortWords.h"
#import "AVPhrasalVerb.h"
#import "AVExample.h"
#import "AVRusMeaning.h"

struct AVIndexPathMeaning {
    int numberGlobalMeaning;
    int numberLocalMeaning;
};

typedef struct AVIndexPathMeaning AVIndexPathMeaning;



NS_ASSUME_NONNULL_BEGIN

@interface AVEnglWord : NSObject <NSCopying>

@property (readwrite) AVIndexPathMeaning indexPathMeaningWord;
@property NSString*engMeaningObject;
@property NSString*engTranscript;
@property NSArray<NSString*>*grammaticType;
@property NSArray<NSString*>*addition;
@property NSArray<AVRusMeaning *>*arrayRusMeaning;
@property NSArray<AVExample*>*arrayExample;
@property NSArray<NSString*>*arrayIdiom;
@property NSArray<AVPhrasalVerb*>*arrayPhrasalVerb;

- (id)copyWithZone:(nullable NSZone *)zone;
-(void)nextIndexPathGlobal;
-(void)nextIndexPathLocal;

@end

NS_ASSUME_NONNULL_END
