Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAE36A6ABA
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 11:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCAKXR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 05:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCAKXL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 05:23:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C803B3C5
        for <linux-arch@vger.kernel.org>; Wed,  1 Mar 2023 02:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677666146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XOyiQKIdMnvfgHK0+JM6b4NpBz3+X6fBNBNCgpa23Zk=;
        b=Dy+pu5wkpGavS149YAv0IcvOoTMZI34eAw7QmL9qVw7Uj+DHGGe2ZvNKWo0PNEEgUBr5sZ
        45zWy6JZldA1gdEuG90jWJc5YcKcakbmesu8DK7QpyQf9Qt6UDjsNku/05YBdxMpIV/fUP
        zq/4j0auyRKKgu0fEImYpKRJg9ziHCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-388-jPx6-0M8MLWGe2Rl2uX8Wg-1; Wed, 01 Mar 2023 05:22:24 -0500
X-MC-Unique: jPx6-0M8MLWGe2Rl2uX8Wg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59A9F864761;
        Wed,  1 Mar 2023 10:22:24 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-180.pek2.redhat.com [10.72.13.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44439492C18;
        Wed,  1 Mar 2023 10:22:20 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org, arnd@arndb.de,
        geert@linux-m68k.org, hch@infradead.org, mcgrof@kernel.org,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 2/2] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Wed,  1 Mar 2023 18:22:08 +0800
Message-Id: <20230301102208.148490-3-bhe@redhat.com>
In-Reply-To: <20230301102208.148490-1-bhe@redhat.com>
References: <20230301102208.148490-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior, everywhere else this is the same as ioremap() anyway.

Here, remove the ioremap_uc() definition in architecutures other
than x86 and ia64. These architectures all have asm-generic/io.h
included and will have the default ioremap_uc() definition which
returns NULL.

Note: This changes the existing behaviour and could break code
calling ioremap_uc(). If any ARCH meets this breakage and really
needs a specific ioremap_uc() for its own usage, one ioremap_uc()
can be added in the ARCH.

Link: https://lore.kernel.org/all/20191112105507.GA7122@lst.de/#t
Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 Documentation/driver-api/device-io.rst | 11 +++++++++--
 arch/alpha/include/asm/io.h            |  1 -
 arch/hexagon/include/asm/io.h          |  3 ---
 arch/m68k/include/asm/kmap.h           |  1 -
 arch/mips/include/asm/io.h             |  1 -
 arch/parisc/include/asm/io.h           |  2 --
 arch/powerpc/include/asm/io.h          |  1 -
 arch/sh/include/asm/io.h               |  2 --
 arch/sparc/include/asm/io_64.h         |  1 -
 9 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 4d2baac0311c..ec37faa37a37 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -408,9 +408,16 @@ functions for details on the CPU side of things.
 ioremap_uc()
 ------------
 
-ioremap_uc() behaves like ioremap() except that on the x86 architecture without
+ioremap_uc() behaves like ioremap() except that on x86 architecture without
 'PAT' mode, it marks memory as uncached even when the MTRR has designated
-it as cacheable, see Documentation/x86/pat.rst.
+it as cacheable, see Documentation/x86/pat.rst, and on ia64 which checks if
+attributes don't match.
+
+
+ioremap_uc() behaves like ioremap() except that on x86 and ia64 architectures.
+X86 non-PAT system marks memory as uncached even when the MTRR has designated
+it as cacheable in ioremap_uc()(see Documentation/x86/pat.rst). While ia64
+system firstly checks if attributes match ioremap_uc(), otherwise fails.
 
 Portable drivers should avoid the use of ioremap_uc().
 
diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 7aeaf7c30a6f..076f0e4e7f1e 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -308,7 +308,6 @@ static inline void __iomem *ioremap(unsigned long port, unsigned long size)
 }
 
 #define ioremap_wc ioremap
-#define ioremap_uc ioremap
 
 static inline void iounmap(volatile void __iomem *addr)
 {
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index dcd9cbbf5934..b9847472f25c 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -176,9 +176,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
 #define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
 		       (__HEXAGON_C_DEV << 6))
 
-#define ioremap_uc(addr, size) ioremap((addr), (size))
-
-
 #define __raw_writel writel
 
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 4efb3efa593a..b778f015c917 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -25,7 +25,6 @@ static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
 	return __ioremap(physaddr, size, IOMAP_NOCACHE_SER);
 }
 
-#define ioremap_uc ioremap
 #define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 3737b48f37dd..9d93e27f7c82 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -167,7 +167,6 @@ void iounmap(const volatile void __iomem *addr);
  */
 #define ioremap(offset, size)						\
 	ioremap_prot((offset), (size), _CACHE_UNCACHED)
-#define ioremap_uc		ioremap
 
 /*
  * ioremap_cache -	map bus memory into CPU space
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 366537042465..48630c78714a 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -132,8 +132,6 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 
 #define ioremap_wc(addr, size)  \
 	ioremap_prot((addr), (size), _PAGE_IOREMAP)
-#define ioremap_uc(addr, size)  \
-	ioremap_prot((addr), (size), _PAGE_IOREMAP)
 
 #define pci_iounmap			pci_iounmap
 
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 978d687edf32..7873fc83c82c 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -863,7 +863,6 @@ void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
 #endif
 
 void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
-#define ioremap_uc(addr, size)		ioremap((addr), (size))
 #define ioremap_cache(addr, size) \
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index b3a26b405c8d..12a892804082 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -278,8 +278,6 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 #endif /* CONFIG_MMU */
 
-#define ioremap_uc	ioremap
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9303270b22f3..d8ee1442f303 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -423,7 +423,6 @@ static inline void __iomem *ioremap(unsigned long offset, unsigned long size)
 	return (void __iomem *)offset;
 }
 
-#define ioremap_uc(X,Y)			ioremap((X),(Y))
 #define ioremap_wc(X,Y)			ioremap((X),(Y))
 #define ioremap_wt(X,Y)			ioremap((X),(Y))
 static inline void __iomem *ioremap_np(unsigned long offset, unsigned long size)
-- 
2.34.1

