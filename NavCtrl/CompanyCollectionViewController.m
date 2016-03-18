//
//  CompanyCollectionViewController.m
//  NavCtrl
//
//  Created by Will Devon-sand on 3/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCollectionViewController.h"
#import "CompanyEditViewController.h"
#import "CompanyCell.h"
#import "ProductViewController.h"
#import "AFNetworking.h"


#import "DAO.h"

@interface CompanyCollectionViewController ()

@end

@implementation CompanyCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dao = [DAO sharedDao];
    self.collectionView.delegate = self;
    
    
    self.installsStandardGestureForInteractiveMovement = TRUE;
    
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // LOAD UP THE NIB FILE FOR THE CELL
    UINib *nib = [UINib nibWithNibName:@"CompanyCell" bundle:nil];
    
    // REGISTER THE NIB FOR THE CELL WITH THE TABLE
    
    
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Add"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(addCompany)];
    self.navigationItem.leftBarButtonItem = addButton;
    [addButton release];
    
    
    UIBarButtonItem *saveChanges = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Save Changes"
                                    style:UIBarButtonItemStyleBordered
                                    target:self
                                    action:@selector(saveChanges)];
    UIBarButtonItem *undo = [[UIBarButtonItem alloc]
                             initWithTitle:@"Undo"
                             style:UIBarButtonItemStyleBordered
                             target:self
                             action:@selector(undoLastAction)];
    UIBarButtonItem *redo = [[UIBarButtonItem alloc]
                             initWithTitle:@"redo"
                             style:UIBarButtonItemStyleBordered
                             target:self
                             action:@selector(redoLastUndo)];
    
    UIBarButtonItem *undoAllChanges = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Undo All Changes"
                                       style:UIBarButtonItemStyleBordered
                                       target:self
                                       action:@selector(rollbackAllChanges)];
    
    
    //Centers the bottom tool bar.
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self setToolbarItems:[NSArray arrayWithObjects:undo,flexibleSpace, saveChanges, flexibleSpace , redo,flexibleSpace, undoAllChanges, nil]];
    [flexibleSpace release];
    
    [self.navigationController setToolbarHidden:NO];
    
    // Uncomment the following line to preserve selection between presentations.
//    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
   self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    [self.collectionView addGestureRecognizer:lpgr];
    
    [lpgr release];
    
    self.longPressRecongizer.delegate = self;
    
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setEditing:NO animated:true];
    [self.collectionView reloadData]; // to reload selected cell
    //create a gesture that passes to the editcompanyviewcontroller
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(runNSURLSession) userInfo:nil repeats:YES];
    [timer fire]; //the timer will fire once and then will fire every 60 seconds.
    
    
    [self runNSURLSession];
    
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.collectionView reloadData];
}


-(void)rollbackAllChanges{
    [[DAO sharedDao]rollbackAllChanges];
    [self.collectionView reloadData];
}

-(void)redoLastUndo{
    [[DAO sharedDao]redoLastUndo];
    [self.collectionView reloadData];
}
-(void)undoLastAction{
    [[DAO sharedDao]undoLastAction];
    [self.collectionView reloadData];
}

-(void)saveChanges{
    [[DAO sharedDao]saveChanges];
    
    
}
-(void)runNSURLSession{
    
    NSMutableArray *stockPriceArray = [[NSMutableArray alloc]init];
    for (Company *company in self.dao.companyList) {
        [stockPriceArray addObject:company.stockCodes];
    }
    
    
    NSString *stockURLBase = [NSString stringWithFormat:@"http://finance.yahoo.com/webservice/v1/symbols/%@",[stockPriceArray componentsJoinedByString:@"," ]];
    NSString *stockURl = [stockURLBase stringByAppendingString:@"/quote?format=json"];
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:stockURl];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            for (int i =0;i<[[responseObject valueForKeyPath:@"list.resources"] count] ; i++) {
                NSString *stockPrice = [[[responseObject valueForKeyPath:@"list.resources"]objectAtIndex:i]valueForKeyPath:@"resource.fields.price"];
                [[self.dao.companyList objectAtIndex:i]setStockPrice:stockPrice];
                
                NSLog(@"The stock price is %@",stockPrice); 
                
                
            }

        }
        
        [self.collectionView reloadData];
    }];
    [dataTask resume];
   
    [stockPriceArray dealloc];

}
    

-(void)addCompany{
    CompanyEditViewController *companyAdd = [[CompanyEditViewController alloc]init];
    [self.navigationController pushViewController:companyAdd animated:YES];
    [companyAdd release];
}
-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{    //push to the companyeditview controller

    
    CGPoint p = [gestureRecognizer locationInView:self.collectionView];
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:p];
    NSLog(@"%ld", (long)indexPath.row);
    
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        
        NSLog(@"long press on table view at row %ld", (long)indexPath.row);
        
        
        CompanyEditViewController *companyEdit = [[CompanyEditViewController alloc]init];
        Company * comp = self.dao.companyList[indexPath.row];
        
        
        companyEdit.companyName = comp.name;
        companyEdit.logoName = comp.logo;
        
        companyEdit.indexPathRow = indexPath.row;
        
        [self.navigationController pushViewController:companyEdit animated:YES];
        [companyEdit release];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

      return [self.dao.companyList count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CompanyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
   cell.CompanyName.text = [[self.dao.companyList objectAtIndex:[indexPath row]] name];
    cell.CompanyImage.image = [UIImage imageNamed:[[self.dao.companyList objectAtIndex:[indexPath row]]logo]];
    cell.StockSymbol.text =[[self.dao.companyList objectAtIndex:[indexPath row]] stockPrice];
    if (self.editing == true) {
        cell.DeleteButton.hidden = false;
    }else{
        cell.DeleteButton.hidden = true;
    }
    
    
    [cell.DeleteButton addTarget:self action:@selector(deleteCompanyData:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/


// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}


// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
	
}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [[DAO sharedDao] setIndexPathRow:indexPath.row];
    
    
    self.productCollectionViewController= [[ProductCollectionViewController alloc]initWithNibName:@"ProductCollectionViewController" bundle:nil];
    self.productCollectionViewController.currentCompany = self.dao.companyList[indexPath.row];
    
    NSLog(@"%@", self.dao.companyList[indexPath.row]);
    
    Company *comp = self.dao.companyList[indexPath.row];
    NSLog(@"Selected Comp Name %@", comp.name);

    
    [self.navigationController
     pushViewController:self.productCollectionViewController
     animated:YES];
    [ProductCollectionViewController dealloc];

}
-(void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    id object = [[[self.companyList objectAtIndex:sourceIndexPath.row] retain] autorelease];
    [self.dao.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.dao.companyList insertObject:object atIndex:destinationIndexPath.row];
    
    id object1 = [[[self.logoList objectAtIndex:sourceIndexPath.row] retain] autorelease];
    [self.dao.logoList removeObjectAtIndex:sourceIndexPath.row];
    [self.dao.logoList insertObject:object1 atIndex:destinationIndexPath.row];
}
-(void)deleteCompanyData: (id)sender{
    
    UIButton *senderButton = (UIButton *)sender;

     NSIndexPath *indexPath = [self.collectionView indexPathForCell:(CompanyCell *)[[senderButton superview]superview]];
    NSLog(@"The collection is %ld", (long)indexPath.row);
    
    int deleteID = [[self.dao.companyList objectAtIndex:indexPath.row] id] ;
    [self.dao deleteCompanyData:deleteID];
   [self.collectionView reloadData];
}


    @end
