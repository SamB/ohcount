# This has been shamelessly copied from java_test.rb because my Ruby is not so
# good and I don't really know what people expect from a Ohcount language test
#  -- Reinier Lamers 2008-01-19
# Ditto from haskell_test.rb
#  -- Samuel Bronson 2008-06-14
require File.dirname(__FILE__) + '/../test_helper'

class Ohcount::OcamlTest < Ohcount::Test
	def test_comments
		lb = [Ohcount::LanguageBreakdown.new("ocaml", "", "(* comment *)", 0)]
		assert_equal lb, Ohcount::parse("(* comment *)", "ocaml")
	end

	def test_comprehensive
		verify_parse("ocaml1.ml")
	end
end
