Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FB76F140E
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 11:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjD1J1T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 05:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345592AbjD1J1S (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 05:27:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74944496;
        Fri, 28 Apr 2023 02:27:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 580052002E;
        Fri, 28 Apr 2023 09:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682674035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5VYWy/AvbpTwYMUvgq/Qf7JvO1LdK29uHbuVPQM8w+I=;
        b=GVDAylSdFB2aC8MzuHMzQQpnFsJO4b+FYu4OUDiHDHTyD+mATNULQ82rwHCWtJJ2n7oa4O
        wmtSxgAGOys9EGQlQlyGj32QskSRu6EmzTrpvbR8TcTaUiGEWxITGrBNjm9U13oGsvKd9E
        L3rjOzqF3CBsko70lonU/BQKqTYWGMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682674035;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5VYWy/AvbpTwYMUvgq/Qf7JvO1LdK29uHbuVPQM8w+I=;
        b=OVW7mKvhPqZ91zi25yBTo9BJR5O4Kqqzh5IohkbwFTzfRAquwndXbRpfe1BoyZ0d8UJeDt
        2gGjf0nPmiJngkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE31E139C3;
        Fri, 28 Apr 2023 09:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0HViOXKRS2ReFwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 28 Apr 2023 09:27:14 +0000
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
Subject: [PATCH v2 5/5] fbdev: Define framebuffer I/O from Linux' I/O functions
Date:   Fri, 28 Apr 2023 11:27:11 +0200
Message-Id: <20230428092711.406-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428092711.406-1-tzimmermann@suse.de>
References: <20230428092711.406-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Implement framebuffer I/O helpers, such as fb_read*() and fb_write*()
with Linux' regular I/O functions. Remove all ifdef cases for the
various architectures.

Most of the supported architectures use __raw_() I/O functions or treat
framebuffer memory like regular memory. This is also implemented by the
architectures' I/O function, so we can use them instead.

Sparc uses SBus to connect to framebuffer devices. It provides respective
implementations of the framebuffer I/O helpers. The involved sbus_()
I/O helpers map to the same code as Sparc's regular I/O functions. As
with other platforms, we can use those instead.

We leave a TODO item to replace all fb_() functions with their regular
I/O counterparts throughout the fbdev drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 63 +++++++++++-----------------------------------
 1 file changed, 15 insertions(+), 48 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index 08cb47da71f8..4aa9e90edd17 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -15,7 +15,6 @@
 #include <linux/list.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
-#include <asm/io.h>
 
 struct vm_area_struct;
 struct fb_info;
@@ -511,58 +510,26 @@ struct fb_info {
  */
 #define STUPID_ACCELF_TEXT_SHIT
 
-// This will go away
-#if defined(__sparc__)
-
-/* We map all of our framebuffers such that big-endian accesses
- * are what we want, so the following is sufficient.
+/*
+ * TODO: Update fbdev drivers to call the I/O helpers directly and
+ *       remove the fb_() tokens.
  */
-
-// This will go away
-#define fb_readb sbus_readb
-#define fb_readw sbus_readw
-#define fb_readl sbus_readl
-#define fb_readq sbus_readq
-#define fb_writeb sbus_writeb
-#define fb_writew sbus_writew
-#define fb_writel sbus_writel
-#define fb_writeq sbus_writeq
-#define fb_memset sbus_memset_io
-#define fb_memcpy_fromfb sbus_memcpy_fromio
-#define fb_memcpy_tofb sbus_memcpy_toio
-
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) ||	\
-	defined(__hppa__) || defined(__sh__) || defined(__powerpc__) ||	\
-	defined(__arm__) || defined(__aarch64__) || defined(__mips__)
-
-#define fb_readb __raw_readb
-#define fb_readw __raw_readw
-#define fb_readl __raw_readl
-#define fb_readq __raw_readq
-#define fb_writeb __raw_writeb
-#define fb_writew __raw_writew
-#define fb_writel __raw_writel
-#define fb_writeq __raw_writeq
+#define fb_readb readb
+#define fb_readw readw
+#define fb_readl readl
+#if defined(CONFIG_64BIT)
+#define fb_readq readq
+#endif
+#define fb_writeb writeb
+#define fb_writew writew
+#define fb_writel writel
+#if defined(CONFIG_64BIT)
+#define fb_writeq writeq
+#endif
 #define fb_memset memset_io
 #define fb_memcpy_fromfb memcpy_fromio
 #define fb_memcpy_tofb memcpy_toio
 
-#else
-
-#define fb_readb(addr) (*(volatile u8 *) (addr))
-#define fb_readw(addr) (*(volatile u16 *) (addr))
-#define fb_readl(addr) (*(volatile u32 *) (addr))
-#define fb_readq(addr) (*(volatile u64 *) (addr))
-#define fb_writeb(b,addr) (*(volatile u8 *) (addr) = (b))
-#define fb_writew(b,addr) (*(volatile u16 *) (addr) = (b))
-#define fb_writel(b,addr) (*(volatile u32 *) (addr) = (b))
-#define fb_writeq(b,addr) (*(volatile u64 *) (addr) = (b))
-#define fb_memset memset
-#define fb_memcpy_fromfb memcpy
-#define fb_memcpy_tofb memcpy
-
-#endif
-
 #define FB_LEFT_POS(p, bpp)          (fb_be_math(p) ? (32 - (bpp)) : 0)
 #define FB_SHIFT_HIGH(p, val, bits)  (fb_be_math(p) ? (val) >> (bits) : \
 						      (val) << (bits))
-- 
2.40.0

