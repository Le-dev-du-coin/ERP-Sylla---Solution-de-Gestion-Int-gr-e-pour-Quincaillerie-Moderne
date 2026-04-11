import pytest
from erp_sylla.apps.core.templatetags.erp_tags import money

class TestErpTemplateTags:
    def test_money_format_thousands(self):
        assert money(1500) == "1 500 F CFA"
        assert money(1000000) == "1 000 000 F CFA"

    def test_money_format_none(self):
        assert money(None) == "0 F CFA"

    def test_money_format_zero(self):
        assert money(0) == "0 F CFA"
