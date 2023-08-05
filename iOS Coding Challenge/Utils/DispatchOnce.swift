//
//  DispatchOnce.swift
//  iOS Coding Challenge
//
//  Created by Nghia Dinh on 02/08/2023.
//

import Foundation

public final class DispatchOnce {
   private var lock = os_unfair_lock()
   private var isInitialized = false
    public func perform(block: () -> Void) {
      os_unfair_lock_lock(&lock)
      if !isInitialized {
         block()
         isInitialized = true
      }
      os_unfair_lock_unlock(&lock)
   }
}

