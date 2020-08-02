Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EDE2358EE
	for <lists+linux-arch@lfdr.de>; Sun,  2 Aug 2020 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgHBQiu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Aug 2020 12:38:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgHBQit (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 2 Aug 2020 12:38:49 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B572220829;
        Sun,  2 Aug 2020 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596386329;
        bh=owq9p+k/C9/dpSukqR8EwL4hnjKsMj+76UiJMdPJ/fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rad8TiDptD9dxrBr88aLuHRAT2BqJnMfW2NRDjy71NJ6blsuHzH1615u85QXsH4wj
         E16+uJggojjz9XGF2WAQ9EoCro0yddSG/vgRc632ePGXFN2VBqVIRyZVPfPYidDOrb
         SMLSTJg8sBnzC+58NQK2lydD29xR2vaGVr/X5nGA=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux@googlegroups.com,
        iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp, x86@kernel.org
Subject: [PATCH v2 14/17] x86/setup: simplify reserve_crashkernel()
Date:   Sun,  2 Aug 2020 19:35:58 +0300
Message-Id: <20200802163601.8189-15-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200802163601.8189-1-rppt@kernel.org>
References: <20200802163601.8189-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

* Replace magic numbers with defines
* Replace memblock_find_in_range() + memblock_reserve() with
  memblock_phys_alloc_range()
* Stop checking for low memory size in reserve_crashkernel_low(). The
  allocation from limited range will anyway fail if there is no enough
  memory, so there is no need for extra traversal of memblock.memory

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/setup.c | 40 ++++++++++++++--------------------------
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d8de4053c5e8..d7ced6982524 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -419,13 +419,13 @@ static int __init reserve_crashkernel_low(void)
 {
 #ifdef CONFIG_X86_64
 	unsigned long long base, low_base = 0, low_size = 0;
-	unsigned long total_low_mem;
+	unsigned long low_mem_limit;
 	int ret;
 
-	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
+	low_mem_limit = min(memblock_phys_mem_size(), CRASH_ADDR_LOW_MAX);
 
 	/* crashkernel=Y,low */
-	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
+	ret = parse_crashkernel_low(boot_command_line, low_mem_limit, &low_size, &base);
 	if (ret) {
 		/*
 		 * two parts from kernel/dma/swiotlb.c:
@@ -443,23 +443,17 @@ static int __init reserve_crashkernel_low(void)
 			return 0;
 	}
 
-	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
+	low_base = memblock_phys_alloc_range(low_size, CRASH_ALIGN, 0, CRASH_ADDR_LOW_MAX);
 	if (!low_base) {
 		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
 		       (unsigned long)(low_size >> 20));
 		return -ENOMEM;
 	}
 
-	ret = memblock_reserve(low_base, low_size);
-	if (ret) {
-		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
-		return ret;
-	}
-
-	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
+	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (low RAM limit: %ldMB)\n",
 		(unsigned long)(low_size >> 20),
 		(unsigned long)(low_base >> 20),
-		(unsigned long)(total_low_mem >> 20));
+		(unsigned long)(low_mem_limit >> 20));
 
 	crashk_low_res.start = low_base;
 	crashk_low_res.end   = low_base + low_size - 1;
@@ -503,13 +497,13 @@ static void __init reserve_crashkernel(void)
 		 * unless "crashkernel=size[KMG],high" is specified.
 		 */
 		if (!high)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_LOW_MAX,
-						crash_size, CRASH_ALIGN);
+			crash_base = memblock_phys_alloc_range(crash_size,
+						CRASH_ALIGN, CRASH_ALIGN,
+						CRASH_ADDR_LOW_MAX);
 		if (!crash_base)
-			crash_base = memblock_find_in_range(CRASH_ALIGN,
-						CRASH_ADDR_HIGH_MAX,
-						crash_size, CRASH_ALIGN);
+			crash_base = memblock_phys_alloc_range(crash_size,
+						CRASH_ALIGN, CRASH_ALIGN,
+						CRASH_ADDR_HIGH_MAX);
 		if (!crash_base) {
 			pr_info("crashkernel reservation failed - No suitable area found.\n");
 			return;
@@ -517,19 +511,13 @@ static void __init reserve_crashkernel(void)
 	} else {
 		unsigned long long start;
 
-		start = memblock_find_in_range(crash_base,
-					       crash_base + crash_size,
-					       crash_size, 1 << 20);
+		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
+						  crash_base + crash_size);
 		if (start != crash_base) {
 			pr_info("crashkernel reservation failed - memory is in use.\n");
 			return;
 		}
 	}
-	ret = memblock_reserve(crash_base, crash_size);
-	if (ret) {
-		pr_err("%s: Error reserving crashkernel memblock.\n", __func__);
-		return;
-	}
 
 	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
 		memblock_free(crash_base, crash_size);
-- 
2.26.2

