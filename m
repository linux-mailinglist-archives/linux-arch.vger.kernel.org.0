Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAD26EF4FE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Apr 2023 15:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241046AbjDZNEh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Apr 2023 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbjDZNE3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Apr 2023 09:04:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9916E420C;
        Wed, 26 Apr 2023 06:04:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D17C21A12;
        Wed, 26 Apr 2023 13:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682514265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE1CGLf64MgpqW7i1P8Xq0VK4UG/io6kopwoxd0Op0s=;
        b=K61+tGwwnMGwloMqhEtXinm1PAVVusHLv3ljsaXfulZTZqWqZ0HS/ZM19UOoLxO8FxViPq
        wQeg0d8KMkcnC+ur5I6G1R0SzxjAcbemlRjwhJmfglXFS0pu60zaweD/kqI9KkPm88q+CK
        tjUdJ2+t9dD+Cc1x17y51F/rVxuEn3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682514265;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wE1CGLf64MgpqW7i1P8Xq0VK4UG/io6kopwoxd0Op0s=;
        b=l1/pH9/wd+5DYhHsG3gIP8hZ6gbLh16kzKSToklD2YuMEwVwChWGF2rAzdxNBC+SNeDa0t
        aiqYJHcn7eoScUAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E3991390E;
        Wed, 26 Apr 2023 13:04:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WHfdJVghSWSBMgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 26 Apr 2023 13:04:24 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/5] fbdev: Move framebuffer I/O helpers into <asm/fb.h>
Date:   Wed, 26 Apr 2023 15:04:20 +0200
Message-Id: <20230426130420.19942-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426130420.19942-1-tzimmermann@suse.de>
References: <20230426130420.19942-1-tzimmermann@suse.de>
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

Implement framebuffer I/O helpers, such as fb_read*() and fb_write*(),
in the architecture's <asm/fb.h> header file or the generic one.

The general solution is to use regular I/O functions, such as
__raw_readb() or memset_io(). This has been the most-common case so
far.

The implementations for arc, ia64, loongarch and m68k operate on system
memory. As framebuffer memory is declared with volatile __iomem, the
helpers add a __force cast to avoid warnings.

Sparc uses SBus to connect framebuffer devices. It provides respective
implementations of the framebuffer I/O helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/arc/include/asm/fb.h       | 29 +++++++++++
 arch/ia64/include/asm/fb.h      | 28 ++++++++++
 arch/loongarch/include/asm/fb.h | 29 +++++++++++
 arch/m68k/include/asm/fb.h      | 29 +++++++++++
 arch/sparc/include/asm/fb.h     | 77 +++++++++++++++++++++++++++
 include/asm-generic/fb.h        | 92 +++++++++++++++++++++++++++++++++
 include/linux/fb.h              | 53 -------------------
 7 files changed, 284 insertions(+), 53 deletions(-)

diff --git a/arch/arc/include/asm/fb.h b/arch/arc/include/asm/fb.h
index 9c2383d29cbb..88fd9051e74a 100644
--- a/arch/arc/include/asm/fb.h
+++ b/arch/arc/include/asm/fb.h
@@ -3,6 +3,35 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/string.h>
+
+#define fb_readb(addr) (*(volatile u8 __force *) (addr))
+#define fb_readw(addr) (*(volatile u16 __force *) (addr))
+#define fb_readl(addr) (*(volatile u32 __force *) (addr))
+#define fb_readq(addr) (*(volatile u64 __force *) (addr))
+#define fb_writeb(b, addr) (*(volatile u8 __force *) (addr) = (b))
+#define fb_writew(b, addr) (*(volatile u16 __force *) (addr) = (b))
+#define fb_writel(b, addr) (*(volatile u32 __force *) (addr) = (b))
+#define fb_writeq(b, addr) (*(volatile u64 __force *) (addr) = (b))
+
+static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+{
+	memcpy(to, (const void __force *)from, n);
+}
+#define fb_memcpy_fromfb fb_memcpy_fromfb
+
+static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+{
+	memcpy((void __force *)to, from, n);
+}
+#define fb_memcpy_tofb fb_memcpy_tofb
+
+static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+{
+	memset((void __force *)addr, c, n);
+}
+#define fb_memset fb_memset
+
 #include <asm-generic/fb.h>
 
 #endif /* _ASM_FB_H_ */
diff --git a/arch/ia64/include/asm/fb.h b/arch/ia64/include/asm/fb.h
index 0208f64a0da0..9aea9461850c 100644
--- a/arch/ia64/include/asm/fb.h
+++ b/arch/ia64/include/asm/fb.h
@@ -3,6 +3,7 @@
 #define _ASM_FB_H_
 
 #include <linux/efi.h>
+#include <linux/string.h>
 
 #include <asm/page.h>
 
@@ -18,6 +19,33 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 }
 #define fb_pgprotect fb_pgprotect
 
