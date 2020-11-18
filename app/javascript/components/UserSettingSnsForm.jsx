import React from "react"

class UserSettingSnsForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        let emailNotice;
        let isDisabled = !this.props.info.hasEmail && !(this.props.info.hasTwitter && this.props.info.hasGitHub);
        let twitterForm;
        let twitterWarning;
        let githubForm;
        let githubWarning;
        let buttonSubmit;

        if(!this.props.info.hasEmail){
            emailNotice = (
                <div className={"email-notice"}>
                    <div className={"caution"}>
                        このアカウントにはメールアドレスが登録されまいません
                    </div>
                    <div className={"description"}>
                        この状態では二度とログインできなくなるため、全てのSNS連携を解除することはできません
                    </div>
                </div>
            )
        }
        if(this.props.info.hasTwitter){
            twitterForm = (
                <div>
                    <h5>このアカウントはTwitterと連携済みです</h5>
                    <form action={"/settings/sns/disconnect/twitter"} method={"POST"} className={"setting-sns-form-2"}>
                        <button type={"submit"} className={"disconnect-twitter"} disabled={isDisabled}>
                            <i className={"fab fa-twitter"}/> Twitterとの連携を解除
                        </button>
                    </form>
                    <input type={"checkbox"} name={"is_publish_twitter"} defaultChecked={this.props.info.isPublishedTwitter}/>URL公開
                </div>
            );
        }else{
            twitterForm = (
                <div>
                    <form action={"/auth/twitter"} method={"POST"} className={"setting-sns-form-2"}>
                        <button type={"submit"} className={"connect-twitter"}>
                            <i className={"fab fa-twitter"}/> Twitterと連携する
                        </button>
                    </form>
                </div>
            );
        }

        if(this.props.info.twitterWarning !== null){
            twitterWarning = (
                <div className={"warning"}>
                    {this.props.info.twitterWarning}
                </div>
            );
        }

        if(this.props.info.hasGitHub){
            githubForm = (
                <div>
                    <h5>このアカウントはGitHubと連携済みです</h5>
                    <form action={"/settings/sns/disconnect/github"} method={"POST"} className={"setting-sns-form-2"}>
                        <button type={"submit"} className={"disconnect-github"} disabled={isDisabled}>
                            <i className={"fab fa-github"}/> GitHubとの連携を解除
                        </button>
                    </form>
                    <input type={"checkbox"} name={"is_publish_github"} defaultChecked={this.props.info.isPublishedGitHub}/>URL公開
                </div>
            );
        }else{
            githubForm = (
                <div>
                    <form action={"/auth/github"} method={"POST"} className={"setting-sns-form-2"}>
                        <button type={"submit"} className={"connect-github"}>
                            <i className={"fab fa-github"}/> GitHubと連携する
                        </button>
                    </form>
                </div>
            );
        }

        if(this.props.info.githubWarning){
            githubWarning = (
                <div className={"warning"}>
                    {this.props.info.githubWarning}
                </div>
            );
        }

        if(this.props.info.hasTwitter || this.props.info.hasGitHub){
            buttonSubmit = (
                <button type={"submit"}>
                    更新
                </button>
            );
        }

        return(
            <div>
                <form action={"/settings/sns"} method={"POST"} className={"settings-form setting-sns-form"}>
                    <h3>SNS設定</h3>
                    {emailNotice}
                    <h4>Twitter連携</h4>
                    {twitterForm}
                    {twitterWarning}
                    <h4>GitHub連携</h4>
                    {githubForm}
                    {githubWarning}
                    {buttonSubmit}
                </form>
            </div>
        );
    }
}

export default UserSettingSnsForm
