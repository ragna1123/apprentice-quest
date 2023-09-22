echo "パスワードマネージャーへようこそ！"
echo "サービス名を入力してください:"
read service
echo "ユーザー名を入力してください:"
read user
echo "パスワードを入力してください:"
read password
echo $service:$user:$password >>password.txt
echo "Thank you!"
