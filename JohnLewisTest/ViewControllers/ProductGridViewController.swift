//
//  ProductGridViewController.swift
//  JohnLewisTest
//
//  Created by Kim Summerskill on 14/08/2018.
//  Copyright © 2018 Kim Summerskill. All rights reserved.
//

import UIKit

class ProductGridViewController: UIViewController, MVVMViewController {

    @IBOutlet fileprivate weak var resultsCollectionView: UICollectionView!
    
    var viewModel: ProductGridViewModel!
    let itemsPerRow: CGFloat = 2.0
    let heightMultiplier: CGFloat = 1.4
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                guard let `self` = self else { return }
                self.reloadData()
            }
        }
        
        self.viewModel.fetchProductCategory(with: nil)
        
    }
    
    func reloadData() {
        self.navigationItem.title = viewModel.titleForGrid()
        resultsCollectionView.reloadData()
    }
    
    // Update table view on rotation to ensure cells calculations are correct
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        resultsCollectionView.reloadData()
        super.viewWillTransition(to: size, with: coordinator)
    }

}

// MARK: UICollectionViewDataSource methods

extension ProductGridViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.collectionView(collectionView, cellForItemAt:indexPath)
    }
}

// MARK: UICollectionViewDelegate methods

extension ProductGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Can do something funky here to calculate based on screen orientation and size if there was more time.
        var items: CGFloat = itemsPerRow
        
        // Double the items for iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            items = items * 2.0
        }
        
        // Add one if Landscape (either that or have the same number of cells but bigger)
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)  {
            items += 1
        }
        
        var padding: CGFloat = 0.0
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            let minSpacing = layout.minimumInteritemSpacing
            padding = (minSpacing > 0) ? (minSpacing * items) / 2.0 : minSpacing
        }
        
        let width = collectionView.frame.size.width/items
        
        // Will use this later to adjust the height of our cell depending on the aspect of the image we
        // have donwloaded. For now they are just going to bbe square cells.
        let height = width * heightMultiplier
        
        return CGSize(width: width - padding, height: height)
        
    }
}

