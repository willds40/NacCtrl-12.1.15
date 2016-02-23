//
//  DAO.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@implementation DAO

+ (DAO *)sharedDao {
    
    NSLog(@"sharedDao called");
    
    static DAO *_sharedInstance = nil;

    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DAO alloc] init];
        
        [_sharedInstance uploadCompanies];
    });
    return _sharedInstance;
}




-(void)uploadCompanies{


Company *Apple =[[Company alloc]initWithName:@"Apple Mobile Devices" andLogo:@"apple.png"andStockCodes:@"AAPL"];
Company *Samsung = [[Company alloc]initWithName:@"Samsung Mobile Devices" andLogo:@"samsung.jpeg" andStockCodes:@"SSNLF"];

Company *Windows = [[Company alloc]initWithName:@"Windows Mobile Devices" andLogo:@"windows.png"andStockCodes:@"MSFT"];
Company *Google = [[Company alloc]initWithName:@"Google Mobile Devices" andLogo:@"google.jpg"andStockCodes:@"GOOG"];


  

Products *ipad = [[Products alloc]initWithName:@"iPad" andlogo:@"ipad.jpg" andurl:@"http://www.apple.com/ipad/"];
Products *ipod = [[Products alloc]initWithName:@"iPod Touch" andlogo:@"ipod.jpg" andurl:@"http://www.apple.com/ipod/"];
Products *iphone = [[Products alloc]initWithName:@"iPhone" andlogo:@"iphone.jpg" andurl:@"http://www.apple.com/iphone/"];

Products *galaaxyS4 = [[Products alloc]initWithName:@"Galaxy S4" andlogo:@"galaxys4.jpg" andurl:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-"];
Products *galaxyNote = [[Products alloc]initWithName:@"Galaxy Note" andlogo:@"galaxynote.png" andurl:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
Products *galaxyTab = [[Products alloc]initWithName:@"Galaxy Tab" andlogo:@"galaxytab.png" andurl:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html"];

Products *windowsLuma = [[Products alloc]initWithName:@"Windows Luma" andlogo:@"windowsluma.jpg" andurl:@"https://www.microsoft.com/en/mobile/phones/lumia/?order_by=Latest"];
Products *destroyer = [[Products alloc]initWithName:@"Windows Destroyer" andlogo:@"destroyer.gif" andurl:@"https://en.wikipedia.org/wiki/Destroyer"];

Products *milkyWay = [[Products alloc]initWithName:@"Windows Milky Way" andlogo:@"milkyway.jpg" andurl:@"http://www.universetoday.com/22285/facts-about-the-milky-way/"];


Products *nexus6p = [[Products alloc]initWithName:@"Nexus 6P" andlogo:@"nexus6p.jpg" andurl:@"https://store.google.com/product/nexus_6p"];
Products *nexus5 = [[Products alloc]initWithName:@"Nexus S" andlogo:@"nuxus5.jpg" andurl:@"https://www.google.com/nexus/5x/"];
Products *nexus4 = [[Products alloc]initWithName:@"Nexus 4" andlogo:@"nexus4.png" andurl:@"https://store.google.com/product/nexus_4?sku=nexus_4_16gb"];

Apple.products = [[NSMutableArray alloc]initWithObjects:ipad,ipod,iphone, nil];
Samsung.products =[[NSMutableArray alloc] initWithObjects:galaaxyS4,galaxyNote,galaxyTab, nil];
Windows.products =[[NSMutableArray alloc]initWithObjects:windowsLuma,destroyer, milkyWay, nil];
Google.products = [[NSMutableArray alloc]initWithObjects:nexus6p,nexus5, nexus4, nil];

self.companyList = [[NSMutableArray alloc]initWithObjects:Apple,Samsung,Windows,Google, nil];
   }

//-(void)UpdateStockPrice{
//    for (int i =0; i< [self.companyList count]; i++) {
//        [self.companyList[i]setStockPrice:self.arrayOfStockPrices[i]];
//        
//    }
//
//}

-(void)createNewCompany:(NSString*)companyName andlogo: (NSString*)logo andstockCodes: (NSString *)stockCodes{
    
   
    Company *newCompany = [[Company alloc]initWithName:companyName andLogo:logo andStockCodes:stockCodes];
    
    [self.companyList addObject:newCompany];
    
}
-(void)createNewProduct:(NSString*)prdouctName andlogo: (NSString*)logo andUrl: (NSString *)url{
    
    self.anotherProduct = [[Products alloc]initWithName:prdouctName andlogo:logo andurl:url];
}
-(void)editCompanyName: (NSString *)names andlogo: (NSString *)logo androw: (NSInteger) indexPathRow andStockSymbol: (NSString *)stockSymbol{

    self.indexPathRow = indexPathRow;
    
    [self.companyList[self.indexPathRow]setName:names];
    [self.companyList[self.indexPathRow]setLogo:logo];
    [self.companyList[self.indexPathRow]setStockCodes:stockSymbol];
}
-(void)editProductName:(NSString *)names andlogo: (NSString *)logo andUrl: (NSString*) url{

}

@end
