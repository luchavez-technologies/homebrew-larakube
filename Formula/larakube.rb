class Larakube < Formula
  desc "Kubernetes for Laravel — from development to deployment"
  homepage "https://larakube.luchtech.dev"
  version "0.21.7"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-arm"
      sha256 "d9a774784bfb0fba3de695dc510c6971225ff2843073d14149ececc3bd32dfcd"
    end
    on_intel do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-x64"
      sha256 "5128153fdb6a609aa3f341de0ce592c58df4014e2ae62295ff034de99976e559"
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
