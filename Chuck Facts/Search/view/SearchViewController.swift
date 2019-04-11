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
    var chuckFactListDelegate: ChuckFactsDelegate?

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var suggestionsCollection: UICollectionView!

    func showFactsList() {
        chuckFactListDelegate?.factsViewModel.facts.value = searchViewModel.facts.value
        self.navigationController?.popViewController(animated: true)
    }


    var lasSearchList: [String] {
        return DataManager.loadSearchs()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionsCollection.delegate = self
        searchTextField.delegate = self
        searchViewModel.facts.bind(to: self) { _ , _ in
            if self.searchViewModel.facts.value.count > 0 {
                self.showFactsList()
            }
        }

        suggestionsViewModel.listSuggestions.bind(to: self) { _,_ in
            self.suggestionsCollection.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath)
            if let cell = cell as? SuggestionsCollectionViewCell {
                cell.label.text = suggestionsViewModel.listSuggestions.value[indexPath.row]

            }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if suggestionsViewModel.listSuggestions.value.count > 8 {
            return 8
        }
        return suggestionsViewModel.listSuggestions.value.count
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchViewModel.searchWith(suggestions: suggestionsViewModel.listSuggestions.value[indexPath.row])
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

}


extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchViewModel.searchFacts(query: textField.text!)
        return true
    }
}
