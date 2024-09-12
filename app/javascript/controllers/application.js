import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

document.addEventListener('turbo:load', () => {

const flashMessage = document.querySelector('.alert');
const FlashMessage_erase = () => {
const timer_id = setInterval(() => {
  // flashメッセージのstyle属性 opacityを取得
  const opacity = flashMessage.style.opacity;
  if (opacity > 0) {
  // opacityの値が0より大きければ0.02ずつ値を減少させる
    flashMessage.style.opacity = 0;
  } else {
    // opacityの値が0になったら非表示に
    flashMessage.style.display = 'none';
    // setIntervalをストップさせる
    clearInterval(timer_id);
  };
}, 50);
}

if (flashMessage !== null) {
  // style属性opacityをセット
  flashMessage.style.opacity = 1;
  // 今回は表示から3秒後に上記で定義したフェードアウトさせる関数を実行
  setTimeout(FlashMessage_erase, 4000);
};
}
)