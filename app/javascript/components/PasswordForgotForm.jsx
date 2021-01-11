import React from "react"

class PasswordForgotForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        let emailWarning;

        if(this.props.info.emailWarning !== null){
            emailWarning = (
                <div className={"warning"}>
                    {this.props.info.emailWarning}
                </div>
            );
        }
        return(
            <div>
                <form action={"/login/forgot"} method={"POST"} className={"forgot-password-form"}>
                    <div className={"description"}>
                        <h3>パスワードをお忘れの方へ</h3>
                        <p>パスワードを再設定するには、ご利用中のメールアドレスを入力してください</p>
                        <p>メールが届いたら、メールに記載されているリンクをクリックしてパスワードを再設定してください</p>
                    </div>
                    <h4>ご利用中のメールアドレス</h4>
                    <input type={"email"} name={"email"}/>
                    {emailWarning}

                    <button type={"submit"}>確認メール送信</button>
                </form>
            </div>
        )
    }
}

export default PasswordForgotForm
