require 'json'

fabric_enabled = ENV['RCT_NEW_ARCH_ENABLED'] == '1'
ios_platform = fabric_enabled ? '12.4' : '11.0'

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))



Pod::Spec.new do |s|
  s.name             = 'RNFlashList'
  s.version          = package['version']
  s.summary          = package['description']
  s.homepage         = package['homepage']
  s.license          = package['license']
  s.author           = package['author']
  s.source           = { git: 'https://github.com/shopify/flash-list.git', tag: "v#{s.version}" }
  s.source_files     = 'ios/Sources/**/*'
  s.requires_arc     = true
  s.swift_version    = '5.0'
  s.platforms        = { :ios => ios_platform, :tvos => '12.0' }

  if defined?(install_modules_dependencies()) != nil
    install_modules_dependencies(s);
  else
    if fabric_enabled
      folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

      s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
      s.pod_target_xcconfig    = {
          "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
          "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
          "CLANG_CXX_LANGUAGE_STANDARD" => "c++17",
          'OTHER_SWIFT_FLAGS' => '-D RCT_NEW_ARCH_ENABLED',
      }

      s.dependency "React-RCTFabric"
      s.dependency "React-Codegen"
      s.dependency "RCT-Folly"
      s.dependency "RCTRequired"
      s.dependency "RCTTypeSafety"
      s.dependency "ReactCommon/turbomodule/core"
      s.ios.deployment_target = ios_platform
    else
      # Settings for non-fabric builds
      s.dependency "React-Core"

    end
  end

  # Tests spec
  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'ios/Tests/**/*'
    test_spec.framework = 'XCTest'
  end
end
