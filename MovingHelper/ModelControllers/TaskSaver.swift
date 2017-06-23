//
//  TaskSaver.swift
//  MovingHelper
//
//  Created by Ellen Shapiro on 6/15/15.
//  Copyright (c) 2015 Razeware. All rights reserved.
//

import Foundation

/*
Struct to save tasks to JSON.
*/
public struct TaskSaver {
  
  /*
  Writes a file to the given file name in the documents directory
  containing JSON storing the given tasks.
  
  :param: The tasks to write out.
  :param: The file name to use when writing out the file.
  */
  static func writeTasksToFile(_ tasks: [Task], fileName: FileName) {
    let dictionaries = map(tasks) {
      task in
      return task.asJson()
    }
    
    var error: NSError?
    let fullFilePath = fileName.jsonFileName().pathInDocumentsDirectory()
    if let jsonData = JSONSerialization.dataWithJSONObject(dictionaries,
      options: .PrettyPrinted,
      error: &error) {
        jsonData.writeToFile(fullFilePath, atomically: true)
    }
    
    if let foundError = error {
      NSLog("Error writing tasks to file: \(foundError.localizedDescription)")
    }
  }
  
  public static func nukeTaskFile(_ fileName: FileName) {
    let fullFilePath = fileName.jsonFileName().pathInDocumentsDirectory()
    var error: NSError?
    
    FileManager.default
      .removeItemAtPath(fullFilePath, error: &error)
    
    if let foundError = error {
      if foundError.code != NSFileNoSuchFileError {
        NSLog("Error deleting file: \(foundError.localizedDescription)")
      } //Otherwise the file cannot be deleted because it doesn't exist yet.
    }
  }
}
