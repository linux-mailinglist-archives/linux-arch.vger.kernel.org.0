Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493176D810A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 17:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbjDEPHL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbjDEPGa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 11:06:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADC061BF;
        Wed,  5 Apr 2023 08:06:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 274B42293C;
        Wed,  5 Apr 2023 15:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680707165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4mcJLom6ZAm6gh+Qd1GGG3mMDreyMyZXiAcH0v+nJE=;
        b=E3C7DIPuZcQ5ckXXJkhw97dBSeflzO3De8NBiQlBKzkJyWilzzov31ZlhZrvaM6qBEv9LF
        BgNnkJ+AwJLkAnA28SLHgOJHj/PYlPvqDP/99rk6emLo1vqI4dNPdZ4umFYXxhyMtxJeGZ
        w6VbcM7InoKAR87SbTp0vMX+F72xm7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680707165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X4mcJLom6ZAm6gh+Qd1GGG3mMDreyMyZXiAcH0v+nJE=;
        b=cJ+t5MdSDdGmLZipOoCQHDkUf4Wd2RAWkTB44d1La3+Z8S7vVgXgnU5qiIcmRpgdzSXrd+
        hn/oD8fSciztSoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB1F213A10;
        Wed,  5 Apr 2023 15:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHbtKFyOLWTPIAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 05 Apr 2023 15:06:04 +0000
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
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 16/18] arch/sparc: Implement fb_is_primary_device() in source file
Date:   Wed,  5 Apr 2023 17:05:52 +0200
Message-Id: <20230405150554.30540-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405150554.30540-1-tzimmermann@suse.de>
References: <20230405150554.30540-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Other architectures implment fb_is_primary_device() in a source
file. Do the same on sparc. No functional changes, but allows to
remove several include statement from <asm/fb.h>.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/Makefile         |  1 +
 arch/sparc/include/asm/fb.h | 22 +++++-----------------
 arch/sparc/video/Makefile   |  3 +++
 arch/sparc/video/fbdev.c    | 24 ++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 17 deletions(-)
 create mode 100644 arch/sparc/video/Makefile
 create mode 100644 arch/sparc/video/fbdev.c

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index a4ea5b05f288..95a9211e48e3 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -60,6 +60,7 @@ libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
 drivers-$(CONFIG_PM) += arch/sparc/power/
+drivers-$(CONFIG_FB) += arch/sparc/video/
 
 boot := arch/sparc/boot
 
diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index f699962e9ddf..e4ef1955b2b6 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _SPARC_FB_H_
 #define _SPARC_FB_H_
-#include <linux/console.h>
-#include <linux/fb.h>
+
 #include <linux/fs.h>
+
 #include <asm/page.h>
 #include <asm/prom.h>
 
+struct fb_info;
+
 static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 				unsigned long off)
 {
@@ -15,20 +17,6 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 #endif
 }
 
-static inline int fb_is_primary_device(struct fb_info *info)
-{
-	struct device *dev = info->device;
-	struct device_node *node;
-
-	if (console_set_on_cmdline)
-		return 0;
-
-	node = dev->of_node;
-	if (node &&
-	    node == of_console_device)
-		return 1;
-
-	return 0;
-}
+int fb_is_primary_device(struct fb_info *info);
 
 #endif /* _SPARC_FB_H_ */
diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
new file mode 100644
index 000000000000..6baddbd58e4d
--- /dev/null
+++ b/arch/sparc/video/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_FB) += fbdev.o
diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
new file mode 100644
index 000000000000..dadd5799fbb3
--- /dev/null
+++ b/arch/sparc/video/fbdev.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/console.h>
+#include <linux/fb.h>
+#include <linux/module.h>
+
+#include <asm/fb.h>
+#include <asm/prom.h>
+
+int fb_is_primary_device(struct fb_info *info)
+{
+	struct device *dev = info->device;
+	struct device_node *node;
+
+	if (console_set_on_cmdline)
+		return 0;
+
+	node = dev->of_node;
+	if (node && node == of_console_device)
+		return 1;
+
+	return 0;
+}
+EXPORT_SYMBOL(fb_is_primary_device);
-- 
2.40.0

