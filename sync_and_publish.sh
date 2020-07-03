
sync() {
  git add .
  git commit -m 'update' -a
  git push origin master
}

sync_and_publish() {
  git add .
  git commit -m 'update' -a
  git push origin master
  ./hugo
  
  cd ../note.github.io/
  rm -r *
  cp -r ../note/public/* .
  git add .
  git commit -m 'update' -a
  git push origin master
}

loacl_server() {
    ./hugo server
}

case $1 in
"srv")
   loacl_server 
;;
"sync")
    sync
;;
"pub")
    sync_and_publish
;;
*)
    echo "Usage: " $0 "srv|sync|pub"
esac