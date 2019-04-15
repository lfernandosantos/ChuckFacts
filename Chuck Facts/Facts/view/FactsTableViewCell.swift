//
//  FactsTableViewCell.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 08/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

class FactsTableViewCell: UITableViewCell {

    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!

    var postion: Int?
    var factDelegate: FactItemPressedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.gray.cgColor
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    @IBAction func shareItem(_ sender: Any) {
        if let at = postion {
            factDelegate?.clickShareFact(at)
        }
    }
}
