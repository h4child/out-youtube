#!/bin/bash
#
  #
    # GPL-2 License
    # Copyright (c) 2021
    # Written by Rodgger Bruno (rodgger@protonmail.com)
    #
  #
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
#                                                              _            
#                 _                               _           | |           
#    ___   _   _ | |_   ___  _   _   ___   _   _ | |_   _   _ | | _    ____ 
#   / _ \ | | | ||  _) (___)| | | | / _ \ | | | ||  _) | | | || || \  / _  )
#  | |_| || |_| || |__      | |_| || |_| || |_| || |__ | |_| || |_) )( (/ / 
#   \___/  \____| \___)      \__  | \___/  \____| \___) \____||____/  \____)
#                           (____/                                          
#  ---------------------------------------------------------------------------
#  ---------------------------------------------------------------------------
#  ---------------------------------------------------------------------------
#
#  out-youtube <arquivo com parametros>
#
# <arquivo com parametro> : arquivos de configuração para o shell, para cria-lo digite 
# ./out-youtube out <diretorio>
#
# dependencias:
# Chave API do Youyube (se for necessário depois crio um tutoria mais moderno) - https://blog.difluir.com/2016/10/como-criar-uma-chave-de-api-para-youtube/ 
# wget -q - https://www.gnu.org/software/wget/
# youtube-dl - http://ytdl-org.github.io/youtube-dl/download.html
# ffmpeg - https://ffmpeg.org/download.html
# 
# 
# descrição: out-youtube faz download das informações, vídeos, áudio do canal do youtube.
# 
#
#

# Cores das letras para tela
RESET="\e[0m"; U_RESET="\e[4m"; B_RESET="\e[1m"
RED="\033[33;31m"; B_RED="\e[1;31m" #vermelho
GREEN="\033[33;32m"; B_GREEN="\e[1;32m" #verde
YELLOW="\033[33;33m"; B_YELLOW="\e[1;33m" #amarelo
CYAN="\e[0;36m"; B_CYAN="\e[1;36m" #ciano

# mostra strings finais quando termina sem erros
function print_final_succcess () {
    echo -e "${B_RESET}${DIRECTORY}${RESET}"; echo -e "${B_RESET}Concluído${RESET}"

}


