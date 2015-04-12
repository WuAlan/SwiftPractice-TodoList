//
//  ViewController.swift
//  Todo
//
//  Created by WuYanlin on 15/4/8.
//  Copyright (c) 2015年 AllenWu. All rights reserved.
//

import UIKit

var todos: [TodoModel] = []
var filterTodos: [TodoModel] = []
func dateFromString(dateStr: String)->NSDate?{
    let dateFormatter=NSDateFormatter()
    dateFormatter.dateFormat="yyyy-MM-dd"
    let date=dateFormatter.dateFromString(dateStr)
    return date
}
class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == searchDisplayController?.searchResultsTableView {
            return filterTodos.count
        }
        return todos.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("todoCell") as! UITableViewCell
        var todo:TodoModel
        if tableView == searchDisplayController?.searchResultsTableView {
            todo=filterTodos[indexPath.row] as TodoModel
        }
        else {
           todo=todos[indexPath.row] as TodoModel
        }
        
        var image=cell.viewWithTag(101) as! UIImageView
        var title=cell.viewWithTag(102) as! UILabel
        var date=cell.viewWithTag(103) as! UILabel
        image.image=UIImage(named: todo.image)
        title.text=todo.title
        let locale=NSLocale.currentLocale()
        let dataFormat=NSDateFormatter.dateFormatFromTemplate("yyyy-MM-dd", options: 0, locale: locale)
        let dataFormater=NSDateFormatter()
        dataFormater.dateFormat=dataFormat
        date.text=dataFormater.stringFromDate(todo.date)
        return cell
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        todos=[
            TodoModel(id: "1", image: "selectChild", title: "1. 去游乐场", date: dateFromString("2014-11-02")!),
            TodoModel(id: "2", image: "selectShop", title: "2. 去购物", date: dateFromString("2014-10-28")!),
            TodoModel(id: "3", image: "selectTravel", title: "3. 去旅行", date: dateFromString("2015-03-02")!),
            TodoModel(id: "4", image: "selectPhone", title: "4. 去打电话", date: dateFromString("2014-10-20")!)
        ]
        navigationItem.leftBarButtonItem=editButtonItem()
        
        var contentOffset=tableView.contentOffset
        contentOffset.y += searchDisplayController!.searchBar.frame.size.height
        tableView.contentOffset = contentOffset
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            todos.removeAtIndex(indexPath.row)
            self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "editTodo" {
            var vc=segue.destinationViewController as! DetailViewController
            var indexPath=tableView.indexPathForSelectedRow()
            if let index=indexPath {
                vc.todo=todos[index.row]
            }
        }
    }
    
    @IBAction func close(segue: UIStoryboardSegue)
    {
        println("closed")
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return editing
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let todo=todos.removeAtIndex(sourceIndexPath.row)
        todos.insert(todo, atIndex: destinationIndexPath.row)
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filterTodos=todos.filter(){$0.title.rangeOfString(searchString) != nil}
        
        return true
    }
}

