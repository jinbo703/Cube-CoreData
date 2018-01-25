//
//  NoteItems.swift
//  Cube
//
//  Created by John Nik on 3/31/17.
//  Copyright © 2017 johnik703. All rights reserved.
//

import UIKit
import CoreData

class NoteItems: NSObject {

    var title :       String  =   ""
    var intertitle:   String  =   ""
    var maintext:     String  =   ""
    
    
    required init(title: String, intertitle: String,  maintext: String) {
        
        self.title      = title
        self.intertitle = intertitle
        self.maintext   = maintext
        
        super.init()
        
    }
    
}
