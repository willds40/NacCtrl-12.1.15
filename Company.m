//
//  Company.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company
-(instancetype)initWithName:(NSString *)name andLogo: (NSString *)logo{
self = [super init];
    
    self.name = name;
    self.logo = logo;
    
    return self;


}


@end
