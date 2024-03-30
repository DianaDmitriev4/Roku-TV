//
//  LaunchViewModel.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import SnapKit
import UIKit

protocol LaunchViewModelProtocol {
    var sourceArray: [LaunchModel] { get }
    var menuViewTopConstraints: [UIView: Constraint] { get set }
    
    func selectView(selectedView: UIView, button: UIButton, imageView: UIImageView)
}

final class LaunchViewModel: LaunchViewModelProtocol {
    // MARK: - Properties
    private var currentlySelectedView: UIView?
    private(set) var sourceArray: [LaunchModel] = []
    var menuViewTopConstraints: [UIView: Constraint] = [:]
    
    // MARK: - Initialization
    init() {
        fillArrayWithData()
    }
    
    // MARK: - Private methods
    private func fillArrayWithData() {
        sourceArray = [
            LaunchModel(image: UIImage(named: "firstPage") ?? .checkmark,
                        title: "Remote Control for Roku TV",
                        description: "Use our convenient application instead of using remote control",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "secondPage") ?? .checkmark,
                        title: "Easy Device Connection",
                        description: "Connect to your devices via Wi-Fi and control TV with the place",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "thirdPage") ?? .checkmark,
                        title: "Your Favorites in One Place",
                        description: "Choose and watch your favorite channels, videos and movies",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "fourthPage") ?? .checkmark,
                        title: "Internet Speed Test",
                        description: "Use the diagnostic tool to analyze network signals",
                        buttonTitle: "Continue",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: nil),
            LaunchModel(image: UIImage(named: "fifthPage") ?? .checkmark,
                        title: "Start to Continue TV Remote",
                        description: "Start to continue TV Reomote app with a 3-day trial and 499 rub/week",
                        buttonTitle: "Get free trial",
                        firstLabel: "Terms of Use",
                        secondLabel: "Privacy Policy",
                        thirdLabel: "Restore Purchases")
        ]
    }
    
    private func findIntersectingView(_ selectedView: UIView) -> UIView? {
        if let subviewOfSuperview = selectedView.superview?.subviews {
            for subview in subviewOfSuperview {
                if subview != selectedView {
                    let selectedViewCGRect = selectedView.convert(selectedView.bounds, to: nil)
                    let subviewCGRect = subview.convert(subview.bounds, to: nil)
                    
                    if selectedViewCGRect.intersects(subviewCGRect) {
                        return subview
                    }
                }
            }
        }
        return nil
    }
    
    // MARK: - Methods
    func selectView(selectedView: UIView, button: UIButton, imageView: UIImageView) {
        if currentlySelectedView == selectedView {
            // Change view color
            if let intersectionView = findIntersectingView(selectedView) {
                intersectionView.backgroundColor = .specialViolet
                intersectionView.layer.borderColor = UIColor.specialViolet.cgColor
            }
            
            // Return constraint
            if let topConstraintOfSelected = menuViewTopConstraints[selectedView] {
                topConstraintOfSelected.update(offset: 35)
                currentlySelectedView = nil
                button.backgroundColor = .specialGray
                button.isUserInteractionEnabled = false
                imageView.backgroundColor = .specialViolet
            }
        } else {
            //return the views color to unselect
            let intersectionView = findIntersectingView(selectedView)
            intersectionView?.backgroundColor = .black
            intersectionView?.layer.borderColor = UIColor.black.cgColor
            
            // Return constraint from previous
            if let currentlySelectedView,
               let topConstraint = menuViewTopConstraints[currentlySelectedView] {
                topConstraint.update(offset: 35)
                
                let intersectionView = findIntersectingView(currentlySelectedView)
                intersectionView?.backgroundColor = .specialViolet
                intersectionView?.layer.borderColor = UIColor.specialViolet.cgColor
            }
            //raise selected
            if let topConstraint = menuViewTopConstraints[selectedView] {
                topConstraint.update(offset: 25)
                currentlySelectedView = selectedView
                imageView.backgroundColor = .specialGray
                button.backgroundColor = .specialViolet
                button.isUserInteractionEnabled = true
            }
            UIView.animate(withDuration: 0.3) {
                selectedView.superview?.layoutIfNeeded()
            }
        }
    }
}
