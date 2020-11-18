import React from "react"

class UserSettingPasswordForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={"/settings/password"} method={"POST"} className={"settings-form"}>
                    <h3>パスワード変更</h3>
                    <h4>現在のパスワード</h4>
                    <input type={"password"} name={"current_password"}/>
                    <h4>新しいパスワード<small>（8字以上、32字以内）</small></h4>
                    <input type={"password"} name={"new_password"}/>
                    <h4>新しいパスワード<small>（確認用）</small></h4>
                    <input type={"password"} name={"new_password_confirmation"}/>
                    <button type={"submit"}>変更</button>
                </form>
            </div>
        );
    }
}

export default UserSettingPasswordForm
