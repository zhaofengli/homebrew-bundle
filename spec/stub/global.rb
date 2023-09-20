# frozen_string_literal: true

HOMEBREW_PREFIX = Pathname("/usr/local").freeze
HOMEBREW_REPOSITORY = Pathname("/usr/local/Homebrew").freeze
HOMEBREW_LIBRARY = Pathname(HOMEBREW_REPOSITORY/"Library").freeze
HOMEBREW_BREW_FILE = Pathname(HOMEBREW_PREFIX/"bin/brew").freeze
HOMEBREW_VERSION = "2.6.0"

module Homebrew
  module_function

  def default_prefix?
    true
  end
end
