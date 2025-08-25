import io
import sys
import pytest
from src.main.python import app

def test_main_output(capsys):
    app.main()
    captured = capsys.readouterr()
    assert "Hello from Python + Gradle!" in captured.out
