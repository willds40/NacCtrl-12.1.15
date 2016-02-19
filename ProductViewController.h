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
@class ProductViewController;

@interface ProductViewController : UITableViewController
@property (nonatomic, retain) Company *currentCompany;
-(void)pushToProductViewEditor;
@end
