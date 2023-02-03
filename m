Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E692B6890AC
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjBCHTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjBCHTb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:19:31 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F24C928F9
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 23:19:17 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so8024569pjq.0
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 23:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISWO9h6SOLQP6WCeahRDXPdJymqgjLrbpJ6FMzUJXpQ=;
        b=GCqfd0gisgkgKlxYZuLHUdcwKWxDsZidEXcZ1aNaZZ2ElupC8rz5g3nIkJ3bobpmqi
         DprWpFD65mlWDpzUu/unAkIGKL37dle+6bCw2lSx+pZmmhDM758k0n8nOhE+ohbJrWlG
         nnQ2rVqpFtFDnzZ9uApSYB6/eFyeFbXLHLC1IdotvCqzph/BPkikJi0WfNZA9G0CsEND
         hYHG9zGzwoF31aJ8l6S4dqlVqQzy8grON+LE2Meicn20ZhPs4l0HXU0uHvm0k+HFrdBm
         AlnDrtDXEIMMr2ZDtrtaE7KDDPGpuU2KJd9TLaiqM1heX5H+w6emkvg9SMXCTv+a9luZ
         bBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISWO9h6SOLQP6WCeahRDXPdJymqgjLrbpJ6FMzUJXpQ=;
        b=MXppSbUwchM7EVPGJpkuJwPal7OXfoA3s+SgDuLJQ3DLLbEYUx45JOQjclChptiNE7
         xPj0zBfPKvCZqZgZphtw76gqfHpZ/Ny3cGAfyfPufMK8nxt9ZHc3PQunUv5FnlFCaHKl
         QRbFjGHiDaJtG/58gyBMKTD5QxDBeEoTAiP5limBhy62OQBFWtsM/YSjKJDxiHfFn/LB
         NPPI5OlPRgaiAQ696iM02sO3fHrRKKYThN3zFNLyppCA8WxMFH09yLXlynecOwe+6GJR
         xrNbVtQz3BLkQBAqHYXDlwz+hvj/nPSydyS7v6qbhUoJh7TSspYuzELcUi5kWVsf4zkp
         8loA==
X-Gm-Message-State: AO0yUKWMBqmbMphQhe2GfeidnGgGOfSWzCICMifLcGzgZZcQKDDgAxKa
        Ahd7KpC51mlaSNuASxUPJkU=
X-Google-Smtp-Source: AK7set+asp6Wk4F7oZN8F9+ScVFgiV4xOvEyfkj0CJUO9gvbWyyWzAGztHv22zCvJ0UaYCbOJNjkVQ==
X-Received: by 2002:a05:6a20:6909:b0:b6:b6a6:9753 with SMTP id q9-20020a056a20690900b000b6b6a69753mr11785825pzj.8.1675408756632;
        Thu, 02 Feb 2023 23:19:16 -0800 (PST)
Received: from bobo.ibm.com (193-116-117-77.tpgi.com.au. [193.116.117.77])
        by smtp.gmail.com with ESMTPSA id f20-20020a637554000000b004df4ba1ebfesm877558pgn.66.2023.02.02.23.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:19:16 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Rik van Riel <riel@redhat.com>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 4/5] lazy tlb: shoot lazies, non-refcounting lazy tlb mm reference handling scheme
Date:   Fri,  3 Feb 2023 17:18:36 +1000
Message-Id: <20230203071837.1136453-5-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230203071837.1136453-1-npiggin@gmail.com>
References: <20230203071837.1136453-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On big systems, the mm refcount can become highly contented when doing a
lot of context switching with threaded applications. user<->idle switch
is one of the important cases. Abandoning lazy tlb entirely slows this
switching down quite a bit in the common uncontended case, so that is
not viable.

Implement a scheme where lazy tlb mm references do not contribute to the
refcount, instead they get explicitly removed when the refcount reaches
zero.

The final mmdrop() sends IPIs to all CPUs in the mm_cpumask and they
switch away from this mm to init_mm if it was being used as the lazy tlb
mm. Enabling the shoot lazies option therefore requires that the arch
ensures that mm_cpumask contains all CPUs that could possibly be using
mm. A DEBUG_VM option IPIs every CPU in the system after this to ensure
there are no references remaining before the mm is freed.

Shootdown IPIs cost could be an issue, but they have not been observed
to be a serious problem with this scheme, because short-lived processes
tend not to migrate CPUs much, therefore they don't get much chance to
leave lazy tlb mm references on remote CPUs. There are a lot of options
to reduce them if necessary, described in comments.

