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
    
    private static let nibName = "FactsTableViewCell"

    var factVM: FactViewModel?
    var factDelegate: FactItemPressedDelegate?
    var sharedItemClicked: ((FactViewModel) -> Void)?


    func populateCell(_ factMV: FactViewModel) {
        self.factVM = factMV
        self.factLabel.text = factMV.title
        if factMV.title.count > 80 {
            self.factLabel.font = UIFont.boldSystemFont(ofSize: 14)
        }
        self.categoryLabel.text = factMV.category

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.gray.cgColor
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


    
    @IBAction func shareItem(_ sender: Any) {
        if let fact = factVM {
            sharedItemClicked?(fact)
        }
    }
    
    static func getTableViewCell() -> FactsTableViewCell? {
        return Bundle.main.loadNibNamed(nibName, owner: self, options: nil)?.first as? FactsTableViewCell 
    }
}
