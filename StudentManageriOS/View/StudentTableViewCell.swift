//
//  StudentTableViewCell.swift
//  StudentManageriOS
//
//  Created by Ankush Ganesh on 17/01/23.
//

import UIKit
protocol StudentTableViewCellDelegate: NSObject {
    func moreInfoButton(_ isPressed: Bool,_ index: Int)
}

class StudentTableViewCell: UITableViewCell {
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    weak var delegate: StudentTableViewCellDelegate!
    var index: Int = 0
    static let identifier = "StudentTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    @IBAction func moreInfoPressed(_ sender: UIButton) {
        delegate.moreInfoButton(true, index)
    }
    
}
