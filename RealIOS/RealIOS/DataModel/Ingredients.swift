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
}
