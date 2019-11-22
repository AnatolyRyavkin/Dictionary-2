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
@property NSArray<NSString*>*additionBase;
@property NSArray<AVRusMeaning *>*arrayRusMeaning;
@property NSArray<AVExample*>*arrayExample;
@property NSArray<NSString*>*arrayIdiom;
@property NSArray<AVPhrasalVerb*>*arrayPhrasalVerb;
@property NSArray<NSString*>*grammaticForm;
@property NSString *dereviative;

- (id)copyWithZone:(nullable NSZone *)zone;

-(void)nextIndexPathGlobal;
-(void)nextIndexPathLocal;
-(void)nextIndexPathCountMeaningInObject;

AVIndexPathMeaning makeIndexPathMeaning(int numberGlobalMeaning, int numberLokalMeaning, int numberMeaning);

void makeIndexPathMeaningNextGlobal(AVIndexPathMeaning r);
void makeIndexPathMeaningNextLocal(AVIndexPathMeaning r);
void makeIndexPathMeaningNextMeaning(AVIndexPathMeaning r);

void setIndexPathGlobal(AVIndexPathMeaning r, int i);
void setIndexPathLocal(AVIndexPathMeaning r, int i);
void setIndexPathMeaning(AVIndexPathMeaning r, int i);

@end

NS_ASSUME_NONNULL_END
