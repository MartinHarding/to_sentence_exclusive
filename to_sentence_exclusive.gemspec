# frozen_string_literal: true

require_relative "lib/to_sentence_exclusive/version"

Gem::Specification.new do |spec|
  spec.name          = "to_sentence_exclusive"
  spec.version       = ToSentenceExclusive::VERSION
  spec.authors       = ["Martin Harding"]
  spec.email         = ["martin@martinharding.com"]

  spec.summary       = "Convert arrays to sentences as an exclusive list."
  spec.description   = "Converts the array to a comma-separated sentence where the last element is joined by the connector word."
  spec.homepage      = "https://github.com/martinharding/to_sentence_exclusive"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/martinharding/to_sentence_exclusive.git"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
