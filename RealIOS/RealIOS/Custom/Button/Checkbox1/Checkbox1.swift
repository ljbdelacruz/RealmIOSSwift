//
//  Checkbox1.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 24/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class Checkbox1: UIButton {
    var isChecked:Bool=false;
    override func awakeFromNib() {
        super.awakeFromNib()
        self.SetImage();
    }
    func Set(ic:Bool){
        self.isChecked=ic;
    }
    func Toggle(){
        self.isChecked = !self.isChecked;
        self.SetImage();
    }
    func SetImage(){
        self.setImage(UIImage(named: self.isChecked ? "c1.png" : "c1n.png")!, for: .normal);
    }
}
