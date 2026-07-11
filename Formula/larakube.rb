class Larakube < Formula
  desc "Kubernetes for Laravel — from development to deployment"
  homepage "https://larakube.luchtech.dev"
  version "0.33.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-arm"
      sha256 "053de2d9bce8bd29d9724a73f6dc8ee8325d18c9e770cc4d39813334edaf1065"
    end
    on_intel do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-x64"
      sha256 "d5210ae25ff6f0e8ac62041349ad13772f3c949c7a915adaadf9712337fd0b2f"
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
