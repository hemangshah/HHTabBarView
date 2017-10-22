Pod::Spec.new do |s|
s.name             = 'HHTabBarView'
s.module_name      = 'HHTabBarView'
s.version          = '1.0.0'
s.summary          = 'A lightweight customized tabbar view. 📌'
s.description      = 'HHTabBarView is an easy to setup and use replacement of default tabbar.'
s.homepage         = 'https://github.com/hemangshah/HHTabBarView'
s.license          = 'MIT'
s.author           = { 'hemangshah' => 'hemangshah.in@gmail.com' }
s.source           = { :git => 'https://github.com/hemangshah/HHTabBarView.git', :tag => s.version.to_s }
s.platform     = :ios, '9.0'
s.requires_arc = true
s.source_files = '**/Source/*.swift'
end
