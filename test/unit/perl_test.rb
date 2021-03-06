require File.dirname(__FILE__) + '/../test_helper'

class Ohcount::PerlTest < Ohcount::Test
	def test_comments
		lb = [Ohcount::LanguageBreakdown.new("perl", "", "#comment", 0)]
		assert_equal lb, Ohcount::parse(" #comment", "perl")
	end

	def test_perl_in_cgi
		verify_parse("perl.cgi")
	end

	def test_comprehensive
		verify_parse("perl1.pl")
	end

	def test_comprehensive
		verify_parse("perl_module.pm")
	end
end
