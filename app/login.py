import tkinter
import customtkinter
from PIL import ImageTk, Image

from home import show_home
from db_controller import DBController

customtkinter.set_appearance_mode("dark")  # Set the appearance mode to system
customtkinter.set_default_color_theme("blue")  # Set the default color theme to blue

# Function to validate login
def validate_login(): #quando a lógica estiver implementada, adicionar os parâmetros username e password validate_login(username, password)
    db_controller = DBController()

    # login_valido = db_controller.call_function('pct_autenticacao.valida_login', [username, password], int) # TODO: a função de login ainda precisa ser implementada,
    login_valido = True
    
    # Check if the login is valid
    if login_valido:
        # Get the username and access level from the database
        # TODO: a função de login precisa retornar, também, o nome do usuário, seu nível de acesso e sua nacao para que possamos passar essas informações para a próxima página
        # username = db_controller.call_function('pct_autenticacao.get_username', [username], str)
        # access_level = db_controller.call_function('pct_autenticacao.get_access_level', [username], str)
        # nacao = db_controller.call_function('pct_autenticacao.get_nacao', [username], str)
        
        app.destroy()  # Close the login window
        show_home() # Depois que tiver a lógica do username e access_level, substituir essa funcao pela de baixo
        # show_home(username, access_level, nacao)  # Navigate to the next page and pass the username and access level to adequate the page
    else:
        print("Login failed.")


app = customtkinter.CTk()  # Create the main window
app.geometry("1024x1024")  # Set the size of the window
app.title("Login")  # Set the title of the window

img1 = ImageTk.PhotoImage(Image.open("./imgs/back.png"))  # Load the image
l1 = customtkinter.CTkLabel(master = app, image=img1)  # Create a label with the image
l1.pack()  # Pack the label

frame = customtkinter.CTkFrame(master=l1, width=480, height=500, corner_radius=36)  # Create a frame with rounded corners
frame.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER) # Place the frame in the center of the label

l2 = customtkinter.CTkLabel(master=frame, text="Log into your account", font=("Garamond", 20))  # Create a label with text
l2.place(relx=0.5, rely=0.15, anchor=tkinter.CENTER)  # Place the label in the center of the frame

l2 = customtkinter.CTkLabel(master=frame, text="Login", font=("Garamond", 16))  
l2.place(relx = 0.2, rely=0.3, anchor=tkinter.CENTER)  

entry1 = customtkinter.CTkEntry(master=frame, placeholder_text="Login", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
entry1.place(relx=0.5, rely=0.38, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

l2 = customtkinter.CTkLabel(master=frame, text="Password", font=("Garamond", 16))  
l2.place(relx = 0.24, rely=0.5, anchor=tkinter.CENTER)  

entry2 = customtkinter.CTkEntry(master=frame, placeholder_text="Password", height=40, width=350, corner_radius=32, show = "*")  # Create an entry with a placeholder
entry2.place(relx=0.5, rely=0.58, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

button1 = customtkinter.CTkButton(master=frame, text="Log in", width=350, height=40, corner_radius=32, command = validate_login)  # Create a button
button1.place(relx=0.5, rely=0.75, anchor=tkinter.CENTER)  # Place the button in the center of the frame


app.mainloop()  # Start the main loop
