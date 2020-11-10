import React from "react"

class UserSettingProfileForm extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            image: this.props.info.image,
            imageWarning : ""
        };
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
            }else if(file.size > 1048576){
                this.setState({image: this.props.info.image});
                this.setState({imageWarning: "1MB以下の画像ファイルをアップロードしてください"});
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
        let birthYearOptions = [];
        let birthMonthOptions = [];
        let birthDayOptions = [];

        let permalinkWarning;
        let nameWarning;
        let imageWarning;
        let descriptionWarning;
        let locationWarning;
        let urlWarning;

        for(let y=2020; y>=1920;y--){
            birthYearOptions.push(<option value={y}>{y}年</option>);
        }

        for(let m=1;m<=12;m++){
            birthMonthOptions.push(<option value={m}>{m}月</option>);
        }

        for(let d=1;d<=31;d++){
            birthDayOptions.push(<option value={d}>{d}日</option>);
        }

        if(this.props.info.permalinkWarning !== null){
            permalinkWarning = (
                <div className={"warning"}>
                    {this.props.info.permalinkWarning}
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

        if(this.props.info.nameWarning !== null){
            nameWarning = (
                <div className={"warning"}>
                    {this.props.info.nameWarning}
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

        if(this.props.info.locationWarning !== null){
            locationWarning = (
                <div className={"warning"}>
                    {this.props.info.locationWarning}
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
                <form action={"/settings"} method={"POST"} className={"settings-form setting-profile-form"} encType={"multipart/form-data"}>
                    <h3>プロフィール設定</h3>
                    <h4>ユーザーID<small>（必須、英数字および「_」のみ）</small></h4>
                    <input type={"text"} name={"permalink"} defaultValue={this.props.info.permalink}/>
                    {permalinkWarning}

                    <h4>ユーザー画像</h4>
                    <h5>1MB以内のgif、png、jpgファイル<br/>400x400推奨</h5>
                    <div className={'user-image'}>
                        <img src={this.state.image} alt={""}/>
                    </div>
                    <input type={"file"} name={"image"} onChange={(e)=>{this.onChangeInputImage(e)}}/>
                    {imageWarning}

                    <h4>ユーザー名<small>（必須）</small></h4>
                    <input type={"text"} name={"name"} defaultValue={this.props.info.name}/>
                    {nameWarning}

                    <h4>担当</h4>
                    <div className={"role-tags"}>
                        {
                            this.props.info.roles.map((role)=>{
                                return(
                                    <p>
                                        <input type={"checkbox"} name={"roles[]"} value={role.id} defaultChecked={this.props.info.userRoles.includes(role.id)}/>{role.name}
                                    </p>
                                )
                            })
                        }
                    </div>

                    <h4>自己紹介<small>（240字以内）</small></h4>
                    <textarea name={"description"} defaultValue={this.props.info.description}/>
                    {descriptionWarning}

                    <h4>所在地</h4>
                    <input type={"text"} name={"location"} defaultValue={this.props.info.location}/>
                    {locationWarning}

                    <h4>誕生日</h4>
                    <div className={"birth"}>
                        <select name={"birth_year"} defaultValue={this.props.info.birth.year}>
                            {birthYearOptions}
                        </select>
                        <select name={"birth_month"} defaultValue={this.props.info.birth.month}>
                            {birthMonthOptions}
                        </select>
                        <select name={"birth_day"} defaultValue={this.props.info.birth.day}>
                            {birthDayOptions}
                        </select>
                    </div>
                    <input type={"checkbox"} name={"birth_published"} defaultChecked={this.props.info.isPublishedBirth}/>公開

                    <h4>ホームページ</h4>
                    <input type={"url"} name={"url"} defaultValue={this.props.info.url}/>
                    {urlWarning}

                    <button type={"submit"}>更新</button>
                </form>
            </div>
        )
    }

}

export default UserSettingProfileForm
