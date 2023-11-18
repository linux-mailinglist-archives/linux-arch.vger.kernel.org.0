Return-Path: <linux-arch+bounces-243-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F356D7EFED6
	for <lists+linux-arch@lfdr.de>; Sat, 18 Nov 2023 11:09:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E10828100F
	for <lists+linux-arch@lfdr.de>; Sat, 18 Nov 2023 10:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1650510949;
	Sat, 18 Nov 2023 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B597D5B;
	Sat, 18 Nov 2023 02:08:56 -0800 (PST)
Received: from dggpemm100001.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SXTrY6JprzMmjJ;
	Sat, 18 Nov 2023 18:04:13 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 18:08:52 +0800
From: Kefeng Wang <wangkefeng.wang@huawei.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-arch@vger.kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-hexagon@vger.kernel.org>,
	<linux-m68k@lists.linux-m68k.org>, <linux-mips@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-sh@vger.kernel.org>, <sparclinux@vger.kernel.org>, Kefeng Wang
	<wangkefeng.wang@huawei.com>, Richard Henderson
	<richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Russell King <linux@armlinux.org.uk>, Brian Cain <bcain@quicinc.com>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
	"David S. Miller" <davem@davemloft.net>, Stanislav Kinsburskii
	<stanislav.kinsburskii@gmail.com>
Subject: [PATCH] asm/io: remove unnecessary xlate_dev_mem_ptr() and unxlate_dev_mem_ptr()
Date: Sat, 18 Nov 2023 18:08:27 +0800
Message-ID: <20231118100827.1599422-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100001.china.huawei.com (7.185.36.93)
X-CFilter-Loop: Reflected

The asm-generic/io.h already has default definition, remove unnecessary
arch's defination.

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brian Cain <bcain@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Stanislav Kinsburskii <stanislav.kinsburskii@gmail.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/alpha/include/asm/io.h    | 6 ------
 arch/arm/include/asm/io.h      | 6 ------
 arch/hexagon/include/asm/io.h  | 6 ------
 arch/m68k/include/asm/io_mm.h  | 6 ------
 arch/mips/include/asm/io.h     | 7 -------
 arch/parisc/include/asm/io.h   | 6 ------
 arch/powerpc/include/asm/io.h  | 6 ------
 arch/sh/include/asm/io.h       | 7 -------
 arch/sparc/include/asm/io_64.h | 6 ------
 9 files changed, 56 deletions(-)

diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
index 7aeaf7c30a6f..5e5d21ebc584 100644
--- a/arch/alpha/include/asm/io.h
+++ b/arch/alpha/include/asm/io.h
@@ -651,12 +651,6 @@ extern void outsl (unsigned long port, const void *src, unsigned long count);
 #endif
 #define RTC_ALWAYS_BCD	0
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
 /*
  * These get provided from <asm-generic/iomap.h> since alpha does not
  * select GENERIC_IOMAP.
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 56b08ed6cc3b..1815748f5d2a 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -407,12 +407,6 @@ struct pci_dev;
 #define pci_iounmap pci_iounmap
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *addr);
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
 #include <asm-generic/io.h>
 
 #ifdef CONFIG_MMU
diff --git a/arch/hexagon/include/asm/io.h b/arch/hexagon/include/asm/io.h
index e2b308e32a37..97d57751ce3b 100644
--- a/arch/hexagon/include/asm/io.h
+++ b/arch/hexagon/include/asm/io.h
@@ -58,12 +58,6 @@ static inline void *phys_to_virt(unsigned long address)
 	return __va(address);
 }
 
-/*
- * convert a physical pointer to a virtual kernel pointer for
- * /dev/mem access.
- */
-#define xlate_dev_mem_ptr(p)    __va(p)
-
 /*
  * IO port access primitives.  Hexagon doesn't have special IO access
  * instructions; all I/O is memory mapped.
diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index 47525f2a57e1..090aec54b8fa 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -389,12 +389,6 @@ static inline void isa_delay(void)
 
 #define __ARCH_HAS_NO_PAGE_ZERO_MAPPED		1
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
 #define readb_relaxed(addr)	readb(addr)
 #define readw_relaxed(addr)	readw(addr)
 #define readl_relaxed(addr)	readl(addr)
diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 062dd4e6b954..2158ff302430 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -548,13 +548,6 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define csr_out32(v, a) (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST) = (v))
 #define csr_in32(a)    (*(volatile u32 *)((unsigned long)(a) + __CSR_32_ADJUST))
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-#define unxlate_dev_mem_ptr(p, v) do { } while (0)
-
 void __ioread64_copy(void *to, const void __iomem *from, size_t count);
 
 #endif /* _ASM_IO_H */
diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 366537042465..9c06cafb0e70 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -267,12 +267,6 @@ extern void iowrite64be(u64 val, void __iomem *addr);
 #define iowrite16_rep iowrite16_rep
 #define iowrite32_rep iowrite32_rep
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
 extern int devmem_is_allowed(unsigned long pfn);
 
 #include <asm-generic/io.h>
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 5220274a6277..79421c285066 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -709,12 +709,6 @@ static inline void name at					\
 #define memcpy_fromio memcpy_fromio
 #define memcpy_toio memcpy_toio
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
 /*
  * We don't do relaxed operations yet, at least not with this semantic
  */
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index ac521f287fa5..be7ac06423a9 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -304,13 +304,6 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 
 #define ioremap_uc	ioremap
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-#define unxlate_dev_mem_ptr(p, v) do { } while (0)
-
 #include <asm-generic/io.h>
 
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
index 9303270b22f3..75ae9bf3bb7b 100644
--- a/arch/sparc/include/asm/io_64.h
+++ b/arch/sparc/include/asm/io_64.h
@@ -470,12 +470,6 @@ static inline int sbus_can_burst64(void)
 struct device;
 void sbus_set_sbus64(struct device *, int);
 
-/*
- * Convert a physical pointer to a virtual kernel pointer for /dev/mem
- * access
- */
-#define xlate_dev_mem_ptr(p)	__va(p)
-
 #endif
 
 #endif /* !(__SPARC64_IO_H) */
-- 
2.27.0


