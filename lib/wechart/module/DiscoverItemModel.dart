class DiscoverItem {
  final String iconName;
  final String title;
  const DiscoverItem(this.iconName, this.title);
}

const k_discoverItems = [
  DiscoverItem("images/icon_pengyouquan.png", "朋友圈"),
  null,
  DiscoverItem("images/icon_saoyisao.png", "扫一扫"),
  DiscoverItem("images/icon_yaoyiyao.png", "摇一摇"),
  null,
  DiscoverItem("images/icon_kanyikan.png", "看一看"),
  DiscoverItem("images/icon_souyisou.png", "搜一搜"),
  null,
  DiscoverItem("images/icon_fujin.png", "附近"),
  null,
  DiscoverItem("images/icon_gouwu.png", "购物"),
  DiscoverItem("images/icon_youxi.png", "游戏"),
  null,
  DiscoverItem("images/icon_xiaochengxu.png", "小程序"),
];

const k_mineItems = [
  null,
  DiscoverItem("images/icon_zhifu.png", "支付"),
  null,
  DiscoverItem("images/icon_shoucang.png", "收藏"),
  DiscoverItem("images/icon_xiangce.png", "相册"),
  DiscoverItem("images/icon_kabao.png", "卡包"),
  DiscoverItem("images/icon_biaoqing.png", "表情"),
  null,
  DiscoverItem("images/icon_shezhi.png", "设置"),
];