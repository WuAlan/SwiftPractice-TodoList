//
//  DetailViewController.swift
//  Todo
//
//  Created by WuYanlin on 15/4/11.
//  Copyright (c) 2015年 AllenWu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var childButton: UIButton!
    
    @IBOutlet weak var phoneButton: UIButton!
    
    @IBOutlet weak var shoppingButton: UIButton!
    
    @IBOutlet weak var travelButton: UIButton!
    
    @IBOutlet weak var todoItem: UITextField!
    
    
    @IBOutlet weak var todoDate: UIDatePicker!
    
    var todo: TodoModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        todoItem.delegate=self
        
        if todo == nil {
            childButton.selected=true
            navigationItem.title = "新增Todo"
        }
        else {
            navigationItem.title = "修改Todo"
            if todo?.image == "selectChild" {
                childButton.selected=true
            }
            else if todo?.image == "selectShop" {
                shoppingButton.selected=true
            }
            else if todo?.image == "selectPhone" {
                phoneButton.selected=true
            }
            else if todo?.image == "selectTravel" {
                travelButton.selected=true
            }
            todoItem.text=todo?.title
            todoDate.setDate((todo?.date)!, animated: false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        todoItem.resignFirstResponder()
    }
    
    func resetButton()
    {
        childButton.selected=false
        shoppingButton.selected=false
        travelButton.selected=false
        phoneButton.selected=false
    }
    
    @IBAction func childTapped(sender: AnyObject) {
        resetButton()
        childButton.selected=true
    }
    
    @IBAction func phoneTapped(sender: AnyObject) {
        resetButton()
        phoneButton.selected=true
    }
    
    @IBAction func shoppingTapped(sender: AnyObject) {
        resetButton()
        shoppingButton.selected=true
    }
    
    @IBAction func travelTapped(sender: AnyObject) {
        resetButton()
        travelButton.selected=true
    }
    

    @IBAction func OKTapped(sender: AnyObject) {
        var image=""
        if childButton.selected {
            image = "selectChild"
        }
        else if phoneButton.selected {
            image = "selectPhone"
        }
        else if shoppingButton.selected {
            image = "selectShop"
        }
        else if travelButton.selected {
            image = "selectTravel"
        }
        if todo==nil {
            let uuid = NSUUID().UUIDString
            var todo=TodoModel(id: uuid, image: image, title: todoItem.text, date: todoDate.date)
            todos.append(todo)
        }
        else {
            todo?.image=image
            todo?.title=todoItem.text
            todo?.date=todoDate.date
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
