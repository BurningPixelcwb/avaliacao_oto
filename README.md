# avaliacao_oto
Scripts para avaliação OTO

O servidor de mysql usado para o teste foi o XAMPP

Link para download: https://www.apachefriends.org/download_success.html

Após baixar e instalar o xampp, basta executa-lo e ligar o servidor mysql

Quando ligar o servidor mysql, acesse o CMD e rode os comandos abaixo.

--------- Criar um ambiente virtual ---------

python -m venv venv_oto


--------- Levantando ambiente virtual ---------

venv_oto\Scripts\activate


--------- Instalando dependencias ---------

pip install -r avaliacao_oto\requirements.txt


--------- Rodando ---------

cd avaliacao_oto

python index.py
