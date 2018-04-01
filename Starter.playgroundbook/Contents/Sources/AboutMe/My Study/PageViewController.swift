//
//  PageViewController.swift
//  AboutMe-2
//
//  Created by Hao Dong on 13/03/2017.
//  Copyright © 2017 Hao Dong. All rights reserved.
//

import UIKit
protocol PageViewControllerDelegate: class {
    
    /**
     Called when the number of pages is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func PageViewControllerUpdatePageCount(PageViewController: PageViewController,
                                           didUpdatePageCount count: Int)
    
    /**
     Called when the current index is updated.
     
     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func PageViewControllerUpdatePageIndex(PageViewController: PageViewController,
                                           didUpdatePageIndex index: Int)
    
}

class PageViewController: UIPageViewController {
    
    weak var pageDelegate: PageViewControllerDelegate?
    
    var pending = 0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    public required init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        if let firstViewController = orderedViewControllers.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        pageDelegate?.PageViewControllerUpdatePageCount(PageViewController: self, didUpdatePageCount: orderedViewControllers.count)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private(set) lazy var orderedViewControllers: [UIViewController] = {
        return [FirstViewController(), SecondViewController(), ThirdViewController(), ForthViewController()]
    }()
    
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        print(pendingViewControllers)
        if let firstViewController = pendingViewControllers.first as? FirstViewController {
            firstViewController.startAnimation()
        } else if let secondViewController = pendingViewControllers.first as? SecondViewController {
            secondViewController.startAnimation()
        } else if let thirdViewController = pendingViewControllers.first as? ThirdViewController {
            thirdViewController.startAnimation()
        } else if let forthViewController = pendingViewControllers.first as? ForthViewController {
            forthViewController.startAnimation()
        }
        pending = orderedViewControllers.index(of: pendingViewControllers.first!)!
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        print(previousViewControllers)
        if completed {
            pageDelegate?.PageViewControllerUpdatePageIndex(PageViewController: self, didUpdatePageIndex: pending)
        }
        
        //So we should remove all the labels
        if let forthViewController = previousViewControllers.first as? ForthViewController {
            forthViewController.removeLables()
        }
    }
    
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousControllerIndex = currentControllerIndex - 1
        guard previousControllerIndex >= 0 else { //loop
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousControllerIndex else { return nil }
        
        return orderedViewControllers[previousControllerIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextControllerIndex = currentControllerIndex + 1
        guard nextControllerIndex != orderedViewControllers.count else { //loop
            return orderedViewControllers.first
        }
        guard orderedViewControllers.count > nextControllerIndex else { return nil }
        
        return orderedViewControllers[nextControllerIndex]
    }
}


