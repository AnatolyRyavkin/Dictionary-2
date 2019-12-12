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
    int countMeaningInObject;
};

typedef struct AVIndexPathMeaning AVIndexPathMeaning;

NS_ASSUME_NONNULL_BEGIN

@interface AVEnglWord : NSObject <NSCopying>

@property AVIndexPathMeaning indexPathMeaningWord;
@property NSString*engMeaningObject;
@property NSString*engTranscript;
@property NSArray<NSString*>*grammaticType;
@property NSArray<NSString*>*grammaticForm;
@property NSArray<AVRusMeaning *>*arrayRusMeaning;
@property NSArray<NSString*>*arrayIdiom;
@property NSArray *arrayPhrasalVerb;


-(AVIndexPathMeaning *)getAdressStr;

- (id)copyWithZone:(nullable NSZone *)zone;

-(void)nextIndexPathGlobal;
-(void)nextIndexPathLocal;
-(void)nextIndexPathCountMeaningInObject;
-(void)printObject:(int)num;

AVIndexPathMeaning makeIndexPathMeaning(int numberGlobalMeaning, int numberLokalMeaning, int numberMeaning);

AVIndexPathMeaning makeIndexPathMeaningNextGlobal(AVIndexPathMeaning r);
AVIndexPathMeaning makeIndexPathMeaningNextLocal(AVIndexPathMeaning r);
AVIndexPathMeaning makeIndexPathMeaningNextMeaning(AVIndexPathMeaning r);

AVIndexPathMeaning setIndexPathGlobal(AVIndexPathMeaning r, int i);
AVIndexPathMeaning setIndexPathLocal(AVIndexPathMeaning r, int i);
AVIndexPathMeaning setIndexPathMeaning(AVIndexPathMeaning r, int i);


#pragma mark - c-function

void setIndexPathCount(AVIndexPathMeaning *r, int i);

@end

NS_ASSUME_NONNULL_END
