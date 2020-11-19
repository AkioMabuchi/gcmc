import React from "react"

class Message extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            messages: [],
            messageFormWarning: ""
        };
    }

    componentDidMount() {
        this.fetchMessages();
        setInterval(() => {
            this.fetchMessages()
        }, 5000);
    }

    fetchMessages() {
        fetch("/messages/fetch", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({
                from_user_id: this.props.info.fromUserId,
                to_user_id: this.props.info.toUserId,
            })
        }).then((response) => {
            return response.json();
        }).then((result) => {
            this.setState({messages: result});
        });
    }

    onClickButtonSendMessage() {
        let content = document.getElementById("react-message-content").value;
        if (content.length === 0) {
            this.setState({messageFormWarning: "入力してください"});
        } else if (content.length > 200) {
            this.setState({messageFormWarning: "200字以内で入力してください"});
        } else {
            this.setState({messageFormWarning: ""});
            fetch("/messages/send", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify({
                    from_user_id: this.props.info.fromUserId,
                    to_user_id: this.props.info.toUserId,
                    content: content
                })
            }).then((response) => {
                return response.text();
            }).then((result) => {
                if (result === "accepted") {
                    setTimeout(() => {
                        this.fetchMessages();
                    }, 100);
                }
                if (result === "error") {
                    alert("メッセージの送信に失敗しました");
                }
            });
        }
        document.getElementById("react-message-content").value = "";
    }


    render() {
        let messageFormWarning;

        if (this.state.messageFormWarning !== "") {
            messageFormWarning = (
                <div className={"warning"}>
                    {this.state.messageFormWarning}
                </div>
            );
        }

        return (
            <div className={"messages"}>
                <div className={"send-message-box"}>
                    <h4>送信先ユーザー</h4>
                    <div className={"user-image-name"}>
                        <div className={"user-image"}>
                            <a href={`/users/${this.props.info.permalink}`}>
                                <img src={this.props.info.toUserImage} alt={"/NoUserImage.png"}/>
                            </a>
                        </div>
                        <div className={"user-name"}>
                            <a href={`/users/${this.props.info.permalink}`}>
                                {this.props.info.toUserName}
                            </a>
                        </div>
                    </div>
                    <h4>メッセージ内容</h4>
                    <textarea id={"react-message-content"}/>
                    {messageFormWarning}
                    <button type={"button"} onClick={() => {
                        this.onClickButtonSendMessage()
                    }}>送信
                    </button>
                </div>
                <ul className={"messages-list"}>
                    {
                        this.state.messages.map((message) => {
                            return (
                                <li>
                                    <div className={"message-header"}>
                                        <div className={"message-image"}>
                                            <img src={message.image} alt={"/NoUserImage.png"}/>
                                        </div>
                                        <div className={"message-name"}>
                                            {message.name}
                                        </div>
                                        <div className={"message-date"}>
                                            {message.date}
                                        </div>
                                    </div>
                                    <div className={"message-content"}>
                                        {message.content}
                                    </div>
                                </li>
                            )
                        })
                    }
                </ul>
            </div>
        );
    }
}

export default Message
