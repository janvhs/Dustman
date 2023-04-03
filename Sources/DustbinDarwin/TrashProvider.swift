import DustbinCore
import Foundation

public struct TrashProvider: TrashProviderProtocol {
    public init() {}

    public func trashFile(file: URL) throws {
        // TODO: Multiple files will require multiple authorization requests.
        let scriptSource = "tell application \"Finder\" to delete { POSIX file \"\(file.canonicalizePath())\" }"
        guard let script = NSAppleScript(
            source: scriptSource
        ) else {
            throw DustbinError.appleScriptNotCompilable(source: scriptSource)
        }

        var errorDict: NSDictionary?
        script.executeAndReturnError(&errorDict)

        if errorDict != nil {
            let errorMessage = errorDict?["NSAppleScriptErrorMessage"] as? String
            let appName = errorDict?["NSAppleScriptErrorAppName"] as? String
            let errorNumber = errorDict?["NSAppleScriptErrorNumber"] as? Int

            if errorNumber != nil, errorNumber == -1743 {
                throw DustbinError.appleScriptAppNotAllowed(appName: appName, message: errorMessage)
            } else {
                throw DustbinError.appleScriptError(errorDict: errorDict ?? NSDictionary())
            }
        }
    }
}
