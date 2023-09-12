Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE75679D2B8
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 15:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjILNu7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 09:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235035AbjILNu5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 09:50:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A34810D8;
        Tue, 12 Sep 2023 06:50:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5D2141F45A;
        Tue, 12 Sep 2023 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694526652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaQuO1Trmju0iKDQmxHT4XBB71pRgiPLDhCaXeO65jU=;
        b=Hos20QQw4ntyf6um4hlBI3ePzarrHK5QKcrU058kAuv/3CS3xHjpDigHoV2xho6xzXq8WB
        CUMvXpOo+LBN9o/S5TnQJ9pp+uCjbqb00bgZ5orT/1tiaVt9XVqnWH/LbLhpvzfXk/kgSt
        n0OjVhceDx1oFwBjKVp7rZ+Orj3/nSs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694526652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SaQuO1Trmju0iKDQmxHT4XBB71pRgiPLDhCaXeO65jU=;
        b=9OvzmtfYsc+EYGI8dcSL66V7JBn3GEdWq46ch0Xq/UCIM451d8mUf3fyKJOHRlYW1IwlNp
        4q52Ol4dOW6i2zDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D6A2139DB;
        Tue, 12 Sep 2023 13:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SKBmBrxsAGVKQwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 12 Sep 2023 13:50:52 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 2/5] fbdev: Replace fb_pgprotect() with pgprot_framebuffer()
Date:   Tue, 12 Sep 2023 15:49:00 +0200
Message-ID: <20230912135050.17155-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912135050.17155-1-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Rename the fbdev mmap helper fb_pgprotect() to pgprot_framebuffer().
The helper sets VMA page-access flags for framebuffers in device I/O
memory.

Also clean up the helper's parameters and return value. Instead of
the VMA instance, pass the individial parameters separately: existing
page-access flags, the VMAs start and end addresses and the offset
in the underlying device memory rsp file. Return the new page-access
flags. These changes align pgprot_framebuffer() with other pgprot_()
functions.

v4:
	* fix commit message (Christophe)
v3:
	* rename fb_pgprotect() to pgprot_framebuffer() (Arnd)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/ia64/include/asm/fb.h           | 15 +++++++--------
 arch/m68k/include/asm/fb.h           | 19 ++++++++++---------
 arch/mips/include/asm/fb.h           | 11 +++++------
 arch/powerpc/include/asm/fb.h        | 13 +++++--------
 arch/sparc/include/asm/fb.h          | 15 +++++++++------
 arch/x86/include/asm/fb.h            | 10 ++++++----
 arch/x86/video/fbdev.c               | 15 ++++++++-------
 drivers/video/fbdev/core/fb_chrdev.c |  3 ++-
 include/asm-generic/fb.h             | 12 ++++++------
 9 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/arch/ia64/include/asm/fb.h b/arch/ia64/include/asm/fb.h
index 1717b26fd423f..7fce0d5423590 100644
--- a/arch/ia64/include/asm/fb.h
+++ b/arch/ia64/include/asm/fb.h
@@ -8,17 +8,16 @@
 
 #include <asm/page.h>
 
-struct file;
-
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
+static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
+					  unsigned long vm_start, unsigned long vm_end,
+					  unsigned long offset)
 {
-	if (efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	if (efi_range_is_wc(vm_start, vm_end - vm_start))
+		return pgprot_writecombine(prot);
 	else
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+		return pgprot_noncached(prot);
 }
-#define fb_pgprotect fb_pgprotect
+#define pgprot_framebuffer pgprot_framebuffer
 
 static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
diff --git a/arch/m68k/include/asm/fb.h b/arch/m68k/include/asm/fb.h
index 24273fc7ad917..9941b7434b696 100644
--- a/arch/m68k/include/asm/fb.h
+++ b/arch/m68k/include/asm/fb.h
@@ -5,26 +5,27 @@
 #include <asm/page.h>
 #include <asm/setup.h>
 
-struct file;
-
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
+static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
+					  unsigned long vm_start, unsigned long vm_end,
+					  unsigned long offset)
 {
 #ifdef CONFIG_MMU
 #ifdef CONFIG_SUN3
-	pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
+	pgprot_val(prot) |= SUN3_PAGE_NOCACHE;
 #else
 	if (CPU_IS_020_OR_030)
-		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE030;
+		pgprot_val(prot) |= _PAGE_NOCACHE030;
 	if (CPU_IS_040_OR_060) {
-		pgprot_val(vma->vm_page_prot) &= _CACHEMASK040;
+		pgprot_val(prot) &= _CACHEMASK040;
 		/* Use no-cache mode, serialized */
-		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
+		pgprot_val(prot) |= _PAGE_NOCACHE_S;
 	}
 #endif /* CONFIG_SUN3 */
 #endif /* CONFIG_MMU */
+
+	return prot;
 }
-#define fb_pgprotect fb_pgprotect
+#define pgprot_framebuffer pgprot_framebuffer
 
 #include <asm-generic/fb.h>
 
diff --git a/arch/mips/include/asm/fb.h b/arch/mips/include/asm/fb.h
index 18b7226403bad..d98d6681d64ec 100644
--- a/arch/mips/include/asm/fb.h
+++ b/arch/mips/include/asm/fb.h
@@ -3,14 +3,13 @@
 
 #include <asm/page.h>
 
