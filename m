Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E26E39B300
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 08:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhFDGvm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 02:51:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhFDGvl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 02:51:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B03661419;
        Fri,  4 Jun 2021 06:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622789395;
        bh=/KPaiU0WXRDWo9TYohvswiPXlMHm9E3WkunzLCb5070=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fftb75Zp7FNIK+q5nT0E5iPcO2BwmQGPdpY4XqJ9OLXOOVnf39t8lcOl7T9nyILZK
         lARKBXiNlnofAXroFgbU2jNDBiZGigzglgIzG5zW6jjPwpGI0Ozw1sutUf3itqpjI6
         sPyed3IK1Lh2p2BZAGjYy7P57a2rJx2m83rNArxF5a0vRCWZFImkc4twCGYLnVCm8d
         WN9NMFtK67UWdBRzAIf8yUgB6CEEGI22FzznRMEI6ypUB3FpvtBUtlPZN12hMbxcM2
         v6q4zqbesnn/BcVqL+d20TUnkxYjw7vRQNUIZvkzLObbH3plcLNHoZPZOQY679b+rO
         O456dQ1lbI9Lg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org
Subject: [PATCH v2 4/9] m68k: remove support for DISCONTIGMEM
Date:   Fri,  4 Jun 2021 09:49:11 +0300
Message-Id: <20210604064916.26580-5-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210604064916.26580-1-rppt@kernel.org>
References: <20210604064916.26580-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

DISCONTIGMEM was replaced by FLATMEM with freeing of the unused memory map
in v5.11.

Remove the support for DISCONTIGMEM entirely.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/Kconfig.cpu           | 10 ----------
 arch/m68k/include/asm/mmzone.h  | 10 ----------
 arch/m68k/include/asm/page.h    |  2 +-
 arch/m68k/include/asm/page_mm.h | 35 ---------------------------------
 arch/m68k/mm/init.c             | 20 -------------------
 5 files changed, 1 insertion(+), 76 deletions(-)
 delete mode 100644 arch/m68k/include/asm/mmzone.h

diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index f4d23977d2a5..29e946394fdb 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -408,10 +408,6 @@ config SINGLE_MEMORY_CHUNK
 	  order" to save memory that could be wasted for unused memory map.
 	  Say N if not sure.
 
-config ARCH_DISCONTIGMEM_ENABLE
-	depends on BROKEN
-	def_bool MMU && !SINGLE_MEMORY_CHUNK
-
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ADVANCED
 	depends on !SINGLE_MEMORY_CHUNK
@@ -451,11 +447,6 @@ config M68K_L2_CACHE
 	depends on MAC
 	default y
 
-config NODES_SHIFT
-	int
-	default "3"
-	depends on DISCONTIGMEM
-
 config CPU_HAS_NO_BITFIELDS
 	bool
 
@@ -553,4 +544,3 @@ config CACHE_COPYBACK
 	  The ColdFire CPU cache is set into Copy-back mode.
 endchoice
 endif
-
diff --git a/arch/m68k/include/asm/mmzone.h b/arch/m68k/include/asm/mmzone.h
deleted file mode 100644
index 64573fe8e60d..000000000000
--- a/arch/m68k/include/asm/mmzone.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_M68K_MMZONE_H_
-#define _ASM_M68K_MMZONE_H_
-
-extern pg_data_t pg_data_map[];
-
-#define NODE_DATA(nid)		(&pg_data_map[nid])
-#define NODE_MEM_MAP(nid)	(NODE_DATA(nid)->node_mem_map)
-
-#endif /* _ASM_M68K_MMZONE_H_ */
diff --git a/arch/m68k/include/asm/page.h b/arch/m68k/include/asm/page.h
index 97087dd3ca6d..2f1c54e4725d 100644
--- a/arch/m68k/include/asm/page.h
+++ b/arch/m68k/include/asm/page.h
@@ -62,7 +62,7 @@ extern unsigned long _ramend;
 #include <asm/page_no.h>
 #endif
 
