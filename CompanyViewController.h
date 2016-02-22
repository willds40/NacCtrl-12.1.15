//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DAO.h"

@class ProductViewController;
@class CompanyEditViewController;

@interface CompanyViewController : UITableViewController
//<NSURLSessionDelegate, NSURLSessionDownloadDelegate>

@property (nonatomic,retain)NSMutableArray *currentCompany;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *logoList; //creating an array of logos
@property (nonatomic, strong)DAO *dao; 
@property (nonatomic, retain) IBOutlet  ProductViewController * productViewController;
@property (strong, nonatomic)UILongPressGestureRecognizer *longPressRecongizer;

 

@end
