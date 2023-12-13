//
//  HeaderCell.swift
//  UIKitArcade
//
//  Created by admin on 13/12/2023.
//

import Foundation
import UIKit

class HeaderCell : UIView {
    
    static let reusableId = "header_cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 80)
    }
}




extension HeaderCell {
    
    func style(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout(){
        //1. Create the alert controller.
        let alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Some default text"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert.textFields![0] // Force unwrapping because we know it exists.
            print("Text field: \(textField.text)")
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
}
