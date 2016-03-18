//
//  CompanyCell.m
//  NavCtrl
//
//  Created by Will Devon-sand on 3/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_CompanyName release];
    [_CompanyImage release];
    [_StockSymbol release];
    [_DeleteButton release];
    [super dealloc];
}
@end
