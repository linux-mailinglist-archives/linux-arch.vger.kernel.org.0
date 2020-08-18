Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887AE248919
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgHRPST (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbgHRPRo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 11:17:44 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9C120829;
        Tue, 18 Aug 2020 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763863;
        bh=ZYR3GBWOTbbLeEGoi1OsOkKb8CEKMyuyBWdLENWnJ1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m1XiJCmbrGx1o925QNv8c/Bp6H5XPTpfeJ1QGf/lnbyqfmruYKi1v8ifq7YUyQIAR
         mOZ35o8Tc86vDo4Lj7DwV982KPoM3khuhgabjNvcxndzkeQsxV3GQCIW74zG8fnva1
         XoxYm1fjkSfMwhRHIMQT4Ivgbg9mEYH8FxQPW2cc=
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Axtens <dja@axtens.net>,
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
Subject: [PATCH v3 05/17] h8300, nds32, openrisc: simplify detection of memory extents
Date:   Tue, 18 Aug 2020 18:16:22 +0300
Message-Id: <20200818151634.14343-6-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818151634.14343-1-rppt@kernel.org>
References: <20200818151634.14343-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Instead of traversing memblock.memory regions to find memory_start and
memory_end, simply query memblock_{start,end}_of_DRAM().

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Stafford Horne <shorne@gmail.com>
---
 arch/h8300/kernel/setup.c    | 8 +++-----
 arch/nds32/kernel/setup.c    | 8 ++------
 arch/openrisc/kernel/setup.c | 9 ++-------
 3 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/arch/h8300/kernel/setup.c b/arch/h8300/kernel/setup.c
index 28ac88358a89..0281f92eea3d 100644
--- a/arch/h8300/kernel/setup.c
+++ b/arch/h8300/kernel/setup.c
@@ -74,17 +74,15 @@ static void __init bootmem_init(void)
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel */
-	for_each_memblock(memory, region) {
-		memory_start = region->base;
-		memory_end = region->base + region->size;
-	}
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	if (!memory_end)
 		panic("No memory!");
 
 	/* setup bootmem globals (we use no_bootmem, but mm still depends on this) */
 	min_low_pfn = PFN_UP(memory_start);
-	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
+	max_low_pfn = PFN_DOWN(memory_end);
 	max_pfn = max_low_pfn;
 
 	memblock_reserve(__pa(_stext), _end - _stext);
diff --git a/arch/nds32/kernel/setup.c b/arch/nds32/kernel/setup.c
index a066efbe53c0..c356e484dcab 100644
--- a/arch/nds32/kernel/setup.c
+++ b/arch/nds32/kernel/setup.c
@@ -249,12 +249,8 @@ static void __init setup_memory(void)
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel */
-	for_each_memblock(memory, region) {
-		memory_start = region->base;
-		memory_end = region->base + region->size;
-		pr_info("%s: Memory: 0x%x-0x%x\n", __func__,
-			memory_start, memory_end);
-	}
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	if (!memory_end) {
 		panic("No memory!");
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index b18e775f8be3..5a5940f7ebb1 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -48,17 +48,12 @@ static void __init setup_memory(void)
 	unsigned long ram_start_pfn;
 	unsigned long ram_end_pfn;
 	phys_addr_t memory_start, memory_end;
-	struct memblock_region *region;
 
 	memory_end = memory_start = 0;
 
 	/* Find main memory where is the kernel, we assume its the only one */
-	for_each_memblock(memory, region) {
-		memory_start = region->base;
-		memory_end = region->base + region->size;
-		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
-		       memory_start, memory_end);
-	}
+	memory_start = memblock_start_of_DRAM();
+	memory_end = memblock_end_of_DRAM();
 
 	if (!memory_end) {
 		panic("No memory!");
-- 
2.26.2

