//
//  ShellUtil.swift
//  MindfulVimeo
//
//  Created by Rob Slegtenhorst on 28/06/2018.
//  Copyright © 2018 Rob Slegtenhorst. All rights reserved.
//

import Foundation

class ShellUtil {

    public func shell(launchPath: String, arguments: [String]) -> String
    {
        let task = Process()
        task.launchPath = launchPath
        task.arguments = arguments
        
        let pipe = Pipe()
        task.standardOutput = pipe
        let errpipe = Pipe()
        task.standardError = errpipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: String.Encoding.utf8)!
        
        task.waitUntilExit()
        
        if output.count > 0 {
            //remove newline character.
            let lastIndex = output.index(before: output.endIndex)
            return String(output[output.startIndex ..< lastIndex])
        }
        
        return output
    }

}
