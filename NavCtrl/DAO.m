//
//  DAO.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import <sqlite3.h>
@interface DAO()
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrResults;
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

-(void)copyDatabaseIntoDocumentsDirectory;
@end


@implementation DAO

+ (DAO *)sharedDao {
    
    NSLog(@"sharedDao called");
    
    static DAO *_sharedInstance = nil;

    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DAO alloc] initWithDatabaseFilename:@"stock.db"];
        [_sharedInstance uploadCompanies];
    });
    
    return _sharedInstance;
}

#pragma mark create And Edit Methods

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    self = [super init];
    if (self) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        
        // Keep the database filename.
        self.databaseFilename = dbFilename;
        // Copy the database file into the documents directory if necessary.
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}
-(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    // Create a sqlite object.
    sqlite3 *sqlite3Database;
    
    // Set the database file path.
    _databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    // Initialize the results array.
    if (self.arrResults != nil) {
        
    [self.arrResults removeAllObjects];
      [_arrResults release];
//        self.arrResults = nil;
    }
    _arrResults = [[NSMutableArray alloc] init];
    
    // Initialize the column names array.
    if (_arrColumnNames != nil) {
        [_arrColumnNames removeAllObjects];
        [self.arrColumnNames release];
        _arrColumnNames = nil;
    }
    
    
    
    // Open the database.
    int openDatabaseResult = sqlite3_open([self.databasePath UTF8String], &sqlite3Database);
    
    
    if(openDatabaseResult == SQLITE_OK){
        // Declare a sqlite3_stmt object in which will be stored the query after having been compiled into a SQLite statement.
        sqlite3_stmt *compiledStatement;
        
        // Load all data from database to memory.
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {
            if (!queryExecutable){
                // In this case data must be loaded from the database.
                
                // Declare an array to keep the data for each fetched row.
                NSMutableArray *arrDataRow;
                
                // Loop through the results and add them to the results array row by row.
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                    // Initialize the mutable array that will contain the data of a fetched row.
                    arrDataRow = [[NSMutableArray alloc] init];
                    
                    // Get the total number of columns.
                    int totalColumns = sqlite3_column_count(compiledStatement);
                    
                    // Go through all columns and fetch each column data.
                    for (int i=0; i<totalColumns; i++){
                        // Convert the column data to text (characters).
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        
                        // If there are contents in the currenct column (field) then add them to the current row array.
                        if (dbDataAsChars != NULL) {
                            // Convert the characters to string.
                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                        
                        // Keep the current column name.
                        if(!_arrColumnNames){
                            _arrColumnNames = [[NSMutableArray alloc] init];
                        }
                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                   
                    // Store each fetched data row in the results array, but first check if there is actually data.
                    if (arrDataRow.count > 0) {
                        NSLog(@"%@", arrDataRow);
                        [self.arrResults addObject:arrDataRow];
                        
                    }
                    [arrDataRow release];
                }
            }else {
                // This is the case of an executable query (insert, update, ...).
                
                // Execute the query.
                NSInteger executeQueryResults = sqlite3_step(compiledStatement);
                if (executeQueryResults == SQLITE_DONE) {
                    // Keep the affected rows.
                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    
                    // Keep the last inserted row ID.
                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                }
                else {
                    // If could not execute the query show the error message on the debugger.
                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        }else {
            // In the database cannot be opened then show the error message on the debugger.
            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        // Release the compiled statement from memory.
        sqlite3_finalize(compiledStatement);
       
    }
    
    // Close the database.
    sqlite3_close(sqlite3Database);
    
  
    
    }
-(NSArray *)loadDataFromDB:(NSString *)query{
    // Run the query and indicate that is not executable.
    // The query string is converted to a char* object.
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    
    // Returned the loaded results.
    return (NSArray *)self.arrResults;
}
-(void)executeQuery:(NSString *)query{
    // Run the query and indicate that is executable.
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}
-(void)uploadCompanies{
    
    
    [self runQuery:"select * from company" isQueryExecutable:false];

    
    _companyList = [[NSMutableArray alloc]init];
    for (int i= 0; i < [_arrResults count]; i++) {
        Company *companyFromDatabase = [[Company alloc]initWithid:_arrResults[i][0] andName:_arrResults[i][1] andLogo:_arrResults[i][2] andStockCodes:_arrResults[i][3]];
        NSLog(@"Result two %@", _arrResults[i][0]);
        
        
        [self.companyList addObject:companyFromDatabase];
        [companyFromDatabase release];
        
    
    }


    for (int i =0; i< [self.companyList count]; i++) {
        
        
        [self uploadProducts:self.companyList[i]];
        
    }
    
    
    NSLog(@"Companylist %@",self.companyList);

}

-(void)uploadProducts: (Company*)company{
    
    NSString *sql = [NSString stringWithFormat:@"select * from Product WHERE company_id = %@", company.identication];
    
    
    [self runQuery:[sql UTF8String] isQueryExecutable:false];
 
    
   _products = [[NSMutableArray alloc]init];
    company.products = _products;
   [_products release];
    
    
    for (int i= 0; i < [self.arrResults count]; i++){
        Products *productFromDatabase = [[Products alloc]initWithComanyIdentification: self.arrResults[i][1] andName:self.arrResults[i][2] andlogo:self.arrResults[i][3] andurl:self.arrResults[i][4]] ;
        [company.products addObject:productFromDatabase];
        [productFromDatabase release];
        
    
    }
 
}


-(void)createNewCompany:(NSString*)companyName andlogo: (NSString*)logo andstockCodes: (NSString *)stockCodes{
    NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO COMPANY (name,logo,stock_symbol) VALUES ('%@','%@','%@')",companyName,logo,stockCodes];
    
    [self executeQuery:insertStmt];

    NSLog(@"Company added to DB");
    int companyListCount = [self.companyList count]+1;//counting the number of items in the companyList
    
    NSString* companyCountString = [@(companyListCount) stringValue];//Coverting that number in a string so I can use the custom init method.
            
            Company *newCompany = [[Company alloc]initWithid:companyCountString andName:companyName andLogo:logo andStockCodes:stockCodes];
            [self.companyList addObject:newCompany];
            [newCompany release];

   }
-(void)createNewProductWithCompanyIdentification: (NSString *)companyId andName: (NSString *)name andlogo: (NSString *)logo andUrl: (NSString *)url{

        NSString *insertStmt = [NSString stringWithFormat:@"INSERT INTO PRODUCT (company_id, name,logo,web_link) VALUES ('%@','%@','%@','%@')",companyId, name,logo,url];
        [self executeQuery:insertStmt];
        NSLog(@"Product added to DB");
            
            _anotherProduct = [[Products alloc]initWithComanyIdentification:companyId andName:name andlogo:logo andurl:url];
             
        }
        
-(void)deleteCompanyData:(NSString *)deleteQuery
{
  NSString * deleteQueryCompany =  [NSString stringWithFormat:@"DELETE FROM company WHERE id = %@",deleteQuery];
    
    [self executeQuery:deleteQueryCompany];
    
}


-(void)deleteProductData:(NSString *)deleteQuery
{
 // NSString *deleteQueryProduct =  [NSString stringWithFormat:@"DELETE FROM product WHERE name = '%@'", deleteQuery];
    
    
   // [self executeQuery:deleteQueryProduct];
    
}


@end
