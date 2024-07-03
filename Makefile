watch:
	dart run build_runner watch

log:
	flutter logs

apk:
	flutter build apk --release

run:
	flutter run
	
apkk:
	open build/app/outputs/flutter-apk/
	
runner:
	flutter build ios

bundle:
	flutter build appbundle
	
bundlee:
	open build/app/outputs/bundle/release/
	
release:
	flutter run --release

lang:
	flutter gen-l10n 
	
get:
	flutter pub get

clean:
	flutter clean
	