class Vcflib < Formula
  desc "Command-line tools for manipulating VCF files"
  homepage "https://github.com/ekg/vcflib"
  # tag "bioinformatics"

  url "https://github.com/ekg/vcflib/archive/v1.0.0-rc0.tar.gz"
  sha256 "c5236f9db068341d064e4ffc3d32ba942f7a371c81a4f43dc5a9d3ab47641ffd"
  head "https://github.com/ekg/vcflib.git"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "f7f3700673941a4db264a125a0b3e49dec3ec669039a0973fc93cd55954f9e24" => :el_capitan
    sha256 "92ade1c0f98fe701075ea9841cf74b7baef020e0a41f65b1bc063066104c2ffd" => :yosemite
    sha256 "52c6168b3a1ad58652ef6fd20af6fd9f8e07376226fa3bcd126fc4e8922ab7b7" => :mavericks
  end

  def install
    if OS.mac?
      # FIX => missing makefile var: https://github.com/ekg/tabixpp/issues/5
      inreplace "tabixpp/Makefile", "SUBDIRS=.", "SUBDIRS=.\nLOBJS=tabix.o"
      # FIX => ld: internal error: atom not found in symbolIndex(<snip>) for architecture x86_64
      inreplace "smithwaterman/Makefile", "LDFLAGS=-Wl,-s", "LDFLAGS="
    end

    system "make"

    bin.install Dir["bin/*"]
    doc.install %w[LICENSE README.md]
  end

  test do
    assert_match "genotype", shell_output("vcfallelicprimitives -h 2>&1", 0)
  end
end
