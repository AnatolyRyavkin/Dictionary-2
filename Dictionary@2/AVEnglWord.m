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
                NSLog(@"error instead type!");
            }else{
                [arrayTemp addObject:[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongGrammatic objectForKey:gramType]];
            }
        }
        self.grammaticType = [NSArray arrayWithArray: arrayTemp];
    }


    if(self.grammaticForm.count > 0){
        NSMutableArray *arrayTemp = [NSMutableArray new];
        for(NSMutableString *gramForm in self.grammaticForm){
            if([gramForm containsString:@"множ.число"]){
                NSRange range = [gramForm rangeOfString:@"множ.число"];
                [gramForm replaceCharactersInRange:range withString:@"множественное число"];
            }
            [arrayTemp addObject:[NSString stringWithString:gramForm]];
        }
        self.grammaticForm = [NSArray arrayWithArray:arrayTemp];
    }


    if(self.arrayRusMeaning.count > 0){
        NSMutableArray *rusMeaningTemp = [NSMutableArray new];
        for(AVRusMeaning *rusMeaning in self.arrayRusMeaning){
            if(rusMeaning.accessory.count > 0){
                NSMutableArray *accessoryTempArray = [NSMutableArray new];
                for(NSMutableString *stringTemp in rusMeaning.accessory){

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
                    if([stringTemp containsString:@"чем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чем-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTemp containsString:@"что-л"]){
                        NSRange range = [stringTemp rangeOfString:@"что-л"];
                        [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
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
                        NSLog(@".......");
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
            [rusMeaningTemp addObject:rusMeaning];
        }
        self.arrayRusMeaning = [NSArray arrayWithArray:rusMeaningTemp];
    }


//    if(self.arrayRusMeaning.count > 0){
//        int i = 0;
//        for(AVRusMeaning *rusMeaning in self.arrayRusMeaning){
//            i++;
//            if(rusMeaning){
////                NSArray<NSString *>* arrayMeaning = rusMeaning.arrayMeaning;
//                NSArray<NSString *> *accessory = rusMeaning.accessory;
//                NSString *dereviative = rusMeaning.dereviative;
//                NSArray<AVExample*>*arrayExample = rusMeaning.arrayExample;
//
////                if(arrayMeaning.count > 0){
////                    for(NSString *rusMean in arrayMeaning){
////                        if(rusMean != nil && ![rusMean isEqualToString:@""]){
////
////                        }
////                    }
////                }
//
//                if(accessory.count > 0){
//                    for(NSString *access in accessory){
//                        if(access != nil && ![access isEqualToString:@""]){
//
//                        }
//                    }
//                }
//
//                if(dereviative != nil && ![dereviative isEqualToString:@""]){
//
//
//                        //    if(([string isEqualToString:@"pl"] && [array[numString+1] isEqualToString:@"от"]) ||
//                        //       ([string isEqualToString:@"superl"] && [array[numString+1] isEqualToString:@"от"]) ||
//                        //       ([string isEqualToString:@"compare"] && [array[numString+1] isEqualToString:@"от"]) ||
//                        //       ([string isEqualToString:@"compar"] && [array[numString+1] isEqualToString:@"от"]) ||
//                        //       ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"от"]) ||
//                        //       ([string isEqualToString:@"past"] && [array[numString+1] isEqualToString:@"и"]) ||
//                        //       ([string isEqualToString:@"p"] && [array[numString+1] isEqualToString:@"p"] && [array[numString+2] isEqualToString:@"от"]) ||
//                        //       ([string isEqualToString:@"косв"] && [array[numString+1] isEqualToString:@"падеж"] && [array[numString+2] isEqualToString:@"от"]) ||
//                        //       [string isEqualToString:@"="]){
//                        //        rusMeaningObject.dereviative = string;
//                        //        dereviative = AVStateWork;
//                        //        continue;
//                        //    }
//
//                }
//
//                if(arrayExample.count > 0){
//                    for(AVExample *example in arrayExample){
//                        if(example != nil){
//                            if(example.meaning != nil && ![example.meaning isEqualToString:@""]){
//
//                            }
//                            if(example.accessory != nil && ![example.accessory isEqualToString:@""]){
//
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}


#pragma mark - Make Simple Object

-(void)printObject{

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

    if(self.arrayIdiom.count > 0){
        int i = 0;
        for(NSString *idiom in self.arrayIdiom){
            i++;
            if(idiom != nil && ![idiom isEqualToString:@""])
                NSLog(@"%d idiom -                    %@",i,idiom);
            else
                NSLog(@"%d idiom -                    idiomError",i);
        }
    }
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
