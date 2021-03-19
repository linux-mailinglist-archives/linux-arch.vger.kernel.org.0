Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710F7341FA7
	for <lists+linux-arch@lfdr.de>; Fri, 19 Mar 2021 15:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhCSOga (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Mar 2021 10:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29982 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230232AbhCSOgQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Mar 2021 10:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616164576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FXYl9hPij054vFEEXKLgQXfdpg6LLSdzf8h+kRhT++U=;
        b=dgrfN5PbCzIUDRfvqGyCzPIpwgtTWyxTQ5oQ4wmk+ZygfVBIAV5OEQPhYo+obt8ragxved
        f5AwGUHP/+PT0uAFSYZMB/l1eIUbZcGzZIAvcC+nzFrrLWxjQ8cLE0/x6UugQCfMKZnYWC
        ZieuyE4+HjMG/2+AL1BycQBWXI9IP98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-5pJmeDzBN1Gy0hLj-NyWUw-1; Fri, 19 Mar 2021 10:36:12 -0400
X-MC-Unique: 5pJmeDzBN1Gy0hLj-NyWUw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0C0A84BA42;
        Fri, 19 Mar 2021 14:36:06 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-11.ams2.redhat.com [10.36.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B096F610F5;
        Fri, 19 Mar 2021 14:35:46 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greentime Hu <green.hu@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH RFC 2/3] mm: remove xlate_dev_kmem_ptr()
Date:   Fri, 19 Mar 2021 15:34:51 +0100
Message-Id: <20210319143452.25948-3-david@redhat.com>
In-Reply-To: <20210319143452.25948-1-david@redhat.com>
References: <20210319143452.25948-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since /dev/kmem has been removed, let's remove the xlate_dev_kmem_ptr()
leftovers.

Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brian Cain <bcain@codeaurora.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-alpha@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-hexagon@vger.kernel.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org
Cc: linux-mips@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/alpha/include/asm/io.h     |  5 -----
 arch/arm/include/asm/io.h       |  5 -----
 arch/hexagon/include/asm/io.h   |  1 -
 arch/ia64/include/asm/io.h      |  1 -
 arch/ia64/include/asm/uaccess.h | 18 ------------------
 arch/m68k/include/asm/io_mm.h   |  5 -----
 arch/mips/include/asm/io.h      |  5 -----
 arch/parisc/include/asm/io.h    |  5 -----
 arch/powerpc/include/asm/io.h   |  5 -----
 arch/s390/include/asm/io.h      |  5 -----
 arch/sh/include/asm/io.h        |  5 -----
 arch/sparc/include/asm/io_64.h  |  5 -----
 include/asm-generic/io.h        | 11 -----------
 13 files changed, 76 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 1f6a909d1fa5..0fab5ac90775 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -602,11 +602,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #endif /* __KERNEL__ */
 
 #endif /* __ALPHA_IO_H */
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index fc748122f1e0..f74944c6fe8d 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -430,11 +430,6 @@ extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index bda2a9c2df78..c33241425a5c 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -64,7 +64,6 @@ static inline void *phys_to_virt(unsigned long address)
  * convert a physical pointer to a virtual kernel pointer for
  * /dev/mem access.
  */
-#define xlate_dev_kmem_ptr(p)    __va(p)
 #define xlate_dev_mem_ptr(p)    __va(p)
 
 /*
diff --git a/arch/ia64/include/asm/io.h b/arch/ia64/include/asm/io.h
index 3d666a11a2de..6d93b923b379 100644
--- a/arch/ia64/include/asm/io.h
+++ b/arch/ia64/include/asm/io.h
@@ -277,7 +277,6 @@ extern void memset_io(volatile void __iomem *s, int c, long n);
 #define memcpy_fromio memcpy_fromio
 #define memcpy_toio memcpy_toio
 #define memset_io memset_io
-#define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
 #include <asm-generic/io.h>
 #undef PCI_IOBASE
diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
index 179243c3dfc7..e19d2dcc0ced 100644
--- a/arch/ia64/include/asm/uaccess.h
+++ b/arch/ia64/include/asm/uaccess.h
@@ -272,22 +272,4 @@ xlate_dev_mem_ptr(phys_addr_t p)
 	return ptr;
 }
 
-/*
- * Convert a virtual cached kernel memory pointer to an uncached pointer
- */
-static __inline__ void *
-xlate_dev_kmem_ptr(void *p)
-{
-	struct page *page;
-	void *ptr;
-
-	page = virt_to_page((unsigned long)p);
-	if (PageUncached(page))
-		ptr = (void *)__pa(p) + __IA64_UNCACHED_OFFSET;
-	else
-		ptr = p;
-
-	return ptr;
-}
-
 #endif /* _ASM_IA64_UACCESS_H */
diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 819f611dccf2..d41fa488453b 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -397,11 +397,6 @@ static inline void isa_delay(void)
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #define readb_relaxed(addr)	readb(addr)
 #define readw_relaxed(addr)	readw(addr)
 #define readl_relaxed(addr)	readl(addr)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 78537aa23500..e6373e7ac892 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -552,11 +552,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
 #endif /* _ASM_IO_H */
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 8a11b8cf4719..0b5259102319 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -316,11 +316,6 @@ extern void iowrite64be(u64 val, void __iomem *addr);
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 extern int devmem_is_allowed(unsigned long pfn);
 
 #endif
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 273edd208ec5..f130783c8301 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -662,11 +662,6 @@ static inline void name at					\
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 /*
  * We don't do relaxed operations yet, at least not with this semantic
  */
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index 28664ee0abc1..e3882b012bfa 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -20,11 +20,6 @@ void *xlate_dev_mem_ptr(phys_addr_t phys);
 #define unxlate_dev_mem_ptr unxlate_dev_mem_ptr
 void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #define IO_SPACE_LIMIT 0
 
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 6d5c6463bc07..cf9a3ec32406 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -283,11 +283,6 @@ static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9bb27e5c22f1..ff6fe387d78c 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -450,11 +450,6 @@ void sbus_set_sbus64(struct device *, int);
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#define xlate_dev_kmem_ptr(p)	p
-
 #endif
 
 #endif /* !(__SPARC64_IO_H) */
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index c6af40ce03be..33d4746b086f 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -1045,17 +1045,6 @@ static inline void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 #endif
 #endif /* CONFIG_GENERIC_IOMAP */
 
-/*
- * Convert a virtual cached pointer to an uncached pointer
- */
-#ifndef xlate_dev_kmem_ptr
-#define xlate_dev_kmem_ptr xlate_dev_kmem_ptr
-static inline void *xlate_dev_kmem_ptr(void *addr)
-{
-	return addr;
-}
-#endif
-
 #ifndef xlate_dev_mem_ptr
 #define xlate_dev_mem_ptr xlate_dev_mem_ptr
 static inline void *xlate_dev_mem_ptr(phys_addr_t addr)
-- 
2.29.2

