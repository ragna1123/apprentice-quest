echo "パスワードマネージャーへようこそ！"
echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
while :; do

	FILE=password.txt
	ENC_FILE=encrypted_file.txt.gpg
	USER_NAME=haga

	read inp_select_mode

	case "$inp_select_mode" in
	"Add Password")
		echo "サービス名を入力してください:"
		read service
		echo "ユーザー名を入力してください:"
		read user
		echo "パスワードを入力してください:"
		read password

		# 追記するために暗号ファイルを復号
		gpg -o $FILE -d $ENC_FILE
		echo "$service:$user:$password" >>$FILE
		echo "パスワードの追加は成功しました"
		# 上書きをするために更新前の暗号化ファイルは削除
		rm $ENC_FILE
		# 再暗号化とテキストファイル削除
		gpg -r $USER_NAME -eao $ENC_FILE $FILE
		rm $FILE

		echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
		;;

	"Get Password")
		decrypted_data=$(gpg -d $ENC_FILE)
		echo "サービス名を入力してくだい:"
		read inp_service_name

		# 登録件数のフラグ管理値　0なら該当なし
		service_found=0

		while IFS=: read -r service user password; do
			if [ "$inp_service_name" = "$service" ]; then
				echo "サービス名:$service"
				echo "ユーザー名:$user"
				echo "パスワード:$password\n"
				service_found=$(expr $service_found + 1)
			fi
		done <<<"$decrypted_data"

		if [ "$service_found" -eq 0 ]; then
			echo "そのサービスは登録されていません。"
		fi

		echo "次の選択肢から入力してください(Add Password/Get Password/Exit):"
		;;

	"Exit")
		echo "Thank you!"
		exit 0
		;;

	*)
		echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
		;;

	esac
done
