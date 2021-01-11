import React from "react"

class SignupDetailsForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        let permalinkWarning;
        let emailWarning;
        let passwordWarning;
        let passwordConfirmationWarning;

        if (this.props.info.permalinkWarning !== null) {
            permalinkWarning = (
                <div className={"warning"}>
                    {this.props.info.permalinkWarning}
                </div>
            );
        }

        if (this.props.info.emailWarning !== null) {
            emailWarning = (
                <div className={"warning"}>
                    {this.props.info.emailWarning}
                </div>
            );
        }

        if (this.props.info.passwordWarning !== null) {
            passwordWarning = (
                <div className={"warning"}>
                    {this.props.info.passwordWarning}
                </div>
            );
        }

        if (this.props.info.passwordConfirmationWarning !== null) {
            passwordConfirmationWarning = (
                <div className={"warning"}>
                    {this.props.info.passwordConfirmationWarning}
                </div>
            );
        }
        return (
            <div>
                <form action={"/signup/details"} method={"POST"} className={"signup-details-form"}>
                    <input type={"hidden"} name={"hash"} value={this.props.info.hash}/>
                    <h4>ユーザーID<small>（必須、24字以内の英数字及びハイフンのみ）</small></h4>
                    <input type={"text"} name={"permalink"} defaultValue={this.props.info.permalink}/>
                    {permalinkWarning}

                    <h4>メールアドレス<small>（必須）</small></h4>
                    <input type={"email"} name={"email"} defaultValue={this.props.info.email}/>
                    {emailWarning}

                    <h4>パスワード<small>（8字以上、32字以内）</small></h4>
                    <input type={"password"} name={"password"} defaultValue={this.props.info.password}/>
                    {passwordWarning}

                    <h4>パスワード<small>（確認用）</small></h4>
                    <input type={"password"} name={"password_confirmation"}
                           defaultValue={this.props.info.passwordConfirmation}/>
                    {passwordConfirmationWarning}

                    <button type={"submit"}>新規登録</button>
                </form>
            </div>
        );
    }
}

export default SignupDetailsForm
