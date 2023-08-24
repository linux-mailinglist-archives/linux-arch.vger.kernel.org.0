Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C37786676
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 06:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjHXEEc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 00:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbjHXEEN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 00:04:13 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E688A198;
        Wed, 23 Aug 2023 21:04:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7E2945C0200;
        Thu, 24 Aug 2023 00:04:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 24 Aug 2023 00:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1692849847; x=1692936247; bh=oP/gPV/pNQ
        wDfgV/Ig6aHbuxRRON8CXYuajJAziUPQI=; b=SbvuKrUatxQamdvBhIhMvJoT2R
        3SYbZIPuU1PgsZvRY3OGvLEUWGiqcfOCGZ3TqvAzHxjsCqOidhSB1d/9tBXL4w04
        kV13Ngg7xCVXKhYubdNKE7ESZFkFKYo2zp6mLqwcGG2D/8sAvbcjaHeLvYqO19RC
        jISfAvhrfuPpnu64pv/jR1gyzhqzLwWNy3/mPWM4Uzy34J9bYov/2vv6DEAEheVv
        +g+jVZis0CVesxzcadYfr7jzt57QfmH+q0CTwKQZLkHDhsw1+uRLtsTzjOxdFlAm
        vbLXw6CLQRqa0wMaagRv3KssS3Yk2jk2oDkVnRAR+ciOBn53Yhz7qhWi+wsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692849847; x=1692936247; bh=oP/gPV/pNQwDf
        gV/Ig6aHbuxRRON8CXYuajJAziUPQI=; b=KU6/Gu7OOD6/jt4btnOHVOJiqFAf3
        26g75eHbJp51xmKjj2H1ztNwB/wICeJv3H6dG6Qoitr+gQeJgpxcCH4pprqdmIQv
        DGq2SxlBwrZbnH9kw3JrzoA6/dtozRxy7tugS//CmjcLHa3P6yJd4/m6IJnkvsHq
        FUJRdlk4dYdvPivQA6/BtVSTpLg/mJVX9LPXdNHFsgsakr0BcxYOHm2ZvtPrPV7x
        j3onP4kqXzy5hhnGqN/EZmUg+TpDcw8w1NDtD/e44cxp6ubI6hHUTTwdbkG5k8Vc
        u8G2a1I0Tp7Th+LGvkoPJSW/+2jlNtGT4MqIJXem/igsIeVyqy/8CZNgA==
X-ME-Sender: <xms:ttbmZJO8UiEAzRyWXLwa9FyPIKPNNNddU0Jtc4ULAlohquzVT0YY8Q>
    <xme:ttbmZL94IB86NDYNppQJSEw7CacCAXVaV7yYq30SiJqcmqe3jD0eW_upLu1Oa2S8a
    RVMfkr8ChZIhNfoWpQ>
X-ME-Received: <xmr:ttbmZIRbw1a4bFr2dQI0XY5tCDJvzA7Rw2W42WfsU7Esn-5_-5zYoFM14ZlU6XSAdZS4LXRMCk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvhedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhirgiguhhn
    ucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhmqeenucggtf
    frrghtthgvrhhnpefhtedutdduveeileejjeetffehueejudehgfffjeduhfeuleeludff
    fefgffevkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:ttbmZFv7-Y8HR5Xt6GCxGFeBY2LfmXddfBvQXyKcrVOgqnDAB0RtNg>
    <xmx:ttbmZBeMa8OWrb4c1vrirdO0lU7yjReu4IUzUfUcvvmUdg0SJJOq0w>
    <xmx:ttbmZB3swWzd56NuxF7-wsY7vBYk1FiXSYKL6BINR7K5Mn__-Me_lg>
    <xmx:t9bmZKF9kogaolqamTlTWbq0I28U0qUW3VrIr1Jioe1dJXMBpCOW_Q>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Aug 2023 00:04:04 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Subject: [PATCH v5] mips: add <asm-generic/io.h> including
