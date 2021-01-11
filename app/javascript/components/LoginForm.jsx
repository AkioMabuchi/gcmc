import React from "react"

class LoginForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={"/login"} method={"POST"} className={"login-form"}>
                    <h4>メールアドレス</h4>
                    <input type={"email"} name={"email"}/>
                    <h4>パスワード</h4>
                    <input type={"password"} name={"password"}/>
                    <div className={"forgot-password"}>
                        <a href={"/login/forgot"}>
                            パスワードをお忘れですか？
                        </a>
                    </div>
                    <button type={"submit"}>
                        ログイン
                    </button>
                </form>
            </div>
        );
    }
}

export default LoginForm
