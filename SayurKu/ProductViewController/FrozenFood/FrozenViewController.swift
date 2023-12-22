//
//  FrozenViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 06/12/23.
//

import UIKit

class FrozenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    @IBOutlet var backButton: UIButton!
    @IBOutlet var shoppingChartButton: UIButton!
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var frozenFoodCollection: UICollectionView!
    
    private var cellIdentifier = "FrozenFoodCollectionViewCell"
    private var frozenFoodData = ["Sosis", "Nugget", "Kentang Beku", "Otak-otak"]
    private var frozenFoodImage: [String: String] = [
        "Sosis": "Sosis 1",
        "Nugget": "Nugget",
        "Kentang Beku": "Kentang Beku",
        "Otak-otak": "Otak Otak Udang"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frozenFoodCollection.dataSource = self
        frozenFoodCollection.delegate = self
        frozenFoodCollection.register(UINib(nibName: "FrozenFoodCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        
        searchBar.delegate = self
        searchBar.attributedPlaceholder = NSAttributedString(
            string: "Cari FrozenFood Disini",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
    }
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frozenFoodData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = frozenFoodCollection.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FrozenFoodCollectionViewCell
        cell.backgroundColor = .pink
        cell.layer.cornerRadius = 10.0
        
        let kategoryIndex = min(indexPath.item, frozenFoodData.count - 1)
        
        if let namaGambar = frozenFoodImage[frozenFoodData[kategoryIndex]] {
            cell.frozenFoodImage.image = UIImage(named: namaGambar)
        }
        
        cell.labelName.text = frozenFoodData[indexPath.item]
        
        return cell
    }
}

extension FrozenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        let searchKeywords = newText.lowercased().components(separatedBy: " ")
        
        if searchKeywords.isEmpty {
            updateFrozenFoodList(frozenFoodData)
            
        } else {
            
            let filteredProduct = frozenFoodData.filter { sayur in
                
                return searchKeywords.allSatisfy { keyword in
                    
                    return sayur.lowercased().contains(keyword)
                    
                }
            }
            
            updateFrozenFoodList(filteredProduct)
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        updateFrozenFoodList(frozenFoodData)
        return true
    }
    
    private func updateFrozenFoodList(_ newFrozenFoodList: [String]) {
        if newFrozenFoodList.isEmpty {
            
            frozenFoodData = ["Sosis", "Nugget", "Kentang Beku", "Otak-otak"]
            
        } else {
            
            frozenFoodData = newFrozenFoodList
        }
        frozenFoodCollection.reloadData()
    }
}
