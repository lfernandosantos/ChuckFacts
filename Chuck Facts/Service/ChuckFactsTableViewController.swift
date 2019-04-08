//
//  ChuckFactsTableViewController.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 04/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit

protocol ChuckFactsDelegate {
    var list:[Fact] { get set }
}
class ChuckFactsTableViewController: UITableViewController, ChuckFactsDelegate {


    var list: [Fact] = []

    override func viewDidLoad() {
        super.viewDidLoad()


    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = list[indexPath.row].value

        return cell
    }


}
