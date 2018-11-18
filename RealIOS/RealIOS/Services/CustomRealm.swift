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
    static func save(in realm: Realm = try! Realm(), item:Object)->Bool {
        do{
            try realm.write{
                realm.add(item)
            }
            return true;
        }catch{
            print("\(error.localizedDescription)");
            return false;
        }
    }
    static func remove(in realm: Realm = try! Realm(), item:Object)->Bool {
        do{
            try realm.write{
                realm.delete(item)
            }
            return true;
        }catch{
            print("\(error.localizedDescription)");
            return false;
        }
    }
}