# Função que inseri conteúdo do arquivo out-config
# Dentro da função echo  apenas tem echo no qual será inserido no out-config
function add_config(){

echo -e "# Esse arquivo será usado para guardar as informações para fazer download\
\n# do conteúdo do canal. Aqui contém informações necessárias que será usado\
\n# pelo out-youtube.\
\n#\
\n#\
\n# Esse arquivo contém as seguintes informações:\
\n# API_KEY: Sua chave para acessar API do youtube. \
\n# \
\n# CHANNEL_YOUTUBE: seu canal desejado para baixar o conteúdo.\
\n#\
\n# USER_YOUTUBE: usuário do youtube que tem o canal para baixar o conteúdo.\
\n#\
\n# DIRECTORY: qual pasta os arquivos serão armazenados\
\n#\
\n# VIDEO: download videos\
\n#\
\n# AUDIO: obter áudio\
\n#\
\n# SUBTITLE: download legenda youtube\
\n# ---------------------------------------------------------------\
\n#\
\n# Para criar ou substituir esse arquivo use 'out-youtube out <diretório>'. O diretório\
\n# é aonde o arquivo ficará e recomendamos colocar na pasta que o conteúdo do youtube\
\n# colocado.\n\n\
\n# A chave API do youtube que será usada para ter aceso a informações do canal.\
\n# criar uma API_KEY\
\n#\nAPI_KEY=\n\n\
\n# O ID do canal desejado é similar a esse UCgnYFet4mgK-7SpNJoI6b_A\
\n# A informação do Channel geralmente está na url do \
\n# canal https://www.youtube.com/channel/UCgnYFet4mgK-7SpNJoI6b_A\
\n# Talvez precise atualizar a paǵina do canal para mostrar o ID do canal\
\n# Você deve colocar o valor no CHANNEL_YOUTUBE ou colocar o USER_YOUTUBE. Caso os dois\
\n# estejam definidos o out-youtube terá preferência no CHANNEL_YOUTUBE\
\n#\nCHANNEL_YOUTUBE=\n\
\n# Para encontrar o id e colocar no CHANNEL_YOUTUBE ou user no USER_YOUTUBE pode ser\
\n# um pouco chato para achar o que pode ajudar com esse link \
\n# https://support.google.com/youtube/answer/6180214?hl=en\
\n# Colocar o USER_YOUTUBE do canal exemplo: dreamtheater (https://www.youtube.com/user/dreamtheater)\
\n# \nUSER_YOUTUBE=\n\
\n# Esse valor é o local aonde os conteúdos do canal serão armazenados. Esse valor precisa\
\n# estar com '/' no final senão o out-youtube interpretará como um prefixo para os arquivos.\
\n# Esse local deverá estar criado antes de chamar o out-youtube pois ele não criará pastas\
\n# e recomendando usar caminho completo para a pasta\
\n#\nDIRECTORY=\`pwd\`\"/test/\"\n\
\n# Informação sobre o download do conteúdo \
\n# opções:\
\n# -- video\
\n# -- audio\
\n# -- legendas\n\
\n# Informar se é necessário baixar o vídeo do canal\
\n# Se desejar deixe 'true' para o out-youtube fazer download dos vídeos\
\n#\nVIDEO=true\n\
\n# Informar se é necessário obter áudio dos vídeos\
\n# Se dejesar deixe 'true' para o out-youtube extrair áudio ds vídeos\
\n#\nAUDIO=false\n\
\n# Obter as legendas do vídeo que estão no youtube.\
\n# Essa opção só será válida se o VIDEO estiver true\
\n#\nSUBTITLE=true\n\
\n# obter as legendas automáticas do youtube\
\n# Essa opção só será válida se o VIDEO estiver true\
\n# \nAUTO_SUBTITLE=true\n\
\n# Caso queira especificar quais linguagens o out-youtube deve  fazer download\
\n# se estiver disponível no vídeo\
\n# Se estiver disponível serão baixados:\
\n# gu | zh-Hans | zh-Hant | gd | ga | gl | lb | la | lo | tt | tr | lv | lt | tk | th |\
\n# tg | te | fil | haw | yi | ceb | yo | de | da | el | eo | en | eu | et | es | ru |\
\n# rw | ro | bn | be | bg | uk | jv | bs | ja | or | xh | co | ca | cy | cs | ps | pt |\
\n# pa | vi | pl | hy | hr | ht | hu | hmn | hi | ha | mg | uz | ml | mn | mi | mk | ur |\
\n# mt | ms | mr | ug | ta | my | af | sw | is | am | it | iw | sv | ar | su | zu | az |\
\n# id | ig | nl | no | ne | ny | fr | ku | fy | fa | fi | ka | kk | sr | sq | ko | kn |\
\n# km | st | sk | si | so | sn | sm | sl | ky | sd\
\n# Exemplo LANG=en,fr,pt----------- en=inglês - fr=francês - pt=português\
\n# Se estiver vazio ele deve baixar todas as legendas disponíveis\
\n#\
\nLANGUAGE=\n" > $1


}


