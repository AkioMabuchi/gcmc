import React from "react"

class ProjectSettingPublishForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            publishCode: this.props.info.publishCode
        };
    }

    onChangeRadioPublish(e) {
        this.setState({publishCode: e.target.value});
    }

    render() {

        let radioNames = {
            "0":"非公開",
            "1":"メンバー限定公開",
            "2":"限定公開",
            "3":"公開"
        };

        let radios = [
            ["0", "非公開"],
            ["1", "メンバー限定公開"],
            ["2", "限定公開"],
            ["3", "公開"]
        ];

        let descriptions = {
                "0": "オーナーだけがアクセスでき、検索結果には表示されません",
                "1": "オーナーとメンバーだけがアクセスできます、検索結果には表示されません",
                "2": "すべてのユーザーにアクセスできますが、検索結果には表示されません",
                "3": "すべてのユーザーにアクセスでき、検索結果に表示されます"
            };


        return (
            <div>
                <form action={`/projects/${this.props.info.permalink}/settings/publish`} method={"POST"}
                      className={"settings-form publish-setting-form"}>
                    <h3>公開設定</h3>
                    <h4>現在の公開状況：{radioNames[this.props.info.publishCode]}</h4>
                    <ul className={"publish-radios"}>
                        {
                            radios.map((radio) => {
                                return (
                                    <li>
                                        <input
                                            type={"radio"}
                                            name={"publish"}
                                            value={radio[0]}
                                            defaultChecked={this.props.info.publishCode === radio[0]}
                                            onChange={(e) => {
                                                this.onChangeRadioPublish(e)
                                            }}
                                        />
                                        {radio[1]}
                                    </li>
                                );
                            })
                        }
                    </ul>
                    <div className={"publish-description"}>
                        {descriptions[this.state.publishCode]}
                    </div>
                    <button type={"submit"}>更新</button>
                </form>
            </div>
        );
    }
}

export default ProjectSettingPublishForm
