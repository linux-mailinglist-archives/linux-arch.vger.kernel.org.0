Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA15671672
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jan 2023 09:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjARIp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Jan 2023 03:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjARIp3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Jan 2023 03:45:29 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A6A90849
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:35 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id z13so8301281plg.6
        for <linux-arch@vger.kernel.org>; Wed, 18 Jan 2023 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqIE8OQntd0W4a4N2kg2lnLwGGF3XcgL5F+Chwm9T4Q=;
        b=KfdJtVwV3zcqhh5famP1bouR06n0PTfilksZbm1hFiESF1H43nvbTHW7Mb75MaGACp
         zxfqqjGqGn88kJjs1uiSW/iHLDh4mIVynPbPCrU6IgmQSUDMRtetaS50F04kKSoGNz9g
         WONXHWze2mU/V3dtxmyHdPzr4FeUSFZg7tJTmveXFrYiPNYRsjHJbd3hg7AjrtA34J5h
         Io7y9+STzomQq1Rz0BArK9zI6oqFyEPUifvhz+IyNLNv5/K9JJDuVyedlkHTRoqirdGz
         Tca1XzhJjeMflbybvMkbUbVUj9LNEmaXTfCe9fq/YPFk+TQN1MRX0mvIM+RvTMI7GgXY
         1JAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqIE8OQntd0W4a4N2kg2lnLwGGF3XcgL5F+Chwm9T4Q=;
        b=trv9g6thY5MMGRoN4heiM67z9YArHdQ2PpWQd7lW0w/8OmQO3vKJH03fOfQyGK1dC5
         qptdattPOOwuDxHNV5wdTLz4WQ2dGFkUL3jZRSVemvzRQ4VsyxSYOWzEuS8cj5QuNado
         35BnMNliYBVQ6DTj1bFVA9WXApCNT7AKMm/wAfpI9Wq+2zT1pKmPkfd2tPpL+wg4IWvs
         RGYE+CJxxO3HP5OZNtjCySeSMoin59RzqaVPLakk3S1He60woObH5Kw9vkOyh6TehHFp
         LYdFrYssSLEOifJG+lpZxOanVWMv4U9Ioq1+pI9uP+A9S5+wjH4C8gpfNMoS2oKWxid1
         gf4A==
X-Gm-Message-State: AFqh2krU9rxq9SpMV+BR1C/WHB5iQXn/AWfHMu2qlSTPFOxS0gPCpL99
        BLQcCwla8ZD5th+OfOT2Fvk=
X-Google-Smtp-Source: AMrXdXsdbUkyarSYAzgpmXfctJIjd4K16TFeyd7Cq4zYvGF3a+5S7WArti19aUKfPU+yLC30TT4/9Q==
X-Received: by 2002:a17:90a:4606:b0:226:620b:6ae5 with SMTP id w6-20020a17090a460600b00226620b6ae5mr5974187pjg.22.1674028834284;
        Wed, 18 Jan 2023 00:00:34 -0800 (PST)
Received: from bobo.ibm.com (193-116-102-45.tpgi.com.au. [193.116.102.45])
        by smtp.gmail.com with ESMTPSA id y2-20020a17090a16c200b002272616d3e1sm738462pje.40.2023.01.18.00.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 00:00:33 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v6 3/5] lazy tlb: shoot lazies, non-refcounting lazy tlb mm reference handling scheme
Date:   Wed, 18 Jan 2023 18:00:09 +1000
Message-Id: <20230118080011.2258375-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230118080011.2258375-1-npiggin@gmail.com>
References: <20230118080011.2258375-1-npiggin@gmail.com>
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

On big systems, the mm refcount can become highly contented when doing
a lot of context switching with threaded applications (particularly
switching between the idle thread and an application thread).

Abandoning lazy tlb slows switching down quite a bit in the important
user->idle->user cases, so instead implement a non-refcounted scheme
that causes __mmdrop() to IPI all CPUs in the mm_cpumask and shoot down
any remaining lazy ones.

Shootdown IPIs cost could be an issue, but they have not been observed
to be a serious problem with this scheme, because short-lived processes
tend not to migrate CPUs much, therefore they don't get much chance to
leave lazy tlb mm references on remote CPUs. There are a lot of options
to reduce them if necessary.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig  | 15 ++++++++++++
 kernel/fork.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index b07d36f08fea..f7da34e4bc62 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -481,6 +481,21 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
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
index 9f7fe3541897..263660e78c2a 100644
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
+	 * Lazy TLB shootdown does not refcount "lazy tlb mm" usage, rather it
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
+	if (IS_ENABLED(CONFIG_DEBUG_VM))
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
-- 
2.37.2

