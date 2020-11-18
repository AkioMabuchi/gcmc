import React from "react"

class UserSettingEmailForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        let currentEmailWarning;
        let newEmailWarning;

        return(
            <div>
                <form action={"/settings/email"} method={"POST"} className={"settings-form setting-email-form"}>
                    <h3>メールアドレス設定</h3>
                    <div className={"email-notice"}>
                        メールアドレスを更新される場合、再度本人確認をさせていただきます。
                        本人確認の終了後、新しいメールアドレスでのログインが可能となります。
                    </div>
                    <h4>現在のメールアドレス</h4>
                    <input type={"email"} name={"current_email"}/>
                    {currentEmailWarning}

                    <h4>新しいメールアドレス<small>（必須）</small></h4>
                    <input type={"email"} name={"new_email"}/>
                    {newEmailWarning}

                    <button type={"submit"}>更新</button>
                </form>
            </div>
        )
    }
}

export default UserSettingEmailForm
