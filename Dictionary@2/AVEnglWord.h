//
//  AVEnglWord.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 30/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVMeaningShortWords.h"
#import "PhrasalVerb.h"
#import "AVExample.h"

struct AVRangeMeaning {
    int numberGlobalMeaning;
    int numberLocalMeaning;
};

typedef struct AVRangeMeaning AVRangeMeaning;



NS_ASSUME_NONNULL_BEGIN

@interface AVEnglWord : NSObject <NSCopying>

@property (readwrite) AVRangeMeaning rangeMeaningWord;
@property NSString*engNameObject;
@property NSString*engTranscript;
@property NSArray*grammaticType;
@property NSArray*addition;
@property NSArray<NSString *>*arrayMeaning;
@property NSArray<AVExample*>*example; 
@property NSString*idiom;
@property PhrasalVerb*phrasalVerb;

- (id)copyWithZone:(nullable NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
