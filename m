Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA822D9371
	for <lists+linux-arch@lfdr.de>; Mon, 14 Dec 2020 08:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407165AbgLNHCN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Dec 2020 02:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407132AbgLNHCH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Dec 2020 02:02:07 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAFCC0613D6;
        Sun, 13 Dec 2020 23:01:27 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id m5so6060163pjv.5;
        Sun, 13 Dec 2020 23:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ErbENPowD2FhE1fb1KE1SS0KG3DGxAufvlmv8VFmkMA=;
        b=JvZByPsEXrHdPtVKtHVHGjkSpux7toHopC3Q55F7zTqqwwZ5PHppHHXxc6aXSO6GKB
         oyfie9gW09mQYPvCRKvx9HMxCB/osCbn29u7jDRUFzqv5IiRSR77KNbem7qfl7TQ7VUq
         C9p49cwE2Z6FNPa8ejWQnty9JN4XxkoGCm7S49R9NFlkO1txIrWjl5Z0FzqZO3U9viux
         06U/I73Dqc+hEzgAZKfCwyUDsCgR7/YUn5DN4UjjGictkGOGay7x42N+o++kqKFggq9l
         nEnjpbRT8HjzsjpOspZdyeyToedAZplx5wUK8CINpXTu1fCREsOLVQFWrEo8h2bLGOKx
         zZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ErbENPowD2FhE1fb1KE1SS0KG3DGxAufvlmv8VFmkMA=;
        b=ChQnzpZzNIl+t2RtLWzFLXJPl6N5BVY5pzOOpyAm7sEKWXC7ZYYbPVlgEazSLayMnc
         bz6ebbizveWpUbPwZ2gG6uASB3hXYtDl1Pk4kCwLqReZqFhwiX6yJFiMqRy3ilDoxUrY
         HUGsdbSu0Bs9YphB6jX8X7E46ocjBmm771PVPxHcEJFqDuKPGWzaUo9fQO8/2em2k8k0
         BqkaqnpntHd0Lzv1Klm++/UWkjNqxjt/UrslzpJDzvGZ6dBjPsTuS6K0icWoNS7TrD/h
         WTpyI6m8+OxMDdBbkrLlhdne2xkEsBYmg2M3VZFhmWWNzQb4HGrL9DVDDEp2ehF4LuhV
         pfbw==
X-Gm-Message-State: AOAM530JYihhvR4pgE0LozcQNIqM6fGhZUSAuhAactqMpONUZWg3rcEH
        gvmLf28K9QTJRqaIiP9KCw97YflYKig=
X-Google-Smtp-Source: ABdhPJxblJXiLKkz13t9MjdDE/WHdnRvcf7rwmiGCqMnrUDtgxWEAmDxtkk08GCN+5bnN8Huo5IieQ==
X-Received: by 2002:a17:902:b415:b029:d6:ec35:755b with SMTP id x21-20020a170902b415b02900d6ec35755bmr21304417plr.47.1607929286389;
        Sun, 13 Dec 2020 23:01:26 -0800 (PST)
Received: from bobo.ozlabs.ibm.com ([220.240.228.148])
        by smtp.gmail.com with ESMTPSA id 84sm19570018pfy.9.2020.12.13.23.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Dec 2020 23:01:26 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 3/5] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Mon, 14 Dec 2020 16:53:10 +1000
Message-Id: <20201214065312.270062-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20201214065312.270062-1-npiggin@gmail.com>
References: <20201214065312.270062-1-npiggin@gmail.com>
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
 arch/Kconfig  | 17 +++++++++++++++--
 kernel/fork.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 84faaba66364..e69c974369cc 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -443,9 +443,22 @@ config MMU_LAZY_TLB
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
 	depends on MMU_LAZY_TLB
+	depends on !MMU_LAZY_TLB_SHOOTDOWN
 	help
-	  This must be enabled if MMU_LAZY_TLB is enabled until the next
-	  patch.
+	  This refcounts the mm that is used as the lazy TLB mm when switching
+	  switching to a kernel thread.
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
index 6d266388d380..74b972d2d8a9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -669,6 +669,53 @@ static void check_mm(struct mm_struct *mm)
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
@@ -678,7 +725,12 @@ void __mmdrop(struct mm_struct *mm)
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

