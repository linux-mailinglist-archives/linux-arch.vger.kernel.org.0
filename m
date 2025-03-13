Return-Path: <linux-arch+bounces-10724-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846CA5F674
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 14:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48D517A84D
	for <lists+linux-arch@lfdr.de>; Thu, 13 Mar 2025 13:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB03267F48;
	Thu, 13 Mar 2025 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGAoZ9Bv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DDB267B9A;
	Thu, 13 Mar 2025 13:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741873850; cv=none; b=DdlhKrq88NV9l2RMVfpguZ1CDmHAb5Lslu75SNshxTl6o9R3E5CDLCGi4/f01P2KXdQwtofJTtfG4NFt5390pRGP/PxJ+HfY9bExUd8mPcXCHNJXpCmNf2AdJb7ZziLvJrNSPg8byvZgY5tXcs+N2VO+cX8lYVvPkD6bnBrMlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741873850; c=relaxed/simple;
	bh=XIr08FortiFXYgvy+0ilxZfO/dI5xt5VoYYHY8PPi6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LtL4Ui/pg7uteG0QmddETKGsKBJsc5ECy3UNdIIwXZ/nK1ka2hci8726KFYC1OxcSjQocsh7E9pXzmoVsJVN9vl12kRQEoTzSRPOFB2qaNcs7grNqxTv7wSy5UMiZDN7COqFqeg1uPCwr9MRrXFc7o08QciHSXwHTjXiwDVHLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGAoZ9Bv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF707C4AF0C;
	Thu, 13 Mar 2025 13:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741873849;
	bh=XIr08FortiFXYgvy+0ilxZfO/dI5xt5VoYYHY8PPi6U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGAoZ9Bv6t2SSbQIAmvfk2jcoGAYo67odXJQH4I/ojEZbm/bm80r5mMCH3HqOTqxP
	 iEZpCsT3i67pyvVHb2yzKWbGZdZItWV2Ob4FFoey9K3/aEHHq8giXuNiumJO7DmCve
	 4eHUz/CEruq5Di7XV6/wke3HQWVq7E0atmm7IkJdrFuZ4qYFw3TQ9EOIhb1g+we9g4
	 9Hqp5mqUVK6+lA5SzALUuWJtjGkTzvZsWBVyO01BMp72OTgxynma6l2j5xAvRQ/lS9
	 IVRmBa6Xj3JWKUq1hEOzK9uv2OFR3tfR/4HK06dHKYPgIsu9Am8T7kbNr4q9/Gwpoe
	 NNdSNeFMp0c7w==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mark Brown <broonie@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH v2 02/13] csky: move setup_initrd() to setup.c
Date: Thu, 13 Mar 2025 15:49:52 +0200
Message-ID: <20250313135003.836600-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250313135003.836600-1-rppt@kernel.org>
References: <20250313135003.836600-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Memory used by initrd should be reserved as soon as possible before
there any memblock allocations that might overwrite that memory.

This will also help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Acked by: Guo Ren (csky) <guoren@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/csky/kernel/setup.c | 43 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/mm/init.c      | 43 ----------------------------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index fe715b707fd0..e0d6ca86ea8c 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -12,6 +12,45 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_initrd(void)
+{
+	unsigned long size;
+
+	if (initrd_start >= initrd_end) {
+		pr_err("initrd not found or empty");
+		goto disable;
+	}
+
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		pr_err("initrd extends beyond end of memory");
+		goto disable;
+	}
+
+	size = initrd_end - initrd_start;
+
+	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
+		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
+		       __pa(initrd_start), size);
+		goto disable;
+	}
+
+	memblock_reserve(__pa(initrd_start), size);
+
+	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
+		(void *)(initrd_start), size);
+
+	initrd_below_start_ok = 1;
+
+	return;
+
+disable:
+	initrd_start = initrd_end = 0;
+
+	pr_err(" - disabling initrd\n");
+}
+#endif
+
 static void __init csky_memblock_init(void)
 {
 	unsigned long lowmem_size = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
@@ -40,6 +79,10 @@ static void __init csky_memblock_init(void)
 		max_low_pfn = min_low_pfn + sseg_size;
 	}
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif
+
 	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
 
 	mmu_init(min_low_pfn, max_low_pfn);
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index bde7cabd23df..ab51acbc19b2 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -42,45 +42,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void __init setup_initrd(void)
-{
-	unsigned long size;
-
-	if (initrd_start >= initrd_end) {
-		pr_err("initrd not found or empty");
-		goto disable;
-	}
-
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		pr_err("initrd extends beyond end of memory");
-		goto disable;
-	}
-
-	size = initrd_end - initrd_start;
-
-	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
-		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
-		       __pa(initrd_start), size);
-		goto disable;
-	}
-
-	memblock_reserve(__pa(initrd_start), size);
-
-	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		(void *)(initrd_start), size);
-
-	initrd_below_start_ok = 1;
-
-	return;
-
-disable:
-	initrd_start = initrd_end = 0;
-
-	pr_err(" - disabling initrd\n");
-}
-#endif
-
 void __init mem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -92,10 +53,6 @@ void __init mem_init(void)
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif
-
 	memblock_free_all();
 
 #ifdef CONFIG_HIGHMEM
-- 
2.47.2


