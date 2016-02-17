//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "detailViewController.h"
#import "ProductViewController.h"




@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
     
    
//    if ([self.currentCompanyString isEqualToString:@"Apple mobile devices"]) {
//        self.products = @[@"iPad", @"iPod Touch",@"iPhone"];
//        self.logoProductList =[NSArray arrayWithObjects:
//        [UIImage imageNamed:@"ipad.jpg"],
//        [UIImage imageNamed:@"ipod.jpg"],
//        [UIImage imageNamed:@"iphone.jpg"],
//        nil];
//
//    } else if ([self.currentCompanyString isEqualToString:@"Samsung mobile devices"]){
//        self.products = @[@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab"];
//        
//        self.logoProductList =[NSArray arrayWithObjects:
//        [UIImage imageNamed:@"galaxys4.jpg"],
//        [UIImage imageNamed:@"galaxynote.png"],
//        [UIImage imageNamed:@"galaxytab.png"],
//        nil];
//    }else if ([self.currentCompanyString isEqualToString:@"Google mobile devices"]){
//        self.products = @[@"Nexus 6P", @"Nexus S", @"Nexus 4"];
//        self.logoProductList =[NSArray arrayWithObjects:
//        [UIImage imageNamed:@"nexus6p.jpg"],
//        [UIImage imageNamed:@"nuxus5.jpg"],
//        [UIImage imageNamed:@"nexus4.png"],
//        nil];
//    
//    }else if ([self.currentCompanyString isEqualToString:@"Windows mobile devices"]){
//        self.products = @[@"Windows Luma", @"Windows Destroyer", @"Windows Milky Way"];
//        self.logoProductList =[NSArray arrayWithObjects:
//        [UIImage imageNamed:@"windowsluma.jpg"],
//        [UIImage imageNamed:@"destroyer.gif"],
//        [UIImage imageNamed:@"milkyway.jpg"],
//        nil];
//    
//    }
  [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.currentCompany.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [[self.currentCompany.products objectAtIndex:[indexPath row] ]name];
    cell.imageView.image = [UIImage imageNamed:[[self.currentCompany.products objectAtIndex:[indexPath row]]logo]];

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//     Create the next view controller.
    
   detailViewController *webviewController = [[detailViewController alloc] init];

    
    
    
//    if ([self.title  isEqual: @"Apple mobile devices"]) {
//
//        if (indexPath.row ==0) {
//            [webviewController uploadWebPage:@"http://www.apple.com/ipad/"];
//        
//        }
//        if (indexPath.row ==1) {
//            [webviewController uploadWebPage:@"http://www.apple.com/ipod/"];
//        }
//        if (indexPath.row==2) {
//          [webviewController uploadWebPage:@"http://www.apple.com/iphone/"];
//        }
//        
//    }else if ([self.title isEqual:@"Samsung mobile devices"]){
//        if (indexPath.row==0) {
//            [webviewController uploadWebPage:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
//        }
//        if (indexPath.row==1) {
//            [webviewController uploadWebPage:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
//        }
//        if (indexPath.row==2) {
//            [webviewController uploadWebPage:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html"];
//        }
//        
//    }
//    
//    else if ([self.title isEqual:@"Google mobile devices"]){
//        if (indexPath.row==0) {
//            [webviewController uploadWebPage:@"https://store.google.com/product/nexus_6p"];
//        }
//        if (indexPath.row ==1) {
//            [webviewController uploadWebPage:@"https://www.google.com/nexus/5x/"];
//        }
//        if (indexPath.row ==2) {
//            [webviewController uploadWebPage:@"https://store.google.com/product/nexus_4?sku=nexus_4_16gb"];
//        }
//    
//    }else{
//        
//        if (indexPath.row ==0) {
//            [webviewController uploadWebPage:@"https://www.microsoft.com/en/mobile/phones/lumia/?order_by=Latest"];
//        }
//        if (indexPath.row ==1) {
//            [webviewController uploadWebPage:@"https://en.wikipedia.org/wiki/Destroyer"];
//        }
//        if (indexPath.row==2) {
//            [webviewController uploadWebPage:@"http://www.universetoday.com/22285/facts-about-the-milky-way/"];
//        }
//    
//    }
//    
webviewController.currentProduct = self.currentCompany.products[indexPath.row];
    
       //     Push the view controller.
    [self.navigationController pushViewController:webviewController animated:YES];
    
}
 


@end
