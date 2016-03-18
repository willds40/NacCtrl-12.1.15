//
//  ProductCollectionViewController.h
//  NavCtrl
//
//  Created by Will Devon-sand on 3/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompanyViewController.h"
#import "DAO.h"
@class detailViewController;

@interface ProductCollectionViewController : UICollectionViewController< UIGestureRecognizerDelegate>
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic)int *currentCompanyId;


-(void)pushToProductViewEditor;

@end
