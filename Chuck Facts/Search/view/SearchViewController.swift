//
//  ViewController.swift
//  Chuck Facts
//
//  Created by Luiz Fernando dos Santos on 03/04/19.
//  Copyright © 2019 LFSantos. All rights reserved.
//

import UIKit
import Bond

class SearchViewController: UIViewController {

    var suggestionsViewModel = SuggestionsViewModel()
    var searchViewModel = SearchViewModel()

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var suggestionsCollection: UICollectionView!

    var lasSearchList: [String] {
        return DataManager.loadSearchs()
    }

    let alert: UIAlertController = {
        var uialert = UIAlertController(title: nil, message: StringFile.loading.rawValue.localized(), preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating()
        uialert.view.addSubview(loadingIndicator)
        return uialert
        }()


    override func viewDidLoad() {
        super.viewDidLoad()

        suggestionsCollection.delegate = self
        searchTextField.delegate = self

        bindViewModel()
        hideKeyboardWhenTappedAround()

    }


    func showLoading(){
        present(alert, animated: true, completion: nil)
    }

    func bindViewModel() {
        suggestionsViewModel.listSuggestions.bind(to: self) { _,_ in
            self.suggestionsCollection.reloadData()
        }

        searchViewModel.searching.bind(to: self) { _, searching in
            if searching {
                self.showLoading()
            } else {
                self.dismiss(animated: false, completion: nil)
            }
        }

        searchViewModel.facts.bind(to: self) { _ , _ in
            if self.searchViewModel.facts.value.count > 0 {
                self.showFactsList()
            }
        }

        searchViewModel.errorSearch.bind(to: self) { _ , errorMSG in
            if let msg = errorMSG, !msg.isEmpty{
                self.showAlert(msg: msg)
            }
        }
    }


    func showFactsList() {
        self.navigationController?.popViewController(animated: true)
    }


    func showAlert(msg: String?){
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func hideKeyboardWhenTappedAround(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SearchViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
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
        if let text = textField.text {
            searchViewModel.searchFacts(query: text)
        }
        return true
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
