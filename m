Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1832255828
	for <lists+linux-arch@lfdr.de>; Fri, 28 Aug 2020 12:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgH1KBD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 06:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728997AbgH1KAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Aug 2020 06:00:47 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A0C06121B;
        Fri, 28 Aug 2020 03:00:47 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so228177plb.12;
        Fri, 28 Aug 2020 03:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1XpS/HyClfw6pT/eMXqAbIXlcXWXqL02aliRjQU+Do=;
        b=SVMi9H9MJSwkxZS4sgc+XDPQgZVOYrHw/JEZlNn2qzPuodctA5rT7WpDP8xuiTQjly
         X0D2OJjTMOoqbxFDG/g8DkoZpjgu7jIBQFJ80Slq1BkwHqZaWF9oyKtnqCKmYKd61nxI
         Yp5xE8WBYoOmHck6mFx5BQ7Y+Dcivra0zWhSwoIGE69lPX5uSwulVVD6ttCYihuretrf
         ZPbBHnedxpLGc/cTg26SzEDCf6l6FZ7x5uZlMwGyF0Hk1fu/TVbYwGppEsB3dsB5H0gk
         4T9dQC8KAAD6JEJi8n5bGxKTB/C3tGLdvMJ0k7fy9HPp2irNvVgYsbIih8sf9HtKzHOO
         jM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1XpS/HyClfw6pT/eMXqAbIXlcXWXqL02aliRjQU+Do=;
        b=Ux8mOGZ1MZ9wnnXQJQOowDNe/3cQHLXv6Fx503Td2XgM2C4XlhQR7tLSxQ0Dd/ZsLj
         llq7+9r+DixIyjHfxOdRninUW2jU6RxKy8b1flebs/97a0Oeh3QNLy6FHoL5p+dlHeGb
         48Hc9TbISn2Ol4lRRkT/01EAVNERbC0Ewsc+lIhttK+roqyWx91Cmlurs1N9iezzdxsw
         t6+cy6VWcZknEteaAtmrBwXU8vuM+pLd0YiY4AuULjev8jdnGNWhh+S1yZ2EHJef4/rg
         DWTF1QAvWn7+nBP0UV6TYM9Ogw8CtX/+iCindMiAzXLOYFSB969+5650BqLHZ/zkGqT6
         AI1A==
X-Gm-Message-State: AOAM533NCEOpXRV2M8nfnGInlcT7DjIZcVwtLXkRew6atZMFjSF0pypo
        9PJ/KxbJOBA54BLEWqNZSxI=
X-Google-Smtp-Source: ABdhPJy4OYhts/oK1ycV+d0OGCx/rtyS/ekQliVuUahTMGfIyFq0gV8RJk/8jgwzJpUyRd+KfS/ZuQ==
X-Received: by 2002:a17:902:a503:: with SMTP id s3mr722211plq.190.1598608847187;
        Fri, 28 Aug 2020 03:00:47 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (61-68-212-105.tpgi.com.au. [61.68.212.105])
        by smtp.gmail.com with ESMTPSA id 78sm1068608pfv.200.2020.08.28.03.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:00:46 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 3/4] sparc64: remove mm_cpumask clearing to fix kthread_use_mm race
Date:   Fri, 28 Aug 2020 20:00:21 +1000
Message-Id: <20200828100022.1099682-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200828100022.1099682-1-npiggin@gmail.com>
References: <20200828100022.1099682-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The de facto (and apparently uncommented) standard for using an mm had,
thanks to this code in sparc if nothing else, been that you must have a
reference on mm_users *and that reference must have been obtained with
mmget()*, i.e., from a thread with a reference to mm_users that had used
the mm.

The introduction of mmget_not_zero() in commit d2005e3f41d4
("userfaultfd: don't pin the user memory in userfaultfd_file_create()")
allowed mm_count holders to aoperate on user mappings asynchronously
from the actual threads using the mm, but they were not to load those
mappings into their TLB (i.e., walking vmas and page tables is okay,
kthread_use_mm() is not).

io_uring 2b188cc1bb857 ("Add io_uring IO interface") added code which
does a kthread_use_mm() from a mmget_not_zero() refcount.

The problem with this is code which previously assumed mm == current->mm
and mm->mm_users == 1 implies the mm will remain single-threaded at
least until this thread creates another mm_users reference, has now
broken.

arch/sparc/kernel/smp_64.c:

    if (atomic_read(&mm->mm_users) == 1) {
        cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
        goto local_flush_and_out;
    }

vs fs/io_uring.c

    if (unlikely(!(ctx->flags & IORING_SETUP_SQPOLL) ||
                 !mmget_not_zero(ctx->sqo_mm)))
        return -EFAULT;
    kthread_use_mm(ctx->sqo_mm);

mmget_not_zero() could come in right after the mm_users == 1 test, then
kthread_use_mm() which sets its CPU in the mm_cpumask. That update could
be lost if cpumask_copy() occurs afterward.

