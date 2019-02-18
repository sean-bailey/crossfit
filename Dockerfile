FROM python:3.7-alpine
ADD requirements.txt /app/requirements.txt
RUN pip install -r requirements.txt
ADD . /app
ENTRYPOINT ["python3" "lambda_function.py"]