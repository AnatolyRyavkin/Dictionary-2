//
//  AVSeparateStringAtComma.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 22.01.2020.
//  Copyright © 2020 AnatolyRyavkin. All rights reserved.
//

#import "AVSeparateStringAtComma.h"


#define AVL NSLog(@"");
#define AV NSLog(@"-------------------------------");

@implementation AVSeparateStringAtComma
@synthesize numberString = _numberString;

-(NSInteger)numberString{
    if(!_numberString)
        _numberString = 0;
    return _numberString;
}
-(void)setNumberString:(NSInteger)numberString{
    _numberString = numberString;
}

-(void)dealloc{
    NSLog(@"AVSeparateStringAtComma deallocated");
}

#pragma mark - Prints

-(void)printObjectJSON: (NSDictionary*) objectDictionaryJSON{

        AV AVL

    if([objectDictionaryJSON objectForKey:typeObjectKey]){
        NSLog(@"type object - %@",[objectDictionaryJSON objectForKey:typeObjectKey]);
    }

    NSLog(@"numberGlobalMeaning= %ld", [[objectDictionaryJSON objectForKey:indexPathGlobalKey] integerValue]);
    NSLog(@"numberLocalMeaning= %ld", [[objectDictionaryJSON objectForKey:indexPathLocalKey] integerValue]);
    NSLog(@"countMeaningInObject= %ld", [[objectDictionaryJSON objectForKey:indexPathCountKey] integerValue]);

    if( [objectDictionaryJSON objectForKey:engMeaningObjectKey]){
        NSLog(@"english meaning - %@",[objectDictionaryJSON objectForKey:engMeaningObjectKey]);
    }

    if( [objectDictionaryJSON objectForKey:engTranscriptKey]){
        NSLog(@"english transcription - %@",[objectDictionaryJSON objectForKey:engTranscriptKey]);
    }

    if( [objectDictionaryJSON objectForKey:grammaticTypeKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:grammaticTypeKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"grammatic Type (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:grammaticFormKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:grammaticFormKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"grammatic Form (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:arrayIdiomKey]){
        NSArray *arrayTemp = [objectDictionaryJSON objectForKey:arrayIdiomKey];
        int i = 1;
        for(NSString *stringTemp in arrayTemp){
            NSLog(@"idiom (%d) - %@",i,stringTemp);
            i++;
        }
    }

    if( [objectDictionaryJSON objectForKey:arrayRusMeaningKey]){

        NSArray *arryaTempRusObject = [objectDictionaryJSON objectForKey:arrayRusMeaningKey];
        int j = 1;
        for(NSDictionary *dictionaryTemp in arryaTempRusObject){

            if([dictionaryTemp objectForKey:arrayExampleRusMeaningKey]){
                NSArray *arrayExample = [dictionaryTemp objectForKey:arrayExampleRusMeaningKey];
                int i = 1;
                for(NSDictionary *dictionaryExample in arrayExample){

                    if( [dictionaryExample objectForKey: meaningExampleKey]){
                        NSLog(@"example (%d : %d) - %@",j,i,[dictionaryExample objectForKey: meaningExampleKey]);
                    }

                    if( [dictionaryExample objectForKey: accessoryExampleKey]){
                        NSLog(@"accessory for example (%d : %d) - %@",j,i,[dictionaryExample objectForKey: accessoryExampleKey]);
                    }
                    i++;
                }
            }

            if( [dictionaryTemp objectForKey:arrayMeaningRusMeaningKey]){
                NSArray *arrayTemp = [dictionaryTemp objectForKey:arrayMeaningRusMeaningKey];
                int i = 1;
                for(NSString *stringTemp in arrayTemp){
                    NSLog(@"rus meaning (%d : %d) - %@",j,i,stringTemp);
                    i++;
                }
            }

            if( [dictionaryTemp objectForKey:accessoryRusMeaningKey]){
                NSArray *arrayTemp = [dictionaryTemp objectForKey:accessoryRusMeaningKey];
                int i = 1;
                for(NSString *stringTemp in arrayTemp){
                    NSLog(@"accessory rus meaning (%d : %d) - %@",j,i,stringTemp);
                    i++;
                }
            }

            if( [dictionaryTemp objectForKey:dereviativeRusMeaningKey]){
                NSLog(@"derevative (%d) - %@",j,[dictionaryTemp objectForKey:dereviativeRusMeaningKey]);
            }

            j++;

        }
    }
}


-(void)printJSONWhole:(NSArray*)arrayJSON{
    for(NSDictionary*dictionaryObjectJSON in arrayJSON)
        [self printObjectJSON:dictionaryObjectJSON];
}

-(void)printObjectDictionaryRusString:(NSDictionary *)dictionaryObject{

        NSLog(@"==========================          ================================ ");
        NSArray*arRusOb = [dictionaryObject objectForKey:arrayRusMeaningKey];
        int j = 0;
        for(NSDictionary*dictRusOb in arRusOb){
            NSArray*arString = [dictRusOb objectForKey:arrayMeaningRusMeaningKey];
            NSLog(@"++++++++++++      %d     +++++++++ ",j);
            for(NSString*st in arString){
                NSLog(@"-------    %@",st);
            }
            j++;
        }
}

-(void)printJSONRusString:(NSArray*)arrayJSON{
    int i = 0;
    for(NSDictionary*dictObject in arrayJSON){
        NSLog(@"==========================            %d         ================================ ",i);
        NSArray*arRusOb = [dictObject objectForKey:arrayRusMeaningKey];
        int j = 0;
        for(NSDictionary*dictRusOb in arRusOb){
            NSArray*arString = [dictRusOb objectForKey:arrayMeaningRusMeaningKey];
            NSLog(@"++++++++++++      %d     +++++++++ ",j);
            for(NSString*st in arString){
                NSLog(@"-------    %@",st);
            }
            j++;
        }
        i++;
    }
}

#pragma mark - Init

-(id)initNavigationController:(UINavigationController*) nc  andViewController:(ViewController*) vcMain{

    self = [super init];
    if(self){
        self.vcMain = vcMain;
        self.nc = nc;

        self.numberObject = 0;
        self.numberArrayRusObject = 0;
        self.numberString = 0;
        self.numberCheckComma = 0;

        UIViewController *vcCurrent = [[UIViewController alloc]init];
        vcCurrent.view.frame = [UIScreen mainScreen].bounds;
        vcCurrent.view.backgroundColor =  [UIColor whiteColor];
        [vcCurrent.view setUserInteractionEnabled:YES];

        NSShadow*shadow = [[NSShadow alloc]init];
        shadow.shadowOffset = CGSizeMake(1, 1);
        shadow.shadowColor = [UIColor redColor];
        shadow.shadowBlurRadius = 0.9;

        [[UIButton appearance] setBackgroundColor:[[UIColor brownColor] colorWithAlphaComponent: .5]];
        UIFont *font = [UIFont systemFontOfSize:30];

        UIButton *buttonSeparate = [UIButton buttonWithType:UIButtonTypeSystem];
        NSDictionary *dictionaryAtributedStringYes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                   shadow, NSShadowAttributeName,
                                                   font, NSFontAttributeName ,
                                                   [UIColor redColor],    NSForegroundColorAttributeName,
                                                   nil];
        NSAttributedString* atributedStringYes = [[NSAttributedString alloc]initWithString:@"Separate" attributes:dictionaryAtributedStringYes];
        [buttonSeparate setAttributedTitle:atributedStringYes forState:UIControlStateNormal];
        [buttonSeparate setFrame:CGRectMake(400, 200, 250, 100)];
        buttonSeparate.enabled = YES;
        [buttonSeparate addTarget:self action:@selector(needSeparate) forControlEvents:UIControlEventTouchDown];

        UIButton *buttonLeaveAsIs = [UIButton buttonWithType:UIButtonTypeSystem];
        NSDictionary *dictionaryAtributedStringNo = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                    shadow, NSShadowAttributeName,
                                                    font, NSFontAttributeName ,
                                                    [UIColor blueColor],    NSForegroundColorAttributeName,
                                                    nil];

        NSAttributedString* atributedStringNo = [[NSAttributedString alloc]initWithString:@"Leave as is" attributes:dictionaryAtributedStringNo];
        [buttonLeaveAsIs setAttributedTitle:atributedStringNo forState:UIControlStateNormal];
        [buttonLeaveAsIs setFrame:CGRectMake(100, 200, 250, 100)];
        [buttonLeaveAsIs setEnabled:YES];
        [buttonLeaveAsIs addTarget:self action:@selector(leaveAsIs) forControlEvents: UIControlEventTouchDown];

        UIView *viewUp = [[UIView alloc]initWithFrame:vcCurrent.view.frame];
        [viewUp setBackgroundColor: [[UIColor greenColor] colorWithAlphaComponent:0.1] ];
        [vcCurrent.view addSubview:viewUp];
        [vcCurrent.view.subviews[0] addSubview:buttonSeparate];
        [vcCurrent.view.subviews[0] addSubview:buttonLeaveAsIs];

        self.vcCurrent = vcCurrent;
    }
    return self;
}

