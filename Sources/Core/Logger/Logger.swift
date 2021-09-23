//
//  Logger.swift
//  ApplicationDelegate
//
//  Created by Amine Bensalah on 23/06/2019.
//

import Foundation

public enum LogLevel {
    case DEBUG, INFO, ERROR, NETWORK, MARK

    fileprivate func emotionLevel() -> String {
        var emotion = ""
        switch self {
        case .DEBUG:
            emotion = "\u{0001F937} "
        case .INFO:
            emotion = "\u{0001F446} "
        case .ERROR:
            emotion = "\u{0001F621} "
        case .NETWORK:
            emotion = "\u{0001F310} "
        case .MARK:
            emotion = "\u{0001F340} "
        }

        return emotion + "\(self)" + " ➯ "
    }
}

public protocol ConsoleLoggerProtocol {
    static func debug(msg: Any, _ line: Int, _ fileName: String, _ funcName: String, type: LogLevel)
    static func error(msg: Any, _ line: Int, _ fileName: String, _ funcName: String)
    static func info(msg: Any, _ line: Int, _ fileName: String, _ funcName: String)
    static func mark(_ line: Int, _ fileName: String, _ funcName: String)
}

extension ConsoleLoggerProtocol {
    // Current UTC time
    fileprivate static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd/HH:mm:ss.SSS"
        return dateFormatter.string(from: Date())
    }

    public static func debug(msg: Any, _ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function, type: LogLevel = .DEBUG) {
        var fullLogMessage = type.emotionLevel()
        fullLogMessage += Self.getCurrentTime() + ": "
        fullLogMessage += URL(fileURLWithPath: fileName).deletingPathExtension().lastPathComponent + " ➯ "
        fullLogMessage += funcName + ":"
        fullLogMessage += "\(line) ➯ "

        print(fullLogMessage, msg)
    }

    public static func error(msg: Any, _ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function) {
        debug(msg: msg as Any, line, fileName, funcName, type: .ERROR)
    }

    public static func info(msg: Any, _ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function) {
        debug(msg: msg as Any, line, fileName, funcName, type: .INFO)
    }

    public static func mark(_ line: Int = #line, _ fileName: String = #file, _ funcName: String = #function) {
        debug(msg: "MARK", line, fileName, funcName, type: .MARK)
    }
}
