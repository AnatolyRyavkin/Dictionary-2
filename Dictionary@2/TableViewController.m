//
//  TableViewController.m
//  Dictionary@2
//
//  Created by Anatoly Ryavkin on 01/10/2019.
//  Copyright © 2019 AnatolyRyavkin. All rights reserved.
//

#import "TableViewController.h"

static NSString* identifaerHeader = @"IdentifaerHeader";
NSString* const identifaerCell = @"identifaerCell";
static NSInteger rectObjects = 5;
NSString* const keyOffset = @"keyOffset";
NSString* const keyStartingPoint = @"keyStartingPoint";
NSInteger const offsetConst = 1000;

@implementation UITableView (ReloadData)

-(void)reloadData:(UITextField*)textField{
    if(textField)
        textField.text = @"";
    [self reloadData];
}

@end

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize manager = _manager;


#pragma mark search


-(void)dealloc{
    NSLog(@"dealloc");
}

-(void)viewDidLoad{
    [super viewDidLoad];
}


-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        UIBarButtonItem*barButtonEdit = [[UIBarButtonItem alloc]initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(beginEdit)];
        UIBarButtonItem*barDuttonSearch = [[UIBarButtonItem alloc]initWithTitle:@"SearchShow" style:UIBarButtonItemStylePlain target:self action:@selector(actionSearth:)];
        [self.navigationItem setRightBarButtonItems:@[barButtonEdit,barDuttonSearch]];
        self.barDuttonSearch = barDuttonSearch;
        self.numberObject = 0;
        self.pointZiro = 0;
        self.flagGoUp = NO;
        [self loadTableAroundingForPoint:0 atOffset:offsetConst atStartingPoint:0];
    }
    return self;
}

#pragma mark - New metod

-(void)loadTableAroundingForPoint:(NSInteger) pointInput atOffset:(NSInteger)offset atStartingPoint:(NSInteger)startingPoint{
        self.arrayVisible = [NSArray arrayWithArray:[self.manager.mainArray subarrayWithRange:NSMakeRange(startingPoint, offset)]];
        [self.tableView reloadData];
    if(!self.flagGoUp)
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:pointInput-startingPoint] atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
    else
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:pointInput-startingPoint] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    [self.tableView reloadData];
};

-(NSDictionary*)prepareLoadTableAtPointInput:(NSInteger)pointInput{
    NSInteger startPredPoint = pointInput - offsetConst/2;
    NSInteger startPoint = (startPredPoint < 0) ? 0 : startPredPoint;
    self.pointZiro = startPoint;
    NSInteger offsetIntrist = (startPoint + offsetConst > self.manager.mainArray.count) ? self.manager.mainArray.count - startPoint : offsetConst;
    NSDictionary*dictionary = [NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInteger:startPoint], keyStartingPoint, @(offsetIntrist), keyOffset, nil];
    return dictionary;
}


-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

         self.numberObject = [searchText integerValue];
         if(self.numberObject >=0 && self.numberObject <=38000){
             NSDictionary*dictionary = [self prepareLoadTableAtPointInput:self.numberObject];
             NSInteger offsetIntrestic = [[dictionary objectForKey:keyOffset] integerValue];
             NSInteger startingPoint = [[dictionary objectForKey:keyStartingPoint] integerValue];
             [self loadTableAroundingForPoint:self.numberObject atOffset:offsetIntrestic atStartingPoint:startingPoint];
         }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.placeholder = @"input number at object";
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    self.barDuttonSearch.title = @"SearchShow";
    self.barDuttonSearch.tintColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    [searchBar removeFromSuperview];
    [self.tableView reloadData];
}


-(void)actionSearth:(UIBarButtonItem*)sender{
    if([sender.title isEqual: @"SearchShow"]){
        sender.title = @"SearchDown";
        UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(200, 75, 400, 27)];
        searchBar.delegate = self;
        [[self.tableView superview] addSubview:searchBar];
        [searchBar becomeFirstResponder];
        self.searchBar = searchBar;
    }else{
        sender.title = @"SearchShow";
        sender.tintColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    }
}


-(void)beginEdit{
    [self.textFieldEditRow removeFromSuperview];
    if(!self.tableView.indexPathForSelectedRow)
        self.tableView.editing = !self.tableView.editing;
    else
        self.tableView.editing = NO;
}

-(AVMainManager*)manager{
    if(!_manager)
        _manager = [AVMainManager managerData];
    return _manager;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayVisible.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray*arrTemp = (NSArray*)self.arrayVisible[section];
    NSInteger num = arrTemp.count;
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifaerCell];
    if(!cell)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifaerCell];
    UIFont*font = [UIFont systemFontOfSize:22];
    cell.textLabel.font = font;
    cell.textLabel.text = [(NSArray*)self.self.arrayVisible[indexPath.section] objectAtIndex:indexPath.row];
    cell.contentView.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.01];
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *nameObject = [NSString stringWithFormat:@"Object %ld",(long)section+self.pointZiro];
    return nameObject;
}

