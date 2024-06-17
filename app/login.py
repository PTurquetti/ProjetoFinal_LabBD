import tkinter
import customtkinter
from PIL import ImageTk, Image

from db_controller import DBController
from oracledb.exceptions import DatabaseError


def show_login(db_controller):

    customtkinter.set_appearance_mode("dark")  # Set the appearance mode to system
    customtkinter.set_default_color_theme("blue")  # Set the default color theme to blue

    # Function to validate login
    def validate_login(): # Adicionado db_controller como parâmetro
        from home import show_home
        try:
            cpi, senha = entry1.get(), entry2.get()
            info_login = db_controller.call_function('PCT_USER_TABLE.fazer_login', [cpi, senha], str)
            info_login = [s.strip() for s in info_login.split(';')]
            id_user, username, access_level, nacao = info_login
            app.destroy()  # Close the login window
            show_home(db_controller, id_user, username, access_level, nacao, cpi) # Passa o db_controller para a próxima tela
        except DatabaseError as ex:
            error, = ex.args
            if error.code == 20000:  # erro lógico 
                msg_erro = error.message.split(':')[1][:-10].strip()
                print('Erro do usuário:', msg_erro)
            else:
                print('Erro da base de dados:', error.code, error.message)
            #TODO: Mostrar mensagem de erro ao usuário e re-validação caso necessário
    
    def on_closing(db_controller):
        del db_controller
        app.destroy()
        

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

    button1 = customtkinter.CTkButton(master=frame, text="Log in", width=350, height=40, corner_radius=32, command=lambda: validate_login())  # Passa o db_controller para validate_login
    button1.place(relx=0.5, rely=0.75, anchor=tkinter.CENTER)  # Place the button in the center of the frame

    app.protocol("WM_DELETE_WINDOW", lambda: on_closing(db_controller))
    app.mainloop()  # Start the main loop


if __name__ == "__main__":
    print('Conectando ao banco de dados...')
    db_controller = DBController()  # Inicializa o controlador do banco de dados
    show_login(db_controller)  # Exibe a tela de login
