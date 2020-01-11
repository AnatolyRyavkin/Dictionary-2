//
//  AVEnglWord.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 30/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "AVEnglWord.h"



void setIndexPathCount(AVIndexPathMeaning *r, int i){
    (*r).countMeaningInObject = i;
}

AVIndexPathMeaning makeIndexPathMeaning(int numberGlobalMeaning, int numberLokalMeaning, int numberMeaning){
    AVIndexPathMeaning r;
    r.numberGlobalMeaning = numberGlobalMeaning;
    r.numberLocalMeaning = numberLokalMeaning;
    r.countMeaningInObject = numberMeaning;
    return r;
};

AVIndexPathMeaning makeIndexPathMeaningNextGlobal(AVIndexPathMeaning r){
    r.numberGlobalMeaning = r.numberGlobalMeaning + 1;
    r.numberLocalMeaning = 1;
    r.countMeaningInObject = 1;
    return r;
};

//example referens structur
//AVIndexPathMeaning m(AVIndexPathMeaning r){
//    AVIndexPathMeaning* k = &r;
//    AVIndexPathMeaning n;
//    n = *k;
//    return *k;
//};

AVIndexPathMeaning makeIndexPathMeaningNextLocal(AVIndexPathMeaning r){
    r.numberLocalMeaning = r.numberLocalMeaning + 1;
    r.countMeaningInObject = 1;
    return r;
};

AVIndexPathMeaning makeIndexPathMeaningNextMeaning(AVIndexPathMeaning r){
    r.countMeaningInObject = r.countMeaningInObject + 1;
    return r;
};

AVIndexPathMeaning setIndexPathGlobal(AVIndexPathMeaning r, int i){
    r.numberGlobalMeaning = i;
    r.numberLocalMeaning = 1;
    r.countMeaningInObject = 1;
    return r;
}
AVIndexPathMeaning setIndexPathLocal(AVIndexPathMeaning r, int i){
    AVIndexPathMeaning indexPath;
    indexPath.numberGlobalMeaning = r.numberGlobalMeaning;
    indexPath.numberLocalMeaning = i;
    indexPath.countMeaningInObject = 1;
    return indexPath;
}

AVIndexPathMeaning setIndexPathCountMeaningInObject(AVIndexPathMeaning r, int i){
    r.countMeaningInObject = i;
    return r;
}

@implementation AVEnglWord

-(AVIndexPathMeaning *)getAdressStr{
    return &_indexPathMeaningWord;
}

#pragma mark - instead short word

