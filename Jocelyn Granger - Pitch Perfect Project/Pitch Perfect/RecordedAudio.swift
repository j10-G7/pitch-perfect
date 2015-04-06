//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Jocelyn Granger on 4/2/15.
//  Copyright (c) 2015 Jocelyn Granger. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject {
    var filePathUrl: NSURL!
    var title: String!

    func RecordedAudio(in_filePathUrl: NSURL, in_title: String)
    {
        self.filePathUrl = in_filePathUrl
        self.title = in_title
    }
}
