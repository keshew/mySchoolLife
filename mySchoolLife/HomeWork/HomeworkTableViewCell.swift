//
//  HomeworkTableViewCell.swift
//  mySchoolLife
//
//  Created by Артём Коротков on 04.10.2022.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {

    @IBOutlet weak var homework: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