-(void)insteadShortWord{

    if(self.grammaticType.count > 0){
        NSMutableArray *arrayTemp = [NSMutableArray new];
        for(NSString *gramType in self.grammaticType){
            if(![[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongGrammatic allKeys] containsObject:gramType]){
//                NSLog(@"error instead type!");
            }else{
                [arrayTemp addObject:[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongGrammatic objectForKey:gramType]];
            }
        }
        self.grammaticType = [NSArray arrayWithArray: arrayTemp];
    }


    if(self.grammaticForm.count > 0){
        NSMutableArray *arrayTemp = [NSMutableArray new];
        for(NSString *gramForm in self.grammaticForm){
            NSMutableString *gramFormMut = [NSMutableString stringWithString:gramForm];
            if([gramForm containsString:@"множ.число"]){
                NSRange range = [gramForm rangeOfString:@"множ.число"];
                [gramFormMut replaceCharactersInRange:range withString:@"множественное число"];
            }
            [arrayTemp addObject:[NSString stringWithString:gramFormMut]];
        }
        self.grammaticForm = [NSArray arrayWithArray:arrayTemp];
    }


    if(self.arrayRusMeaning.count > 0){

        NSMutableArray *rusMeaningTemp = [NSMutableArray new];

        for(AVRusMeaning *rusMeaning in self.arrayRusMeaning){

            if(rusMeaning.accessory.count > 0){
                NSMutableArray *accessoryTempArray = [NSMutableArray new];

                for(NSString *stringTempNotMutable in rusMeaning.accessory){
                    NSMutableString *stringTemp = [NSMutableString stringWithString:stringTempNotMutable];
                    if([stringTemp containsString:@"чего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чего-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                    }
                    if([stringTemp containsString:@"кого-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кого-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                    }
                    if([stringTemp containsString:@"чему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чему-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                    }
                    if([stringTemp containsString:@"кому-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кому-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                    }
                    if([stringTemp containsString:@"чем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чем-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTemp containsString:@"кем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кем-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTemp containsString:@"что-л"]){
                        NSRange range = [stringTemp rangeOfString:@"что-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTemp containsString:@"чьему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTemp containsString:@"чьим-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTemp containsString:@"чьей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTemp containsString:@"чью-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чью-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTemp containsString:@"чьём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTemp containsString:@"ком-л"]){
                        NSRange range = [stringTemp rangeOfString:@"ком-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTemp containsString:@"чьи-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTemp containsString:@"чьих-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTemp containsString:@"чьё-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                    }
                    if([stringTemp containsString:@"чём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чём-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTemp containsString:@"чей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чей-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTemp containsString:@"какой-л"]){
                        NSRange range = [stringTemp rangeOfString:@"какой-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTemp containsString:@"чья-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чья-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTemp containsString:@"чьего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTemp containsString:@"куда-л"]){
                        NSRange range = [stringTemp rangeOfString:@"куда-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                    }

                    if([stringTemp containsString:@"множ.число"]){
                        NSRange range = [stringTemp rangeOfString:@"множ.число"];
                        [stringTemp replaceCharactersInRange:range withString:@"множественное число"];
                    }else

                    if([stringTemp containsString:@"ед.число"]){
                        NSRange range = [stringTemp rangeOfString:@"ед.число"];
                        [stringTemp replaceCharactersInRange:range withString:@"единственное число"];
                    }else

                    if([stringTemp containsString:@"."]){
//                        NSLog(@"....... %@",stringTemp);
//                        NSLog(@"");
                    }

                    if([[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongRusProperty allKeys] containsObject:stringTemp]){

                        NSRange range = [stringTemp rangeOfString:stringTemp];
                        
                        [stringTemp replaceCharactersInRange:range withString:
                                    [self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongRusProperty objectForKey:stringTemp]];

                    }


                    [accessoryTempArray addObject: [NSString stringWithString:stringTemp]];
                }
                rusMeaning.accessory = [NSArray arrayWithArray:accessoryTempArray];
            }



            if(rusMeaning.arrayMeaning.count > 0){

                NSMutableArray *meanTempArray = [NSMutableArray new];

                for(NSString *stringTempNotMutable in rusMeaning.arrayMeaning){

                    NSMutableString *stringTemp = [NSMutableString stringWithString:stringTempNotMutable];

                    if([stringTemp containsString:@"чего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чего-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                    }
                    if([stringTemp containsString:@"кого-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кого-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                    }
                    if([stringTemp containsString:@"чему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чему-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                    }
                    if([stringTemp containsString:@"кому-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кому-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                    }
                    if([stringTemp containsString:@"чьему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTemp containsString:@"чьим-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTemp containsString:@"чьей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTemp containsString:@"чем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чем-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTemp containsString:@"кем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кем-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTemp containsString:@"что-л"]){
                        NSRange range = [stringTemp rangeOfString:@"что-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTemp containsString:@"чью-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чью-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTemp containsString:@"чьём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTemp containsString:@"ком-л"]){
                        NSRange range = [stringTemp rangeOfString:@"ком-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTemp containsString:@"чьи-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTemp containsString:@"чьих-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTemp containsString:@"чьё-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                    }
                    if([stringTemp containsString:@"чём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чём-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTemp containsString:@"чей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чей-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTemp containsString:@"какой-л"]){
                        NSRange range = [stringTemp rangeOfString:@"какой-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTemp containsString:@"чья-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чья-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTemp containsString:@"чьего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTemp containsString:@"куда-л"]){
                        NSRange range = [stringTemp rangeOfString:@"куда-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                    }

                    if([stringTemp containsString:@"множ.число"]){
                        NSRange range = [stringTemp rangeOfString:@"множ.число"];
                        [stringTemp replaceCharactersInRange:range withString:@"множественное число"];
                    }else

                        if([stringTemp containsString:@"ед.число"]){
                            NSRange range = [stringTemp rangeOfString:@"ед.число"];
                            [stringTemp replaceCharactersInRange:range withString:@"единственное число"];
                        }else

                            if([stringTemp containsString:@"."]){
//                                NSLog(@"....... %@",stringTemp);
//                                NSLog(@"");
                            }


                    [meanTempArray addObject: [NSString stringWithString:stringTemp]];
                }
                rusMeaning.arrayMeaning = [NSArray arrayWithArray:meanTempArray];
            }

            if(rusMeaning.arrayExample.count > 0){

                NSMutableArray *exampleTemp = [NSMutableArray new];

                for(AVExample *example in rusMeaning.arrayExample){

                    NSMutableString *stringTemp = [NSMutableString stringWithString: example.accessory];

                        if([stringTemp containsString:@"чего-л"]){
                            NSRange range = [stringTemp rangeOfString:@"чего-л"];
                            [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                        }
                        if([stringTemp containsString:@"кого-л"]){
                            NSRange range = [stringTemp rangeOfString:@"кого-л"];
                            [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                        }
                        if([stringTemp containsString:@"чему-л"]){
                            NSRange range = [stringTemp rangeOfString:@"чему-л"];
                            [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                        }
                    if([stringTemp containsString:@"кому-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кому-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                    }
                        if([stringTemp containsString:@"чьему-л"]){
                            NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                            [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                        }
                    if([stringTemp containsString:@"чьим-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTemp containsString:@"чьей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                        if([stringTemp containsString:@"чем-л"]){
                            NSRange range = [stringTemp rangeOfString:@"чем-л"];
                            [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                        }
                    if([stringTemp containsString:@"кем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кем-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                        if([stringTemp containsString:@"что-л"]){
                            NSRange range = [stringTemp rangeOfString:@"что-л"];
                            [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                        }
                    if([stringTemp containsString:@"чью-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чью-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTemp containsString:@"чьём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTemp containsString:@"ком-л"]){
                        NSRange range = [stringTemp rangeOfString:@"ком-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTemp containsString:@"чьи-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTemp containsString:@"чьих-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTemp containsString:@"чьё-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                    }
                    if([stringTemp containsString:@"чём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чём-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTemp containsString:@"чей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чей-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTemp containsString:@"какой-л"]){
                        NSRange range = [stringTemp rangeOfString:@"какой-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTemp containsString:@"чья-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чья-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTemp containsString:@"чьего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTemp containsString:@"куда-л"]){
                        NSRange range = [stringTemp rangeOfString:@"куда-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                    }

                        if([stringTemp containsString:@"множ.число"]){
                            NSRange range = [stringTemp rangeOfString:@"множ.число"];
                            [stringTemp replaceCharactersInRange:range withString:@"множественное число"];
                        }else

                            if([stringTemp containsString:@"ед.число"]){
                                NSRange range = [stringTemp rangeOfString:@"ед.число"];
                                [stringTemp replaceCharactersInRange:range withString:@"единственное число"];
                            }else

                                if([stringTemp containsString:@"."]){
//                                    NSLog(@"....... %@",stringTemp);
//                                    NSLog(@"");
                                }

                        if([[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongRusProperty allKeys] containsObject:stringTemp]){
                            NSRange range = [stringTemp rangeOfString:stringTemp];
                            [stringTemp replaceCharactersInRange:range withString:
                             [self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongRusProperty objectForKey:stringTemp]];

                        }

                    example.accessory = [NSString stringWithString: stringTemp];

                    NSMutableString *stringTempExMean = [NSMutableString stringWithString: example.meaning];

                    if([stringTempExMean containsString:@"чего-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чего-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чего-либо"];
                    }
                    if([stringTempExMean containsString:@"кого-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"кого-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"кого-либо"];
                    }
                    if([stringTempExMean containsString:@"чему-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чему-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чему-либо"];
                    }
                    if([stringTempExMean containsString:@"кому-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"кому-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"кому-либо"];
                    }
                    if([stringTempExMean containsString:@"чьему-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьему-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTempExMean containsString:@"чьим-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьим-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTempExMean containsString:@"чьей-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьей-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTempExMean containsString:@"чем-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чем-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTempExMean containsString:@"кем-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"кем-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTempExMean containsString:@"что-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"что-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTempExMean containsString:@"чью-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чью-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTempExMean containsString:@"чьём-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьём-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTempExMean containsString:@"ком-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"ком-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTempExMean containsString:@"чьи-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьи-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTempExMean containsString:@"чьих-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьих-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTempExMean containsString:@"чьё-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьё-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьё-либо"];
                    }
                    if([stringTempExMean containsString:@"чём-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чём-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTempExMean containsString:@"чей-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чей-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTempExMean containsString:@"какой-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"какой-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTempExMean containsString:@"чья-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чья-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTempExMean containsString:@"чьего-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьего-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTempExMean containsString:@"куда-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"куда-л"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"куда-либо"];
                    }

                    if([stringTempExMean containsString:@"множ.число"]){
                        NSRange range = [stringTempExMean rangeOfString:@"множ.число"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"множественное число"];
                    }else

                        if([stringTempExMean containsString:@"ед.число"]){
                            NSRange range = [stringTempExMean rangeOfString:@"ед.число"];
                            [stringTempExMean replaceCharactersInRange:range withString:@"единственное число"];
                        }else

                            if([stringTempExMean containsString:@"."]){
//                                NSLog(@"....... %@",stringTempExMean);
//                                NSLog(@"");
                            }

                    if([stringTempExMean containsString:@"smb"]){
                        NSLog(@"%@",stringTempExMean);
                        NSRange range = [stringTempExMean rangeOfString:@"smb"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"somebody"];
                    }

                    if([stringTempExMean containsString:@"smth"]){
                        NSLog(@"%@",stringTempExMean);
                        NSRange range = [stringTempExMean rangeOfString:@"smth"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"something"];
                    }

                     example.meaning = [NSString stringWithString: stringTempExMean];

                    [exampleTemp addObject:example];
                }

                rusMeaning.arrayExample = exampleTemp;

            }

            if(![rusMeaning.dereviative isEqualToString:@""]){
                if([rusMeaning.dereviative containsString :@"pl от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"pl от"];
                    [tempString replaceCharactersInRange: range withString:@"множественное число от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"superl от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"superl от"];
                    [tempString replaceCharactersInRange: range withString:@"превосходная степень от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"compare от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"compare от"];
                    [tempString replaceCharactersInRange: range withString:@"сравнительная степень от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"compar от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"compar от"];
                    [tempString replaceCharactersInRange: range withString:@"сравнительная степень от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"past и pp от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"past и pp от"];
                    [tempString replaceCharactersInRange: range withString:@"прошедшее и причастие прошедшего времени от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"pp от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"pp от"];
                    [tempString replaceCharactersInRange: range withString:@"причастие прошедшего времени от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"past от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"past от"];
                    [tempString replaceCharactersInRange: range withString:@"прошедшее от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
                if([rusMeaning.dereviative containsString :@"косв падеж от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"косв падеж от"];
                    [tempString replaceCharactersInRange: range withString:@"косвенный падеж от:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }

                if([rusMeaning.dereviative containsString :@"="]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"="];
                    [tempString replaceCharactersInRange: range withString:@"равнозначно с:"];
                    rusMeaning.dereviative = tempString;
                    continue;
                }
            }

            [rusMeaningTemp addObject:rusMeaning];
        }

        self.arrayRusMeaning = [NSArray arrayWithArray:rusMeaningTemp];
//        NSLog(@"");
//        NSLog(@"NEW OBJECT ");
//        [self printObject];
//        NSLog(@"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=");
    }

}

#pragma mark - Make Simple Object

-(void)printObject{

    if(self.engMeaningObject == nil || [self.engMeaningObject isEqualToString:@""])
        {}
    else
                NSLog(@"England meaning -                                   %@",self.engMeaningObject);

                NSLog(@"Index path:                                         (%d,%d,%d)", self.indexPathMeaningWord.numberGlobalMeaning,self.indexPathMeaningWord.numberLocalMeaning,self.indexPathMeaningWord.countMeaningInObject);

    if(self.engTranscript == nil || [self.engTranscript isEqualToString:@""])
        {}
    else
                NSLog(@"England transcript -                                %@",self.engTranscript);



    if(self.grammaticType.count > 0){
        for(NSString *gramType in self.grammaticType){
            if(gramType != nil && ![gramType isEqualToString:@""])
                NSLog(@"Type -                                                %@",gramType);
        }
    }

    if(self.grammaticForm.count > 0){
        for(NSString *gramForm in self.grammaticForm){
            if(gramForm != nil && ![gramForm isEqualToString:@""])
                NSLog(@"Form -                                               %@",gramForm);
        }
    }

    if(self.arrayRusMeaning.count > 0){

        int i = 0;
        for(AVRusMeaning *rusMeaning in self.arrayRusMeaning){
            i++;
            if(rusMeaning){
                NSArray<NSString *>* arrayMeaning = rusMeaning.arrayMeaning;
                NSArray<NSString *> *accessory = rusMeaning.accessory;
                NSString *dereviative = rusMeaning.dereviative;
                NSArray<AVExample*>*arrayExample = rusMeaning.arrayExample;

                if(arrayMeaning.count > 0){

                    for(NSString *rusMean in arrayMeaning){
                        if(rusMean != nil && ![rusMean isEqualToString:@""]){
                NSLog(@"%d meaning -                      & %@",i,rusMean);
                        }
                    }
                }

                if(accessory.count > 0){

                    for(NSString *access in accessory){
                        if(access != nil && ![access isEqualToString:@""])
                NSLog(@"%d access -                             ^%@",i,access);
                    }
                }

                if(dereviative != nil && ![dereviative isEqualToString:@""])
                NSLog(@"%d derevative -                                         !%@",i,dereviative);

                if(arrayExample.count > 0){

                    for(AVExample *example in arrayExample){
                        if(example != nil){
                            if(example.meaning != nil && ![example.meaning isEqualToString:@""])
                NSLog(@"%d example.meaning -                                  *%@",i,example.meaning);
                            if(example.accessory != nil && ![example.accessory isEqualToString:@""])
                NSLog(@"%d example.accessory -                                      **%@",i,example.accessory);
                        }
                    }
                }
            }
        }
    }
}

-(void)printObjectWhole{

    if(self.engMeaningObject == nil || [self.engMeaningObject isEqualToString:@""])
        NSLog(@"England meaning -                    England meaningError");
    else
        NSLog(@"England meaning -                                                    %@",self.engMeaningObject);

    NSLog(@"Index path:              (%d,%d,%d)", self.indexPathMeaningWord.numberGlobalMeaning,self.indexPathMeaningWord.numberLocalMeaning,self.indexPathMeaningWord.countMeaningInObject);

    if(self.engTranscript == nil || [self.engTranscript isEqualToString:@""])
        NSLog(@"England transcript -     England transcriptError");
    else
        NSLog(@"England transcript -     %@",self.engTranscript);



    if(self.grammaticType.count > 0){
            //NSLog(@"Grammatic types:");
        for(NSString *gramType in self.grammaticType){
            if(gramType != nil && ![gramType isEqualToString:@""])
                NSLog(@"Type -                    %@",gramType);
            else
                NSLog(@"Type -                    typeError");
        }
    }

    if(self.grammaticForm.count > 0){
            // NSLog(@"Grammatic form:");
        for(NSString *gramForm in self.grammaticForm){
            if(gramForm != nil && ![gramForm isEqualToString:@""])
                NSLog(@"Form -                %@",gramForm);
            else
                NSLog(@"Form -                    formError");
        }
    }

    if(self.arrayRusMeaning.count > 0){
            // NSLog(@"Rus meaning object:");
        int i = 0;
        for(AVRusMeaning *rusMeaning in self.arrayRusMeaning){
            i++;
            if(rusMeaning){
                NSArray<NSString *>* arrayMeaning = rusMeaning.arrayMeaning;
                NSArray<NSString *> *accessory = rusMeaning.accessory;
                NSString *dereviative = rusMeaning.dereviative;
                NSArray<AVExample*>*arrayExample = rusMeaning.arrayExample;

                if(arrayMeaning.count > 0){
                        //NSLog(@"Rus meanings:");

                    for(NSString *rusMean in arrayMeaning){
                        if(rusMean != nil && ![rusMean isEqualToString:@""]){
                            NSLog(@"%d meaning -                                                                       %@",i,rusMean);
                        }
                        else
                            NSLog(@"%d -                                                                                 rusMeanError",i);
                    }
                }
                else
                    NSLog(@"%d                                                        arrayMeaning.count = 0",i);

                if(accessory.count > 0){
                        //NSLog(@"      accessory:");
                    for(NSString *access in accessory){
                        if(access != nil && ![access isEqualToString:@""])
                            NSLog(@"%d access -                  %@",i,access);
                        else
                            NSLog(@"%d -                                                      accesError = nil",i);
                    }
                }

                if(dereviative != nil && ![dereviative isEqualToString:@""])
                    NSLog(@"%d derevative -              %@",i,dereviative);

                if(arrayExample.count > 0){
                        //NSLog(@"   Examples:");
                    for(AVExample *example in arrayExample){
                        if(example != nil){
                            if(example.meaning != nil && ![example.meaning isEqualToString:@""])
                                NSLog(@"%d example.meaning -        %@",i,example.meaning);
                            else
                                NSLog(@"%d -                      example.meaningError = nil",i);
                            if(example.accessory != nil && ![example.accessory isEqualToString:@""])
                                NSLog(@"%d example.accessory -        %@",i,example.accessory);
                            else
                                NSLog(@" -                      example.accessoryError = nil");
                        }
                    }
                }
            }
        }
    }
}


-(void)printObject:(int)num{
                            NSLog(@"");
    if(num)
                            NSLog(@"object number -         %d          typeObject = %@",num,self.selfType);
    [self printObject];
    NSLog(@"==================================================================================");
}


-(id)init{
    static NSString * SelfTypeEngWord = @"SelfTypeEngWord";
    static NSString * SelfTypePhraseVerb = @"SelfTypePhraseVerb";
    self = [super init];
    if(self){
        self.selfType = ([self isMemberOfClass:[AVEnglWord class]]) ? SelfTypeEngWord : SelfTypePhraseVerb;
        self.engMeaningObject = [[NSString alloc] init];
        self.indexPathMeaningWord = makeIndexPathMeaning(1, 1, 1);
        self.engTranscript = ([self isMemberOfClass:[AVEnglWord class]]) ? [[NSString alloc] init] : @"[]";
        self.grammaticType = [NSArray new];
        self.grammaticForm = [NSArray new];
        self.arrayRusMeaning = [NSArray new];
        self.arrayIdiom = [NSArray new];
        self.arrayPhrasalVerb = [NSArray new];
        self.managerMeaningShort = [AVMeaningShortWords sharedShortWords];
    }
    return self;
}


- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    AVEnglWord*new = [[AVEnglWord alloc]init];
    new.indexPathMeaningWord = self.indexPathMeaningWord;
    new.engMeaningObject = [NSString stringWithString: self.engMeaningObject];
    new.engTranscript = [NSString stringWithString: self.engTranscript];
    new.grammaticType = [NSArray arrayWithArray: self.grammaticType];
    new.grammaticForm = [NSArray arrayWithArray: self.grammaticForm];
    new.arrayRusMeaning = [NSArray arrayWithArray: self.arrayRusMeaning];
    new.arrayIdiom = [NSArray arrayWithArray: self.arrayIdiom];
    new.arrayPhrasalVerb = [NSArray arrayWithArray: self.arrayPhrasalVerb];
    
    //new.dereviative = self.dereviative;
    //new.additionBase = [NSArray arrayWithArray: self.additionBase];
    //new.arrayExample = [NSArray arrayWithArray: self.arrayExample];

    return new;
}

-(void)nextIndexPathGlobal{
    AVIndexPathMeaning indexPath = self.indexPathMeaningWord;
    indexPath.numberGlobalMeaning = indexPath.numberGlobalMeaning + 1;
    indexPath.numberLocalMeaning = 1;
    indexPath.countMeaningInObject = 1;
    self.indexPathMeaningWord = indexPath;
}

-(void)nextIndexPathLocal{
    AVIndexPathMeaning indexPath = self.indexPathMeaningWord;
    indexPath.numberLocalMeaning = indexPath.numberLocalMeaning + 1;
    indexPath.countMeaningInObject = 1;
    self.indexPathMeaningWord = indexPath;
}

-(void)nextIndexPathCountMeaningInObject{
    AVIndexPathMeaning indexPath = self.indexPathMeaningWord;
    indexPath.countMeaningInObject = indexPath.countMeaningInObject + 1;
    self.indexPathMeaningWord = indexPath;
}

@end
