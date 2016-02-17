//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
#import "DAO.h"
@class detailViewController;

@interface ProductViewController : UITableViewController
//@property (nonatomic, retain) NSArray *products;
//@property (nonatomic, retain) NSArray *logoProductList;
//@property(nonatomic, retain)NSString *currentCompanyString;
@property (nonatomic, retain) Company *currentCompany;
@end
