////
////  ProductViewController.m
////  NavCtrl
////
////  Created by Aditya Narayan on 10/22/13.
////  Copyright (c) 2013 Aditya Narayan. All rights reserved.
////
//
//#import "detailViewController.h"
//#import "ProductViewController.h"
//#import "EditproductViewController.h"
//
//@interface ProductViewController ()
//
//@end
//
//@implementation ProductViewController
//
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
//                                          initWithTarget:self action:@selector(handleLongPress:)];
//    lpgr.minimumPressDuration = 2.0; //seconds
//    [self.tableView addGestureRecognizer:lpgr];
//    [lpgr release];
//
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button addTarget:self
//               action:@selector(pushToProductViewEditor)
//     forControlEvents:UIControlEventTouchUpInside];
//    [button setTitle:@"AddProduct" forState:UIControlStateNormal];
//    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
//    button.backgroundColor = [UIColor blueColor];
//    [self.view addSubview:button];
//    
//    UIBarButtonItem *saveChanges = [[UIBarButtonItem alloc]
//                                    initWithTitle:@"Save Changes"
//                                    style:UIBarButtonItemStyleBordered
//                                    target:self
//                                    action:@selector(saveChanges)];
//    UIBarButtonItem *undo = [[UIBarButtonItem alloc]
//                             initWithTitle:@"Undo"
//                             style:UIBarButtonItemStyleBordered
//                             target:self
//                             action:@selector(undoLastAction)];
//    UIBarButtonItem *redo = [[UIBarButtonItem alloc]
//                             initWithTitle:@"redo"
//                             style:UIBarButtonItemStyleBordered
//                             target:self
//                             action:@selector(redoLastUndo)];
//    
//    UIBarButtonItem *undoAllChanges = [[UIBarButtonItem alloc]
//                                       initWithTitle:@"Undo All Changes"
//                                       style:UIBarButtonItemStyleBordered
//                                       target:self
//                                       action:@selector(rollbackAllChanges)];
//    
//    
//    
//    
//    
//    
//    //Centers the bottom tool bar.
//    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [self setToolbarItems:[NSArray arrayWithObjects:undo,flexibleSpace, saveChanges, flexibleSpace , redo,flexibleSpace, undoAllChanges, nil]];
//    [flexibleSpace release];
//    
//    [self.navigationController setToolbarHidden:NO];
//
//    
//
//    // Uncomment the following line to preserve selection between presentations.
//     self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    self.navigationItem.rightBarButtonItem = self.editButtonItem;
//
//    
//     }
//
//-(void)rollbackAllChanges{
//    [[DAO sharedDao]rollbackAllChangesProducts:self.currentCompany];
//    [self.tableView reloadData];
//}
//
//-(void)redoLastUndo{
//    [[DAO sharedDao]redoLastUndoforProductWithCurrentCompany:self.currentCompany];
//   [self.tableView reloadData];
//}
//-(void)undoLastAction{
//    [[DAO sharedDao]undoLastActionProductWithcurrentCompny:self.currentCompany];
//  [self.tableView reloadData]; 
//}
//
//-(void)saveChanges{
//    [[DAO sharedDao]saveChanges];
//}
//
//
//-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
//{    //push to the companyeditview controller
//    
//    CGPoint p = [gestureRecognizer locationInView:self.tableView];
//    
//    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
//    if (indexPath == nil) {
//        NSLog(@"long press on table view but not on a row");
//    }
//    else if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
//               NSLog(@"long press on table view at row %ld", (long)indexPath.row);
//
//    
//    EditproductViewController *productEdit = [[[EditproductViewController alloc]init]autorelease];
//    Products *prod = self.currentCompany.products[indexPath.row];
//        productEdit.productPassedIn = prod;
//        
//
//    
//    productEdit.productNameString = prod.name;
//    productEdit.logoString = prod.logo;
//    productEdit.webLinkString = prod.url;
//    
//    
//    [self.navigationController pushViewController:productEdit animated:YES];
//    
////        [productEdit release];
//    }
//    
//}
//
//
//-(void)pushToProductViewEditor{
//    
//        EditproductViewController *productEdit = [[EditproductViewController alloc]init];
//    productEdit.productsArray = self.currentCompany.products;
//    productEdit.currentCompanyIdentificaion = self.currentCompany.id; 
//    
//    [self.navigationController pushViewController:productEdit animated:YES];
//   
//
//   [productEdit release];
//
//}
//
//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//       
//    
//     [self.tableView reloadData];
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [self.currentCompany.products count]; 
//}
////Added to not have empty rows.
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [[[UIView alloc] init] autorelease];
//    
//    return view;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]autorelease];
//    }
//    // Configure the cell...
//    cell.textLabel.text = [[self.currentCompany.products objectAtIndex:[indexPath row] ]name];
//    
//    cell.imageView.image = [UIImage imageNamed:[[self.currentCompany.products objectAtIndex:[indexPath row]]logo]];
//
//    return cell;
//    [cell release];
//}
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
//
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    NSString *prodName = [self.currentCompany.products[indexPath.row]name];
//    
//    [[DAO sharedDao] deleteProductData:prodName];
//    
//    [self.currentCompany.products removeObjectAtIndex:indexPath.row];
//        
//    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//
//    [self.tableView reloadData];
// 
//}
//
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
//
//#pragma mark - Table view delegate
//
//// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
////     Create the next view controller.
//    
//   detailViewController *webviewController = [[detailViewController alloc] init];
//
//
//                        webviewController.currentProduct = self.currentCompany.products[indexPath.row];
//    
//       //     Push the view controller.
//        [self.navigationController pushViewController:webviewController animated:YES];
//    [webviewController release];
//}
//@end
