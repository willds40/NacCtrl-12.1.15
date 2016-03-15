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
#import <CoreData/CoreData.h>

@interface DAO : NSObject




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
@property (nonatomic, strong)NSMutableArray *productList; 

//for Core Data
@property(nonatomic, strong) NSManagedObjectContext *context;
@property(nonatomic,strong) NSManagedObjectModel *model;

-(NSString *) archivePath;
-(void)initModelContext;

-(void)createNewCompany: (NSString *)company andlogo:(NSString *)logo andstockCodes:(NSString *)stockSymbol;
-(void)createNewProductWithCompanyId: (int)currentCompanyIdentificaion andName:(NSString *)name andlogo:(NSString *)logo andUrl: (NSString *)url;
-(void)deleteCompanyData:(int)companyID;
-(void)deleteProductData:(NSString *)productName;
+(DAO *)sharedDao;
-(void)fetchRequest;

-(void) saveChanges;
-(void)undoLastAction;
- (void)redoLastUndo;
-(void)rollbackAllChanges;
-(void)undoLastActionProductWithcurrentCompny:(Company *)currentCompany;
-(void)redoLastUndoforProductWithCurrentCompany: (Company *)currentCompany;
-(void)rollbackAllChangesProducts: (Company *)currentCompany;
@end
