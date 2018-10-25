//
//  FoodMenuViewController.swift
//  RealIOS
//
//  Created by Lainel John Dela Cruz on 24/10/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit
import RealmSwift
import UITableViewCellAnimation

class FoodMenuViewController: UIViewController {
    //
    var foods:Results<Food>?;
    let realm = try! Realm();
    var selectedFood:Food?;
    
    @IBOutlet weak var UIFoodTV: UITableView!
    @IBOutlet weak var UIFoodSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.LoadData();
        // Do any additional setup after loading the view.
        self.UIFoodTV.delegate=self;
        self.UIFoodTV.dataSource=self;
        self.UIFoodTV.register(UINib(nibName: "Custom1TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTVCell1");
        //searchbar
        self.UIFoodSearchBar.delegate=self;
        self.configureTableView()
        self.UIFoodTV.separatorStyle = .none
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func AddFoodOnClick(_ sender: Any) {
        var foodTF:UITextField?;
        let uialert=UIAlertController(title: "Add Food in Menu", message: "", preferredStyle: .alert)
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Food";
            foodTF=tf;
        })
        let addAction=UIAlertAction(title: "Add", style: .default, handler: {
            (action) in
            //action invoked when user added new item button
            let food=Food(name: foodTF!.text!);
            self.SaveData(food: food);
        })
        let cancelAction=UIAlertAction(title: "Cancel", style: .default, handler: {
            (action) in
        })
        uialert.addAction(addAction);
        uialert.addAction(cancelAction);
        present(uialert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "foodToIngredients"{
            let destVC=segue.destination as! IngredientsViewController;
            destVC.food=self.selectedFood;
        }
    }
    
}


//MARK: -UISearchBar Functionalities
extension FoodMenuViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
//MARK: -UITableView Functionalities
extension FoodMenuViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //?? - nil coalesceng operator if foods is nil it returns one else it return its value
        return self.foods?.count ?? 1;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)
//        cell.textLabel?.text = self.foods?[indexPath.row].name ?? "No Food Added";
        let cell=self.UIFoodTV.dequeueReusableCell(withIdentifier: "CustomTVCell1", for: indexPath) as! Custom1TableViewCell;
        cell.UILabel.text = self.foods?[indexPath.row].name ?? "No Food Added";
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedFood=self.foods?[indexPath.row] ?? nil;
        if selectedFood != nil {
            performSegue(withIdentifier: "foodToIngredients", sender: nil)
        }
    }
    func configureTableView(){
        self.UIFoodTV.rowHeight=UITableViewAutomaticDimension;
        self.UIFoodTV.estimatedRowHeight=120.0;
    }
    
    
}

//MARK: -Realm Functionalities
extension FoodMenuViewController{
    func SaveData(food:Food){
        do{
            try realm.write{
                realm.add(food)
            }
        }catch{
            print("\(error.localizedDescription)");
        }
        self.UIFoodTV.reloadData();
    }
    func LoadData(){
        self.foods=realm.objects(Food.self)
    }
}

