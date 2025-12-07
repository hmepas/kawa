import Foundation

class AlwaysAllowShortcutValidator: MASShortcutValidator {
  static let sharedValidator = AlwaysAllowShortcutValidator()

  override func isShortcutValid(_ shortcut: MASShortcut!) -> Bool {
    return true
  }

  override func isShortcut(_ shortcut: MASShortcut!, alreadyTakenIn menu: NSMenu!, explanation: AutoreleasingUnsafeMutablePointer<NSString?>!) -> Bool {
    return false
  }

  override func isShortcutAlreadyTaken(bySystem shortcut: MASShortcut!, explanation: AutoreleasingUnsafeMutablePointer<NSString?>!) -> Bool {
    return false
  }
}
