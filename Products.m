//
//  Products.m
//  NavCtrl
//
//  Created by Will Devon-sand on 2/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Products.h"

@implementation Products


-(instancetype)initWithName: (NSString *)name andlogo: (NSString *)logo andurl: (NSString *)url{


self = [super init];
    
    
    self.name = name;
    self.logo = logo;
    self.url = url;
    
    
    return self;

}

-(void)dealloc{
    [_name release];
    [_logo release];
    [_url release];
    [super dealloc];
}


@end
