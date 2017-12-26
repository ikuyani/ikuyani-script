#!/bin/bash

######################################################################
# 任意のディレクトリのファイル一覧のリンクのHTMLを出力する。
# 
# <html>
# <head>
# <title>$2<title>
# </head>
# <body>
# $3
# $5
# <a href="$7/$6">$6</a>
# <a href="$7/$6">$6</a>
# <a href="$7/$6">$6</a>
# $8
# <a href="$10/$9">$9</a>
# <a href="$10/$9">$9</a>
# $4
# </body>
# </html>
# 
# [引数]
# ・$1: 出力するHTMLファイルのパス
# ・$2: <title>の値
# ・$3: <body>上部に表示する内容のテキストファイル
# ・$4: <body>下部に表示する内容のテキストファイル
# 以降、引数3つ毎にループ
# ・$5: ファイルタイトル
# ・$6: 対象ファイルのパターン (e.g. /var/www/ikuyani/xxx/hoge_*.zip)
# ・$7: HTML上のリンクのパス (e.g. /xxx)
# 
# [Example]
# ・tar.gzとzipの一覧を出力する
# ./html_filelist.sh "/var/www/ikuyani/filelist.html" "File download"
# "/home/ikuyani/header.txt" "/home/ikuyani/footer.txt" \
# "TAR.GZ list" "/var/www/ikuyani/xxx/*.tar.gz" "/xxx" \
# "ZIP list" "/var/www/ikuyani/xxx/*.zip" "/xxx"
######################################################################

v_html=${1}
v_title=${2}
v_header=${3}
v_footer=${4}

if [ -z "${v_html}" ]; then
  echo "html is null."
  exit 1
fi

rm -f ${v_html}
echo "<html>" >> ${v_html}
echo "<head>" >> ${v_html}
echo "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">" >> ${v_html}
if [ -n "${v_title}" ]; then
  echo "<title>${v_title}</title>" >> ${v_html}
fi

echo "</head>" >> ${v_html}
echo "<body>" >> ${v_html}

if [ -n "${v_header}" -a -f "${v_header}" ]; then
  echo "<p>" >> ${v_html}
  v_msg=`cat "${v_header}"`
  echo "${v_msg}" >> ${v_html}
  echo "</p>" >> ${v_html}
fi

v_count=1
v_pattern=
v_link_path=
v_subject=
for i in "${@}"
do
  if [ ${v_count} -gt 4 ]; then
    if [ ${v_count} -eq 5 ]; then
      v_subject=${i}

    elif [ ${v_count} -eq 6 ]; then
      v_pattern=${i}

    elif [ ${v_count} -eq 7 ]; then
      v_link_path=${i}
      if [ -n "${v_subject}" ]; then
        echo "<p>${v_subject}</p>" >> ${v_html}
      fi
      echo "<p>" >> ${v_html}
      for file in ${v_pattern}; do
        if [ -f ${file} ]; then
          if [ -n "${v_link_path}" ]; then
            echo "<a href="${v_link_path}/${file##*/}">${file##*/}</a><br>" >> ${v_html}
          else
            echo "<a href="${file##*/}">${file##*/}</a><br>" >> ${v_html}
          fi
        fi
      done
      echo "</p>" >> ${v_html}

      v_count=4
    fi
  fi

v_count=$(expr $v_count + 1)
done

if [ -n "${v_footer}" -a -f "${v_footer}" ]; then
  echo "<p>" >> ${v_html}
  v_msg=`cat "${v_footer}"`
  echo "${v_msg}" >> ${v_html}
  echo "</p>" >> ${v_html}
fi

echo "</body>" >> ${v_html}
echo "</html>" >> ${v_html}