function get_data_channel() {
    # $1 - filename_json
    # $2 - file_error

    ######## Aqui vai começar buscar informação do canal através do wget -q ########
    local base_url_channel="https://www.googleapis.com/youtube/v3/channels?\
part=contentDetails,snippet,statistics&"

    if [[ -n ${CHANNEL_YOUTUBE} ]];then
        local base_url_channel="${base_url_channel}id=${CHANNEL_YOUTUBE}&key="

    elif [[ -n ${USER_YOUTUBE} ]];then
        local base_url_channel=${base_url_channel}forUsername="${USER_YOUTUBE}&key="

    else
        echo -e "${B_RED}está faltando o ID ou o user do canal${RESET}"
        echo -e "${GREEN}out-config help ${RESET}"
        exit 1
    fi

    local base_url_channel="${base_url_channel}${API_KEY}"

    #$$=valor do pid
    wget -q -O "${1}" "$base_url_channel" 2>> $([[ -n "${2}" ]] && echo "${2}" || echo "/dev/null")
    local return_wget=$?

    # retorno 4 do wget -q é Network failure.
    if [[ $return_wget -eq 4 ]];then
        echo -e $B_RED"sem acesso a internet${RESET}"
        echo -e $B_RED$(tail -1 "${2}")$RESET
        exit 1

    # Conexão foi feita, porém o servidor respondeu um erro. Server issued an error response.
    elif [[ $return_wget -eq 8 ]];then
        if [[ $(sed -n '5p' "${2}") =~ 'ERRO 400: Bad Request' ]]; then
            echo -e $B_RED"API_KEY inválida: $API_KEY"
            exit 1

        elif [[ $(sed -n '4p' "${2}") =~ '403 Forbidden'  ]]; then
            echo -e $B_RED"Está faltando API_KEY" $RESET
            echo 
            exit 1

        elif [[ $(sed -n '4p' "${2}") =~ '400 Forbidden' ]]; then
            echo -e $B_RED"API_KEY inválida" $RESET
            echo 
            exit 1

        else
            echo "${RED}Servidor respondeu um erro não reconhecido${RESET}"
            exit 1
        fi

    elif [[ $return_wget -ne 0 ]];then
        echo ${B_RED}"Erro a usar wget${RESET}"
        echo ${B_RED}"link: $base_url_channel${RESET}"
        exit 1

    # Conexão foi feita e retornou valor normal. Mas o resultado é zero que indica que não existe esse canal
    elif [[ $(cat "${1}" | jq .pageInfo.totalResults) -eq 0 ]];then
        echo -e $B_RED"Youtube não encontrou" $([[ -n $CHANNEL_YOUTUBE ]] && echo "CHANNEL_YOUTUBE do canal: $CHANNEL_YOUTUBE" || echo "USER_YOUTUBE do canal: $USER_YOUTUBE") $RESET
        echo 
        exit 1
    fi


}

function get_data_playlist() {


    local base_url_playlist="https://www.googleapis.com/youtube/v3/playlistItems?\
part=snippet&\
maxResults=50&\
pageToken=${2}&\
playlistId=${1}&\
key=$API_KEY"
    local file_json_playlist="/tmp/playlist_$$"
    local error_json_playlist="/tmp/playlist_error_$$"

    wget -q -O "${file_json_playlist}" "${base_url_playlist}" 2> "${error_json_playlist}"
    local return_wget=$?

    if [[ $return_wget -eq 4 ]];then
        echo -e $B_RED"sem acesso a internet${RESET}"
        echo -e $B_RED$(tail -1 "/tmp/video_error_$$")$RESET
        exit 1

    elif [[ $return_wget -eq 8 ]];then

        if [[ $(tail -2 $error_json_video) =~ [0-9]+"-"[0-9]+"-"[0-9]+.*[0-9]+":"[0-9]+":"[0-9]+" ERRO 404: Not Found" ]]; then
            echo -e $B_GREEN"Não tem vídeos públicos no canal${RESET}"
            exit 1
        fi
        exit 0

    elif [[ $return_wget -ne 0 ]];then
        echo -e ${B_RED}"Erro a usar wget${RESET}"
        echo -e ${B_RED}"link: $base_url_channel${RESET}"
        exit 1
    fi

    count_video=$(cat $file_json_playlist| jq '.items | length')
    if [[ $count_video -eq 0 ]];then
        echo -e "${GREEN}Não tem vídeos nesse canal!${RESET}"
    fi

    return_get_data_playlist=$file_json_playlist
}

