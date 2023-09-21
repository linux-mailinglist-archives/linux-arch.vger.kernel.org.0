Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753C17A9E9B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjIUUDw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjIUUDn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574E9E73
        for <linux-arch@vger.kernel.org>; Thu, 21 Sep 2023 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gc794sWeUcluHG84qn7IZLMHNx7xgMXK60iMjhdtco8=;
        b=hgPKQ26i27xpTFX/hxwEbWBJ/Ncn1VsndK07nh1lvX+jEl20BMlX1UhRbR1mkvxfPQ434o
        pZGtJ2glaJmUbEmDjrbqjboBzxqKTmbTCl7Arhh4mMeavZTklRAF9HkVGu9vSGC7CqagV9
        r/8gF2a+UCOa7S1CELBVt27TIPG35I0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-Fm1uU5RAMbyD5e9qp4Klfw-1; Thu, 21 Sep 2023 07:04:48 -0400
X-MC-Unique: Fm1uU5RAMbyD5e9qp4Klfw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F41DB8039D2;
        Thu, 21 Sep 2023 11:04:47 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 124EF2156701;
        Thu, 21 Sep 2023 11:04:41 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, arnd@arndb.de, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        deller@gmx.de, Baoquan He <bhe@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org
Subject: [PATCH v5 2/4] mips: add <asm-generic/io.h> including
Date:   Thu, 21 Sep 2023 19:04:22 +0800
Message-ID: <20230921110424.215592-3-bhe@redhat.com>
In-Reply-To: <20230921110424.215592-1-bhe@redhat.com>
References: <20230921110424.215592-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

With the adding, some default ioremap_xx methods defined in
asm-generic/io.h can be used. E.g the default ioremap_uc() returning
NULL.

We also massaged various headers to avoid nested includes.

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
[jiaxun.yang@flygoat.com: Massage more headers, fix ioport defines]
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-mips@vger.kernel.org
Cc: linux-arch@vger.kernel.org
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
2.41.0

