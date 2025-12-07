# Homebrew tap packaging

Этот каталог — заготовка для собственного tap-а. Шаги:

1) Создай репозиторий `homebrew-kawa` или `homebrew-tap` (одно на аккаунт).
2) Внутри репозитория создай папку `Formula/` и положи туда `kawa.rb` из этого каталога.
3) (Опционально для бинарной установки) Создай папку `Casks/` и добавь cask, указывающий на release-asset `Kawa.zip` (см. GitHub Actions ниже).
4) Запушь репозиторий. Подключение пользователем:
   ```bash
   brew tap hmepas/kawa   # или hmepas/tap
   brew install hmepas/kawa/kawa        # формула из исходников
   brew install --cask hmepas/kawa/kawa # готовый .app из релиза
   ```

## Release-пайплайн

В корне проекта добавлен workflow `.github/workflows/release.yml`, который на теги собирает `Kawa.app` в Release и прикладывает `Kawa.zip` к GitHub Release. Это пригодится для cask-а (установка без Xcode).

## Настройки формулы

- Формула `kawa.rb` сейчас фиксирована на ревизию `26055ed…` и версию `0.0.1`. При выпуске тега обнови `version`, `revision` и/или переведи на tarball релиза.
- Для cask-а используй URL вида `https://github.com/hmepas/kawa/releases/download/v0.0.1/Kawa.zip` и пропиши `sha256` из CI артефакта.
