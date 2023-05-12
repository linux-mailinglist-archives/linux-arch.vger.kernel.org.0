Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE270053F
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbjELKYv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240693AbjELKYu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:24:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C99726AE;
        Fri, 12 May 2023 03:24:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B8C18204C4;
        Fri, 12 May 2023 10:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683887086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKkN56RUPh9oC0BXZ+/gJrIx2IOIBYrGvTrm6Orhswg=;
        b=n6+aLNu8izfhcRaJnuJJhJrKbJ6DSVB+yHcXKRG4+vb3AzFQm4e2fudXyyZme7RhL3tTFj
        vM1tOwUBQKPd6PY9XcbHHq1QLRFyamoEXDKeFiHXKOq9RZtZVRBVt/DtmDLYbzZQohUN8c
        AvRhieO7xboS+QkQBm58OWJXACiuu+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683887086;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKkN56RUPh9oC0BXZ+/gJrIx2IOIBYrGvTrm6Orhswg=;
        b=KZdsUTsYWfAPvFBEHxbvufFVUQ4fdTohvwN70aZkMZSa7bpZrbEDbN/A6zjc1CvJWsJ2zE
        88ByvzCLuyqsOIAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D3B013466;
        Fri, 12 May 2023 10:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cCMnDu4TXmS5XwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 May 2023 10:24:46 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        sam@ravnborg.org, suijingfeng@loongson.cn
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH v7 1/7] fbdev/hitfb: Cast I/O offset to address
Date:   Fri, 12 May 2023 12:24:38 +0200
Message-Id: <20230512102444.5438-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102444.5438-1-tzimmermann@suse.de>
References: <20230512102444.5438-1-tzimmermann@suse.de>
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

Cast I/O offsets to pointers to use them with I/O functions. The I/O
functions expect pointers of type 'volatile void __iomem *', but the
offsets are plain integers. Build warnings are

  ../drivers/video/fbdev/hitfb.c: In function 'hitfb_accel_wait':
  ../arch/x86/include/asm/hd64461.h:18:33: warning: passing argument 1 of 'fb_readw' makes pointer from integer without a cast [-Wint-conversion]
   18 | #define HD64461_IO_OFFSET(x)    (HD64461_IOBASE + (x))
      |                                 ^~~~~~~~~~~~~~~~~~~~~~
      |                                 |
      |                                 unsigned int
  ../arch/x86/include/asm/hd64461.h:93:33: note: in expansion of macro 'HD64461_IO_OFFSET'
   93 | #define HD64461_GRCFGR          HD64461_IO_OFFSET(0x1044)       /* Accelerator Configuration Register */
      |                                 ^~~~~~~~~~~~~~~~~
  ../drivers/video/fbdev/hitfb.c:47:25: note: in expansion of macro 'HD64461_GRCFGR'
   47 |         while (fb_readw(HD64461_GRCFGR) & HD64461_GRCFGR_ACCSTATUS) ;
      |                         ^~~~~~~~~~~~~~
  In file included from ../arch/x86/include/asm/fb.h:15,
  from ../include/linux/fb.h:19,
  from ../drivers/video/fbdev/hitfb.c:22:
  ../include/asm-generic/fb.h:52:57: note: expected 'const volatile void *' but argument is of type 'unsigned int'
   52 | static inline u16 fb_readw(const volatile void __iomem *addr)
      |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~

This patch only fixes the build warnings. It's not clear if the I/O
offsets can legally be passed to the I/O helpers. It was apparently
broken in 2007 when custom inw()/outw() helpers got removed by
commit 34a780a0afeb ("sh: hp6xx pata_platform support."). Fixing the
driver would require setting the I/O base address.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305102136.eMjTSPwH-lkp@intel.com/
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/video/fbdev/hitfb.c | 122 ++++++++++++++++++++----------------
 1 file changed, 69 insertions(+), 53 deletions(-)

