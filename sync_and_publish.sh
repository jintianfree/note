
git add .
git commit -m 'update' -a
git push origin master
./hugo

rm -r ../note.github.io/*
cp -r public/* ../note.github.io/
cd ../note.github.io/
git add .
git commit -m 'update' -a
git push origin master
