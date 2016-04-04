export default (req, res) => {
  // просто выводим форму редактора статьи
  // TODO если пользователь не авторизован - предложить авторизоваться или зарегистрироваться
  res.render('posts', {
    user: req.session.user ? req.session.user : {},
    partials: {
      footer: 'footer'
    }
  });
};
