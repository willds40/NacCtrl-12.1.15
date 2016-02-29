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
#import <sqlite3.h>

@interface DAO : NSObject


@property (nonatomic)sqlite3 *stockDB;

@property (nonatomic,retain)NSMutableArray *currentCompany;
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *products;
@property (strong, retain) Products *currentProduct;
@property (nonatomic, retain) NSMutableArray *logoList; //creating an array of logos
@property (nonatomic) NSUInteger indexPathRow;
@property (nonatomic, strong)Products *anotherProduct;
@property (nonatomic, strong) NSMutableArray *arrayOfStockPrices;
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property(nonatomic, strong)NSString *databasePath; 

//For the Database
@property (nonatomic) long long lastInsertedRowID;

-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;
-(void)deleteCompanyData:(NSString *)deleteQuery;
-(void)deleteProductData:(NSString *)deleteQuery;


-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;



+(DAO *)sharedDao;
-(void)createNewCompany:(NSString*)companyName andlogo: (NSString*)logo andstockCodes: (NSString *)stockPrice;
-(void)createNewProductWithCompanyIdentification: (NSString *)companyId andName: (NSString *)name andlogo: (NSString *)logo andUrl: (NSString *)url;
//-(void)UpdateStockPrice;
@end
