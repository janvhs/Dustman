import DustbinCore
import Foundation

func ensureUserUID() throws {
    guard let sudoUID = getSudoUid() else {
        return
    }

    let result = setuid(sudoUID)
    guard result == 0 else {
        throw DustbinError.setUIDFailed
    }
}

func getSudoUid() -> UInt32? {
    let sudoUid = ProcessInfo.processInfo.environment["SUDO_UID"]
    if let sudoUid {
        return UInt32(sudoUid)
    } else {
        return nil
    }
}
