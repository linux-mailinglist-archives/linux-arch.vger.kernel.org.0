Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D9E2683C9
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 06:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgINExL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 00:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgINEw5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 00:52:57 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0E0C06174A;
        Sun, 13 Sep 2020 21:52:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d9so11559190pfd.3;
        Sun, 13 Sep 2020 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R15E1zKDEleMSpcLsh3CZt5cwnsxHHwg3les0S/1HZQ=;
        b=uNv5AhJ0SYv5S+1R/EdoTvDqPZ5eXsxLSyL8+onv+hZ/ZRcPZqRzqqm6XO3h5Nj6Py
         sKBbwnnGJu/HqHJUmlYkl+GiPJ8B8mrJS5k0iRTMEr0bvt4hkHbDzeeVFA3PHO/w5v9j
         DutoQlniOFqwgAaQkImqtu5I4FY5mSAlT6K0jQbybp3oSKsaoixC3ZjFM6tOjIQVYZqF
         +onq2SwiDTGpV8J1qnA382eEVQG+9lVu3Fz6arc+56QRPz4i/OKVOMr+OH7kxCGOJXtF
         5is1TXx+TzvrmSlZ0XC8FTocgM6LhhrgTYxk66zt3maGFX2EV3KuWoosS3Ba8Je3Dykt
         UM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R15E1zKDEleMSpcLsh3CZt5cwnsxHHwg3les0S/1HZQ=;
        b=RgdSAuT0P4yF29li8EmB0uqQL+XKkzjWSqIc1dnQ+KKGCsRQtH27CyyCKL3oe6jg6d
         X8pU+eQRHGhsj+SPr1hAYxDQFL3OWgVJEBozzXMXr30xq7Y0eMkYAuZQSeHl2LqnWeoe
         D+DWCs09dcRfxG+nCLhamgpfZHLfRIpNqPtFFQtJwK3RTGt0m4iLp5Qf2t8zU0A4unpF
         AZ3wCCLqm7xIGbuO/kEvz0MQhfWwGv0sxjlHIvm3DGl/OFncS+Os6moIR08G3Ia5wF7Q
         XStVMt96AiVkfog2O11W7Dt4WBllzSPUb0bnNFmaWKEUt8gKHJ2jbFOCgWYO1uu4cyrt
         VMHA==
X-Gm-Message-State: AOAM533M8tXwLyd5ZpN5J+e3W4OIWkoqdiij9BRe+L1UcHsrsVc6wxBW
        /anaXWL57njP2fTISP0CKxk=
X-Google-Smtp-Source: ABdhPJyC3zHA2fO7ys2+MpyPfXJxUsoxMUIwuOQM00TR8Qj8lFaNM2scvwlKBeqI7feKRAikOHoVjg==
X-Received: by 2002:a63:5561:: with SMTP id f33mr9503684pgm.13.1600059175888;
        Sun, 13 Sep 2020 21:52:55 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id a13sm6945312pgq.41.2020.09.13.21.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 21:52:55 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 4/4] powerpc/64s/radix: Fix mm_cpumask trimming race vs kthread_use_mm
Date:   Mon, 14 Sep 2020 14:52:19 +1000
Message-Id: <20200914045219.3736466-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200914045219.3736466-1-npiggin@gmail.com>
References: <20200914045219.3736466-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Commit 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of
single-threaded mm_cpumask") added a mechanism to trim the mm_cpumask of
a process under certain conditions. One of the assumptions is that
mm_users would not be incremented via a reference outside the process
context with mmget_not_zero() then go on to kthread_use_mm() via that
reference.

That invariant was broken by io_uring code (see previous sparc64 fix),
but I'll point Fixes: to the original powerpc commit because we are
changing that assumption going forward, so this will make backports
match up.

Fix this by no longer relying on that assumption, but by having each CPU
check the mm is not being used, and clearing their own bit from the mask
only if it hasn't been switched-to by the time the IPI is processed.

This relies on commit 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB
invalidate") and ARCH_WANT_IRQS_OFF_ACTIVATE_MM to disable irqs over mm
switch sequences.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
Depends-on: 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB invalidate")
Fixes: 0cef77c7798a7 ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/tlb.h       | 13 -------------
 arch/powerpc/mm/book3s64/radix_tlb.c | 23 ++++++++++++++++-------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index fbc6f3002f23..d97f061fecac 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -66,19 +66,6 @@ static inline int mm_is_thread_local(struct mm_struct *mm)
 		return false;
 	return cpumask_test_cpu(smp_processor_id(), mm_cpumask(mm));
 }
-static inline void mm_reset_thread_local(struct mm_struct *mm)
-{
-	WARN_ON(atomic_read(&mm->context.copros) > 0);
-	/*
-	 * It's possible for mm_access to take a reference on mm_users to
-	 * access the remote mm from another thread, but it's not allowed
-	 * to set mm_cpumask, so mm_users may be > 1 here.
-	 */
-	WARN_ON(current->mm != mm);
-	atomic_set(&mm->context.active_cpus, 1);
-	cpumask_clear(mm_cpumask(mm));
-	cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
-}
 #else /* CONFIG_PPC_BOOK3S_64 */
 static inline int mm_is_thread_local(struct mm_struct *mm)
 {
diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 0d233763441f..143b4fd396f0 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -645,19 +645,29 @@ static void do_exit_flush_lazy_tlb(void *arg)
 	struct mm_struct *mm = arg;
 	unsigned long pid = mm->context.id;
 
+	/*
+	 * A kthread could have done a mmget_not_zero() after the flushing CPU
+	 * checked mm_is_singlethreaded, and be in the process of
+	 * kthread_use_mm when interrupted here. In that case, current->mm will
+	 * be set to mm, because kthread_use_mm() setting ->mm and switching to
+	 * the mm is done with interrupts off.
+	 */
 	if (current->mm == mm)
-		return; /* Local CPU */
+		goto out_flush;
 
 	if (current->active_mm == mm) {
-		/*
-		 * Must be a kernel thread because sender is single-threaded.
-		 */
-		BUG_ON(current->mm);
+		WARN_ON_ONCE(current->mm != NULL);
+		/* Is a kernel thread and is using mm as the lazy tlb */
 		mmgrab(&init_mm);
-		switch_mm(mm, &init_mm, current);
 		current->active_mm = &init_mm;
+		switch_mm_irqs_off(mm, &init_mm, current);
 		mmdrop(mm);
 	}
+
+	atomic_dec(&mm->context.active_cpus);
+	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(mm));
+
+out_flush:
 	_tlbiel_pid(pid, RIC_FLUSH_ALL);
 }
 
@@ -672,7 +682,6 @@ static void exit_flush_lazy_tlbs(struct mm_struct *mm)
 	 */
 	smp_call_function_many(mm_cpumask(mm), do_exit_flush_lazy_tlb,
 				(void *)mm, 1);
-	mm_reset_thread_local(mm);
 }
 
 void radix__flush_tlb_mm(struct mm_struct *mm)
-- 
2.23.0

