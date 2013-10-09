//
//  fotoScan.m
//  Fautauwstroom
//
//  Created by Matthias on 21/09/13.
//  Copyright (c) 2013 Matthias. All rights reserved.
//

#import "fotoScan.h"

@implementation fotoScan
{
    NSArray* sortedFiles;
    NSMutableArray *imagesList;
    int count;
}



+ (fotoScan *)sharedfotoScan;
{
    static fotoScan *sharedfotoScan;
    
    @synchronized(self)
    {
        if (!sharedfotoScan)
            sharedfotoScan = [[fotoScan alloc] init];
        
        return sharedfotoScan;
    }
}


-(NSArray*)fotoScannen
{
    NSLog(@"Begin scannen!");
    NSString *docsDir = [NSHomeDirectory() stringByAppendingPathComponent:  @"Library/Application Support/iLifeAssetManagement/assets/sub/"];
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    NSDirectoryEnumerator *dirEnum =[localFileManager enumeratorAtPath:docsDir];
    
    NSError* error = nil;
    NSString *file;
    count = 0;
    imagesList = [[NSMutableArray alloc] init];
    
    while ((file = [dirEnum nextObject]))
    {
        if ([[file pathExtension] isEqualToString: @"JPG"])
        {
            
            
            NSString *imgString = [docsDir stringByAppendingPathComponent:file];
            count++;
            NSDictionary* properties = [[NSFileManager defaultManager]attributesOfItemAtPath:imgString error:&error];
            NSDate* modDate = [properties objectForKey:NSFileModificationDate];
            if(error == nil)
            {
                [imagesList addObject:[NSDictionary dictionaryWithObjectsAndKeys:imgString, @"path",modDate, @"lastModDate",nil]];
            }
            
        }
        
    }
  //  NSLog(@"%@", imagesList);
    return imagesList;
    
}

-(NSArray*)fotoLijst
{
     sortedFiles = [imagesList sortedArrayUsingComparator:^(id path1, id path2)
                            {
                                // compare
                                NSComparisonResult comp = [[path1 objectForKey:@"lastModDate"] compare:[path2 objectForKey:@"lastModDate"]];
                                // invert ordering
                                if (comp == NSOrderedDescending)
                                {
                                    comp = NSOrderedAscending;
                                }
                                else if(comp == NSOrderedAscending)
                                {
                                    comp = NSOrderedDescending;
                                }
                                return comp;
                            }];
    
    NSMutableArray *finalList = [[NSMutableArray alloc]init];
    NSCharacterSet *chs = [NSCharacterSet characterSetWithCharactersInString:@"\""];
    
    for (int i = 0; i < [sortedFiles count]; i++)
    {
        NSString *kak = [[sortedFiles[i] valueForKey:@"path"] stringByTrimmingCharactersInSet:chs];
      //  NSLog(@"%@", kak);
        [finalList addObject:kak];
        
    }
    
   // NSLog(@"%@",[sortedFiles valueForKey:@"path"]);
    NSLog(@"%i", count);
    return finalList;
  //  return sortedFiles;
    
    
    
}

    


@end
