//
//  ViewController.swift
//  specificDeepLink
//
//  Created by 33893981 on 09/11/2023.
//  Copyright (c) 2023 33893981. All rights reserved.
//

import UIKit
import specificDeepLink

@available(iOS 13.0, *)
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = ViewHelper().getColor(hex: "008080")
        setupTitle()
        setupBtnClick()
        setupNavigationBar()
    }

    private let lblTitle     : UILabel    = UILabel()
    private let btnClick    : UIButton   = UIButton()
    
    private func setupTitle(){
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.textColor = UIColor.green
        lblTitle.font = UIFont(name: "HelveticaNeue-bold", size: 33)
        view.addSubview(lblTitle)
        lblTitle.topAnchor.constraint(equalTo: view.topAnchor , constant: 100).isActive = true
        lblTitle.heightAnchor.constraint(equalToConstant: 50).isActive = true
        lblTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        self.lblTitle.text = "Welcome From App A"
    }
    
    private func setupBtnClick(){
        view.addSubview(btnClick)
        btnClick.translatesAutoresizingMaskIntoConstraints = false
        btnClick.backgroundColor = UIColor.blue
        btnClick.tintColor = .white
        btnClick.layer.cornerRadius = 8
        btnClick.centerYAnchor.constraint(equalTo: view.centerYAnchor , constant: 0).isActive = true
        btnClick.centerXAnchor.constraint(equalTo: view.centerXAnchor , constant: 0).isActive = true
        btnClick.widthAnchor.constraint(equalToConstant: 300).isActive = true
        btnClick.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnClick.addTarget(self, action: #selector(clickApp), for: .touchUpInside)
        btnClick.setTitle("Click to open", for: .normal)
    }
    var appID:String = ""
    
    private func setAppID(){
        if let infoDictionary = Bundle.main.infoDictionary,
           let urlTypes = infoDictionary["CFBundleURLTypes"] as? [[String: Any]],
           let urlType = urlTypes.first,
           let urlSchemes = urlType["CFBundleURLSchemes"] as? [String],
           let urlScheme = urlSchemes.first {
            appID = urlScheme
        } else {
            appID = ""
           
        }
    }
    @objc func clickApp(sender:UIButton){
        setAppID()
        print("Click From App A")
        let order   = "hello123"
        let amt     = "110"
        let ccy     = "USD"
//        UIApplication.shared.open(URL.init(string: "appb://elepay?orderNo=\(order)&amount=\(amt)&ccy=\(ccy)&urlScheme=\(self.appID)://openpage")!, options: [:]) { success in
//            guard success else {
//                UIApplication.shared.open(URL.init(string: "itms-apps://itunes.apple.com/app/id1480524848")!, options: [:], completionHandler: nil)
//                return
//            }
//        }
        specificLink().openPrinceBank(order: order)
    }
    
    
    
    private func setupNavigationBar() {
        
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = ViewHelper().getColor(hex: "008090")
        appearance.titleTextAttributes = [.foregroundColor: ViewHelper().getColor(hex: "ffffff")]
        appearance.largeTitleTextAttributes = [.foregroundColor: ViewHelper().getColor(hex: "ffffff")]
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        title = "Home"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 18)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    
}

