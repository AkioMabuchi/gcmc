import React from "react"

class ProjectJoinRequestForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            answer: 1
        }
    }

    onClickAcceptButton(){
        let result = confirm(`${this.props.info.user.name}をプロジェクトに加入させますか？`);

        if(result){
            this.setState({answer: 2},()=>{
                document.getElementById(`react-join-request-answer${this.props.info.id}`).click();
            });
        }
    }

    onClickRejectButton(){
        let result = confirm(`${this.props.info.user.name}のプロジェクト加入を拒否しますか？`);

        if(result){
            this.setState({answer: 3},()=>{
                document.getElementById(`react-join-request-answer${this.props.info.id}`).click();
            });
        }
    }

    render(){
        return(
            <div>
                <form action={`/projects/${this.props.info.project.permalink}/requests`} method={"POST"} className={"project-join-request-form"}>
                    <input type={"hidden"} name={"id"} value={this.props.info.id}/>
                    <input type={"hidden"} name={"answer"} value={this.state.answer}/>
                    <h4>応募ユーザー</h4>
                    <div className={"applicant-user"}>
                        <div className={"applicant-user-image"}>
                            <a href={`/users/${this.props.info.user.permalink}`}>
                                <img src={this.props.info.user.image} alt={"/NoUserImage.png"}/>
                            </a>
                        </div>
                        <div className={"applicant-user-name"}>
                            <a href={`/users/${this.props.info.user.permalink}`}>
                                {this.props.info.user.name}
                            </a>
                        </div>
                    </div>
                    <h4>希望ポジション</h4>
                    <div className={"wanted-position"}>
                        {this.props.info.position.name}
                    </div>
                    <div className={"buttons-container"}>
                        <button type={"button"} className={"button-accept"} onClick={()=>{this.onClickAcceptButton()}}>
                            承認
                        </button>
                        <button type={"button"} className={"button-reject"} onClick={()=>{this.onClickRejectButton()}}>
                            拒否
                        </button>
                    </div>
                    <input type={"submit"} id={`react-join-request-answer${this.props.info.id}`}/>
                </form>
            </div>
        );
    }
}

export default ProjectJoinRequestForm
