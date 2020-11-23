import React from "react"

class InvitationForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            answer: 1
        }
    }

    onClickAcceptButton(){
        let result = confirm("招待を受諾してプロジェクトに加入しますか？");

        if(result){
            this.setState({answer: 2},()=>{
                document.getElementById(`react-invitation-answer${this.props.info.id}`).click();
            });
        }
    }

    onClickRejectButton(){
        let result = confirm("招待を拒否しますか？");

        if(result){
            this.setState({answer: 3},()=>{
                document.getElementById(`react-invitation-answer${this.props.info.id}`).click();
            });
        }
    }

    render(){
        return(
            <div>
                <form action={"/invitations"} method={"POST"} className={"invitations-form"}>
                    <h4>プロジェクト</h4>
                    <div className={"project-info"}>
                        <div className={"project-image"}>
                            <a href={`/projects/${this.props.info.project.permalink}`}>
                                <img src={this.props.info.project.image} alt={"/NoProjectImage.png"}/>
                            </a>
                        </div>
                        <div className={"project-title"}>
                            <a href={`/projects/${this.props.info.project.permalink}`}>
                                {this.props.info.project.title}
                            </a>
                        </div>
                        <div className={"project-owner-user"}>
                            <div className={"owner-user-image"}>
                                <a href={`/users/${this.props.info.project.ownerUser.permalink}`}>
                                    <img src={this.props.info.project.ownerUser.image} alt={"/NoUserImage.png"}/>
                                </a>
                            </div>
                            <div className={"owner-user-title"}>
                                プロジェクトオーナー
                            </div>
                            <div className={"owner-user-name"}>
                                <a href={`/users/${this.props.info.project.ownerUser.permalink}`}>
                                    {this.props.info.project.ownerUser.name}
                                </a>
                            </div>
                        </div>
                        <div className={"project-description"}>
                            {this.props.info.project.description}
                        </div>
                    </div>
                    <h4>招待ポジション</h4>
                    <div className={"invited-position"}>
                        {this.props.info.position.name}
                    </div>
                    <div className={"buttons-container"}>
                        <button type={"button"} className={"button-accept"} onClick={()=>{this.onClickAcceptButton()}}>
                            受諾
                        </button>
                        <button type={"button"} className={"button-reject"} onClick={()=>{this.onClickRejectButton()}}>
                            拒否
                        </button>
                    </div>

                    <input type={"hidden"} name={"project_id"} value={this.props.info.project.id}/>
                    <input type={"hidden"} name={"user_id"} value={this.props.info.user.id}/>
                    <input type={"hidden"} name={"position_id"} value={this.props.info.position.id}/>
                    <input type={"hidden"} name={"result_code"} value={this.state.answer}/>
                    <input type={"submit"} id={`react-invitation-answer${this.props.info.id}`}/>
                </form>
            </div>
        )
    }
}

export default InvitationForm
