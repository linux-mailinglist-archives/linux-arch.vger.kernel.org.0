Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478846890AD
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 08:21:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbjBCHTc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 02:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbjBCHT3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 02:19:29 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901FB928FC
        for <linux-arch@vger.kernel.org>; Thu,  2 Feb 2023 23:19:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id jh15so4400422plb.8
        for <linux-arch@vger.kernel.org>; Thu, 02 Feb 2023 23:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUGCesZ+ECKfxuO6+UdvSldGg8VBbbvoIh7jdtjrlkU=;
        b=pLnnqDRIDYF0X+7odeq2MLz8sT29lO0h9nXJRzhqSWb2cKDmw+AjnJVXwKX4LO0+YN
         sy6TWCVWrrhdAqdi0Athmqz7hnxbv9sXhy7zHgw5JMbTMALz+lrRMnA7mhKMW0UOaN3X
         QCHhXYJFOAJf6mMzTg6U9SYCB0rngQkrXqgCC9sJi9COvb9A1wQ5Pk8YAxIHPyyrhAK8
         45tFQTFNKq2y3gE/ag6BjXudpVKSfK+TUTK3G6sll8axgwNiKP1UqpP4lrWqQnLzlWn0
         p2jjdVOgV/IsArGVMlzfnf1uVgzpoRPyeV1+V87NiHGnhmhY+aWACx4xhLz/DXOY+iS+
         dKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUGCesZ+ECKfxuO6+UdvSldGg8VBbbvoIh7jdtjrlkU=;
        b=INtQDGpkcYy2ybGDm9Byy9f6Txyq+NwT3w13GqX/RySudfUjiiM+N/b+yq5xJCsr/J
         lDddGHA100Sk+DVWZNv9dDKu+shbHFe0PqslKjQ6jl4o/Gf4Wi0FFwcwuVvIr9+eJmSO
         FEX2nAJgJnLMGSf5q7aJEfVdQJww8jYleWvoYh81q3KD319tvCsX+/Syq+NPgTq3ZnOx
         ADCcQ6iC+0C+Am9Bc8WSZYwV3satejHTL6n6ODMhYFs8ax/HWvwbh68uUAwcXDFyy2sb
         7EU4q03on/UtxsYF0boQjSQ7Y32O2nka/9NgtvxOjl0rUZF6nMktWZ/DI66rAQA8LVj+
         bkEQ==
X-Gm-Message-State: AO0yUKV4oPb9lc2vetBBDT1OPSsIwQuexHAeWBWsiJUQgB+mHXS3Ozsz
        WyuSrhhdqsGvhlrmydwYFM0=
X-Google-Smtp-Source: AK7set9Pa1+UA0tNLvIosl6qOQXe2T4uQwVT+pZWT/dLmS0GvpN8PpOxJcaipNBn1b+VrjOFZQErtw==
X-Received: by 2002:a05:6a21:78a9:b0:be:a944:b07f with SMTP id bf41-20020a056a2178a900b000bea944b07fmr12686834pzc.61.1675408751037;
        Thu, 02 Feb 2023 23:19:11 -0800 (PST)
Received: from bobo.ibm.com (193-116-117-77.tpgi.com.au. [193.116.117.77])
        by smtp.gmail.com with ESMTPSA id f20-20020a637554000000b004df4ba1ebfesm877558pgn.66.2023.02.02.23.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:19:10 -0800 (PST)
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
Subject: [PATCH v7 3/5] lazy tlb: allow lazy tlb mm refcounting to be configurable
Date:   Fri,  3 Feb 2023 17:18:35 +1000
Message-Id: <20230203071837.1136453-4-npiggin@gmail.com>
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

Add CONFIG_MMU_TLB_REFCOUNT which enables refcounting of the lazy tlb mm
when it is context switched. This can be disabled by architectures that
don't require this refcounting if they clean up lazy tlb mms when the
last refcount is dropped. Currently this is always enabled, so the patch
introduces no functional change.

Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 Documentation/mm/active_mm.rst |  6 ++++++
 arch/Kconfig                   | 17 +++++++++++++++++
 include/linux/sched/mm.h       | 18 +++++++++++++++---
 3 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/active_mm.rst b/Documentation/mm/active_mm.rst
index 6f8269c284ed..0114d80d406a 100644
--- a/Documentation/mm/active_mm.rst
+++ b/Documentation/mm/active_mm.rst
@@ -4,6 +4,12 @@
 Active MM
 =========
 
+Note, the mm_count refcount may no longer include the "lazy" users
+(running tasks with ->active_mm == mm && ->mm == NULL) on kernels
+with CONFIG_MMU_LAZY_TLB_REFCOUNT=n. Taking and releasing these lazy
+references must be done with mmgrab_lazy_tlb() and mmdrop_lazy_tlb()
+helpers, which abstract this config option.
+
 ::
 
  List:       linux-kernel
diff --git a/arch/Kconfig b/arch/Kconfig
index 12e3ddabac9d..11e8915c0652 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -465,6 +465,23 @@ config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
 	  irqs disabled over activate_mm. Architectures that do IPI based TLB
 	  shootdowns should enable this.
 
+# Use normal mm refcounting for MMU_LAZY_TLB kernel thread references.
+# MMU_LAZY_TLB_REFCOUNT=n can improve the scalability of context switching
+# to/from kernel threads when the same mm is running on a lot of CPUs (a large
+# multi-threaded application), by reducing contention on the mm refcount.
+#
+# This can be disabled if the architecture ensures no CPUs are using an mm as a
+# "lazy tlb" beyond its final refcount (i.e., by the time __mmdrop frees the mm
+# or its kernel page tables). This could be arranged by arch_exit_mmap(), or
+# final exit(2) TLB flush, for example.
+#
+# To implement this, an arch *must*:
+# Ensure the _lazy_tlb variants of mmgrab/mmdrop are used when manipulating
+# the lazy tlb reference of a kthread's ->active_mm (non-arch code has been
+# converted already).
+config MMU_LAZY_TLB_REFCOUNT
+	def_bool y
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 5376caf6fcf3..689dbe812563 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -82,17 +82,29 @@ static inline void mmdrop_sched(struct mm_struct *mm)
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
-	mmgrab(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
+		mmgrab(mm);
 }
 
 static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 {
-	mmdrop(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT)) {
+		mmdrop(mm);
+	} else {
+		/*
+		 * mmdrop_lazy_tlb must provide a full memory barrier, see the
+		 * membarrier comment finish_task_switch which relies on this.
+		 */
+		smp_mb();
+	}
 }
 
 static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
 {
-	mmdrop_sched(mm);
+	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
+		mmdrop_sched(mm);
+	else
+		smp_mb(); /* see mmdrop_lazy_tlb() above */
 }
 
 /**
-- 
2.37.2

