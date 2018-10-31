//
//  IngredientsViewController.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 24/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import RealmSwift

class IngredientsViewController: UIViewController {
    @IBOutlet weak var UIIngredientSB: UISearchBar!
    @IBOutlet weak var UIIngredientTV: UITableView!
    let realm=try! Realm();
    var food:Food?
    var ingredients:Results<Ingredients>?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.UIIngredientTV.delegate=self;
        self.UIIngredientTV.dataSource=self;
        self.LoadData();
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddIngredientsOnClick(_ sender: Any){
        var ingredientTF:UITextField?;
        var quantityTF:UITextField?;
        let uialert=UIAlertController(title: "Add Ingredients", message: "", preferredStyle: .alert)
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Ingredients";
            tf.keyboardType = .asciiCapable;
            ingredientTF=tf;
        })
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Quantity";
            tf.keyboardType = .numberPad;
            quantityTF=tf;
        })
        
        let addAction=UIAlertAction(title: "Add", style: .default, handler: {
            (action) in
            //action invoked when user added new item button
            let quantity=(quantityTF?.text as! NSString).floatValue
            var ingredient=Ingredients(name: (ingredientTF?.text!)!, q:quantity)
            self.Save(item: ingredient);
        })
        let cancelAction=UIAlertAction(title: "Cancel", style: .default, handler: {
            (action) in
        })
        uialert.addAction(addAction);
        uialert.addAction(cancelAction);
        present(uialert, animated: true, completion: nil)
        
    }
}

//MARK: -UITableView Functionalities
extension IngredientsViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if ingredients list is nil then return 1
        return self.ingredients?.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        cell.textLabel?.text = self.ingredients?[indexPath.row].name ?? "No Ingredients Listed!";
        return cell;
    }
}
extension IngredientsViewController{
    func LoadData(){
        self.ingredients=self.food?.ingredients.sorted(byKeyPath: "name", ascending: true);
        self.UIIngredientTV.reloadData();
    }
    func Save(item:Ingredients){
//        self.food?.ingredients.append(item);
        print("Dont know how to save data from relationshional");
//        self.food?.ingredients.append(item);
//        do{
//            try self.realm.write{
//                realm.add(item);
//            }
//        }catch{print("\(error.localizedDescription)")}
        self.LoadData();
    }
}



