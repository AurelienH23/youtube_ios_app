//
//  HomeController.swift
//  youtube
//
//  Created by Aurélien Haie on 03/01/2017.
//  Copyright © 2017 Aurélien Haie. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    //MARK: Properties
    let titles = ["Home", "Trending", "Subscription", "Account"]

    var settings: [Setting] = {
        return [Setting(name: "Settings", imageName: "ic_settings"),
                Setting(name: "Terms & privacy policy", imageName: "ic_lock"),
                Setting(name: "Send Feedback", imageName: "ic_announcement"),
                Setting(name: "Help", imageName: "ic_help"),
                Setting(name: "Switch Account", imageName: "ic_account_circle"),
                Setting(name: "Cancel", imageName: "ic_clear")]
    }()
    
    //MARK: LifeCycle funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 50, width: view.frame.width - 32, height: 44))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        navigationController?.navigationBar.isTranslucent = false
        
        setUpCollectionView()
        setUpMenuBar()
        setUpNavBarButtons()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setUpCollectionView() {
        collectionView?.backgroundColor = UIColor.white
//        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "slidesCellId")
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "feedCellId")
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.isPagingEnabled = true
    }
    
    //MARK: Custom funcs
    func setUpNavBarButtons() {
        let searchImage = UIImage(named: "ic_search_white")?.withRenderingMode(.alwaysOriginal)
        let searchButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "ic_more_vert_white")?.withRenderingMode(.alwaysOriginal)
        let moreButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))

        navigationItem.rightBarButtonItems = [moreButtonItem, searchButtonItem]
    }
    
    @objc func handleSearch() {
        print(123)
    }
    
    let blackView = UIView()
    
    let moreCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.white
        return cv
    }()
    
    @objc func handleMore() {
        //Show menu
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)

            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMoreView)))
            
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(moreCollectionView)
            moreCollectionView.delegate = self
            moreCollectionView.dataSource = self
            moreCollectionView.register(SettingsCell.self, forCellWithReuseIdentifier: "settingsCellId")
            
            let height = CGFloat(settings.count) * 50.0
            let y = window.frame.height - height
            moreCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.moreCollectionView.frame = CGRect(x: 0, y: y, width: self.moreCollectionView.frame.width, height: self.moreCollectionView.frame.height)
            }, completion: nil)
        }
    }
    
    @objc func dismissMoreView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.moreCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.moreCollectionView.frame.width, height: self.moreCollectionView.frame.height)
            }
        }) { (Bool) in
            self.blackView.removeFromSuperview()
            self.moreCollectionView.removeFromSuperview()
        }
    }

    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setUpMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
        setTitleForIndex(index: menuIndex)
    }
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    //MARK: DataSource & Delegate funcs
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == moreCollectionView {
            return settings.count
        } else {
            return 4
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == moreCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "settingsCellId", for: indexPath) as! SettingsCell
            cell.setting = self.settings[indexPath.row]
            return cell
        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slidesCellId", for: indexPath)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCellId", for: indexPath)
            
            cell.backgroundColor = UIColor(white: CGFloat(indexPath.row)/3, alpha: 1)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == moreCollectionView {
            return CGSize(width: collectionView.frame.width, height: 50)
        } else {
            return CGSize(width: view.frame.width, height: view.frame.height - 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moreCollectionView {
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 0
                if let window = UIApplication.shared.keyWindow {
                    self.moreCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.moreCollectionView.frame.width, height: self.moreCollectionView.frame.height)
                }
            }, completion: { (Bool) in
                self.blackView.removeFromSuperview()
                self.moreCollectionView.removeFromSuperview()
                
                let setting = self.settings[indexPath.row]
                
                if setting.name != "Cancel" {
                    let dummyViewController = UIViewController()
                    dummyViewController.view.backgroundColor = UIColor.white
                    dummyViewController.navigationItem.title = setting.name
                    self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                    self.navigationController?.navigationBar.tintColor = UIColor.white
                    self.navigationController?.pushViewController(dummyViewController, animated: true)
                }
            })
        } else {
            
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarViewLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
        setTitleForIndex(index: index)
    }
}
