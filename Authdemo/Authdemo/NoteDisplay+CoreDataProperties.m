//
//  NoteDisplay+CoreDataProperties.m
//  Autodemo
//
//  Created by Felix Changoo on 5/9/16.
//  Copyright © 2016 secret sauce. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NoteDisplay+CoreDataProperties.h"

@implementation NoteDisplay (CoreDataProperties)

@dynamic dateCreated;
@dynamic isLocked;
@dynamic title;
@dynamic actualNote;

@end
