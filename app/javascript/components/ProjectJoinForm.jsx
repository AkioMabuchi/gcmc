import React from "react"

class ProjectJoinForm extends React.Component {
    constructor(props) {
        super(props);
    }

    render(){
        return(
            <div>
                <form action={`/projects/${this.props.info.permalink}/join`} method={"POST"} className={"project-join-form"}>
                    <input type={"hidden"} name={"id"} value={this.props.info.id}/>
                    <h4>現在募集中の役割</h4>
                    <ul className={"wanted-positions"}>
                        {
                            this.props.info.positions.map((position)=>{
                                return(
                                    <li>
                                        <div className={"position-name"}>
                                            {position.name}
                                        </div>
                                        <div className={"position-amount"}>
                                            {position.amount}名
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
                                    <option value={position.position_id}>
                                        {position.name}
                                    </option>
                                );
                            })
                        }
                    </select>
                    <button type={"submit"}>申請</button>
                </form>
            </div>
        );
    }
}

export default ProjectJoinForm