#pragma mark - Begin


-(void)changeJSON: (NSArray*) JSONObjects{

    if(JSONObjects.count > 0){
#pragma mark - Temp numberObject = 18000
        self.numberObject = 28000;
        self.JSONTemp = [NSMutableArray arrayWithArray: JSONObjects];
        [self obtainObjectAtNumber:self.numberObject];
    }else{
        UIAlertController*ac = [UIAlertController alertControllerWithTitle:@"Allert!" message:@"JSON empty!!! Anatoly - your good!!!" preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                 {
                                 [ac dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [ac addAction:cancel];
        [self.nc.topViewController presentViewController:ac animated:YES completion:nil];
    }
}

-(void)obtainObjectAtNumber:(NSInteger)numberObject{
    if(numberObject < self.JSONTemp.count){


        AVL AVL
        NSLog(@"#######################     Object num = %ld    #######################",numberObject);
        AVL

        self.dictionaryObjectTemp = [NSMutableDictionary dictionaryWithDictionary: self.JSONTemp[numberObject]];
        AVL
        NSLog(@"origin");
        [self printObjectDictionaryRusString:self.dictionaryObjectTemp];
        if( [self.dictionaryObjectTemp objectForKey:arrayRusMeaningKey]){
            self.arrayObjectsRusObjectsTemp =  [NSMutableArray arrayWithArray: [self.dictionaryObjectTemp objectForKey:arrayRusMeaningKey]];
            self.numberArrayRusObject = 0;
            [self obtainArrayObjectsRusAtNumber:self.numberArrayRusObject];
        }else{
            self.numberObject++;
            [self obtainObjectAtNumber:self.numberObject];
        }
    }else{
        //[self printJSONWhole:self.JSONTemp];
        self.JSONReady = [NSArray arrayWithArray: self.JSONTemp];
        __weak AVSeparateStringAtComma *weakSelf = self;
        UIAlertController*ac = [UIAlertController alertControllerWithTitle:@"Allert!" message:@"Change JSON ending!!! Anatoly - your good!!!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *writeJSONInFile = [UIAlertAction actionWithTitle:@"write JSON In File" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                          {

#pragma mark - Save JSON in file
                                          [weakSelf.vcMain writeJSONInFile:weakSelf.JSONReady];
                                          [ac dismissViewControllerAnimated:YES completion:nil];
                                          }];

        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                 {
                                 [ac dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [ac addAction:writeJSONInFile];
        [ac addAction:cancel];

        [self.nc.topViewController presentViewController:ac animated:YES completion:nil];
    }
}


-(void)obtainArrayObjectsRusAtNumber:(NSInteger)numberArrayRusObject{

    if(numberArrayRusObject < self.arrayObjectsRusObjectsTemp.count){
        self.dictionaryRusMeaningTemp = [NSMutableDictionary dictionaryWithDictionary: self.arrayObjectsRusObjectsTemp[numberArrayRusObject]];
        if( [self.dictionaryRusMeaningTemp objectForKey:arrayMeaningRusMeaningKey]){
            self.arrayStringsRusMeaningTemp = [NSMutableArray arrayWithArray:
                                               [self.dictionaryRusMeaningTemp objectForKey:arrayMeaningRusMeaningKey]];
            self.numberString = 0;
            [self obtainStringRus:self.numberString];

        }else{
            self.numberArrayRusObject++;
            [self obtainArrayObjectsRusAtNumber: self.numberArrayRusObject];
        }
    }else{

        [self.dictionaryObjectTemp setObject:[NSArray arrayWithArray:self.arrayObjectsRusObjectsTemp] forKey:arrayRusMeaningKey];
        self.JSONTemp[self.numberObject] = [NSDictionary dictionaryWithDictionary: self.dictionaryObjectTemp];
        AVL
        NSLog(@"changed");
        [self printObjectDictionaryRusString:self.dictionaryObjectTemp];

        self.numberObject++;
        [self obtainObjectAtNumber:self.numberObject];

    }

}


-(void)obtainStringRus:(NSInteger)numberString{

    if(numberString < self.arrayStringsRusMeaningTemp.count){

        self.stringRusTemp = self.arrayStringsRusMeaningTemp[numberString];

            //NSLog(@"stringTemp = %@",self.stringRusTemp);

        BOOL isStringSingle = YES;

        if([self.stringRusTemp containsString:@","]){

                // check single strings
                //delete whitespace on the edges

            NSMutableArray *arrayCheck = [NSMutableArray new];
            NSArray *arraySeparateAtComma = [self.stringRusTemp componentsSeparatedByString:@","];
            for(NSString*str in arraySeparateAtComma){
                NSString *string = [NSMutableString stringWithString:str];
                if([[string lastCharString] isEqualToString:@" "])
                    string = [string stringWithoutLastSimbol];
                if([[string firstCharString] isEqualToString:@" "])
                    string = [string stringWithoutFirstSimbol];
                [arrayCheck addObject:string];
            }

                //separate at whitespace and check is string single word

            for(NSString*stringSeparWhitespace in arrayCheck){
                if([stringSeparWhitespace componentsSeparatedByString:@" "].count != 1)
                    isStringSingle = NO;
            }
            if(isStringSingle){

                for(NSString*string in arrayCheck){
                    [self.arrayStringsRusMeaningTemp insertObject:string atIndex:self.numberString];
                }
                [self.arrayStringsRusMeaningTemp removeObjectAtIndex:self.numberString + arrayCheck.count];
                self.numberString = numberString + arrayCheck.count;
                [self obtainStringRus:self.numberString];
            }else{

#pragma mark - separate manual

                [self separateStringAtComma:self.stringRusTemp];
            }

        }else{
                //string have'nt comma
            self.numberString++;
            [self obtainStringRus:self.numberString];
        }

    }else{
        [self.dictionaryRusMeaningTemp setObject:[NSArray arrayWithArray:self.arrayStringsRusMeaningTemp] forKey:arrayMeaningRusMeaningKey];
        self.arrayObjectsRusObjectsTemp[self.numberArrayRusObject] = [NSDictionary dictionaryWithDictionary:
                                                                        self.dictionaryRusMeaningTemp];
        self.numberArrayRusObject++;
        [self obtainArrayObjectsRusAtNumber:self.numberArrayRusObject];
    }
}


-(void)separateStringAtComma:(NSString*)stringInput{

    NSString *stringWhole = stringInput;
    if([[stringInput lastCharString] isEqualToString:@","])
        stringWhole = [stringInput stringWithoutLastSimbol];
    if([[stringInput firstCharString] isEqualToString:@","])
        stringWhole = [stringInput stringWithoutFirstSimbol];

    NSArray *arraySeparatedString = [stringWhole componentsSeparatedByString:@","];

    NSMutableAttributedString *attributedStringMutable = [[NSMutableAttributedString alloc]init];

    int numComma = 0;

    for(NSString*string in arraySeparatedString){
        NSDictionary *dictionaryAttributedString = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                    [UIFont systemFontOfSize:30], NSFontAttributeName ,
                                                    [UIColor blueColor],    NSForegroundColorAttributeName,
                                                    nil];
        NSAttributedString* attributedString = [[NSAttributedString alloc]initWithString:string attributes:dictionaryAttributedString];
        [attributedStringMutable appendAttributedString:attributedString];

        if(![string isEqualToString:[arraySeparatedString lastObject]]){

            UIColor *color = (numComma == self.numberCheckComma) ? [UIColor redColor] :  [UIColor blueColor];

            dictionaryAttributedString = [[NSDictionary alloc] initWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:40], NSFontAttributeName ,
                                          color,    NSForegroundColorAttributeName,
                                          nil];

            attributedString = [[NSAttributedString alloc]initWithString: @"," attributes:dictionaryAttributedString];

            [attributedStringMutable appendAttributedString:attributedString];
        }
        numComma++;
    }

    UITextView *textView = [[UITextView alloc]initWithFrame: CGRectMake(10, 400, self.vcMain.view.frame.size.width-20 , 500)];
    [textView setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.8] ];
    textView.attributedText = attributedStringMutable;

    NSArray*arrayViews = self.vcCurrent.view.subviews[0].subviews;
    for(UIView*view in arrayViews){
        if([view isMemberOfClass:[UITextView class]]){
            [view removeFromSuperview];
        }
    }

    [self.vcCurrent.view.subviews[0] addSubview:textView];

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self.nc showViewController:self.vcCurrent sender: nil];
    });

}

