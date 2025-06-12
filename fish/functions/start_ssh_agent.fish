function start_ssh_agent --description "start the ssh agent in the background"
    if test -z (pgrep ssh-agent)
        eval (ssh-agent -c)
        set -l sock $SSH_AUTH_SOCK
        set -l pid $SSH_AGENT_PID
        set -ge SSH_AUTH_SOCK
        set -ge SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $sock
        set -Ux SSH_AGENT_PID $pid
        ssh-add ~/.ssh/id_ed25519
    else
        echo "agent already running"
    end
end
