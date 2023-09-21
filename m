Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEE67A9E5B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Sep 2023 22:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjIUUAn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Sep 2023 16:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbjIUUAQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Sep 2023 16:00:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30454212F
        for <linux-arch@vger.kernel.org>; Thu, 21 Sep 2023 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695317214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tn5ZDFUI6iPOIWmja0Ms5+F66UgwvJBJvQvpQLjnla0=;
        b=c5zbx6JlMnpQIVFjw3Aqc7K1cYyI7ULJf2/iHeZEHCwrHmIgIbnBHFpXPJw2aq1H9wXI2S
        bFX6kJk0AKfNJW2opGepsiuYSgji3NDJCe6Nlv/RYdTHJaKGveMPYs6uyTmcbLAssyBIpJ
        Dia2PLXsWcjFeoa8jRxD4EmmpmElQIw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-HzV00hqNNTmcFQhVDqz-Nw-1; Thu, 21 Sep 2023 07:04:57 -0400
X-MC-Unique: HzV00hqNNTmcFQhVDqz-Nw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 848AF8039CB;
        Thu, 21 Sep 2023 11:04:56 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.40])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9BA682156701;
        Thu, 21 Sep 2023 11:04:48 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, arnd@arndb.de, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, geert@linux-m68k.org, mcgrof@kernel.org,
        hch@infradead.org, tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        deller@gmx.de, Baoquan He <bhe@redhat.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH v5 3/4] arch/*/io.h: remove ioremap_uc in some architectures
Date:   Thu, 21 Sep 2023 19:04:23 +0800
Message-ID: <20230921110424.215592-4-bhe@redhat.com>
In-Reply-To: <20230921110424.215592-1-bhe@redhat.com>
References: <20230921110424.215592-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ioremap_uc() is only meaningful on old x86-32 systems with the PAT
extension, and on ia64 with its slightly unconventional ioremap()
behavior. So remove the ioremap_uc() definition in architecutures
other than x86 and ia64. These architectures all have asm-generic/io.h
included and will have the default ioremap_uc() definition which
returns NULL.

This changes the existing behaviour, while no need to worry about
any breakage because in the only callsite of ioremap_uc(), code
has been adjusted to eliminate the impact. Please see
atyfb_setup_generic() of drivers/video/fbdev/aty/atyfb_base.c.

If any new invocation of ioremap_uc() need be added, please consider
using ioremap() intead or adding a ARCH specific version if necessary.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Acked-by: Helge Deller <deller@gmx.de>  # parisc
Cc: linux-alpha@vger.kernel.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 Documentation/driver-api/device-io.rst | 9 +++++----
 arch/alpha/include/asm/io.h            | 1 -
 arch/hexagon/include/asm/io.h          | 3 ---
 arch/m68k/include/asm/kmap.h           | 1 -
 arch/mips/include/asm/io.h             | 1 -
 arch/parisc/include/asm/io.h           | 2 --
 arch/powerpc/include/asm/io.h          | 1 -
 arch/sh/include/asm/io.h               | 2 --
 arch/sparc/include/asm/io_64.h         | 1 -
 9 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index 2c7abd234f4e..d55384b106bd 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -408,11 +408,12 @@ functions for details on the CPU side of things.
 ioremap_uc()
 ------------
 
-ioremap_uc() behaves like ioremap() except that on the x86 architecture without
-'PAT' mode, it marks memory as uncached even when the MTRR has designated
-it as cacheable, see Documentation/arch/x86/pat.rst.
+ioremap_uc() is only meaningful on old x86-32 systems with the PAT extension,
+and on ia64 with its slightly unconventional ioremap() behavior, everywhere
+elss ioremap_uc() defaults to return NULL.
 
-Portable drivers should avoid the use of ioremap_uc().
+
+Portable drivers should avoid the use of ioremap_uc(), use ioremap() instead.
 
 ioremap_cache()
 ---------------
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
index e2b308e32a37..b7bc246dbcb1 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -174,9 +174,6 @@ static inline void writel(u32 data, volatile void __iomem *addr)
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
index 41d8bd5adef8..1ecf255efb40 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -170,7 +170,6 @@ void iounmap(const volatile void __iomem *addr);
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
index 0732b743e099..21bd3e8bffce 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -900,7 +900,6 @@ void __iomem *ioremap_wt(phys_addr_t address, unsigned long size);
 #endif
 
 void __iomem *ioremap_coherent(phys_addr_t address, unsigned long size);
-#define ioremap_uc(addr, size)		ioremap((addr), (size))
 #define ioremap_cache(addr, size) \
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
 
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index f2f38e9d489a..790bea22c9b5 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -302,8 +302,6 @@ unsigned long long poke_real_address_q(unsigned long long addr,
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
2.41.0

