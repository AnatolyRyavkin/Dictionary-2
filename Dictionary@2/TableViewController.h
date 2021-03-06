//
//  TableViewController.h
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 01/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVMainManager.h"
#import "AVButton.h"


@interface TableViewController : UITableViewController<UITableViewDelegate,UITextFieldDelegate,UISearchBarDelegate>

@property (nonatomic) AVMainManager*manager;
@property NSArray*arrayVisible;
@property UITextField *textFieldEditRow;
@property (weak) UITableViewCell* cellEdit;
@property NSIndexPath*indexPathForEditRow;
@property (weak) UISearchBar*searchBar;
@property UIBarButtonItem*barDuttonSearch;
@property NSInteger numberObject;
@property NSInteger offset;
@property NSInteger pointZiro;
@property BOOL flagGoUp;

-(void)loadTableAroundingForPoint:(NSInteger) pointInput atOffset:(NSInteger)offset atStartingPoint:(NSInteger)startingPoint;
-(NSDictionary*)prepareLoadTableAtPointInput:(NSInteger)pointInput;
-(void)saveArray;

@end


