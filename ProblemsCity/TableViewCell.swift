//
//  TableViewCell.swift
//  ProblemsCity
//
//  Created by Lucas Dev on 28/08/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var labelTitleRegister: UILabel!
    @IBOutlet weak var labelDateRegister: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureWith(_ register: Register) {
        labelTitleRegister.text = register.title
        
        if let date = register.created_at {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/YY"
            labelDateRegister.text = dateFormatter.string(from: date)
        } else {
            labelDateRegister.text = "--"
        }
    }

}
