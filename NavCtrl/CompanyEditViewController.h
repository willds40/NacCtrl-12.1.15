//
//  CompanyEditViewController.h
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "CompanyViewController.h"

@interface CompanyEditViewController : UIViewController <UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITextField *companyEdit;
@property (retain, nonatomic) IBOutlet UITextField *companyImageEdit;
@property (retain, nonatomic) IBOutlet UITextField *stockSymbolAdd;

@property (strong, nonatomic) NSString *companyName;
@property (strong, nonatomic)NSString *logoName;
- (IBAction)submitButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *submitButtonOutlet;
@property (retain, nonatomic) IBOutlet UIButton *saveButtonOutlet;
- (IBAction)saveButton:(id)sender;
@property (nonatomic) NSInteger indexPathRow;



@end
