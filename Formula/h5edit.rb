class H5edit < Formula
  desc "Edit attributes of HDF5 files"
  homepage "https://support.hdfgroup.org/projects/jpss/h5edit_index.html"
  url "https://support.hdfgroup.org/ftp/HDF5/projects/jpss/h5edit/h5edit-1.3.1.tar.gz"
  sha256 "57e2cc7cd67af82614e51064ee969ffa0a5328b8c58c4ed7085db32a8d99acef"

  depends_on "hdf5"

  def install
    inreplace "src/misc.c",
      "int opendatafile(const char *name)",
      "hid_t opendatafile(const char *name)"
    system "./configure",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--disable-silent-rules",
      "--prefix=#{prefix}"
    system "make", "install", "LIBS=-lhdf5_hl -lhdf5"
  end

  test do
    assert_match "Usgae", shell_output("#{bin}/h5edit --version")
  end
end
