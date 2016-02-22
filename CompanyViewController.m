//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "CompanyEditViewController.h"

#import "DAO.h"

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
    
    self.dao = [DAO sharedDao];
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Add"
                                  style:UIBarButtonItemStyleBordered
                                  target:self
                                  action:@selector(addCompany)];
    self.navigationItem.leftBarButtonItem = addButton;
    [addButton release];
    
    
    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                          initWithTarget:self action:@selector(handleLongPress:)];
    lpgr.minimumPressDuration = 2.0; //seconds
    [self.tableView addGestureRecognizer:lpgr];
    [lpgr release];
    
    
    
    
    
}
-(void)runNSURLSession{
    
    NSMutableArray *stockPriceArray = [[NSMutableArray alloc]init];
    for (Company *company in self.dao.companyList) {
        [stockPriceArray addObject:company.stockCodes];
    }
    
    
    NSString *stockURL = [NSString stringWithFormat:@"https://finance.yahoo.com/d/quotes.csv?s=%@&f=l1",[stockPriceArray componentsJoinedByString:@"+" ]];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:stockURL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                NSString *stockQuoteStrings = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
                NSLog(@"%@", stockQuoteStrings);
                NSUInteger index = 0;
                for (NSString *stockPrice in [stockQuoteStrings componentsSeparatedByString:@"\n"]) {
                    
                    if (index == self.dao.companyList.count) break;
                    [[self.dao.companyList objectAtIndex:index]setStockPrice:stockPrice];
                    index++;
                }
                
                
//                alternative way of doing it. This calls a makes a nsmutable array and then calls a method in the DAO
                
                //                self.dao.arrayOfStockPrices = (NSMutableArray *)[stockQuoteStrings componentsSeparatedByString:@"\n"];//NSMutableArray was a string, but we typecasted it to make it a mutable array.
                //                [self.dao.arrayOfStockPrices removeLastObject];
                //                NSLog(@" %@", self.dao.arrayOfStockPrices);
                //                [self.dao UpdateStockPrice];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
                
                
                
            }] resume];
    
    
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData]; // to reload selected cell
    //create a gesture that passes to the editcompanyviewcontroller
    
    [self runNSURLSession];
    
}


-(void)handleLongPress:(UILongPressGestureRecognizer *)gestureRecognizer
{    //push to the companyeditview controller
    
    CGPoint p = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:p];
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
    }
    
}

-(void)addCompany{
    CompanyEditViewController *companyAdd = [[CompanyEditViewController alloc]init];
    [self.navigationController pushViewController:companyAdd animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dao.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.dao.companyList objectAtIndex:[indexPath row]] name];
    cell.imageView.image = [UIImage imageNamed:[[self.dao.companyList objectAtIndex:[indexPath row]]logo]];
    cell.detailTextLabel.text =[[self.dao.companyList objectAtIndex:[indexPath row]] stockPrice];
    
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
        [self.dao.companyList removeObjectAtIndex:indexPath.row];
        [self.dao.logoList removeObjectAtIndex:indexPath.row];
        [self.dao.currentCompany removeObjectAtIndex:indexPath.row];
        
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
    [self.dao.companyList removeObjectAtIndex:fromIndexPath.row];
    [self.dao.companyList insertObject:object atIndex:toIndexPath.row];
    
    id object1 = [[[self.logoList objectAtIndex:fromIndexPath.row] retain] autorelease];
    [self.dao.logoList removeObjectAtIndex:fromIndexPath.row];
    [self.dao.logoList insertObject:object1 atIndex:toIndexPath.row];
}
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [DAO sharedDao].indexPathRow = indexPath.row;
    
    
    self.productViewController.currentCompany = self.dao.companyList[indexPath.row];
    
    NSLog(@"%@", self.dao.companyList[indexPath.row]);
    
    Company *comp = self.dao.companyList[indexPath.row];
    NSLog(@"Selected Comp Name %@", comp.name);
    
    [self.navigationController
     pushViewController:self.productViewController
     animated:YES];
}

@end
