import customtkinter
import tkinter


def incluir_nacao_federacao(frame):
        # TODO: Implementar a conexão com o banco de dados para incluir a nação na federação
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira a qual federação você deseja incluir a nação", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Nova federação", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def excluir_nacao_federacao(frame):
        # TODO: Implement ar a conexão com o banco de dados para excluir a nação da federação
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        # TODO quando a lógica estiver implementada, substituir {"nação"} por {nacao}
        tNovoNome = customtkinter.CTkLabel(master=frame3, text=f"Você tem certeza que deseja remover a nação {'nação'} da federação atual?", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.4, anchor="center")
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.55, anchor=tkinter.CENTER)

def criar_nova_federacao(frame):
        # TODO: Implementar a conexão com o banco de dados para criar uma nova federação
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira o nome da nova federação", font=("Garamond", 16))
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Nova federação", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def inserir_dominancia_planeta(frame):
        # TODO: Implementar a conexão com o banco de dados para inserir a dominância no planeta
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira o planeta ao qual você deseja inserir dominância", font=("Garamond", 16))
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Planeta", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)