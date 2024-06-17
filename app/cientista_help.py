import customtkinter
import tkinter


def inserir_nova_estrela(frame):
        # TODO: Implementar a conexão com o banco de dados para inserir a nova estrela
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Entre com o ID da nova estrela", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.15, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="ID estrela", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.3, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Entre com as coordenadas X, Y e Z, respectivamente", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.48, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Coordenada X", height=40, width=130, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.25, rely=0.62, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Coordenada Y", height=40, width=130, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.62, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Coordenada Z", height=40, width=130, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.75, rely=0.62, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.85, anchor=tkinter.CENTER)

def ver_informacoes_estrela(frame):
        # TODO: Implementar a conexão com o banco de dados para buscar as informações da estrela
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira o ID da estrela que você gostaria de ver mais informações", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Estrela", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def atualizar_estrela(frame):
        # TODO: Implementar a conexão com o banco de dados para atualizar a estrela
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira os dados da estrela para atualizá-los", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.15, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="ID da estrela *", height=40, width=200, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.3, rely=0.3, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Nome da estrela", height=40, width=200, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.7, rely=0.3, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Classificação", height=40, width=200, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.3, rely=0.48, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Massa", height=40, width=200, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.7, rely=0.48, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Coordenada X *", height=40, width=130, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.25, rely=0.66, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Coordenada Y *", height=40, width=130, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.66, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Coordenada Z *", height=40, width=130, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.75, rely=0.66, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.85, anchor=tkinter.CENTER)

def remover_estrela(frame):
        # TODO: implementar a conexão com o banco de dados para remover a estrela
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira o ID da estrela que você deseja remover", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="ID strela", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)