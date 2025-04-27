# ベースイメージは軽めなPython公式
FROM python:3.10-slim

# 作業ディレクトリ作成
WORKDIR /app

# 必要なPythonパッケージをインストール
COPY requirements.txt .
RUN python3 -m venv venv
RUN ./venv/bin/pip install --upgrade pip
RUN ./venv/bin/pip install --no-cache-dir -r requirements.txt
RUN mkdir -p /app/models && ./venv/bin/python3 -c "import whisper; whisper.load_model('tiny', download_root='/app/models')"


# アプリコードをコピー
COPY app.py .


# ポートを開ける
EXPOSE 8000

# コンテナ起動時にアプリを実行
CMD ["./venv/bin/uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
