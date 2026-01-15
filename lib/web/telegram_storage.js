function tgGet(key) {
  return new Promise((resolve) => {
    if (!window.Telegram?.WebApp?.CloudStorage) {
      resolve(null);
      return;
    }
    Telegram.WebApp.CloudStorage.getItem(key, (err, value) => {
      resolve(value);
    });
  });
}

function tgSet(key, value) {
  if (!window.Telegram?.WebApp?.CloudStorage) return;
  Telegram.WebApp.CloudStorage.setItem(key, value);
}