I propose we fix this by allowing mmget_not_zero() to be a first-class
reference, and not have this obscure undocumented and unchecked
restriction.

The basic fix for sparc64 is to remove its mm_cpumask clearing code. The
optimisation could be effectively restored by sending IPIs to mm_cpumask
members and having them remove themselves from mm_cpumask. This is more
tricky so I leave it as an exercise for someone with a sparc64 SMP.
powerpc has a (currently similarly broken) example.

Cc: sparclinux@vger.kernel.org
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/sparc/kernel/smp_64.c | 65 ++++++++------------------------------
 1 file changed, 14 insertions(+), 51 deletions(-)

diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e286e2badc8a..e38d8bf454e8 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -1039,38 +1039,9 @@ void smp_fetch_global_pmu(void)
  * are flush_tlb_*() routines, and these run after flush_cache_*()
  * which performs the flushw.
  *
- * The SMP TLB coherency scheme we use works as follows:
- *
- * 1) mm->cpu_vm_mask is a bit mask of which cpus an address
- *    space has (potentially) executed on, this is the heuristic
- *    we use to avoid doing cross calls.
- *
- *    Also, for flushing from kswapd and also for clones, we
- *    use cpu_vm_mask as the list of cpus to make run the TLB.
- *
- * 2) TLB context numbers are shared globally across all processors
- *    in the system, this allows us to play several games to avoid
- *    cross calls.
- *
- *    One invariant is that when a cpu switches to a process, and
- *    that processes tsk->active_mm->cpu_vm_mask does not have the
- *    current cpu's bit set, that tlb context is flushed locally.
- *
- *    If the address space is non-shared (ie. mm->count == 1) we avoid
- *    cross calls when we want to flush the currently running process's
- *    tlb state.  This is done by clearing all cpu bits except the current
- *    processor's in current->mm->cpu_vm_mask and performing the
- *    flush locally only.  This will force any subsequent cpus which run
- *    this task to flush the context from the local tlb if the process
- *    migrates to another cpu (again).
- *
- * 3) For shared address spaces (threads) and swapping we bite the
- *    bullet for most cases and perform the cross call (but only to
- *    the cpus listed in cpu_vm_mask).
- *
- *    The performance gain from "optimizing" away the cross call for threads is
- *    questionable (in theory the big win for threads is the massive sharing of
- *    address space state across processors).
+ * mm->cpu_vm_mask is a bit mask of which cpus an address
+ * space has (potentially) executed on, this is the heuristic
+ * we use to limit cross calls.
  */
 
 /* This currently is only used by the hugetlb arch pre-fault
@@ -1080,18 +1051,13 @@ void smp_fetch_global_pmu(void)
 void smp_flush_tlb_mm(struct mm_struct *mm)
 {
 	u32 ctx = CTX_HWBITS(mm->context);
-	int cpu = get_cpu();
 
-	if (atomic_read(&mm->mm_users) == 1) {
-		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-		goto local_flush_and_out;
-	}
+	get_cpu();
 
 	smp_cross_call_masked(&xcall_flush_tlb_mm,
 			      ctx, 0, 0,
 			      mm_cpumask(mm));
 
-local_flush_and_out:
 	__flush_tlb_mm(ctx, SECONDARY_CONTEXT);
 
 	put_cpu();
@@ -1114,17 +1080,15 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 {
 	u32 ctx = CTX_HWBITS(mm->context);
 	struct tlb_pending_info info;
-	int cpu = get_cpu();
+
+	get_cpu();
 
 	info.ctx = ctx;
 	info.nr = nr;
 	info.vaddrs = vaddrs;
 
-	if (mm == current->mm && atomic_read(&mm->mm_users) == 1)
-		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-	else
-		smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
-				       &info, 1);
+	smp_call_function_many(mm_cpumask(mm), tlb_pending_func,
+			       &info, 1);
 
 	__flush_tlb_pending(ctx, nr, vaddrs);
 
@@ -1134,14 +1098,13 @@ void smp_flush_tlb_pending(struct mm_struct *mm, unsigned long nr, unsigned long
 void smp_flush_tlb_page(struct mm_struct *mm, unsigned long vaddr)
 {
 	unsigned long context = CTX_HWBITS(mm->context);
-	int cpu = get_cpu();
 
-	if (mm == current->mm && atomic_read(&mm->mm_users) == 1)
-		cpumask_copy(mm_cpumask(mm), cpumask_of(cpu));
-	else
-		smp_cross_call_masked(&xcall_flush_tlb_page,
-				      context, vaddr, 0,
-				      mm_cpumask(mm));
+	get_cpu();
+
+	smp_cross_call_masked(&xcall_flush_tlb_page,
+			      context, vaddr, 0,
+			      mm_cpumask(mm));
+
 	__flush_tlb_page(context, vaddr);
 
 	put_cpu();
-- 
2.23.0

