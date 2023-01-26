//
//  CustomTableViewCell.swift
// StudentManageriOS
//
//  Created by Ankush Ganesh on 17/01/23.
//

import UIKit

protocol CustomTableViewCellDelegate: NSObject {
    func postValue(_ fieldName: String, _ value: String)
}

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomTableViewCell"
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
//    var cellName: String = "name"
    
    weak var delegate: CustomTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.delegate = self
    }
}

extension CustomTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate.postValue(label.text!,textField.text!)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if label.text == "Name"{
            if range.location > 19 {
                return false
            }
        } else if label.text == "Phone Number"{
            if range.location > 9 {
                return false
            }
        }
        return true
    }
}