The near-worst-case can be benchmarked with will-it-scale:

  context_switch1_threads -t $(($(nproc) / 2))

This will create nproc threads (nproc / 2 switching pairs) all sharing
the same mm that spread over all CPUs so each CPU does
thread->idle->thread switching.

[ Rik came up with basically the same idea a few years ago, so credit
  to him for that. ]

Link: https://lore.kernel.org/linux-mm/20230118080011.2258375-1-npiggin@gmail.com/
Link: https://lore.kernel.org/all/20180728215357.3249-11-riel@surriel.com/
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig      | 15 +++++++++++
 kernel/fork.c     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig.debug | 10 ++++++++
 3 files changed, 90 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 11e8915c0652..0d2021aed57e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -481,6 +481,21 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 # converted already).
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
index 9f7fe3541897..e7d81db7e885 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -780,6 +780,67 @@ static void check_mm(struct mm_struct *mm)
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
+static void do_check_lazy_tlb(void *arg)
+{
+	struct mm_struct *mm = arg;
+
+	WARN_ON_ONCE(current->active_mm == mm);
+}
+
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
+static void cleanup_lazy_tlbs(struct mm_struct *mm)
+{
+	if (!IS_ENABLED(CONFIG_MMU_LAZY_TLB_SHOOTDOWN)) {
+		/*
+		 * In this case, lazy tlb mms are refounted and would not reach
+		 * __mmdrop until all CPUs have switched away and mmdrop()ed.
+		 */
+		return;
+	}
+
+	/*
+	 * Lazy mm shootdown does not refcount "lazy tlb mm" usage, rather it
+	 * requires lazy mm users to switch to another mm when the refcount
+	 * drops to zero, before the mm is freed. This requires IPIs here to
+	 * switch kernel threads to init_mm.
+	 *
+	 * archs that use IPIs to flush TLBs can piggy-back that lazy tlb mm
+	 * switch with the final userspace teardown TLB flush which leaves the
+	 * mm lazy on this CPU but no others, reducing the need for additional
+	 * IPIs here. There are cases where a final IPI is still required here,
+	 * such as the final mmdrop being performed on a different CPU than the
+	 * one exiting, or kernel threads using the mm when userspace exits.
+	 *
+	 * IPI overheads have not found to be expensive, but they could be
+	 * reduced in a number of possible ways, for example (roughly
+	 * increasing order of complexity):
+	 * - The last lazy reference created by exit_mm() could instead switch
+	 *   to init_mm, however it's probable this will run on the same CPU
+	 *   immediately afterwards, so this may not reduce IPIs much.
+	 * - A batch of mms requiring IPIs could be gathered and freed at once.
+	 * - CPUs store active_mm where it can be remotely checked without a
+	 *   lock, to filter out false-positives in the cpumask.
+	 * - After mm_users or mm_count reaches zero, switching away from the
+	 *   mm could clear mm_cpumask to reduce some IPIs, perhaps together
+	 *   with some batching or delaying of the final IPIs.
+	 * - A delayed freeing and RCU-like quiescing sequence based on mm
+	 *   switching to avoid IPIs completely.
+	 */
+	on_each_cpu_mask(mm_cpumask(mm), do_shoot_lazy_tlb, (void *)mm, 1);
+	if (IS_ENABLED(CONFIG_DEBUG_VM_SHOOT_LAZIES))
+		on_each_cpu(do_check_lazy_tlb, (void *)mm, 1);
+}
+
 /*
  * Called when the last reference to the mm
  * is dropped: either by a lazy thread or by
@@ -791,6 +852,10 @@ void __mmdrop(struct mm_struct *mm)
 
 	BUG_ON(mm == &init_mm);
 	WARN_ON_ONCE(mm == current->mm);
+
+	/* Ensure no CPUs are using this as their lazy tlb mm */
+	cleanup_lazy_tlbs(mm);
+
 	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 61a9425a311f..1a5849f9f414 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -852,6 +852,16 @@ config DEBUG_VM
 
 	  If unsure, say N.
 
+config DEBUG_VM_SHOOT_LAZIES
+	bool "Debug MMU_LAZY_TLB_SHOOTDOWN implementation"
+	depends on DEBUG_VM
+	depends on MMU_LAZY_TLB_SHOOTDOWN
+	help
+	  Enable additional IPIs that ensure lazy tlb mm references are removed
+	  before the mm is freed.
+
+	  If unsure, say N.
+
 config DEBUG_VM_MAPLE_TREE
 	bool "Debug VM maple trees"
 	depends on DEBUG_VM
-- 
2.37.2

