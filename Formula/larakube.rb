class Larakube < Formula
  desc "Kubernetes for Laravel — from development to deployment"
  homepage "https://larakube.luchtech.dev"
  version "0.21.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-arm"
      sha256 "0d09718491608514bf86e3f52e39b3fbaf1118ba16edb9d40f59fd4d8be408ee"
    end
    on_intel do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-x64"
      sha256 "a27e3472e20d069aa0aaf87c9f6e18521293ce91e8f3c23df126e6c4131100d3"
    end
  end

  def install
    if Hardware::CPU.arm?
      bin.install "larakube-mac-arm" => "larakube"
    else
      bin.install "larakube-mac-x64" => "larakube"
    end
  end

  def post_install
    config_dir = "#{Dir.home}/.larakube"
    config_file = "#{config_dir}/config.json"
    Dir.mkdir(config_dir) unless Dir.exist?(config_dir)
    unless File.exist?(config_file)
      File.write(config_file, %({"email": "email@example.com"}\n))
    end
  end

  def caveats
    <<~EOS
      LaraKube CLI requires Docker to run local Kubernetes clusters.
      If you don't have Docker installed: https://docs.docker.com/get-docker/

      Get started:
        larakube --version
        cd your-laravel-app && larakube init
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/larakube --version")
  end
end
