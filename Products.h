//
//  Products.h
//  NavCtrl
//
//  Created by Will Devon-sand on 2/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Products : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *logo;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic)NSString *companyIdentification;
@property (strong, nonatomic)NSString *identification; 


-(instancetype)initWithComanyIdentification: (NSString *)companyIdentification andName: (NSString *)name andlogo: (NSString *)logo andurl: (NSString *)url; 
@end
