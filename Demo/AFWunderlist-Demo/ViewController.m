//
//  ViewController.m
//  AFWunderlist-Demo
//
//  Created by Alvaro Franco on 2/1/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import "ViewController.h"
#import "WLClient.h"

@interface ViewController ()

-(void)toggleLogin;

@end

@implementation ViewController

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    _emailField.delegate = self;
    [_emailField becomeFirstResponder];
    
    _passField.delegate = self;
    _passField.secureTextEntry = YES;
        
    [_loginButton addTarget:self action:@selector(toggleLogin) forControlEvents:UIControlEventTouchUpInside];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _emailField) {
        [_passField becomeFirstResponder];
    } else {
        [self toggleLogin];
    }
    
    return YES;
}

-(void)toggleLogin {
    [[WLClient sharedClient]loginWithEmail:_emailField.text andPassword:_passField.text withCompletion:^(BOOL success) {
        if (success) {
            [self performSegueWithIdentifier:@"PushTableView" sender:self];
        } else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops" message:@"User and password doesn't match with any record in the Wunderlist database" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
