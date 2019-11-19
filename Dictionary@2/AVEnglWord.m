//
//  AVEnglWord.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 30/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVEnglWord.h"


AVIndexPathMeaning makeIndexPathMeaning(int numberGlobalMeaning, int numberLokalMeaning, int numberMeaning){
    AVIndexPathMeaning r;
    r.numberGlobalMeaning = numberGlobalMeaning;
    r.numberLocalMeaning = numberLokalMeaning;
    r.numberMeaning = numberMeaning;
    return r;
};

void makeIndexPathMeaningNextGlobal(AVIndexPathMeaning r){
    r.numberGlobalMeaning = r.numberGlobalMeaning + 1;
    r.numberLocalMeaning = 0;
    r.numberMeaning = 0;
};

void makeIndexPathMeaningNextLocal(AVIndexPathMeaning r){
    r.numberLocalMeaning = r.numberLocalMeaning + 1;
    r.numberMeaning = 0;
};

void makeIndexPathMeaningNextMeaning(AVIndexPathMeaning r){
    r.numberMeaning = r.numberMeaning + 1;
};

void setIndexPathGlobal(AVIndexPathMeaning r, int i){
    r.numberGlobalMeaning = i;
    r.numberLocalMeaning = 0;
    r.numberMeaning = 0;
}
void setIndexPathLocal(AVIndexPathMeaning r, int i){
    r.numberLocalMeaning = i;
    r.numberMeaning = 0;
}

void setIndexPathMeaning(AVIndexPathMeaning r, int i){
    r.numberMeaning = i;
}






@implementation AVEnglWord



-(id)init{
    self = [super init];
    if(self){
        self.engMeaningObject = [[NSString alloc] init];
        self.indexPathMeaningWord = makeIndexPathMeaning(0, 0, 0);
        self.engMeaningObject  = @"";
        self.engTranscript = @"";
        self.grammaticType = [NSArray new];
        self.addition = [NSArray new];
        self.arrayRusMeaning = [NSArray new];
        self.arrayExample = [NSArray new];
        self.arrayIdiom = [NSArray new];
        self.arrayPhrasalVerb = [NSArray new];
    }
    return self;
}


- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    AVEnglWord*new = [[AVEnglWord alloc]init];
    new.indexPathMeaningWord = self.indexPathMeaningWord;
    new.engMeaningObject = [NSString stringWithString: self.engMeaningObject];
    new.engTranscript = [NSString stringWithString: self.engTranscript];
    new.grammaticType = [NSArray arrayWithArray: self.grammaticType];
    new.addition = [NSArray arrayWithArray: self.addition];
    new.arrayRusMeaning = [NSArray arrayWithArray: self.arrayRusMeaning];
    new.arrayExample = [NSArray arrayWithArray: self.arrayExample];
    new.arrayIdiom = [NSArray arrayWithArray: self.arrayIdiom];
    new.arrayPhrasalVerb = [NSArray arrayWithArray: self.arrayPhrasalVerb];
    return new;
}

-(void)nextIndexPathGlobal{
    AVIndexPathMeaning indexPath = self.indexPathMeaningWord;
    indexPath.numberGlobalMeaning = indexPath.numberGlobalMeaning + 1;
    indexPath.numberLocalMeaning = 0;
    self.indexPathMeaningWord = indexPath;
}

-(void)nextIndexPathLocal{
    AVIndexPathMeaning indexPath = self.indexPathMeaningWord;
    indexPath.numberLocalMeaning = indexPath.numberLocalMeaning + 1;
    indexPath.numberMeaning = 0;
    self.indexPathMeaningWord = indexPath;
}

-(void)nextIndexPathMeaning{
    AVIndexPathMeaning indexPath = self.indexPathMeaningWord;
    indexPath.numberMeaning = indexPath.numberMeaning + 1;
    self.indexPathMeaningWord = indexPath;
}

@end
