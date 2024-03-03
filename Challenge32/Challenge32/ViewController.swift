//
//  ViewController.swift
//  Challenge23
//
//  Created by Mac on 29/02/2024.
//
import Foundation
import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var shoppingList : [ShoppingItem] = []
    
    let storage = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        style()
        layout()
        load()
        // Do any additional setup after loading the view.
    }
    
}

extension ViewController {
    
    func setup() {
        view.backgroundColor = .white
        title = "Shopping List"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(ShoppingItemTableViewCell.self, forCellReuseIdentifier: ShoppingItemTableViewCell.reusableId)
    }
    
    func style() {
        
    }
    
    func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: tableView.bottomAnchor, multiplier: 1)
        ])
    }
    
    func appendNewShoppingItem(_ shoppingItem: ShoppingItem) {
        shoppingList.insert(shoppingItem, at: 0)
        tableView.insertRows(at: [.init(row: 0, section: 0)], with: .automatic)
    }
    
    func store() {
        let encoder = JSONEncoder()
        if let jsonData = try? encoder.encode(shoppingList){
            storage.set(jsonData, forKey: ShoppingItem.shoppingListKey)
        }
        
    }
    
    func load() {
        let decoder = JSONDecoder()
        
        if let storedData = storage.data(forKey: ShoppingItem.shoppingListKey) , let storedShoppingList = try? decoder.decode([ShoppingItem].self, from: storedData){
            shoppingList = storedShoppingList
        }
    }
}


extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingItemTableViewCell.reusableId, for: indexPath) as? ShoppingItemTableViewCell else {
            return UITableViewCell()
        }
        let shoppingItem = shoppingList[indexPath.row]
        cell.configure(shoppingItem: shoppingItem)
        return cell
    }
    
    func presentError(_ title: String, _ message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(.init(title: "Okey", style: .default))
        present(alertController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}


//MARK: Actions
extension ViewController {
    
    @objc func addButtonTapped() {
        let alertController = UIAlertController(title: "Add New Shopping Item", message: "Please fill the below details ...", preferredStyle: .alert)
        
        alertController.addTextField { nameTextField in
            nameTextField.placeholder = "Enter item name"
            nameTextField.tag = 10
        }
        
        alertController.addTextField { quantityTextField in
            quantityTextField.placeholder = "Enter quantity"
            quantityTextField.keyboardType = .numberPad
            quantityTextField.tag = 20
        }
        
        alertController.addTextField { descriptionTextField in
            descriptionTextField.placeholder = "Enter description (optional)"
            descriptionTextField.tag = 30
        }
        alertController.addAction(UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self else {
                return
            }
            if let nameField =  alertController.textFields?.first(where: {
                $0.tag == 10
            }), let quantityField = alertController.textFields?.first(where: {$0.tag == 20 }) , let descriptionField = alertController.textFields?.first(where: {$0.tag == 30 }) {
                
                guard let name = nameField.text , let quantity = Int(quantityField.text ?? "" ) else {
                    presentError("Something went wrong ...","Please make sure to enter a name and a valid quantity")
                    return
                }
                
                let newShoppingItem = ShoppingItem(id: (shoppingList.count + 1 ) * 10, name: name, quantity: quantity, description: descriptionField.text)
                appendNewShoppingItem(newShoppingItem)
            }
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true)
    }
    
    @objc func saveButtonTapped() {
        store()
    }
}


