//
//  DAO.h
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "Company.h"
#import "Products.h"

@interface DAO : NSObject
@property (nonatomic,retain)NSMutableArray *currentCompany;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSArray *products;
@property (strong, retain) Products *currentProduct;

+(DAO *)sharedDao;
-(void)uploadCompanies;
@end
