
import pytest
from app import app


@pytest.fixture
def client():
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


def test_pagina_inicial(client):
    resposta = client.get("/")
    assert resposta.status_code == 200


def test_pagina_empresas(client):
    resposta = client.get("/empresas")
    assert resposta.status_code == 200


def test_pagina_impostos(client):
    resposta = client.get("/impostos")
    assert resposta.status_code == 200
