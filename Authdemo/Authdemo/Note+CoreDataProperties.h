//
//  Note+CoreDataProperties.h
//  Autodemo
//
//  Created by Felix Changoo on 5/9/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Note.h"

NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *content;
@property (nullable, nonatomic, retain) NoteDisplay *notedisplay;

@end

NS_ASSUME_NONNULL_END
