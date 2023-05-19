Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A246E70A01B
	for <lists+linux-arch@lfdr.de>; Fri, 19 May 2023 21:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjESTv5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 May 2023 15:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjESTvz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 May 2023 15:51:55 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19E81B4;
        Fri, 19 May 2023 12:51:53 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C89973200990;
        Fri, 19 May 2023 15:51:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 19 May 2023 15:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1684525910; x=1684612310; bh=9Ue55PNTF4
        QaBoX9cm2KiiX1+jDjMSVX9qJLLW4yuTE=; b=q5c0LGDCsmNtXet0dY5h+YEIFJ
        wES6On7QlKcuyJCv2nYiJHBAFdYKBfyvlCt/mTCPOGt1FgdcMRwmTQRg/wBs1Ubn
        qKmoXsWUftzFyZV4fNnR8uEwuysICI1Up/8e1RX1Kvujz031I22N7WdWajEr+sPV
        yP0OevuGBng6qFDdjLxDurcgmTtkolo3OTTUE0dlrAmxVQ71C+3jGauh2VhG6PsV
        51gC57y2DIIc3sF20dVWo7Bt2P3bi4r59MhqrRDdmd/bBJIM46WQ2Hak3JebULxY
        +01jTolCKlpaeVFatLtnM1QXg19GIT4V/jtJzYQT5pelx/j+6k/rRzV+LwgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684525910; x=1684612310; bh=9Ue55PNTF4QaB
        oX9cm2KiiX1+jDjMSVX9qJLLW4yuTE=; b=n9z6Hj2wjed23Hl99aB1RYvDendbE
        TQ1PYFzYfz+WY0xdb4to10Rb14m7/vF0YGq+nwcQHi8XuS6GVH8siUkbKNnlXp0I
        3W3EWThSHxW0yaGVevVR/jaf4DNbmajsZuiysURrokLNOYuvXZ+GQtojhe0Ks2VT
        MVEH12/m+UTPk9EllNUp+Y4/MuLGMdxOKw4WdgtXs/hEsHjf+98MHONWmTJNiaru
        40tTwzaYYKeP7erKuBdPaNcOyK+D3wvcDrRkcZ8zciLnWhbzx506gTg4RxkzZ+Xr
        je1BOxKLyUgX8m94OxzQtK8Bxv9t+D+yMpvXIIRuB+NZVQjwmf1EtB30w==
X-ME-Sender: <xms:VdNnZHZUyFYlcrkFrmhzNQa3jadNlHpxxpauiYX2ck4O5bv3jjxcYA>
    <xme:VdNnZGYW7Gc6zoLJ9xGXtgMyTU-2o_OV1ezulGXYiKjBTIURaF2oOZh_hu5VLvusd
    q_d1sl1KPcWrw0tf38>
X-ME-Received: <xmr:VdNnZJ-FDW2p8OpXtUoPBh_TFi4fcbarCVkU7xb8LRbkpdfrf4mgHpugxIy1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeihedgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhephfetuddtudevieeljeejteffheeujeduhefgffejudfhueelledu
    ffefgfffveeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:VdNnZNoqRuplzPAb3xWTCuPruj4Dc34bjZU4LJU5bmG9WUCy-lru4A>
    <xmx:VdNnZCrfm5O6EKNfDnbB8V82MPaaK_pxo7UEKa2rUag2GLb_M4t3sg>
    <xmx:VdNnZDRdfIvgtKpFYw7WEdrk3mh2eSNQ1keY2p2kHUbjTPegDapNIQ>
    <xmx:VtNnZDfDa8oR57g13tKbEux-wy4cU_Z-ylXkwc6TDDlWP5iW8iWTqQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 May 2023 15:51:48 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Baoquan He <bhe@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v4] mips: add <asm-generic/io.h> including
Date:   Fri, 19 May 2023 20:51:35 +0100
Message-Id: <20230519195135.79600-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the adding, some default ioremap_xx methods defined in
asm-generic/io.h can be used. E.g the default ioremap_uc() returning
NULL.

We also massaged various headers to avoid nested includes.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
[jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
---
Tested against qemu malta 34Kf, boston I6500, Loongson64, hopefully
everything is fine now.
---
 arch/mips/include/asm/io.h      | 65 +++++++++++++++++++++++++++++----
 arch/mips/include/asm/mmiowb.h  |  4 +-
 arch/mips/include/asm/smp-ops.h |  2 -
 arch/mips/include/asm/smp.h     |  4 +-
 arch/mips/kernel/setup.c        |  1 +
 arch/mips/pci/pci-ip27.c        |  3 ++
 6 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cc28d207a061..8508d01fb75e 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -15,7 +15,6 @@
 #define ARCH_HAS_IOREMAP_WC
 
 #include <linux/compiler.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/irqflags.h>
 
@@ -28,7 +27,6 @@
 #include <asm-generic/iomap.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
-#include <asm/processor.h>
 #include <asm/string.h>
 #include <mangle-port.h>
 
@@ -44,6 +42,11 @@
 # define __raw_ioswabq(a, x)	(x)
 # define ____raw_ioswabq(a, x)	(x)
 
+# define _ioswabb ioswabb
+# define _ioswabw ioswabw
+# define _ioswabl ioswabl
+# define _ioswabq ioswabq
+
 # define __relaxed_ioswabb ioswabb
 # define __relaxed_ioswabw ioswabw
 # define __relaxed_ioswabl ioswabl
@@ -129,6 +132,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
  *     almost all conceivable cases a device driver should not be using
  *     this function
  */
+#define phys_to_virt phys_to_virt
 static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
@@ -297,9 +301,9 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
 	return pfx##ioswab##bwlq(__mem, __val);				\
 }
 
