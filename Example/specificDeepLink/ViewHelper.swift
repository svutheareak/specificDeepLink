//
//  ViewHelper.swift
//  deepLinkA
//
//  Created by Sam Vutheareak on 31/8/23.
//


import Foundation
import UIKit


class ViewHelper {
    func getColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func showToast(message: String, duration: TimeInterval = 5.0, view: UIView) {
        let toastLabel = PaddingLabel(withInsets: 8, 8, 16, 16)
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        view.addSubview(toastLabel)
        
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toastLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toastLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            toastLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        
        // Call sizeToFit() to adjust the label's height based on its content
        toastLabel.sizeToFit()
        
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
    
    
    //Currency Helper
    func formatCurrency(amount: Double, currencyCode: String, localeIdentifier: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        
        if currencyCode == "KHR" {
            formatter.maximumFractionDigits = 0 // For KHR, no cents
        } else {
            formatter.maximumFractionDigits = 2 // For other currencies, keep 2 decimal places
        }
        
        // Use the specified locale
        formatter.locale = Locale(identifier: localeIdentifier)
        
        // Hide the currency symbol by setting it to an empty string
        formatter.currencySymbol = ""
        
        var formattedString = formatter.string(from: NSNumber(value: amount))
        
        // Manually replace the decimal separator if the currency is KHR and the locale is km_KH
        if currencyCode == "KHR" && localeIdentifier == "km_KH" {
            formattedString = formattedString?.replacingOccurrences(of: ".", with: ",")
        }
        
        return formattedString
    }
    
}

class PaddingLabel: UILabel {
    
    var topInset: CGFloat
    var bottomInset: CGFloat
    var leftInset: CGFloat
    var rightInset: CGFloat
    
    required init(withInsets top: CGFloat, _ bottom: CGFloat,_ left: CGFloat,_ right: CGFloat) {
        self.topInset = top
        self.bottomInset = bottom
        self.leftInset = left
        self.rightInset = right
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func drawText(in rect: CGRect) {
//        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
//        super.drawText(in: rect.inset(by: insets))
//    }
//
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += topInset + bottomInset
            contentSize.width += leftInset + rightInset
            return contentSize
        }
    }
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height / 2, width: bounds.width, height: bounds.height / 2)
    }
}

extension UIViewController {
    
//    func createWaitingAlert() -> UIAlertController {
//        let alert = UIAlertController(title: "please wait", message: nil, preferredStyle: UIAlertController.Style.alert)
//        alert.view.translatesAutoresizingMaskIntoConstraints = false
//        alert.view.heightAnchor.constraint(equalToConstant: 120).isActive = true
//        
//        // init player container
//        let containerView: UIView = UIView()
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//        alert.view.addSubview(containerView)
//        containerView.topAnchor.constraint(equalTo: alert.view.topAnchor, constant: 50).isActive = true
//        containerView.trailingAnchor.constraint(equalTo: alert.view.trailingAnchor, constant: -10).isActive = true
//        containerView.leadingAnchor.constraint(equalTo: alert.view.leadingAnchor, constant: 10).isActive = true
//        containerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        
//        let loadingView = UIActivityIndicatorView.init(style: .medium)
//        loadingView.startAnimating()
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.addSubview(loadingView)
//        loadingView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
//        loadingView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
//        return alert
//    }
    
    func showWarningAlert(title: String, button: String, msg: String, handler: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: { (action) in
            handler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

/// ----- Disable Rotation with NavigationController /////
extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.shouldAutorotate
            }
            return super.shouldAutorotate
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
}
