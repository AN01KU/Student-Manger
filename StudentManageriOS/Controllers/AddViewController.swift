//
//  AddViewController.swift
//
//  Created by Ankush Ganesh on 16/01/23.
//

import UIKit

protocol AddViewControllerDelegate: AnyObject{
    func postStudentData(_ student: Student)
}

class AddViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    weak var delegate: AddViewControllerDelegate!
    
    var tempStudent = Student()
    var stud: Student?
    
    enum StudentTableViewOrder: Int {
        case Name = 0
        case DOB
        case Age
        case Gender
        case PhoneNumber
        case OverallGPA
        case Notes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        if stud != nil {
            tempStudent = stud!
        }
        //add rightBarButton
        let saveItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(save))
        self.navigationItem.rightBarButtonItem = saveItem
         
        //load tableView nibs
        tableView.register(UINib(nibName: DateTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DateTableViewCell.identifier)
        tableView.register(UINib(nibName: GenderTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GenderTableViewCell.identifier)
        tableView.register(UINib(nibName: CustomTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.register(UINib(nibName: NotesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NotesTableViewCell.identifier)
          
    }
    
    @objc func save() {
        if tempStudent.validator(for: tempStudent) {
            delegate?.postStudentData(tempStudent)
            navigationController?.popViewController(animated: true)
        } else {
            print(tempStudent)
            let alert =  UIAlertController(title: "Alert", message: "Invalid input/s", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .destructive))
            self.present(alert, animated: true)
        }
    }
 
    
    func setAge() {
        guard let cell = tableView.cellForRow(at: IndexPath(row: StudentTableViewOrder.Age.rawValue, section: 0)) as? CustomTableViewCell else {
            return
        }
        cell.textField.text = "\(tempStudent.age)"
    }
    
}

extension AddViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension AddViewController: UITableViewDataSource{
    
    func customCell(text: String, placeholder: String, indexPath: IndexPath, value: String? = nil, keyboardType: UIKeyboardType? = .default, isEnabled: Bool? = true) -> UITableViewCell{
        let defaultCell = UITableViewCell()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath)  as? CustomTableViewCell else {
            return defaultCell
        }
        cell.delegate = self
        cell.label.text = text
        cell.textField.text = value
        cell.textField.placeholder = placeholder
        cell.textField.keyboardType = keyboardType ?? .default
        cell.textField.isEnabled = isEnabled ?? true
        
        return cell
    }
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let defaultCell = UITableViewCell()

        switch indexPath.row {
        case StudentTableViewOrder.Name.rawValue:
            return customCell(text: "Name", placeholder: "Eg. Ankush", indexPath: indexPath, value: stud?.name)

        case StudentTableViewOrder.DOB.rawValue:
            guard let dateCell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.identifier, for: indexPath) as? DateTableViewCell
            else {
                return defaultCell
            }
            dateCell.dateTextField.allowsEditingTextAttributes = false
            dateCell.delegate = self
            if stud != nil {
                dateCell.dateTextField.text = formatDate(date: (stud?.dob)!)
            }
            return dateCell
        
        case StudentTableViewOrder.Age.rawValue:
            return customCell(text: "Age", placeholder: "Eg. 21", indexPath: indexPath, value: stud?.age)
            
        case StudentTableViewOrder.Gender.rawValue:
            guard let gendercell = tableView.dequeueReusableCell(withIdentifier: GenderTableViewCell.identifier, for: indexPath)  as? GenderTableViewCell else {
                return defaultCell
            }
            gendercell.delegate = self
            if stud == nil {
                return gendercell
            }
            gendercell.genderField.text = stud!.gender
            return gendercell
        
        case StudentTableViewOrder.PhoneNumber.rawValue:
           
            return customCell(text: "Phone Number", placeholder: "Eg. 6301598117", indexPath: indexPath, value: stud?.phoneNo, keyboardType: .phonePad)
            
        case StudentTableViewOrder.OverallGPA.rawValue:
            return customCell(text: "Overall GPA", placeholder: "Eg. 7.7", indexPath: indexPath, value: stud?.gpa, keyboardType: .decimalPad)
            
        case StudentTableViewOrder.Notes.rawValue:
            guard let notesCell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as? NotesTableViewCell else {
                return defaultCell
            }
            notesCell.delegate = self
            notesCell.textView.text = stud?.notes
            return notesCell
            
        default:
            return defaultCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
}

extension AddViewController: CustomTableViewCellDelegate {
    func postValue(_ fieldName: String, _ value: String) {
        if fieldName == "Name"{
            tempStudent.name = value
        } else if fieldName == "Phone Number"{
            tempStudent.phoneNo = value
        } else if fieldName == "Overall GPA" {
            tempStudent.gpa = value
        }
    }
}

extension AddViewController: DateTableViewCellDelegate {
    
    func postValue(_ dob : Date) {
        let now = Date()
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: dob, to: now)
        tempStudent.age = String(ageComponents.year!)
        tempStudent.dob = dob
        setAge()
    }
  
}

extension AddViewController: GenderTableViewCellDelegate {
    func postValue(_ gender: String) {
        tempStudent.gender = gender
    }
}

extension AddViewController: NotesTableViewCellDelegate {
    func postNotes(_ notes: String) {
        tempStudent.notes = notes
    }
}
