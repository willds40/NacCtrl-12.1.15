//
//  ProductCellCollectionViewCell.h
//  NavCtrl
//
//  Created by Will Devon-sand on 3/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCellCollectionViewCell : UICollectionViewCell
@property (retain, nonatomic) IBOutlet UIButton *deleteButton;
@property (retain, nonatomic) IBOutlet UILabel *productName;
@property (retain, nonatomic) IBOutlet UIImageView *productImage;




@end
