//
//  AVEnglWord.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 30/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVMeaningShortWords.h"
#import "AVExample.h"
#import "AVRusMeaning.h"



@class AVPhrasalVerb;


struct AVIndexPathMeaning {
    int numberGlobalMeaning;
    int numberLocalMeaning;
    int countMeaningInObject;
};

typedef struct AVIndexPathMeaning AVIndexPathMeaning;

NS_ASSUME_NONNULL_BEGIN

extern const NSString *etcWithoutPoint;
extern const NSString *etcWithPoint;

extern NSString *SelfTypeEngWord;
extern NSString *SelfTypePhraseVerb;

@interface AVEnglWord : NSObject <NSCopying>

@property NSString *selfType;
@property AVIndexPathMeaning indexPathMeaningWord;
@property NSString*engMeaningObject;
@property NSString*engTranscript;
@property NSArray<NSString*>*grammaticType;
@property NSArray<NSString*>*grammaticForm;
@property NSArray<AVRusMeaning *>*arrayRusMeaning;
@property NSArray<NSString*>*arrayIdiom;
@property NSArray <AVPhrasalVerb*>*arrayPhrasalVerb;

@property AVMeaningShortWords *managerMeaningShort;


-(AVIndexPathMeaning *)getAdressStr;

- (id)copyWithZone:(nullable NSZone *)zone;

-(void)nextIndexPathGlobal;
-(void)nextIndexPathLocal;
-(void)nextIndexPathCountMeaningInObject;
-(void)printObject:(int)num;
-(void)printObject;
-(void)printObjectWhole;
-(void)insteadShortWord;
-(void)deleteSemicolon;
-(void)instadEtc;
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