+#define fb_readb(addr) (*(volatile u8 __force *) (addr))
+#define fb_readw(addr) (*(volatile u16 __force *) (addr))
+#define fb_readl(addr) (*(volatile u32 __force *) (addr))
+#define fb_readq(addr) (*(volatile u64 __force *) (addr))
+#define fb_writeb(b, addr) (*(volatile u8 __force *) (addr) = (b))
+#define fb_writew(b, addr) (*(volatile u16 __force *) (addr) = (b))
+#define fb_writel(b, addr) (*(volatile u32 __force *) (addr) = (b))
+#define fb_writeq(b, addr) (*(volatile u64 __force *) (addr) = (b))
+
+static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+{
+	memcpy(to, (const void __force *)from, n);
+}
+#define fb_memcpy_fromfb fb_memcpy_fromfb
+
+static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+{
+	memcpy((void __force *)to, from, n);
+}
+#define fb_memcpy_tofb fb_memcpy_tofb
+
+static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+{
+	memset((void __force *)addr, c, n);
+}
+#define fb_memset fb_memset
+
 #include <asm-generic/fb.h>
 
 #endif /* _ASM_FB_H_ */
diff --git a/arch/loongarch/include/asm/fb.h b/arch/loongarch/include/asm/fb.h
index ff82f20685c8..97b0f02ffd0c 100644
--- a/arch/loongarch/include/asm/fb.h
+++ b/arch/loongarch/include/asm/fb.h
@@ -5,6 +5,35 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/string.h>
+
+#define fb_readb(addr) (*(volatile u8 __force *) (addr))
+#define fb_readw(addr) (*(volatile u16 __force *) (addr))
+#define fb_readl(addr) (*(volatile u32 __force *) (addr))
+#define fb_readq(addr) (*(volatile u64 __force *) (addr))
+#define fb_writeb(b, addr) (*(volatile u8 __force *) (addr) = (b))
+#define fb_writew(b, addr) (*(volatile u16 __force *) (addr) = (b))
+#define fb_writel(b, addr) (*(volatile u32 __force *) (addr) = (b))
+#define fb_writeq(b, addr) (*(volatile u64 __force *) (addr) = (b))
+
+static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+{
+	memcpy(to, (const void __force *)from, n);
+}
+#define fb_memcpy_fromfb fb_memcpy_fromfb
+
+static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+{
+	memcpy((void __force *)to, from, n);
+}
+#define fb_memcpy_tofb fb_memcpy_tofb
+
+static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+{
+	memset((void __force *)addr, c, n);
+}
+#define fb_memset fb_memset
+
 #include <asm-generic/fb.h>
 
 #endif /* _ASM_FB_H_ */
diff --git a/arch/m68k/include/asm/fb.h b/arch/m68k/include/asm/fb.h
index 24273fc7ad91..8530d09fa04d 100644
--- a/arch/m68k/include/asm/fb.h
+++ b/arch/m68k/include/asm/fb.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/string.h>
+
 #include <asm/page.h>
 #include <asm/setup.h>
 
@@ -26,6 +28,33 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 }
 #define fb_pgprotect fb_pgprotect
 
+#define fb_readb(addr) (*(volatile u8 __force *) (addr))
+#define fb_readw(addr) (*(volatile u16 __force *) (addr))
+#define fb_readl(addr) (*(volatile u32 __force *) (addr))
+#define fb_readq(addr) (*(volatile u64 __force *) (addr))
+#define fb_writeb(b, addr) (*(volatile u8 __force *) (addr) = (b))
+#define fb_writew(b, addr) (*(volatile u16 __force *) (addr) = (b))
+#define fb_writel(b, addr) (*(volatile u32 __force *) (addr) = (b))
+#define fb_writeq(b, addr) (*(volatile u64 __force *) (addr) = (b))
+
+static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+{
+	memcpy(to, (const void __force *)from, n);
+}
+#define fb_memcpy_fromfb fb_memcpy_fromfb
+
+static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+{
+	memcpy((void __force *)to, from, n);
+}
+#define fb_memcpy_tofb fb_memcpy_tofb
+
+static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+{
+	memset((void __force *)addr, c, n);
+}
+#define fb_memset fb_memset
+
 #include <asm-generic/fb.h>
 
 #endif /* _ASM_FB_H_ */
diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index 689ee5c60054..c702892b2db7 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_FB_H_
 #define _SPARC_FB_H_
 
+#include <asm/io.h>
+
 struct fb_info;
 struct file;
 struct vm_area_struct;
@@ -16,6 +18,81 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 int fb_is_primary_device(struct fb_info *info);
 #define fb_is_primary_device fb_is_primary_device
 
