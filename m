Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B024395224
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 18:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbhE3QwM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 May 2021 12:52:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhE3Qv6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 May 2021 12:51:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9459D61027;
        Sun, 30 May 2021 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622393420;
        bh=7QeWtBcpmgX2h1U9CSCvY1o63rcwMf7sxdiWDnALUwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJoAYQlWEwdM35MRPZa8cvx3sFeawkf+1sbNxYZ5uetxWas7b4pr3b4EHhsdFEBbZ
         Vqn67zpyeTosp8e/ajzAQvCcnihdg3LaxejLHP4pLn/Nmvyo0VAGCqKanWdYZZtPDc
         219NJL9B2Gi9WXvDENZ4ZknONDSGW7uXNOrHhUbqsNQZ8AuHkaqTNyGGd0XTzokZ/S
         WawAns5UQiJf+gJhoAjNeSXjIbLX1XN2FQeI5de6cyDP/EwvzI/KNZRFG9KoyHjD+g
         biE9rbnoiGfZjs3XTau61B7hhhrlNyL0HJvYkmeApwRLl3HnWVI/7d5su34RBhZVjJ
         RxqWgQTiUgxpg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH V5 3/3] riscv: tlbflush: Optimize coding convention
Date:   Sun, 30 May 2021 16:49:26 +0000
Message-Id: <1622393366-46079-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622393366-46079-1-git-send-email-guoren@kernel.org>
References: <1622393366-46079-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Passing the mm_struct as the first argument, as we can derive both
the cpumask and asid from it instead of doing that in the callers.

But more importantly, the static branch check can be moved deeper
into the code to avoid a lot of duplication.

Also add FIXME comment on the non-ASID code switches to a global
flush once flushing more than a single page.

Link: https://lore.kernel.org/linux-riscv/CAJF2gTQpDYtEdw6ZrTVZUYqxGdhLPs25RjuUiQtz=xN2oKs2fw@mail.gmail.com/T/#m30f7e8d02361f21f709bc3357b9f6ead1d47ed43
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-Developed-by: Christoph Hellwig <hch@lst.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/mm/tlbflush.c | 91 ++++++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 50 deletions(-)

diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 87b4e52..facca6e 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -12,56 +12,59 @@ void flush_tlb_all(void)
 }
 
 /*
- * This function must not be called with cmask being null.
+ * This function must not be called with mm_cpumask(mm) being null.
  * Kernel may panic if cmask is NULL.
  */
-static void __sbi_tlb_flush_range(struct cpumask *cmask, unsigned long start,
+static void __sbi_tlb_flush_range(struct mm_struct *mm,
+				  unsigned long start,
 				  unsigned long size)
 {
+	struct cpumask *cmask = mm_cpumask(mm);
 	struct cpumask hmask;
 	unsigned int cpuid;
+	bool local;
 
 	if (cpumask_empty(cmask))
 		return;
 
 	cpuid = get_cpu();
 
-	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
-		/* local cpu is the only cpu present in cpumask */
-		if (size <= PAGE_SIZE)
-			local_flush_tlb_page(start);
-		else
-			local_flush_tlb_all();
-	} else {
-		riscv_cpuid_to_hartid_mask(cmask, &hmask);
-		sbi_remote_sfence_vma(cpumask_bits(&hmask), start, size);
-	}
+	/*
+	 * check if the tlbflush needs to be sent to other CPUs, local
+	 * cpu is the only cpu present in cpumask.
+	 */
+	local = !(cpumask_any_but(cmask, cpuid) < nr_cpu_ids);
 
-	put_cpu();
-}
-
-static void __sbi_tlb_flush_range_asid(struct cpumask *cmask,
-				       unsigned long start,
-				       unsigned long size,
-				       unsigned long asid)
-{
-	struct cpumask hmask;
-	unsigned int cpuid;
-
-	if (cpumask_empty(cmask))
-		return;
-
-	cpuid = get_cpu();
+	if (static_branch_likely(&use_asid_allocator)) {
+		unsigned long asid = atomic_long_read(&mm->context.id);
 
-	if (cpumask_any_but(cmask, cpuid) >= nr_cpu_ids) {
-		if (size == -1)
-			local_flush_tlb_all_asid(asid);
-		else
-			local_flush_tlb_range_asid(start, size, asid);
+		if (likely(local)) {
+			if (size == -1)
+				local_flush_tlb_all_asid(asid);
+			else
+				local_flush_tlb_range_asid(start, size, asid);
+		} else {
+			riscv_cpuid_to_hartid_mask(cmask, &hmask);
+			sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
+						   start, size, asid);
+		}
 	} else {
-		riscv_cpuid_to_hartid_mask(cmask, &hmask);
-		sbi_remote_sfence_vma_asid(cpumask_bits(&hmask),
-					   start, size, asid);
+		if (likely(local)) {
+			/*
+			 * FIXME: The non-ASID code switches to a global flush
+			 * once flushing more than a single page. It's made by
+			 * commit 6efb16b1d551 (RISC-V: Issue a tlb page flush
+			 * if possible).
+			 */
+			if (size <= PAGE_SIZE)
+				local_flush_tlb_page(start);
+			else
+				local_flush_tlb_all();
+		} else {
+			riscv_cpuid_to_hartid_mask(cmask, &hmask);
+			sbi_remote_sfence_vma(cpumask_bits(&hmask),
+					      start, size);
+		}
 	}
 
 	put_cpu();
@@ -69,28 +72,16 @@ static void __sbi_tlb_flush_range_asid(struct cpumask *cmask,
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	if (static_branch_unlikely(&use_asid_allocator))
-		__sbi_tlb_flush_range_asid(mm_cpumask(mm), 0, -1,
-					   atomic_long_read(&mm->context.id));
-	else
-		__sbi_tlb_flush_range(mm_cpumask(mm), 0, -1);
+	__sbi_tlb_flush_range(mm, 0, -1);
 }
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
-	if (static_branch_unlikely(&use_asid_allocator))
-		__sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE,
-					   atomic_long_read(&vma->vm_mm->context.id));
-	else
-		__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), addr, PAGE_SIZE);
+	__sbi_tlb_flush_range(vma->vm_mm, addr, PAGE_SIZE);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		     unsigned long end)
 {
-	if (static_branch_unlikely(&use_asid_allocator))
-		__sbi_tlb_flush_range_asid(mm_cpumask(vma->vm_mm), start, end - start,
-					   atomic_long_read(&vma->vm_mm->context.id));
-	else
-		__sbi_tlb_flush_range(mm_cpumask(vma->vm_mm), start, end - start);
+	__sbi_tlb_flush_range(vma->vm_mm, start, end - start);
 }
-- 
2.7.4

