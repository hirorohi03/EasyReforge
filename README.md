# EasyReforge-Next

This project is a fork of [EasyReforge](https://github.com/Zuntan03/EasyReforge).<BR>
本プロジェクトはZuntan03氏の[EasyReforge](https://github.com/Zuntan03/EasyReforge)をベースにしたforkです。

解説記事<BR>
[EasyReforge-Nextを公開しました（EasyReforgeのfork）](https://note.com/hirorohi03/n/nb8d3a31b3548)

## オリジナルのEasyReforgeからの変更点

基本的な仕様はEasyReforgeを受け継いでいますが、**reForge本体と拡張機能のバージョンを指定、固定しない**ことが最大の違いです。<BR>
以下に違いを箇条書きします。
- 新規インストール後に起動しない問題への対策
- reForge本体を最新にアップデート、バージョン固定なし（バージョン指定方法も提供）
- 拡張機能を最新にアップデート、バージョン固定なし
- Potable Gitを2.48.1から2.53.0.2にアップデート
- Pyhton (venv) を3.10.6から3.10.11にアップデート
- PyTorchを2.7.1から2.9.1にアップデート, Triton, Sageattentionもそれに対応するものにアップデート
- 拡張機能stable-diffusion-webui-wd14-taggerをBocchi-Chan2023版から~~67372a版~~[hirorohi03版](https://github.com/hirorohi03/stable-diffusion-webui-wd14-tagger)に変更
- 拡張機能を追加
	- [sd-webui-prompt-all-in-one](https://github.com/Physton/sd-webui-prompt-all-in-one)
	- [model-keyword](https://github.com/mix1009/model-keyword)
	- [sd-webui-cutoff](https://github.com/hnmr293/sd-webui-cutoff)
	- [sd-webui-enable-checker](https://github.com/shirayu/sd-webui-enable-checker)
 	- [sd-webui-forge-spectrum](https://github.com/hirorohi03/sd-webui-forge-spectrum)
- ~~SpectrumのStable Diffusion WebUI Forge Neoでの実装であるSpectrum Integrated (sd_forge_spectrum) を追加（reForge本体に実装されるまでの暫定措置）~~<BR>
**→ Sepectrumを使用する場合は[sd-webui-forge-spectrum](https://github.com/hirorohi03/sd-webui-forge-spectrum)を使用してください**
- ~~標準バッチの起動オプション変更（`--cuda-malloc --cuda-stream --skip-torch-cuda-test --use-sage-attention`）~~<BR>
**→ 環境によっては黒画像が生成されてしまうという報告があったためオプションなしに戻しました**
- reForge本体のソースコードパッチによるControlNet Preprocessorの削除
    - inpaint_only_noobai_xl+lama
	- inpaint_only_noobai_xl
- ローカル LLM チャット (llama.cpp) の削除
- A1111, Forge等の不要と思われる機能やファイルの削除

## インストール方法

1.  [EasyReforgeInstaller.bat](https://github.com/hirorohi03/EasyReforge/raw/main/EasyReforge/EasyReforgeInstaller.bat?ver=1) を右クリックから保存します。
	- NVIDIA GPU の Windows PC、20GB 以上の空きストレージ、PC の管理者権限、アバストなどの Windows Diffender でないウィルスチェック無効化、VPN の無効化が必要です。
2. `C:/EasyReforge/` などの浅いパスのインストール先の **空フォルダ** で、`EasyReforgeInstaller.bat` をダブルクリックして実行します。
	- **`WindowsによってPCが保護されました` と表示されたら、`詳細表示` から `実行` します。**
3. `動作に必要なモデルなどをダウンロードします。よろしいですか？ [y/n]（空欄なら y）` で `Enter` します。
4. インストール先の `EasyReforge/vc_redist.x64.exe` で、`Microsoft Visual C++ Redistributable` をインストールします。

## 起動方法

EasyReforge-Next インストール先にある以下いずれかのバッチを実行することでreForgeが起動します。
- `Reforge.bat`：起動オプションなしの標準設定で起動します。
- `Reforge_Fast.bat`：sageattention等を有効にして起動します。画像生成時間が約10%削減します。ただし環境によっては黒画像しか生成されなくなる場合がありますので、その場合は `Reforge.bat` を使用してください。
- 自作バッチ：自分で自由に起動オプションを指定したい場合は、`Reforge_Fast.bat` を任意のファイル名でコピーして、ファイルの内容を書き換えて利用してください。コピーせずに既存のファイルの内容を書き換えて利用すると、EasyReforge-Next の更新時に巻き戻ってしまいます。<br>
	- 参考ですが、--allow-fp16-accumulation オプションで計算精度を低くして生成時間を約10%削減することも可能です（sageattentionとの合計て約20%削減）。

## 更新方法

- `Update.bat` で EasyReforge-Next を更新します。
	- 更新で問題が発生したら『[更新のトラブルシューティング](https://github.com/hirorohi03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E6%9B%B4%E6%96%B0%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)』へ。
- `Update.bat` 実行時、赤い文字で以下のエラーメッセージが出力された場合はとりあえず無視してください。途中で止まってしまった場合は `Update.bat` を再実行すると問題なく最後まで実行できると思います。<p>
`ERROR: pip's dependency resolver does not currently take into account all the packages that are installed. This behaviour is the source of the following dependency conflicts.`<br>
`tensorflow 2.21.0 requires protobuf<8.0.0,>=6.31.1, but you have protobuf 3.20.0 which is incompatible.`<p>
	- この問題は[2026/4/6の更新](https://github.com/hirorohi03/EasyReforge?tab=readme-ov-file#202646)で修正されているはずですので、そちらを参照して対策してください。

## reForge本体のバージョン指定方法

2つのバッチでreForge本体のバージョンを指定／解除することができます。<BR>
reForge本体はリリースやバージョンタグを付けていないため、Gitの**コミットハッシュ値**で指定します。
- `EasyReforge\ReforgeVersionControl-Enable.bat`<BR>
reForge本体のコミットハッシュ値を入力して指定（入力内容の`EasyReforge\Reforge_Version.txt`が生成される）
- `EasyReforge\ReforgeVersionControl-Disable.bat`<BR>
reForge本体のバージョン指定を解除（`EasyReforge\Reforge_Version.txt`が削除される）

バージョンを変更する場合は `Update.bat` を実行してください。<BR>
reForge本体の**コミットハッシュ値**は、下図を参考にして[reForge本体のコミットログ](https://github.com/Panchovix/stable-diffusion-webui-reForge/commits/main/)からコピー＆ペーストしてください。<P>
![CommitHash](/Sample/Images_README/commit_hash.png) 

## オリジナルのEasyReforgeからのアップデートや移行について

現時点ではオリジナルのEasyReforgeからのアップデートや移行はサポートしていません。
- ほとんどの資産はModelとOutputReforge以下に格納されており、単純にコピーすればよいです。
- 使い方次第ですが、本体や拡張機能の設定やスタイル、プリセット類は、再設定や再作成が必要になるかもしれません。

とりあえず、[私のnote](https://note.com/hirorohi03)でWebUI間の移行についての解説記事を記載する予定です。

## 注意事項

- テストが十分でないためオリジナルのEasyReforgeでは発生しない不具合が存在する可能性があります。
- オリジナルのEasyReforgeと異なりreForge本体と拡張機能のバージョンを固定しませんので、それらのアップデートにより不具合が発生することがあります。

## 連絡

このforkについてわからないことや不具合や要望がありましたら、[@hirorohi003](https://x.com/hirorohi003) や [Issues](https://github.com/hirorohi03/EasyReforge/issues)  にお知らせください。<BR>
オリジナルのEasyReforgeならびに開発者のZuntan03氏、またreForge本体ならびに開発者のPanchovix氏への問い合わせは絶対におやめください。

## 最近の更新内容

- **更新で編集したスタイルが巻き戻った場合は、`stable-diffusion-webui-reForge\sytles.csv` の横にある日付付きバックアップファイルからコピペして復元してください。**

### 2026/4/6

- 既存の `wd14-tagger` は、`protobuf` というPythonライブラリに対するバージョン要求がreForgeの要求と不整合になっており、`Update.bat` 実行時などにエラーメッセージが出力されていたため、hirorohi03が修正した [`wd14-tagger`](https://github.com/hirorohi03/stable-diffusion-webui-wd14-tagger)に変更しました。
	- 既に不整合になっているPythonライブラリは自動で回復しませんので、[更新のトラブルシューティング](https://github.com/hirorohi03/EasyReforge/wiki/%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0#%E6%9B%B4%E6%96%B0%E3%81%AE%E3%83%88%E3%83%A9%E3%83%96%E3%83%AB%E3%82%B7%E3%83%A5%E3%83%BC%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0)に記載のとおり、`venv` を削除＆再作成してください。
	- venvは7GB以上のサイズがあるため削除＆再作成には相応の時間を要します。削除＆再作成ではなく個別に不要なPythonライブラリを削除して修正する場合は`Reforge_Activate.bat`を実行して開くコマンドプロンプトで以下のコマンドを実行してください。
```
pip uninstall deepdanbooru
pip uninstall tensorflow
pip uninstall opencv_python_headless
```

### 2026/4/5

- 不具合が発生した場合などのために、`EasyReforge\ReforgeVersionControl-Enable.bat` と `EasyReforge\ReforgeVersionControl-Disable.bat` でreForgeのバージョン指定と解除、`Update.bat`で指定したバージョンに変更できるようにしました。

### 2026/4/3

- [Stable Diffusion WebUI Forge - Neo](https://github.com/Haoming02/sd-webui-forge-classic)からのSpectrum Integrated ((sd_forge_spectrum)[https://github.com/Haoming02/sd-webui-forge-classic/tree/ae4e34e2fcf38eb64f77892bdc941b2444e5eaf3/extensions-builtin/sd_forge_spectrum])の流用をやめ、拡張機能の[sd-webui-forge-spectrum](https://github.com/hirorohi03/sd-webui-forge-spectrum)を追加しました。
	- 既にインストール済みのSpectrum Integratedは自動で削除されませんので、不要な場合はユーザー自身でエクスプローラー等を使ってstable-diffusion-webui-reForge\extensions-builtin\sd_forge_spectrumをフォルダごと削除してください。
	- [sd-webui-forge-spectrum](https://github.com/hirorohi03/sd-webui-forge-spectrum)は品質が低いという報告もありますので、気になる場合はSpectrum Integratedを残しておくか、既にSpectrum Integratedを削除してしまった場合は(sd-webui-reforge-spectrum)[https://github.com/wai55555/sd-webui-reforge-spectrum]を試してみてください。

### 2026/3/26

- 環境によってはsageattention有効時に黒画像しか生成されないという報告があったため、`Reforge.bat` の起動オプションを削除しました。sageattentionを有効にしたい場合は `Reforge_Fast.bat` を使用するか、 [起動方法](https://github.com/hirorohi03/EasyReforge/#起動方法)を参考に、ユーザー自身で起動バッチを作成して使用してください。

---
以降は基本的にオリジナルのEasyReforgeのドキュメントの内容です。<BR>
インストールバッチなど混同が起きそうなリンクのみ宛先を当リポジトリに変更してあります。

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
