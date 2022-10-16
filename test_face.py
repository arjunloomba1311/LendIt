# This is a demo of running face recognition on a Raspberry Pi.
# This program will print out the names of anyone it recognizes to the console.

# To run this, you need a Raspberry Pi 2 (or greater) with face_recognition and
# the picamera[array] module installed.
# You can follow this installation instructions to get your RPi set up:
# https://gist.github.com/ageitgey/1ac8dbe8572f3f533df6269dab35df65


import face_recognition
import picamera
import numpy as np
import os
import time
from datetime import datetime, date
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
import pyimgur
from google.cloud import vision
from google.cloud import storage
from google.cloud.vision_v1 import types
from PIL import ImageFont, ImageDraw, Image
import sys
import time
import RPi.GPIO as GPIO
from luma.core.interface.serial import i2c
from luma.core.render import canvas
from luma.oled.device import sh1106
import luma.oled
import serial


# initialising different modes


val = [] 

camera = picamera.PiCamera()
camera.resolution = (320, 240)
output = np.empty((240, 320, 3), dtype=np.uint8)

#finalName fdr making a list of all the people seen through the glasses
finalName=[]

#nameFinal for user to access more information about person being viewed using pop

nameFinal = [] 
# Load a sample picture and learn how to recognize it.



# Initialize some variables
face_locations = []
face_encodings = []
face_names = []
test = []

    
#new variables
known_person=[]
known_image=[]
known_face_encoding=[]



#Loop to add images in friends folder

#TRAINING SECTION

for file in os.listdir("friends"):
    try:
        #Extracting person name from the image filename eg: david.jpg
        known_person.append(file.replace(".jpg", ""))
        file=os.path.join("friends/", file)
        known_image = face_recognition.load_image_file(file)

        known_face_encoding.append(face_recognition.face_encodings(known_image)[0])
    except Exception as e:
        pass

print("done encoding")


cred = credentials.Certificate("servKey.json")
firebase_admin.initialize_app(cred)
    
db = firestore.client()


serial1 = i2c(port=1, address=0x3C)
device= sh1106(serial1)
FontTemp6 = ImageFont.truetype("/home/pi/Desktop/Helvetica.ttf",10)
FontTemp = ImageFont.truetype("/home/pi/Desktop/Helvetica.ttf",10)
FontTemp5 = ImageFont.truetype("/home/pi/Desktop/Helvetica.ttf",22)
FontTemp3 = ImageFont.truetype("/home/pi/Desktop/Helvetica.ttf",10)
FontTemp4 = ImageFont.truetype("/home/pi/Desktop/Helvetica.ttf",10)
FontTemp2 = ImageFont.truetype("/home/pi/Desktop/Brain/fontawesome-webfont.ttf",11) 



def detectObject(recName):
    
    with canvas(device) as draw:
        draw.text((15,20), "Starting", fill=255,font=FontTemp3)
        draw.text((15,35),"Object Detection", font=FontTemp, fill=255)
    time.sleep(10)
    camera.capture('testing.jpg')
    
    with canvas(device) as draw:
        draw.text((15,20), "Object", fill=255,font=FontTemp3)
        draw.text((15,35),"captured", font=FontTemp, fill=255)
    
    
    
    CLIENT_ID = "1e40ac5eb2fe48d"
    PATH = "testing.jpg"

    im = pyimgur.Imgur(CLIENT_ID)
    print("working")
    uploaded_image = im.upload_image(PATH, title="Uploaded with PyImgur")

    link = uploaded_image.link



    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'gcp.json'

    # Instantiates a client
    client = vision.ImageAnnotatorClient()
    #set this thumbnail as the url
    image = types.Image()
    image.source.image_uri = link

    print(link)


    #### LABEL DETECTION ######

    response_label = client.label_detection(image=image)

#     print("object detected: ",(response_label.label_annotations)[0].description)
    
    dic = {}
    
    obj = (response_label.label_annotations)[0].description
    
    dic[recName] = obj
    
    print(dic)
    
    with canvas(device) as draw:
        draw.text((15,20), "Object removed:", fill=255,font=FontTemp3)
        draw.text((15,35),obj, font=FontTemp, fill=255)
    
    time.sleep(5)
    
    #STARTING FIREBASE
    

    
    db.collection(u'activeBorrowers').add({'borrowerName': recName, 'borrowedObject': obj})
    
    
    
    quit()
    

