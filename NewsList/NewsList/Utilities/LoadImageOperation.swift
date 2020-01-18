//
//  LoadImageOperation.swift
//  NewsList
//
//  Created by Andrew on 14/01/2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

final class LoadImageOperation: Operation {
    
    var url: URL?
    var completion: ((UIImage) -> ())?
    override func main() {
        if let data = try? Data(contentsOf: self.url ?? URL(string: "https://vk.com/images/dquestion_v.png")!),
            let image = UIImage(data: data) {
            DispatchQueue.main.async { self.completion?(image) }
        }
    }
}
