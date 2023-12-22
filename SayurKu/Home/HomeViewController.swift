//
//  HomeViewController.swift
//  SayurKu
//
//  Created by Pungki Busneri on 05/12/23.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet var searchBar: UITextField!
    @IBOutlet var shoppingChartButton: UIButton!
    @IBOutlet var BannerInformationCollection: UICollectionView!
    @IBOutlet var bannerPageControl: UIPageControl!
    @IBOutlet var productCollection: UICollectionView!
    @IBOutlet var allCategoriesCollecttion: UICollectionView!
    
    let bannerImages = ["Banner 2", "Banner 1", "Banner 3", "Banner 4", "Banner 5", "Banner 6"]
    private var bannerIdentifier = "BannerCollectionViewCell"
    private var currentBannerIndex = 0
    private var bannerTimer: Timer?
    
    private var cellIdentifier = "SayurkuCollectionViewCell"
    private var kategoriData = ["Sayur", "Buah", "Daging", "Ikan", "Protein", "Seafood", "Frozen", "Bumbu"]
    
    private var gambarKategori: [String: String] = [
        "Sayur": "Bokcoy",
        "Buah": "fruit",
        "Daging": "Meat",
        "Ikan": "Fish",
        "Protein": "Egg",
        "Seafood": "Crab",
        "Frozen": "Sosis",
        "Bumbu": "Garlic"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingChartButton.tintColor = UIColor.systemGreen
        navigationController?.navigationBar.isHidden = true
        
        setupComponent()
        startBannerTimer()
        setupPageControl()
    }
    
    func setupComponent () {
        
        BannerInformationCollection.dataSource = self
        BannerInformationCollection.delegate = self
        if let layout = BannerInformationCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: BannerInformationCollection.bounds.height)
        }
        productCollection.delegate = self
        productCollection.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 25
        productCollection.collectionViewLayout = layout
        
        productCollection.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        BannerInformationCollection.register(UINib(nibName: bannerIdentifier, bundle: nil), forCellWithReuseIdentifier: bannerIdentifier)
    }
    
    func setupPageControl() {
        bannerPageControl.numberOfPages = bannerImages.count
        bannerPageControl.currentPage = currentBannerIndex
        bannerPageControl.pageIndicatorTintColor = .systemGray6
        bannerPageControl.currentPageIndicatorTintColor = .pink
    }

    func startBannerTimer() {
        bannerTimer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(rotateBanner), userInfo: nil, repeats: true)
    }
    
    @objc func rotateBanner() {
        
        if currentBannerIndex == bannerImages.count - 1 {
            currentBannerIndex = 0
        } else {
            currentBannerIndex += 1
        }

        let indexPath = IndexPath(item: currentBannerIndex, section: 0)

        UIView.animate(withDuration: 2.0, delay: 0, options: .curveLinear, animations: {
            self.BannerInformationCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }, completion: nil)
        
        bannerPageControl.currentPage = currentBannerIndex
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == BannerInformationCollection {
            return bannerImages.count
        }
        return kategoriData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == BannerInformationCollection {
            let bannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerIdentifier, for: indexPath) as! BannerCollectionViewCell
            bannerCell.bannerInformationImage.image = UIImage(named: bannerImages[indexPath.item])
            
            return bannerCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! SayurkuCollectionViewCell
        let kategoriIndex = min(indexPath.item, kategoriData.count - 1)
        if let namaGambar = gambarKategori[kategoriData[kategoriIndex]] {
            
            cell.sayurImage.image = UIImage(named: namaGambar)
        }
        cell.sayurNameLabel.text = kategoriData[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == BannerInformationCollection {
            
        } else if collectionView == productCollection {
            
            let selectedCategory = kategoriData[indexPath.item]
            
            if selectedCategory == "Sayur" {
                navigateToSayurViewController()
            }
            if selectedCategory == "Buah" {
                navigateToBuahViewController()
            }
            if selectedCategory == "Daging" {
                navigateToDagingViewController()
            }
            if selectedCategory == "Ikan" {
                navigateToIkanViewController()
            }
            if selectedCategory == "Protein" {
                navigateToProteinViewController()
            }
            if selectedCategory == "Seafood" {
                navigateToSeafoodViewController()
            }
            
            if selectedCategory == "Frozen" {
                navigateToFrozenViewController()
            }
            if selectedCategory == "Bumbu" {
                navigateToBumbuViewController()
            }
            func navigateToSayurViewController () {
                let sayurVC = SayurViewController()
                
                navigationController?.pushViewController(sayurVC, animated: true)
            }
            
            func navigateToBuahViewController () {
                
                let buahVC = BuahViewController()
                
                navigationController?.pushViewController(buahVC, animated: true)
            }
            
            func navigateToDagingViewController () {
                
                let dagingVC = DagingViewController()
                
                navigationController?.pushViewController(dagingVC, animated: true)
            }
            func navigateToIkanViewController () {
                
                let ikanVC = IkanViewController()
                
                navigationController?.pushViewController(ikanVC, animated: true)
            }
            func navigateToProteinViewController () {
                
                let ptoteinVC = ProteinViewController()
                
                navigationController?.pushViewController(ptoteinVC, animated: true)
            }
            func navigateToSeafoodViewController () {
                
                let seafoodVC = SeafoodViewController()
                
                navigationController?.pushViewController(seafoodVC, animated: true)
            }
            func navigateToFrozenViewController () {
                
                let frozenVC = FrozenViewController()
                
                navigationController?.pushViewController(frozenVC, animated: true)
            }
            func navigateToBumbuViewController () {
                
                let bumbuVC = BumbuViewController()
                
                navigationController?.pushViewController(bumbuVC, animated: true)
            }
        }
    }
}
