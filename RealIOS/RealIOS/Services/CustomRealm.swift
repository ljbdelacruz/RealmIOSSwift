//
//  CustomRealm.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 26/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import RealmSwift


class CustomRealm {
    
    //MARK: -Ingredients functionality
    
    
    //MARK: -Food Functionality
    static func all(in realm: Realm = try! Realm()) -> Results<Food> {
        return realm.objects(Food.self)
    }
    static func likeName(in realm: Realm = try! Realm(), searchText:String)-> Results<Food>{
        let predicate=NSPredicate(format: "name CONTAINS[cd] %@", searchText)
        return realm.objects(Food.self).filter(predicate);
    }
}
