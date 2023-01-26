//
//  StudentListingViewController.swift
//  Created by Ankush Ganesh on 16/01/23.
//

import UIKit


class StudentListingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var studentArray =  [Student]()
    var studentId: Int = 0
    var operationType: String = "Add"
    
    var selectedIndex = -1
    var isCollapsed  = false
    var cellHeight = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: StudentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StudentTableViewCell.identifier)
        studentArray.append(Student(name: "Ankush",phoneNo: "6301598117", gpa: "7.4", gender: "Male", dob: Date(), age: "0", notes: "very shy kid"))
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        operationType = "Add"
        let addVC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        addVC.delegate = self
        self.navigationController?.pushViewController(addVC, animated: true)
    }
}

extension StudentListingViewController: AddViewControllerDelegate {
    func postStudentData(_ student: Student) {
        self.dismiss(animated: true) {
            if self.operationType == "Add"{
                self.studentArray.append(student)
            } else if self.operationType == "Edit"{
                self.studentArray[self.studentId] = student
            }
            self.tableView.reloadData()
        }
    }
}


extension StudentListingViewController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let heightRequired = studentArray[indexPath.row].notes.height(withConstrainedWidth: CGFloat(385), font: UIFont.systemFont(ofSize: 20))
        
        if selectedIndex == indexPath.row && isCollapsed {
            if heightRequired < 120 {
                return 200
            }
            return heightRequired + 50
            
        }
        return CGFloat(100)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedIndex == indexPath.row {
            if !isCollapsed {
                isCollapsed = true
            } else {
                isCollapsed = false
            }
        } else {
            isCollapsed = true
        }
        selectedIndex = indexPath.row
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension StudentListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.identifier, for: indexPath) as? StudentTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        cell.notesLabel.text = studentArray[indexPath.row].notes
        cell.studentNameLabel.text = "\(studentArray[indexPath.row].name)(\(studentArray[indexPath.row].gender.prefix(1)))"
        studentId = indexPath.row
        return cell
                
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return studentArray.count
    }
    
    
}

extension StudentListingViewController: StudentTableViewCellDelegate {
    func moreInfoButton(_ isPressed: Bool,_ index: Int) {
        operationType = "Edit"
        let addVC = storyboard?.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        addVC.stud = studentArray[index]
        addVC.delegate = self
        studentId = index
        self.navigationController?.pushViewController(addVC, animated: true)
    }
   
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
}
