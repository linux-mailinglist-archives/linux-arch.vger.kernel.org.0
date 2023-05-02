Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CDB6F447E
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjEBNDD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjEBNCk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 09:02:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D009B59E7;
        Tue,  2 May 2023 06:02:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DE9F21FB2;
        Tue,  2 May 2023 13:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683032547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiIe+W8/KVk4z+vQoB0merwIWEmbGtuxPyODzPQCCGc=;
        b=QWtuhR4wHDzswQBv4us+KwZsspyvFqq8TFjtcaOayh9THdP2cguppKX8nC+aRceMm8P+FF
        JrHhaatkjNZ1dA9Ks+5lf8g4ySLnR6hXwcK7j/XOlj1oUzw26XTyVNijcWxjYuMcaP5uaj
        Fv8xpMzWqDNjyOyufGljFRopU6wsJHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683032547;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NiIe+W8/KVk4z+vQoB0merwIWEmbGtuxPyODzPQCCGc=;
        b=Ac0QGkIf+AHVVsCtosvAEY750LHyRzsNI0FrsKxRfR4yEfgVTdSdteFuSj8zRQy7oPHQZJ
        A1iogSzzBRE+iFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A664134FB;
        Tue,  2 May 2023 13:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cEnCAeMJUWRYTQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 02 May 2023 13:02:27 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/6] fbdev: Include <linux/io.h> via <asm/fb.h>
Date:   Tue,  2 May 2023 15:02:21 +0200
Message-Id: <20230502130223.14719-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502130223.14719-1-tzimmermann@suse.de>
References: <20230502130223.14719-1-tzimmermann@suse.de>
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

Fbdev's main header file, <linux/fb.h>, includes <asm/io.h> to get
declarations for I/O helper functions. From these declarations, it
later defines framebuffer I/O helpers, such as fb_{read,write}[bwlq]()
or fb_memset().

The framebuffer I/O helpers depend on the system architecture and
will therefore be moved into <asm/fb.h>. Prepare this change by first
adding an include statement for <linux/io.h> to <asm-generic/fb.h>.
Include <asm/fb.h> in all source files that use the framebuffer I/O
helpers, so that they still get the necessary I/O functions.

v3:
	* fix grammar in commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/arkfb.c                 | 2 ++
 drivers/video/fbdev/aty/mach64_cursor.c     | 2 +-
 drivers/video/fbdev/chipsfb.c               | 1 +
 drivers/video/fbdev/cirrusfb.c              | 2 ++
 drivers/video/fbdev/core/cfbcopyarea.c      | 2 +-
 drivers/video/fbdev/core/cfbfillrect.c      | 1 +
 drivers/video/fbdev/core/cfbimgblt.c        | 1 +
 drivers/video/fbdev/core/svgalib.c          | 3 +--
 drivers/video/fbdev/cyber2000fb.c           | 2 ++
 drivers/video/fbdev/ep93xx-fb.c             | 2 ++
 drivers/video/fbdev/hgafb.c                 | 3 ++-
 drivers/video/fbdev/hitfb.c                 | 2 +-
 drivers/video/fbdev/kyro/fbdev.c            | 3 ++-
 drivers/video/fbdev/matrox/matroxfb_accel.c | 2 ++
 drivers/video/fbdev/matrox/matroxfb_base.h  | 2 +-
 drivers/video/fbdev/pm2fb.c                 | 3 +++
 drivers/video/fbdev/pm3fb.c                 | 2 ++
 drivers/video/fbdev/pvr2fb.c                | 2 ++
 drivers/video/fbdev/s3fb.c                  | 2 ++
 drivers/video/fbdev/sm712fb.c               | 2 ++
 drivers/video/fbdev/sstfb.c                 | 2 +-
 drivers/video/fbdev/stifb.c                 | 2 ++
 drivers/video/fbdev/tdfxfb.c                | 3 ++-
 drivers/video/fbdev/tridentfb.c             | 2 ++
 drivers/video/fbdev/vga16fb.c               | 3 ++-
 drivers/video/fbdev/vt8623fb.c              | 2 ++
 include/asm-generic/fb.h                    | 1 +
 27 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 60a96fdb5dd8..fd38e8a073b8 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -27,6 +27,8 @@
 #include <linux/console.h> /* Why should fb driver call console functions? because console_lock() */
 #include <video/vga.h>
 
