//
//  AVEnglWord.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 30/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVEnglWord.h"


AVRangeMeaning makeRangeMeaning(int globalMeaning, int lokalMeaning){
    AVRangeMeaning r;
    r.numberGlobalMeaning = globalMeaning;
    r.numberLocalMeaning = lokalMeaning;
    return r;
};


@implementation AVEnglWord



-(id)init{
    self = [super init];
    if(self){
        self.engNameObject = [[NSString alloc] init];
        self.rangeMeaningWord = makeRangeMeaning(10, 1);
        self.engNameObject  = @"";
        self.engTranscript = @"";
        self.grammaticType = [NSArray new];
        self.addition = [NSArray new];
        self.arrayMeaning = [NSArray new];
        self.example = [NSArray new];
        self.idiom = @"";
        self.phrasalVerb = [PhrasalVerb new];
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    AVEnglWord*new = [[AVEnglWord alloc]init];
    new.rangeMeaningWord = self.rangeMeaningWord;
    new.engNameObject = self.engNameObject;
    new.engTranscript = self.engTranscript;
    new.grammaticType = self.grammaticType;
    new.addition = self.addition;
    new.arrayMeaning = self.arrayMeaning;
    new.example = self.example;
    new.idiom = self.idiom;
    new.phrasalVerb = self.phrasalVerb;
    return new;
}

@end
