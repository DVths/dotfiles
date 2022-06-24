#!/bin/bash

# Capiura o primeiro argumento da linha de comando (nome do projeto)
SESSION=$1
# Verifica se existe uma sessão na lista com o mesmo nome
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

# Apenas crie uma nova sessão se a mesma não existir 
if [ "$SESSIONEXISTS" = "" ]
then
    # Inicializar o tmux com uma nome fornecido como primeiro argumento 
    tmux new-session -d -s $SESSION

    # Criar um painel vertical com 20px
    tmux split-window -v -p 20
    # Crie outras divisões no painel inferior se achar que deve
    # tmux split-window -h -p 66
    # tmux split-window -h -p 50

    # Renomear a primeira janela selecionar o painel superio e executar neovim
    tmux rename-window -t 1 'Main'
    tmux select-pane -t 0 
    # "nv" é um alisas definido na minha configuração para neovim
    tmux send-keys 'nv' C-m

    # Cria uma janela para execução de testes 
    tmux new-window -t $SESSION:2 -n 'Run Tests'
    # Aqui você pode executar um script de acordo com a sua necessidade 

    # Cria uma janela para subir o servidor 
    tmux new-window -t $SESSION:3 -n 'Server'
    # Aqui você pode executar um script de acordo com a sua necessidade 

    # Cria uma janela adicional para o shell
    tmux new-window -t $SESSION:4 -n 'Shell'
fi

# Anexa a sessção a partir da janela principal
tmux attach-session -t $SESSION:1

