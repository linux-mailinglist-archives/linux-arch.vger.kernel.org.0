Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D524E2E9EA8
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbhADUMM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:12:12 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:14191 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728045AbhADUMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:12:12 -0500
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 0044F240005;
        Mon,  4 Jan 2021 20:11:27 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 12/12] riscv: Improve virtual kernel memory layout dump
Date:   Mon,  4 Jan 2021 14:58:40 -0500
Message-Id: <20210104195840.1593-13-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the arrival of sv48 and its large address space, it would be
cumbersome to statically define the unit size to use to print the different
portions of the virtual memory layout: instead, determine it dynamically.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c  | 46 ++++++++++++++++++++++++++++++++++++-------
 include/linux/sizes.h |  3 ++-
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f9a99cb1870b..f06c21985274 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -80,30 +80,62 @@ static void setup_zero_page(void)
 }
 
 #if defined(CONFIG_MMU) && defined(CONFIG_DEBUG_VM)
+
+#define LOG2_SZ_1K  ilog2(SZ_1K)
+#define LOG2_SZ_1M  ilog2(SZ_1M)
+#define LOG2_SZ_1G  ilog2(SZ_1G)
+#define LOG2_SZ_1T  ilog2(SZ_1T)
+
 static inline void print_mlk(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld kB)\n", name, b, t,
-		  (((t) - (b)) >> 10));
+		  (((t) - (b)) >> LOG2_SZ_1K));
 }
 
 static inline void print_mlm(char *name, unsigned long b, unsigned long t)
 {
 	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld MB)\n", name, b, t,
-		  (((t) - (b)) >> 20));
+		  (((t) - (b)) >> LOG2_SZ_1M));
+}
+
+static inline void print_mlg(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld GB)\n", name, b, t,
+		  (((t) - (b)) >> LOG2_SZ_1G));
+}
+
+static inline void print_mlt(char *name, unsigned long b, unsigned long t)
+{
+	pr_notice("%12s : 0x%08lx - 0x%08lx   (%4ld TB)\n", name, b, t,
+		  (((t) - (b)) >> LOG2_SZ_1T));
+}
+
+static inline void print_ml(char *name, unsigned long b, unsigned long t)
+{
+    unsigned long diff = t - b;
+
+    if ((diff >> LOG2_SZ_1T) >= 10)
+        print_mlt(name, b, t);
+    else if ((diff >> LOG2_SZ_1G) >= 10)
+        print_mlg(name, b, t);
+    else if ((diff >> LOG2_SZ_1M) >= 10)
+        print_mlm(name, b, t);
+    else
+        print_mlk(name, b, t);
 }
 
 static void print_vm_layout(void)
 {
 	pr_notice("Virtual kernel memory layout:\n");
-	print_mlk("fixmap", (unsigned long)FIXADDR_START,
+	print_ml("fixmap", (unsigned long)FIXADDR_START,
 		  (unsigned long)FIXADDR_TOP);
-	print_mlm("pci io", (unsigned long)PCI_IO_START,
+	print_ml("pci io", (unsigned long)PCI_IO_START,
 		  (unsigned long)PCI_IO_END);
-	print_mlm("vmemmap", (unsigned long)VMEMMAP_START,
+	print_ml("vmemmap", (unsigned long)VMEMMAP_START,
 		  (unsigned long)VMEMMAP_END);
-	print_mlm("vmalloc", (unsigned long)VMALLOC_START,
+	print_ml("vmalloc", (unsigned long)VMALLOC_START,
 		  (unsigned long)VMALLOC_END);
-	print_mlm("lowmem", (unsigned long)PAGE_OFFSET,
+	print_ml("lowmem", (unsigned long)PAGE_OFFSET,
 		  (unsigned long)high_memory);
 }
 #else
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index 9874f6f67537..9528b082873b 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -42,8 +42,9 @@
 
 #define SZ_1G				0x40000000
 #define SZ_2G				0x80000000
-
 #define SZ_4G				_AC(0x100000000, ULL)
+
+#define SZ_1T				_AC(0x10000000000, ULL)
 #define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.20.1

