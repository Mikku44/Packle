import requests
import numpy as np
from datetime import datetime
import os
API_URL = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0"
TOKEN = os.environ.get('HUG_TOKEN')
print(TOKEN)
headers = {"Authorization": f'{TOKEN}'}



def save_image(user_id,prompt,filename,mockup):
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
        path2 = f'./app_gen/static/app_gen/imgGen/{user_id}/{date}/{filename}_mockup.png'


        plt.imsave(path,image)
        create_mockup(path,path2,mockup)
        
    else:
        print('Could not connect to server.')

# save_image('anda','mango with water spread and objects with green and yellow color pattern, artwork style')


def create_mockup(image,path,mockup):
    from PIL import Image
    import matplotlib.pyplot as plt

    
    mockup_path = './app_gen/originMockup.jpg'
    bg_mockup_path = './app_gen/originMockup2.jpg'
    if mockup == 'TB':
        mockup_path = './app_gen/tall box.jpg'
        bg_mockup_path = './app_gen/tallBoxOrigin.jpg'
    elif mockup == 'MLB':
        mockup_path = './app_gen/mailingBoxmockup.png'
        bg_mockup_path = './app_gen/mailingBoxmockup.jpg'
    elif mockup == 'FB':
        mockup_path = './app_gen/flatboxMockup.png'
        bg_mockup_path = './app_gen/flatboxMockup.png'


    mask = Image.open(mockup_path).convert('L')
    src =Image.open(image).resize(mask.size)
    src2 = Image.new("RGBA", src.size, 0)
    mockup = Image.open(bg_mockup_path)
    im = Image.composite(src, src2, mask)

    # plt.imshow(mockup)
    # plt.imshow(im)
    # plt.axis('off')
    # plt.show()
    mockup.paste(im,(0,0),mask=mask)
    mockup.show()
    mockup.save(path)
    # return im


# create_mockup("./app_gen/static/app_gen/imgGen/1/171023/boxabstr213552.png")