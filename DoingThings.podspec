require 'json'

# Returns the version number for a package.json file
pkg_version = lambda do |dir_from_root = '', version = 'version'|
  path = File.join(__dir__, dir_from_root, 'package.json')
  JSON.parse(File.read(path))[version]
end

# Let the main package.json decide the version number for the pod
doingThings_version = pkg_version.call
# Use the same RN version that the JS tools use
react_native_version = pkg_version.call('node_modules/react-native')

Pod::Spec.new do |s|
  s.name             = 'DoingThings'
  s.version          = doingThings_version
  s.summary          = 'application that do things'
  s.description      = "application that do things a lot"
  s.homepage         = 'https://github.com/daferpi/DoingThings'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'orta' => 'orta.therox@gmail.com' }
  s.source           = { git: 'https://github.com/daferpi/DoingThings.git', tag: s.version.to_s }

  s.source_files   = 'Pod/Classes/**/*.{h,m}'
  s.resources      = 'Pod/Assets/{DoingThings.js,assets}'
  s.platform       = :ios, '8.0'

  # React is split into a set of subspecs, these are the essentials
  s.dependency 'React/Core', react_native_version
  s.dependency 'React/CxxBridge', react_native_version
  s.dependency 'React/RCTAnimation', react_native_version
  s.dependency 'React/RCTImage', react_native_version
  s.dependency 'React/RCTLinkingIOS', react_native_version
  s.dependency 'React/RCTNetwork', react_native_version
  s.dependency 'React/RCTText', react_native_version

  # React's dependencies
  s.dependency 'yoga', "#{react_native_version}.React"
  podspecs = [
    'node_modules/react-native/third-party-podspecs/DoubleConversion.podspec',
    'node_modules/react-native/third-party-podspecs/Folly.podspec',
    'node_modules/react-native/third-party-podspecs/glog.podspec'
  ]
  podspecs.each do |podspec_path|
    spec = Pod::Specification.from_file podspec_path
    s.dependency spec.name, "#{spec.version}"
  end
end