Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6944E6F4480
	for <lists+linux-arch@lfdr.de>; Tue,  2 May 2023 15:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjEBNDC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 2 May 2023 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbjEBNCi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 May 2023 09:02:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9836C5B8E;
        Tue,  2 May 2023 06:02:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AFB321FD9;
        Tue,  2 May 2023 13:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683032548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5smhVNnov7m4A55DYdhwmZ5Y9gsYQLIUAvwyfQy1iw=;
        b=YgAQQGGhS9p5y+Qswq2XdSC0Nb5dRapZC8k3SeCH8ou3A7cBdpeF9R1VcV/D98SVwf2rqe
        0/HTdmP3C415eNlicuQLimYKjbyJJmXE/+RevYro6XFUrrADggGk+JzkjCj37yrvnbcWUc
        CPnxgHuTmqGD/7I9ChAO48pm4esmuco=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683032548;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5smhVNnov7m4A55DYdhwmZ5Y9gsYQLIUAvwyfQy1iw=;
        b=V6uRErJzJdt0ssGWz2NlWwz2l3uwbLi85IInTKe1+Lc39r1ohNgsoEqJ7rVGTetXUVCdaL
        Bwkd9zjgj4ixg2AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DFF23134FB;
        Tue,  2 May 2023 13:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8NHLNeMJUWRYTQAAMHmgww
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
Subject: [PATCH v3 6/6] fbdev: Rename fb_mem*() helpers
Date:   Tue,  2 May 2023 15:02:23 +0200
Message-Id: <20230502130223.14719-7-tzimmermann@suse.de>
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

Update the names of the fb_mem*() helpers to be consistent with their
regular counterparts. Hence, fb_memset() now becomes fb_memset_io(),
fb_memcpy_fromfb() now becomes fb_memcpy_fromio() and fb_memcpy_tofb()
becomes fb_memcpy_toio(). No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/aty/mach64_cursor.c |  2 +-
 drivers/video/fbdev/chipsfb.c           |  2 +-
 drivers/video/fbdev/core/fbmem.c        |  4 ++--
 drivers/video/fbdev/kyro/fbdev.c        |  2 +-
 drivers/video/fbdev/pvr2fb.c            |  2 +-
 drivers/video/fbdev/sstfb.c             |  2 +-
 drivers/video/fbdev/stifb.c             |  4 ++--
 drivers/video/fbdev/tdfxfb.c            |  2 +-
 include/asm-generic/fb.h                | 16 ++++++++--------
 9 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
index a848aaff510c..6adbcf366a98 100644
--- a/drivers/video/fbdev/aty/mach64_cursor.c
+++ b/drivers/video/fbdev/aty/mach64_cursor.c
@@ -153,7 +153,7 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	    u8 m, b;
 
 	    // Clear cursor image with 1010101010...
-	    fb_memset(dst, 0xaa, 1024);
+	    fb_memset_io(dst, 0xaa, 1024);
 
 	    offset = align - width*2;
 
diff --git a/drivers/video/fbdev/chipsfb.c b/drivers/video/fbdev/chipsfb.c
index 9f9ee13ba2be..297ca6eeac1e 100644
--- a/drivers/video/fbdev/chipsfb.c
+++ b/drivers/video/fbdev/chipsfb.c
@@ -333,7 +333,7 @@ static const struct fb_var_screeninfo chipsfb_var = {
 
 static void init_chips(struct fb_info *p, unsigned long addr)
 {
-	fb_memset(p->screen_base, 0, 0x100000);
+	fb_memset_io(p->screen_base, 0, 0x100000);
 
 	p->fix = chipsfb_fix;
 	p->fix.smem_start = addr;
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 3fd95a79e4c3..a696399f2160 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -804,7 +804,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	while (count) {
 		c  = (count > PAGE_SIZE) ? PAGE_SIZE : count;
 		dst = buffer;
-		fb_memcpy_fromfb(dst, src, c);
+		fb_memcpy_fromio(dst, src, c);
 		dst += c;
 		src += c;
 
@@ -881,7 +881,7 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 			break;
 		}
 
-		fb_memcpy_tofb(dst, src, c);
+		fb_memcpy_toio(dst, src, c);
 		dst += c;
 		src += c;
 		*ppos += c;
diff --git a/drivers/video/fbdev/kyro/fbdev.c b/drivers/video/fbdev/kyro/fbdev.c
index 8b6c3318bf8c..59a6b71fba44 100644
--- a/drivers/video/fbdev/kyro/fbdev.c
+++ b/drivers/video/fbdev/kyro/fbdev.c
@@ -738,7 +738,7 @@ static int kyrofb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			       info->var.bits_per_pixel);
 	size *= info->var.yres_virtual;
 
-	fb_memset(info->screen_base, 0, size);
+	fb_memset_io(info->screen_base, 0, size);
 
 	if (register_framebuffer(info) < 0)
 		goto out_unmap;
diff --git a/drivers/video/fbdev/pvr2fb.c b/drivers/video/fbdev/pvr2fb.c
index 1dfb75b15eea..5f85207e91f7 100644
--- a/drivers/video/fbdev/pvr2fb.c
+++ b/drivers/video/fbdev/pvr2fb.c
@@ -800,7 +800,7 @@ static int __maybe_unused pvr2fb_common_init(void)
 		goto out_err;
 	}
 
