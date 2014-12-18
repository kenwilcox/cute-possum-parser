//
//  TegVisibleViewController.swift
//
//  Returns currently visible view controller
//
//  Created by Evgenii Neumerzhitckii on 4/12/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegVisibleViewController {
  class var visibleViewController: UIViewController? {
    if let rooViewController = UIApplication.sharedApplication().delegate?.window??.rootViewController {
      return getVisibleViewControllerFrom(rooViewController)
    }
    
    return nil
  }
  
  private class func getVisibleViewControllerFrom(viewController: UIViewController) -> UIViewController {
    if let navigationViewController = viewController as? UINavigationController {
      return getVisibleViewControllerFrom(navigationViewController.visibleViewController)
    }
    
    if let tabBarViewController = viewController as? UITabBarController {
      if let selectedViewController = tabBarViewController.selectedViewController {
        return getVisibleViewControllerFrom(selectedViewController)
      }
    }
    
    if let presentedViewController = viewController.presentedViewController {
      return getVisibleViewControllerFrom(presentedViewController)
    }
    
    return viewController
  }
}
