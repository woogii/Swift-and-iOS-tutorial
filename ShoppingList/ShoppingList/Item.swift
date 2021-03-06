//
//  Item.swift
//  ShoppingList
//
//  Created by Hyun on 2016. 3. 12..
//  Copyright © 2016년 wook2. All rights reserved.
//

import Foundation

// In order to use NSKeyedArchiver and NSKeyedUnarchiver to archive and unarchive instances 
// of the Item class, Item needs to adopt the NSCoding protocol
class Item : NSObject, NSCoding {
    
    // MARK: Properties
    var uuid:String = NSUUID().UUIDString
    var price:Float = 0.0
    var name:String = ""
    var isShoppingList = false
    
    // MARK : Keys for Decoding and Encoding
    struct Keys {
        static let UUID = "uuid"
        static let Price = "price"
        static let Name  = "name"
        static let IsList  = "isShoppingList"
    }
    
    // MARK: Initializers
    init(name:String, price:Float){
        super.init()
    
        self.name = name
        self.price = price
    }
    
    // MARK: NSCoding Protocol Methods
    
    required init?(coder aDecoder: NSCoder) {
        // init (coder:) is invoked whenever an encoded object needs to be converted back to
        // an instance of the respective class

        super.init()
        
        // decodeObjectForKey returns AnyObject?, so return value need to be cast to String
        if let archiveUuid = aDecoder.decodeObjectForKey(Keys.UUID) as? String {
            uuid = archiveUuid
        }
        
        if let archiveName = aDecoder.decodeObjectForKey(Keys.Name) as? String {
            name = archiveName
        }
        
        price = aDecoder.decodeFloatForKey(Keys.Price)
        isShoppingList = aDecoder.decodeBoolForKey(Keys.IsList)
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(uuid, forKey : Keys.UUID)
        aCoder.encodeObject(name, forKey: Keys.Name)
        aCoder.encodeFloat(price, forKey: Keys.Price)
        aCoder.encodeBool(isShoppingList, forKey: Keys.IsList)
    }
}