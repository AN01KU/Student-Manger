//
//  NotesTableViewCell.swift
//  notificationCenterDemo
//
//  Created by Ankush Ganesh on 23/01/23.
//

import UIKit

protocol NotesTableViewCellDelegate: NSObject {
    func postNotes(_ notes: String)
}

class NotesTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    static let identifier = "NotesTableViewCell"
    weak var delegate: NotesTableViewCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }
}

extension NotesTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        delegate.postNotes(textView.text)
    }
}
