//
//  SubjectTableViewCell.swift
//  Studyminus
//
//  Created by Keisuke Horiguchi on 2020/11/30.
//

import UIKit
import Kingfisher

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var subjectImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(subject: Subject) {
        titleLbl.text = subject.name
        detailLbl.text = subject.detail
        if let url = URL(string: subject.subjectImg) {
            subjectImg.kf.setImage(with: url)
        }
    }

}
