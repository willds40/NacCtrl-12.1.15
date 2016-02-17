//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

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
    

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    Company *Apple =[[Company alloc]initWithName:@"Apple Mobile Devices" andLogo:@"apple.png"];
//    Company *Samsung = [[Company alloc]initWithName:@"Samsung Mobile Devices" andLogo:@"samsung.jpeg"];
//    
//    Company *Windows = [[Company alloc]initWithName:@"Windows Mobile Devices" andLogo:@"windows.png"];
//    Company *Google = [[Company alloc]initWithName:@"Google Mobile Devices" andLogo:@"google.jpg"];
//    
//    
//    self.companyList = [[NSMutableArray alloc]initWithObjects:Apple,Samsung,Windows,Google, nil];
//    
//    Products *ipad = [[Products alloc]initWithName:@"iPad" andlogo:@"ipad.jpg" andurl:@"http://www.apple.com/ipad/"];
//    Products *ipod = [[Products alloc]initWithName:@"iPod Touch" andlogo:@"ipod.jpg" andurl:@"http://www.apple.com/ipod/"];
//    Products *iphone = [[Products alloc]initWithName:@"iPhone" andlogo:@"iphone.jpg" andurl:@"http://www.apple.com/iphone/"];
//    
//    Products *galaaxyS4 = [[Products alloc]initWithName:@"Galaxy S4" andlogo:@"galaxys4.jpg" andurl:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
//    Products *galaxyNote = [[Products alloc]initWithName:@"Galaxy Note" andlogo:@"galaxynote.png" andurl:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
//    Products *galaxyTab = [[Products alloc]initWithName:@"Galaxy Tab" andlogo:@"galaxytab.png" andurl:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html"];
//    
//    Products *windowsLuma = [[Products alloc]initWithName:@"Windows Luma" andlogo:@"windowsluma.jpg" andurl:@"https://www.microsoft.com/en/mobile/phones/lumia/?order_by=Latest"];
//    Products *destroyer = [[Products alloc]initWithName:@"Windows Destroyer" andlogo:@"destroyer.gif" andurl:@"https://en.wikipedia.org/wiki/Destroyer"];
//    
//    Products *milkyWay = [[Products alloc]initWithName:@"Windows Milky Way" andlogo:@"milkyway.jpg" andurl:@"http://www.universetoday.com/22285/facts-about-the-milky-way/"];
//
//    
//    Products *nexus6p = [[Products alloc]initWithName:@"Nexus 6P" andlogo:@"nexus6p.jpg" andurl:@"https://store.google.com/product/nexus_6p"];
//    Products *nexus5 = [[Products alloc]initWithName:@"Nexus S" andlogo:@"nuxus5.jpg" andurl:@"https://www.google.com/nexus/5x/"];
//    Products *nexus4 = [[Products alloc]initWithName:@"Nexus 4" andlogo:@"nexus4.png" andurl:@"https://store.google.com/product/nexus_4?sku=nexus_4_16gb"];
//    
//    Apple.products = [[NSMutableArray alloc]initWithObjects:ipad,ipod,iphone, nil];
//    Samsung.products =[[NSMutableArray alloc] initWithObjects:galaaxyS4,galaxyNote,galaxyTab, nil];
//    Windows.products =[[NSMutableArray alloc]initWithObjects:windowsLuma,destroyer, milkyWay, nil];
//    Google.products = [[NSMutableArray alloc]initWithObjects:nexus6p,nexus5, nexus4, nil];
//    
//    
    
//    self.companyList = [[NSMutableArray alloc]initWithObjects: @"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices",@"Windows mobile devices", nil];
//    
//    
//    self.currentCompany = [NSMutableArray arrayWithObjects:  @"Apple mobile devices",@"Samsung mobile devices", @"Google mobile devices",@"Windows mobile devices", nil];
//
//    self.title = @"Mobile device makers";
//    
//    self.logoList = [[NSMutableArray arrayWithObjects:
//    [UIImage imageNamed:@"apple.png"],
//    [UIImage imageNamed:@"samsung.jpeg"],
//    [UIImage imageNamed:@"google.jpg"],
//    [UIImage imageNamed:@"windows.png"],
//    nil] retain];
    
    
    
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
    return [self.dao.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[self.dao.companyList objectAtIndex:[indexPath row]] name];
    cell.imageView.image = [UIImage imageNamed:[[self.dao.companyList objectAtIndex:[indexPath row]]logo]];
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



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    self.companyList = self.currentCompany;
    
    
    self.productViewController.currentCompany = self.dao.companyList[indexPath.row];
    
    NSLog(@"%@", self.dao.companyList[indexPath.row]);
    
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}
 


@end
