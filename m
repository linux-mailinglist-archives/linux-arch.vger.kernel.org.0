Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2562358ED
	for <lists+linux-arch@lfdr.de>; Sun,  2 Aug 2020 18:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgHBQik (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 2 Aug 2020 12:38:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgHBQij (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 2 Aug 2020 12:38:39 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D797220759;
        Sun,  2 Aug 2020 16:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596386318;
        bh=o8aZbB2pKDQsqUqKMBDH2F8svHn12mD34Nb+72y2BZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QgzlknYsb9NiWB8c/Yeh/cISQPrZRFom46AMdT7FrT79j0mzUH6ggsWMbDZWlX4P8
         UyQ3srMeb9iG6KtyQNKoy0bv4eQadT2brjYzvyX1yGh7qES1VdDGGb7RMSiDH9JBdG
         DZDhRIfp4FkpXhluwKfMBKUj7+OCDBbjLlDEZLbY=
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
Subject: [PATCH v2 13/17] x86/setup: simplify initrd relocation and reservation
Date:   Sun,  2 Aug 2020 19:35:57 +0300
Message-Id: <20200802163601.8189-14-rppt@kernel.org>
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

Currently, initrd image is reserved very early during setup and then it
might be relocated and re-reserved after the initial physical memory
mapping is created. The "late" reservation of memblock verifies that mapped
memory size exceeds the size of initrd, the checks whether the relocation
required and, if yes, relocates inirtd to a new memory allocated from
memblock and frees the old location.

The check for memory size is excessive as memblock allocation will anyway
fail if there is not enough memory. Besides, there is no point to allocate
memory from memblock using memblock_find_in_range() + memblock_reserve()
when there exists memblock_phys_alloc_range() with required functionality.

Remove the redundant check and simplify memblock allocation.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/kernel/setup.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a3767e74c758..d8de4053c5e8 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -262,16 +262,12 @@ static void __init relocate_initrd(void)
 	u64 area_size     = PAGE_ALIGN(ramdisk_size);
 
 	/* We need to move the initrd down into directly mapped mem */
-	relocated_ramdisk = memblock_find_in_range(0, PFN_PHYS(max_pfn_mapped),
-						   area_size, PAGE_SIZE);
-
+	relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
+						      PFN_PHYS(max_pfn_mapped));
 	if (!relocated_ramdisk)
 		panic("Cannot find place for new RAMDISK of size %lld\n",
 		      ramdisk_size);
 
-	/* Note: this includes all the mem currently occupied by
-	   the initrd, we rely on that fact to keep the data intact. */
-	memblock_reserve(relocated_ramdisk, area_size);
 	initrd_start = relocated_ramdisk + PAGE_OFFSET;
 	initrd_end   = initrd_start + ramdisk_size;
 	printk(KERN_INFO "Allocated new RAMDISK: [mem %#010llx-%#010llx]\n",
@@ -298,13 +294,13 @@ static void __init early_reserve_initrd(void)
 
 	memblock_reserve(ramdisk_image, ramdisk_end - ramdisk_image);
 }
+
 static void __init reserve_initrd(void)
 {
 	/* Assume only end is not page aligned */
 	u64 ramdisk_image = get_ramdisk_image();
 	u64 ramdisk_size  = get_ramdisk_size();
 	u64 ramdisk_end   = PAGE_ALIGN(ramdisk_image + ramdisk_size);
-	u64 mapped_size;
 
 	if (!boot_params.hdr.type_of_loader ||
 	    !ramdisk_image || !ramdisk_size)
@@ -312,12 +308,6 @@ static void __init reserve_initrd(void)
 
 	initrd_start = 0;
 
-	mapped_size = memblock_mem_size(max_pfn_mapped);
-	if (ramdisk_size >= (mapped_size>>1))
-		panic("initrd too large to handle, "
-		       "disabling initrd (%lld needed, %lld available)\n",
-		       ramdisk_size, mapped_size>>1);
-
 	printk(KERN_INFO "RAMDISK: [mem %#010llx-%#010llx]\n", ramdisk_image,
 			ramdisk_end - 1);
 
-- 
2.26.2

