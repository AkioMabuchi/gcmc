import React from "react"
class TopSection extends React.Component {
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
                <h1 className={this.state.h1}>一緒にゲームを作ろう！</h1>
                <p className={this.state.p}>GCMCは他のゲーム開発者をマッチングさせ<br/>共同開発を支援するサービスです</p>
            </div>
        )
    }
}

export default TopSection