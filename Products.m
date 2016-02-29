//
//  Products.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Products.h"

@implementation Products


-(instancetype)initWithComanyIdentification: (NSString *)companyIdentification andName: (NSString *)name andlogo: (NSString *)logo andurl: (NSString *)url{


self = [super init];
    
    self.companyIdentification = companyIdentification;
    self.name = name;
    self.logo = logo;
    self.url = url;
    
    
    return self;

}


@end
