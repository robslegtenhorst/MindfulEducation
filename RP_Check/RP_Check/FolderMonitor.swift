//
//  DAFileMonitor.swift
//  DAAppGroupDemo
//
//  Created by Dejan on 01/08/2017.
//  Copyright © 2017 Dejan. All rights reserved.
//
import Foundation

open class FolderMonitor {
	
	private let folderPath: String
	private let fileSystemEvent: DispatchSource.FileSystemEvent
	private let dispatchQueue: DispatchQueue
	
	private var eventSource: DispatchSourceFileSystemObject?
	
	public var onFolderEvent: (() -> ())? {
		willSet {
			self.eventSource?.cancel()
		}
		didSet {
			if (onFolderEvent != nil) {
				self.startObservingFileChanges()
			}
		}
	}
	
	init?(withFolderPath path: String, observeEvent event: DispatchSource.FileSystemEvent = .write, queue: DispatchQueue = DispatchQueue.global(), createFile create: Bool = true) {
		self.folderPath = path
		self.fileSystemEvent = event
		self.dispatchQueue = queue
		
		print("Folder Monitor_1")
		
		if self.fileExists() == false && create == false {
			return nil
		} else if self.fileExists() == false {
			createFile()
		}
	}
	
	deinit {
		self.eventSource?.cancel()
	}
	
	private func fileExists() -> Bool {
		return FileManager.default.fileExists(atPath: self.folderPath)
	}
	
	private func createFile() {
		if self.fileExists() == false {
			FileManager.default.createFile(atPath: self.folderPath, contents: nil, attributes: nil)
		}
	}
	
	private func startObservingFileChanges()
	{
		guard fileExists() == true else {
			return
		}
		
		let descriptor = open(self.folderPath, O_EVTONLY)
		if descriptor == -1 {
			return
		}
		
		self.eventSource = DispatchSource.makeFileSystemObjectSource(fileDescriptor: descriptor, eventMask: self.fileSystemEvent, queue: self.dispatchQueue)
		
		self.eventSource?.setEventHandler {
			[weak self] in
			self?.onFolderEvent?()
		}
		
		self.eventSource?.setCancelHandler() {
			close(descriptor)
		}
		
		self.eventSource?.resume()
	}
}
