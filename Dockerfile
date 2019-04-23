FROM python:2.7-alpine
ADD requirements.txt /app/requirements.txt
ADD lambda_function.py /app/lambda_function.py
RUN pip install -r /app/requirements.txt
ADD . /app
ENTRYPOINT ["python", "/app/lambda_function.py"]
