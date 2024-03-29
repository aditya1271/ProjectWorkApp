# Always Remove pyobject from requirements.txt
from flask import Flask, render_template, url_for, request, redirect
from datetime import datetime
import pandas as pd
import nltk
import re
from nltk.tokenize import PunktSentenceTokenizer
from SPARQLWrapper import SPARQLWrapper,JSON
from bs4 import BeautifulSoup as bs
import pickle
import requests
import wikipedia
import networkx as nx
from googlesearch import search
import json
import requests
import urllib

#TODO Add this to to return data
def send_message():
    server = "https://fcm.googleapis.com/fcm/send"
    api_key = "AAAAgWFaEHE:APA91bHNcm5sJjbxpW-dH0TwidCeelBBR4LDyk4XSrmHgt9058rjCNubgD3vTT3On9-EW4pzlw4Z5jK9-wgf4-CGYLiAdgfJ37mb4w3qP_Q83InM1qLDqTuBtS3qQGA9bX3lZ44kSW4q"
    user_token = "dP70npWW5YA:APA91bEoN-XOGkIhcl4y6ZUEVzoQ3818cJ3LqJ7FbNHPeRRZ8zJp5fvj0lIqsIVj0Jm2XBYtiLTVlfXrFDkWYkFjp6xwLR1WQGxpMpDwu5ye-LuzPJKJ4-M3Boj5mt0-DwJdjsk16GIL"

    headers = {'Authorization': 'key=' + api_key}

    notification= {"body": "this is a body", "title": "this is a title" , "click_action": "FLUTTER_NOTIFICATION_CLICK"}
    data = {"click_action": "FLUTTERNOTIFICATIONCLICK", "id": "1", "status": "done"}
    payload = {"notification":notification,"data": data, "to": user_token}

    res = requests.post(server, headers=headers, json=payload)

    return res
print(send_message())

#import matplotlib.pyplot as plt
Graph={}
levels=3
#limit=""
list_of_nodes=[] #base nodes with inital names
renamed_nodes=[] #base nodes with wikidata names

app=Flask(__name__)

def data_to_list(data):

    pst = PunktSentenceTokenizer()
    data=data.decode('utf-8')
    tokenized_sentence = pst.tokenize(data)
    stringlist = []
    for i in tokenized_sentence:
      try:
        words = nltk.word_tokenize(i)
        tagged = nltk.pos_tag(words)
        chunkGram = r"""Chunk: {<JJ.?>{0,2}<VBG>{0,1}<NN.?>{1,2}<VBG>{0,1}<NN..?>{0,2}<VBG>{0,1}}"""
        chunkParser = nltk.RegexpParser(chunkGram)
        chunked = chunkParser.parse(tagged)
        #chunked.draw()
        stringlist.append(chunked.pformat().encode('ascii','ignore'))
      except Exception as e:
          print(str(e))
    #print(len(stringlist[1]))
    #String = stringlist[1]
    index = 0
    listoflist = []
    for f in stringlist:
     String = f
     #print(len(String))
     chunklist = []
     iter = re.finditer(r"\Chunk\b", String)
     indices = [m.start(0) for m in iter]
     #print(indices)
     for x in indices:
    #print(stringlist[1][x+5])#space
    #get the word from space till /
    #print(x)
      j=1
      temp =""
      while(stringlist[index][x+5+j]!=')'):
       temp = temp + stringlist[index][x+5+j]
       j = j+1
     # print(temp)
      chunklist.append(temp)
     index = index + 1
     listoflist.append(chunklist)
    #print(listoflist)
    for y in listoflist:
        for x in y:
            x=x.encode("utf-8")
            x=re.sub(r"/[A9595-Z][A-Z][A-Z]*","",x)
            x=re.sub(r"/"," ",x)
            x=re.sub(r"\n","",x)
            list_of_nodes.append(x)
def urls(word1,word2):
    list_urls=[]
    regex1='\W'+word1+'\W'
    regex2='\W'+word2+'\W'
    query='"'+word1+'" "'+word2+'"'
    #fout.write(word2+"\n")
    for url in search(query, tld='com', stop=10):
        if(url.find(".pdf",len(url)-5)==-1):
            test=1
            try:
                page=requests.get(url).text
            except :
                test=0
            if test!=0 :
                #fout.write(url)
                #fout.write("\n")
                #fout.write(str(len(re.findall(regex1, page ,  re.IGNORECASE) ) )  )
                #fout.write(" ")
                #fout.write(str(len(re.findall(regex2, page ,  re.IGNORECASE) ) )  )
                #fout.write("\n")
                list_urls.append(url)
    #TODO sort URLS
    return list_urls

