import React from "react"

class UserSettingInvitationsForm extends React.Component {
    constructor(props) {
        super(props);
        if(this.props.info.defaultPosition !== null){
            if(this.props.info.currentPositionsIds.includes(this.props.info.defaultPosition.id)){
                this.state = {
                    buttonName: "削除",
                    buttonClass: "destroy",
                    buttonDisabled: false
                }
            }else{
                this.state = {
                    buttonName: "追加",
                    buttonClass: "",
                    buttonDisabled: false
                }
            }
        }else{
            this.state = {
                buttonName: "追加",
                buttonClass: "",
                buttonDisabled: true
            }
        }

    }

    onChangePosition(e){
        if(this.props.info.currentPositionsIds.includes(Number(e.target.value))){
            this.setState({buttonName: "削除"});
            this.setState({buttonClass: "destroy"});
        }else{
            this.setState({buttonName: "追加"});
            this.setState({buttonClass: ""});
        }
    }

    render(){
        return(
            <div>
                <form action={"/settings/invitations"} method={"POST"} className={"settings-form setting-invitations-form"}>
                    <h3>招待設定</h3>
                    <h4>現在の招待されたい役割</h4>
                    <ul className={"invitations"}>
                        {
                            this.props.info.currentPositionsNames.map((name)=>{
                                return(
                                  <li>
                                      {name}
                                  </li>
                                );
                            })
                        }
                    </ul>
                    <h4>役割</h4>
                    <select name={"position"} onChange={(e)=>{this.onChangePosition(e)}}>
                        {
                            this.props.info.selectablePositions.map((position)=>{
                                return(
                                    <option value={position.id}>
                                        {position.name}
                                    </option>
                                );
                            })
                        }
                    </select>
                    <div className={"detail"}>
                        どの役割にも招待されたくない場合は、上記にある役割を選択して、全てリストから削除してください
                    </div>
                    <div className={"detail"}>
                        また、<a href={"/settings"}>プロフィール設定</a>の担当をチェックする必要がございます
                    </div>
                    <button type={"submit"} className={this.state.buttonClass} disabled={this.state.buttonDisabled}>
                        {this.state.buttonName}
                    </button>
                </form>
            </div>
        )
    }
}

export default UserSettingInvitationsForm
