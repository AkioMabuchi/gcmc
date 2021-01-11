import React from "react"

class SignupForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        let permalinkWarning;
        let nameWarning;
        let emailWarning;
        let passwordWarning;
        let passwordConfirmationWarning;
        let agreementWarning;
        let captchaWarning;

        if (this.props.info.permalinkWarning !== null) {
            permalinkWarning = (
                <div className={"warning"}>
                    {this.props.info.permalinkWarning}
                </div>
            );
        }

        if (this.props.info.nameWarning !== null) {
            nameWarning = (
                <div className={"warning"}>
                    {this.props.info.nameWarning}
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

        if (this.props.info.agreementWarning !== null) {
            agreementWarning = (
                <div className={"warning"}>
                    {this.props.info.agreementWarning}
                </div>
            );
        }

        if (this.props.info.captchaWarning !== null) {
            captchaWarning = (
                <div className={"warning"}>
                    {this.props.info.captchaWarning}
                </div>
            );
        }

        return (
            <div>
                <form action={"/signup"} method={"POST"} className={"signup-form"}>
                    <h4>ユーザーID<small>（必須、24字以内の英数字及びハイフンのみ）</small></h4>
                    <input type={"text"} name={"permalink"} defaultValue={this.props.info.permalink}/>
                    {permalinkWarning}

                    <h4>ユーザー名<small>（必須、24字以内）</small></h4>
                    <input type={"text"} name={"name"} defaultValue={this.props.info.name}/>
                    {nameWarning}

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

                    <div className={"checkbox"}>
                        <input type={"checkbox"} name={"agreement"} defaultChecked={this.props.info.agreement}/>利用規約およびプライバシーポリシーに同意します
                    </div>
                    {agreementWarning}

                    <div className={"recaptcha"}>
                        <div className={"g-recaptcha"} data-callcak={"clearcall"}
                             data-sitekey={this.props.info.recaptchaSiteKey}/>
                    </div>
                    {captchaWarning}

                    <button type={"submit"}>新規登録</button>
                </form>
            </div>
        );
    }
}

export default SignupForm
