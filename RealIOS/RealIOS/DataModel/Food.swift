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
    //forward relationship
    var ingredients=List<Ingredients>();    
    convenience init(name:String){
        self.init();
        self.name=name;
    }
    func set(name:String){
        self.name=name;
    }
    
}

