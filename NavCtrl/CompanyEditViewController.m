//
//  CompanyEditViewController.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyEditViewController.h"

@interface CompanyEditViewController ()

@end

@implementation CompanyEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.companyName != nil) {
        self.companyEdit.text = self.companyName;
        [self.submitButtonOutlet setHidden:YES];
            }
    else{
        [self.saveButtonOutlet setHidden:YES]; 
    
    }
    if (self.logoName != nil) {
        self.companyImageEdit.text = self.logoName; 
    }
    
    // Do any additional setup after loading the view from its nib.
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
    [_companyEdit release];
    [_companyImageEdit release];
    [_submitButtonOutlet release];
    [_saveButtonOutlet release];
    [_stockSymbolAdd release];
    [super dealloc];
}
- (IBAction)submitButton:(id)sender {

    
    [[DAO sharedDao] createNewCompany:self.companyEdit.text
                              andlogo:self.companyImageEdit.text andstockCodes:self.stockSymbolAdd.text];
    
 
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (IBAction)saveButton:(id)sender {
    
    [[DAO sharedDao]editCompanyName:self.companyEdit.text andlogo:self.companyImageEdit.text androw:self.indexPathRow andStockSymbol:self.stockSymbolAdd.text];
    [self.navigationController popToRootViewControllerAnimated:YES];

    
}
@end
