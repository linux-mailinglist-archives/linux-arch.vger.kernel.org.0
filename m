Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3854421ACB2
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 03:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGJB5n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Jul 2020 21:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727827AbgGJB5l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 21:57:41 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34484C08C5CE;
        Thu,  9 Jul 2020 18:57:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so1598363pls.4;
        Thu, 09 Jul 2020 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuNVeJNgy5mpkucMC/444QKJa8KYGoy9AAUByxslVr0=;
        b=BoASjg5DuB0JgJ/G9iM75j5066TvHrMOt03o2xV9i6pMNokjvc39C4RRiktgpOGDpj
         doX11205IDJ2VrLi+hwng0m6ABgVjNKqpQL8fhFw5B2J1gLI2JIoG704T6+BP64xHFiV
         oC1niasIHgPNHKmcbXkkm7jg1TSu+PYvG91YB+PNqEYITyWlWT4Td2P7rbTyPIeOSQ1p
         UhyJv744LdKzZvGoLMLwHiZ3d7BK5HhwyAmV8z/WA1ssGO44c/ay+9U5Tj75XkrkfkzJ
         E9mOxkFL6p9WWJnJl2n0ivM3zsrbM75wwFMUskppQkK7tJ4l0oImoRAKuPxJfJI9rV4E
         QqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cuNVeJNgy5mpkucMC/444QKJa8KYGoy9AAUByxslVr0=;
        b=EyVt68uqBGGVM0b9G/jTevJDicJ36LdVoyQuMSV5B+qq8wkQSvLyLNgaiyTJK7lTsw
         U5YBam8kQDB1aqhr+IqrIdbuzWdho2gw/bnqI6iHgTdnnYKFcHvKJL8WaO60sT1VucjN
         mXWgOt2PqJuVkg0B/RXvV//bbJ9oS98qFvl+qcuEqVh1Zr7RPZF8rU+QpBov2rudTXrk
         5F9BB0brC8rKj/NJIeVE4+qe5gY4Sag8s7JvusSfPj2VGfMm7MDhnvwzy4HTkGu72bJ3
         34zRKpqlQdEXJ1csVYBvzQ5DPaDGqq7ps7+WGMyudS0CPSf5p4ZzUOnS4EDAwMcLhYch
         SD7g==
X-Gm-Message-State: AOAM5310FQoNSNnAfvF7BLOsRQ+X5CdeNuH3RJ1pJCgaVtbeEodeQ3TG
        vbLsxfDYUHnIuslzmYoWAetpBZN/
X-Google-Smtp-Source: ABdhPJyO+w0HBiEzqfRNFqWFAjyLUpISZ9zKyiEOCRhCmyS9AmC4eBitlltoelxlr5SRAGfnZKpe8g==
X-Received: by 2002:a17:902:6194:: with SMTP id u20mr58629926plj.333.1594346260530;
        Thu, 09 Jul 2020 18:57:40 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (220-245-19-62.static.tpgi.com.au. [220.245.19.62])
        by smtp.gmail.com with ESMTPSA id 7sm3912834pgw.85.2020.07.09.18.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 18:57:40 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-arch@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [RFC PATCH 7/7] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Fri, 10 Jul 2020 11:56:46 +1000
Message-Id: <20200710015646.2020871-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200710015646.2020871-1-npiggin@gmail.com>
References: <20200710015646.2020871-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On big systems, the mm refcount can become highly contented when doing
a lot of context switching with threaded applications (particularly
switching between the idle thread and an application thread).

Abandoning lazy tlb slows switching down quite a bit in the important
user->idle->user cases, so so instead implement a non-refcounted scheme
that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
any remaining lazy ones.

On a 16-socket 192-core POWER8 system, a context switching benchmark
with as many software threads as CPUs (so each switch will go in and
out of idle), upstream can achieve a rate of about 1 million context
switches per second. After this patch it goes up to 118 million.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig             | 16 ++++++++++++++++
 arch/powerpc/Kconfig     |  1 +
 include/linux/sched/mm.h |  6 +++---
 kernel/fork.c            | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2daf8fe6146a..edf69437a971 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -418,6 +418,22 @@ config MMU_LAZY_TLB
 	help
 	  Enable "lazy TLB" mmu context switching for kernel threads.
 
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+	depends on MMU_LAZY_TLB
+	depends on !MMU_LAZY_TLB_SHOOTDOWN
+
+config MMU_LAZY_TLB_SHOOTDOWN
+	bool
+	depends on MMU_LAZY_TLB
+	help
+	  Instead of refcounting the "lazy tlb" mm struct, which can cause
+	  contention with multi-threaded apps on large multiprocessor systems,
+	  this option causes __mmdrop to IPI all CPUs in the mm_cpumask and
+	  switch to init_mm if they were using the to-be-freed mm as the lazy
+	  tlb. Architectures which do not track all possible lazy tlb CPUs in
+	  mm_cpumask can not use this (without modification).
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 920c4e3ca4ef..24ac85c868db 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -225,6 +225,7 @@ config PPC
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE
 	select MMU_GATHER_PAGE_SIZE
+	select MMU_LAZY_TLB_SHOOTDOWN
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 2c2b20e2ccc7..1067af8039bd 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -53,19 +53,19 @@ void mmdrop(struct mm_struct *mm);
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmgrab(mm);
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmdrop(mm);
 }
 
 static inline void mmdrop_lazy_tlb_smp_mb(struct mm_struct *mm)
 {
-	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB))
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmdrop(mm); /* This depends on mmdrop providing a full smp_mb() */
 	else
 		smp_mb();
diff --git a/kernel/fork.c b/kernel/fork.c
index 142b23645d82..da0fba9e6079 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -685,6 +685,40 @@ static void check_mm(struct mm_struct *mm)
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
+static void do_shoot_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	if (current->active_mm == mm) {
+		BUG_ON(current->mm);
+		switch_mm(mm, &init_mm, current);
+		current->active_mm = &init_mm;
+	}
+}
+
+static void do_check_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	BUG_ON(current->active_mm == mm);
+}
+
+static void shoot_lazy_tlbs(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
+		smp_call_function_many(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1);
+		do_shoot_lazy_tlb(mm);
+	}
+}
+
+static void check_lazy_tlbs(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_DEBUG_VM)) {
+		smp_call_function(do_check_lazy_tlb, (void *)mm, 1);
+		do_check_lazy_tlb(mm);
+	}
+}
+
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -695,6 +729,11 @@ void __mmdrop(struct mm_struct *mm)
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
 	WARN_ON_ONCE(mm == current->active_mm);
+
+	/* Ensure no CPUs are using this as their lazy tlb mm */
+	shoot_lazy_tlbs(mm);
+	check_lazy_tlbs(mm);
+
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
-- 
2.23.0

