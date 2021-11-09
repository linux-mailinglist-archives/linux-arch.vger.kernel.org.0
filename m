Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD7C44A5A9
	for <lists+linux-arch@lfdr.de>; Tue,  9 Nov 2021 05:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbhKIEOc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Nov 2021 23:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhKIEOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Nov 2021 23:14:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF3C061766;
        Mon,  8 Nov 2021 20:11:38 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so18580163plf.3;
        Mon, 08 Nov 2021 20:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mQV34cqT+5uDm9EJBkW1FMD8FZHvkjExjjx6fGh4VcI=;
        b=PuGtZqMwxMh0+H4n4RjIwW9lQofP3rBqYcZPzRlmtg5myURTIFMdz51vwCAFrIbqY8
         QPh0UD2hNz9wrRQZtP461Drmx2InZpT9Z6tCBquaDFXKfprTLzqTd5wcOzR+2zRS8p27
         NtjExZPcjGXr2nVKJ/oL9pDh7WJhtaLZHZRzNmlU5Z2WxfD727+G/cM/rCQlODspu9BT
         j+ecvhrqXbqaoZtab0vhJVfZx0HESqUL/bRGppziK98CuBRmw6Ym6KfBNEjO1Ay3QUCz
         nTlWCwZURw33CEcBEtBQFUsKHi8ZpypiTGVVXHaE5N0mSSMVvWiNR/hTEKzV+DS0VFe6
         8lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQV34cqT+5uDm9EJBkW1FMD8FZHvkjExjjx6fGh4VcI=;
        b=y4x6MRZZR49S+8HphxVazzQW8bjCgS0lGDybcCjA2U5Hz+3AXATJcb/iM01HbEF05L
         I2vup1WKcq6+mAn7yyEFw0HgmpxQ0hDaPGz++op7KyXQnYWR6MRwPgTR5iGBM7EjM5N6
         Hfl3846ZKaZqDBW4pyuwaMAhJtAsbV+pKJSLFtwoZPrkV9HnVJPrQh6e9vi36ga5dT+q
         6fao82/uUMR6HvqiquGPCkm9u/BF2YiWQjyeojgWAieOaRpFBEYxNG8+k1iCyUnbTqbA
         os2aHRB92BglZhselOY7CJ/36quYr/ITbUT/mB/AiQnkxzwVYawxi5gM4RVzcS4pr/A/
         dpsQ==
X-Gm-Message-State: AOAM530ApvCxSF6svtyQlS5AyMZ0C5tke16W4UEAEjDtV5e9DKLNuO57
        89QZDE0Jc8Y2b3zYCFiT1Xk=
X-Google-Smtp-Source: ABdhPJwDNNVbeTXijVR6cgCKYSwC1U11bBHeS8R6qI10SX3+oy3npTCbjjCi57dE0IP/EzyNCeXUhw==
X-Received: by 2002:a17:90b:4a89:: with SMTP id lp9mr3951797pjb.6.1636431097931;
        Mon, 08 Nov 2021 20:11:37 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id o19sm18278063pfu.56.2021.11.08.20.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 20:11:37 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/4] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Tue,  9 Nov 2021 14:11:18 +1000
Message-Id: <20211109041119.1972927-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211109041119.1972927-1-npiggin@gmail.com>
References: <20211109041119.1972927-1-npiggin@gmail.com>
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
 arch/Kconfig  | 15 +++++++++++++++
 kernel/fork.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 73d98edc5cdc..2b70a9e7b142 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -444,6 +444,21 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 # already).
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
+	depends on !MMU_LAZY_TLB_SHOOTDOWN
+
+# This option allows MMU_LAZY_TLB_REFCOUNT=n. It ensures no CPUs are using an
+# mm as a lazy tlb beyond its last reference count, by shooting down these
+# users before the mm is deallocated. __mmdrop() first IPIs all CPUs that may
+# be using the mm as a lazy tlb, so that they may switch themselves to using
+# init_mm for their active mm. mm_cpumask(mm) is used to determine which CPUs
+# may be using mm as a lazy tlb mm.
+#
+# To implement this, an arch *must*:
+# - At the time of the final mmdrop of the mm, ensure mm_cpumask(mm) contains
+#   at least all possible CPUs in which the mm is lazy.
+# - It must meet the requirements for MMU_LAZY_TLB_REFCOUNT=n (see above).
+config MMU_LAZY_TLB_SHOOTDOWN
+	bool
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..a7da9b0bc402 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -686,6 +686,53 @@ static void check_mm(struct mm_struct *mm)
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
@@ -695,6 +742,10 @@ void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
+
+	/* Ensure no CPUs are using this as their lazy tlb mm */
+	shoot_lazy_tlbs(mm);
+
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
-- 
2.23.0

