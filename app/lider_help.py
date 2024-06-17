import customtkinter
import tkinter


def alter_faction_name(frame):
        # TODO: Implementar a conexão com o banco de dados para alterar o nome da facção
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Entre com o novo nome da facção", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Novo nome", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def indicar_novo_lider(frame):
        # TODO: Implementar a conexão com o banco de dados para indicar um novo líder
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Indique um novo líder para a facção", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Novo líder", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def credenciar_nova_comunidade(frame):
        # TODO: Implementar a conexão com o banco de dados para credenciar a nova comunidade
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira a comunidade a ser credenciada", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Comunidade", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def remover_faccao_nacao(frame):
        # TODO: Implementar a conexão com o banco de dados para remover a facção da nação
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        # TODO quando a lógica estiver implementada, substituir {"nação"} por {nacao}
        tNovoNome = customtkinter.CTkLabel(master=frame3, text=f"Você tem certeza que deseja remover a facção da nação {'nação'}?", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.4, anchor="center")
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.55, anchor=tkinter.CENTER)