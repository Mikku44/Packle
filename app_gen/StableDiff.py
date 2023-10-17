#ใช้ได้แล้ว
from diffusers import StableDiffusionPipeline,DiffusionPipeline
import torch
import matplotlib.pyplot as plt
from datetime import datetime
import os
def genImg(username,prompt):
    date = datetime.now()
    date = date.strftime("%d%m%y")

    try:
        path = os.path.join(f'./app_gen/static/app_gen/imgGen/',str(username))
        os.mkdir(path)
    except:
        pass
    try:
        path = os.path.join(f'./app_gen/static/app_gen/imgGen/{str(username)}/',str(date))
        os.mkdir(path)
    except:
        pass

    # model_id = "prompthero/openjourney"
    model_id = "prompthero/openjourney-v4"
    # model_id = "stabilityai/stable-diffusion-xl-base-1.0"
    # pipe = StableDiffusionPipeline.from_pretrained(model_id, torch_dtype=torch.float16)
    pipe = StableDiffusionPipeline.from_pretrained(model_id, torch_dtype=torch.float16)
    pipe = pipe.to("cuda")
    # pipe.enable_model_cpu_offload()

    # prompt = "retro serie of different cars with different colors and shapes, mdjrny-v4 style"

    
    filename = prompt[0:]
    # image = pipe(prompt,num_inference_steps=10,num_images_per_prompt=1)

    image = pipe(
    prompt=prompt,
    num_inference_steps=2,
    )
    plt.imshow(image.images[0])

    
    image.images[0].save(f'./app_gen/static/app_gen/imgGen/{username}/{date}/{filename}.png')

def sysTes(username):
    date = datetime.now()
    date = date.strftime("%d%m%y")
    try:
        path = os.path.join(f'./app_gen/static/app_gen/imgGen/',str(username))
        os.mkdir(path)
    except:
        pass
    try:
        path = os.path.join(f'./app_gen/static/app_gen/imgGen/{str(username)}/',str(date))
        os.mkdir(path)
    except:
        pass
    # try:
    # except:
    #     pass

if __name__ == '__main__':
    genImg('John','orange juice package with orange and black color')
    # sysTes('anda')