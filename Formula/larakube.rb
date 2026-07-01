class Larakube < Formula
  desc "Kubernetes for Laravel — from development to deployment"
  homepage "https://larakube.luchtech.dev"
  version "0.21.22"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-arm"
      sha256 "2e3e788a226b0b59beea13486ff9b6de41231336dcdb1ef63b523ff222621881"
    end
    on_intel do
      url "https://github.com/luchavez-technologies/larakube-cli/releases/download/v#{version}/larakube-mac-x64"
      sha256 "5ea8792dd49e00dfae7d6210997f56d66671f8aea228c4e0cb7b1e7ff120cdc6"
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
