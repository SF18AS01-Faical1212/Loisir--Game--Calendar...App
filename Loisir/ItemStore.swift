//
//  ItemStore.swift
//  DynamicTable
//
//  Created by Faical Sawadogo1212 on 03/01/19
//  Copyright © 2019 Faical Sawadogo1212. All rights reserved.
//

import Foundation

class ItemStore: NSObject, NSCoding {
    
    private var items = [Item]()
    
    func encode(with aCoder: NSCoder) {
        // Encode the array
        aCoder.encode(items, forKey: "items")
    }
    
    required init?(coder aDecoder: NSCoder) {
        items = (aDecoder.decodeObject(forKey: "items") as? [Item])!
    }
    
    override init() {
        super.init()
    }
    
    func addItem() {
        let item = Item(name: "", number: "")
        //items.append(item)
        items.insert(item, at: 0)
    }
    
    func getItem(index : Int) -> Item {
        return items[index]
    }
    
    func setItem(number index: Int, item: Item) {
        items[index] = item
    }
    
    func deleteItem(index: Int) {
        // Remove the specified array element
        items.remove(at: index)
    }
    
    // Move an item
    func moveItem(first: Int, second: Int) {
        // Get a reference to the item
        let item = items[first]
        
        // Remove from first, insert at second
        items.remove(at: first)
        items.insert(item, at: second)
    }
    
    func insertItem(index: Int) {
        // Create a generic Item
        let item = Item(name: "", number: "")
        
        // Put the new item at the specified index
        items.insert(item, at: index)
    }
    
    func itemCount() -> Int {
        return items.count
    }
}
class Game: NSObject {
    
    private var itemsGame = [ItemGame]()
    
    func addItem(scoreValue: Int) {
        let item = ItemGame(number: scoreValue)
        itemsGame.insert(item, at: 0)
        sortItem()
    }
    
    func getItem(index : Int) -> ItemGame {
        return itemsGame[index]
    }
    
    func sortItem() {
        itemsGame.sort(by: >)
    }
    
    func deleteItem(index: Int) {
        // Remove the specified array element
        itemsGame.remove(at: index)
    }
    
    func isEmpty() -> Bool {
        if itemsGame.isEmpty {
            return true
        }else{
            return false
        }
    }
    
    func length() -> Int{
        return  itemsGame.count
    }
    
    
    struct  ItemGame {
        var score = Int()
        let date   = NSDate()
        
        init( number: Int?) {
            self.score = number!
            
        }
        
        static func >(lhs: ItemGame, rhs: ItemGame) -> Bool {
            return lhs.score > rhs.score
        }
        
        func getScore() -> Int {
            return score
        }
    }
    
}



