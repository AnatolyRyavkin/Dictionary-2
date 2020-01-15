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
            if([[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongGrammatic allKeys] containsObject:gramType]){
                [arrayTemp addObject:[self.managerMeaningShort.dictionaryFromKeysAsShortAndMeaningAsLongGrammatic objectForKey:gramType]];
            }else{
                [arrayTemp addObject:gramType];
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

    if(self.arrayIdiom.count > 0){
        NSMutableArray *arrayTemp = [NSMutableArray new];
        for(NSString *stringTempDontMut in self.arrayIdiom){
            NSMutableString *stringTemp = [NSMutableString stringWithString:stringTempDontMut];

            if([stringTemp containsString:@"чего-л"]){
                NSRange range = [stringTemp rangeOfString:@"чего-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(![[stringTemp substringWithRange:rangeCheck] isEqualToString: @"чего-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];

            }
            if([stringTemp containsString:@"кого-л"]){
                NSRange range = [stringTemp rangeOfString:@"кого-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кого-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];

            }
            if([stringTemp containsString:@"чему-л"]){
                NSRange range = [stringTemp rangeOfString:@"чему-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чему-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];

            }
            if([stringTemp containsString:@"кому-л"]){
                NSRange range = [stringTemp rangeOfString:@"кому-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кому-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];

            }
            if([stringTemp containsString:@"чем-л"]){
                NSRange range = [stringTemp rangeOfString:@"чем-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чем-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];

                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
            }
            if([stringTemp containsString:@"кем-л"]){
                NSRange range = [stringTemp rangeOfString:@"кем-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кем-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
            }
            if([stringTemp containsString:@"что-л"]){
                NSRange range = [stringTemp rangeOfString:@"что-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"что-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
            }
            if([stringTemp containsString:@"чьему-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьему-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
            }
            if([stringTemp containsString:@"чьим-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьим-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
            }
            if([stringTemp containsString:@"чьей-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьей-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
            }
            if([stringTemp containsString:@"чью-л"]){
                NSRange range = [stringTemp rangeOfString:@"чью-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чью-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
            }
            if([stringTemp containsString:@"чьём-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьём-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                }
            if([stringTemp containsString:@"ком-л"]){
                NSRange range = [stringTemp rangeOfString:@"ком-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"ком-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                }
                [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
            }
            if([stringTemp containsString:@"чьи-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьи-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
            }
            if([stringTemp containsString:@"чьих-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьих-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
            }
            if([stringTemp containsString:@"чьё-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьё-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];

            }
            if([stringTemp containsString:@"чём-л"]){
                NSRange range = [stringTemp rangeOfString:@"чём-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чём-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
            }
            if([stringTemp containsString:@"чей-л"]){
                NSRange range = [stringTemp rangeOfString:@"чей-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чей-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
            }
            if([stringTemp containsString:@"какой-л"]){
                NSRange range = [stringTemp rangeOfString:@"какой-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"какой-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
            }
            if([stringTemp containsString:@"чья-л"]){
                NSRange range = [stringTemp rangeOfString:@"чья-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чья-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
            }
            if([stringTemp containsString:@"чьего-л"]){
                NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьего-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                }else
                    [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
            }
            if([stringTemp containsString:@"куда-л"]){
                NSRange range = [stringTemp rangeOfString:@"куда-л"];
                NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                    if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"куда-либо"])
                        [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                }else
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

            if([stringTemp containsString:@"smb"]){
                NSRange range = [stringTemp rangeOfString:@"smb"];
                [stringTemp replaceCharactersInRange:range withString:@"somebody"];
            }

            if([stringTemp containsString:@"smth"]){
                NSRange range = [stringTemp rangeOfString:@"smth"];
                [stringTemp replaceCharactersInRange:range withString:@"something"];
            }

            [arrayTemp addObject:[NSString stringWithString:stringTemp]];
        }
        self.arrayIdiom = [NSArray arrayWithArray:arrayTemp];
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
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(![[stringTemp substringWithRange:rangeCheck] isEqualToString: @"чего-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];

                    }
                    if([stringTemp containsString:@"кого-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кого-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кого-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];

                    }
                    if([stringTemp containsString:@"чему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чему-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];

                    }
                    if([stringTemp containsString:@"кому-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кому-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кому-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];

                    }
                    if([stringTemp containsString:@"чем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чем-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];

                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTemp containsString:@"кем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кем-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTemp containsString:@"что-л"]){
                        NSRange range = [stringTemp rangeOfString:@"что-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"что-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTemp containsString:@"чьему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьему-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTemp containsString:@"чьим-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьим-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTemp containsString:@"чьей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьей-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTemp containsString:@"чью-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чью-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чью-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTemp containsString:@"чьём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьём-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTemp containsString:@"ком-л"]){
                        NSRange range = [stringTemp rangeOfString:@"ком-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"ком-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                        }
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTemp containsString:@"чьи-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьи-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTemp containsString:@"чьих-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьих-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTemp containsString:@"чьё-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьё-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];

                    }
                    if([stringTemp containsString:@"чём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чём-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTemp containsString:@"чей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чей-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTemp containsString:@"какой-л"]){
                        NSRange range = [stringTemp rangeOfString:@"какой-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"какой-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTemp containsString:@"чья-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чья-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чья-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTemp containsString:@"чьего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьего-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTemp containsString:@"куда-л"]){
                        NSRange range = [stringTemp rangeOfString:@"куда-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"куда-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                        }else
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
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(![[stringTemp substringWithRange:rangeCheck] isEqualToString: @"чего-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];

                    }
                    if([stringTemp containsString:@"кого-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кого-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кого-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];

                    }
                    if([stringTemp containsString:@"чему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чему-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];

                    }
                    if([stringTemp containsString:@"кому-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кому-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кому-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];

                    }
                    if([stringTemp containsString:@"чем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чем-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];

                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTemp containsString:@"кем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кем-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTemp containsString:@"что-л"]){
                        NSRange range = [stringTemp rangeOfString:@"что-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"что-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTemp containsString:@"чьему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьему-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTemp containsString:@"чьим-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьим-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTemp containsString:@"чьей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьей-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTemp containsString:@"чью-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чью-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чью-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTemp containsString:@"чьём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьём-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTemp containsString:@"ком-л"]){
                        NSRange range = [stringTemp rangeOfString:@"ком-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"ком-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                        }
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTemp containsString:@"чьи-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьи-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTemp containsString:@"чьих-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьих-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTemp containsString:@"чьё-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьё-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];

                    }
                    if([stringTemp containsString:@"чём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чём-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTemp containsString:@"чей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чей-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTemp containsString:@"какой-л"]){
                        NSRange range = [stringTemp rangeOfString:@"какой-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"какой-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTemp containsString:@"чья-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чья-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чья-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTemp containsString:@"чьего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьего-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTemp containsString:@"куда-л"]){
                        NSRange range = [stringTemp rangeOfString:@"куда-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"куда-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                        }else
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
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(![[stringTemp substringWithRange:rangeCheck] isEqualToString: @"чего-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чего-либо"];

                    }
                    if([stringTemp containsString:@"кого-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кого-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кого-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кого-либо"];

                    }
                    if([stringTemp containsString:@"чему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чему-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чему-либо"];

                    }
                    if([stringTemp containsString:@"кому-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кому-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кому-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кому-либо"];

                    }
                    if([stringTemp containsString:@"чем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чем-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];

                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTemp containsString:@"кем-л"]){
                        NSRange range = [stringTemp rangeOfString:@"кем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"кем-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTemp containsString:@"что-л"]){
                        NSRange range = [stringTemp rangeOfString:@"что-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"что-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTemp containsString:@"чьему-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьему-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTemp containsString:@"чьим-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьим-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьим-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTemp containsString:@"чьей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьей-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTemp containsString:@"чью-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чью-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чью-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTemp containsString:@"чьём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьём-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTemp containsString:@"ком-л"]){
                        NSRange range = [stringTemp rangeOfString:@"ком-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"ком-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                        }
                        [stringTemp replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTemp containsString:@"чьи-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьи-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьи-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTemp containsString:@"чьих-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьих-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьих-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTemp containsString:@"чьё-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьё-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьё-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьё-либо"];

                    }
                    if([stringTemp containsString:@"чём-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чём-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTemp containsString:@"чей-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чей-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTemp containsString:@"какой-л"]){
                        NSRange range = [stringTemp rangeOfString:@"какой-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"какой-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTemp containsString:@"чья-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чья-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чья-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTemp containsString:@"чьего-л"]){
                        NSRange range = [stringTemp rangeOfString:@"чьего-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"чьего-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                        }else
                            [stringTemp replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTemp containsString:@"куда-л"]){
                        NSRange range = [stringTemp rangeOfString:@"куда-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTemp.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTemp substringWithRange:rangeCheck] isEqualToString: @"куда-либо"])
                                [stringTemp replaceCharactersInRange:range withString:@"куда-либо"];
                        }else
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

                    example.accessory = [NSString stringWithString: stringTemp];

                    NSMutableString *stringTempExMean = [NSMutableString stringWithString: example.meaning];

                    if([stringTempExMean containsString:@"чего-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чего-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(![[stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чего-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чего-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чего-либо"];

                    }
                    if([stringTempExMean containsString:@"кого-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"кого-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"кого-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"кого-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"кого-либо"];

                    }
                    if([stringTempExMean containsString:@"чему-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чему-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чему-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чему-либо"];

                    }
                    if([stringTempExMean containsString:@"кому-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"кому-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"кому-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"кому-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"кому-либо"];

                    }
                    if([stringTempExMean containsString:@"чем-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чем-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чем-либо"];

                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чем-либо"];
                    }
                    if([stringTempExMean containsString:@"кем-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"кем-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"кем-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"кем-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"кем-либо"];
                    }
                    if([stringTempExMean containsString:@"что-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"что-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"что-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"что-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"что-либо"];
                    }
                    if([stringTempExMean containsString:@"чьему-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьему-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьему-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьему-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьему-либо"];
                    }
                    if([stringTempExMean containsString:@"чьим-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьим-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьим-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьим-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьим-либо"];
                    }
                    if([stringTempExMean containsString:@"чьей-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьей-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьей-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьей-либо"];
                    }
                    if([stringTempExMean containsString:@"чью-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чью-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чью-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чью-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чью-либо"];
                    }
                    if([stringTempExMean containsString:@"чьём-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьём-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьём-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьём-либо"];
                    }
                    if([stringTempExMean containsString:@"ком-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"ком-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"ком-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"ком-либо"];
                        }
                        [stringTempExMean replaceCharactersInRange:range withString:@"ком-либо"];
                    }
                    if([stringTempExMean containsString:@"чьи-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьи-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьи-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьи-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьи-либо"];
                    }
                    if([stringTempExMean containsString:@"чьих-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьих-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьих-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьих-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьих-либо"];
                    }
                    if([stringTempExMean containsString:@"чьё-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьё-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьё-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьё-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьё-либо"];

                    }
                    if([stringTempExMean containsString:@"чём-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чём-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чём-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чём-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чём-либо"];
                    }
                    if([stringTempExMean containsString:@"чей-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чей-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чей-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чей-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чей-либо"];
                    }
                    if([stringTempExMean containsString:@"какой-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"какой-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"какой-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"какой-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"какой-либо"];
                    }
                    if([stringTempExMean containsString:@"чья-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чья-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чья-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чья-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чья-либо"];
                    }
                    if([stringTempExMean containsString:@"чьего-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"чьего-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"чьего-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"чьего-либо"];
                        }else
                            [stringTempExMean replaceCharactersInRange:range withString:@"чьего-либо"];
                    }
                    if([stringTempExMean containsString:@"куда-л"]){
                        NSRange range = [stringTempExMean rangeOfString:@"куда-л"];
                        NSRange rangeCheck = NSMakeRange(range.location, range.length + 3);
                        if(stringTempExMean.length >= rangeCheck.location + rangeCheck.length){
                            if(! [ [stringTempExMean substringWithRange:rangeCheck] isEqualToString: @"куда-либо"])
                                [stringTempExMean replaceCharactersInRange:range withString:@"куда-либо"];
                        }else
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
                                    //                        NSLog(@"....... %@",stringTemp);
                                    //                        NSLog(@"");
                            }
                    if([stringTempExMean containsString:@"smb"]){
                        //NSLog(@"%@",stringTempExMean);
                        NSRange range = [stringTempExMean rangeOfString:@"smb"];
                        [stringTempExMean replaceCharactersInRange:range withString:@"somebody"];
                    }

                    if([stringTempExMean containsString:@"smth"]){
                        //NSLog(@"%@",stringTempExMean);
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
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"superl от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"superl от"];
                    [tempString replaceCharactersInRange: range withString:@"превосходная степень от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"compare от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"compare от"];
                    [tempString replaceCharactersInRange: range withString:@"сравнительная степень от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"compar от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"compar от"];
                    [tempString replaceCharactersInRange: range withString:@"сравнительная степень от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"past и pp от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"past и pp от"];
                    [tempString replaceCharactersInRange: range withString:@"прошедшее и причастие прошедшего времени от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"pp от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"pp от"];
                    [tempString replaceCharactersInRange: range withString:@"причастие прошедшего времени от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"past от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"past от"];
                    [tempString replaceCharactersInRange: range withString:@"прошедшее от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }
                if([rusMeaning.dereviative containsString :@"косв падеж от"]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"косв падеж от"];
                    [tempString replaceCharactersInRange: range withString:@"косвенный падеж от:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];

                    continue;
                }

                if([rusMeaning.dereviative containsString :@"="]){
                    NSMutableString *tempString = [NSMutableString stringWithString:rusMeaning.dereviative];
                    NSRange range = [tempString rangeOfString: @"="];
                    [tempString replaceCharactersInRange: range withString:@"равнозначно с:"];
                    rusMeaning.dereviative = tempString;
                    [rusMeaningTemp addObject:rusMeaning];
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

    if(self.arrayIdiom.count > 0){
        for(NSString *idiom in self.arrayIdiom){
            if(idiom != nil && ![idiom isEqualToString:@""])
                NSLog(@"Idiom -                I# %@",idiom);
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