- (nullable UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section NS_AVAILABLE_IOS(6_0){
    UITableViewHeaderFooterView *header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifaerHeader];
    if(!header)
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifaerHeader];
    if(section == self.numberObject - self.pointZiro)
        header.backgroundColor = [[UIColor purpleColor]colorWithAlphaComponent:1];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    if(section == self.numberObject - self.pointZiro && self.numberObject != 0){
        UILabel *myLabel = [[UILabel alloc] init];
        myLabel.frame = CGRectMake(10, 5, self.tableView.frame.size.width, 27);
        myLabel.font = [UIFont boldSystemFontOfSize:16];
        myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
        myLabel.backgroundColor=[UIColor greenColor];
        [headerView addSubview:myLabel];
        return headerView;
    }
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(10, 5, CGRectGetWidth(self.tableView.frame), 27);
    myLabel.font = [UIFont boldSystemFontOfSize:16];
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    myLabel.backgroundColor=[[UIColor grayColor] colorWithAlphaComponent:0.2];
    [headerView addSubview:myLabel];
    return headerView;
}


#pragma mark - TableEdit

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!tableView.editing){

        self.indexPathForEditRow = indexPath;

        [self.textFieldEditRow removeFromSuperview];

        UITableViewCell*cell = [self.tableView cellForRowAtIndexPath:indexPath];

        self.cellEdit = cell;

        CGRect rect = cell.frame;

        self.textFieldEditRow = [[UITextField alloc]initWithFrame:rect];

        UIFont*font = [UIFont systemFontOfSize:22];
        [self.textFieldEditRow setFont:font];

        self.textFieldEditRow.text = [NSString stringWithFormat:@"    %@",cell.textLabel.text];

        self.textFieldEditRow.textColor = [[UIColor redColor]colorWithAlphaComponent:0.8];

        [self.tableView addSubview:self.textFieldEditRow];

        self.textFieldEditRow.delegate = self;

        [self.textFieldEditRow becomeFirstResponder];
    }
}


-(NSString*)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return @"REMOVE";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        NSMutableArray*arrVisTemp = [NSMutableArray arrayWithArray:self.arrayVisible];
        NSMutableArray*arrTemp = [NSMutableArray arrayWithArray:arrVisTemp[indexPath.section]];
        [arrTemp removeObjectAtIndex:indexPath.row];
        [arrVisTemp replaceObjectAtIndex:indexPath.section withObject:arrTemp];
        self.arrayVisible = [NSArray arrayWithArray:arrVisTemp];
        [tableView beginUpdates];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];


    } else if (editingStyle == UITableViewCellEditingStyleInsert) {

    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
}

#pragma mark - UIScrollViewDelegat


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.textFieldEditRow removeFromSuperview];
        NSInteger countVisibleFirst = self.tableView.indexPathsForVisibleRows.firstObject.section;
        NSLog(@"first = %ld", (long)countVisibleFirst);
        NSInteger rectRealDown = offsetConst - countVisibleFirst;
        if(rectRealDown == rectObjects){
            [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
            NSInteger pointInput = self.pointZiro + countVisibleFirst;
            NSDictionary*dictionary = [self prepareLoadTableAtPointInput:pointInput];
            NSInteger offset = [[dictionary objectForKey:keyOffset] integerValue];
            NSInteger startingPoint = [[dictionary objectForKey:keyStartingPoint] integerValue];
            [self loadTableAroundingForPoint:pointInput atOffset:offset atStartingPoint:startingPoint];
        }
        if(countVisibleFirst == rectObjects && self.pointZiro > 0 ){
            [self.tableView setContentOffset:self.tableView.contentOffset animated:NO];
            self.flagGoUp = YES;
            NSInteger pointInput = self.pointZiro + countVisibleFirst;
            NSDictionary*dictionary = [self prepareLoadTableAtPointInput:pointInput];
            NSInteger offset = [[dictionary objectForKey:keyOffset] integerValue];
            NSInteger startingPoint = [[dictionary objectForKey:keyStartingPoint] integerValue];
            [self loadTableAroundingForPoint:pointInput atOffset:offset atStartingPoint:startingPoint];
        }
        self.flagGoUp = NO;
}

#pragma mark - textFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(range.location>3){
        self.cellEdit.textLabel.text = [self.cellEdit.textLabel.text stringByReplacingCharactersInRange:NSMakeRange(range.location-4, range.length) withString:string];
        return YES;
    }
    return NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    UITableViewCell*cell = [self.tableView cellForRowAtIndexPath:self.indexPathForEditRow];
    [cell setSelected:YES];
}

-(UITableViewCell*)superCell:(UIView*)view{

    UIView*superView = [view superview];
    if(superView){
        if([superView isMemberOfClass:[UITableViewCell class]])
            return (UITableViewCell*)superView;
        else
            return [self superCell:superView];
    }
        return nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString*string = self.cellEdit.textLabel.text;

    NSLog(@"str1 = %@",self.manager.mainArray[0][0]);

    self.arrayVisible[self.indexPathForEditRow.section][self.indexPathForEditRow.row] = string;  ///!!!!!!! mutate main

    NSLog(@"str1 = %@",self.manager.mainArray[0][0]);


    [textField resignFirstResponder];
    [self.tableView reloadData:textField];
    return YES;
}


@end
