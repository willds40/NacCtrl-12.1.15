//
//  Company.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company
-(instancetype)initWithid:(NSString *)identification andName:(NSString *)name andLogo: (NSString *)logo andStockCodes: (NSString *)stockCodes {
self = [super init];
    self.identication = identification;
    self.name = name;
    self.logo = logo;
    self.stockCodes = stockCodes;
    
    return self;


}
-(void)dealloc{
    
    [_name release];
    [_logo release];
    [_stockCodes release];
    [super dealloc];
}




//-(instancetype)initWithName:(NSString *)name andLogoURL: (NSString *)logo andStockPrice: (NSString *)stockPrice{
//    self = [super init];
//    
//    self.name = name;
//    
//    self.logo = logo;
//    self.stockprice = stockPrice;
//    ;
//    return self;
//

//}

@end
