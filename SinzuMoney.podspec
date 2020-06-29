Pod::Spec.new do |spec|

  spec.name         = "SinzuMoney"
  spec.version      = "0.1.2"
  spec.summary      = "This is a simple type-safe representation of a Monetary"

  spec.description  = <<-DESC
A precise, type-safe representation of monetary amounts in a given currency.
                   DESC

  spec.homepage     = "https://github.com/moderateepheezy/SinzuMoney"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Afees Lawal" => "moderateepheezy@gmail.com" }

  spec.ios.deployment_target = "12.1"
  spec.swift_version = "5.1"

  spec.source        = { :git => "https://github.com/moderateepheezy/SinzuMoney.git", :tag => "#{spec.version}" }
  spec.source_files  = "SinzuMoney/**/*.{h,m,swift}"

end
