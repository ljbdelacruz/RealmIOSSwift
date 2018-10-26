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
import SwipeCellKit


class FoodMenuViewController: UIViewController {
    //
    var foods:Results<Food>?;
    let realm = try! Realm();
    var selectedFood:Food?;
    
    @IBOutlet weak var UIFoodTV: UITableView!
    @IBOutlet weak var UIFoodSearchBar: UISearchBar!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.foods=Food.all(in:self.realm);
        // Do any additional setup after loading the view.
        self.UIFoodTV.delegate=self;
        self.UIFoodTV.dataSource=self;
        //registering CustomTableViewCell
//        self.UIFoodTV.register(UINib(nibName: "Custom1TableViewCell", bundle: nil), forCellReuseIdentifier: "CustomTVCell1");
        //searchbar
        self.UIFoodSearchBar.delegate=self;
        self.configureTableView()
//        self.UIFoodTV.separatorStyle = .none
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
            self.CreateUIAlertMessage(message: food.name+" has been added!")
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
        self.LoadData(search: searchBar.text!);
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.count <= 0{
            self.LoadData(search: searchText);
            DispatchQueue.main.async {
                searchBar.resignFirstResponder();
            }
        }
    }
}
//MARK: -SwipeTableView
extension FoodMenuViewController:SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.RemoveData(food: self.foods![indexPath.row]);
            self.CreateUIAlertMessage(message: "Food Removed!")
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: "delete")
        return [deleteAction]
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
//        let cell=self.UIFoodTV.dequeueReusableCell(withIdentifier: "CustomTVCell1", for: indexPath) as! SwipeTableViewCell;
        let cell = UIFoodTV.dequeueReusableCell(withIdentifier: "FoodCell") as! SwipeTableViewCell
        cell.delegate=self;
        cell.textLabel?.text = self.foods?[indexPath.row].name ?? "No Food Added";
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
//        self.UIFoodTV.rowHeight=UITableViewAutomaticDimension;
        self.UIFoodTV.rowHeight=80.0;
    }
}
//MARK: -Realm Functionalities
extension FoodMenuViewController{
    func SaveData(food:Food){
        if Food.save(in:self.realm, food: food){
            self.UIFoodTV.reloadData();
        }
    }
    func RemoveData(food:Food){
        if Food.remove(in: self.realm, food: food) {
            self.UIFoodTV.reloadData()
        }
    }
    func LoadData(search:String){
        if search.count > 0 {
            self.foods=Food.likeName(in: self.realm,searchText: search);
        }else{
            self.foods=Food.all(in: self.realm);
        }
        self.UIFoodTV.reloadData();
    }
}
//MARK: -UIAlert functionality
extension FoodMenuViewController{
    func CreateUIAlertMessage(message:String){
        let uialert=UIAlertController(title: message, message: "", preferredStyle: .alert)
        let okAction=UIAlertAction(title: "OK", style: .default, handler: {
            (action) in
        })
        uialert.addAction(okAction);
        present(uialert, animated: true, completion: nil)
    }
}



