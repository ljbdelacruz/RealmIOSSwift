//
//  TestViewController.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 24/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func CheckboxOnClick(_ sender: Checkbox1) {
        sender.Toggle();
    }
    

}
