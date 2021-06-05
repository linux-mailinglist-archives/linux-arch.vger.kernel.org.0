Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4677F39C4DC
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jun 2021 03:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhFEBoj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 21:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFEBoi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 21:44:38 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3ABC061766;
        Fri,  4 Jun 2021 18:42:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u18so8679052pfk.11;
        Fri, 04 Jun 2021 18:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o79xAv8VGlL9P0cnIMgEnd0kABY+0aVXPPf79qRUn38=;
        b=EfkqsrLHsB7OMvz7oioK9BBbvfX//VN0Qw/rqIoO6VTLg+nNlnZ/KwQq3Ak+aOlAJ3
         4S1x1y+m8CXRSw/uKOh3GHNLGFovqdRQUIFX0Dcq6pC7OE+yBjpBJpGqqn+CRcKbBPAY
         4mnCAWNE1DNFy3YE0B8updP/ljldtNDies0KZ25LEesppi4qXSwnW2uLmd/t/dWRN9Ia
         Jk1T9dWv2C5leuoyrJr5BQMj4Z9qUj/tleWND28vrxEqsj8DZ2aXJfQL9kYMwI7CfeIl
         Yzl9twL/atYxeXecU4ZgZwgwq00za2QJ/RHuxgZxyIRXUCMIvtLRYq7hcluVMYREzs8J
         MBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o79xAv8VGlL9P0cnIMgEnd0kABY+0aVXPPf79qRUn38=;
        b=PnahaKcrrv2rR06xg6FBMeig/eOiptRSFNUF88ODC7wCqnhX8P77UJsk8RwJHeXxWK
         2pzh8h7c8MrLWszuVrG9qps3lqZAb9tXEI2mhuEYgEYiHr22BhTYeJZxFRAdCSfyxbD6
         s0ePgDdn0V+uH4RM6VTQOGE4A1zuSxdBymmtAnDQSpPmYALz0+FdyLVtQsrQC69KZjPm
         k8rAhXchaW9VTWDSs2X0zQA+Qy+tDgFdUwErBzsuzfDge/XXMvx8zne5z4teTp7Gl53d
         vcnC6+EPDrgrp7E5flk5/YnLyaNrOIYVHkt4ji8+5A1f9If5uCeTJt6PM6H1lwS5qa7n
         8QVA==
X-Gm-Message-State: AOAM530jP1y/nLfYuOg6Gd+xCvakHyOwKtFNlR/1BSeOieQ6kYgROQRW
        xVMQW27eTrmcBZG4SiE+xCU=
X-Google-Smtp-Source: ABdhPJxId09rwktS+wz23oEw5BLQX2VX0E1Io1PESo6MYBadnFs6NbNcFmDkmt3wim2iUcQ6z1nzfw==
X-Received: by 2002:a63:1626:: with SMTP id w38mr7676348pgl.420.1622857358356;
        Fri, 04 Jun 2021 18:42:38 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id q68sm5779056pjq.45.2021.06.04.18.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:42:38 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v4 3/4] lazy tlb: shoot lazies, a non-refcounting lazy tlb option
Date:   Sat,  5 Jun 2021 11:42:15 +1000
Message-Id: <20210605014216.446867-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210605014216.446867-1-npiggin@gmail.com>
References: <20210605014216.446867-1-npiggin@gmail.com>
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
 arch/Kconfig  | 13 +++++++++++++
 kernel/fork.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 1cff045cdde6..f8136c893991 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -421,6 +421,19 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 # Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
 config MMU_LAZY_TLB_REFCOUNT
 	def_bool y
+	depends on !MMU_LAZY_TLB_SHOOTDOWN
+
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
 
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
diff --git a/kernel/fork.c b/kernel/fork.c
index dc06afd725cb..8085ff33c7f6 100644
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
@@ -683,6 +730,10 @@ void __mmdrop(struct mm_struct *mm)
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

