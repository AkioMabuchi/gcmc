import React from "react"

class PasswordResetForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        let passwordWarning;
        let passwordConfirmationWarning;

        if(this.props.info.passwordWarning !== null){
            passwordWarning = (
                <div className={"warning"}>
                    {this.props.info.passwordWarning}
                </div>
            );
        }

        if(this.props.info.passwordConfirmationWarning !== null){
            passwordConfirmationWarning = (
                <div className={"warning"}>
                    {this.props.info.passwordConfirmationWarning}
                </div>
            );
        }
        return(
            <div>
                <form action={"/reset"} method={"POST"} className={"reset-password-form"}>
                    <input type={"hidden"} name={"hash"} value={this.props.info.hash}/>
                    <h4>新しいパスワード<small>（8字以上、32字以内）</small></h4>
                    <input type={"password"} name={"password"} defaultValue={this.props.info.password}/>
                    {passwordWarning}

                    <h4>新しいパスワード<small>（確認用）</small></h4>
                    <input type={"password"} name={"password_confirmation"} defaultValue={this.props.info.passwordConfirmation}/>
                    {passwordConfirmationWarning}

                    <button type={"submit"}>再設定</button>
                </form>
            </div>
        );
    }
}

export default PasswordResetForm
