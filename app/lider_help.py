import customtkinter
import tkinter
from oracledb.exceptions import DatabaseError

def show_popup(message):
        popup = tkinter.Toplevel()
        popup.geometry('300x100')  # Set the size of the popup window
        popup.title('Popup Message')
        
        popup.configure(bg='#202845')  # Dark blue background color
        label = tkinter.Label(popup, text=message, padx=20, pady=20, fg='white', bg='#202845', font=('Garamond', 12))
        label.pack()
        
        # Center the popup window
        popup.update_idletasks()
        width = popup.winfo_width()
        height = popup.winfo_height()
        x = (popup.winfo_screenwidth() // 2) - (width // 2)
        y = (popup.winfo_screenheight() // 2) - (height // 2)
        popup.geometry('{}x{}+{}+{}'.format(width, height, x, y))
        
        # Automatically close the popup after 3000 milliseconds (3 seconds)
        popup.after(25000, popup.destroy)
        
        popup.mainloop()

def alterar_nome(db_controller, cpi, novo_nome):
        try:
                info_funcao = db_controller.call_function('PCT_GERENCIAMENTO_LIDER.alterar_nome_faccao', [cpi, novo_nome], str)
                show_popup(info_funcao)
                db_controller.commit()
        except DatabaseError as ex:
                error, = ex.args
                if error.code == 20000:  # erro lógico 
                        msg_erro = error.message.split(':')[1][:-10].strip()
                        show_popup(msg_erro)
                        print('Erro do usuário:', msg_erro)
                else:
                        show_popup('Erro da base de dados (olhar log)')
                        print('Erro da base de dados:', error.code, error.message)

def indica_lider(db_controller, cpi, novo_lider):
        try:
                info_funcao = db_controller.call_function('PCT_GERENCIAMENTO_LIDER.indica_lider', [cpi, novo_lider], str)
                show_popup(info_funcao)
                db_controller.commit()
        except DatabaseError as ex:
                error, = ex.args
                if error.code == 20000:  # erro lógico 
                        msg_erro = error.message.split(':')[1][:-10].strip()
                        show_popup(msg_erro)
                        print('Erro do usuário:', msg_erro)
                else:
                        show_popup('Erro da base de dados (olhar log)')
                        print('Erro da base de dados:', error.code, error.message)

def insere_com(db_controller, cpi, especie, nome):
        try:
                info_funcao = db_controller.call_function('PCT_GERENCIAMENTO_LIDER.credenciar_comunidade', [cpi, especie, nome], str)
                show_popup(info_funcao)
                db_controller.commit()
        except DatabaseError as ex:
                error, = ex.args
                if error.code == 20000:  # erro lógico 
                        msg_erro = error.message.split(':')[1][:-10].strip()
                        show_popup(msg_erro)
                        print('Erro do usuário:', msg_erro)
                else:
                        show_popup('Erro da base de dados (olhar log) ' + str(error.code) + ' '  + error.message)
                        print('Erro da base de dados:', error.code, error.message)

def alter_faction_name(frame, db_controller, cpi):
        # TODO: Implementar a conexão com o banco de dados para alterar o nome da facção
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Entre com o novo nome da facção", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Novo nome", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32, command=lambda: alterar_nome(db_controller, cpi, entryFName.get()))  # Call the function to change the faction name
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER)

def indicar_novo_lider(frame, db_controller, cpi):
        # TODO: Implementar a conexão com o banco de dados para indicar um novo líder
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Indique um novo líder para a facção", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Novo líder", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32, command=lambda: indica_lider(db_controller, cpi, entryFName.get()))
        buttonFName.place(relx=0.5, rely=0.7, anchor=tkinter.CENTER, )  # Call the function to indicate the new leader

def credenciar_nova_comunidade(frame, dbcontroller, cpi):
        # TODO: Implementar a conexão com o banco de dados para credenciar a nova comunidade
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        tNovoNome = customtkinter.CTkLabel(master=frame3, text="Insira a comunidade a ser credenciada", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.35, anchor="center")

        entryFName = customtkinter.CTkEntry(master=frame3, placeholder_text="Especie", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)  # Place the entry in the center of the frame

        entryFName2 = customtkinter.CTkEntry(master=frame3, placeholder_text="Comunidade", height=40, width=350, corner_radius=32)  # Create an entry with a placeholder
        entryFName2.place(relx=0.5, rely=0.65, anchor=tkinter.CENTER)  # Place the entry in the center of the frame
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32, command=lambda: insere_com(dbcontroller, cpi, entryFName.get(), entryFName2.get()))  # Call the function to accredit the new community
        buttonFName.place(relx=0.5, rely=0.9, anchor=tkinter.CENTER)

def remover_faccao_nacao(frame):
        # TODO: Implementar a conexão com o banco de dados para remover a facção da nação
        
        frame3 = customtkinter.CTkFrame(master=frame, width=550, height=300, corner_radius=36)  # Create a frame with rounded corners
        frame3.place(relx=0.64, rely=0.53, anchor=tkinter.CENTER) # Place the frame in the center of the label

        # TODO quando a lógica estiver implementada, substituir {"nação"} por {nacao}
        tNovoNome = customtkinter.CTkLabel(master=frame3, text=f"Você tem certeza que deseja remover a facção da nação {'nação'}?", font=("Garamond", 16), wraplength=500)
        tNovoNome.place(relx=0.5, rely=0.4, anchor="center")
        
        buttonFName = customtkinter.CTkButton(master=frame3, text="Confirmar", width=200, height=40, corner_radius=32)
        buttonFName.place(relx=0.5, rely=0.55, anchor=tkinter.CENTER)
