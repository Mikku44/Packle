import requests
import numpy as np
from datetime import datetime
import os
import cv2
import cvzone
import matplotlib.pyplot  as plt
API_URL = "https://api-inference.huggingface.co/models/stabilityai/stable-diffusion-xl-base-1.0"
TOKEN = os.environ.get('HUG_TOKEN')
print(TOKEN)
headers = {"Authorization": f'{TOKEN}'}
# print(os.getcwd())
def image_resize(image, width = None, height = None, inter = cv2.INTER_AREA):
    # initialize the dimensions of the image to be resized and
    # grab the image size
    dim = None
    (h, w) = image.shape[:2]

    # print(height / float(h))

    # if both the width and height are None, then return the
    # original image
    if width is None and height is None:
        return image

    # check to see if the width is None
    if width is None:
        # calculate the ratio of the height and construct the
        # dimensions
        r = height / float(h) #type:ignore
        dim = (int(w * r), height)
        
       
    # otherwise, the height is None
    else:
        # calculate the ratio of the width and construct the
        # dimensions
        r = width / float(w)
        dim = (width, int(h * r))
        (h, w)  = dim


        

    # resize the image
    resized = cv2.resize(image, dim, interpolation = inter)#type:ignore
    # print(h , w)
    # print(h > w)
    # if(h < w):
    #     r = width / float(h) #type:ignore
    #     dim = (int(w * r), width)
    #     resized = cv2.resize(image, dim, interpolation = inter)#type:ignore
    # return the resized image
    return resized