diff --git a/drivers/video/fbdev/hitfb.c b/drivers/video/fbdev/hitfb.c
index 3033f5056976..7737923b7a0a 100644
--- a/drivers/video/fbdev/hitfb.c
+++ b/drivers/video/fbdev/hitfb.c
@@ -42,17 +42,33 @@ static struct fb_fix_screeninfo hitfb_fix = {
 	.accel		= FB_ACCEL_NONE,
 };
 
+static volatile void __iomem *hitfb_offset_to_addr(unsigned int offset)
+{
+	return (__force volatile void __iomem *)(uintptr_t)offset;
+}
+
+static u16 hitfb_readw(unsigned int offset)
+{
+	return fb_readw(hitfb_offset_to_addr(offset));
+}
+
+static void hitfb_writew(u16 value, unsigned int offset)
+{
+	fb_writew(value, hitfb_offset_to_addr(offset));
+}
+
 static inline void hitfb_accel_wait(void)
 {
-	while (fb_readw(HD64461_GRCFGR) & HD64461_GRCFGR_ACCSTATUS) ;
+	while (hitfb_readw(HD64461_GRCFGR) & HD64461_GRCFGR_ACCSTATUS)
+		;
 }
 
 static inline void hitfb_accel_start(int truecolor)
 {
 	if (truecolor) {
-		fb_writew(6, HD64461_GRCFGR);
+		hitfb_writew(6, HD64461_GRCFGR);
 	} else {
-		fb_writew(7, HD64461_GRCFGR);
+		hitfb_writew(7, HD64461_GRCFGR);
 	}
 }
 
@@ -63,11 +79,11 @@ static inline void hitfb_accel_set_dest(int truecolor, u16 dx, u16 dy,
 	if (truecolor)
 		saddr <<= 1;
 
-	fb_writew(width-1, HD64461_BBTDWR);
-	fb_writew(height-1, HD64461_BBTDHR);
+	hitfb_writew(width-1, HD64461_BBTDWR);
+	hitfb_writew(height-1, HD64461_BBTDHR);
 
-	fb_writew(saddr & 0xffff, HD64461_BBTDSARL);
-	fb_writew(saddr >> 16, HD64461_BBTDSARH);
+	hitfb_writew(saddr & 0xffff, HD64461_BBTDSARL);
+	hitfb_writew(saddr >> 16, HD64461_BBTDSARH);
 
 }
 
@@ -80,7 +96,7 @@ static inline void hitfb_accel_bitblt(int truecolor, u16 sx, u16 sy, u16 dx,
 
 	height--;
 	width--;
-	fb_writew(rop, HD64461_BBTROPR);
+	hitfb_writew(rop, HD64461_BBTROPR);
 	if ((sy < dy) || ((sy == dy) && (sx <= dx))) {
 		saddr = WIDTH * (sy + height) + sx + width;
 		daddr = WIDTH * (dy + height) + dx + width;
@@ -91,32 +107,32 @@ static inline void hitfb_accel_bitblt(int truecolor, u16 sx, u16 sy, u16 dx,
 				maddr =
 				    (((width >> 4) + 1) * (height + 1) - 1) * 2;
 
-			fb_writew((1 << 5) | 1, HD64461_BBTMDR);
+			hitfb_writew((1 << 5) | 1, HD64461_BBTMDR);
 		} else
-			fb_writew(1, HD64461_BBTMDR);
+			hitfb_writew(1, HD64461_BBTMDR);
 	} else {
 		saddr = WIDTH * sy + sx;
 		daddr = WIDTH * dy + dx;
 		if (mask_addr) {
-			fb_writew((1 << 5), HD64461_BBTMDR);
+			hitfb_writew((1 << 5), HD64461_BBTMDR);
 		} else {
-			fb_writew(0, HD64461_BBTMDR);
+			hitfb_writew(0, HD64461_BBTMDR);
 		}
 	}
 	if (truecolor) {
 		saddr <<= 1;
 		daddr <<= 1;
 	}
-	fb_writew(width, HD64461_BBTDWR);
-	fb_writew(height, HD64461_BBTDHR);
-	fb_writew(saddr & 0xffff, HD64461_BBTSSARL);
-	fb_writew(saddr >> 16, HD64461_BBTSSARH);
-	fb_writew(daddr & 0xffff, HD64461_BBTDSARL);
-	fb_writew(daddr >> 16, HD64461_BBTDSARH);
+	hitfb_writew(width, HD64461_BBTDWR);
+	hitfb_writew(height, HD64461_BBTDHR);
+	hitfb_writew(saddr & 0xffff, HD64461_BBTSSARL);
+	hitfb_writew(saddr >> 16, HD64461_BBTSSARH);
+	hitfb_writew(daddr & 0xffff, HD64461_BBTDSARL);
+	hitfb_writew(daddr >> 16, HD64461_BBTDSARH);
 	if (mask_addr) {
 		maddr += mask_addr;
-		fb_writew(maddr & 0xffff, HD64461_BBTMARL);
-		fb_writew(maddr >> 16, HD64461_BBTMARH);
+		hitfb_writew(maddr & 0xffff, HD64461_BBTMARL);
+		hitfb_writew(maddr >> 16, HD64461_BBTMARH);
 	}
 	hitfb_accel_start(truecolor);
 }
