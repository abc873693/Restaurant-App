//
//  ViewController.swift
//  Restaurant_app
//
//  Created by Ray on 2016/12/31.
//  Copyright © 2016年 kuas. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UIPageViewController {
    lazy var orderedViewControllers = [UIViewController]()
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        self.view.backgroundColor = UIColor.white
        for i in types {
            let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChildOrderTableViewController")
            view.title = i
            orderedViewControllers.append(view)
        }
        pageControl.numberOfPages = orderedViewControllers.count
        print("orderedViewControllers count = \(orderedViewControllers.count)")
        
        if orderedViewControllers.first != nil {
            setViewControllers([orderedViewControllers[0]], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newColoredViewController(color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(color)ViewController")
    }
    
    @IBAction func action_comfirm(_ sender: UIButton) {
        orders.removeAll()
        for i in orderedViewControllers {
            let view = i as! ChildOrderTableViewController
            for j in view.tableView.visibleCells {
                let cell = j as! ChildOrderTableViewCell
                if cell.step_amount.value != 0.0 {
                    print("\(cell.text_name.text!)")
                    //saveData(uid:cell.uid,amount:Int(cell.step_amount.value),size:cell.segment_price.selectedSegmentIndex)
                    let model = SlectProduct()
                    model.uid = cell.uid
                    model.amount = Int(cell.step_amount.value)
                    model.size = cell.segment_price.selectedSegmentIndex
                    orders.append(model)
                }
            }
        }
        self.performSegue(withIdentifier: "comfirm", sender: self)
    }
    

    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "comfirm" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! ProductTableViewController
                destinationController.type = types[indexPath.row]
            }
        }
        
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OrderViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        pageControl.currentPage = previousIndex
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        pageControl.currentPage = nextIndex
        return orderedViewControllers[nextIndex]
    }

    
}
