Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7558A396D49
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jun 2021 08:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhFAGZH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Jun 2021 02:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhFAGZF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Jun 2021 02:25:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114B2C06175F;
        Mon, 31 May 2021 23:23:24 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e7so4241435plj.7;
        Mon, 31 May 2021 23:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7SY6QzuWUSlWj33T26/GRZSVwi+Ld4IHiibBoCb52p4=;
        b=ePlorr20RYdU83BpwKX/s0RfyvSJGLZuiSfUt1Q5Tf+Uj6s0wJkGx8MFmTlzTq06Ly
         /QdSin1Qqs2l0J37C68YVuBoCY22xVUnKkbWT5c/25xPZUE4hwRl5CveuKHLOW9KwoLz
         WMUnhDGfB+gMrKJPdIvTLtMDs5EgLCysNJyB17ago3WfOtWSwQRzdwE9GUfx+u24xoXb
         YvUh+XKO7EACTncuCcfNhm9MUjn8I6F0IEFKp7B02dAPD0YE4xz1HbQBw17+5uziSWyH
         6Hbt03PuVPQDsas/U9JfW6GikTKlAqSmRjtpSQ956IQanhxIOkALHMsFIlrry/0xO4L8
         Jh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7SY6QzuWUSlWj33T26/GRZSVwi+Ld4IHiibBoCb52p4=;
        b=FszMTsbjZf9sRRvnOKTdBb3sMsCMM1OUoRCJBgaY+wRshGR6tplPA1+2GpsFuBR+x0
         bLHaMYNFHtTpNs0FH2I+RDDRqQq6OohlAfJGAIs2vm7f/mKUKil7Ih77SvSuAaXAGvae
         CynEOScc2XprzwkbThw1uWJikyXVvnGvMhBwtnVwcI3lF1e7ToPU6uF3ysPxLQaFQZmy
         2hIQDG2BNI+UtlTe+mUyumGnH5e/EQo5Z6pfh+RlNnWj6GcAAZbsjgb6p+A2Xckp99Dq
         218KsYthVpNY3qN8fltYpxj6nrU5FeaB5e/wvMfoVuF9y/vjkAUhrgZlCNFOJpiM907b
         Ju8A==
X-Gm-Message-State: AOAM532Swguts18l4s/0CkOM/ttU2iMI1lkEau1dgl2m+jJgG8D98fxJ
        gDMRmgYWECgeNsPSivxyi3Q=
X-Google-Smtp-Source: ABdhPJw09TNZqBmKx3WQDrsKTZlhlpstv4mz2E1lJZnWicTzFCQBo5ZLvZlMnKhALwZzNq6+juRuaA==
X-Received: by 2002:a17:90a:5106:: with SMTP id t6mr3315886pjh.216.1622528603683;
        Mon, 31 May 2021 23:23:23 -0700 (PDT)
Received: from bobo.ibm.com (60-241-69-122.static.tpgi.com.au. [60.241.69.122])
        by smtp.gmail.com with ESMTPSA id h1sm12519100pfh.72.2021.05.31.23.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:23:23 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v3 3/4] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Tue,  1 Jun 2021 16:23:02 +1000
Message-Id: <20210601062303.3932513-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210601062303.3932513-1-npiggin@gmail.com>
References: <20210601062303.3932513-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On big systems, the mm refcount can become highly contented when doing
a lot of context switching with threaded applications (particularly
switching between the idle thread and an application thread).

Abandoning lazy tlb slows switching down quite a bit in the important
user->idle->user cases, so instead implement a non-refcounted scheme
that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
any remaining lazy ones.

Shootdown IPIs are some concern, but they have not been observed to be
a big problem with this scheme (the powerpc implementation generated
314 additional interrupts on a 144 CPU system during a kernel compile).
There are a number of strategies that could be employed to reduce IPIs
if they turn out to be a problem for some workload.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig  | 14 +++++++++++++-
 kernel/fork.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 276e1c1c0219..91e1882e3284 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -439,11 +439,23 @@ config NO_MMU_LAZY_TLB
 	def_bool n
 
 # Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
-# For now, this must be enabled if MMU_LAZY_TLB is enabled.
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
 	depends on MMU_LAZY_TLB
 
+# Instead of refcounting the lazy mm struct for kernel thread references
+# (which can cause contention with multi-threaded apps on large multiprocessor
+# systems), this option causes __mmdrop to IPI all CPUs in the mm_cpumask and
+# switch to init_mm if they were using the to-be-freed mm as the lazy tlb. To
+# implement this, architectures must use _lazy_tlb variants of mm refcounting
+# when releasing kernel thread mm references, and mm_cpumask must include at
+# least all possible CPUs in which the mm might be lazy, at the time of the
+# final mmdrop. mmgrab/mmdrop in arch/ code must be switched to _lazy_tlb
+# postfix as necessary.
+config MMU_LAZY_TLB_SHOOTDOWN
+	bool
+	depends on MMU_LAZY_TLB
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/kernel/fork.c b/kernel/fork.c
index dc06afd725cb..d485c24426a0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -674,6 +674,53 @@ static void check_mm(struct mm_struct *mm)
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
+static void do_shoot_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	if (current->active_mm == mm) {
+		WARN_ON_ONCE(current->mm);
+		current->active_mm = &init_mm;
+		switch_mm(mm, &init_mm, current);
+	}
+}
+
+static void do_check_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	WARN_ON_ONCE(current->active_mm == mm);
+}
+
+static void shoot_lazy_tlbs(struct mm_struct *mm)
+{
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
+		/*
+		 * IPI overheads have not found to be expensive, but they could
+		 * be reduced in a number of possible ways, for example (in
+		 * roughly increasing order of complexity):
+		 * - A batch of mms requiring IPIs could be gathered and freed
+		 *   at once.
+		 * - CPUs could store their active mm somewhere that can be
+		 *   remotely checked without a lock, to filter out
+		 *   false-positives in the cpumask.
+		 * - After mm_users or mm_count reaches zero, switching away
+		 *   from the mm could clear mm_cpumask to reduce some IPIs
+		 *   (some batching or delaying would help).
+		 * - A delayed freeing and RCU-like quiescing sequence based on
+		 *   mm switching to avoid IPIs completely.
+		 */
+		on_each_cpu_mask(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1);
+		if (IS_ENABLED(CONFIG_DEBUG_VM))
+			on_each_cpu(do_check_lazy_tlb, (void *)mm, 1);
+	} else {
+		/*
+		 * In this case, lazy tlb mms are refounted and would not reach
+		 * __mmdrop until all CPUs have switched away and mmdrop()ed.
+		 */
+	}
+}
+
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -683,7 +730,12 @@ void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
+
+	/* Ensure no CPUs are using this as their lazy tlb mm */
+	shoot_lazy_tlbs(mm);
+
 	WARN_ON_ONCE(mm == current->active_mm);
+
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
-- 
2.23.0

