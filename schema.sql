CREATE TABLE `test_kbans`.`bans`
(
    `id`               INT                                                     NOT NULL AUTO_INCREMENT,
    `player_name`      VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci  NULL,
    `player_steam64`   BIGINT(20) UNSIGNED                                     NOT NULL,
    `admin_name`       VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci  NULL DEFAULT 'Console',
    `admin_steam64`    BIGINT(20) UNSIGNED                                     NOT NULL,
    `reason`           VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
    `unbanned_name`    VARCHAR(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci  NULL,
    `unbanned_steam64` BIGINT(20) UNSIGNED                                     NOT NULL,
    `created_at`       TIMESTAMP                                               NULL,
    `expires_at`       TIMESTAMP                                               NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;