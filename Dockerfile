# ベースイメージは軽めなPython公式
FROM python:3.10-slim

# 作業ディレクトリ作成
WORKDIR /app

# 必要なPythonパッケージをインストール
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# アプリコードをコピー
COPY app.py .

# ポートを開ける
EXPOSE 8000

# コンテナ起動時にアプリを実行
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
