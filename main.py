# DS 3002 Project 2
# Joe von Storch, Jenna Mulvihill, Connor Snavely

import discord
import requests
import random

client = discord.Client()
#TOKEN = os.getenv(
#    'DISCORD_TOKEN',
#    'OTY2MzYxMjA0NzUyODA1OTU5.YmAoAQ.fU_Zyp3boBfD6TZqsd34OrSo6P8')

#GUILD = os.getenv('DISCORD_GUILD', "joevonsto's server")

TOKEN="OTY2MzYxMjA0NzUyODA1OTU5.YmAoAQ.sK2ku3ToXHGUxBQJEg_MqFxr3To"
GUILD = "joevonsto's server"

@client.event
#async def on_ready():
#  for guild in client.guilds:
#    if guild.name == GUILD:
#      break
#  print('We have logged in as {0.user}.format(client)')

# User inputs a 'Help' message
async def on_message(message):
  if message.author == client.user:
      return
    
# When the user types in 'Help', they will receive a help message explaining the three functions of the discord bot (project steps 1 and 2).
  if message.content.startswith('Help'):
    await message.channel.send("I'm sorry that you need help! If you would like a recipe that is a specific type of cuisine, such as Italian, please type in that type of cuisine. If you would like a recipe that follows a specific diet, such as Vegan, please type in that diet. If you would like a recipe that is a specific meal type, such as breakfast, please type in a meal type in all lowercase letters. Happy cooking!")

# List of all of the possible cuisines
  cuisines=["African","American","British","Cajun","Caribbean","Chinese","Eastern European","European","French","German","Greek","Indian","Irish","Italian","Japanese","Jewish","Korean","Latin American","Mediterranean","Mexican","Middle Eastern","Nordic","Southern","Spanish","Thai","Vietnamese"]  
# Check to see if the users input is part of the cuisine types and if it is, print out the name of a recipe that is within that type of cuisine from the API (function 1 and project step 4)
  if message.content in cuisines:
    url = "https://api.spoonacular.com/recipes/complexSearch?cuisine="+message.content
    querystring = {}
    headers = {
    'x-api-key': "c44c65169a1a4b7988052b77f577b63d"}
    response = requests.request("GET", url, headers=headers, params=querystring)
    dish_json = response.json()
    x = random.randint(0,len(dish_json)-1)
    await message.channel.send(dish_json['results'][x]['title'])
    
# List of the types of diets
  diets = ["Gluten Free","Ketogenic","Vegetarian","Lacto-Vegetarian","Ovo-Vegetarian","Vegan","Pescetarian","Paleo","Primal","Low FODMAP","Whole30"]
# Check to see if the users input is part of the diet types and if it is, print out the name of a recipe that is within that type of diet (function 2 and project step 4)
  if message.content in diets:
    url1="https://api.spoonacular.com/recipes/complexSearch?diet="+message.content
    querystring1 = {}
    headers1 = {
    'x-api-key': "c44c65169a1a4b7988052b77f577b63d"}
    response = requests.request("GET", url1, headers=headers1, params=querystring1)
    #await message.channel.send(response.json())
    dish_json1 = response.json()
    x1 = random.randint(0,len(dish_json1)-1)
    await message.channel.send(dish_json1['results'][x1]['title'])
    
# List of all of the meal types
  mealTypes = ["main course", "bread", "marinade", "side dish", "breakfast", "fingerfood", "dessert", "soup", "snack", "appetizer", "beverage", "drink", "salad", "sauce"]
# Check to see if the users input is part of the meal types and if it is, print out the name of a recipe that is within that type of meal (function 3 and project step 4)
  if message.content in mealTypes:
    url2="https://api.spoonacular.com/recipes/complexSearch?type="+message.content
    querystring2 = {}
    headers2 = {
    'x-api-key': "c44c65169a1a4b7988052b77f577b63d"}
    response = requests.request("GET", url2, headers=headers2, params=querystring2)
    #await message.channel.send(response.json())
    dish_json2 = response.json()
    x2 = random.randint(0,len(dish_json2)-1)
    await message.channel.send(dish_json2['results'][x2]['title'])
    
# Check if the users input is valid, and if it is not, give the user an error
  if message.content not in mealTypes and message.content not in cuisines and message.content not in diets and message.content != "Help":
    await message.channel.send("Invalid Input: Please type in 'Help', a valid cuisine type, a valid diet, or a valid meal type.")

client.run(TOKEN)