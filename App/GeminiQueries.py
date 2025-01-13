import pathlib
import textwrap

import google.generativeai as genai

from neo4j import GraphDatabase
from IPython.display import display
from IPython.display import Markdown

language = "spanish"
genai.configure(api_key="AIzaSyAPIE9FPv10gazy5DqNcejoKVLyVGFF8PM")
model = genai.GenerativeModel("gemini-1.5-flash")

prompt2 = ("Greetings, you are an AI dedicated to summarizing the descriptions of some Steam games. You will receive some text data and after the word Description: " 
    +"you will summarize whatever follows into a 100 word paragraph, roughly. The rest of the text and its format must remain intact. Also you will translate all the text to "+language+" " 
    +"if it's not already in that language. Finally, please try to avoid copyrighted material. Here's the text you'll work on: ")

def trimQuery(s):
    ind1 = s.find('\n')
    ind2 = s.rfind('\n')
    s2 = s[ind1+1:ind2]
    s2 = s2[:s2.rfind('\n')]
    return s2

def to_markdown(text):
    text = text.replace("•", "  *")
    return Markdown(textwrap.indent(text, "", predicate=lambda _: True))

def makeQueryAI(request):
    request.replace('\n', ' ')

    with open("App\promptInicial.txt", 'r') as file:
        prompt = file.read().replace('\n', ' ')+request

    response = model.generate_content(prompt)
    text = to_markdown(response.text)
    query = trimQuery(text.data)

    print(query)
    return query

def formatGameInfo(text):
    try:
        response = model.generate_content(prompt2+text)
        text = to_markdown(response.text)
        result = text.data
    except Exception as e:
        print(e)
        return e
    
    return result
