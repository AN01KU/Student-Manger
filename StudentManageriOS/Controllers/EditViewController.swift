//
//  EditViewController.swift
//  notificationCenterDemo
//
//  Created by Ankush Ganesh on 18/01/23.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    enum StudentTableViewOrder: Int {
        case Name = 0
        case DOB
        case Age
        case Gender
        case PhoneNumber
        case OverallGPA
    }
    
    var tempStudent = Student()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: DateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DateTableViewCell.identifier)
        tableView.register(UINib(nibName: GenderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GenderTableViewCell.identifier)
        tableView.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        
        
    }
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
        //update student details
    }
}

extension EditViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


extension EditViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell()

        switch indexPath.row {
        case StudentTableViewOrder.Name.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)  as? CustomTableViewCell else {
                return defaultCell
            }
            cell.delegate = self
            cell.label.text = "Name"
            cell.textField.placeholder = "Enter your name"
            return cell

        case StudentTableViewOrder.DOB.rawValue:
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as? DateTableViewCell
            else {
                return defaultCell
            }
            dateCell.dateTextField.allowsEditingTextAttributes = false
            dateCell.delegate = self
            return dateCell
            
        
        case StudentTableViewOrder.Age.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)  as? CustomTableViewCell else {
                return defaultCell
            }
            
            return cell
            
        case StudentTableViewOrder.Gender.rawValue:
            guard let gendercell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.identifier, for: indexPath)  as? GenderTableViewCell else {
                return defaultCell
            }
            gendercell.delegate = self
            return gendercell
        
        case StudentTableViewOrder.PhoneNumber.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)  as? CustomTableViewCell else {
                return defaultCell
            }
            
            return cell
            
        case StudentTableViewOrder.OverallGPA.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)  as? CustomTableViewCell else {
                return defaultCell
            }
            
            return cell
            
        default:
            return defaultCell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
}

extension EditViewController: CustomTableViewCellDelegate {
    func getValue(_ fieldName: String, _ value: String) {
        if fieldName == "Name"{
            tempStudent.name = value
        } else if fieldName == "Phone Number"{
            tempStudent.phoneNo = value
        } else if fieldName == "Overall GPA" {
            tempStudent.gpa = value
        }
    }
    
    
}

extension EditViewController: DateTableViewCellDelegate {
    func getValue(_ dob: Date) {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dob, to: now)
        tempStudent.age = String(ageComponents.year!)
        tempStudent.dob = dob
    }
    
    
}

extension EditViewController: GenderTableViewCellDelegate {
    func getVale(_ gender: String) {
        tempStudent.gender = gender
    }
}
