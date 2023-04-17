Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5C66E48C2
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDQM7B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 08:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbjDQM5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 08:57:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25DF9ED6;
        Mon, 17 Apr 2023 05:57:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BC4EA1FE0F;
        Mon, 17 Apr 2023 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681736225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rz0KVXgl7eygxSOZmb7rFdY5CLJi8hQKmbruW8U1YU=;
        b=VpHvENwZHnBCyXjOULTtGXZdYAugTWqnh+HTkbLLExQWCyu+/FN1J7BdzAaO6YDeoE7GW4
        HP8VXSA0tIb8XdH7qNsiW6OXkFbCtAecOY7mH5fW7wFCalLfaXTBxPHiiarpzxr3+IYs9w
        vtGN25+04Ttm7vFolaDi1M+V0AQnU3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681736225;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rz0KVXgl7eygxSOZmb7rFdY5CLJi8hQKmbruW8U1YU=;
        b=BXMcHuKHts+WrGo+6uxSH+bF2kXeTa35zcDAx3h7WJADV68Zx7N+ICQonVWeTSPJg7atE7
        I9Yhhfsyb2mxfEAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 639721390E;
        Mon, 17 Apr 2023 12:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MO3fFiFCPWToWwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 12:57:05 +0000
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
Subject: [PATCH v3 17/19] arch/sparc: Implement fb_is_primary_device() in source file
Date:   Mon, 17 Apr 2023 14:56:49 +0200
Message-Id: <20230417125651.25126-18-tzimmermann@suse.de>
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

Other architectures implment fb_is_primary_device() in a source
file. Do the same on sparc. No functional changes, but allows to
remove several include statement from <asm/fb.h>.

v2:
	* don't include <asm/prom.h> in header file

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/Makefile         |  1 +
 arch/sparc/include/asm/fb.h | 23 +++++------------------
 arch/sparc/video/Makefile   |  3 +++
 arch/sparc/video/fbdev.c    | 24 ++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 18 deletions(-)
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
index f699962e9ddf..28609f7a965c 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -1,11 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _SPARC_FB_H_
 #define _SPARC_FB_H_
-#include <linux/console.h>
-#include <linux/fb.h>
+
 #include <linux/fs.h>
+
 #include <asm/page.h>
-#include <asm/prom.h>
+
+struct fb_info;
 
 static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 				unsigned long off)
@@ -15,20 +16,6 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
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

