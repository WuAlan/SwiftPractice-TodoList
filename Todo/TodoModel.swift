//
//  TodoModel.swift
//  Todo
//
//  Created by WuYanlin on 15/4/11.
//  Copyright (c) 2015年 AllenWu. All rights reserved.
//

import UIKit

class TodoModel: NSObject {
    var id:String
    var image:String
    var title:String
    var date:NSDate
    
    init(id: String, image: String, title: String, date: NSDate) {
        self.id=id
        self.image=image
        self.title=title
        self.date=date
    }
}
