//
//  ProductCollectionViewController.m
//  NavCtrl
//
//  Created by Will Devon-sand on 3/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCollectionViewController.h"
#import "EditproductViewController.h"
#import "detailViewController.h"
#import "ProductCellCollectionViewCell.h"


@interface ProductCollectionViewController ()

@end

@implementation ProductCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.installsStandardGestureForInteractiveMovement = TRUE;
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // LOAD UP THE NIB FILE FOR THE CELL
    UINib *nib = [UINib nibWithNibName:@"ProductCellCollectionViewCell" bundle:nil];
    // REGISTER THE NIB FOR THE CELL WITH THE TABLE
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:reuseIdentifier];
    
    // instead of button - give a good name
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(pushToProductViewEditor)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"AddProduct" forState:UIControlStateNormal];
    button.frame = CGRectMake(300.0, 700.0, 160.0, 40.0);
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    
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
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    
    [self.collectionView reloadData];
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.collectionView reloadData];
}


-(void)rollbackAllChanges{
    [[DAO sharedDao]rollbackAllChangesProducts:self.currentCompany];
    [self.collectionView reloadData];
}

-(void)redoLastUndo{
    [[DAO sharedDao]redoLastUndoforProductWithCurrentCompany:self.currentCompany];
    [self.collectionView reloadData];
}
-(void)undoLastAction{
    [[DAO sharedDao]undoLastActionProductWithcurrentCompny:self.currentCompany];
    [self.collectionView reloadData];
}

-(void)saveChanges{
    [[DAO sharedDao]saveChanges];
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
-(void)pushToProductViewEditor{
    EditproductViewController *productEdit = [[EditproductViewController alloc]init];
    productEdit.productsArray = self.currentCompany.products;
    productEdit.currentCompanyIdentificaion = self.currentCompany.id;
    
    [self.navigationController pushViewController:productEdit animated:YES];
    
    
    [productEdit release];


}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return [self.currentCompany.products count];
;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  ProductCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
  cell.productName.text = [[self.currentCompany.products objectAtIndex:[indexPath row] ]name];
    cell.productImage.image =[UIImage imageNamed:[[self.currentCompany.products objectAtIndex:[indexPath row]]logo]];
    
    if (self.editing == true) {
        cell.deleteButton.hidden = false;
    }else{
        cell.deleteButton.hidden = true;
    }
    
    
    [cell.deleteButton addTarget:self action:@selector(deleteProductData:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

-(void)deleteProductData: (id)sender{
    
    
    UIButton *senderButton = (UIButton *)sender;
    
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:(ProductCellCollectionViewCell *)[[senderButton superview]superview]];
    NSLog(@"The collection is %d", indexPath.row);
    
    NSString *prodName = [self.currentCompany.products[indexPath.row]name];
    
    [[DAO sharedDao] deleteProductData:prodName];
    
    [self.currentCompany.products removeObjectAtIndex:indexPath.row];

    [self.collectionView reloadData];
    //    int deleteIndex = [[self.dao.companyList.objectAtIndex:indexPath.row]] ;

}


@end
