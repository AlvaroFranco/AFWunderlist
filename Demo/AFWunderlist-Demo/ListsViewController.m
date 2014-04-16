//
//  ListsViewController.m
//  AFWunderlist-Demo
//
//  Created by Alvaro Franco on 2/1/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "ListsViewController.h"
#import "WLClient.h"

@interface ListsViewController ()

@property (nonatomic, strong) NSMutableArray *lists;
@property (nonatomic, strong) NSMutableArray *tasks;

@end

@implementation ListsViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;
    
    _lists = [[NSMutableArray alloc]init];
    _tasks = [[NSMutableArray alloc]init];
    
    [[WLClient sharedClient]getListsWithCompletion:^(NSDictionary *response, BOOL success) {
        for (NSDictionary *dict in response) {
            [_lists addObject:dict];
        }
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:NO];
    }];
    
    [[WLClient sharedClient]getTasksWithCompletion:^(NSDictionary *response, BOOL success) {
        for (NSDictionary *dict in response) {
            [_tasks addObject:dict];
        }
        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:Nil waitUntilDone:NO];
    }];
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return _lists.count;
    } else {
        return _tasks.count;
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"Lists";
    } else {
        return @"Tasks";
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    
    if (indexPath.section == 0) {
        cell.textLabel.text = [[_lists objectAtIndex:indexPath.row]objectForKey:@"title"];
    } else {
        cell.textLabel.text = [[_tasks objectAtIndex:indexPath.row] objectForKey:@"title"];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"That's not all!" message:@"Looking for more features? Take a look into the README at the GitHub repo of AFWunderlist" delegate:self cancelButtonTitle:@"OK, I'll do it" otherButtonTitles:@"Thanks, not interested",nil];
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
