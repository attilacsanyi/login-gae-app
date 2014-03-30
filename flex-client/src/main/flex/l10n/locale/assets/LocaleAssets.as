package l10n.locale.assets
{
	public class LocaleAssets
	{		
		[Embed(source='flags/us32x32.png')]
		public static const  FLAG_USA : Class;
		
		[Embed(source='flags/hu32x32.png')]
		public static const  FLAG_HUNGARY : Class;
		
		/**
		 * Build list of supported Flag data items. This will be used to dynamically
		 * construct Flag buttons in the LanguageBar or other UI needs. To add more flags
		 * simply add more records.
		 * 
		 * Note: The title properties should be localized (at runtime) via injection...
		 * 
		 */
		private static var _locales : Array = [
			{ flag:FLAG_HUNGARY,	locale:"hu_HU", title:"Hungary" },
			{ flag:FLAG_USA,		locale:"en_US", title:"English (US)" }
		];
		
		/**
		 * This array allows us to auto-assign build order (and possibly display order)
		 * for all supported flags/locales 
		 */
		static public function get allFlags():Array {
			return [FLAG_HUNGARY, FLAG_USA]; 
		}
		
		/**
		 * Using the locale's flag Class, lookup the locale's shortcode
		 * 
		 * @param flag Class Embedded bitmapAsset class associated with locale code
		 * @return String Locale code (e.g. en_US, fr_FR, es_ES, zh_CN, etc.)
		 * 
		 */
		static public function getLocaleFor(flag:Class):String {
			var locale : String = "en_US";
			
			for each (var it:Object in _locales) {
				if (it.flag == flag) {
					locale = it.locale;
					break;
				}
			}
			
			return locale;
		}
		
		/**
		 * Using the locale's flag Class, lookup the locale's associated title text
		 * 
		 * @param flag Class Embedded bitmapAsset class associated with locale code
		 * @return String English title associated with locale code 
		 * 
		 */
		static public function getTitleFor(flag:Class):String {
			var tip : String = "";
			
			for each (var it:Object in _locales) {
				if (it.flag == flag) {
					tip = it.title;
					break;
				}
			}
			
			return tip;
		}
		
	}
}