@@ -127,17 +143,17 @@ static void hitfb_fillrect(struct fb_info *p, const struct fb_fillrect *rect)
 		cfb_fillrect(p, rect);
 	else {
 		hitfb_accel_wait();
-		fb_writew(0x00f0, HD64461_BBTROPR);
-		fb_writew(16, HD64461_BBTMDR);
+		hitfb_writew(0x00f0, HD64461_BBTROPR);
+		hitfb_writew(16, HD64461_BBTMDR);
 
 		if (p->var.bits_per_pixel == 16) {
-			fb_writew(((u32 *) (p->pseudo_palette))[rect->color],
+			hitfb_writew(((u32 *) (p->pseudo_palette))[rect->color],
 				  HD64461_GRSCR);
 			hitfb_accel_set_dest(1, rect->dx, rect->dy, rect->width,
 					     rect->height);
 			hitfb_accel_start(1);
 		} else {
-			fb_writew(rect->color, HD64461_GRSCR);
+			hitfb_writew(rect->color, HD64461_GRSCR);
 			hitfb_accel_set_dest(0, rect->dx, rect->dy, rect->width,
 					     rect->height);
 			hitfb_accel_start(0);
@@ -162,7 +178,7 @@ static int hitfb_pan_display(struct fb_var_screeninfo *var,
 	if (xoffset != 0)
 		return -EINVAL;
 
-	fb_writew((yoffset*info->fix.line_length)>>10, HD64461_LCDCBAR);
+	hitfb_writew((yoffset*info->fix.line_length)>>10, HD64461_LCDCBAR);
 
 	return 0;
 }
@@ -172,33 +188,33 @@ int hitfb_blank(int blank_mode, struct fb_info *info)
 	unsigned short v;
 
 	if (blank_mode) {
-		v = fb_readw(HD64461_LDR1);
+		v = hitfb_readw(HD64461_LDR1);
 		v &= ~HD64461_LDR1_DON;
-		fb_writew(v, HD64461_LDR1);
+		hitfb_writew(v, HD64461_LDR1);
 
-		v = fb_readw(HD64461_LCDCCR);
+		v = hitfb_readw(HD64461_LCDCCR);
 		v |= HD64461_LCDCCR_MOFF;
-		fb_writew(v, HD64461_LCDCCR);
+		hitfb_writew(v, HD64461_LCDCCR);
 
-		v = fb_readw(HD64461_STBCR);
+		v = hitfb_readw(HD64461_STBCR);
 		v |= HD64461_STBCR_SLCDST;
-		fb_writew(v, HD64461_STBCR);
+		hitfb_writew(v, HD64461_STBCR);
 	} else {
-		v = fb_readw(HD64461_STBCR);
+		v = hitfb_readw(HD64461_STBCR);
 		v &= ~HD64461_STBCR_SLCDST;
-		fb_writew(v, HD64461_STBCR);
+		hitfb_writew(v, HD64461_STBCR);
 
-		v = fb_readw(HD64461_LCDCCR);
+		v = hitfb_readw(HD64461_LCDCCR);
 		v &= ~(HD64461_LCDCCR_MOFF | HD64461_LCDCCR_STREQ);
-		fb_writew(v, HD64461_LCDCCR);
+		hitfb_writew(v, HD64461_LCDCCR);
 
 		do {
-		    v = fb_readw(HD64461_LCDCCR);
+		    v = hitfb_readw(HD64461_LCDCCR);
 		} while(v&HD64461_LCDCCR_STBACK);
 
-		v = fb_readw(HD64461_LDR1);
+		v = hitfb_readw(HD64461_LDR1);
 		v |= HD64461_LDR1_DON;
-		fb_writew(v, HD64461_LDR1);
+		hitfb_writew(v, HD64461_LDR1);
 	}
 	return 0;
 }
@@ -211,10 +227,10 @@ static int hitfb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 	switch (info->var.bits_per_pixel) {
 	case 8:
-		fb_writew(regno << 8, HD64461_CPTWAR);
-		fb_writew(red >> 10, HD64461_CPTWDR);
-		fb_writew(green >> 10, HD64461_CPTWDR);
-		fb_writew(blue >> 10, HD64461_CPTWDR);
+		hitfb_writew(regno << 8, HD64461_CPTWAR);
+		hitfb_writew(red >> 10, HD64461_CPTWDR);
+		hitfb_writew(green >> 10, HD64461_CPTWDR);
+		hitfb_writew(blue >> 10, HD64461_CPTWDR);
 		break;
 	case 16:
 		if (regno >= 16)
@@ -302,11 +318,11 @@ static int hitfb_set_par(struct fb_info *info)
 		break;
 	}
 
-	fb_writew(info->fix.line_length, HD64461_LCDCLOR);
-	ldr3 = fb_readw(HD64461_LDR3);
+	hitfb_writew(info->fix.line_length, HD64461_LCDCLOR);
+	ldr3 = hitfb_readw(HD64461_LDR3);
 	ldr3 &= ~15;
 	ldr3 |= (info->var.bits_per_pixel == 8) ? 4 : 8;
-	fb_writew(ldr3, HD64461_LDR3);
+	hitfb_writew(ldr3, HD64461_LDR3);
 	return 0;
 }
 
@@ -337,9 +353,9 @@ static int hitfb_probe(struct platform_device *dev)
 	hitfb_fix.smem_start = HD64461_IO_OFFSET(0x02000000);
 	hitfb_fix.smem_len = 512 * 1024;
 
-	lcdclor = fb_readw(HD64461_LCDCLOR);
-	ldvndr = fb_readw(HD64461_LDVNDR);
-	ldr3 = fb_readw(HD64461_LDR3);
+	lcdclor = hitfb_readw(HD64461_LCDCLOR);
+	ldvndr = hitfb_readw(HD64461_LDVNDR);
+	ldr3 = hitfb_readw(HD64461_LDR3);
 
 	switch (ldr3 & 15) {
 	default:
@@ -429,9 +445,9 @@ static int hitfb_suspend(struct device *dev)
 	u16 v;
 
 	hitfb_blank(1,0);
-	v = fb_readw(HD64461_STBCR);
+	v = hitfb_readw(HD64461_STBCR);
 	v |= HD64461_STBCR_SLCKE_IST;
-	fb_writew(v, HD64461_STBCR);
+	hitfb_writew(v, HD64461_STBCR);
 
 	return 0;
 }
@@ -440,12 +456,12 @@ static int hitfb_resume(struct device *dev)
 {
 	u16 v;
 
-	v = fb_readw(HD64461_STBCR);
+	v = hitfb_readw(HD64461_STBCR);
 	v &= ~HD64461_STBCR_SLCKE_OST;
 	msleep(100);
-	v = fb_readw(HD64461_STBCR);
+	v = hitfb_readw(HD64461_STBCR);
 	v &= ~HD64461_STBCR_SLCKE_IST;
-	fb_writew(v, HD64461_STBCR);
+	hitfb_writew(v, HD64461_STBCR);
 	hitfb_blank(0,0);
 
 	return 0;
-- 
2.40.1

