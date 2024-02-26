
# ZIMKit(ZegoCloud In-App Chat UIKit)

🥳beta support:
- Create peer-to-peer chat / Create group chat/ Join group chat
- Send text, picture(<10M), gif(<10M), video(<100M), file(<100M)
- Long press the conversation list item to delete the conversation or exit the group chat
- custom ui (Please check widgets' parameters)

✨Coming soon: 
- Invite to join group chat / set user avatar /set group avatar
- download files
## 1. init imkit

```
void main() {
  ZIMKit().init(
    appID: , // your appid
    appSign: '', // your appSign
  );
  runApp(const ZIMKitDemo());
}
```


## 2. user login

[//]: # (```dart)

[//]: # ( ElevatedButton&#40;)

[//]: # (    onPressed: &#40;&#41; async {)

[//]: # (        await ZIMKit&#40;&#41;)

[//]: # (            .connectUser&#40;id: userID.text, name: userName.text&#41;;)

[//]: # (            Navigator.of&#40;context&#41;.pushReplacement&#40;)

[//]: # (            MaterialPageRoute&#40;)

[//]: # (                builder: &#40;context&#41; =>)

[//]: # (                    const ZIMKitDemoHomePage&#40;&#41;,)

[//]: # (            &#41;,)

[//]: # (        &#41;;)

[//]: # (    },)

[//]: # (    child: const Text&#40;"login"&#41;,)

[//]: # (&#41;)

[//]: # (```)

## 3. enjoy it

```dart
class ZIMKitDemoHomePage extends StatelessWidget {
  const ZIMKitDemoHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
          actions: const [HomePagePopupMenuButton()],
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ZIMKitMessageListPage(
                  conversationID: conversation.id,
                  conversationType: conversation.type,
                );
              },
            ));
          },
        ),
      ),
    );
  }
}

```