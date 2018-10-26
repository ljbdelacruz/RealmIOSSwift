//
//  Food.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 23/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import RealmSwift

class Food:Object{
    //dynamic allows this variable to be monitored at runtime
    @objc dynamic var name:String = "";
    var isSelected:Bool=false;
    //forward relationship
    var ingredients=List<Ingredients>();    
    convenience init(name:String){
        self.init();
        self.name=name;
    }
    func set(name:String){
        self.name=name;
    }
    //MARK: -Food Functionality
    static func all(in realm: Realm = try! Realm()) -> Results<Food> {
        return realm.objects(Food.self).sorted(byKeyPath: "name");
    }
    static func likeName(in realm: Realm = try! Realm(), searchText:String)-> Results<Food>{
        return realm.objects(Food.self).filter(NSPredicate(format: "name CONTAINS[cd] %@", searchText)).sorted(byKeyPath: "name");
    }
    static func save(in realm: Realm = try! Realm(), food:Food)->Bool {
        return CustomRealm.save(in:realm, item: food);
    }
    static func remove(in realm: Realm = try! Realm(), food:Food)->Bool {
        return CustomRealm.remove(in: realm, item:food)
    }

    
    
    
    
}

