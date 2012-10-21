name=$1
git=$2

mkdir enabled -p
mkdir sites/$name -p

mkdir sites/$name/logs
mkdir sites/$name/public

sed "s/HOSTNAME/$name/g" draft/nginx.conf > sites/$name/nginx.conf
sed "s/HOSTNAME/$name/g" draft/index.html > sites/$name/public/index.html

ln sites/$name/nginx.conf enabled/$name.conf

if [ $git ]; then
  git clone $git sites/$name/git
  cp draft/post-receive sites/$name/git/.git/hooks/.
  cp draft/post-update sites/$name/git/.git/hooks/.

  cd sites/$name/git
  git config receive.denycurrentbranch ignore
  make setup

  cd ../../../
fi
