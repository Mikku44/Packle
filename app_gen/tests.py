from time import sleep
from django.test import TestCase
from nltk.tokenize import sent_tokenize 
# Create your tests here.
import requests
import numpy as np
from datetime import datetime
import os


img = []
prompt = "Astronaut riding a colour horse  in the Amazon"

def save_image(prompt):
        
        API_URL = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0"
        TOKEN = os.environ.get('HUG_TOKEN')
        print(TOKEN)
        headers = {"Authorization": f'{TOKEN}'}

        # prompt = sent_tokenize('Astronaut riding a colour horse  in the Amazon')
       
        def query(payload):
            response = requests.post(API_URL, headers=headers, json=payload)
            # print(response)
            return response
    
   
        image_bytes = query({
            "inputs": prompt,
        
        })
        # print((image_bytes))

        if image_bytes.ok:
            import io
            from PIL import Image
            import matplotlib.pyplot as plt
            print((image_bytes.content))
            # image = Image.open(io.BytesIO(image_bytes.content))
            # img.append(image)
            # # image = np.asarray(image)
            # image.show()

            
            # plt.imshow("title",image)
            # plt.show()


# save_image(prompt)
# sleep(2)
# save_image(str(prompt.split(" ")[2:6]))


