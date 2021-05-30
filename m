Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA583395222
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhE3QwF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 May 2021 12:52:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229975AbhE3Qv4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 May 2021 12:51:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E32561205;
        Sun, 30 May 2021 16:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622393418;
        bh=h/LBInXkQe0GJZ3kZE09CPKLl4b0IH8I2tgS72te2ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JAuuZoeVs4jTmxdGUOrcYjzwzvZ2r9C3y/+H1ktgb5hWNFC4K2bNPhLpJVB7cTmge
         uYk3KlAxWk5EGU3aCAh6u0up/cchUbQMlqi4uQ6dzC+gEkzqBS7494ofgJDXMh8Hsv
         +zlhlvbZ3uSr0jtUaMy1Fj/HVxiUbIdGiibE3DrOPwqH2QpJb13X3uPGAI21I6ZUhe
         QEU8qRpKB8VkobaDR28nFjsQbJ6OPBCnt4yS+cOAmPlxFy6aghfuX/zuHbSbgr+Aiv
         1xZIOcc7moaPsBte0MbYS78hCp91642uneZiJvtXYPFT045sN4cRlZDQRmX+z244OO
         eTvB/598AJl6A==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 2/3] riscv: Add ASID-based tlbflushing methods
Date:   Sun, 30 May 2021 16:49:25 +0000
Message-Id: <1622393366-46079-3-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622393366-46079-1-git-send-email-guoren@kernel.org>
References: <1622393366-46079-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement optimized version of the tlb flushing routines for systems
using ASIDs. These are behind the use_asid_allocator static branch to
not affect existing systems not using ASIDs.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup.patel@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/include/asm/mmu_context.h |  2 ++
 arch/riscv/include/asm/tlbflush.h    | 22 +++++++++++++++++
 arch/riscv/mm/context.c              |  2 +-
 arch/riscv/mm/tlbflush.c             | 46 +++++++++++++++++++++++++++++++++---
 4 files changed, 68 insertions(+), 4 deletions(-)

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
index c84218a..894cf75 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -22,9 +22,31 @@ static inline void local_flush_tlb_page(unsigned long addr)
 {
 	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
 }
+
+static inline void local_flush_tlb_all_asid(unsigned long asid)
+{
+	__asm__ __volatile__ ("sfence.vma x0, %0"
+			:
+			: "r" (asid)
+			: "memory");
+}
+
+static inline void local_flush_tlb_range_asid(unsigned long start,
+				unsigned long size, unsigned long asid)
+{
+	unsigned long tmp, end = ALIGN(start + size, PAGE_SIZE);
+
+	for (tmp = start & PAGE_MASK; tmp < end; tmp += PAGE_SIZE) {
+		__asm__ __volatile__ ("sfence.vma %0, %1"
+				:
+				: "r" (tmp), "r" (asid)
+				: "memory");
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
index 720b443..87b4e52 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -4,6 +4,7 @@
 #include <linux/smp.h>
 #include <linux/sched.h>
 #include <asm/sbi.h>
+#include <asm/mmu_context.h>
 
 void flush_tlb_all(void)
 {
@@ -39,18 +40,57 @@ static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
 	put_cpu();
 }
 
+static void __sbi_tlb_flush_range_asid(struct cpumask *cmask,
+				       unsigned long start,
+				       unsigned long size,
+				       unsigned long asid)
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
+		if (size == -1)
+			local_flush_tlb_all_asid(asid);
+		else
+			local_flush_tlb_range_asid(start, size, asid);
+	} else {
+		riscv_cpuid_to_hartid_mask(cmask, &hmask);
+		sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
+					   start, size, asid);
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

