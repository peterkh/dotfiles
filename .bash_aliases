
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'

alias k='kubectl'
alias ksys='kubectl --namespace=kube-system'
alias kex='kubectl exec -i -t'
alias kg='kubectl get'
alias kd='kubectl describe'
alias krun='kubectl run --rm --restart=Never --image-pull-policy=IfNotPresent -i -t'
alias kgsvc='kubectl get service'
alias kgdep='kubectl get deployment'
alias kgpo='kubectl get pods'

