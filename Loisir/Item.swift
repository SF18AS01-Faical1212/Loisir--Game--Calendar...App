//
//  File.swift
//  DynamicTable
//
//  Created by Faical Sawadogo1212 on 03/01/19.
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import Foundation

class Item: NSObject, NSCoding {
    var name = ""
    var number = ""
    var date   = NSDate()
    
    func encode(with aCoder: NSCoder) {
        // Encode the name
        aCoder.encode(name, forKey: "name")
        
        // Encode the number
        
        aCoder.encode(number, forKey: "number")
        
        // Encode the date
        aCoder.encode(date, forKey: "date")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        // Decode/restore the properties
        name   = (aDecoder.decodeObject(forKey: "name") as? String)!
        number = (aDecoder.decodeObject(forKey: "number") as? String)!
        date   = (aDecoder.decodeObject(forKey: "date") as? Date)! as NSDate
        
        // Debugging output to show the call happened
        print(">>>name:   \(name)")
        print(">>>number: \(number)")
        print(">>>date:   \(date)")
        
    }
    
    init(name: String, number: String) {
        self.name = name
        self.number = number
    }
}

