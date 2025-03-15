Return-Path: <linux-arch+bounces-10884-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC00A62B6A
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9159517A8C7
	for <lists+linux-arch@lfdr.de>; Sat, 15 Mar 2025 10:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A411F8BAC;
	Sat, 15 Mar 2025 10:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLAs0s17"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9A01DFED;
	Sat, 15 Mar 2025 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742036368; cv=none; b=YwYEIIoddCBPQ6YrKEP9XjjK6aIRK4DN6Q658hEk/WjSE0VkmxSl0GRDsuI8WmysdtQpHkinQSkilqcY7WmUKfZsHp3vnev5DN6JJd+JzZUp/RFbzvmyA5A/O/wD3yPZjJ/OXQX7tKRNea2i94qK9uAkZE4qyLDKcXgdk1U1mXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742036368; c=relaxed/simple;
	bh=ifm6+RNn7W+4D9iZBd9DXE2mvpD9E69YYaSTABFkwMw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CcEha8iHfpbWQkJ8pF2SJvss5ZAisDk0ELUHMLofmpevged8Y5K4HEulrtrTRGYkoBrqviWgw5KCSzjBsozZSG02UBvtYjCL7A4vtTJy4YhcotElaWGa/2lhoj6sOXLVxy77X9MUDe139VGeQWBvz/pY8wT+90SKGe8/0pAw7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLAs0s17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33C2C4CEE9;
	Sat, 15 Mar 2025 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742036367;
	bh=ifm6+RNn7W+4D9iZBd9DXE2mvpD9E69YYaSTABFkwMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLAs0s17y4TlJdo1dj8CRoFIbCgt8ordw0TgHG/VvNSocGisqa7LAU6K10B8AsI0w
	 Khn8ABI6KU0a3m/BkEFcO70ou6Wu8vLHIqLUM/JXV4Jiysyx7inju1ovYrHO3iEK9S
	 h5zu1Yq5AwePf0Q6hPWy2A3LL1W5eUQkbL/JwOr7EMZK+awdBBGl9dAzwnw3HXGdRt
	 jTqkAid0yIIKlIDO0h84d6Gp6ZTcNaK1r1UuSbDwIuNXuHgaKGAkCskivbXA/8PLOX
	 tPKrdogC4rwrmwkYvsKL5vu6hQzN2cTCwnZuaVxdH95yrNAmKJbgxprIbfxpaCrR3p
	 mT76EiNpgsZtg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Julian Vetter <julian@outer-limits.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org
Subject: [PATCH 2/6] sh: remove duplicate ioread/iowrite helpers
Date: Sat, 15 Mar 2025 11:59:03 +0100
Message-Id: <20250315105907.1275012-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250315105907.1275012-1-arnd@kernel.org>
References: <20250315105907.1275012-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The ioread/iowrite functions on sh only do memory mapped I/O like the
generic verion, and never map onto non-MMIO inb/outb variants, so they
just add complexity. In particular, the use of asm-generic/iomap.h
ties the declaration to the x86 implementation.

Remove the custom versions and use the architecture-independent fallback
code instead. Some of the calling conventions on sh are different here,
so fix that by adding 'volatile' keywords where required by the generic
implementation and change the cpg clock driver to no longer depend on
the interesting choice of return types for ioread8/ioread16/ioread32.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sh/include/asm/io.h |  30 ++------
 arch/sh/kernel/Makefile  |   3 -
 arch/sh/kernel/iomap.c   | 162 ---------------------------------------
 arch/sh/kernel/ioport.c  |   5 --
 arch/sh/lib/io.c         |   4 +-
 drivers/sh/clk/cpg.c     |  25 +++---
 6 files changed, 21 insertions(+), 208 deletions(-)
 delete mode 100644 arch/sh/kernel/iomap.c

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index cf5eab840d57..0f663ebec700 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -19,7 +19,6 @@
 #include <asm/machvec.h>
 #include <asm/page.h>
 #include <linux/pgtable.h>
-#include <asm-generic/iomap.h>
 
 #define __IO_PREFIX     generic
 #include <asm/io_generic.h>
@@ -100,7 +99,7 @@ pfx##writes##bwlq(volatile void __iomem *mem, const void *addr,		\
 	}								\
 }									\
 									\
