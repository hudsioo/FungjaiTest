//
//  Media.swift
//  FungjaiTest
//
//  Created by hudsioo on 3/17/2560 BE.
//  Copyright © 2560 qoofhouse. All rights reserved.
//

import UIKit

class Media: NSObject {
    
    enum mediaType : String{
        case track
        case video
        case ads
    }
    
    let mID      : String
    let name     : String
    let coverURL : String
    let type     : mediaType
    
    
    
    init(mID : String, name : String, coverURL : String, type : String) {
        self.mID        = mID
        self.name       = name
        self.coverURL   = coverURL
        self.type       = mediaType(rawValue: type)!
    }
}