def motor_run(s):
    state = s
 
    GPIO.setmode(GPIO.BOARD)
    GPIO.setwarnings(False)

    aMotorPins = [12, 15, 11, 13]
     
    # Set all pins as output
    for pin in aMotorPins:
        GPIO.setup(pin,GPIO.OUT)
        GPIO.output(pin, False)

    aSequence = [
        [1,0,0,1],
        [1,0,0,0],
        [1,1,0,0],
        [0,1,0,0],
        [0,1,1,0],
        [0,0,1,0],
        [0,0,1,1],
        [0,0,0,1]
    ]
            
    iNumSteps = len(aSequence)

    if state == 'locked':
        iDirection = 1
    else:
        iDirection = -1

    fWaitTime = int(1) / float(1000)

    iDeg = int(90 * 11.377777777777)

    iSeqPos = 0
    # If the fourth argument is present, it means that the motor should start at a
    # specific position from the aSequence list

    # 1024 steps is 90 degrees
    # 4096 steps is 360 degrees

    for step in range(0,iDeg):

        for iPin in range(0, 4):
            iRealPin = aMotorPins[iPin]
            if aSequence[iSeqPos][iPin] != 0:
                GPIO.output(iRealPin, True)
            else:
                GPIO.output(iRealPin, False)
     
        iSeqPos += iDirection
     
        if (iSeqPos >= iNumSteps):
            iSeqPos = 0
        if (iSeqPos < 0):
            iSeqPos = iNumSteps + iDirection
     
        # Time to wait between steps
        time.sleep(fWaitTime)

    for pin in aMotorPins:
        GPIO.output(pin, False)

    # Print the position from the aSequence list which should have been the
    # next position, if the previous loop was not ended
    # Need to catch this output when running from another script

    print (iSeqPos)

        

def testingFunction():
    
    with canvas(device) as draw:
        draw.text((15,20), "Starting", fill=255,font=FontTemp3)
        draw.text((15,35),"Facial Recognition", font=FontTemp, fill=255,)
    


    while True:
#         test.append(retrieveData())
    # Grab a single frame of video from the RPi camera as a numpy array
        camera.capture(output, format="rgb")

    # Find all the faces and face encodings in the current frame of video
        faceCurFrame = face_recognition.face_locations(output)
        encodeCurFrame = face_recognition.face_encodings(output, faceCurFrame)

    # Loop over each face found in the frame to see if it's someone we know.
        for encodeFace, faceLoc in zip(encodeCurFrame, faceCurFrame):

            matches = face_recognition.compare_faces(known_face_encoding, encodeFace)
            faceDis = face_recognition.face_distance(known_face_encoding, encodeFace)
            matchIndex=np.argmin(faceDis) #Checking which image is matched
            if matches[matchIndex]:
              name = known_person[matchIndex].lower()
              if len(finalName)!=0 and finalName[0]=="hardik" and len(finalName)==1:
                  with canvas(device) as draw:
                      draw.text((15,20), "Unlocking", fill=255,font=FontTemp3)
                      draw.text((15,35),"The Safe", font=FontTemp, fill=255,)
                  motor_run("unlocked")
                  print("starting object detection\n")
                  detectObject(finalName[0])
              finalName.append(name)
              nameFinal.append(name)
              # DISPLAYING KNOWN NAME ON THE OLED SCREEN 
            
              
                
            #print(finalName)
        
#         elif test[-1] == "send\r\n":
#             print(finalName)
#             dict = {'names':finalName}
#             df = pd.DataFrame(dict)
#             df.to_csv('names.csv')
    
            
            '''Firebase connection'''

            
            
#             if len(finalName) == 1:
#                 
#                 print(finalName)
#                 return finalName
#                 break

            print(finalName)






users_ref = db.collection(u'toRaspi')


#MAIN RUNNER LOOP

while True:
    docs = users_ref.stream()

    for doc in docs:
        prime = doc.to_dict()
        
        check = (prime["hereToCollect"])
        if check:
            
            print("Button has been pressed; starting face rec\n")
            testingFunction()
        else:
            continue








# def fire_base_connection():
#     
#     try:
#         df = pd.read_csv('names.csv')
#         naam = df.names.to_list()
#         print("this is:  " , naam)
# 
#         for i in naam:
#             doc = db.collection('people').document(i)
#             doc.set({
#                 'name': i
#             })
# 
#     except Exception as err:
#         print("Error found... moving on", err)
        
        



    
    
      




print("Starting a new camera capture")
        
        
                






