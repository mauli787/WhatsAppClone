//
//  ListTableCell.swift
//  ChatAppUI
//
//  Created by Dnyaneshwar on 14/01/21.
//

import UIKit

class ListTableCell: DSBaseCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!

    static let identifier = String(describing: ListTableCell.self)
    
    override func setupViews() {
        super.setupViews()
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2
    }
    
    func setupCell(user:UsersViewModel){
        
        self.userNameLabel.text = user.userName
        self.profileImageView.image = #imageLiteral(resourceName: "DS")
        self.messageLabel.text = user.userMessage
        self.dayLabel.text = user.userdayOnline
    }

}
