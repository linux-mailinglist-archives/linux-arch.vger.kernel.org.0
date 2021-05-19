Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19862388660
	for <lists+linux-arch@lfdr.de>; Wed, 19 May 2021 07:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbhESFG6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 May 2021 01:06:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244825AbhESFGw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 May 2021 01:06:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0E54613AE;
        Wed, 19 May 2021 05:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621400733;
        bh=sYN05bC53EDVyET7U5IMlzdjAkaiTBtrJ259CHygA2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvDTItlkZj5gI9AXS4AQXNPjQLrTpx/5B2e1rmH39FXvYEC3cMJFrlw+zJ0AaPMWD
         T6YWvUc8hG4FVJL8ZDwTN9Io+YQKOSrxlTlROygKIi3oF0XwzV/L4k0VQb2UNYSRlO
         0lX+aqj1IIoL95XmXz7mMsLBr0YBv+iOzKj3zM4nq06mIVU4sqNrSUvzpjJ8WRMme+
         f9pv6GgC2egWvVQbVfgbHF2uKNX88Yh1xsk55L55JvhN9MopdCkXLgnMZ6rbs35c4D
         wBPGC/enieQxXgHBFiJYPZBSbR+1y760gO6AekeHeiLfQtRvtHpODZ9rNBpdhAE2yL
         USUjp+Avm1iYw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        drew@beagleboard.org, hch@lst.de, wefu@redhat.com,
        lazyparser@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH RFC 2/3] riscv: Add DMA_COHERENT for custom PTE attributes
Date:   Wed, 19 May 2021 05:04:15 +0000
Message-Id: <1621400656-25678-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621400656-25678-1-git-send-email-guoren@kernel.org>
References: <1621400656-25678-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The RISC-V ISA doesn't yet specify how to query or modify PMAs, so
let vendors define the custom properties of memory regions in PTE.

That means address attributes would use PTE entry not PMA to meet
the different requirements of IO/mem.

The patch helps SOC vendors to support their own custom
interconnect coherent solution with PTE attributes.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Drew Fustini <drew@beagleboard.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Wei Fu <wefu@redhat.com>
Cc: Wei Wu <lazyparser@gmail.com>
---
 arch/riscv/Kconfig                    | 27 +++++++++++++++++++++++++++
 arch/riscv/include/asm/pgtable-bits.h | 13 ++++++++++++-
 arch/riscv/include/asm/pgtable.h      |  7 ++++---
 3 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a8ad8eb..632fac5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -376,6 +376,33 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_DMA_COHERENT
+	bool "Custom DMA coherent support"
+	depends on MMU
+	help
+	  Help SOC vendors to support their own custom interconnect coherent
+	  solution with PTE attributes.
+
+	  The RISC-V ISA doesn't yet specify how to query or modify PMAs, so let
+	  vendors define the custom properties of memory regions in PTE.
+
+	  If you don't know what to do here, say N.
+
+config RISCV_PAGE_DMA_MASK
+	hex "Custom DMA attributes' mask bits in pte"
+	depends on RISCV_DMA_COHERENT
+	default "0x0"
+
+config RISCV_PAGE_CACHE
+	hex "Custom CACHE attribute bits in pte"
+	depends on RISCV_DMA_COHERENT
+	default "0x0"
+
+config RISCV_PAGE_DMA_NONCACHE
+	hex "Custom NONCACHE attribute bits in pte"
+	depends on RISCV_DMA_COHERENT
+	default "0x0"
+
 endmenu
 
 menu "Kernel features"
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index bbaeb5d..071c5dc 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -24,6 +24,16 @@
 #define _PAGE_DIRTY     (1 << 7)    /* Set by hardware on any write */
 #define _PAGE_SOFT      (1 << 8)    /* Reserved for software */
 
+#ifdef CONFIG_RISCV_DMA_COHERENT
+#define _PAGE_DMA_MASK		CONFIG_RISCV_PAGE_DMA_MASK
+#define _PAGE_CACHE		CONFIG_RISCV_PAGE_CACHE
+#define _PAGE_DMA_NONCACHE	CONFIG_RISCV_PAGE_DMA_NONCACHE
+#else
+#define _PAGE_DMA_MASK		(0UL)
+#define _PAGE_CACHE		(0UL)
+#define _PAGE_DMA_NONCACHE	(0UL)
+#endif
+
 #define _PAGE_SPECIAL   _PAGE_SOFT
 #define _PAGE_TABLE     _PAGE_PRESENT
 
@@ -38,6 +48,7 @@
 /* Set of bits to preserve across pte_modify() */
 #define _PAGE_CHG_MASK  (~(unsigned long)(_PAGE_PRESENT | _PAGE_READ |	\
 					  _PAGE_WRITE | _PAGE_EXEC |	\
-					  _PAGE_USER | _PAGE_GLOBAL))
+					  _PAGE_USER | _PAGE_GLOBAL |	\
+					  _PAGE_DMA_MASK))
 
 #endif /* _ASM_RISCV_PGTABLE_BITS_H */
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 869d6bf..f822f22 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -114,7 +114,7 @@
 #define USER_PTRS_PER_PGD   (TASK_SIZE / PGDIR_SIZE)
 
 /* Page protection bits */
-#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER)
+#define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_USER | _PAGE_CACHE)
 
 #define PAGE_NONE		__pgprot(_PAGE_PROT_NONE)
 #define PAGE_READ		__pgprot(_PAGE_BASE | _PAGE_READ)
@@ -134,7 +134,8 @@
 				| _PAGE_WRITE \
 				| _PAGE_PRESENT \
 				| _PAGE_ACCESSED \
-				| _PAGE_DIRTY)
+				| _PAGE_DIRTY \
+				| _PAGE_CACHE)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
@@ -148,7 +149,7 @@
  * The RISC-V ISA doesn't yet specify how to query or modify PMAs, so we can't
  * change the properties of memory regions.
  */
-#define _PAGE_IOREMAP _PAGE_KERNEL
+#define _PAGE_IOREMAP ((_PAGE_KERNEL & ~_PAGE_DMA_MASK) | _PAGE_DMA_NONCACHE)
 
 extern pgd_t swapper_pg_dir[];
 
-- 
2.7.4