-struct file;
-
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
+static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
+					  unsigned long vm_start, unsigned long vm_end,
+					  unsigned long offset)
 {
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	return pgprot_noncached(prot);
 }
-#define fb_pgprotect fb_pgprotect
+#define pgprot_framebuffer pgprot_framebuffer
 
 /*
  * MIPS doesn't define __raw_ I/O macros, so the helpers
diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/fb.h
index 61e3b8806db69..3cecf14d51de8 100644
--- a/arch/powerpc/include/asm/fb.h
+++ b/arch/powerpc/include/asm/fb.h
@@ -2,23 +2,20 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
-#include <linux/fs.h>
-
 #include <asm/page.h>
 
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
+static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
+					  unsigned long vm_start, unsigned long vm_end,
+					  unsigned long offset)
 {
 	/*
 	 * PowerPC's implementation of phys_mem_access_prot() does
 	 * not use the file argument. Set it to NULL in preparation
 	 * of later updates to the interface.
 	 */
-	vma->vm_page_prot = phys_mem_access_prot(NULL, PHYS_PFN(off),
-						 vma->vm_end - vma->vm_start,
-						 vma->vm_page_prot);
+	return phys_mem_access_prot(NULL, PHYS_PFN(offset), vm_end - vm_start, prot);
 }
-#define fb_pgprotect fb_pgprotect
+#define pgprot_framebuffer pgprot_framebuffer
 
 #include <asm-generic/fb.h>
 
diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index 572ecd3e1cc48..24440c0fda490 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -4,15 +4,18 @@
 
 #include <linux/io.h>
 
+#include <asm/page.h>
+
 struct fb_info;
-struct file;
-struct vm_area_struct;
 
 #ifdef CONFIG_SPARC32
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
-{ }
-#define fb_pgprotect fb_pgprotect
+static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
+					  unsigned long vm_start, unsigned long vm_end,
+					  unsigned long offset)
+{
+	return prot;
+}
+#define pgprot_framebuffer pgprot_framebuffer
 #endif
 
 int fb_is_primary_device(struct fb_info *info);
diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/fb.h
index 23873da8fb77c..c3b9582de7efd 100644
--- a/arch/x86/include/asm/fb.h
+++ b/arch/x86/include/asm/fb.h
@@ -2,12 +2,14 @@
 #ifndef _ASM_X86_FB_H
 #define _ASM_X86_FB_H
 
+#include <asm/page.h>
+
 struct fb_info;
-struct file;
-struct vm_area_struct;
 
-void fb_pgprotect(struct file *file, struct vm_area_struct *vma, unsigned long off);
-#define fb_pgprotect fb_pgprotect
+pgprot_t pgprot_framebuffer(pgprot_t prot,
+			    unsigned long vm_start, unsigned long vm_end,
+			    unsigned long offset);
+#define pgprot_framebuffer pgprot_framebuffer
 
 int fb_is_primary_device(struct fb_info *info);
 #define fb_is_primary_device fb_is_primary_device
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 49a0452402e97..1dd6528cc947c 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -13,16 +13,17 @@
 #include <linux/vgaarb.h>
 #include <asm/fb.h>
 
-void fb_pgprotect(struct file *file, struct vm_area_struct *vma, unsigned long off)
+pgprot_t pgprot_framebuffer(pgprot_t prot,
+			    unsigned long vm_start, unsigned long vm_end,
+			    unsigned long offset)
 {
-	unsigned long prot;
-
-	prot = pgprot_val(vma->vm_page_prot) & ~_PAGE_CACHE_MASK;
+	pgprot_val(prot) &= ~_PAGE_CACHE_MASK;
 	if (boot_cpu_data.x86 > 3)
-		pgprot_val(vma->vm_page_prot) =
-			prot | cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
+		pgprot_val(prot) |= cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS);
+
+	return prot;
 }
-EXPORT_SYMBOL(fb_pgprotect);
+EXPORT_SYMBOL(pgprot_framebuffer);
 
 int fb_is_primary_device(struct fb_info *info)
 {
diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index eadb81f53a821..32a7315b4b6dd 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -365,7 +365,8 @@ static int fb_mmap(struct file *file, struct vm_area_struct *vma)
 	mutex_unlock(&info->mm_lock);
 
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	fb_pgprotect(file, vma, start);
+	vma->vm_page_prot = pgprot_framebuffer(vma->vm_page_prot, vma->vm_start,
+					       vma->vm_end, start);
 
 	return vm_iomap_memory(vma, start, len);
 }
diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
index bb7ee9c70e603..6ccabb400aa66 100644
--- a/include/asm-generic/fb.h
+++ b/include/asm-generic/fb.h
@@ -12,14 +12,14 @@
 #include <linux/pgtable.h>
 
 struct fb_info;
-struct file;
 
-#ifndef fb_pgprotect
-#define fb_pgprotect fb_pgprotect
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
+#ifndef pgprot_framebuffer
+#define pgprot_framebuffer pgprot_framebuffer
+static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
+					  unsigned long vm_start, unsigned long vm_end,
+					  unsigned long offset)
 {
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	return pgprot_writecombine(prot);
 }
 #endif
 
-- 
2.42.0

