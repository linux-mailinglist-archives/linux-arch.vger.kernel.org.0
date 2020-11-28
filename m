Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C9A2C72AF
	for <lists+linux-arch@lfdr.de>; Sat, 28 Nov 2020 23:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgK1VuP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 28 Nov 2020 16:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730178AbgK1SiF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 28 Nov 2020 13:38:05 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6F2C0258F4;
        Sat, 28 Nov 2020 08:02:19 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id k11so6743747pgq.2;
        Sat, 28 Nov 2020 08:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65OkZBDz2HAL7Su3DQky7EvOLeinu5tb1gf0ETLWceY=;
        b=u/jtzknFAd1tAacYeJoy/46zj5ChdFT3xU8MZDR6BV1HUVh/2VSorfp/+xqvPHsPkn
         A5kWjznZ0r5vU8waxfe1mqVhtjhfYM+MaOz88K1WoNyQZyYjMWkiGLgwLA3xK3WSa6Gq
         FrlTNGIlqHWCl/be5jqC8aVx2VyfAfrUaer6LZ0ZQ/nNbXgJa/VHWb+e2mFD1wW/jxDa
         IfrRS5GIsGLweCb8HbxwZksrk0lJRMKAEcFqCQtSF2EBIi7qeHLU8MfKOOiNLtDuaQj9
         FYq964XIIM+e/xk1kgqKRlfVu9uv/c3RzDRXUBD5Oi2Uu4QAgEoknC8D/6A6B7cDDFbc
         ZOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65OkZBDz2HAL7Su3DQky7EvOLeinu5tb1gf0ETLWceY=;
        b=fywcnwGNuSGoBmm8r6woiizBRiZnVeS5MW0nB2HaLJsQAKwppQe7USHzMeYwd6Isep
         Hzw40ojhHMya1LYFoL+huTV0BwaWaUX3MHkZY92X4ERAhrFSHOvXBekCPa1LTLSOKu4t
         N0qTkyJhRo7zsvc+er89RqIfv1zGKJhLFbUogZzIBQpKx4O3COzjUAd8y+CcEmVDI+tH
         fTAfG3zjCTgIsGMkzOiAnQPfGC6HjwpNl/DRGqLi7aomqMg7I3lzbBvpwa0tkGkqcNIE
         yGoDoe+8CC2pe5FW3A1t1XS7YfVp0mRMyTEt5lt8H9JmKr9sXf9BUCAl0VRZVHU9H21j
         Md3A==
X-Gm-Message-State: AOAM530x0jL/zpcnX9vSFq46WlYli7l7QirXnvyYIDJOhw0uvM/UwrzN
        jm99vRov4gwAwtkQTdTtE+rVzhSFAgg=
X-Google-Smtp-Source: ABdhPJwsxob0WXTuSWwVF1+ay5qDAtrGlbPGBtoVsiaD1Lu41q7ZrRVVVOcfY+0p8Z91jyXmyn1W1w==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr6227490pjb.129.1606579338854;
        Sat, 28 Nov 2020 08:02:18 -0800 (PST)
Received: from bobo.ibm.com (193-116-103-132.tpgi.com.au. [193.116.103.132])
        by smtp.gmail.com with ESMTPSA id d4sm9762607pjz.28.2020.11.28.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 08:02:17 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Anton Blanchard <anton@ozlabs.org>
Subject: [PATCH 6/8] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Sun, 29 Nov 2020 02:01:39 +1000
Message-Id: <20201128160141.1003903-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201128160141.1003903-1-npiggin@gmail.com>
References: <20201128160141.1003903-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Shootdown IPIs are some concern, but they have not been observed to be
a big problem with this scheme (the powerpc implementation generated
314 additional interrupts on a 144 CPU system during a kernel compile).
There are a number of strategies that could be employed to reduce IPIs
if they turn out to be a problem for some workload.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig  | 13 +++++++++++++
 kernel/fork.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 596bf589d74b..540e43aeefa4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -440,6 +440,19 @@ config MMU_LAZY_TLB
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
 	depends on MMU_LAZY_TLB
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
+	  tlb. To implement this, architectures must use _lazy_tlb variants of
+	  mm refcounting, and mm_cpumask must include at least all possible
+	  CPUs in which mm might be lazy.
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
diff --git a/kernel/fork.c b/kernel/fork.c
index 6d266388d380..e47312c2b48b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -669,6 +669,54 @@ static void check_mm(struct mm_struct *mm)
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
+		exit_lazy_tlb(mm, current);
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
@@ -678,7 +726,12 @@ void __mmdrop(struct mm_struct *mm)
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

