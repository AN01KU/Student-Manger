//
//  GenderTableViewCell.swift
//  StudentManageriOS
//
//  Created by Ankush Ganesh on 17/01/23.
//

import UIKit

protocol GenderTableViewCellDelegate: NSObject {
    func postValue(_ gender: String)
}

class GenderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var genderField: UITextField!
    
    let genders = ["Male", "Female", "Others"]
    static let identifier = "GenderTableViewCell"
    let pickerView = UIPickerView()
    weak var delegate: GenderTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        genderField.placeholder = "Eg. Male/Female/Others"
        pickerView.delegate = self
        pickerView.dataSource = self
        genderField.inputView = pickerView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension GenderTableViewCell: UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderField.text = genders[row]
        delegate.postValue(genders[row])
        genderField.resignFirstResponder()
    }
    
    
}
extension GenderTableViewCell: UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }

    
}
