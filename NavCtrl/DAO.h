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
#import "EditproductViewController.h"

@interface DAO : NSObject
@property (nonatomic,retain)NSMutableArray *currentCompany;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;
@property (strong, retain) Products *currentProduct;
@property (nonatomic, retain) NSMutableArray *logoList; //creating an array of logos
@property (nonatomic) NSUInteger indexPathRow;
@property (nonatomic, strong)Products *anotherProduct;
@property (nonatomic, strong) NSMutableArray *arrayOfStockPrices;


+(DAO *)sharedDao;
-(void)uploadCompanies;
-(void)createNewCompany:(NSString*)companyName andlogo: (NSString*)logo andstockCodes: (NSString *)stockPrice;
-(void)createNewProduct:(NSString*)prdouctName andlogo: (NSString*)logo andUrl: (NSString *)url;
-(void)editCompanyName: (NSString *)name andlogo: (NSString *)logo androw: (NSInteger) indexPathRow;
-(void)editProductName:(NSString *)names andlogo: (NSString *)logo andUrl: (NSString*) url;
//-(void)UpdateStockPrice;
@end