-(void)needSeparate{

    NSMutableArray *arrayMut1 = [NSMutableArray new];
    NSMutableArray *arrayMut2 = [NSMutableArray new];
    NSArray *arraySeparated = [self.stringRusTemp componentsSeparatedByString:@","];
    for(int i=0;i<arraySeparated.count;i++){
        if(i<=self.numberCheckComma){
            [arrayMut1 addObject:arraySeparated[i]];
        }
        else{
            [arrayMut2 addObject:arraySeparated[i]];
        }
    }

    NSString *string1 = [arrayMut1 componentsJoinedByString:@", "];
    NSString *string2 = [arrayMut2 componentsJoinedByString:@", "];
    [self.arrayStringsRusMeaningTemp removeObjectAtIndex:self.numberString];
    [self.arrayStringsRusMeaningTemp insertObject:string1 atIndex:self.numberString];
    [self.arrayStringsRusMeaningTemp insertObject:string2 atIndex:self.numberString + 1];
    self.numberCheckComma = 0;
    self.numberString++;
    [self obtainStringRus:self.numberString];

}

-(void)leaveAsIs{
    NSArray *arraySeparated = [self.stringRusTemp componentsSeparatedByString:@","];
    if(self.numberCheckComma == arraySeparated.count - 2 )
        self.numberString++;
    else
        self.numberCheckComma++;

    [self obtainStringRus:self.numberString];
}


@end