function get_data_video() {
    # $1 - id do canal


    local base_url_video="https://www.googleapis.com/youtube/v3/videos?\
part=snippet,contentDetails,statistics,status&\
id=${1}&\
key=$API_KEY"
    file_json_video="/tmp/videos_$$"
    error_json_video="/tmp/video_error_$$"

    wget -q -O "$file_json_video" "$base_url_video" 2> "${error_json_video}"
    local return_wget=$?

    if [[ $return_wget -ne 0 ]];then
        echo -e "Erro obter informação do id ${1} na API youtube"
        exit 0
    fi
}


function get_img(){

    # $1 - file
    # $2 - url

    if [[ ! -s "${1}" ]];then
        wget -q -O "${1}" "${2}"

        if [[ $? -ne 0 ]];then
            echo -e "${RED}Erro no download da imagem. link ${2}"
            exit 1
        fi
    fi

}



function add_data_channel() {

    # $1 - value_channel_title
    # $2 - value_channel_description
    # $3 - value_channel_highurl
    # $4 - value_channel_data
    # $5 - value_channel_uploads
    # $6 - value_channel_videocount
    # $7 - value_channel_viewcount

    local file_dados_canais="${DIRECTORY}dados-canal"

    local file_img_channel="${DIRECTORY}capa_canal.jpg"
    get_img "$file_img_channel" "$value_channel_highurl"

    echo -e "${B_YELLOW}Inserindo informações do canal: $file_dados_canais${RESET}"
    if [[ ! -s $file_dados_canais ]]; then
        > $file_dados_canais
        echo -e "Título: ${1} \n\
Description: ${2} \n\
Imagem: ${3} \n\
Data: ${4} \n\
Uploads: https://www.youtube.com/playlist?list=${5}\n\
Canal: $( [[ -z ${CHANNEL_YOUTUBE} ]] && echo "${USER_YOUTUBE}" || echo "${CHANNEL_YOUTUBE}") \n\
vídeos no canal: ${6}\n\
visualização do canal: ${7}" >> $file_dados_canais
    fi

    echo; 

}


