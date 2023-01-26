//
//  SecondVC.swift
//  StudentMacApp
//
//  Created by Ankush Ganesh on 23/01/23.
//

import Cocoa

class SecondVC: NSViewController {
    
    let names = ["Ankush", "Abhay"]

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension SecondVC: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return names.count
    }
    
    
    
}

extension SecondVC: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let customCell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "CustomNSTableCellView"), owner: self) as? CustomNSTableCellView else {
            return nil
        }
//        customCell.nameTextField.stringValue = names[row]
        return customCell
    }
}

