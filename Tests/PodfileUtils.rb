# Podfile.lock содержит PODFILE CHECKSUM, из-за которого постоянно возникают конфликты, а он на самом деле не нужен.
# Возможно, вы подумаете, что CHECKSUM может как-то ускорять pod install, но я замерял время pod install и оно не менялось.
#
# Ждем, когда `pod install` завершится (в post_install хуке Podfile.lock еще не обновлен, поэтому делаем at_exit)
at_exit do
  podfile_lock_path = "#{__dir__}/Podfile.lock"
  manifest_lock_path = "#{__dir__}/Pods/Manifest.lock"
  podfile_lock_contents = File.read(podfile_lock_path)

  # Убирает такие конфликты:
  # <<<<<<<
  # PODFILE CHECKSUM: d304528e72925f278d0fb9367fc5b9720bda81df
  # =======
  # PODFILE CHECKSUM: 7cda18b5689dc7f854794b2100de67edfe1123e5
  # >>>>>>>
  #
  # Интересные факты:
  # Если checksum сосоит только из цифр [0-9], то кокоаподс крешится.
  podfile_lock_contents = podfile_lock_contents.gsub(/^PODFILE CHECKSUM: '?[0-9a-f]{40}'?$/, 'PODFILE CHECKSUM: f000000000000000000000000000000000000000')

  # Убирает такой дифф:
  # -    :path: ../TestsCore/UI/Targets/UIAutomation
  # +    :path: "../TestsCore/UI/Targets/UIAutomation"
  # Оставляем с кавычками
  podfile_lock_contents = podfile_lock_contents.gsub(/^    :path: ([^"].*?[^"])$/, '    :path: "\1"')

  # Убирает такой дифф:
  # -  GoogleSignIn: 09036ed61f8e75f1424100d63f7719480b2428c3
  # +  GoogleSignIn: '09036ed61f8e75f1424100d63f7719480b2428c3'
  # Убираем кавычки
  podfile_lock_contents = podfile_lock_contents.gsub(/^  (.*?): '([0-9a-f]{40})'$/, '  \1: \2')

  # Записываем в Podfile.lock и Manifest.lock
  File.open(podfile_lock_path, "w") {|file| file.puts podfile_lock_contents }
  File.open(manifest_lock_path, "w") {|file| file.puts podfile_lock_contents }
end