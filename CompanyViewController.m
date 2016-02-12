//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

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
    
    
    self.companyList = [[NSMutableArray alloc]initWithObjects: @"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices",@"Windows mobile devices", nil];
    
    
    self.currentCompany = [NSMutableArray arrayWithObjects:  @"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices",@"Windows mobile devices", nil];

    self.title = @"Mobile device makers";
    
    self.logoList = [[NSMutableArray arrayWithObjects:
    [UIImage imageNamed:@"apple.png"],
    [UIImage imageNamed:@"samsung.jpeg"],
    [UIImage imageNamed:@"google.jpg"],
    [UIImage imageNamed:@"windows.png"],
    nil] retain];
    
    
    
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
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    cell.imageView.image = [self.logoList objectAtIndex:indexPath .row];

    
    
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//         Delete the row from the data source
        [self.companyList removeObjectAtIndex:indexPath.row];
        [self.logoList removeObjectAtIndex:indexPath.row];
        [self.currentCompany removeObjectAtIndex:indexPath.row];
        
        
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//         Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    [self.tableView reloadData];

}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath

{
    
    id object = [[[self.companyList objectAtIndex:fromIndexPath.row] retain] autorelease];
    [self.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.companyList insertObject:object atIndex:toIndexPath.row];
    
    id object1 = [[[self.logoList objectAtIndex:fromIndexPath.row] retain] autorelease];
    [self.logoList removeObjectAtIndex:fromIndexPath.row];
    [self.logoList insertObject:object1 atIndex:toIndexPath.row];
 
    
   
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  //  self.companyList = self.currentCompany;
    
    
    self.productViewController.currentCompanyString = self.companyList[indexPath.row];
    
    NSLog(@"%@", self.companyList[indexPath.row]);
    
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}
 


@end
