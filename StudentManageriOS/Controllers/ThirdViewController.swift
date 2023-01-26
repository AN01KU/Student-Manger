//
//  ThirdViewController.swift
//  notificationCenterDemo
//
//  Created by Ankush Ganesh on 17/01/23.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var studentArray =  [Student]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StudentTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: StudentTableViewCell.identifier)
    }
    
}
extension ThirdViewController: AddViewControllerDelegate {
    func studentDataPass(studentInfo: Student) {
        studentArray.append(studentInfo)
        print(studentArray)
    }
}

extension ThirdViewController: UITableViewDelegate{
    
}

extension ThirdViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StudentTableViewCell.identifier, for: indexPath)  as? StudentTableViewCell else {
            return UITableViewCell()
        }
//        cell.studentNameLabel.text =
        
        return cell
    }
    
    
}
