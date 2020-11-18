import React from "react"

class ProjectSettingWantsForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        let amountWarning;

        if(this.props.info.amountWarning !== null){
            amountWarning = (
                <div className={"warning"}>
                    {this.props.info.amountWarning}
                </div>
            );
        }

        return(
            <div>
                <form action={`/projects/${this.props.info.permalink}/settings/wants`} method={"POST"} className={"settings-form wants-setting-form"}>
                    <h3>募集設定</h3>
                    <h4>現在の募集一覧</h4>
                    <ul className={"wants-list"}>
                        {
                            this.props.info.wants.map((want)=>{
                                return(
                                    <li>
                                        <div className={"want-name"}>
                                            {want.name}
                                        </div>
                                        <div className={"want-amount"}>
                                            {want.amount}名
                                        </div>
                                    </li>
                                );
                            })
                        }
                    </ul>
                    <h4>役割</h4>
                    <select name={"position"}>
                        {
                            this.props.info.positions.map((position)=>{
                                return(
                                    <option value={position.id}>
                                        {position.name}
                                    </option>
                                );
                            })
                        }
                    </select>
                    <h4>人数<small>（0~99）</small></h4>
                    <input type={"number"} name={"amount"} defaultValue={1}/>
                    <div className={"amount-explanation"}>
                        一覧から削除したい場合は「0」を入力してください
                    </div>
                    {amountWarning}
                    <button type={"submit"}>更新</button>
                </form>
            </div>
        );
    }
}

export default ProjectSettingWantsForm
