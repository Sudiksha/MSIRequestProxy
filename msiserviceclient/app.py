from flask import Flask
from flask import request
import json
import sys
import requests

app = Flask(__name__)

#
# for testing purpose, always hardcoded the following Url and header 
# for any MSI requests
#
mdUrl = "http://169.254.169.254/metadata/instance?api-version=2017-04-02"
header = {'Metadata':'True'}

@app.route("/")
def hello():
    print("HTTP request: from client:" + request.headers.get('X-Forwarded-For'))
    
#    header2=request.headers 
#    print(header2)
#    print("url:")
#    print(request.url)

    r=requests.get(url=mdUrl, headers=header)
    print("returned from 169.254.169.254 endpoint ...") 
    return r.text
  
if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)