-#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, relax, p)	\
+#define __BUILD_IOPORT_SINGLE(pfx, bwlq, type, barrier, relax)		\
 									\
-static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
+static inline void pfx##out##bwlq(type val, unsigned long port)		\
 {									\
 	volatile type *__addr;						\
 	type __val;							\
@@ -319,7 +323,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 	*__addr = __val;						\
 }									\
 									\
-static inline type pfx##in##bwlq##p(unsigned long port)			\
+static inline type pfx##in##bwlq(unsigned long port)			\
 {									\
 	volatile type *__addr;						\
 	type __val;							\
@@ -361,11 +365,10 @@ __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
 #endif
 
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
-	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
+	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0)
 
 #define BUILDIO_IOPORT(bwlq, type)					\
-	__BUILD_IOPORT_PFX(, bwlq, type)				\
+	__BUILD_IOPORT_PFX(_, bwlq, type)				\
 	__BUILD_IOPORT_PFX(__mem_, bwlq, type)
 
 BUILDIO_IOPORT(b, u8)
@@ -481,14 +484,17 @@ BUILDSTRING(l, u32)
 BUILDSTRING(q, u64)
 #endif
 
+#define memset_io memset_io
 static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
 {
 	memset((void __force *) addr, val, count);
 }
+#define memcpy_fromio memcpy_fromio
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
 {
 	memcpy(dst, (void __force *) src, count);
 }
+#define memcpy_toio memcpy_toio
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
 {
 	memcpy((void __force *) dst, src, count);
@@ -549,6 +555,47 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
 #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
 
+
+#define __raw_readb __raw_readb
+#define __raw_readw __raw_readw
+#define __raw_readl __raw_readl
+#define __raw_readq __raw_readq
+#define __raw_writeb __raw_writeb
+#define __raw_writew __raw_writew
+#define __raw_writel __raw_writel
+#define __raw_writeq __raw_writeq
+
+#define readb readb
+#define readw readw
+#define readl readl
+#define writeb writeb
+#define writew writew
+#define writel writel
+
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#define readsq readsq
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+#define writesq writesq
+
+#define _inb _inb
+#define _inw _inw
+#define _inl _inl
+#define insb insb
+#define insw insw
+#define insl insl
+
+#define _outb _outb
+#define _outw _outw
+#define _outl _outl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
@@ -557,4 +604,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
+#include <asm-generic/io.h>
+
 #endif /* _ASM_IO_H */
diff --git a/arch/mips/include/asm/mmiowb.h b/arch/mips/include/asm/mmiowb.h
index a40824e3ef8e..cf27752fd220 100644
--- a/arch/mips/include/asm/mmiowb.h
+++ b/arch/mips/include/asm/mmiowb.h
@@ -2,9 +2,9 @@
 #ifndef _ASM_MMIOWB_H
 #define _ASM_MMIOWB_H
 
-#include <asm/io.h>
+#include <asm/barrier.h>
 
-#define mmiowb()	iobarrier_w()
+#define mmiowb()	wmb()
 
 #include <asm-generic/mmiowb.h>
 
diff --git a/arch/mips/include/asm/smp-ops.h b/arch/mips/include/asm/smp-ops.h
index 5719ff49eff1..a6941b7f0cc0 100644
--- a/arch/mips/include/asm/smp-ops.h
+++ b/arch/mips/include/asm/smp-ops.h
@@ -13,8 +13,6 @@
 
 #include <linux/errno.h>
 
-#include <asm/mips-cps.h>
-
 #ifdef CONFIG_SMP
 
 #include <linux/cpumask.h>
diff --git a/arch/mips/include/asm/smp.h b/arch/mips/include/asm/smp.h
index aab8981bc32c..125c3494a010 100644
--- a/arch/mips/include/asm/smp.h
+++ b/arch/mips/include/asm/smp.h
@@ -11,13 +11,11 @@
 #ifndef __ASM_SMP_H
 #define __ASM_SMP_H
 
-#include <linux/bitops.h>
+#include <linux/compiler.h>
 #include <linux/linkage.h>
-#include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/cpumask.h>
 
-#include <linux/atomic.h>
 #include <asm/smp-ops.h>
 
 extern int smp_num_siblings;
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index febdc5564638..f9f149928e46 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -41,6 +41,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp-ops.h>
+#include <asm/mips-cps.h>
 #include <asm/prom.h>
 #include <asm/fw/fw.h>
 
diff --git a/arch/mips/pci/pci-ip27.c b/arch/mips/pci/pci-ip27.c
index d85cbf84e41c..973faea61cad 100644
--- a/arch/mips/pci/pci-ip27.c
+++ b/arch/mips/pci/pci-ip27.c
@@ -7,6 +7,9 @@
  * Copyright (C) 1999, 2000, 04 Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  */
+
+#include <linux/io.h>
+
 #include <asm/sn/addrs.h>
 #include <asm/sn/types.h>
 #include <asm/sn/klconfig.h>
-- 
2.39.2 (Apple Git-143)