# função inseri as informações no arquivo dados-video
function add_data_video() {
    # $1 - value_video_id
    # $2 - value_video_date
    # $3 - value_video_title
    # $4 - value_video_description
    # $5 - value_video_img
    # $6 - value_video_channeltitle
    # $7 - value_video_duration
    # $8 - value_video_definition
    # $9 - value_video_caption

    # loop 
    # em vezes que retorna "ERROR: No video formats found" falso positivo
    while true; do
# youtube-dl retorna o o diretório do out-config nome do arquivo e a extensão
        local path=$(youtube-dl -o "$DIRECTORY%(title)s-%(id)s.%(ext)s" \
-f [ext=mp4] \
--get-filename \
$( [[ "${1}" =~ "/" ]] && echo "${1}" || echo "https://www.youtube.com/watch?v=${1}"))

        if [[ ${#path} -gt 3 ]];then
            break
        fi
    done


    #retona apenas nome e a extensão
    filename_ext=$(basename "$path")

    #retorna apenas nome sem a extensão
    filename="${filename_ext%.*}"

    filename_txt="$DIRECTORY$filename.txt"

# verifica se VIDEO_QUALITY tem bestvideo e worsevideo. Caso tenha 'none' ou vazio o download não é feito como as legendas
    if [[ $VIDEO =~ ^"true" ]];then
        echo -e "${B_RESET}Video: ${B_YELLOW}${filename}.mp4${RESET}"
        filename_video="$path"

        if [[ ! -s  "$path" ]];then #verifica se o vídeo já foi baixado naquel diretório
            while true; do
                youtube-dl  -o "$DIRECTORY%(title)s-%(id)s.%(ext)s" \
-f [ext=mp4] \
$([[ $SUBTITLE =~ ^(TRUE|true)$ ]] && echo "--write-sub ") \
$([[ $AUTO_SUBTITLE =~ ^(TRUE|true)$ ]] && echo "--write-auto-sub ") \
$([[ -n $LANGUAGE ]] && echo "--sub-lang $LANGUAGE") \
$( [[ "${1}" =~ "/" ]] && echo "${1}" || echo "https://www.youtube.com/watch?v=${1}")
                return_youtube=$?

                # return youtube-dl = $?
                if [[ return_youtube -ne 0 ]]; then
                    rm $path 2> /dev/null
                    echo -e "${RED}Erro de baixar o vídeo https://www.youtube.com/watch?v=${value_playlist_videoId} . . .${RESET}"
                    echo -e "${GREEN}Recomeçar Download https://www.youtube.com/watch?v=${value_playlist_videoId}${RESET}"
                    sleep 3
                    continue
                else
                    break
                fi

            done
        else
            echo -e "Já existe um \"${filename_ext}\" no \"${DIRECTORY}\"$RESET"
        fi
    fi

# verifica se o AUDIO tem valor true para extrair apenas áudio.
    if [[ $AUDIO =~ ^(TRUE|true)$ ]];then
        filename_audio=${DIRECTORY}${filename}".mp3"
        echo -e "${B_RESET}Audio: ${B_YELLOW}${filename}.mp3${RESET}"

        #verifica se o arquivo de ádudio já existe nesse diretório
        if [[ ! -s "$DIRECTORY$filename.mp3" ]];then

            while true; do
                youtube-dl  -o "$DIRECTORY%(title)s-%(id)s.%(ext)s" \
-x --audio-format mp3 \
$( [[ "${1}" =~ "/" ]] && echo "${1}" || echo "https://www.youtube.com/watch?v=${1}")
                return_youtube=$?

                if [[ return_youtube -ne 0 ]]; then
                    echo -e "${RED}Erro de extrair audio do vídeo https://www.youtube.com/watch?v=${value_playlist_videoId} ${RESET}. . ."
                    echo -e "${GREEN}Recomeçar Download para extrair áudio https://www.youtube.com/watch?v=${value_playlist_videoId}${RESET}"
                    echo 

                    sleep 3
                    continue
                else

                    mv "${DIRECTORY}${filename}.mp3" "${DIRECTORY}$$${filename}.mp3"
                    capa_video="${DIRECTORY}${filename}.jpg"
                    wget -q -O "$capa_video" "${5}"

                    ffmpeg -i "$DIRECTORY$$$filename.mp3" -i "$capa_video" \
-loglevel 24 \
-metadata title="${3}" \
-metadata album="${6}" \
-metadata artist="${6}" \
-metadata comment="Feito pelo out-youtube: https://github.com/h4child/out-youtube" \
-write_id3v1 true \
-metadata date="${2:0:4}" \
-map_metadata 0 \
-c:a copy -c:v copy  -map 0 -map 1 \
"$DIRECTORY$filename.mp3" < /dev/null

                    rm "$DIRECTORY$$$filename.mp3"

                    break
                fi
            done
        else
            echo -e "Já existe um \"${filename}.mp3\" no \"$DIRECTORY\""$RESET
        fi
    fi

    echo -e "${B_RESET}TXT: ${B_YELLOW}${filename}.txt${RESET}"
    #testa se já existe um arquivo dados-video
    if [[ ! -s "$filename_txt" ]];then
        >"$filename_txt"

        #varios echos que apenas inseri informações do vídeo, áudio ou ambos
        echo "TÍTULO: ${3}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "DATA: ${2}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "DESCRIÇÃO: ${4}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "CAMINHO VÍDEO: $([[ -e "${path}" ]] && echo "${path}")" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "CAMINHO AUDIO: $([[ -e "${DIRECTORY}${filename}.mp3" ]] && echo "${DIRECTORY}${filename}.mp3")" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "CAPA DO VÍDEO: $([[ -e "${DIRECTORY}${filename}.jpg" ]] && echo "${DIRECTORY}${filename}.jpg")" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "ID CANAL: $( [[ -z ${CHANNEL_YOUTUBE} ]] && echo "${USER_YOUTUBE}" || echo "${CHANNEL_YOUTUBE}")" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "lINK DA CAPA: ${5}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "LINK: www.youtube.com/watch?v=${1}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "DURAÇÃO: ${7}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "QUALIDADE: ${8}" >> "${filename_txt}"
        echo  >> "${filename_txt}"

        echo "LEGENDA (NÃO AUTOMÁTICA): ${9}" >> "${filename_txt}"

        echo  >> "${filename_txt}"

        echo "inserido: TÍTULO, DATA, DESCRIÇÃO, CAMINHO VÍDEO, CAMINHO AUDIO, CAPA DO VÍDEO, ID CANAL, lINK DA CAPA, LINK, DURAÇÃO, QUALIDADE, LEGENDA"
    else
        echo -e "Já existe um \"${filename}.txt\" no \"$DIRECTORY\""$RESET
    fi

    echo -e $B_YELLOW"---------------------${RESET}"
    echo


}


function handle_data_channel() {

    local file_json_channel="/tmp/channel-$$"
    local error="/tmp/error_$$"

    echo -e "${B_YELLOW}Obter informações do canal . . . ${RESET}"
    get_data_channel $file_json_channel $error

    # 0 título canal
    local json_channel=$(cat $file_json_channel |jq .items[0].snippet.title)
    local value_channel_title=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    # 1 decrição do canal
    local json_channel=$(cat $file_json_channel |jq .items[0].snippet.description)
    local value_channel_description=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    # 2 capa canal
    local json_channel=$(cat $file_json_channel |jq .items[0].snippet.thumbnails.high.url)
    local value_channel_highurl=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    # 3 data criação do canal
    local json_channel=$(cat $file_json_channel |jq .items[0].snippet.publishedAt)
    local value_channel_data=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    # 4 id playlist
    local json_channel=$(cat $file_json_channel |jq .items[0].contentDetails.relatedPlaylists.uploads)
    local value_channel_uploads=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    # 5 números de vídeos
    local json_channel=$(cat $file_json_channel |jq .items[0].statistics.videoCount)
    local value_channel_videocount=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    # 6 visualização
    local json_channel=$(cat $file_json_channel |jq .items[0].statistics.viewCount)
    local value_channel_viewcount=$( [[ $json_channel = "null" ]] || echo "${json_channel:1:-1}")

    rm "$file_json_channel"
    rm "$error"

    # função add informações do canal
    add_data_channel "$value_channel_title" \
"$value_channel_description" \
"$value_channel_highurl" \
"$value_channel_data" \
"$value_channel_uploads" \
"$value_channel_videocount" \
"$value_channel_viewcount"
    
    #valores retornáveis
    return_handle_data_channel=("null" \
        "null" \
        "null" \
        "null" \
        "$value_channel_uploads" \
        "$value_channel_videocount" \
        "null")
}


function handle_data_video() {

    # $1 - id do canal

    get_data_video "${1}"

    local json_video=$(cat $file_json_video | jq .items[0].id)
    local value_video_id=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].snippet.publishedAt)
    local value_video_date=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].snippet.title)
    local value_video_title=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].snippet.description)
    local value_video_description=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].snippet.thumbnails.high.url)
    local value_video_img=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].snippet.channelTitle)
    local value_video_channeltitle=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].contentDetails.duration)
    local value_video_duration=$( [[ $json_video != "null" ]] && echo "${json_video:3:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].contentDetails.definition)
    local value_video_definition=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    local json_video=$(cat $file_json_video | jq .items[0].contentDetails.caption)
    local value_video_caption=$( [[ $json_video != "null" ]] && echo "${json_video:1:-1}")

    add_data_video "$value_video_id" \
"$value_video_date" \
"$value_video_title" \
"$value_video_description" \
"$value_video_img" \
"$value_video_channeltitle" \
"$value_video_duration" \
"$value_video_definition" \
"$value_video_caption"

}


