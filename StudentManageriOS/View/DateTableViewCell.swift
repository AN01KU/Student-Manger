//
//  DateTableViewCell.swift
//  StudentManageriOS
//
//  Created by Ankush Ganesh on 17/01/23.
//

import UIKit

protocol DateTableViewCellDelegate: NSObject {
    func postValue(_ dob : Date)
}

class DateTableViewCell: UITableViewCell {

    static let identifier = "DateTableViewCell"
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    weak var delegate: DateTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        dateTextField.inputView = datePicker
        dateTextField.placeholder = "Eg. 16.05.2001"
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        dateTextField.text = formatDate(date: datePicker.date)
        delegate.postValue(datePicker.date)
    }
    
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }

    
}
