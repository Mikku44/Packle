import requests
import numpy as np
from datetime import datetime
import os
API_URL = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0"
TOKEN = os.environ.get('HUG_TOKEN')
print(TOKEN)
headers = {"Authorization": f'{TOKEN}'}



def save_image(user_id,prompt,filename):
    def query(payload):
        response = requests.post(API_URL, headers=headers, json=payload)
        return response
    image_bytes = query({
        "inputs": prompt,
    })
    print((image_bytes))

    if image_bytes.ok:
        import io
        from PIL import Image
        import matplotlib.pyplot as plt
        image = Image.open(io.BytesIO(image_bytes.content))
        image = np.asarray(image)

        date = datetime.now()
        date = date.strftime("%d%m%y")

        try:
            path = os.path.join(f'./app_gen/static/app_gen/imgGen/',str(user_id))
            os.mkdir(path)
        except:
            pass
        try:
            path = os.path.join(f'./app_gen/static/app_gen/imgGen/{str(user_id)}/',str(date))
            os.mkdir(path)
        except:
            pass


        path = f'./app_gen/static/app_gen/imgGen/{user_id}/{date}/{filename}.png'
        plt.imsave(path,image)
    else:
        print('Could not connect to server.')

# save_image('anda','mango with water spread and objects with green and yellow color pattern, artwork style')