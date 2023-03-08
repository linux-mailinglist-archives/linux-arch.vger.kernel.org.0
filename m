Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89186B0811
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 14:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCHNLv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 08:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCHNLB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 08:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C491B51
        for <linux-arch@vger.kernel.org>; Wed,  8 Mar 2023 05:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678280859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QTt8B6xdpie3JQtkOGQkvv8PGf5htHiQBmIwsiz6QFE=;
        b=OuJf1RaWoxWKx248gB22+t/o9ABzmo3Ms6D9j7scrahqu7SwDpWDjFBZmrOhdnSlc1a2ch
        2zuGpxsIQhyzn/pJ9rJNtta3ITu11M72JXi+8Qeeh2e8xsk0KViJNPpVW+YSV4FrnmOa27
        KAM61jz9C0nuo2vvc7f+qosUsqgVS48=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-zmKLBDpnNMKup2LB2LatPQ-1; Wed, 08 Mar 2023 08:07:34 -0500
X-MC-Unique: zmKLBDpnNMKup2LB2LatPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B469857D07;
        Wed,  8 Mar 2023 13:07:33 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CAC32166B26;
        Wed,  8 Mar 2023 13:07:25 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, Baoquan He <bhe@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Serge Semin <fancer.lancer@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org
Subject: [PATCH v4 2/4] mips: add <asm-generic/io.h> including
Date:   Wed,  8 Mar 2023 21:07:08 +0800
Message-Id: <20230308130710.368085-3-bhe@redhat.com>
In-Reply-To: <20230308130710.368085-1-bhe@redhat.com>
References: <20230308130710.368085-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the adding, some default ioremap_xx methods defined in
asm-generic/io.h can be used. E.g the default ioremap_uc() returning
NULL.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/io.h | 78 ++++++++++++++++++++++++++++++++++----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index cec8347f0b85..6756baadba6c 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -126,6 +126,7 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
  *     almost all conceivable cases a device driver should not be using
  *     this function
  */
+#define phys_to_virt phys_to_virt
 static inline void * phys_to_virt(unsigned long address)
 {
 	return __va(address);
@@ -359,6 +360,27 @@ __BUILD_MEMORY_PFX(__raw_, q, u64, 0)
 __BUILD_MEMORY_PFX(__mem_, q, u64, 0)
 #endif
 
+#define readb readb
+#define readw readw
+#define readl readl
+#define writeb writeb
+#define writew writew
+#define writel writel
+
+#ifdef CONFIG_64BIT
+#define readq readq
+#define writeq writeq
+#define __raw_readq __raw_readq
+#define __raw_writeq __raw_writeq
+#endif
+
+#define __raw_readb __raw_readb
+#define __raw_readw __raw_readw
+#define __raw_readl __raw_readl
+#define __raw_writeb __raw_writeb
+#define __raw_writew __raw_writew
+#define __raw_writel __raw_writel
+
 #define __BUILD_IOPORT_PFX(bus, bwlq, type)				\
 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0,)			\
 	__BUILD_IOPORT_SINGLE(bus, bwlq, type, 1, 0, _p)
@@ -374,6 +396,27 @@ BUILDIO_IOPORT(l, u32)
 BUILDIO_IOPORT(q, u64)
 #endif
 
+#define inb inb
+#define inw inw
+#define inl inl
+#define inb_p inb_p
+#define inw_p inw_p
+#define inl_p inl_p
+
+#define outb outb
+#define outw outw
+#define outl outl
+#define outb_p outb_p
+#define outw_p outw_p
+#define outl_p outl_p
+
+#ifdef CONFIG_64BIT
+#define inq inq
+#define outq outq
+#define inq_p inq_p
+#define outq_p outq_p
+#endif
+
 #define __BUILDIO(bwlq, type)						\
 									\
 __BUILD_MEMORY_SINGLE(____raw_, bwlq, type, 1, 0, 0)
@@ -412,14 +455,6 @@ __BUILDIO(q, u64)
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
@@ -480,14 +515,39 @@ BUILDSTRING(l, u32)
 BUILDSTRING(q, u64)
 #endif
 
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
+#define readsb readsb
+#define readsw readsw
+#define readsl readsl
+#define writesb writesb
+#define writesw writesw
+#define writesl writesl
+
+#ifdef CONFIG_64BIT
+#define insq insq
+#define readsq readsq
+#define readsq readsq
+#define writesq writesq
+#endif
+
+
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
@@ -556,4 +616,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
+#include <asm-generic/io.h>
+
 #endif /* _ASM_IO_H */
-- 
2.34.1