-#if !defined(CONFIG_MMU) || defined(CONFIG_DISCONTIGMEM)
+#ifndef CONFIG_MMU
 #define __phys_to_pfn(paddr)	((unsigned long)((paddr) >> PAGE_SHIFT))
 #define __pfn_to_phys(pfn)	PFN_PHYS(pfn)
 #endif
diff --git a/arch/m68k/include/asm/page_mm.h b/arch/m68k/include/asm/page_mm.h
index 2411ea9ef578..a5b459bcb7d8 100644
--- a/arch/m68k/include/asm/page_mm.h
+++ b/arch/m68k/include/asm/page_mm.h
@@ -126,26 +126,6 @@ static inline void *__va(unsigned long x)
 
 extern int m68k_virt_to_node_shift;
 
-#ifndef CONFIG_DISCONTIGMEM
-#define __virt_to_node(addr)	(&pg_data_map[0])
-#else
-extern struct pglist_data *pg_data_table[];
-
-static inline __attribute_const__ int __virt_to_node_shift(void)
-{
-	int shift;
-
-	asm (
-		"1:	moveq	#0,%0\n"
-		m68k_fixup(%c1, 1b)
-		: "=d" (shift)
-		: "i" (m68k_fixup_vnode_shift));
-	return shift;
-}
-
-#define __virt_to_node(addr)	(pg_data_table[(unsigned long)(addr) >> __virt_to_node_shift()])
-#endif
-
 #define virt_to_page(addr) ({						\
 	pfn_to_page(virt_to_pfn(addr));					\
 })
@@ -153,23 +133,8 @@ static inline __attribute_const__ int __virt_to_node_shift(void)
 	pfn_to_virt(page_to_pfn(page));					\
 })
 
-#ifdef CONFIG_DISCONTIGMEM
-#define pfn_to_page(pfn) ({						\
-	unsigned long __pfn = (pfn);					\
-	struct pglist_data *pgdat;					\
-	pgdat = __virt_to_node((unsigned long)pfn_to_virt(__pfn));	\
-	pgdat->node_mem_map + (__pfn - pgdat->node_start_pfn);		\
-})
-#define page_to_pfn(_page) ({						\
-	const struct page *__p = (_page);				\
-	struct pglist_data *pgdat;					\
-	pgdat = &pg_data_map[page_to_nid(__p)];				\
-	((__p) - pgdat->node_mem_map) + pgdat->node_start_pfn;		\
-})
-#else
 #define ARCH_PFN_OFFSET (m68k_memory[0].addr >> PAGE_SHIFT)
 #include <asm-generic/memory_model.h>
-#endif
 
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 #define pfn_valid(pfn)		virt_addr_valid(pfn_to_virt(pfn))
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 1759ab875d47..5d749e188246 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -44,28 +44,8 @@ EXPORT_SYMBOL(empty_zero_page);
 
 int m68k_virt_to_node_shift;
 
-#ifdef CONFIG_DISCONTIGMEM
-pg_data_t pg_data_map[MAX_NUMNODES];
-EXPORT_SYMBOL(pg_data_map);
-
-pg_data_t *pg_data_table[65];
-EXPORT_SYMBOL(pg_data_table);
-#endif
-
 void __init m68k_setup_node(int node)
 {
-#ifdef CONFIG_DISCONTIGMEM
-	struct m68k_mem_info *info = m68k_memory + node;
-	int i, end;
-
-	i = (unsigned long)phys_to_virt(info->addr) >> __virt_to_node_shift();
-	end = (unsigned long)phys_to_virt(info->addr + info->size - 1) >> __virt_to_node_shift();
-	for (; i <= end; i++) {
-		if (pg_data_table[i])
-			pr_warn("overlap at %u for chunk %u\n", i, node);
-		pg_data_table[i] = pg_data_map + node;
-	}
-#endif
 	node_set_online(node);
 }
 
-- 
2.28.0

