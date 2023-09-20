# frozen_string_literal: true

require "spec_helper"

describe Bundle do
  context "when the system call succeeds" do
    it "omits all stdout output if verbose is false" do
      expect { described_class.system "echo", "foo", verbose: false }.not_to output.to_stdout_from_any_process
    end

    it "emits all stdout output if verbose is true" do
      expect { described_class.system "echo", "foo", verbose: true }.to output("foo\n").to_stdout_from_any_process
    end
  end

  context "when the system call fails" do
    before do
      allow_any_instance_of(Process::Status).to receive(:success?).and_return(false)
    end

    it "emits all stdout output even if verbose is false" do
      expect { described_class.system "echo", "foo", verbose: false }.to output("foo\n").to_stdout_from_any_process
    end

    it "emits all stdout output only once if verbose is true" do
      expect { described_class.system "echo", "foo", verbose: true }.to output("foo\n").to_stdout_from_any_process
    end
  end

  context "when checking for homebrew/cask", :needs_macos do
    it "finds it when present" do
      allow(File).to receive(:directory?).with("#{HOMEBREW_PREFIX}/Caskroom").and_return(true)
      allow(File).to receive(:directory?)
        .with("#{HOMEBREW_LIBRARY}/Taps/homebrew/homebrew-cask")
        .and_return(true)
      expect(described_class.cask_installed?).to be(true)
    end
  end

  context "when checking for brew services", :needs_macos do
    it "finds it when present" do
      allow(described_class).to receive(:which).and_return(true)
      expect(described_class.services_installed?).to be(true)
    end
  end

  context "when checking for mas", :needs_macos do
    it "finds it when present" do
      allow(described_class).to receive(:which).and_return(true)
      expect(described_class.mas_installed?).to be(true)
    end
  end
end
