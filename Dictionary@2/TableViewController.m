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


-(id)initWithStyle:(UITableViewStyle)style{
    self = [super initWithStyle:style];
    if(self){
        UIBarButtonItem*barButtonEdit = [[UIBarButtonItem alloc]initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(beginEdit)];
        UIBarButtonItem*barDuttonSearch = [[UIBarButtonItem alloc]initWithTitle:@"SearchShow" style:UIBarButtonItemStylePlain target:self action:@selector(actionSearth:)];
        [self.navigationItem setRightBarButtonItems:@[barButtonEdit,barDuttonSearch]];
        self.barDuttonSearch = barDuttonSearch;
        self.flagOneScroll = YES;
        self.flagSearch = NO;
        self.numberObject = 0;
        self.offset = 1000;
        self.pointZiro = 0;
        self.arrayVisible = [NSArray arrayWithArray:[self.manager.mainArray subarrayWithRange:NSMakeRange(0, 1000)]];
    }
    return self;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

         self.numberObject = [searchText integerValue];
         if(self.numberObject >=0 && self.numberObject <=38000){
             self.pointZiro = 100;
             if(self.numberObject - self.pointZiro < 0)
                 self.pointZiro = self.numberObject;
             self.arrayVisible = [NSArray arrayWithArray:[self.manager.mainArray subarrayWithRange:NSMakeRange(self.numberObject-self.pointZiro,self.offset)]];
             self.flagSearch = YES;
             [self.tableView reloadData];
             [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:self.pointZiro] atScrollPosition:UITableViewScrollPositionTop animated:NO];
             [self.tableView reloadData];
         }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.placeholder = @"input number at object";
    //searchBar.prompt =  @"search";
    searchBar.barTintColor = [[UIColor redColor]colorWithAlphaComponent:0.3];
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    self.barDuttonSearch.title = @"SearchShow";
    self.barDuttonSearch.tintColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
    self.tableView.tableHeaderView = nil;
    [self.tableView reloadData];
}

-(void)actionSearth:(UIBarButtonItem*)sender{
    if([sender.title isEqual: @"SearchShow"]){
        sender.title = @"SearchDown";
        sender.tintColor = [[UIColor purpleColor]colorWithAlphaComponent:0.8];
        self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(200, 70, 400, 27)];
        self.searchBar.delegate = self;
        [[self.tableView superview] addSubview:self.searchBar];
        [self.searchBar becomeFirstResponder];
    }else{
        sender.title = @"SearchShow";
        sender.tintColor = [[UIColor blueColor]colorWithAlphaComponent:0.8];
        self.tableView.tableHeaderView = nil;
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
    UITableViewHeaderFooterView*header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:identifaerHeader];
    if(!header)
        header = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:identifaerHeader];
    NSString*nameObject;
    if(self.flagSearch)
        nameObject = [NSString stringWithFormat:@"Object %ld",(long)section+self.numberObject-self.pointZiro];
    else
        nameObject = [NSString stringWithFormat:@"Object %ld",(long)section+self.pointZiro+self.numberObject];
    return nameObject;
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
    NSInteger countVisibleFirst = self.tableView.indexPathsForVisibleRows.firstObject.section;
    if(countVisibleFirst == 800){
        if(self.flagOneScroll == YES){
            self.pointZiro = self.pointZiro + 600;
            self.arrayVisible = [NSArray arrayWithArray:[self.manager.mainArray subarrayWithRange:NSMakeRange(self.numberObject+self.pointZiro, self.offset)]];
            [self.tableView reloadData:nil];
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:200] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            [self.tableView reloadData:nil];
            self.flagOneScroll = NO;
            self.flagSearch = NO;
        }
    }else
        self.flagOneScroll = YES;



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