def save_image(user_id,prompt,filename,mockup,logo=None,pos=None,Text=None):
    if Text == "None":
        Text = None
    if logo == "None":
        logo = None
    if pos == "None":
        pos = None
    def query(payload):
        response = requests.post(API_URL, headers=headers, json=payload)
        return response
    
    addOn = [' 1',' 2',' 3',' 4']
    i = 0
    while i < len(addOn):
        image_bytes = query({
            "inputs": prompt + addOn[i],
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
                path = os.path.join(f'./app_gen/static/app_gen/imgGen/{str(user_id)}/',str(date))
                os.mkdir(path)
            except:
                pass


            path = f'./app_gen/static/app_gen/imgGen/{user_id}/{date}/{filename}{addOn[i]}.png'
            path2 = f'./app_gen/static/app_gen/imgGen/{user_id}/{date}/{filename}{addOn[i]}_mockup.png'


            plt.imsave(path,image)
            create_mockup(path,path2,mockup,logo,pos,Text)
            i+=1
        else:
            print('Could not connect to server.')

# save_image('anda','mango with water spread and objects with green and yellow color pattern, artwork style')


def create_mockup(image,path,mockup,logo=None,pos=None,text=None):
    from PIL import Image,ImageDraw,ImageFont
    import matplotlib.pyplot as plt


   
    
    mockup_path = './app_gen/originMockup.jpg'
    bg_mockup_path = './app_gen/originMockup2.jpg'
    x =30
    y = 410
    if pos == 'top': 
        y =320
    elif pos == 'bottom':
        y = 530
    
    if mockup == 'TB':
        mockup_path = './app_gen/tall box.jpg'
        bg_mockup_path = './app_gen/tallBoxOrigin.jpg'
        x = 15
        y = 310
        shear = 0.08
        if pos == 'top': 
            y =50
            x = 80
            shear = -0.055
        elif pos == 'bottom':
            x = -10
            y = 450
            shear = 0.02

        

        mask = Image.open(mockup_path).convert('L')
        pattern = cv2.imread(image)
        pattern = cv2.cvtColor(pattern, cv2.COLOR_BGR2RGBA)
        src2 = Image.new("RGB", mask.size, 255)
       
        rows, cols, dim = pattern.shape
        M = np.float32([[1, -0.186,250], #  shear x ,pos x 0
              [-0.055, 1  ,100], #shear y , pos y 0.385
              [0, 0  , 1]]) # type: ignore

        pattern = cv2.warpPerspective(pattern,M,(int(cols*1),int(rows*1)))# type: ignore
       
        if logo is not None:
            M = np.float32([[1, 0,420], #  shear x ,pos x 0
            [shear, 1  ,100], #shear y , pos y 0.385
            [0, 0  , 1]]) # type: ignore
            logo = cv2.imread(logo,cv2.IMREAD_UNCHANGED)
            logo = cv2.cvtColor(logo, cv2.COLOR_BGR2RGBA)
            logo = image_resize(logo, width =110)
            logo = cv2.warpPerspective(logo,M,(int(cols*1),int(rows*2))) # type: ignore
            pattern = cvzone.overlayPNG(pattern,logo,[x,y])
            #make overlay
            patt_wlogo = cvzone.overlayPNG(pattern,logo,[x,y])
            src = Image.fromarray(patt_wlogo).resize(mask.size)
        else:
             src = Image.fromarray(pattern).resize(mask.size)

        mockup = Image.open(bg_mockup_path)
        mockup.paste(src,(0,0),mask=mask) # type: ignore
        # mockup.show()
        mockup.save(path)
        return
    
     
    elif mockup == 'MLB':
        mockup_path = './app_gen/milkmockup.png'
        bg_mockup_path = './app_gen/milkmockupOrigin.png'
  
        y = 410
        if pos == 'top': 
            y =250
        elif pos == 'bottom':
            y = 630

        mask = Image.open(mockup_path).convert('L')
        pattern = cv2.imread(image)
        pattern = cv2.cvtColor(pattern, cv2.COLOR_BGR2RGBA)
        src2 = Image.new("RGBA", mask.size, 0)
        rows, cols, dim = pattern.shape
        M = np.float32([[1, 0,380], #  shear x ,pos x 0
              [-0.055, 1  ,100], #shear y , pos y 0.385
              [0, 0  , 1]]) # type: ignore

        if logo is not None:
            logo = cv2.imread(logo,cv2.IMREAD_UNCHANGED)
            logo = cv2.cvtColor(logo, cv2.COLOR_BGR2RGBA)
            logo = image_resize(logo, width =130)
            logo = cv2.warpPerspective(logo,M,(int(cols*1),int(rows*2))) # type: ignore
            pattern = cvzone.overlayPNG(pattern,logo,[x,y])
            #make overlay
            patt_wlogo = cvzone.overlayPNG(pattern,logo,[x,y])
            src = Image.fromarray(patt_wlogo).resize(mask.size)
        else:
            src = Image.fromarray(pattern).resize(mask.size)

        mockup = Image.open(bg_mockup_path)
        mockup.paste(src,(0,0),mask=mask) # type: ignore
        # mockup.show()
        mockup.save(path)
        return
    
    elif mockup == 'FB':
        mockup_path = './app_gen/snackBag.jpg'
        bg_mockup_path = './app_gen/snackBagOrigin.jpg'

        x = 200
        y =250
        if pos == 'top':
            x = 200
            y =100
        elif pos == 'bottom':
            x = 200
            y = 400

        mask = Image.open(mockup_path).convert('L')
        pattern = cv2.imread(image)
        pattern = cv2.cvtColor(pattern, cv2.COLOR_BGR2RGBA)
        # src2 = Image.new("RGBA", mask.size, 0)
        # rows, cols, dim = pattern.shape
        # M = np.float32([[1, 0.8,600], #  shear x ,pos x
        #                 [-0.48, 1  ,600], #shear y , pos y
        #                 [0, 0  , 1]]) # type: ignore
        # #resize logo
        # if logo is not None:
        #     logo = cv2.imread(logo,cv2.IMREAD_UNCHANGED)
        #     logo = cv2.cvtColor(logo, cv2.COLOR_BGR2RGBA)
        #     logo = image_resize(logo, width = 350)
        #     pattern = cvzone.overlayPNG(pattern,logo,[x,y])
        img = cv2.imread(mockup_path)

        assert img is not None, "file could not be read, check with os.path.exists()"
        src2 = Image.new("RGBA", mask.size, 0)
        rows,cols,ch = img.shape

        tl = [861,813]
        bl = [1498,1562]
        tr = [1573,457]
        br = [2219,1234]

        # img = cv2.circle(img,tl,10,(0,0,0),50) #tl
        # img = cv2.circle(img,bl,10,(0,0,255),50)#bl
        # img = cv2.circle(img,tr,10,(255,0,0),50)#tr
        # img = cv2.circle(img,br,10,(0,255,0),50)#br

        pattern = cv2.resize(pattern,(br[0]-bl[0],bl[1]-tl[1])) #y x
        if logo is not None:
            logo = cv2.imread(logo,cv2.IMREAD_UNCHANGED)
            logo = cv2.cvtColor(logo, cv2.COLOR_BGR2RGBA)
            logo = image_resize(logo, width = 350)
            pattern = cvzone.overlayPNG(pattern,logo,[x,y])

         #TODO text
        if text is not None:
            text = text.replace(' ','\n')
            plain_image = Image.new("RGBA", mask.size, 0)
            d1 = ImageDraw.Draw(plain_image)
            myFont = ImageFont.truetype('./app_gen/fonts/MN MINI.ttf', 48)
            # text((x,y),text,font,fill,spacing,align='center')
            # y = 0 top y = 500 center y =200 bottom
            d1.text((0,0),text, font=myFont, fill =(0, 0, 0),align='left')
            text_plain_image = np.array(plain_image) 
            
            # plain_image.show()
            pattern = cvzone.overlayPNG(pattern,text_plain_image,[100,100])

        pts1 = np.float32([bl,br,tl,tr]) # type: ignore # tl ,bl,tr,br
        pts2 = np.float32([[0,300],[300,300],[0,0],[300,0]]) # type: ignore #bl tr tl br

        M =  cv2.getPerspectiveTransform(pts1,pts2) # type: ignore
        dst = cv2.warpPerspective(img,M,(300,300))


        pts2 = np.float32([[0,bl[1]-tl[1]],[br[0]-bl[0],bl[1]-tl[1]],[0,0],[br[0]-bl[0],0]]) # type: ignore #bl tr tl br
        M =  cv2.getPerspectiveTransform(pts2,pts1) # type: ignore

      
        # shear_pattern = cv2.warpPerspective(pattern,M,(int(cols*2.5),int(rows*1.6)))#type:ignore
        shear_pattern = cv2.warpPerspective(pattern,M,(img.shape[1],img.shape[0]))
        pil_pattern = Image.fromarray(shear_pattern).resize(mask.size)
        src = Image.composite(pil_pattern, src2, mask)

       
        mockup = Image.open(bg_mockup_path)
        mockup.paste(src,(0,0),mask=mask)
        # mockup.show()
        # plt.subplot(3,1,1)
        # plt.imshow(img) # type: ignore    
        # plt.subplot(3,1,2)
        # plt.imshow(shear_pattern) # type: ignore    
        # plt.subplot(3,1,2)
        # plt.imshow(pattern) # type: ignore    
        # plt.show()
        mockup.save(path)
        return

    # witout logo
    mask = Image.open(mockup_path).convert('L')
    src =Image.open(image).resize(mask.size)
    src2 = Image.new("RGBA", src.size, 0)

    #with logo
    pattern = cv2.imread(image)
    pattern = cv2.cvtColor(pattern, cv2.COLOR_BGR2RGBA)
    rows, cols, dim = pattern.shape
    # shear logo

    M = np.float32([[1, -0.02,500], #  shear x ,pos x 0
              [-0.275, 1.2  ,100], #shear y , pos y 0.385
              [0, 0  , 1]])#type:ignore
    #resize logo
    if logo is not None:
        logo = cv2.imread(logo,cv2.IMREAD_UNCHANGED)
        logo = cv2.cvtColor(logo, cv2.COLOR_BGR2RGBA)
        logo = image_resize(logo, width =140)
        logo = cv2.warpPerspective(logo,M,(int(cols*1),int(rows*2)))#type:ignore
        #make overlay
        pattern = cvzone.overlayPNG(pattern,logo,[x,y])
        
        
    
    #TODO text
    if text is not None:
        text = text.replace(' ','\n')
        img = Image.new("RGBA", mask.size, 0)
        d1 = ImageDraw.Draw(img)
        myFont = ImageFont.truetype('./app_gen/fonts/MN MINI.ttf', 48)
        # text((x,y),text,font,fill,spacing,align='center')
        # y = 0 top y = 100 center y =200 bottom
        d1.text((0,0),text, font=myFont, fill =(0, 0, 0),align='left')
        text_img = np.array(img) 
        text_img = cv2.warpPerspective(text_img,M,(int(cols*1),int(rows*2)))#type:ignore
        # img.show()

        pattern = cvzone.overlayPNG(pattern,text_img,[x,y])
    
    src = Image.fromarray(pattern).resize(mask.size)
    mockup = Image.open(bg_mockup_path)
    im = Image.composite(src, src2, mask)


    # with logo



    # plt.imshow(mockup)
    # plt.imshow(im)
    # plt.axis('off')
    # plt.show()
    mockup.paste(im,(0,0),mask=mask)
    # mockup.show()
    mockup.save(path)   #uncomment to save the file
    # return im


# create_mockup("./app_gen/static/app_gen/imgGen/1/171023/boxabstr213552.png")
# logo = cv2.imread('./app_gen/static/app_gen/imgGen/1/logo.png',cv2.IMREAD_UNCHANGED)
# image = image_resize(logo, width = 80)
# plt.imshow(image)
# plt.show()
# create_mockup("./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png","./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png",'FB',"./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png",'center')
# create_mockup("./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png","./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png",'','./app_gen/static/app_gen/imgGen/1/psu.png','bottom')
# create_mockup("./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png","./app_gen/static/app_gen/imgGen/1/171023/boxastro2130.png",'','./app_gen/static/app_gen/imgGen/1/psu.png','top')