Date:   Thu, 24 Aug 2023 12:03:29 +0800
Message-Id: <20230824040329.132810-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mips@vger.kernel.org
Cc: linux-arch@vger.kernel.org
---
v5:
   - Remove unused define of memcpy_*
   - Don't define 64bit variant of I/O ops on 32bit kernel
---
 arch/mips/include/asm/io.h      | 96 +++++++++++++++++++++++----------
 arch/mips/include/asm/mmiowb.h  |  4 +-
 arch/mips/include/asm/smp-ops.h |  2 -
 arch/mips/include/asm/smp.h     |  4 +-
 arch/mips/kernel/setup.c        |  1 +
 arch/mips/pci/pci-ip27.c        |  3 ++
 6 files changed, 75 insertions(+), 35 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 062dd4e6b954..41d8bd5adef8 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -13,7 +13,6 @@
 #define _ASM_IO_H
 
 #include <linux/compiler.h>
-#include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/irqflags.h>
 
@@ -25,7 +24,6 @@
 #include <asm/cpu-features.h>
 #include <asm/page.h>
 #include <asm/pgtable-bits.h>
-#include <asm/processor.h>
 #include <asm/string.h>
 #include <mangle-port.h>
 
@@ -41,6 +39,11 @@
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
@@ -126,6 +129,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
  *     almost all conceivable cases a device driver should not be using
  *     this function
  */
+#define phys_to_virt phys_to_virt
 static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
@@ -296,9 +300,9 @@ static inline type pfx##read##bwlq(const volatile void __iomem *mem)	\
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
@@ -318,7 +322,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
 	*__addr = __val;						\
 }									\
 									\
-static inline type pfx##in##bwlq##p(unsigned long port)			\
+static inline type pfx##in##bwlq(unsigned long port)			\
 {									\
 	volatile type *__addr;						\
 	type __val;							\
@@ -360,11 +364,10 @@ __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
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
@@ -412,14 +415,6 @@ __BUILDIO(q, u64)
 #define writeq_be(val, addr)						\
 	__raw_writeq(cpu_to_be64((val)), (__force unsigned *)(addr))
 
-/*
- * Some code tests for these symbols
- */
-#ifdef CONFIG_64BIT
-#define readq				readq
-#define writeq				writeq
-#endif
-
 #define __BUILD_MEMORY_STRING(bwlq, type)				\
 									\
 static inline void writes##bwlq(volatile void __iomem *mem,		\
@@ -480,18 +475,6 @@ BUILDSTRING(l, u32)
 BUILDSTRING(q, u64)
 #endif
 
-static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
-{
-	memset((void __force *) addr, val, count);
-}
-static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
-{
-	memcpy(dst, (void __force *) src, count);
-}
-static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
-{
-	memcpy((void __force *) dst, src, count);
-}
 
 /*
  * The caches on some architectures aren't dma-coherent and have need to
@@ -548,6 +531,61 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
 #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
 
+
+#define __raw_readb __raw_readb
+#define __raw_readw __raw_readw
+#define __raw_readl __raw_readl
+#ifdef CONFIG_64BIT
+#define __raw_readq __raw_readq
+#endif
+#define __raw_writeb __raw_writeb
+#define __raw_writew __raw_writew
+#define __raw_writel __raw_writel
+#ifdef CONFIG_64BIT
+#define __raw_writeq __raw_writeq
+#endif
+
+#define readb readb
+#define readw readw
+#define readl readl
+#ifdef CONFIG_64BIT
+#define readq readq
+#endif
+#define writeb writeb
+#define writew writew
+#define writel writel
+#ifdef CONFIG_64BIT
+#define writeq writeq
+#endif
+
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#ifdef CONFIG_64BIT
+#define readsq readsq
+#endif
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+#ifdef CONFIG_64BIT
+#define writesq writesq
+#endif
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
@@ -557,4 +595,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
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
index a40d8c0e4b87..f3b18b4a5e44 100644
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
index cb871eb784a7..6939b27b1106 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -43,6 +43,7 @@
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
2.39.2

