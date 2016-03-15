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
@end


@implementation DAO

+ (DAO *)sharedDao {
    
    NSLog(@"sharedDao called");
    
    static DAO *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DAO alloc] init];
        [_sharedInstance initModelContext];
        [_sharedInstance fetchRequest];
        
            });
    
    return _sharedInstance;
}


#pragma mark create And Edit Methods

-(void)initModelContext
{
    // 1. Creating ObjectModel which describes the schema.
    [self setModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    
    NSPersistentStoreCoordinator *psc =
    [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self model]];
    
    // 2. Creating Context.
    NSString *path = [self archivePath];
    NSLog(@" The path is %@", path);
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    if(![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        [NSException raise:@"Open failed" format:@"Reason: %@", [error localizedDescription]];
    }
    
 [self setContext:[[NSManagedObjectContext alloc] init]];
    self.context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    //Add an undo manager
    self.context.undoManager = [[NSUndoManager alloc] init];
    
    //3. Now the context points to the SQLite store
    [[self context] setPersistentStoreCoordinator:psc];
//    [[self context] setUndoManager:nil];
}
// Physical storage location in device.
-(NSString*) archivePath
{
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"store.data"];
    
    }

-(void)fetchRequest{
    //fetching records
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Company"];
    
    //Add sort Descriptor
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES
                                        ];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    //Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&fetchError];
    
    
    if (!fetchError) {
        //Adding it to the company list
        self.companyList = [[NSMutableArray alloc]init];
        for (NSManagedObject *managedCompany in result) {
            
            Company *company = [[Company alloc]
            initWithName:[managedCompany valueForKey:@"name"]
            andLogo:[managedCompany valueForKey:@"logo"]
            andStockCodes:[managedCompany valueForKey:@"stockSymbol"]];
            company.id = [[managedCompany valueForKey:@"id"] intValue];
            
            
            [self.companyList addObject:company];
           [self fetchRequestProducts:company];
        }
    } else {
        NSLog(@"Error fetching data");
        NSLog(@" %@, %@", fetchError, fetchError.localizedDescription);
        
    }
    if (result == nil || [result count] == 0) //Create a Company{
        
        [self hardCodedValues];
}
-(void)fetchRequestProducts: (Company *)companyFetched{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Product"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", @"id",companyFetched.id];
    [fetchRequest setPredicate:predicate];

    //Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        
    
    companyFetched.products =[[NSMutableArray alloc]init];
    
    
    for (NSManagedObject *managedProduct in result) {
        
        Products *productFromDatabase = [[Products alloc]initWithName:[managedProduct valueForKey:@"name"] andlogo:[managedProduct valueForKey:@"logo"] andurl:[managedProduct valueForKey:@"url"]];
        
        [companyFetched.products addObject:productFromDatabase];
    }
    
    }

}
-(void)hardCodedValues
    {
        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Company" inManagedObjectContext:self.context];
        NSManagedObject *apple = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.context];
        [apple setValue:@"Apple Moble Debices" forKey:@"name"];
        [apple setValue:@"apple.png" forKey:@"logo"];
        [apple setValue:@"AAPL" forKey:@"stockSymbol"];
        [apple setValue:@0 forKey:@"id"];
        
        
         NSManagedObject *google = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.context];
        [google setValue:@"Google Mobile Devices" forKey:@"name"];
        [google setValue:@"google.jpg" forKey:@"logo"];
        [google setValue:@"GOOG" forKey:@"stockSymbol"];
        [google setValue:@1 forKey:@"id"];
        
        
        NSManagedObject *samsung = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.context];
        [samsung setValue:@"Samsung Mobile Devices" forKey:@"name"];
        [samsung setValue:@"samsung.jpeg" forKey:@"logo"];
        [samsung setValue:@"SSNLF" forKey:@"stockSymbol"];
        [samsung setValue:@2 forKey:@"id"];
        
       
        NSManagedObject *windows = [[NSManagedObject alloc]initWithEntity:entityDescription insertIntoManagedObjectContext:self.context];
        [windows setValue:@"Windows Mobile Devices" forKey:@"name"];
        [windows setValue:@"windows.png" forKey:@"logo"];
        [windows setValue:@"MSFT" forKey:@"stockSymbol"];
        [windows setValue:@4 forKey:@"id"];

        //Apple Products
        NSEntityDescription *entityDescription2 = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.context];
        NSManagedObject *iphone = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [iphone setValue:@"Iphone" forKey:@"name"];
        [iphone setValue:@"iphone.jpg" forKey:@"logo"];
        [iphone setValue:@"http://www.apple.com/iphone/?cid=oas-us-domains-iphone.com" forKey:@"url"];
        [iphone setValue:@0 forKey:@"id"];
        [iphone setValue:apple forKey:@"company"];
        
        
        NSManagedObject *ipad = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [ipad setValue:@"Ipad" forKey:@"name"];
        [ipad setValue:@"ipad.jpg" forKey:@"logo"];
        [ipad setValue:@"http://www.apple.com/ipad/" forKey:@"url"];
        [ipad setValue:@0 forKey:@"id"];
        [ipad setValue:apple forKey:@"company"];
        
        NSManagedObject *ipod = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [ipod setValue:@"Ipod" forKey:@"name"];
        [ipod setValue:@"ipod.jpg" forKey:@"logo"];
        [ipod setValue:@"http://www.apple.com/ipod/" forKey:@"url"];
        [ipod setValue:@0 forKey:@"id"];
        [ipod setValue:apple forKey:@"company"];
        
        //Google Products
        
        
        NSManagedObject *nexus4 = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [nexus4 setValue:@"Nexus 4" forKey:@"name"];
        [nexus4 setValue:@"nexus4.png" forKey:@"logo"];
        [nexus4 setValue:@"http://www.gsmarena.com/lg_nexus_4_e960-5048.php" forKey:@"url"];
        [nexus4 setValue:@1 forKey:@"id"];
        [nexus4 setValue:google forKey:@"company"];

        
        
        NSManagedObject *nexus5= [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [nexus5 setValue:@"Nexus 5" forKey:@"name"];
        [nexus5 setValue:@"nuxus5.jpg" forKey:@"logo"];
        [nexus5 setValue:@"https://www.google.com/nexus/5x/" forKey:@"url"];
        [nexus5 setValue:@1 forKey:@"id"];
        [nexus5 setValue:google forKey:@"company"];


        
        
        NSManagedObject *nexus6p= [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [nexus6p setValue:@"Nexus 6" forKey:@"name"];
        [nexus6p setValue:@"nuxus6p.jpg" forKey:@"logo"];
        [nexus6p setValue:@"https://store.google.com/product/nexus_6p" forKey:@"url"];
        [nexus6p setValue:@1 forKey:@"id"];
        [nexus6p setValue:google forKey:@"company"];


        
        //Samsung Products
        
        NSManagedObject *galaxyTab= [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [galaxyTab setValue:@"Galaxy Tab" forKey:@"name"];
        [galaxyTab setValue:@"galaxytab.png" forKey:@"logo"];
        [galaxyTab setValue:@"http://www.samsung.com/us/mobile/galaxy-tab/" forKey:@"url"];
        [galaxyTab setValue:@2 forKey:@"id"];
        [galaxyTab setValue:samsung forKey:@"Company"];

        
        
        NSManagedObject *galaxy4= [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [galaxy4 setValue:@"Galaxy 4" forKey:@"name"];
        [galaxy4 setValue:@"galaxys4.jpg" forKey:@"logo"];
        [galaxy4 setValue:@"http://www.gsmarena.com/samsung_i9500_galaxy_s4-5125.php" forKey:@"url"];
        [galaxy4 setValue:@2 forKey:@"id"];
        [galaxy4 setValue:samsung forKey:@"Company"];

        
        NSManagedObject *galaxyNote= [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [galaxyNote setValue:@"Galaxy Note" forKey:@"name"];
        [galaxyNote setValue:@"galaxynote.png" forKey:@"logo"];
        [galaxyNote setValue:@"http://www.gsmarena.com/samsung_galaxy_note_4-6434.php" forKey:@"url"];
        [galaxyNote setValue:@2 forKey:@"id"];
        [galaxyNote setValue:samsung forKey:@"Company"];


    //Windows  Phones
        
        NSManagedObject *milkyway = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [milkyway setValue:@"Milkyway" forKey:@"name"];
        [milkyway setValue:@"milkyway.jpg" forKey:@"logo"];
        [milkyway setValue:@"https://en.wikipedia.org/wiki/Milky_Way" forKey:@"url"];
        [milkyway setValue:@3 forKey:@"id"];
        [milkyway setValue:windows forKey:@"Company"];
        
        
        
        NSManagedObject *windowsLuma = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [windowsLuma setValue:@"Windows Luma" forKey:@"name"];
        [windowsLuma setValue:@"windowsLuma.jpg" forKey:@"logo"];
        [windowsLuma setValue:@"http://www.microsoft.com/en/mobile/phones/lumia/" forKey:@"url"];
        [windowsLuma setValue:@3 forKey:@"id"];
        [windowsLuma setValue:windows forKey:@"Company"];
        
        
        NSManagedObject *destroyer = [[NSManagedObject alloc]initWithEntity:entityDescription2 insertIntoManagedObjectContext:self.context];
        [destroyer setValue:@"Destroyer" forKey:@"name"];
        [destroyer setValue:@"destroyer.gif" forKey:@"logo"];
        [destroyer setValue:@"https://en.wikipedia.org/wiki/Destroyer" forKey:@"url"];
        [destroyer setValue:@3 forKey:@"id"];
        [destroyer setValue:windows forKey:@"Company"];

       [self saveChanges];
        [self fetchRequest];
    }
    





-(void)createNewCompany: (NSString *)company andlogo:(NSString *)logo andstockCodes:(NSString *)stockSymbol{
    
    //Add this object to the contex. Nothing happens till it is saved
    
    Company *nscompany = [[Company alloc]initWithName:company andLogo:logo andStockCodes:stockSymbol];
    
    NSManagedObject *newCompany = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:[self context]];
    
    [newCompany setValue:company forKey:@"name"];
    [newCompany setValue:logo forKey:@"logo"];
    [newCompany setValue:stockSymbol forKey:@"stockSymbol"];
    [newCompany setValue:@([self.companyList count]+1 )forKey:@"id"];
    
    

    [self.companyList addObject:nscompany];
    //No save now. There is a separate 'Save to Disk' now to try undo functionality
//    [self saveChanges];
//

}

-(void)createNewProductWithCompanyId: (int)currentCompanyIdentificaion andName:(NSString *)name andlogo:(NSString *)logo andUrl: (NSString *)url{
    
    
    
    
self.anotherProduct = [[Products alloc]initWithName:name andlogo:logo andurl:url];
    
NSEntityDescription *entityProduct = [NSEntityDescription entityForName:@"Product" inManagedObjectContext:self.context];
    NSManagedObject *newProduct= [[NSManagedObject alloc]initWithEntity:entityProduct insertIntoManagedObjectContext:self.context];
    [newProduct setValue:name forKey:@"name"];
    [newProduct setValue:logo forKey:@"logo"];
    [newProduct setValue:url forKey:@"url"];
    
   
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Company"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", @"id",currentCompanyIdentificaion];
    [fetchRequest setPredicate:predicate];

    
    
    //Execute Fetch Request
    NSError *fetchError = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        for (NSManagedObject *companyAtIndex in result) {
            NSLog(@"%@", [companyAtIndex valueForKey:@"name"]);
           
            [companyAtIndex setValue:[NSSet setWithObject:newProduct] forKey:@"products"];
        }
    } else {
        NSLog(@"Error fetching data");
        NSLog(@" %@, %@", fetchError, fetchError.localizedDescription);
    }

    
    
    
    

//     [self saveChanges];
    }

-(void)deleteCompanyData:(int)companyID{
    
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Company"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %d", @"id",companyID];
    [fetchRequest setPredicate:predicate];
   
    
    
    NSError *fetchError = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        for (NSManagedObject *companyAtIndex in result) {
            NSLog(@"%@", [companyAtIndex valueForKey:@"name"]);
        }
    } else {
        NSLog(@"Error fetching data");
        NSLog(@" %@, %@", fetchError, fetchError.localizedDescription);
    }
    
    NSManagedObject *person3 = (NSManagedObject *)[result objectAtIndex:0];
        [self.context deleteObject:person3];
    
        NSError *deleteError = nil;
        if (![person3.managedObjectContext save:&deleteError]) {
            NSLog(@" Unable to sae object context");
            NSLog(@ " %@, %@,", deleteError, deleteError.localizedDescription);
        }else{
    
            NSLog(@" The delete was succesful");
        }
    
