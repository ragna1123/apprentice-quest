echo "パスワードマネージャーへようこそ！"
echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
while :
do
read select_mode
case "$select_mode" in 
	"Add Password")
		echo "サービス名を入力してください:"
		read service
		echo "ユーザー名を入力してください:"
		read user
		echo "パスワードを入力してください:"
		read password
		echo $service:$user:$password >> password.txt
		echo "パスワードの追加は成功しました";;
	"Get Password")
		echo "サービス名を入力してくだい:"
		read service;;
	"Exit")
		echo "Thank you!"
		exit 0;;
	*)
	echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。";;
	esac
done
