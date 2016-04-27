//
//  NoteDisplay+CoreDataProperties.h
//  Autodemo
//
//  Created by Felix Changoo on 4/27/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NoteDisplay.h"
#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoteDisplay (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *isLocked;
@property (nullable, nonatomic, retain) NSDate *dateCreated;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) Note *actualNote;

@end

NS_ASSUME_NONNULL_END