//    [self saveChanges];
}
-(void)deleteProductData:(NSString *)productName{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]initWithEntityName:@"Product"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"name",productName];
    [fetchRequest setPredicate:predicate];
    
    
    NSError *fetchError = nil;
    NSArray *result = [self.context executeFetchRequest:fetchRequest error:&fetchError];
    if (!fetchError) {
        for (NSManagedObject *companyAtIndex in result) {
            NSLog(@"%@", [companyAtIndex valueForKey:@"name"]);
        }
    } else {
        NSLog(@"Error fetching data");
        NSLog(@" %@, %@", fetchError, fetchError.localizedDescription);
    }
    
    NSManagedObject *person3 = (NSManagedObject *)[result objectAtIndex:0];
    [self.context deleteObject:person3];
    
    NSError *deleteError = nil;
    if (![person3.managedObjectContext save:&deleteError]) {
        NSLog(@" Unable to sae object context");
        NSLog(@ " %@, %@,", deleteError, deleteError.localizedDescription);
    }else{
        
        NSLog(@" The delete was succesful");
    }
    
//    [self saveChanges];




}

// On calling this, actual saving is done in the Core Data table
-(void) saveChanges
{
    NSError *err = nil;
    BOOL successful = [[self context] save:&err];
    if(!successful)
    {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    NSLog(@"Data Saved");
}

-(void)undoLastAction {
    
    [self.context undo];
    
    [self fetchRequest];
    
}

-(void)undoLastActionProductWithcurrentCompny:(Company *)currentCompany{

    [self.context undo];
    
    [self fetchRequestProducts:currentCompany];

}

- (void)redoLastUndo {
    
    [self.context redo];
    
    [self fetchRequest];
}

- (void)redoLastUndoforProductWithCurrentCompany: (Company *)currentCompany{
    
    [self.context redo];
    
    [self fetchRequestProducts:currentCompany];
}




-(void)rollbackAllChanges{
    
    [self.context rollback];
    
    [self fetchRequest];
    
}

-(void)rollbackAllChangesProducts: (Company *)currentCompany{

    [self.context rollback];
    
    [self fetchRequestProducts:currentCompany];
    

}


@end
