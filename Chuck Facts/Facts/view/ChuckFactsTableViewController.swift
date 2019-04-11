//
//  ChuckFactsTableViewController.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 04/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit


class ChuckFactsTableViewController: UITableViewController, ChuckFactsDelegate {

    var factsViewModel: ChuckFactsViewModel = ChuckFactsViewModel(facts: nil)

    let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = StringFile.emptyList.rawValue.localized()
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "TrebuchetMS", size: 15)
        label.sizeToFit()
        return label
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        bindViewModel()
    }


    func setup() {
        tableView.register(FactsTableViewCell.self, forCellReuseIdentifier: "factsCell")
        self.tableView.backgroundView = emptyLabel
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return factsViewModel.facts.value.count
    }


    func bindViewModel() {
        factsViewModel.facts.bind(to: self) { _, _ in
            self.updateTable()
        }
    }

    
    func updateTable() {
        tableView.reloadData()
        if factsViewModel.facts.value.isEmpty {
            emptyLabel.isHidden = false
        } else {
            emptyLabel.isHidden = true
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell =  Bundle.main.loadNibNamed("FactsTableViewCell", owner: self, options: nil)?.first as? FactsTableViewCell {
            cell.factLabel.text = factsViewModel.facts.value[indexPath.row].title
            if factsViewModel.facts.value[indexPath.row].title.count > 80 {
                cell.factLabel.font = UIFont.boldSystemFont(ofSize: 14)
            }
            cell.categoryLabel.text = factsViewModel.facts.value[indexPath.row].category
            cell.postion = indexPath.row
            cell.factDelegate = self

            return cell
        }

        return UITableViewCell()
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchVC = segue.destination as? SearchViewController {
            searchVC.chuckFactListDelegate = self
        }
    }


    func clickShareFact(_ at: Int) {
        let item = factsViewModel.facts.value[at]
        let activityViewController = UIActivityViewController(activityItems: [item.link], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
}
