//
//  AVSeparateStringAtComma.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 22.01.2020.
//  Copyright © 2020 AnatolyRyavkin. All rights reserved.
//

#import "AVSeparateStringAtComma.h"

@implementation AVSeparateStringAtComma

-(id)initNavigationController:(UINavigationController*) nc  andViewController:(UIViewController*) vc{
    self = [super init];
    if(self){
        self.vc = vc;
        self.nc = nc;
    
    }
    return self;
}

-(NSArray*)mutatingString: (NSString*) inputString{

    UIViewController *vc = [[UIViewController alloc]init];
    vc.view.frame = self.vc.view.frame;
    vc.view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1];

    NSShadow*shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeMake(1, 1);
    shadow.shadowColor = [UIColor redColor];
    shadow.shadowBlurRadius = 0.9;

    UIButton *buttonYes = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonYes setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent: .5]];
    UIFont *font = [UIFont systemFontOfSize:30];
    NSDictionary *dictionaryAtributedString = [[NSDictionary alloc] initWithObjectsAndKeys:
                                               shadow, NSShadowAttributeName,
                                               font, NSFontAttributeName ,
                                               [UIColor redColor],    NSForegroundColorAttributeName,
                                               nil];
    NSAttributedString* atributedString = [[NSAttributedString alloc]initWithString:@"separate" attributes:dictionaryAtributedString];
    [buttonYes setAttributedTitle:atributedString forState:UIControlStateNormal];
    [buttonYes setFrame:CGRectMake(500, 100, 150, 50)];
    [buttonYes addTarget:self action:@selector(isCycleEnd) forControlEvents:UIControlEventAllEvents];

    UIButton *buttonNo = [UIButton buttonWithType:UIButtonTypeSystem];
    [buttonNo setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent: .5]];
    UIFont *font1 = [UIFont systemFontOfSize:30];
    NSDictionary *dictionaryAtributedString1 = [[NSDictionary alloc] initWithObjectsAndKeys:
                                               shadow, NSShadowAttributeName,
                                               font1, NSFontAttributeName ,
                                               [UIColor blueColor],    NSForegroundColorAttributeName,
                                               nil];
    NSAttributedString* atributedString1 = [[NSAttributedString alloc]initWithString:@"leave" attributes:dictionaryAtributedString1];
    [buttonNo setAttributedTitle:atributedString1 forState:UIControlStateNormal];
    [buttonNo setFrame:CGRectMake(100, 100, 150, 50)];
    [buttonNo addTarget:self action:@selector(isCycleEnd) forControlEvents:UIControlEventAllEvents];

    [vc.view addSubview:buttonYes];
    [vc.view addSubview:buttonNo];

    NSArray *arraySepar = [inputString componentsSeparatedByString:@","];

    NSMutableAttributedString *attributedStringMutable = [[NSMutableAttributedString alloc]init];

    for(NSString*string in arraySepar){
        NSDictionary *dictionaryAttributedString = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                    [UIFont systemFontOfSize:30], NSFontAttributeName ,
                                                    [UIColor blueColor],    NSForegroundColorAttributeName,
                                                    nil];
        NSAttributedString* attributedString = [[NSAttributedString alloc]initWithString:string attributes:dictionaryAttributedString];
        [attributedStringMutable appendAttributedString:attributedString];

        if(![string isEqualToString:[arraySepar lastObject]]){

            dictionaryAttributedString = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                        [UIFont systemFontOfSize:40], NSFontAttributeName ,
                                                        [UIColor redColor],    NSForegroundColorAttributeName,
                                                        nil];

            attributedString = [[NSAttributedString alloc]initWithString: @"," attributes:dictionaryAttributedString];

            [attributedStringMutable appendAttributedString:attributedString];
        }
    }

    UITextView *textView = [[UITextView alloc]initWithFrame: CGRectMake(10, 300, 800, 500)];
    textView.attributedText = attributedStringMutable;

    [vc.view addSubview:textView];

    [self.nc showViewController:vc sender: nil];

    return [NSArray new];
}


@end
