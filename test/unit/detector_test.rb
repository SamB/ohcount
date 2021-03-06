require File.dirname(__FILE__) + '/../test_helper'
include Ohcount

# DetectorTest covers all Detector scenarios.
#
# The directory <tt>test/detect_files</tt> contains test files for the detector.
# These files are not used in parser testing; they are strictly for detection.
#
# ==== Manual Testing
#
# To manually test an addition to the detector, rebuild ohcount and run it against
# your test file:
#
#   rake
#   bin/ohcount --detect test/detect_files/my_file.ext
#
# If the detector is working, you should see the name of your expected language:
#
#   my_language  test/detect_files/my_file.ext
#
class Ohcount::DetectorTest < Ohcount::Test

	def do_detect(filename, filenames = [])
    file_location = File.dirname(__FILE__) + "/../detect_files/" + filename
    sfc = Ohcount::SimpleFileContext.new(filename, filenames, nil, file_location)
		Ohcount::Detector.detect(sfc)
	end

	def test_matlab_or_objective_c
		assert_equal 'objective_c', do_detect("t1.m")
		assert_equal 'objective_c', do_detect("t2.m")
	end

	def text_fortran_fixedfree
		assert_equal 'fortranfixed', do_detect("fortranfixed.f")
		assert_equal 'fortranfree', do_detect("fortranfree.f")
	end

	def test_detect_polyglot
		assert_equal "c", do_detect("foo.c")
		assert_equal "c", do_detect("foo.c")
		assert_equal "c", do_detect("uses_no_cpp.h")
		assert_equal "cpp", do_detect("uses_cpp_headers.h")
		assert_equal "cpp", do_detect("uses_cpp_stdlib_headers.h")
		assert_equal "cpp", do_detect("uses_cpp_keywords.h")
		assert_equal "ruby", do_detect("foo.rb")
		assert_equal "make", do_detect("foo.mk")
    assert_equal "matlab", do_detect("foo_matlab.m", ["foo_matlab.m", "bar.m", "README"])
		assert_equal "objective_c", do_detect("foo_objective_c.m", ["foo_objective_c.m", "bar.h", "README"])
		assert_equal "objective_c", do_detect("foo_objective_c.h", ["foo_objective_c.h, different_than_foo.m"])
		assert_equal "php", do_detect("upper_case_php")
		assert_equal "smalltalk", do_detect("example.st")
		assert_equal "vala", do_detect("foo.vala")
		assert_equal "tex", do_detect("foo.tex")
		assert_equal "xslt", do_detect("example.xsl")
		assert_equal "lisp", do_detect("core.lisp")
		assert_equal "dmd", do_detect("foo.d")
		assert_equal "vim", do_detect("foo.vim")
		assert_equal "ebuild", do_detect("foo.ebuild")
		assert_equal "ebuild", do_detect("foo.eclass")
		assert_equal "exheres", do_detect("foo.exheres-0")
		assert_equal "exheres", do_detect("foo.exlib")
	end

	def test_upper_case_extensions
		assert_equal "cpp", do_detect("foo_upper_case.C")
		assert_equal "ruby", do_detect("foo_upper_case.RB")
	end

  def test_no_extensions
    assert_equal "python", do_detect("py_script", [])
    assert_equal "ruby", do_detect("ruby_script", [])
    assert_equal "shell", do_detect("bourne_again_script", [])
    assert_equal "shell", do_detect("bash_script", [])
    assert_equal "perl", do_detect("perl_w", [])
    assert_equal "dmd", do_detect("d_script", [])
  end

	def test_by_filename
		assert_equal "autoconf", do_detect("configure.ac")
		assert_equal "autoconf", do_detect("configure.in")
		assert_equal "automake", do_detect("Makefile.am")
		assert_equal "make", do_detect("Makefile")
	end

  def test_csharp_or_clearsilver
		assert_equal 'csharp', do_detect("cs1.cs")
		assert_equal 'clearsilver_template', do_detect("clearsilver_template1.cs")
  end

end