+#include <asm/fb.h>
+
 struct arkfb_info {
 	int mclk_freq;
 	int wc_cookie;
diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
index 4ad0331a8c57..a848aaff510c 100644
--- a/drivers/video/fbdev/aty/mach64_cursor.c
+++ b/drivers/video/fbdev/aty/mach64_cursor.c
@@ -8,7 +8,7 @@
 #include <linux/string.h>
 #include "../core/fb_draw.h"
 
-#include <asm/io.h>
+#include <asm/fb.h>
 
 #ifdef __sparc__
 #include <asm/fbio.h>
diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 7799d52a651f..9f9ee13ba2be 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -32,6 +32,7 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
+#include <asm/fb.h>
 
 /*
  * Since we access the display with inb/outb to fixed port numbers,
diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index ba45e2147c52..cc306b3733e2 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -57,6 +57,8 @@
 #include <video/vga.h>
 #include <video/cirrus.h>
 
+#include <asm/fb.h>
+
 /*****************************************************************
  *
  * debugging and utility macros
diff --git a/drivers/video/fbdev/core/cfbcopyarea.c b/drivers/video/fbdev/core/cfbcopyarea.c
index 6d4bfeecee35..128fdd0cdcdc 100644
--- a/drivers/video/fbdev/core/cfbcopyarea.c
+++ b/drivers/video/fbdev/core/cfbcopyarea.c
@@ -26,8 +26,8 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <asm/fb.h>
 #include <asm/types.h>
-#include <asm/io.h>
 #include "fb_draw.h"
 
 #if BITS_PER_LONG == 32
diff --git a/drivers/video/fbdev/core/cfbfillrect.c b/drivers/video/fbdev/core/cfbfillrect.c
index ba9f58b2a5e8..2c6aac987786 100644
--- a/drivers/video/fbdev/core/cfbfillrect.c
+++ b/drivers/video/fbdev/core/cfbfillrect.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <asm/fb.h>
 #include <asm/types.h>
 #include "fb_draw.h"
 
diff --git a/drivers/video/fbdev/core/cfbimgblt.c b/drivers/video/fbdev/core/cfbimgblt.c
index 9ebda4e0dc7a..d1e071148a4b 100644
--- a/drivers/video/fbdev/core/cfbimgblt.c
+++ b/drivers/video/fbdev/core/cfbimgblt.c
@@ -32,6 +32,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <asm/fb.h>
 #include <asm/types.h>
 #include "fb_draw.h"
 
diff --git a/drivers/video/fbdev/core/svgalib.c b/drivers/video/fbdev/core/svgalib.c
index 9e01322fabe3..5ddd498024a8 100644
--- a/drivers/video/fbdev/core/svgalib.c
+++ b/drivers/video/fbdev/core/svgalib.c
@@ -15,9 +15,8 @@
 #include <linux/string.h>
 #include <linux/fb.h>
 #include <linux/svga.h>
+#include <asm/fb.h>
 #include <asm/types.h>
-#include <asm/io.h>
-
 
 /* Write a CRT register value spread across multiple registers */
 void svga_wcrt_multi(void __iomem *regbase, const struct vga_regset *regset, u32 value)
diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 38c0a6866d76..9fbc0994b3ae 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -48,6 +48,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
+#include <asm/fb.h>
+
 #ifdef __arm__
 #include <asm/mach-types.h>
 #endif
diff --git a/drivers/video/fbdev/ep93xx-fb.c b/drivers/video/fbdev/ep93xx-fb.c
index 305f1587bd89..5dce00500f0a 100644
--- a/drivers/video/fbdev/ep93xx-fb.c
+++ b/drivers/video/fbdev/ep93xx-fb.c
@@ -23,6 +23,8 @@
 
 #include <linux/platform_data/video-ep93xx.h>
 
+#include <asm/fb.h>
+
 /* Vertical Frame Timing Registers */
 #define EP93XXFB_VLINES_TOTAL			0x0000	/* SW locked */
 #define EP93XXFB_VSYNC				0x0004	/* SW locked */
diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index 40879d9facdf..b15271c52d05 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -41,7 +41,8 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
-#include <asm/io.h>
+
+#include <asm/fb.h>
 #include <asm/vga.h>
 
 #if 0
diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index bbb0f1d953cc..a2b5c58f7b7c 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -23,7 +23,7 @@
 
 #include <asm/machvec.h>
 #include <linux/uaccess.h>
-#include <asm/io.h>
+#include <asm/fb.h>
 #include <asm/hd64461.h>
 #include <cpu/dac.h>
 
diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 0596573ef140..8b6c3318bf8c 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -21,9 +21,10 @@
 #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <asm/io.h>
 #include <linux/uaccess.h>
 
+#include <asm/fb.h>
+
 #include <video/kyro.h>
 
 #include "STG4000Reg.h"
diff --git a/drivers/video/fbdev/matrox/matroxfb_accel.c b/drivers/video/fbdev/matrox/matroxfb_accel.c
index ce51227798a1..c982cfe68ab8 100644
--- a/drivers/video/fbdev/matrox/matroxfb_accel.c
+++ b/drivers/video/fbdev/matrox/matroxfb_accel.c
@@ -82,6 +82,8 @@
 #include "matroxfb_Ti3026.h"
 #include "matroxfb_misc.h"
 
+#include <asm/fb.h>
+
 #define curr_ydstorg(x)	((x)->curr.ydstorg.pixels)
 
 #define mga_ydstlen(y,l) mga_outl(M_YDSTLEN | M_EXEC, ((y) << 16) | (l))
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/video/fbdev/matrox/matroxfb_base.h
index c93c69bbcd57..184a6d733b93 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.h
+++ b/drivers/video/fbdev/matrox/matroxfb_base.h
@@ -43,7 +43,7 @@
 #include <linux/spinlock.h>
 #include <linux/kd.h>
 
-#include <asm/io.h>
+#include <asm/fb.h>
 #include <asm/unaligned.h>
 
 #if defined(CONFIG_PPC_PMAC)
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 47d212944f30..b6a37aff057e 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -39,6 +39,9 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+
+#include <asm/fb.h>
+
 #include <video/permedia2.h>
 #include <video/cvisionppc.h>
 
diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index b46a471df9ae..95e152969d30 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -34,6 +34,8 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 
+#include <asm/fb.h>
+
 #include <video/pm3fb.h>
 
 #if !defined(CONFIG_PCI)
diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 6888127a5eb8..1dfb75b15eea 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -74,6 +74,8 @@
 #include <cpu/sq.h>
 #endif
 
+#include <asm/fb.h>
+
 #ifndef PCI_DEVICE_ID_NEC_NEON250
 #  define PCI_DEVICE_ID_NEC_NEON250	0x0067
 #endif
diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 7d257489edcc..eb16beba10c5 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -29,6 +29,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
+#include <asm/fb.h>
+
 struct s3fb_info {
 	int chip, rev, mclk_freq;
 	int wc_cookie;
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index b528776c7612..ca15938ce603 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -31,6 +31,8 @@
 
 #include <linux/pm.h>
 
+#include <asm/fb.h>
+
 #include "sm712.h"
 
 /*
diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index da296b2ab54a..1ee4bea467b4 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -88,10 +88,10 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/init.h>
-#include <asm/io.h>
 #include <linux/uaccess.h>
 #include <video/sstfb.h>
 
+#include <asm/fb.h>
 
 /* initialized by setup */
 
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index baca6974e288..a3b837a5fb81 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -69,6 +69,8 @@
 #include <asm/grfioctl.h>	/* for HP-UX compatibility */
 #include <linux/uaccess.h>
 
+#include <asm/fb.h>
+
 #include <video/sticore.h>
 
 /* REGION_BASE(fb_info, index) returns the virtual address for region <index> */
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index d17e5e1472aa..5ed8f670f51c 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -74,7 +74,8 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#include <asm/io.h>
+
+#include <asm/fb.h>
 
 #include <video/tdfx.h>
 
diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/tridentfb.c
index 6099b9768ba1..1bd12606c9e0 100644
--- a/drivers/video/fbdev/tridentfb.c
+++ b/drivers/video/fbdev/tridentfb.c
@@ -30,6 +30,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
+#include <asm/fb.h>
+
 struct tridentfb_par {
 	void __iomem *io_virt;	/* iospace virtual memory address */
 	u32 pseudo_pal[16];
diff --git a/drivers/video/fbdev/vga16fb.c b/drivers/video/fbdev/vga16fb.c
index 1a8ffdb2be26..2899d4ce0f6f 100644
--- a/drivers/video/fbdev/vga16fb.c
+++ b/drivers/video/fbdev/vga16fb.c
@@ -23,7 +23,8 @@
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
 
-#include <asm/io.h>
+#include <asm/fb.h>
+
 #include <video/vga.h>
 
 #define MODE_SKIP4	1
diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 034333ee6e45..bc345d4fee9e 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -27,6 +27,8 @@
 #include <linux/console.h> /* Why should fb driver call console functions? because console_lock() */
 #include <video/vga.h>
 
+#include <asm/fb.h>
+
 struct vt8623fb_info {
 	char __iomem *mmio_base;
 	int wc_cookie;
diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
index c8af99f5a535..6922dd248c51 100644
--- a/include/asm-generic/fb.h
+++ b/include/asm-generic/fb.h
@@ -7,6 +7,7 @@
  * Only include this header file from your architecture's <asm/fb.h>.
  */
 
+#include <linux/io.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
 
-- 
2.40.1