function handle_data_playlist() {
    # $1 - id playlist do canal

    if [[ $VIDEO != true ]] && [[ $AUDIO != true ]];then
        return
    fi

    while true; do

        get_data_playlist "$1" "$next_page_token"

        for id_video in `seq 0 $(($count_video -1))`
        do

            local file_json_playlist=$return_get_data_playlist
            local json_playlist=$(cat $file_json_playlist | jq .items[$id_video].snippet.resourceId.videoId)
            local value_playlist_videoId=$( [[ $json_playlist != "null" ]] && echo "${json_playlist:1:-1}" || echo "")

            handle_data_video "$value_playlist_videoId"

        #    add_data_playlist  "$value_playlist_title" "$value_playlist_date" "$value_playlist_description" "$value_playlist_high_url" "$value_playlist_videoId" "$value_playlist_channel_id"
        done

        if [[ $( cat $file_json_playlist| jq .nextPageToken) != "null" ]]; then
            local next_page_token=$( cat $file_json_playlist| jq .nextPageToken)
            local next_page_token=${next_page_token:1:-1}

        else
            break
        fi

    done

}


# primeiro if serve para opção de criar o out-config
if [[ "$1" == "out" ]] && [[ -n "$2" ]]; then

    [[ ${2} = "." ]] && set -- "out" "./"; [[ ${2} = ".." ]] && set -- "out" "../";

    path_config="${2}out-config"

    if [[ -s "${2}out-config" ]]; then
        read -p "subtituir o out config (sim):" replace
        if [[ $replace != "sim" ]];then
            echo "Não substituiu!";
            exit 1
        fi
    fi

    $( > $path_config)
    if [[ $? -ne 0 ]];then
        echo "não foi possível criar arquivo ${path_config}"
        exit 1
    fi

    add_config $path_config #apenas para inserir conteúdo
    exit 0

