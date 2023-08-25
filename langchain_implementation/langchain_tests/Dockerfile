FROM python:3.9.12

RUN mkdir usr/app
WORKDIR usr/app

COPY . .

RUN pip install --upgrade pip install langchain openai tiktoken duckduckgo-search
RUN pip install -r requirements.txt

CMD python app.py