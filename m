Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1A6B0818
	for <lists+linux-arch@lfdr.de>; Wed,  8 Mar 2023 14:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCHNNK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 8 Mar 2023 08:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjCHNMq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 8 Mar 2023 08:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB5C6E60
        for <linux-arch@vger.kernel.org>; Wed,  8 Mar 2023 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678280877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gLq762oeic7hM/krtcOf8E8H5QTsFuEhCmd4UZ/jjZs=;
        b=eZzpjABtRrRU8+oZ/VUrqtSUll8ZUnDa71/WcbEEVEgj//WxqiepNsm9gkvR33ovyDb9uJ
        zEW8vhrtVf8enDLAwb+b/qU+ljE0yxh/F8aMyM9qOe5ix1c82eyZtFLap+gFZvxfCyRF+f
        QB56ZuwBkkqyS4otGoCAZZVjD9U7j5Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-uSFGI7sxPSKXvm-FACyRDg-1; Wed, 08 Mar 2023 08:07:51 -0500
X-MC-Unique: uSFGI7sxPSKXvm-FACyRDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 505EC2932493;
        Wed,  8 Mar 2023 13:07:50 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-137.pek2.redhat.com [10.72.12.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CAD02166B26;
        Wed,  8 Mar 2023 13:07:42 +0000 (UTC)
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
Subject: [PATCH v4 4/4] mips: io: remove duplicated codes
Date:   Wed,  8 Mar 2023 21:07:10 +0800
Message-Id: <20230308130710.368085-5-bhe@redhat.com>
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

By adding asm-generic/io.h support, there are some duplicated function
implementation, like phys_to_virt, memset_io, memcpy_(from|to)io.
Let's remove them to use the default version in asm-neneric/io.h.

Meanwhile move isa_bus_to_virt() down below <asm-generic/io.h> including
line to fix the compiling error of missing phys_to_virt definition.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Serge Semin <fancer.lancer@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-mips@vger.kernel.org
---
 arch/mips/include/asm/io.h | 45 +++++---------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index da0a625c3c6d..1b38f02bc608 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -114,24 +114,6 @@ static inline phys_addr_t virt_to_phys(const volatile void *x)
 	return __virt_to_phys(x);
 }
 
-/*
- *     phys_to_virt    -       map physical address to virtual
- *     @address: address to remap
- *
- *     The returned virtual address is a current CPU mapping for
- *     the memory address given. It is only valid to use this function on
- *     addresses that have a kernel mapping
- *
- *     This function does not handle bus mappings for DMA transfers. In
- *     almost all conceivable cases a device driver should not be using
- *     this function
- */
-#define phys_to_virt phys_to_virt
-static inline void * phys_to_virt(unsigned long address)
-{
-	return __va(address);
-}
-
 /*
  * ISA I/O bus memory addresses are 1:1 with the physical address.
  */
@@ -140,11 +122,6 @@ static inline unsigned long isa_virt_to_bus(volatile void *address)
 	return virt_to_phys(address);
 }
 
-static inline void *isa_bus_to_virt(unsigned long address)
-{
-	return phys_to_virt(address);
-}
-
 /*
  * Change "struct page" to physical address.
  */
@@ -535,23 +512,6 @@ BUILDSTRING(q, u64)
 #define writesq writesq
 #endif
 
-
-#define memset_io memset_io
-static inline void memset_io(volatile void __iomem *addr, unsigned char val, int count)
-{
-	memset((void __force *) addr, val, count);
-}
-#define memcpy_fromio memcpy_fromio
-static inline void memcpy_fromio(void *dst, const volatile void __iomem *src, int count)
-{
-	memcpy(dst, (void __force *) src, count);
-}
-#define memcpy_toio memcpy_toio
-static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int count)
-{
-	memcpy((void __force *) dst, src, count);
-}
-
 /*
  * The caches on some architectures aren't dma-coherent and have need to
  * handle this in software.  There are three types of operations that
@@ -617,4 +577,9 @@ void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
 #include <asm-generic/io.h>
 
+static inline void *isa_bus_to_virt(unsigned long address)
+{
+	return phys_to_virt(address);
+}
+
 #endif /* _ASM_IO_H */
-- 
2.34.1