def onotology(task_content,imageTag):
    def id_extractor(search_string):
        #print(type(wikipedia.search(search_string)))
        query=""
        try:
            query = wikipedia.search(search_string)[0]
        except :
            return "-1","-1"

        #print(query)
        new_string = ""
        for i in query:
            if i == " ":
                new_string = new_string + '_'
            else:
                new_string = new_string + i
        print(["New string",new_string])
        new_string = new_string.encode('ascii', 'ignore').decode('ascii').encode("utf-8")
        #new_string= str(new_string).encode('utf-8')
        print("Added to renamed_nodes {}".format(new_string))

        res = requests.get("https://en.wikipedia.org/wiki/"+new_string)
        soup = bs(res.text, "html.parser")
        wikidata = []
        for link in soup.find_all("a"):
            url = link.get("href", "")
            if "//www.wikidata.org/" in url:
                wikidata.append(url)
                #print(url)
        #print(wikidata)
        count = 0
        wikidata_id  = ""
        for i in wikidata[0]:
            if i == 'Q' or i == '1' or i == '2' or i =='0' or i =='3' or i == '4' or i == '5' or i == '6' or i == '7' or i == '8' or i == '9':
                wikidata_id = wikidata_id + i
        res = requests.get(wikidata[0])
        soup = bs(res.text, "html.parser")
        #print(soup)
        node=""
        for hit in soup.findAll(attrs={'class' : 'wikibase-title-label'}):
            node= hit.text
        #TODO dont use unicode
        # UnicodeWarning: Unicode equal comparison failed to convert both arguments to Unicode - interpreting them as being unequal
        #solve this ^^
        return wikidata_id.encode('ascii', 'ignore').decode('ascii').encode("utf-8"),node.encode('ascii', 'ignore').decode('ascii').encode("utf-8")


    def result_gen_children(prop,id):
        sparql = SPARQLWrapper("https://query.wikidata.org/sparql")
        q="""
        SELECT ?item ?itemLabel
        WHERE
        {
            ?item wdt:P361? wd:Q245652 .
            SERVICE wikibase:label { bd:serviceParam wikibase:language "en" }
        }
        """
        q=re.sub(r"Q245652",id,q)
        #q=re.sub(r"P361",prop,q)

        sparql.setQuery(q)

        sparql.setReturnFormat(JSON)
        results = sparql.query().convert()
        return results


    def result_gen_parent(prop,id):
        sparql = SPARQLWrapper("https://query.wikidata.org/sparql")
        q="""
        SELECT ?item ?itemLabel
        WHERE
        {
            wd:Q245652 wdt:P361? ?item   .
            SERVICE wikibase:label { bd:serviceParam wikibase:language "en" }
        }
        """
        q=re.sub(r"Q245652",id,q)
        sparql.setQuery(q)

        sparql.setReturnFormat(JSON)
        results = sparql.query().convert()
        return results


    def chilldren(node,id,level):
        if level==levels:
            return

        results = result_gen_children("P361",id)
        results_df = pd.io.json.json_normalize(results['results']['bindings'])

        if node not in Graph.keys():
            Graph[node]=[]
        if not results_df.empty:
            for x,y in zip(results_df["item.value"] , results_df["itemLabel.value"] ) :
                x=x.encode("utf-8")
                y=y.encode("utf-8")
                print(y)
                x=re.sub(r"http://www.wikidata.org/entity/","",x)
                if y not in Graph[node]:
                    if y!=node:
                        Graph[node].append(y)
                if y not in Graph:
                    chilldren(y,x,level+1)

    def parent(node,id,level):
        if level==levels:
            return

        results = result_gen_parent("P361",id)
        results_df = pd.io.json.json_normalize(results['results']['bindings'])

        if node not in Graph.keys():
            Graph[node]=[]
        if not results_df.empty:
            for x,y in zip(results_df["item.value"] , results_df["itemLabel.value"] ) :
                x=x.encode("utf-8")
                y=y.encode("utf-8")
                x=re.sub(r"http://www.wikidata.org/entity/","",x)
                print(y)
                if y not in Graph:
                    Graph[y]=[]
                    if y!=node:
                        Graph[y].append(node)
                    parent(y,x,level+1)
                else:
                    if y!=node:
                        Graph[y].append(node)
    def save_graph(filename):
        open(filename, 'w').close()
        fout=open(filename,"w")
        for x in Graph:
            #x=x.encode("utf-8")
            fout.write(x)
            fout.write("\n")
            for y in Graph[x]:
                #y=y.encode("utf-8")
                fout.write(y)
                fout.write("\n")
            fout.write("-1\n")
        fout.close()

    def load_graph():
        fin=open("graph.txt","r")
        lines=fin.readlines()
        is_key=True
        for x in lines:
            x=x.strip()
            if is_key:
                key=x
                is_key=False
                Graph[key]=[]
            else:
                if(x=="-1"):
                    is_key=True
                else:
                    Graph[key].append(x)
    def get_nodes():
        #TODO
        openfile=open("nodes.txt","r")
        t=openfile.readlines()
        for x in t:
            #print(x)
            x=x.encode("utf-8")
            x=re.sub(r"/[A-Z][A-Z][A-Z]*","",x)
            x=re.sub(r"/"," ",x)
            x=re.sub(r"\n","",x)
            list_of_nodes.append(x)
        list_of_nodes=list(dict.fromkeys(list_of_nodes))


    def Graph_gen():
        load_graph()
        print(len(Graph))
        for node in list_of_nodes:
            id,new_node=id_extractor(node)
            if len(id)!=0 and id!="-1":
                renamed_nodes.append(new_node)
                save_graph("prev_graph.txt")
                if new_node not in Graph:
                    #print("Here")
                    chilldren(new_node,id,0)
                    parent(new_node,id,0)
                    #print(Graph)
                    save_graph("graph.txt")
        print("DONE")

    data_to_list(task_content)
    print(list_of_nodes)
    Graph_gen()
    #Graph Appended/Created`
    id,new_node=id_extractor(imageTag)
    imageTag=new_node
    print("280 ",imageTag,type(imageTag),len(imageTag))
    if id!="-1" and len(id) !=0:
        save_graph("prev_graph.txt")
        if new_node not in Graph:
            #levels=2
            #print("Here")
            chilldren(new_node,id,0)
            parent(new_node,id,0)
            #print(Graph)
            save_graph("graph.txt")
    #levels=3
    #imagetag added to graph
    source = []
    target = []
    for x in Graph:
        for y in Graph[x]:
            if x!=y:
                source.append(x)
                target.append(y)
    kg_df = pd.DataFrame({'source':source, 'target':target})
    G=nx.from_pandas_edgelist(kg_df, "source", "target")
    print (renamed_nodes)
    print("Done form nx codeline 280",imageTag)
    ranking=[]
    if(id!="-1" and len(id)!=0):
        for node in renamed_nodes:
            val=0
            val1=0
            if node.strip()!="" :
                flag=1
                #print([id,imageTag,node])
                try:
                    val=nx.shortest_path_length(G,imageTag,node)
                except:
                    flag=0
                try:
                    val1=nx.shortest_path_length(G,node,imageTag)
                    if(flag==0 or val1<val):
                        val=val1
                except:
                    flag=0

                if(flag!=0):

                    ranking.append([val,node,urls(imageTag,node)])
                else:
                    print("Path to ",node," not found")
        print(ranking)
        ranking=sorted(ranking,key=lambda x: (x[0]))
        print("---------------")
        print(ranking)
    else:
        print("Image Tag Not Found")



@app.route('/', methods=['POST', 'GET'])
def index():
    if request.method == 'POST':
        #change to url after creating function
        imageTag=request.form['imageTag']
        #Perform depending which of them is empty
        # data = urllib.urlopen(requestform['dataUrl'])
        task_content = request.form['content']


        #print(task_content)
        #try:
        onotology(task_content, imageTag)
            #onotology()
        return redirect('/')
        #except:
            #return 'There was an issue adding your task'

    else:

        return render_template('index.html', tasks=renamed_nodes)



if __name__ == "__main__":
    app.run(debug=True)
