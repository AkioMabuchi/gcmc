import React from "react"

class UserSettingPortfoliosForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            image: "/NoPortfolioImage.png",
            imageWarning: "",
            buttonName: "追加",
            buttonSubmit: "",
            selectedId: "0",
            hasNameNotice: false
        };
    }

    onClickButtonPortfolio(portfolio){
        if(this.state.selectedId !== portfolio.id) {
            this.setState({selectedId: portfolio.id});
            this.setState({image: portfolio.image.url});
            this.setState({buttonName: "更新"});
            this.setState({buttonSubmit: "update"});
            this.setState({hasNameNotice: true});
            document.getElementsByName("name")[0].value = portfolio.name;
            document.getElementsByName("image")[0].value = "";
            document.getElementsByName("period")[0].value = portfolio.period;
            document.getElementsByName("description")[1].value = portfolio.description;
            document.getElementsByName("url")[0].value = portfolio.url;
        }else{
            this.setState({selectedId: "0"});
            this.setState({image: "/NoPortfolioImage.png"});
            this.setState({buttonName: "追加"});
            this.setState({buttonSubmit: ""});
            this.setState({hasNameNotice: false});
            document.getElementsByName("name")[0].value = "";
            document.getElementsByName("image")[0].value = "";
            document.getElementsByName("period")[0].value = "";
            document.getElementsByName("description")[1].value = "";
            document.getElementsByName("url")[0].value = "";
        }
    }

    onChangeInputImage(e){
        let createObjectURL = (window.URL || window.webkitURL).createObjectURL || window.createObjectURL;
        let file = e.target.files[0];
        let imageInput = document.getElementsByName("image")[0];

        if(!(imageInput.value === "")) {
            let fileNameRegExp = /\.(jpg|jpeg|png|gif|JPG|JPEG|PNG|GIF)$/;
            if (!(file.type.match("image.*"))) {
                this.setState({image: this.props.info.image});
                this.setState({imageWarning: "画像ファイルをアップロードしてください"});
                imageInput.value = "";
            }else if(!(fileNameRegExp.test(file.name))){
                this.setState({image: this.props.info.image});
                this.setState({imageWarning: "gif、png、jpegのいずれかの画像をアップロードしてください"});
                imageInput.value = "";
            }else if(file.size > 2097152){
                this.setState({image: this.props.info.image});
                this.setState({imageWarning: "2MB以下の画像ファイルをアップロードしてください"});
                imageInput.value = "";
            }else{
                this.setState({image: createObjectURL(file)});
                this.setState({imageWarning: ""});
            }
        }else{
            this.setState({image: this.props.info.image});
            this.setState({imageWarning: ""});
        }
    }

    render(){
        let nameNotice;
        let nameWarning;
        let imageWarning;
        let periodWarning;
        let descriptionWarning;
        let urlWarning;

        if(this.state.hasNameNotice){
            nameNotice = (
                <div className={"name-notice"}>
                    ポートフォリオをリストから削除する場合は<br/>上記を空欄にしてください
                </div>
            )
        }
        if(this.props.info.nameWarning !== null){
            nameWarning = (
                <div className={"warning"}>
                    {this.props.info.nameWarning}
                </div>
            );
        }

        if(this.state.imageWarning !== ""){
            imageWarning = (
                <div className={"warning"}>
                    {this.state.imageWarning}
                </div>
            );
        }

        if(this.props.info.periodWarning !== null){
            periodWarning = (
                <div className={"warning"}>
                    {this.props.info.periodWarning}
                </div>
            );
        }

        if(this.props.info.descriptionWarning !== null){
            descriptionWarning = (
                <div className={"warning"}>
                    {this.props.info.descriptionWarning}
                </div>
            );
        }

        if(this.props.info.urlWarning !== null){
            urlWarning = (
                <div className={"warning"}>
                    {this.props.info.urlWarning}
                </div>
            );
        }

        return(
            <div>
                <form action={"/settings/portfolios"} method={"POST"} className={"settings-form setting-portfolios-form"} encType={"multipart/form-data"}>
                    <h3>ポートフォリオ設定</h3>
                    <h4>現在のポートフォリオ</h4>
                    <div className={"portfolios"}>
                        {
                            this.props.info.portfolios.map((portfolio)=>{
                                return(
                                    <div className={"portfolio"}>
                                        <div className={"portfolio-image"}>
                                            <button type={"button"} onClick={()=>{this.onClickButtonPortfolio(portfolio)}}>
                                                <img src={portfolio.image.url} alt={""}/>
                                            </button>
                                        </div>
                                        <div className={"portfolio-name"}>
                                            <button type={"button"} className={portfolio.id === this.state.selectedId ? "selected" : ""} onClick={()=>{this.onClickButtonPortfolio(portfolio)}}>
                                                {portfolio.name}
                                            </button>
                                        </div>
                                    </div>
                                );
                            })
                        }
                    </div>
                    <input type={"hidden"} name={"id"} value={this.state.selectedId}/>
                    <h4>ポートフォリオ名<small>{this.state.hasNameNotice ? "" : "（必須）"}</small></h4>
                    <input type={"text"} name={"name"} defaultValue={this.props.info.name}/>
                    {nameNotice}
                    {nameWarning}

                    <h4>ポートフォリオ画像</h4>
                    <h5>2MB以内のgif、png、jpgファイル<br/>600x310推奨</h5>
                    <div className={"image-portfolio"}>
                        <img src={this.state.image} alt={""}/>
                    </div>
                    <input type={"file"} name={"image"} onChange={(e)=>{this.onChangeInputImage(e)}}/>
                    {imageWarning}

                    <h4>制作期間</h4>
                    <input type={"text"} name={"period"} defaultValue={this.props.info.period}/>
                    {periodWarning}

                    <h4>ポートフォリオ説明</h4>
                    <textarea name={"description"} defaultValue={this.props.info.description}/>
                    {descriptionWarning}

                    <h4>ポートフォリオURL</h4>
                    <input type={"url"} name={"url"} defaultValue={this.props.info.url}/>
                    {urlWarning}

                    <button type={"submit"} className={this.state.buttonSubmit}>{this.state.buttonName}</button>
                </form>
            </div>
        )
    }
}

export default UserSettingPortfoliosForm