# segundo if testa se o arquivo out-config está disponível
# [ -s "$1" ] = caso out-config foi renomeado, verifica se o arquivo $1 existe
# [ -s "out-config" ] = out-config está no diretório  atual. Nesse caso não precisa inserir out-config
# [ -d "$1""out-config" ] = apenas inseriu o diretório aonde out-config está
elif [[ -s "$1" ]] || [[ -s "out-config" ]] || [[ -d "${1}out-config" ]]; then

    #se $1 é vazio então $1=out-config
    if [[ ! -n  "$1" ]];then
        set - "out-config"
        . $1

    elif [[ -f "$1" ]];then
        . $1

    #[ -d "$1""out-config" ] 
    elif [[ -f "${1}out-config" ]];then
        set - "${1}out-config"
        . $1

    elif [[ ! -s  $1 ]];then
        echo -e "${B_RED}Não foi possível acessar o arquivo:${RESET} $1"
        exit 1

    fi

    #return array:return_handle_data_channel
    # 0 - null
    # 1 - null
    # 2 - null
    # 3 - null
    # 4 - value_channel_uploads
    # 5 - value_channel_videocount
    # 6 - null
    handle_data_channel

    if [[ ${return_handle_data_channel[5]} -ne 0 ]]; then
        handle_data_playlist ${return_handle_data_channel[4]}
    else
        echo -e "${YELLOW}Sem vídeos no canal${RESET}"
    fi

    print_final_succcess

    exit 0

else
    echo -e $B_RED "Arquivo out-config não foi encontrado${RESET}"
    echo -e $B_CYAN "Para cria-lo out-youtube.sh$GREEN out <directory>${RESET}"

    exit 1
fi

