//
//  PetUserView.m
//  Petpet
//
//  Created by GIGIGUN on 08/01/2017.
//  Copyright © 2017 GIGIGUN. All rights reserved.
//

#import "PetUserView.h"

@implementation PetUserView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    _petAvatarImageView.layer.masksToBounds = YES;
    _petAvatarImageView.layer.cornerRadius = _petAvatarImageView.frame.size.width/2;
    _userImageView.layer.masksToBounds = YES;
    _userImageView.layer.cornerRadius = _userImageView.frame.size.width/2;
}


@end
