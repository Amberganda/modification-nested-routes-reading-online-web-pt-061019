module Bootsnap
  module CompileCache
    def self.setup(cache_dir:, iseq:, yaml:)
      if iseq
        if supported?
          require_relative('compile_cache/iseq')
          Bootsnap::CompileCache::ISeq.install!(cache_dir)
        elsif $VERBOSE
          warn("[bootsnap/setup] bytecode caching is not supported on this implementation of Ruby")
        end
      end

      if yaml
        if supported?
          require_relative('compile_cache/yaml')
          Bootsnap::CompileCache::YAML.install!(cache_dir)
        elsif $VERBOSE
          warn("[bootsnap/setup] YAML parsing caching is not supported on this implementation of Ruby")
        end
      end
    end

    def self.supported?
      # only enable on 'ruby' (MRI), POSIX (darwin, linux, *bsd), and >= 2.3.0
      RUBY_ENGINE == 'ruby' &&
      RUBY_PLATFORM =~ /darwin|linux|bsd/ &&
      Gem::Version.new(RUBY_VERSION) >= Gem::Version.new("2.3.0")
    end
  end
end
