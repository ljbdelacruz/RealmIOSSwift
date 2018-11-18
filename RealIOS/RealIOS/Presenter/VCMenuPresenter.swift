//
//  VCMenuPresenter.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 18/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import RealmSwift

protocol VCMenuDelegate{
    func SuccessProcess(message:String)
    func FailedProcess(message:String)
}

class VCMenuPresenter:NSObject{
    var foods:Results<Food>?;
    let realm = try! Realm();
    var selectedFood:Food?;
    var delegate:VCMenuDelegate?;
    override init() {
        super.init();
        self.foods=Food.all(in:self.realm);
    }
}
//MARK: -CRUD Food Realm
extension VCMenuPresenter{
    func LoadData(searchText:String){
        if searchText.count > 0{
            self.foods=Food.likeName(in: self.realm,searchText: searchText);
        }else{
            self.foods=Food.all(in: self.realm);
        }
    }
    func SaveNew(food:Food){
        if Food.save(in:self.realm, food: food){
            self.delegate?.SuccessProcess(message:"New food added");
        }else{
            self.delegate?.FailedProcess(message:"Cannot save food")
        }
    }
    func RemoveData(index:Int){
        if Food.remove(in: self.realm, food: self.foods![index]) {
            self.delegate?.SuccessProcess(message:"Food Removed!");
        }else{
            self.delegate?.FailedProcess(message:"Cannot remove food please try again")
        }
    }
    
}
//MARK: -UIAlert Func
extension VCMenuPresenter{
    func CreateUIAlertMessage(message:String)->UIAlertController{
        let uialert=UIAlertController(title: message, message: "", preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
        })
        uialert.addAction(okAction);
        return uialert
    }
}

