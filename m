Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8683324896D
	for <lists+linux-arch@lfdr.de>; Tue, 18 Aug 2020 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgHRPUY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 11:20:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbgHRPTe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Aug 2020 11:19:34 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF31B2054F;
        Tue, 18 Aug 2020 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597763973;
        bh=nhrWEJg18dZtklhN7elITeRIszP29EpKC+P0m7RisCg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jJdwwbdMEM6WFAxnKmzqjftNGL5aHnZ8HFdP0bLUoJbwkV7KT+64vmwzgPr/3gM4H
         L3TcgqCT4iWq+77Eas6CHdNnad16CnUdskrAErKRn7QQ+AYSaIk8S8xA3vFVYoMH1A
         qr6QBNG6c3Pm5z2O3XmrN6YvTl5W+Qn4hIl1KgsI=
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
Subject: [PATCH v3 15/17] memblock: remove unused memblock_mem_size()
Date:   Tue, 18 Aug 2020 18:16:32 +0300
Message-Id: <20200818151634.14343-16-rppt@kernel.org>
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

The only user of memblock_mem_size() was x86 setup code, it is gone now and
memblock_mem_size() funciton can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
---
 include/linux/memblock.h |  1 -
 mm/memblock.c            | 15 ---------------
 2 files changed, 16 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 27c3b84d1615..15ed119701c1 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -481,7 +481,6 @@ static inline bool memblock_bottom_up(void)
 
 phys_addr_t memblock_phys_mem_size(void);
 phys_addr_t memblock_reserved_size(void);
-phys_addr_t memblock_mem_size(unsigned long limit_pfn);
 phys_addr_t memblock_start_of_DRAM(void);
 phys_addr_t memblock_end_of_DRAM(void);
 void memblock_enforce_memory_limit(phys_addr_t memory_limit);
diff --git a/mm/memblock.c b/mm/memblock.c
index 567e454ce0a1..eb4f866bea34 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1657,21 +1657,6 @@ phys_addr_t __init_memblock memblock_reserved_size(void)
 	return memblock.reserved.total_size;
 }
 
-phys_addr_t __init memblock_mem_size(unsigned long limit_pfn)
-{
-	unsigned long pages = 0;
-	unsigned long start_pfn, end_pfn;
-	int i;
-
-	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, NULL) {
-		start_pfn = min_t(unsigned long, start_pfn, limit_pfn);
-		end_pfn = min_t(unsigned long, end_pfn, limit_pfn);
-		pages += end_pfn - start_pfn;
-	}
-
-	return PFN_PHYS(pages);
-}
-
 /* lowest address */
 phys_addr_t __init_memblock memblock_start_of_DRAM(void)
 {
-- 
2.26.2

