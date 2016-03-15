//
//  EditproductViewController.h
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Products.h"

@interface EditproductViewController : UIViewController<UITextFieldDelegate>

@property (retain, nonatomic) IBOutlet UITextField *EditProductTextLabel;
@property (retain, nonatomic) IBOutlet UITextField *EditLogoTextField;
- (IBAction)SubmitButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *submitButtonOutlet;

@property (retain, nonatomic) IBOutlet UITextField *WebLinkTextField;
@property (strong,nonatomic)NSString *webLinkString;
@property (strong, nonatomic)NSString *productNameString;
@property (strong, nonatomic)NSString *logoString; 
@property (nonatomic,strong) NSMutableArray *productsArray;
- (IBAction)saveButton:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *saveButtonOutlet;
@property (nonatomic)int currentCompanyIdentificaion;

@property (strong, nonatomic)Products *productPassedIn; 
@end
