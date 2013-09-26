//
//  main.m
//  Fautauwstroom
//
//  Created by Matthias on 20/09/13.
//  Copyright (c) 2013 Matthias. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "fotoScan.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool
    {
        fotoScan *scanner = [[fotoScan alloc]init];
        [scanner fotoScannen];
        [scanner fotoLijst];
        return 0;
   }

}

