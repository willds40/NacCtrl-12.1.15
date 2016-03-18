//
//  CompanyCell.h
//  NavCtrl
//
//  Created by Will Devon-sand on 3/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel *CompanyName;
@property (retain, nonatomic) IBOutlet UIImageView *CompanyImage;
@property (retain, nonatomic) IBOutlet UILabel *StockSymbol;
@property (retain, nonatomic) IBOutlet UIButton *DeleteButton;





@end
