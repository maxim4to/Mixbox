import Bash
import Foundation
import CiFoundation
import Cocoapods
import Git
import Destinations
import SingletonHell

// Stupid implementation of xcodebuild derived from some stupid bash scripts
public final class XcodebuildImpl: Xcodebuild {
    private let bashExecutor: BashExecutor
    private let derivedDataPathProvider: DerivedDataPathProvider
    private let cocoapodsFactory: CocoapodsFactory
    private let repoRootProvider: RepoRootProvider
    private let environmentProvider: EnvironmentProvider
    
    public init(
        bashExecutor: BashExecutor,
        derivedDataPathProvider: DerivedDataPathProvider,
        cocoapodsFactory: CocoapodsFactory,
        repoRootProvider: RepoRootProvider,
        environmentProvider: EnvironmentProvider)
    {
        self.bashExecutor = bashExecutor
        self.derivedDataPathProvider = derivedDataPathProvider
        self.cocoapodsFactory = cocoapodsFactory
        self.repoRootProvider = repoRootProvider
        self.environmentProvider = environmentProvider
    }
    
    public func build(
        xcodebuildPipeFilter: String,
        projectDirectoryFromRepoRoot: String,
        action: XcodebuildAction,
        workspaceName: String,
        scheme: String,
        sdk: String?,
        destination: String?)
        throws
        -> XcodebuildResult
    {
        try prepareForBuilding()
        
        let derivedDataPath = derivedDataPathProvider.derivedDataPath()
        let projectDirectory = try repoRootProvider.repoRootPath() + "/" + projectDirectoryFromRepoRoot
        
        print("Building using xcodebuild...")
        
        try? FileManager.default.removeItem(atPath: derivedDataPath)
        try FileManager.default.createDirectory(atPath: derivedDataPath, withIntermediateDirectories: true, attributes: nil)
        
        let cocoapods = try cocoapodsFactory.cocoapods(projectDirectory: projectDirectory)
        
        try cocoapods.install()
        
        let args = xcodebuildArgs(
            action: action,
            workspaceName: workspaceName,
            scheme: scheme,
            sdk: sdk,
            destination: destination,
            derivedDataPath: derivedDataPath
        )
        
        let argsString = args.map { "\"\($0)\"" }.joined(separator: " ")
        
        try runXcodebuild(
            projectDirectory: projectDirectory,
            argsString: argsString,
            xcodebuildPipeFilter: xcodebuildPipeFilter
        )
        
        // TODO: Try to remove? I think it is outdated.
        _ = try? bashExecutor.executeOrThrow(
            command: """
            # Work around a bug when xcodebuild puts Build and Indexes folders to a pwd instead of dd/
            
            [ -d "Build" ] && echo "Moving Build/ -> \(derivedDataPath)/" && mv -f "Build" "\(derivedDataPath)" || true
            [ -d "Index" ] && echo "Moving Index/ -> \(derivedDataPath)/" && mv -f "Index" "\(derivedDataPath)" || true
            """,
            currentDirectory: projectDirectory
        )
        
        return XcodebuildResult(derivedDataPath: derivedDataPath)
    }
    
    private func runXcodebuild(
        projectDirectory: String,
        argsString: String,
        xcodebuildPipeFilter: String)
        throws
    {
        let bashResult = try bashExecutor.execute(
            command:
            """
            set -o pipefail
            xcodebuild \(argsString) | \(xcodebuildPipeFilter)
            """,
            currentDirectory: projectDirectory,
            environment: .current,
            stdoutDataHandler: { data in
                FileHandle.standardOutput.write(data)
            },
            stderrDataHandler: { data in
                FileHandle.standardError.write(data)
            }
        )
        
        let xcodebuildBugIndicatorString = "Failed to establish communication with the test runner"
        
        if bashResult.code != 0,
            let stdout = bashResult.stdout.utf8String(),
            stdout.contains(xcodebuildBugIndicatorString)
        {
            // This code should be uncommented if we knew what file descriptor is used in this error.
            
            // print("Found bug in Xcodebuild: \(xcodebuildBugIndicatorString), attempting to retry running xcodebuild.")
            //
            // _ = try bashExecutor.executeOrThrow(
            //     command:
            //     """
            //     set -o pipefail
            //     xcodebuild \(argsString) | \(xcodebuildPipeFilter)
            //     """,
            //     currentDirectory: projectDirectory
            // )
            
            // Checking if it is in stdout or stderr:
            print(
                """
                xcodebuildBugIndicatorString (\(xcodebuildBugIndicatorString)) is indeed \
                inside stdout of xcodebuild, uncomment code in XcodebuildImpl and remove this \
                code that was added to check if indicator is in stdout or stderr.
                """
            )
            throw NonZeroExitCodeBashError(
                bashResult: bashResult
            )
        } else {
            // Checking if it is in stdout or stderr:
            if let stderr = bashResult.stdout.utf8String(),
                stderr.contains(xcodebuildBugIndicatorString)
            {
                print(
                    """
                    xcodebuildBugIndicatorString (\(xcodebuildBugIndicatorString)) is inside \
                    stderr and not stdout! Correct the code accordingly.
                    """
                )
            }
            
            throw NonZeroExitCodeBashError(
                bashResult: bashResult
            )
        }
    }
    
    private func xcodebuildArgs(
        action: XcodebuildAction,
        workspaceName: String,
        scheme: String,
        sdk: String?,
        destination: String?,
        derivedDataPath: String)
        -> [String]
    {
        var args: [String] = [
            action.rawValue,
            "-workspace", "\(workspaceName).xcworkspace",
            "-scheme", scheme,
            "-derivedDataPath", derivedDataPath
        ]
        
        if let sdk = sdk {
            args.append(contentsOf: ["-sdk", sdk])
        }
        
        if let destination = destination {
            args.append(contentsOf: ["-destination", destination])
        }
        
        return args
    }
    
    private func prepareForBuilding() throws {
        try FileManager.default.createDirectory(
            atPath: try environmentProvider.getOrThrow(env: Env.MIXBOX_CI_REPORTS_PATH),
            withIntermediateDirectories: true,
            attributes: nil
        )
    }
}
