<?php
/**
 * The base configurations of the WordPress.
 *
 * This file has the following configurations: MySQL settings, Table Prefix,
 * Secret Keys, WordPress Language, and ABSPATH. You can find more information
 * by visiting {@link http://codex.wordpress.org/Editing_wp-config.php Editing
 * wp-config.php} Codex page. You can get the MySQL settings from your web host.
 *
 * This file is used by the wp-config.php creation script during the
 * installation. You don't have to use the web site, you can just copy this file
 * to "wp-config.php" and fill in the values.
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('DB_NAME', 'data_mah');

/** MySQL database username */
define('DB_USER', 'root');

/** MySQL database password */
define('DB_PASSWORD', 'root');

/** MySQL hostname */
define('DB_HOST', 'localhost:80');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         'UnR<95Q)s1-jx[HC;tS)DIZX&KsF`~,-Z*zOj&5IrH&[*!MV[ qrQ&;M1gQq|>S3');
define('SECURE_AUTH_KEY',  '2TTu85k8Xlar13lqV@5iI {  qzn4U<;|gKz+nJtR-}37aLfgIdpu-}+-.K!,yR~');
define('LOGGED_IN_KEY',    'BaBxtPm!Ss{m6;}X#mtwZA`8 rcE^vd*vdiS7^WJI:CTu05 )},oaNp|7r/NwhFm');
define('NONCE_KEY',        'U/u0l$LrSw<=4>^B,P^Tfs7}hL3]V|L0Ddb!Y8O&|Lv%}7,%T1AzbsXN+-NyK#Wu');
define('AUTH_SALT',        'QqtO`AnPyv{(:d:Hu]P027K* OSn;n1tUvl#K80&Wa`~-b/y?+|_[<{B!!P:dyhj');
define('SECURE_AUTH_SALT', 'WVn#(:)#(97=blRij$J.Yi}I%;VG]wD^i%,Wy=#%z13i=I-p-o1`,/-K31[GcpR;');
define('LOGGED_IN_SALT',   'Arz&5jTY`mmH~_ma*-|E{dXX4X{Vz)4nRG8C+]s`k:6Ak49@)<tt`(yRF.El4}#H');
define('NONCE_SALT',       '-%0@naTv7/C?-.Rh|VI3,QI!UW>mRu4cX{^7.$*#Jw<QCJK]3(nbBC3@ZJtWo Pc');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each a unique
 * prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');
