import React from "react"

class InviteForm extends React.Component {
    constructor(props) {
        super(props);
    }

    onClickButtonInvite(){
        let result = confirm(`${this.props.info.user.name}を上記プロジェクトに招待しますか？`);

        if(result){
            document.getElementById(`react-user-invite-submit${this.props.info.project.id}`).click();
        }
    }

    render() {
        return(
            <div>
                <form action={`/users/${this.props.info.user.permalink}/invite`} method={"POST"} className={"user-invite-form"}>
                    <div className={"project-info"}>
                        <div className={"project-info-image"}>
                            <a href={`/projects/${this.props.info.project.permalink}`}>
                                <img src={this.props.info.project.image} alt={"/NoProjectImage.png"}/>
                            </a>
                        </div>
                        <div className={"project-info-title"}>
                            <a href={`/projects/${this.props.info.project.permalink}`}>
                                {this.props.info.project.title}
                            </a>
                        </div>
                        <div className={"project-info-description"}>
                            {this.props.info.project.description}
                        </div>
                    </div>
                    <h4>招待役割</h4>
                    <input type={"hidden"} name={"project_id"} value={this.props.info.project.id}/>
                    <input type={"hidden"} name={"user_id"} value={this.props.info.user.id}/>
                    <select name={"position_id"}>
                        {
                            this.props.info.positions.map((position)=>{
                                return(
                                    <option value={position.position_id}>
                                        {position.name}
                                    </option>
                                );
                            })
                        }
                    </select>
                    <button type={"button"} onClick={()=>{this.onClickButtonInvite()}}>招待</button>
                    <input type={"submit"} id={`react-user-invite-submit${this.props.info.project.id}`}/>
                </form>
            </div>
        );
    }
}

export default InviteForm