-	fb_memset(fb_info->screen_base, 0, pvr2_fix.smem_len);
+	fb_memset_io(fb_info->screen_base, 0, pvr2_fix.smem_len);
 
 	pvr2_fix.ypanstep	= nopan  ? 0 : 1;
 	pvr2_fix.ywrapstep	= nowrap ? 0 : 1;
diff --git a/drivers/video/fbdev/sstfb.c b/drivers/video/fbdev/sstfb.c
index 1ee4bea467b4..327831b64b85 100644
--- a/drivers/video/fbdev/sstfb.c
+++ b/drivers/video/fbdev/sstfb.c
@@ -335,7 +335,7 @@ static int sst_calc_pll(const int freq, int *freq_out, struct pll_timing *t)
 static void sstfb_clear_screen(struct fb_info *info)
 {
 	/* clear screen */
-	fb_memset(info->screen_base, 0, info->fix.smem_len);
+	fb_memset_io(info->screen_base, 0, info->fix.smem_len);
 }
 
 
diff --git a/drivers/video/fbdev/stifb.c b/drivers/video/fbdev/stifb.c
index a3b837a5fb81..93107909155a 100644
--- a/drivers/video/fbdev/stifb.c
+++ b/drivers/video/fbdev/stifb.c
@@ -529,8 +529,8 @@ rattlerSetupPlanes(struct stifb_info *fb)
 	fb->id = saved_id;
 
 	for (y = 0; y < fb->info.var.yres; ++y)
-		fb_memset(fb->info.screen_base + y * fb->info.fix.line_length,
-			0xff, fb->info.var.xres * fb->info.var.bits_per_pixel/8);
+		fb_memset_io(fb->info.screen_base + y * fb->info.fix.line_length,
+			     0xff, fb->info.var.xres * fb->info.var.bits_per_pixel/8);
 
 	CRX24_SET_OVLY_MASK(fb);
 	SETUP_FB(fb);
diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index 5ed8f670f51c..bc8108396c22 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -1117,7 +1117,7 @@ static int tdfxfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 		u8 *mask = (u8 *)cursor->mask;
 		int i;
 
-		fb_memset(cursorbase, 0, 1024);
+		fb_memset_io(cursorbase, 0, 1024);
 
 		for (i = 0; i < cursor->image.height; i++) {
 			int h = 0;
diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
index 0540eccdbeca..bb7ee9c70e60 100644
--- a/include/asm-generic/fb.h
+++ b/include/asm-generic/fb.h
@@ -108,28 +108,28 @@ static inline void fb_writeq(u64 b, volatile void __iomem *addr)
 #endif
 #endif
 
-#ifndef fb_memcpy_fromfb
-static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+#ifndef fb_memcpy_fromio
+static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
 	memcpy_fromio(to, from, n);
 }
-#define fb_memcpy_fromfb fb_memcpy_fromfb
+#define fb_memcpy_fromio fb_memcpy_fromio
 #endif
 
-#ifndef fb_memcpy_tofb
-static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+#ifndef fb_memcpy_toio
+static inline void fb_memcpy_toio(volatile void __iomem *to, const void *from, size_t n)
 {
 	memcpy_toio(to, from, n);
 }
-#define fb_memcpy_tofb fb_memcpy_tofb
+#define fb_memcpy_toio fb_memcpy_toio
 #endif
 
 #ifndef fb_memset
-static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+static inline void fb_memset_io(volatile void __iomem *addr, int c, size_t n)
 {
 	memset_io(addr, c, n);
 }
-#define fb_memset fb_memset
+#define fb_memset fb_memset_io
 #endif
 
 #endif /* __ASM_GENERIC_FB_H_ */
-- 
2.40.1