-static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
+static inline void pfx##reads##bwlq(const volatile void __iomem *mem,	\
 				    void *addr, unsigned int count)	\
 {									\
 	volatile type *__addr = addr;					\
@@ -114,37 +113,18 @@ static inline void pfx##reads##bwlq(volatile void __iomem *mem,		\
 __BUILD_MEMORY_STRING(__raw_, b, u8)
 __BUILD_MEMORY_STRING(__raw_, w, u16)
 
-void __raw_writesl(void __iomem *addr, const void *data, int longlen);
-void __raw_readsl(const void __iomem *addr, void *data, int longlen);
+void __raw_writesl(void volatile __iomem *addr, const void *data, int longlen);
+void __raw_readsl(const volatile void __iomem *addr, void *data, int longlen);
 
 __BUILD_MEMORY_STRING(__raw_, q, u64)
 
 #define ioport_map ioport_map
-#define ioport_unmap ioport_unmap
 #define pci_iounmap pci_iounmap
 
-#define ioread8 ioread8
-#define ioread16 ioread16
-#define ioread16be ioread16be
-#define ioread32 ioread32
-#define ioread32be ioread32be
-
-#define iowrite8 iowrite8
-#define iowrite16 iowrite16
-#define iowrite16be iowrite16be
-#define iowrite32 iowrite32
-#define iowrite32be iowrite32be
-
-#define ioread8_rep ioread8_rep
-#define ioread16_rep ioread16_rep
-#define ioread32_rep ioread32_rep
-
-#define iowrite8_rep iowrite8_rep
-#define iowrite16_rep iowrite16_rep
-#define iowrite32_rep iowrite32_rep
-
 #ifdef CONFIG_HAS_IOPORT_MAP
 
+extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
+
 /*
  * Slowdown I/O port space accesses for antique hardware.
  */
diff --git a/arch/sh/kernel/Makefile b/arch/sh/kernel/Makefile
index ba917008d63e..7b453592adaf 100644
--- a/arch/sh/kernel/Makefile
+++ b/arch/sh/kernel/Makefile
@@ -21,10 +21,7 @@ obj-y	:= head_32.o debugtraps.o dumpstack.o				\
 	   syscalls_32.o time.o topology.o traps.o			\
 	   traps_32.o unwinder.o
 
-ifndef CONFIG_GENERIC_IOMAP
-obj-y				+= iomap.o
 obj-$(CONFIG_HAS_IOPORT_MAP)	+= ioport.o
-endif
 
 obj-y				+= sys_sh32.o
 obj-y				+= cpu/
diff --git a/arch/sh/kernel/iomap.c b/arch/sh/kernel/iomap.c
deleted file mode 100644
index 0a0dff4e66de..000000000000
--- a/arch/sh/kernel/iomap.c
+++ /dev/null
@@ -1,162 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * arch/sh/kernel/iomap.c
- *
- * Copyright (C) 2000  Niibe Yutaka
- * Copyright (C) 2005 - 2007 Paul Mundt
- */
-#include <linux/module.h>
-#include <linux/io.h>
-
-unsigned int ioread8(const void __iomem *addr)
-{
-	return readb(addr);
-}
-EXPORT_SYMBOL(ioread8);
-
-unsigned int ioread16(const void __iomem *addr)
-{
-	return readw(addr);
-}
-EXPORT_SYMBOL(ioread16);
-
-unsigned int ioread16be(const void __iomem *addr)
-{
-	return be16_to_cpu(__raw_readw(addr));
-}
-EXPORT_SYMBOL(ioread16be);
-
-unsigned int ioread32(const void __iomem *addr)
-{
-	return readl(addr);
-}
-EXPORT_SYMBOL(ioread32);
-
-unsigned int ioread32be(const void __iomem *addr)
-{
-	return be32_to_cpu(__raw_readl(addr));
-}
-EXPORT_SYMBOL(ioread32be);
-
-void iowrite8(u8 val, void __iomem *addr)
-{
-	writeb(val, addr);
-}
-EXPORT_SYMBOL(iowrite8);
-
-void iowrite16(u16 val, void __iomem *addr)
-{
-	writew(val, addr);
-}
-EXPORT_SYMBOL(iowrite16);
-
-void iowrite16be(u16 val, void __iomem *addr)
-{
-	__raw_writew(cpu_to_be16(val), addr);
-}
-EXPORT_SYMBOL(iowrite16be);
-
-void iowrite32(u32 val, void __iomem *addr)
-{
-	writel(val, addr);
-}
-EXPORT_SYMBOL(iowrite32);
-
-void iowrite32be(u32 val, void __iomem *addr)
-{
-	__raw_writel(cpu_to_be32(val), addr);
-}
-EXPORT_SYMBOL(iowrite32be);
-
-/*
- * These are the "repeat MMIO read/write" functions.
- * Note the "__raw" accesses, since we don't want to
- * convert to CPU byte order. We write in "IO byte
- * order" (we also don't have IO barriers).
- */
-static inline void mmio_insb(const void __iomem *addr, u8 *dst, int count)
-{
-	while (--count >= 0) {
-		u8 data = __raw_readb(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_insw(const void __iomem *addr, u16 *dst, int count)
-{
-	while (--count >= 0) {
-		u16 data = __raw_readw(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_insl(const void __iomem *addr, u32 *dst, int count)
-{
-	while (--count >= 0) {
-		u32 data = __raw_readl(addr);
-		*dst = data;
-		dst++;
-	}
-}
-
-static inline void mmio_outsb(void __iomem *addr, const u8 *src, int count)
-{
-	while (--count >= 0) {
-		__raw_writeb(*src, addr);
-		src++;
-	}
-}
-
-static inline void mmio_outsw(void __iomem *addr, const u16 *src, int count)
-{
-	while (--count >= 0) {
-		__raw_writew(*src, addr);
-		src++;
-	}
-}
-
-static inline void mmio_outsl(void __iomem *addr, const u32 *src, int count)
-{
-	while (--count >= 0) {
-		__raw_writel(*src, addr);
-		src++;
-	}
-}
-
-void ioread8_rep(const void __iomem *addr, void *dst, unsigned long count)
-{
-	mmio_insb(addr, dst, count);
-}
-EXPORT_SYMBOL(ioread8_rep);
-
-void ioread16_rep(const void __iomem *addr, void *dst, unsigned long count)
-{
-	mmio_insw(addr, dst, count);
-}
-EXPORT_SYMBOL(ioread16_rep);
-
-void ioread32_rep(const void __iomem *addr, void *dst, unsigned long count)
-{
-	mmio_insl(addr, dst, count);
-}
-EXPORT_SYMBOL(ioread32_rep);
-
-void iowrite8_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	mmio_outsb(addr, src, count);
-}
-EXPORT_SYMBOL(iowrite8_rep);
-
-void iowrite16_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	mmio_outsw(addr, src, count);
-}
-EXPORT_SYMBOL(iowrite16_rep);
-
-void iowrite32_rep(void __iomem *addr, const void *src, unsigned long count)
-{
-	mmio_outsl(addr, src, count);
-}
-EXPORT_SYMBOL(iowrite32_rep);
diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
index c8aff8a20164..915a3dfd9f02 100644
--- a/arch/sh/kernel/ioport.c
+++ b/arch/sh/kernel/ioport.c
@@ -23,8 +23,3 @@ void __iomem *ioport_map(unsigned long port, unsigned int nr)
 	return (void __iomem *)(port + sh_io_port_base);
 }
 EXPORT_SYMBOL(ioport_map);
-
-void ioport_unmap(void __iomem *addr)
-{
-}
-EXPORT_SYMBOL(ioport_unmap);
diff --git a/arch/sh/lib/io.c b/arch/sh/lib/io.c
index ebcf7c0a7335..dc6345e4c53b 100644
--- a/arch/sh/lib/io.c
+++ b/arch/sh/lib/io.c
@@ -11,7 +11,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-void __raw_readsl(const void __iomem *addr, void *datap, int len)
+void __raw_readsl(const volatile void __iomem *addr, void *datap, int len)
 {
 	u32 *data;
 
@@ -60,7 +60,7 @@ void __raw_readsl(const void __iomem *addr, void *datap, int len)
 }
 EXPORT_SYMBOL(__raw_readsl);
 
-void __raw_writesl(void __iomem *addr, const void *data, int len)
+void __raw_writesl(volatile void __iomem *addr, const void *data, int len)
 {
 	if (likely(len != 0)) {
 		int tmp1;
diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
index fd72d9088bdc..64ed7d64458a 100644
--- a/drivers/sh/clk/cpg.c
+++ b/drivers/sh/clk/cpg.c
@@ -26,6 +26,19 @@ static unsigned int sh_clk_read(struct clk *clk)
 	return ioread32(clk->mapped_reg);
 }
 
+static unsigned int sh_clk_read_status(struct clk *clk)
+{
+	void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
+		(phys_addr_t)clk->enable_reg + clk->mapped_reg;
+
+	if (clk->flags & CLK_ENABLE_REG_8BIT)
+		return ioread8(mapped_status);
+	else if (clk->flags & CLK_ENABLE_REG_16BIT)
+		return ioread16(mapped_status);
+
+	return ioread32(mapped_status);
+}
+
 static void sh_clk_write(int value, struct clk *clk)
 {
 	if (clk->flags & CLK_ENABLE_REG_8BIT)
@@ -40,20 +53,10 @@ static int sh_clk_mstp_enable(struct clk *clk)
 {
 	sh_clk_write(sh_clk_read(clk) & ~(1 << clk->enable_bit), clk);
 	if (clk->status_reg) {
-		unsigned int (*read)(const void __iomem *addr);
 		int i;
-		void __iomem *mapped_status = (phys_addr_t)clk->status_reg -
-			(phys_addr_t)clk->enable_reg + clk->mapped_reg;
-
-		if (clk->flags & CLK_ENABLE_REG_8BIT)
-			read = ioread8;
-		else if (clk->flags & CLK_ENABLE_REG_16BIT)
-			read = ioread16;
-		else
-			read = ioread32;
 
 		for (i = 1000;
-		     (read(mapped_status) & (1 << clk->enable_bit)) && i;
+		     (sh_clk_read_status(clk) & (1 << clk->enable_bit)) && i;
 		     i--)
 			cpu_relax();
 		if (!i) {
-- 
2.39.5


