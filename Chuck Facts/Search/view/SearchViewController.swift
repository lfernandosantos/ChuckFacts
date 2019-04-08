//
//  ViewController.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit
import Alamofire
import Bond


class SearchViewController: UIViewController {

    var suggestionsViewModel = SuggestionsViewModel()
    var searchViewModel = SearchViewModel()

    var facts = Observable<[Fact]>([])

    @IBOutlet weak var searchTextField: UITextField!

    func performSegueSearchList() {
        self.performSegue(withIdentifier: "goList", sender: searchViewModel.facts.value)
    }


    var lasSearchList: [String] {
        return DataManager.loadSearchs()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self

        searchViewModel.facts.bind(to: self) { _ , _ in
            if self.searchViewModel.facts.value.count > 0 {
                self.performSegueSearchList()
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
            if let cell = cell as? SuggestionsCollectionViewCell {
                cell.label.text = suggestionsViewModel.listSuggestions[indexPath.row]

            }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchViewModel.searchWith(suggestions: suggestionsViewModel.listSuggestions[indexPath.row])
    }
}


extension SearchViewController: UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = lasSearchList[indexPath.row]
        return cell
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchViewModel.searchFacts(query: lasSearchList[indexPath.row])
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lasSearchList.count > 4 {
            return 4
        }
        return lasSearchList.count
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var tableVC = segue.destination as? ChuckFactsDelegate {
            tableVC.list = sender as! [Fact]
        }
    }
}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchViewModel.searchFacts(query: textField.text!)
        return true
    }
}
