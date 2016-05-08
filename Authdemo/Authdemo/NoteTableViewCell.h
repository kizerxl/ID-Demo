//
//  NoteTableViewCell.h
//  Autodemo
//
//  Created by Felix Changoo on 4/25/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *lockImage;
@property (weak, nonatomic) IBOutlet UILabel *noteTitle;
@property (weak, nonatomic) IBOutlet UILabel *noteDate;


@end
