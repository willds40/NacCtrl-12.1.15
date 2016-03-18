//
//  ProductCellCollectionViewCell.m
//  NavCtrl
//
//  Created by Will Devon-sand on 3/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductCellCollectionViewCell.h"

@implementation ProductCellCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_deleteButton release];
    [_productName release];
    [_productImage release];
    [super dealloc];
}
@end
