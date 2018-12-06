//
//  PPPizzaDetailsVC.swift
//  PizzaPlaces
//
//  Created by Marco Guerrieri on 03/12/18.
//  Copyright © 2018 Marco Guerrieri. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cosmos

class PPPizzaDetailsVC: PPViewController, ViewModelBased, UIScrollViewDelegate {
    typealias ViewModel = PPPizzaDetailsViewModel
    var viewModel: PPPizzaDetailsViewModel?
    
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet var textHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var friendsListHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var readMoreBtn: UIButton!
    @IBOutlet weak var bookNowBtn: PPRoundButton!
    @IBOutlet weak var detailLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ratingSelector: CosmosView!
    @IBOutlet weak var openingLbl: UILabel!
    @IBOutlet weak var friendsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindViewModel()
    }
    
    func bindViewModel() {
        let viewWillAppear =  self.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map({ _ -> Void in return () })
            .asDriver(onErrorJustReturn: ())
        
        viewModel!.initBindings(viewWillAppear: viewWillAppear)
        
        viewModel?.resturantImage
            .catchError { Observable.error($0) }
            .filter{ $0 != nil }
            .bind(to: resturantImage.rx.image)
            .disposed(by: self.disposeBag)
        
        viewModel?.resturantName
            .bind(to: self.nameLbl.rx.text)
            .disposed(by: self.disposeBag)
        
        viewModel?.isOpened
            .bind(to: self.openingLbl.rx.text)
            .disposed(by: self.disposeBag)
        
        viewModel?.resturantDescription
            .bind(to: self.detailLbl.rx.text)
            .disposed(by: self.disposeBag)
        
        readMoreBtn.rx.tap.asDriver().drive(onNext: { [weak self] (_) in
            guard let self = self else {return}
            UIView.animate(withDuration: 0.5, animations: {
                //there are some arrangment to do on the animation of the label.
                self.textHeightConstraint.isActive.toggle()
                let title = self.textHeightConstraint.isActive ? PPStrings.Buttons.readMore : PPStrings.Buttons.readLess
                self.readMoreBtn.setTitle(title, for: .normal)
                self.view.layoutIfNeeded()
            }, completion: { (completed) in
            })
        })
        .disposed(by: self.disposeBag)
        
        friendsCollectionView.register(UINib.init(nibName: PPFriendsCVCell.identifier, bundle: nil), forCellWithReuseIdentifier: PPFriendsCVCell.identifier)
        
        viewModel?.friendsListSource
            .asObservable()
            .bind(to:
            friendsCollectionView.rx.items(cellIdentifier: PPFriendsCVCell.identifier, cellType: PPFriendsCVCell.self)) { row, friend, cell in
                cell.friend = friend
            }.disposed(by: disposeBag)
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let imageHeight = resturantImage.frame.size.height
        let yOffset = scrollView.contentOffset.y
        if yOffset < 0 {
            let move = yOffset > imageHeight ? -imageHeight : -yOffset
            self.imageTopConstraint.constant = move / 2
        }
        // also maybe hide favourite btn when go behinde the resturant name and make it appear on the bar
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
        if yOffset > 0 && (scrollView.contentSize.height > (scrollView.frame.size.height + imageHeight)) {
            if yOffset < imageHeight / 2 {
                scrollView.setContentOffset(CGPoint.zero, animated: true)
            }
            else if (yOffset > imageHeight / 2 ) && (yOffset < imageHeight) {
                scrollView.setContentOffset(CGPoint.init(x: 0, y: imageHeight), animated: true)
            }
        }
    }
    
    
}
