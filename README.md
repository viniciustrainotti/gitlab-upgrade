# Subir e Atualizar versões do Gitlab Community

## Subir container

Execute o arquivo `up-gitlab.sh` com a versão para subir o gitlab na versão community desejada

```sh
$ ./up-gitlab.sh 14.9.2-ce.0 http://localhost
```

## Atualizar container

Execute o arquivo `upgrade-gitlab.sh` com a versão para atualizar o gitlab na versão community desejada

```sh
$ ./upgrade-gitlab.sh 14.10.2-ce.0
```

## Acessar como root

o login é `root` e a senha você consegue pegar via `cat`

```sh
$ docker exec -u root gitlab2 bash -c "cat /etc/gitlab/initial_root_password" | grep Password: | sed 's/Password://' | sed 's/ //'
```