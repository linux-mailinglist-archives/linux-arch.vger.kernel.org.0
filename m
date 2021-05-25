Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE9138F851
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 04:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhEYCs7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 22:48:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230282AbhEYCsz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 22:48:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8B17613B6;
        Tue, 25 May 2021 02:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621910846;
        bh=G0DLGokLK/mGUXDs2QLc6PfTjpzoIAZVAK4gEAIlKEY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3EHYmuGDNTXTFlZA3cB4CTQZZ0D1mKbPF2sfq0fP3TSFIFGEtd0uMIX1xd6AivLW
         gRfmGH/4Irmox5lOj2ZjIQ8FUFbO72gU1+zfmRySWX/P1bsF61NLThGSsbO4s52JTl
         sZn/lmvlM6ItakqK3himjAdzVQIppr0smX6AzjqLk6ZxkSy6yRlMTyKI5H82k2m70a
         k8P9/VGA8p7HkKcXrWGA3EanTT2TjMtrafWoNQ7glS8UcIdBM9yKpHY1isc3k2dbIx
         z7lKgRtVoI+aYPnhSYF1SDhQaHhbmI71GrY4OxG7CVyTPzb/KhzrlaZSwUibrbHP2X
         BViXx5Yshh4bA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 2/2] riscv: Use use_asid_allocator flush TLB
Date:   Tue, 25 May 2021 02:46:27 +0000
Message-Id: <1621910787-34598-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1621910787-34598-1-git-send-email-guoren@kernel.org>
References: <1621910787-34598-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Use static_branch_unlikely(&use_asid_allocator) to keep the origin
tlb flush style, so it's no effect on the existing machine. Here
are the optimized functions:
 - flush_tlb_mm
 - flush_tlb_page
 - flush_tlb_range

All above are based on the below new implement functions:
 - __sbi_tlb_flush_range_asid
 - local_flush_tlb_range_asid

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup.patel@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/mmu_context.h |  2 ++
 arch/riscv/include/asm/tlbflush.h    | 22 ++++++++++++++++++++
 arch/riscv/mm/context.c              |  2 +-
 arch/riscv/mm/tlbflush.c             | 40 +++++++++++++++++++++++++++++++++---
 4 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index b065941..7030837 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -33,6 +33,8 @@ static inline int init_new_context(struct task_struct *tsk,
 	return 0;
 }
 
+DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index c84218a..9390319 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -8,6 +8,7 @@
 #define _ASM_RISCV_TLBFLUSH_H
 
 #include <linux/mm_types.h>
+#include <asm/page.h>
 #include <asm/smp.h>
 #include <asm/errata_list.h>
 
@@ -22,9 +23,30 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
+
+static inline void local_flush_tlb_range_asid(unsigned long start, unsigned long size,
+					      unsigned long asid)
+{
+	unsigned long page_add = PAGE_DOWN(start);
+	unsigned long page_end = PAGE_UP(start + size);
+
+	if (size == -1) {
+		__asm__ __volatile__ ("sfence.vma x0, %0" : : "r" (asid) : "memory");
+		return;
+	}
+
+	while(page_add < page_end) {
+		__asm__ __volatile__ ("sfence.vma %0, %1"
+				:
+				: "r" (page_add), "r" (asid)
+				: "memory");
+		page_add += PAGE_SIZE;
+	}
+}
 #else /* CONFIG_MMU */
 #define local_flush_tlb_all()			do { } while (0)
 #define local_flush_tlb_page(addr)		do { } while (0)
+#define local_flush_tlb_range_asid(addr)	do { } while (0)
 #endif /* CONFIG_MMU */
 
 #if defined(CONFIG_SMP) && defined(CONFIG_MMU)
diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 68aa312..45c1b04 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -18,7 +18,7 @@
 
 #ifdef CONFIG_MMU
 
-static DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
+DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
 static unsigned long asid_bits;
 static unsigned long num_asids;
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 720b443..69588dc 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <asm/sbi.h>
+#include <asm/mmu_context.h>
 
 void flush_tlb_all(void)
 {
@@ -39,18 +40,51 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 	put_cpu();
 }
 
+static void __sbi_tlb_flush_range_asid(struct cpumask *cmask, unsigned long start,
+				       unsigned long size, unsigned long asid)
+{
+	struct cpumask hmask;
+	unsigned int cpuid;
+
+	if (cpumask_empty(cmask))
+		return;
+
+	cpuid = get_cpu();
+
+	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
+		local_flush_tlb_range_asid(start, size, asid);
+	} else {
+		riscv_cpuid_to_hartid_mask(cmask, &hmask);
+		sbi_remote_sfence_vma_asid(cpumask_bits(&hmask), start, size, asid);
+	}
+
+	put_cpu();
+}
+
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
+	if (static_branch_unlikely(&use_asid_allocator))
+		__sbi_tlb_flush_range_asid(mm_cpumask(mm), 0, -1,
+					   atomic_long_read(&mm->context.id));
+	else
+		__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
+	if (static_branch_unlikely(&use_asid_allocator))
+		__sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE,
+					   atomic_long_read(&vma->vm_mm->context.id));
+	else
+		__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
+	if (static_branch_unlikely(&use_asid_allocator))
+		__sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), start, end - start,
+					   atomic_long_read(&vma->vm_mm->context.id));
+	else
+		__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
 }
-- 
2.7.4

