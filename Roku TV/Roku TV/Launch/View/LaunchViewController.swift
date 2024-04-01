//
//  LaunchViewController.swift
//  Roku TV
//
//  Created by User on 21.03.2024.
//

import SnapKit
import UIKit

final class LaunchViewController: UIPageViewController {
    // MARK: - Properties
    private let viewModel: LaunchViewModelProtocol
    private var currentPageIndex = 0
    weak var coordinator: AppCoordinator?
    
    // MARK: - GUI Variables
    private lazy var detailViewControllersArray: [LaunchDetailViewController] = {
        var launchVCArray: [LaunchDetailViewController] = viewModel.sourceArray.map { LaunchDetailViewController(source: $0) }
        return launchVCArray
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - Initialization
    init(viewModel: LaunchViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    func goNext() {
        guard let vc = viewControllers?.first as? LaunchDetailViewController,
              let index = detailViewControllersArray.firstIndex(of: vc) else { return }
        if index < detailViewControllersArray.count - 1 {
            setViewControllers([detailViewControllersArray[index + 1]], direction: .forward, animated: false)
            currentPageIndex = index + 1
            updatePageControl()
        } else {
            coordinator?.showLastVC()
        }
    }
}

// MARK: - Private methods
private extension LaunchViewController {
    func setupUI() {
        view.backgroundColor = .specialGray
        setViewControllers([detailViewControllersArray[0]], direction: .forward, animated: true)
        self.dataSource = self
    }
    
    func getPageControl() -> UIPageControl? {
        for view in view.subviews {
            if let pageControl = view as? UIPageControl {
                return pageControl
            }
        }
        return nil
    }
    
    func updatePageControl() {
        if let pageControl = getPageControl() {
            pageControl.currentPage = currentPageIndex
        }
    }
}

// MARK: - UIPageViewControllerDataSource
extension LaunchViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? LaunchDetailViewController else { return nil }
        if let index = detailViewControllersArray.firstIndex(of: viewController) {
            if index > 0 {
                return detailViewControllersArray[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? LaunchDetailViewController else { return nil }
        if let index = detailViewControllersArray.firstIndex(of: viewController) {
            if index < detailViewControllersArray.count - 1 {
                return detailViewControllersArray[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return detailViewControllersArray.count + 1
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
