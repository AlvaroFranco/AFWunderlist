//
//  ViewController.h
//  AFWunderlist-Demo
//
//  Created by Alvaro Franco on 2/1/14.
//  Copyright (c) 2014 AlvaroFranco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *emailField;
@property (nonatomic, strong) IBOutlet UITextField *passField;
@property (nonatomic, strong) IBOutlet UIButton *loginButton;

@end
