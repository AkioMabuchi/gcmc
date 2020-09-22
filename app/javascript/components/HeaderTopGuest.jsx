import React from "react"
class HeaderTopGuest extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            h1: "hide",
            p: "hide"
        }
    }

    componentDidMount() {
        setTimeout(() => {
            this.setState({h1: "show"});
            setTimeout(()=>{
                this.setState({p: "show"});
            },1000);
        },500);
    }

    render(){
        return(
            <div>
                <a href={'/'} className={'header-logo'}/>
                <a href={"/login"} className={"login-button"}/>
                <div>
                    <a href={"/login"} className={"guest-button"}>ログイン</a>
                    <a href={"/signup"} className={"guest-button"}>新規登録</a>
                </div>
                <h1 className={this.state.h1}>一緒にゲームを開発しよう！</h1>
                <p className={this.state.p}>GCMCは他のゲーム開発者をマッチングさせ<br/>共同開発を支援するサービスです</p>
                <a href={'/signup'} className={'signup-button'}>今すぐ新規登録</a>
            </div>
        )
    }
}

export default HeaderTopGuest
