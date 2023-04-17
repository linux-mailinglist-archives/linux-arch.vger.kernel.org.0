Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC876E4892
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 14:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjDQM5q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 08:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjDQM5W (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 08:57:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE69ECC;
        Mon, 17 Apr 2023 05:57:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 192D11FE0D;
        Mon, 17 Apr 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681736223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNg0lz+7KBHL0Jy2/T4bI8sg52Xj/iVvmLTbUyEhSFc=;
        b=1A7fXiy1zKPCuEHooMeIVWVvJlKA/ju1B4NXN7LwNgEtx/G2NE2eLoHXc3y2k3Ny8vAC3o
        bQE8YX9wQ63rTt4qUtIF2zXbQQrnHf3lgS8GpEd9Sq9lWO5AVYvQOKkWBhc3m+Aq4eOa3k
        zlJZR9DLxIUgT46xqhjJXNjAvf7hF6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681736223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNg0lz+7KBHL0Jy2/T4bI8sg52Xj/iVvmLTbUyEhSFc=;
        b=8/AlEZDQXt3r2Q36jm3rhtdSm0bNHjwRZn287hcP5LcsmvipnpFbxL//4nCdb/g1kzIQvk
        jnC4JSw7Kh0YkwBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1AB61391A;
        Mon, 17 Apr 2023 12:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SGqRKh5CPWToWwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 12:57:02 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 11/19] video: Move HP PARISC STI core code to shared location
Date:   Mon, 17 Apr 2023 14:56:43 +0200
Message-Id: <20230417125651.25126-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417125651.25126-1-tzimmermann@suse.de>
References: <20230417125651.25126-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

STI core files have been located in console and fbdev code. Move
the source code and header to the directories for video helpers.
Also update the config and build rules such that the code depends
on the config symbol CONFIG_STI_CORE, which STI console and STI
framebuffer select automatically.

Cleans up the console makefile and prepares PARISC to implement
fb_is_primary_device() within the arch/ directory. No functional
changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/Kconfig                            | 7 +++++++
 drivers/video/Makefile                           | 1 +
 drivers/video/console/Kconfig                    | 1 +
 drivers/video/console/Makefile                   | 4 +---
 drivers/video/console/sticon.c                   | 2 +-
 drivers/video/fbdev/Kconfig                      | 3 +--
 drivers/video/fbdev/stifb.c                      | 2 +-
 drivers/video/{console => }/sticore.c            | 2 +-
 {drivers/video/fbdev => include/video}/sticore.h | 0
 9 files changed, 14 insertions(+), 8 deletions(-)
 rename drivers/video/{console => }/sticore.c (99%)
 rename {drivers/video/fbdev => include/video}/sticore.h (100%)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index bf05363d8906..8b2b9ac37c3d 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -11,6 +11,13 @@ config APERTURE_HELPERS
 	  Support tracking and hand-over of aperture ownership. Required
 	  by graphics drivers for firmware-provided framebuffers.
 
+config STI_CORE
+	bool
+	depends on PARISC
+	help
+	  STI refers to the HP "Standard Text Interface" which is a set of
+	  BIOS routines contained in a ROM chip in HP PA-RISC based machines.
+
 config VIDEO_CMDLINE
 	bool
 
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 831c9fa57a6c..6bbc03950899 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_APERTURE_HELPERS)    += aperture.o
+obj-$(CONFIG_STI_CORE)            += sticore.o
 obj-$(CONFIG_VGASTATE)            += vgastate.o
 obj-$(CONFIG_VIDEO_CMDLINE)       += cmdline.o
 obj-$(CONFIG_VIDEO_NOMODESET)     += nomodeset.o
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 22cea5082ac4..a2a88d42edf0 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -141,6 +141,7 @@ config STI_CONSOLE
 	depends on PARISC && HAS_IOMEM
 	select FONT_SUPPORT
 	select CRC32
+	select STI_CORE
 	default y
 	help
 	  The STI console is the builtin display/keyboard on HP-PARISC
diff --git a/drivers/video/console/Makefile b/drivers/video/console/Makefile
index db07b784bd2c..fd79016a0d95 100644
--- a/drivers/video/console/Makefile
+++ b/drivers/video/console/Makefile
@@ -5,8 +5,6 @@
 
 obj-$(CONFIG_DUMMY_CONSOLE)       += dummycon.o
 obj-$(CONFIG_SGI_NEWPORT_CONSOLE) += newport_con.o
-obj-$(CONFIG_STI_CONSOLE)         += sticon.o sticore.o
+obj-$(CONFIG_STI_CONSOLE)         += sticon.o
 obj-$(CONFIG_VGA_CONSOLE)         += vgacon.o
 obj-$(CONFIG_MDA_CONSOLE)         += mdacon.o
-
-obj-$(CONFIG_FB_STI)              += sticore.o
diff --git a/drivers/video/console/sticon.c b/drivers/video/console/sticon.c
index 89ad7ade6cf9..d11cfd2d68b5 100644
--- a/drivers/video/console/sticon.c
+++ b/drivers/video/console/sticon.c
@@ -50,7 +50,7 @@
 
 #include <asm/io.h>
 
-#include "../fbdev/sticore.h"
+#include <video/sticore.h>
 
 /* switching to graphics mode */
 #define BLANK 0
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 96e91570cdd3..485e8c35d5c6 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -551,10 +551,9 @@ config FB_STI
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
+	select STI_CORE
 	default y
 	help
-	  STI refers to the HP "Standard Text Interface" which is a set of
-	  BIOS routines contained in a ROM chip in HP PA-RISC based machines.
 	  Enabling this option will implement the linux framebuffer device
 	  using calls to the STI BIOS routines for initialisation.
 
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index 99996bc7e6d9..baca6974e288 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -69,7 +69,7 @@
 #include <asm/grfioctl.h>	/* for HP-UX compatibility */
 #include <linux/uaccess.h>
 
-#include "sticore.h"
+#include <video/sticore.h>
 
 /* REGION_BASE(fb_info, index) returns the virtual address for region <index> */
 #define REGION_BASE(fb_info, index) \
diff --git a/drivers/video/console/sticore.c b/drivers/video/sticore.c
similarity index 99%
rename from drivers/video/console/sticore.c
rename to drivers/video/sticore.c
index 6ea9596a3c4b..f8aaedea437d 100644
--- a/drivers/video/console/sticore.c
+++ b/drivers/video/sticore.c
@@ -32,7 +32,7 @@
 #include <asm/grfioctl.h>
 #include <asm/fb.h>
 
-#include "../fbdev/sticore.h"
+#include <video/sticore.h>
 
 #define STI_DRIVERVERSION "Version 0.9c"
 
diff --git a/drivers/video/fbdev/sticore.h b/include/video/sticore.h
similarity index 100%
rename from drivers/video/fbdev/sticore.h
rename to include/video/sticore.h
-- 
2.40.0

