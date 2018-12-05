//
//  PPPizzaDetailsVC.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit

class PPPizzaDetailsVC: PPViewController, ViewModelBased, UIScrollViewDelegate {
    typealias ViewModel = PPPizzaDetailsViewModel
    var viewModel: PPPizzaDetailsViewModel?
    
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resturantImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func bindViewModel() {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageHeight = resturantImage.frame.size.height
        let yOffset = scrollView.contentOffset.y
        let move = yOffset < 0 ? 0 : yOffset > imageHeight ? -imageHeight : -yOffset
        self.imageTopConstraint.constant = move / 2
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            moveScrollViewToAnchor()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        moveScrollViewToAnchor()
    }
    
    func moveScrollViewToAnchor(){
        let yOffset = scrollView.contentOffset.y
        let imageHeight = resturantImage.frame.size.height
        if yOffset > 0 {
            if yOffset < imageHeight / 2 {
                scrollView.setContentOffset(CGPoint.zero, animated: true)
            }
            else if yOffset < imageHeight {
                scrollView.setContentOffset(CGPoint.init(x: 0, y: imageHeight), animated: true)
            }
        }
    }
    
    
}
