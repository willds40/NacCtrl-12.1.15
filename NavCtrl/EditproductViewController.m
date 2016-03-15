//
//  EditproductViewController.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "EditproductViewController.h"
#import "ProductViewController.h" 

@interface EditproductViewController ()

@end

@implementation EditproductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.productNameString !=nil) {
        self.EditProductTextLabel.text = self.productNameString;
        [self.submitButtonOutlet setHidden:YES];
    }else{
        [self.saveButtonOutlet setHidden:YES];
    }
    
    
    if (self.webLinkString!= nil) {
        self.WebLinkTextField.text = self.webLinkString;
    }

    if (self.logoString != nil) {
        self.EditLogoTextField.text = self.logoString;
    }
    
    self.EditProductTextLabel.delegate = self;
    self.EditLogoTextField.delegate =self;
    self.WebLinkTextField.delegate=self;

  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_EditProductTextLabel release];
    [_EditLogoTextField release];
    [_WebLinkTextField release];
    [_submitButtonOutlet release];
    [_saveButtonOutlet release];
    [super dealloc];
}
- (IBAction)SubmitButton:(id)sender {
    NSLog(@"The current company is %d", self.currentCompanyIdentificaion);
    
    
    [[DAO sharedDao] createNewProductWithCompanyId:self.currentCompanyIdentificaion andName:self.EditProductTextLabel.text andlogo:self.EditLogoTextField.text andUrl:self.WebLinkTextField.text];
    
    [self.productsArray addObject: [[DAO sharedDao] anotherProduct]] ;
    
    
    [self.navigationController popViewControllerAnimated:YES];//pops back to previous view controller.

}
- (IBAction)saveButton:(id)sender {
    
    self.productPassedIn.name = self.EditProductTextLabel.text;
    self.productPassedIn.logo = self.EditLogoTextField.text;
    self.productPassedIn.url = self.WebLinkTextField.text; 
    
    [self.navigationController popViewControllerAnimated:YES];//pops back to previous view controller.
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


@end
