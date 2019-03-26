Pod::Spec.new do |s|
s.name = 'AFQuark'
s.version = '0.0.4'
s.license = 'MIT'
s.summary = 'A library to simplify iOS development in Swift.'
s.homepage = 'https://github.com/laurent68k/AFQuark'
s.authors = { 'Laurent Favard' => 'laurent68k.ios@gmail.com' }
s.source = { :git => 'https://github.com/laurent68k/AFQuark.git', :tag => s.version.to_s }
s.requires_arc = true
s.ios.deployment_target = '9.0'
s.tvos.deployment_target = '9.0'
s.source_files = 'AFQuark/AFQuark/*.swift'
s.ios.resources = ['AFQuark/**/*.xib']
s.tvos.resources = ['AFQuark/**/*.xcassets']
end
