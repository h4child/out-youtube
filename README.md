
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)


```
                                                              _            
                 _                               _           | |           
    ___   _   _ | |_   ___  _   _   ___   _   _ | |_   _   _ | | _    ____ 
   / _ \ | | | ||  _) (___)| | | | / _ \ | | | ||  _) | | | || || \  / _  )
  | |_| || |_| || |__      | |_| || |_| || |_| || |__ | |_| || |_) )( (/ / 
   \___/  \____| \___)      \__  | \___/  \____| \___) \____||____/  \____)
                           (____/                                          

```

## Fazer Dowload de conteúdo do canal do youtube.

Dependências:
`ffmpeg` - https://www.ffmpeg.org/download.html
`youtube-dl` - https://ytdl-org.github.io/youtube-dl/download.html
`jq` - https://stedolan.github.io/jq/download/
`wget` - https://www.gnu.org/software/wget/

`./out-youtube out <diretório>`
Vai ser criado um arquivo chamado out-config que deverá ser preenchido de acordo
com as informações necessária. A leitura do out-config ficará mais claro como usar.

Depois que as informações forem colocadas no out-config o out-youtube poderá baixar
o conteúdo do canal `./out-youtube <diretório out-config>`




