# EasyReforge-Next

This project is a fork of [EasyReforge](https://github.com/Zuntan03/EasyReforge).<BR>
本プロジェクトはZuntan03氏の[EasyReforge](https://github.com/Zuntan03/EasyReforge)をベースにしたforkです。

## オリジナルのEasyReforgeからの変更点

基本的な仕様はEasyReforgeを受け継いでいますが以下の違いがあります。
- Stable Diffusion WebUI reForge本体、および拡張機能 (Extensions) を最新にアップデート、バージョン固定なし
- Potable Gitのバージョンを2.48.1から2.53.0.2にアップデート
- Pyhton (venv) を3.10.6から3.10.11にアップデート
- PyTorchを2.7.1から2.9.1にアップデート, Triton, Sageattentionもそれに対応するものにアップデート
- 拡張機能stable-diffusion-webui-wd14-taggerをBocchi-Chan2023版から67372a版に変更
- 拡張機能を追加
	- sd-webui-prompt-all-in-one
	- model-keyword
	- sd-webui-cutoff
	- sd-webui-enable-checker
- reForge本体のソースコードパッチによるControlNet Preprocessorの削除
    - inpaint_only_noobai_xl+lama
	- inpaint_only_noobai_xl
- ローカル LLM チャット (llama.cpp) の削除
- A1111, Forge等の不要と思われる機能やファイルの削除
- 標準バッチの起動オプション変更（`--cuda-malloc --cuda-stream --skip-torch-cuda-test --use-sage-attention`）

## インストール方法

[EasyReforgeInstaller.bat](https://github.com/hirorohi03/EasyReforge/raw/main/EasyReforge/EasyReforgeInstaller.bat) を右クリックから保存します。以降は[オリジナルのEasyReforgeの手順](https://github.com/hirorohi03/EasyReforge?tab=readme-ov-file#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E6%96%B9%E6%B3%95-1)と同じです。

## オリジナルのEasyReforgeからの移行

現時点ではオリジナルのEasyReforgeからの移行はサポートしていません。
- ほとんどの資産はModelとOutputReforge以下に格納されているはずです。
- 使い方次第ですが、本体や拡張機能の設定やスタイル、プリセット類は、再設定や再作成が必要になるかもしれません。

今後、[私のnote](https://note.com/hirorohi03)でWebUI間の移行に関する解説記事を記載する予定です。

## 連絡

このforkについてわからないことや不具合や要望がありましたら、 [@hirorohi03](https://x.com/hirorohi003) や [Issues](https://github.com/hirorohi03/EasyReforge/issues)  にお知らせください。<BR>
Zuntan03氏やオリジナルのEasyReforgeへの問い合わせは絶対におやめください。

以降は基本的にオリジナルのEasyReforgeのドキュメントの内容です。<BR>
問題が起きそうなリンクのみ宛先を当リポジトリに変更してあります。

---
# EasyReforge

[reForge](https://github.com/Panchovix/stable-diffusion-webui-reForge) でお手軽に高速画像生成する EasyReforge です。  
[NoobAi](https://civitai.com/models/833294) の Epsilon-Prediction 版 ( **NoobE** ) と V-Prediction 版 ( **NoobV** ) を主に扱います。

- ワンクリックインストール
- Geforce RTX 3060 VRAM 12GB で FullHD を 10秒で生成するプリセット
- 便利な拡張機能一式を組み込み
- Civitai キー設定でモデル・LoRA・Wildcard・ADetailer モデルなどリソース一式をダウンロード

わからないことや不具合や要望がありましたら、 [@Zuntan03](https://x.com/Zuntan03) や [Issues](https://github.com/Zuntan03/EasyReforge/issues) にお知らせください。

## インストール方法

1.  [EasyReforgeInstaller.bat](https://github.com/hirorohi03/EasyReforge/raw/main/EasyReforge/EasyReforgeInstaller.bat?ver=1) を右クリックから保存します。
	- NVIDIA GPU の Windows PC、20GB 以上の空きストレージ、PC の管理者権限、アバストなどの Windows Diffender でないウィルスチェック無効化、VPN の無効化が必要です。
2. `C:/EasyReforge/` などの浅いパスのインストール先の **空フォルダ** で、`EasyReforgeInstaller.bat` をダブルクリックして実行します。
	- **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
3. `動作に必要なモデルなどをダウンロードします。よろしいですか？ [y/n]（空欄なら y）` で `Enter` します。
4. インストール先の `EasyReforge/vc_redist.x64.exe` で、`Microsoft Visual C++ Redistributable` をインストールします。
5. インストールが問題なく終了したら [使い方](https://github.com/Zuntan03/EasyReforge/#使い方) へ。

**インストールで問題が発生したら『[インストールのトラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。**

## 使い方

解説いただいた記事

- [新環境構築にEasyReforge 使ったから自動的に入るやつ全部解説する](https://note.com/kagami_kami/n/n79f46bc6147b)

|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_00_Basic.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_02_VPred.webp)|
|:-:|:-:|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Txt2ImgInpaint.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/Reforge_01_Tipo.webp)|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/TipoWildcard.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/TipoWildcardMulti.webp)|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/FramePlanner.webp)|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/Sample/CheatSheet/NoobInpaint.webp)|
|![](https://raw.githubusercontent.com/wiki/Zuntan03/EasyReforge/log/2507/anytest.webp)||

### 基本操作

- EasyReforge インストール先にある `Reforge.bat` で起動します。
	- 右側の `Generate` ボタンで画像を生成します。
		- 画像は `OutputReforge\txt2img-images` に保存されます。
			- `InfiniteImageBrowsing.bat` で生成した画像を確認できます。
	- プロンプト欄に入力するタグは [Danbooru](https://danbooru.donmai.us/) の左上にある `Search` 欄で、**日本語で検索して調べます** 。
	- `Generate` ボタン下のスタイル設定欄で `DMD2[4]: LCM, SGM Uniform 📋↙` を選択して `📋` と `↙` で基本的な設定を適用できます。
		- **Latent 系 Hires. fix x1.5 の利用が前提のプリセットです。**
		- プロンプト末尾の safe は TIPO 用のレーティング指定です。  
		TIPO を利用しない場合は削除してください（金庫が生成される場合があります）。
		- 高速化 LoRA なしの通常の設定を利用したい場合は `Normal[28+]: Euler a, Normal 📋↙️` を適用します。
	- プロンプト入力欄下の `TIPO` を開いて `Enabled` を有効にすると、入力済みのプロンプトから関連するプロンプトを追加して生成します（NSFW で特に強力です）。
		- 評価の高い NSFW を試すには `safe` を `explicit` に書き換えます。
	- 画像生成で問題が発生したら『[画像生成のトラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E7%94%BB%E5%83%8F%E7%94%9F%E6%88%90%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。
- **起動時の設定状態は `Settings` の左下にある `Other` - `Defaults` で変更できます。**
	- `View changes` で変更内容を確認して、`Apply` で保存します。
	- 設定がよくわからなくなったら `stable-diffusion-webui-reForge/` にある `config.json`, `ui-config.json`, `styles.csv` を退避してから `EasyReforge.bat` を実行すると、初期状態にリセットします。
- VRAM の少ない GPU では画面左下の `Never OOM Integrated` を有効にして、`Low VRAM` などを指定すると動作が快適になる可能性があります。
- UI の日本語併記を止めるには `Settings` にある `Bilingual Localization` の `Localization file` を `None` にして、`Apply settings` と `Reload UI` をしてください。
- 起動時にコマンドラインオプションを指定したい場合は `Reforge_ArgSample_DarkTheme.bat` をコピーして、ファイル内の `--theme dark` を書き換えます。
- **`Update.bat` で EasyReforge を更新します。**
	- 更新で問題が発生したら『[更新のトラブルシューティング](https://github.com/Zuntan03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E6%9B%B4%E6%96%B0%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。

### 追加データのダウンロード

- `Settings` の左上 `Search...` 欄に `api` と入力すると `[Wiki] API key for authenticating with Civitai.` の設定が表示されます。  
	- [Wiki](https://github.com/zixaphir/Stable-Diffusion-Webui-Civitai-Helper/wiki/Civitai-API-Key) のリンク先をブラウザで翻訳して、内容にそって API Key を取得して、この設定欄にコピペしてから上の `Apply settings` で保存します。
- Civitai キーを設定したら `NoobAiEpsilonPred_StandardModels.bat` でモデルなどを一式ダウンロードします。
	- モデルのダウンロードが不要な場合は `NoobAiEpsilonPred_Standard.bat` を実行します。
- 追加データをダウンロードするとキャラやスタイルのワイルドカードが使えます。
	- `__NsfwPony/char__`: キャラワイルドカード
	- `__Booru1girl__`: 女性のみキャラワイルドカード
	- `__MixedStyle__`: 混合スタイルワイルドカード
	- `<lora:NoobEStylesDump:1> __NoobEStylesDump__`: スタイル LoRA とトリガーワイルドカード。V-Pred なら NoobE を NoobV にします。
	- `<lora:NoobEStylesCollection:1> __NoobStylesCollection__`: スタイル LoRA とトリガーワイルドカード。V-Pred なら NoobE を NoobV にします。
- `Download/` 直下の `bat` では追加データを一式ダウンロードできます。
	- `NoobAiEpsilonPred`, `NoobAiVPred`: [NoobAi](https://civitai.com/models/833294) の Epsilon-Prediction 版、V-Prediction 版の関連ファイルをダウンロードします。最初は扱いが簡単な `NoobAiEpsilonPred` がオススメです。
	- `Minimum`: 画像生成ができる最低限の関連ファイルをダウンロードします。`Minimum` のみ、下記の Civitai キー設定をしなくてもダウンロードできます。
	- `Standard`: `Minimum` に加えて、モデル以外の標準的な関連ファイルをダウンロードします。LoRA や ADetailer 検出モデルや Wildcard など、容量に対して効果が大きいモノが多いため、Civitai キーを登録してのダウンロードを推奨します。
	- `StandardModels`: `Standard` に加えて、合計 100GB 以下の定番オススメモデルをダウンロードします。
	- `All`: すべての関連ファイルをダウンロードします。
	- サブフォルダの `bat` で個別のダウンロードもできます。
	- モデルや LoRA は日々新しいモノが公開されますので、[Civitai](https://civitai.com/) で気になったモノを `Civitai Helper` でダウンロードしたり、`Civitai Helper Browser` で直接ダウンロードしてください（Civitai キー設定が必要）。

### 他の環境とのリソース共有

- モデルや LoRA は `Model/` 以下に保存します。
- 各サブフォルダの `LinkInput.bat` と `LinkOutput.bat` でモデルや LoRA を共有できます。
	- EasyReforge から他の環境のモデルや LoRA を参照したい場合は、`LinkInput.bat` を実行してください。
	- EasyReforge のモデルや LoRA を他の環境から参照したい場合は、`LinkOutput.bat` を実行してください。

### V-Prediction を試す

**NoobAI の V-Prediction 版は開発中です。**  
**現時点では V-Prediction & ZTSNR に対応した高速化 LoRA も存在しないため、強引な対応により品質が落ちています（が、その代わりに 3060 で FullHD を 10秒で生成できます）。**

[追加データのダウンロード](https://github.com/hirorohi03/EasyReforge/#追加データのダウンロード) で Civitai キーを設定してから、`Download/` にある `NoobAiVPred_StandardModels.bat` で V-Pred のモデルや LoRA をダウンロードします。

1. 左下にある `Advanced Model Sampling for reForge` を開いて `Enable Advanced Model Sampling` を有効にします。
	- V-Pred や ZTSNR 自動判定機能は派生モデルで正常に動作しない場合があるようですのでご注意ください。
1. `DMD2[4+]: Euler a CFG++, Beta 📋↙` を選択して、`📋` と `↙` で適用します。
	- モデルによっては `DMD2[4]: LCM, SGM Uniform 📋↙` の設定のままでも生成できます。
2. `__Booru1girl__ official logo, upper body` や `__NsfwPony/char__ official logo, upper body` で生成すると、ロゴなどで学習精度の高さを確認できます。

E-Pred に戻すときも同様です。

1. `DMD2[4]: LCM, SGM Uniform 📋↙` を選択して、`📋` と `↙` で適用します。
1. 左下にある `Advanced Model Sampling for reForge` を開いて `Enable Advanced Model Sampling` を無効にします。

- **更新で編集したスタイルが巻き戻った場合は、`stable-diffusion-webui-reForge\sytles.csv` の横にある日付付きバックアップファイルからコピペして復元してください。**

#### [EasyReforgeの更新内容](https://github.com/hirorohi03/EasyReforge/wiki/EasyReforge%E3%81%AE%E6%9B%B4%E6%96%B0%E5%86%85%E5%AE%B9)（参考画像もこちらにあります。）

## ドキュメント

- [トラブルシューティング](https://github.com/hirorohi03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)
- [EasyReforgeの更新内容](https://github.com/hirorohi03/EasyReforge/wiki/EasyReforge%E3%81%AE%E6%9B%B4%E6%96%B0%E5%86%85%E5%AE%B9)

## ライセンス

このリポジトリの内容は [MIT License](./LICENSE.txt) です。
