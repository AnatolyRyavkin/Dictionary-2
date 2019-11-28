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

@property (readwrite) AVIndexPathMeaning indexPathMeaningWord;
@property NSString*engMeaningObject;
@property NSString*engTranscript;
@property NSArray<NSString*>*grammaticType;
@property NSArray<NSString*>*grammaticForm;
@property NSArray<AVRusMeaning *>*arrayRusMeaning;
@property NSArray<NSString*>*arrayIdiom;
@property NSArray<AVPhrasalVerb*>*arrayPhrasalVerb;

//@property NSArray<NSString*>*additionBase;
//@property NSString *dereviative;
//@property NSArray<AVExample*>*arrayExample;  // ???



- (id)copyWithZone:(nullable NSZone *)zone;

-(void)nextIndexPathGlobal;
-(void)nextIndexPathLocal;
-(void)nextIndexPathCountMeaningInObject;

AVIndexPathMeaning makeIndexPathMeaning(int numberGlobalMeaning, int numberLokalMeaning, int numberMeaning);

void makeIndexPathMeaningNextGlobal(AVIndexPathMeaning r);
void makeIndexPathMeaningNextLocal(AVIndexPathMeaning r);
void makeIndexPathMeaningNextMeaning(AVIndexPathMeaning r);

void setIndexPathGlobal(AVIndexPathMeaning r, int i);
AVIndexPathMeaning setIndexPathLocal(AVIndexPathMeaning r, int i);
void setIndexPathMeaning(AVIndexPathMeaning r, int i);

@end

NS_ASSUME_NONNULL_END
