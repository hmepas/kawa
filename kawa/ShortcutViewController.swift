import Cocoa

class ShortcutViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
  @IBOutlet weak var tableView: NSTableView?

  private var inputSources: [InputSource] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    tableView?.registerForDraggedTypes([.string])
    tableView?.setDraggingSourceOperationMask(.move, forLocal: true)
    reloadInputSources()
  }

  func reloadInputSources() {
    inputSources = InputSource.orderedSources(using: PermanentStorage.inputSourceOrder)
    ShortcutManager.shared.rebuildBindings(with: inputSources)
    tableView?.reloadData()
  }

  func numberOfRows(in tableView: NSTableView) -> Int {
    return inputSources.count
  }

  func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
    let inputSource = inputSources[row]
    guard let columnIdentifier = tableColumn?.identifier.rawValue else { return nil }

    switch columnIdentifier {
    case "Keyboard":
      return createKeyboardCellView(tableView, inputSource)
    case "Shortcut":
      return createShortcutCellView(tableView, inputSource)
    default:
      return nil
    }
  }

  func createKeyboardCellView(_ tableView: NSTableView, _ inputSource: InputSource) -> NSTableCellView? {
    let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "KeyboardCellView"), owner: self) as? NSTableCellView
    cell!.textField?.stringValue = inputSource.name
    cell!.imageView?.image = inputSource.icon
    return cell
  }

  func createShortcutCellView(_ tableView: NSTableView, _ inputSource: InputSource) -> ShortcutCellView? {
    let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "ShortcutCellView"), owner: self) as? ShortcutCellView
    cell?.setInputSource(inputSource)
    return cell
  }

  // MARK: Drag & drop ordering

  func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
    return NSString(string: inputSources[row].id)
  }

  func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
    tableView.setDropRow(row, dropOperation: .above)
    return .move
  }

  func tableView(_ tableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
    guard let sourceId = info.draggingPasteboard.string(forType: .string),
      let fromIndex = inputSources.firstIndex(where: { $0.id == sourceId })
    else { return false }

    var updated = inputSources
    let source = updated.remove(at: fromIndex)
    let toIndex = row > fromIndex ? row - 1 : row
    updated.insert(source, at: max(0, min(toIndex, updated.count)))

    inputSources = updated
    PermanentStorage.inputSourceOrder = updated.map { $0.id }
    ShortcutManager.shared.rebuildBindings(with: updated)
    tableView.reloadData()
    return true
  }
}
