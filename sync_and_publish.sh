
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
