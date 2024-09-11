import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// フラッシュメッセージ（一定時間で消す）
$(function(){  //メソッド定義
    $('.js-flash').fadeOut(5000);  //5秒かけて消えていく
  });
