//
//  Ingredients.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 23/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import RealmSwift;

class Ingredients:Object{
    @objc dynamic var name:String="";
    @objc dynamic var quantity:Float=0;
    //set the inverse relationship to food and property of which they are linked ingredients
    var parentFood = LinkingObjects(fromType: Food.self, property: "ingredients")
    convenience init(name:String, q:Float){
        self.init()
        self.name=name;
        self.quantity=q;
    }
    func set(name:String, q:Float){
        self.name=name;
        self.quantity=q;
    }
    static func all(in realm: Realm = try! Realm()) -> Results<Ingredients> {
        return realm.objects(Ingredients.self).sorted(byKeyPath: "name");
    }
    static func likeName(in realm: Realm = try! Realm(), search:String) -> Results<Ingredients> {
        return realm.objects(Ingredients.self).filter(NSPredicate(format: "name CONTAINS[cd] %@", search)).sorted(byKeyPath: "name");
    }
    static func save(in realm: Realm = try! Realm(), ingredient:Ingredients)->Bool {
        return CustomRealm.save(in:realm, item:ingredient)
    }
    static func remove(in realm: Realm = try! Realm(), ingredient:Ingredients)->Bool {
        return CustomRealm.remove(in:realm, item:ingredient)
    }
    
    
    
    
    
    
}
