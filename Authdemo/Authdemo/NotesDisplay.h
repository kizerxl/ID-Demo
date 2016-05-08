//
//  NotesDisplay.h
//  Autodemo
//
//  Created by Felix Changoo on 5/8/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteTableViewCell.h"
#import "NotesDataStore.h"

@interface NotesDisplay : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NotesDataStore *store;
@property (strong, nonatomic)NSDateFormatter *dateFormater;

@end
