import Cuckoo
import MixboxUiTestsFoundation

public class MockStubRequestBuilder: StubRequestBuilder, Cuckoo.ProtocolMock {

    public typealias MocksType = StubRequestBuilder

    public typealias Stubbing = __StubbingProxy_StubRequestBuilder
    public typealias Verification = __VerificationProxy_StubRequestBuilder

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: StubRequestBuilder?

    public func enableDefaultImplementation(_ stub: StubRequestBuilder) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    public func withRequestStub(urlPattern: String, httpMethod: HttpMethod?) -> StubResponseBuilder {

    return cuckoo_manager.call("withRequestStub(urlPattern: String, httpMethod: HttpMethod?) -> StubResponseBuilder",
            parameters: (urlPattern, httpMethod),
            escapingParameters: (urlPattern, httpMethod),
            superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.withRequestStub(urlPattern: urlPattern, httpMethod: httpMethod))

    }

    public func removeAllStubs()  {

    return cuckoo_manager.call("removeAllStubs()",
            parameters: (),
            escapingParameters: (),
            superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeAllStubs())

    }

	public struct __StubbingProxy_StubRequestBuilder: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func withRequestStub<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(urlPattern: M1, httpMethod: M2) -> Cuckoo.ProtocolStubFunction<(String, HttpMethod?), StubResponseBuilder> where M1.MatchedType == String, M2.OptionalMatchedType == HttpMethod {
	        let matchers: [Cuckoo.ParameterMatcher<(String, HttpMethod?)>] = [wrap(matchable: urlPattern) { $0.0 }, wrap(matchable: httpMethod) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStubRequestBuilder.self, method: "withRequestStub(urlPattern: String, httpMethod: HttpMethod?) -> StubResponseBuilder", parameterMatchers: matchers))
	    }
	    
	    func removeAllStubs() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockStubRequestBuilder.self, method: "removeAllStubs()", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_StubRequestBuilder: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func withRequestStub<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable>(urlPattern: M1, httpMethod: M2) -> Cuckoo.__DoNotUse<(String, HttpMethod?), StubResponseBuilder> where M1.MatchedType == String, M2.OptionalMatchedType == HttpMethod {
	        let matchers: [Cuckoo.ParameterMatcher<(String, HttpMethod?)>] = [wrap(matchable: urlPattern) { $0.0 }, wrap(matchable: httpMethod) { $0.1 }]
	        return cuckoo_manager.verify("withRequestStub(urlPattern: String, httpMethod: HttpMethod?) -> StubResponseBuilder", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeAllStubs() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("removeAllStubs()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class StubRequestBuilderStub: StubRequestBuilder {

    public func withRequestStub(urlPattern: String, httpMethod: HttpMethod?) -> StubResponseBuilder  {
        return DefaultValueRegistry.defaultValue(for: (StubResponseBuilder).self)
    }

    public func removeAllStubs()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }

}

import Cuckoo
import MixboxUiTestsFoundation

import MixboxIpcCommon

public class MockStubResponseBuilder: StubResponseBuilder, Cuckoo.ProtocolMock {

    public typealias MocksType = StubResponseBuilder

    public typealias Stubbing = __StubbingProxy_StubResponseBuilder
    public typealias Verification = __VerificationProxy_StubResponseBuilder

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: StubResponseBuilder?

    public func enableDefaultImplementation(_ stub: StubResponseBuilder) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    public func withResponse(value: StubResponseBuilderResponseValue, variation: URLResponseProtocolVariation, responseTime: TimeInterval)  {

    return cuckoo_manager.call("withResponse(value: StubResponseBuilderResponseValue, variation: URLResponseProtocolVariation, responseTime: TimeInterval)",
            parameters: (value, variation, responseTime),
            escapingParameters: (value, variation, responseTime),
            superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.withResponse(value: value, variation: variation, responseTime: responseTime))

    }

	public struct __StubbingProxy_StubResponseBuilder: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func withResponse<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(value: M1, variation: M2, responseTime: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(StubResponseBuilderResponseValue, URLResponseProtocolVariation, TimeInterval)> where M1.MatchedType == StubResponseBuilderResponseValue, M2.MatchedType == URLResponseProtocolVariation, M3.MatchedType == TimeInterval {
	        let matchers: [Cuckoo.ParameterMatcher<(StubResponseBuilderResponseValue, URLResponseProtocolVariation, TimeInterval)>] = [wrap(matchable: value) { $0.0 }, wrap(matchable: variation) { $0.1 }, wrap(matchable: responseTime) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStubResponseBuilder.self, method: "withResponse(value: StubResponseBuilderResponseValue, variation: URLResponseProtocolVariation, responseTime: TimeInterval)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_StubResponseBuilder: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func withResponse<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(value: M1, variation: M2, responseTime: M3) -> Cuckoo.__DoNotUse<(StubResponseBuilderResponseValue, URLResponseProtocolVariation, TimeInterval), Void> where M1.MatchedType == StubResponseBuilderResponseValue, M2.MatchedType == URLResponseProtocolVariation, M3.MatchedType == TimeInterval {
	        let matchers: [Cuckoo.ParameterMatcher<(StubResponseBuilderResponseValue, URLResponseProtocolVariation, TimeInterval)>] = [wrap(matchable: value) { $0.0 }, wrap(matchable: variation) { $0.1 }, wrap(matchable: responseTime) { $0.2 }]
	        return cuckoo_manager.verify("withResponse(value: StubResponseBuilderResponseValue, variation: URLResponseProtocolVariation, responseTime: TimeInterval)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class StubResponseBuilderStub: StubResponseBuilder {

    public func withResponse(value: StubResponseBuilderResponseValue, variation: URLResponseProtocolVariation, responseTime: TimeInterval)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }

}

import Cuckoo
import MixboxUiTestsFoundation

public class MockScreenshotTaker: ScreenshotTaker, Cuckoo.ProtocolMock {

    public typealias MocksType = ScreenshotTaker

    public typealias Stubbing = __StubbingProxy_ScreenshotTaker
    public typealias Verification = __VerificationProxy_ScreenshotTaker

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    private var __defaultImplStub: ScreenshotTaker?

    public func enableDefaultImplementation(_ stub: ScreenshotTaker) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }

    public func takeScreenshot() -> UIImage? {

    return cuckoo_manager.call("takeScreenshot() -> UIImage?",
            parameters: (),
            escapingParameters: (),
            superclassCall:

                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.takeScreenshot())

    }

	public struct __StubbingProxy_ScreenshotTaker: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func takeScreenshot() -> Cuckoo.ProtocolStubFunction<(), UIImage?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockScreenshotTaker.self, method: "takeScreenshot() -> UIImage?", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_ScreenshotTaker: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func takeScreenshot() -> Cuckoo.__DoNotUse<(), UIImage?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("takeScreenshot() -> UIImage?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class ScreenshotTakerStub: ScreenshotTaker {

    public func takeScreenshot() -> UIImage?  {
        return DefaultValueRegistry.defaultValue(for: (UIImage?).self)
    }

}
