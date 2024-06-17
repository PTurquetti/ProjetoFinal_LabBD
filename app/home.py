import tkinter
import customtkinter
from PIL import ImageTk, Image

def show_home(): # TODO quando a lógica estiver implementada, adicionar os parâmetros authenticated_user e access_level show_home(authenticated_user, access_level, nacao):
    home_window = customtkinter.CTk()
    home_window.geometry("1024x1024")
    home_window.title("Home Page")

    img1 = ImageTk.PhotoImage(Image.open("./imgs/back.png"))  # Load the image
    l1 = customtkinter.CTkLabel(master = home_window, image=img1)  # Create a label with the image
    l1.pack()  # Pack the label
    
    # Área de informações de overview
    frame = customtkinter.CTkFrame(master=l1, width=824, height=500, corner_radius=36)  # Create a frame with rounded corners
    frame.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER) # Place the frame in the center of the label

    # Greetings to the authenticaded user
    # TODO quando tiver a lógica implementada, substituir {"Username"} por {authenticated_user}
    hl2 = customtkinter.CTkLabel(master=frame, text=f"Bem-vindo, {"Username"}", font=("Garamond", 20))
    hl2.place(relx=0.5, rely=0.12, anchor=tkinter.CENTER)

    # TODO quando tiver a lógica implementada, substituir {"cargo"} por {access-level} e {"nação"} por {nacao}
    hl3 = customtkinter.CTkLabel(master=frame, text=f"Aqui está o que você pode fazer como, {"cargo"} da nação {"nação"}" , font=("Garamond", 18))
    hl3.place(relx=0.5, rely=0.18, anchor=tkinter.CENTER)

    frame2 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
    frame2.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

    # TODO Decidir que tipo de informação de overview será exibida
    hl2 = customtkinter.CTkLabel(master=frame2, text="Selecione o que gostaria de fazer ao lado.", font=("Garamond", 16))
    hl2.place(relx=0.5, rely=0.5, anchor="center")

    access_level = "CIENTISTA"  # TODO: quando a lógica estiver implementada, substituir "admin" pelo access_level


    if access_level == "LIDER":
        # Funções específicas para Líder de facção
        func1_button = customtkinter.CTkButton(master=frame, text="Alterar nome da facção", width=200, height=40)
        func1_button.place(relx=0.15, rely=0.34, anchor=tkinter.CENTER)
        
        func2_button = customtkinter.CTkButton(master=frame, text="Indicar novo líder", width=200, height=40)
        func2_button.place(relx=0.15, rely=0.46, anchor=tkinter.CENTER)
        
        func3_button = customtkinter.CTkButton(master=frame, text="Credenciar novas comunidades", width=200, height=40)
        func3_button.place(relx=0.15, rely=0.58, anchor=tkinter.CENTER)
        
        # TODO quando a lógica estiver implementada, substituir {"nação"} por {nacao}
        func4_button = customtkinter.CTkButton(master=frame, text=f"Remover facção de {"nação"}", width=200, height=40)
        func4_button.place(relx=0.15, rely=0.7, anchor=tkinter.CENTER)

    elif access_level == "OFICIAL":
        # Funções específicas para Oficial
        # ele n tem? só overview TODO qq eu faço no oficial então?
        hl2 = customtkinter.CTkLabel(master=frame2, text="Decidir o que colocar para o oficial", font=("Garamond", 16))
        hl2.place(relx=0.5, rely=0.6, anchor="center")    

    elif access_level == "COMANDANTE":
        # Funções específicas para Comandante
        func1_button = customtkinter.CTkButton(master=frame, text="Incluir nação em uma federação", width=200, height=40)
        func1_button.place(relx=0.15, rely=0.34, anchor=tkinter.CENTER)

        # Funções específicas para Comandante
        func2_button = customtkinter.CTkButton(master=frame, text="Excluir nação de uma federação", width=200, height=40)
        func2_button.place(relx=0.15, rely=0.46, anchor=tkinter.CENTER)
        
        func3_button = customtkinter.CTkButton(master=frame, text="Criar nova federação na nação", width=200, height=40)
        func3_button.place(relx=0.15, rely=0.58, anchor=tkinter.CENTER)

        func4_button = customtkinter.CTkButton(master=frame, text="Inserir dominância em planeta", width=200, height=40)
        func4_button.place(relx=0.15, rely=0.7, anchor=tkinter.CENTER)

    elif access_level == "CIENTISTA":
        # Funções específicas para cientista
        func1_button = customtkinter.CTkButton(master=frame, text="Inserir nova estrela", width=200, height=40)
        func1_button.place(relx=0.15, rely=0.34, anchor=tkinter.CENTER)

        # Funções específicas para Comandante
        func2_button = customtkinter.CTkButton(master=frame, text="Ver informações sobre uma estrela", width=200, height=40)
        func2_button.place(relx=0.15, rely=0.46, anchor=tkinter.CENTER)
        
        func3_button = customtkinter.CTkButton(master=frame, text="Atualizar estrela", width=200, height=40)
        func3_button.place(relx=0.15, rely=0.58, anchor=tkinter.CENTER)

        func4_button = customtkinter.CTkButton(master=frame, text="Deletar estrela", width=200, height=40)
        func4_button.place(relx=0.15, rely=0.7, anchor=tkinter.CENTER)

    

    # Função 1
    button1 = customtkinter.CTkButton(master=frame, text="Generate report", width=200, height=40)
    button1.place(relx=0.51, rely=0.91, anchor=tkinter.CENTER)

    # Função 2
    button2 = customtkinter.CTkButton(master=frame, text="Log out", width=200, height=40)
    button2.place(relx=0.77, rely=0.91, anchor=tkinter.CENTER)


    home_window.mainloop()  # Start the main loop