//
//  CompanyCollectionViewController.h
//  NavCtrl
//
//  Created by Will Devon-sand on 3/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "Company.h"
#import "ProductCollectionViewController.h"
#import "CompanyEditViewController.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "AFNetworking.h"

@interface CompanyCollectionViewController : UICollectionViewController< UIGestureRecognizerDelegate>
@property (nonatomic, strong)DAO *dao;
@property (nonatomic, retain) IBOutlet  ProductCollectionViewController *
productCollectionViewController;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *logoList;
@property (strong, nonatomic)UILongPressGestureRecognizer *longPressRecongizer;
@property (nonatomic)int companyId; 
@end