+/*
+ * We map all of our framebuffers such that big-endian accesses
+ * are what we want, so the following is sufficient.
+ */
+
+static inline u8 fb_readb(const volatile void __iomem *addr)
+{
+	return sbus_readb(addr);
+}
+#define fb_readb fb_readb
+
+static inline u16 fb_readw(const volatile void __iomem *addr)
+{
+	return sbus_readw(addr);
+}
+#define fb_readw fb_readw
+
+static inline u32 fb_readl(const volatile void __iomem *addr)
+{
+	return sbus_readl(addr);
+}
+#define fb_readl fb_readl
+
+#ifdef CONFIG_SPARC64
+static inline u64 fb_readq(const volatile void __iomem *addr)
+{
+	return sbus_readq(addr);
+}
+#define fb_readq fb_readq
+#endif
+
+static inline void fb_writeb(u8 b, volatile void __iomem *addr)
+{
+	sbus_writeb(b, addr);
+}
+#define fb_writeb fb_writeb
+
+static inline void fb_writew(u16 b, volatile void __iomem *addr)
+{
+	sbus_writew(b, addr);
+}
+#define fb_writew fb_writew
+
+static inline void fb_writel(u32 b, volatile void __iomem *addr)
+{
+	sbus_writel(b, addr);
+}
+#define fb_writel fb_writel
+
+#ifdef CONFIG_SPARC64
+static inline void fb_writeq(u64 b, volatile void __iomem *addr)
+{
+	sbus_writeq(b, addr);
+}
+#define fb_writeq fb_writeq
+#endif
+
+static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+{
+	sbus_memcpy_fromio(to, from, n);
+}
+#define fb_memcpy_fromfb fb_memcpy_fromfb
+
+static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+{
+	sbus_memcpy_toio(to, from, n);
+}
+#define fb_memcpy_tofb fb_memcpy_tofb
+
+static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+{
+	sbus_memset_io(addr, c, n);
+}
+#define fb_memset fb_memset
+
 #include <asm-generic/fb.h>
 
 #endif /* _SPARC_FB_H_ */
diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
index 6922dd248c51..49eb63629ffe 100644
--- a/include/asm-generic/fb.h
+++ b/include/asm-generic/fb.h
@@ -31,4 +31,96 @@ static inline int fb_is_primary_device(struct fb_info *info)
 }
 #endif
 
+#ifndef fb_readb
+static inline u8 fb_readb(const volatile void __iomem *addr)
+{
+	return __raw_readb(addr);
+}
+#define fb_readb fb_readb
+#endif
+
+#ifndef fb_readw
+static inline u16 fb_readw(const volatile void __iomem *addr)
+{
+	return __raw_readw(addr);
+}
+#define fb_readw fb_readw
+#endif
+
+#ifndef fb_readl
+static inline u32 fb_readl(const volatile void __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+#define fb_readl fb_readl
+#endif
+
+#if defined(CONFIG_64BIT)
+#ifndef fb_readq
+static inline u64 fb_readq(const volatile void __iomem *addr)
+{
+	return __raw_readq(addr);
+}
+#define fb_readq fb_readq
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef fb_writeb
+static inline void fb_writeb(u8 b, volatile void __iomem *addr)
+{
+	__raw_writeb(b, addr);
+}
+#define fb_writeb fb_writeb
+#endif
+
+#ifndef fb_writew
+static inline void fb_writew(u16 b, volatile void __iomem *addr)
+{
+	__raw_writew(b, addr);
+}
+#define fb_writew fb_writew
+#endif
+
+#ifndef fb_writel
+static inline void fb_writel(u32 b, volatile void __iomem *addr)
+{
+	__raw_writel(b, addr);
+}
+#define fb_writel fb_writel
+#endif
+
+#if defined(CONFIG_64BIT)
+#ifndef fb_writeq
+static inline void fb_writeq(u64 b, volatile void __iomem *addr)
+{
+	__raw_writeq(b, addr);
+}
+#define fb_writeq fb_writeq
+#endif
+#endif /* CONFIG_64BIT */
+
+#ifndef fb_memcpy_fromfb
+static inline void fb_memcpy_fromfb(void *to, const volatile void __iomem *from, size_t n)
+{
+	memcpy_fromio(to, from, n);
+}
+#define fb_memcpy_fromfb fb_memcpy_fromfb
+#endif
+
+#ifndef fb_memcpy_tofb
+static inline void fb_memcpy_tofb(volatile void __iomem *to, const void *from, size_t n)
+{
+	memcpy_toio(to, from, n);
+}
+#define fb_memcpy_tofb fb_memcpy_tofb
+#endif
+
+#ifndef fb_memset
+static inline void fb_memset(volatile void __iomem *addr, int c, size_t n)
+{
+	memset_io(addr, c, n);
+}
+#define fb_memset fb_memset
+#endif
+
 #endif /* __ASM_GENERIC_FB_H_ */
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 08cb47da71f8..7d80ee62a9d5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -15,7 +15,6 @@
 #include <linux/list.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
-#include <asm/io.h>
 
 struct vm_area_struct;
 struct fb_info;
@@ -511,58 +510,6 @@ struct fb_info {
  */
 #define STUPID_ACCELF_TEXT_SHIT
 
-// This will go away
-#if defined(__sparc__)
-
-/* We map all of our framebuffers such that big-endian accesses
- * are what we want, so the following is sufficient.
- */
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
-#define fb_memset memset_io
-#define fb_memcpy_fromfb memcpy_fromio
-#define fb_memcpy_tofb memcpy_toio
-
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

