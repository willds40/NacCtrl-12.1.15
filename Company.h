//
//  Company.h
//  NavCtrl
//
//  Created by Will Devon-sand on 2/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Products.h"

@interface Company : NSObject
@property (strong, nonatomic)NSMutableArray *products;
@property (strong, nonatomic)NSString * name;
@property (strong, nonatomic)NSString * logo;
@property (strong, nonatomic)NSString * stockCodes;
@property (nonatomic, strong)NSString *stockPrice; 

-(instancetype)initWithName:(NSString *)name andLogo: (NSString *)logo andStockCodes: (NSString *)stockCodes;



@end
