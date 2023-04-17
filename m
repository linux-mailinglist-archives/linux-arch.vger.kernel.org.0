Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70926E48ED
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 14:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjDQM7t (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 08:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjDQM5o (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 08:57:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C774686;
        Mon, 17 Apr 2023 05:57:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EE88921A8E;
        Mon, 17 Apr 2023 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681736223; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clUDjDH/bPWQSIzDszYi3/oWFwNxlrGwwLdQNX68Lw4=;
        b=sFsu/btvzBzKBTdHfoh9f7gkzVBKnILRtZD+kCJlEMjDjzMNkXKXygZ9jYgmbibyQbJsL6
        ouw4hAWjPH1AAEGek+OihtCjyCyqdsP/q9hEoijffbZglV0Ke+yUyZWWIDOWqDhIkVkEYE
        PI+Ypb39XIiS8JMssB8rKjFIK94lwrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681736223;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=clUDjDH/bPWQSIzDszYi3/oWFwNxlrGwwLdQNX68Lw4=;
        b=DEhNa/mlpAMmKlm1givPI/g/HB0ECPTaXd4BfaOzWxB90gRjkNnpoRi6MHY/m3Dz1e2PZh
        kmr7r65eRj2RJWDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CD061391A;
        Mon, 17 Apr 2023 12:57:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sP5mIR9CPWToWwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 12:57:03 +0000
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
        Thomas Zimmermann <tzimmermann@suse.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v3 13/19] arch/parisc: Implement fb_is_primary_device() under arch/parisc
Date:   Mon, 17 Apr 2023 14:56:45 +0200
Message-Id: <20230417125651.25126-14-tzimmermann@suse.de>
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

Move PARISC's implementation of fb_is_primary_device() into the
architecture directory. This the place of the declaration and
where other architectures implement this function. No functional
changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
---
 arch/parisc/Makefile         |  2 ++
 arch/parisc/include/asm/fb.h |  2 +-
 arch/parisc/video/Makefile   |  3 +++
 arch/parisc/video/fbdev.c    | 27 +++++++++++++++++++++++++++
 drivers/video/sticore.c      | 19 -------------------
 include/video/sticore.h      |  2 ++
 6 files changed, 35 insertions(+), 20 deletions(-)
 create mode 100644 arch/parisc/video/Makefile
 create mode 100644 arch/parisc/video/fbdev.c

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 0d049a6f6a60..968ebe17494c 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -119,6 +119,8 @@ export LIBGCC
 
 libs-y	+= arch/parisc/lib/ $(LIBGCC)
 
+drivers-y += arch/parisc/video/
+
 boot	:= arch/parisc/boot
 
 PALO := $(shell if (which palo 2>&1); then : ; \
diff --git a/arch/parisc/include/asm/fb.h b/arch/parisc/include/asm/fb.h
index 55d29c4f716e..0b9a38ced5c8 100644
--- a/arch/parisc/include/asm/fb.h
+++ b/arch/parisc/include/asm/fb.h
@@ -12,7 +12,7 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
 }
 
-#if defined(CONFIG_FB_STI)
+#if defined(CONFIG_STI_CORE)
 int fb_is_primary_device(struct fb_info *info);
 #else
 static inline int fb_is_primary_device(struct fb_info *info)
diff --git a/arch/parisc/video/Makefile b/arch/parisc/video/Makefile
new file mode 100644
index 000000000000..16a73cce4661
--- /dev/null
+++ b/arch/parisc/video/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_STI_CORE) += fbdev.o
diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/fbdev.c
new file mode 100644
index 000000000000..4a0ae08fc75b
--- /dev/null
+++ b/arch/parisc/video/fbdev.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2000 Philipp Rumpf <prumpf@tux.org>
+ * Copyright (C) 2001-2020 Helge Deller <deller@gmx.de>
+ * Copyright (C) 2001-2002 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
+ */
+
+#include <linux/module.h>
+
+#include <asm/fb.h>
+
+#include <video/sticore.h>
+
+int fb_is_primary_device(struct fb_info *info)
+{
+	struct sti_struct *sti;
+
+	sti = sti_get_rom(0);
+
+	/* if no built-in graphics card found, allow any fb driver as default */
+	if (!sti)
+		return true;
+
+	/* return true if it's the default built-in framebuffer driver */
+	return (sti->info == info);
+}
+EXPORT_SYMBOL(fb_is_primary_device);
diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index f8aaedea437d..7eb925f2ba9c 100644
--- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -30,7 +30,6 @@
 #include <asm/pdc.h>
 #include <asm/cacheflush.h>
 #include <asm/grfioctl.h>
-#include <asm/fb.h>
 
 #include <video/sticore.h>
 
@@ -1148,24 +1147,6 @@ int sti_call(const struct sti_struct *sti, unsigned long func,
 	return ret;
 }
 
-#if defined(CONFIG_FB_STI)
-/* check if given fb_info is the primary device */
-int fb_is_primary_device(struct fb_info *info)
-{
-	struct sti_struct *sti;
-
-	sti = sti_get_rom(0);
-
-	/* if no built-in graphics card found, allow any fb driver as default */
-	if (!sti)
-		return true;
-
-	/* return true if it's the default built-in framebuffer driver */
-	return (sti->info == info);
-}
-EXPORT_SYMBOL(fb_is_primary_device);
-#endif
-
 MODULE_AUTHOR("Philipp Rumpf, Helge Deller, Thomas Bogendoerfer");
 MODULE_DESCRIPTION("Core STI driver for HP's NGLE series graphics cards in HP PARISC machines");
 MODULE_LICENSE("GPL v2");
diff --git a/include/video/sticore.h b/include/video/sticore.h
index c0879352cde4..fbb78d7e7565 100644
--- a/include/video/sticore.h
+++ b/include/video/sticore.h
@@ -2,6 +2,8 @@
 #ifndef STICORE_H
 #define STICORE_H
 
+struct fb_info;
+
 /* generic STI structures & functions */
 
 #define MAX_STI_ROMS 4		/* max no. of ROMs which this driver handles */
-- 
2.40.0

