Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FBC2683C4
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 06:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgINEwy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 00:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgINEwq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 00:52:46 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF2EC06174A;
        Sun, 13 Sep 2020 21:52:46 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k15so11532592pfc.12;
        Sun, 13 Sep 2020 21:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PMGQxaBKPbON3ssZWMqrEm63rTUeWUDOhP6COLqPYSc=;
        b=E6t5ATL8gx3qXPR8MutckEOtFp8N/QqyJhBR7KZvwdtkFuAEyC2lhZ2/emCtjTKBmo
         B0kb2CydVdVNlaob1xulncfmSHsG5MpRJYpG32az5As5jUlalJv5Z1u24HGgsukfOob0
         pStFmcZQbhM6RQl6+oGHRZ/T4R+TM1Eyv8T8Wo3EQa0oEPAufWykBkJADQ737q0p9bQY
         2R33AJCLbtCHvjVUHJysl92cDr8E/Gps9+AWbHKehyystd+wcHrhzluGm/ArtKvSmZCu
         bm9w6OFAfNAC+nOJ6NR0QDHwYy2vZD6WeoHYvXZICjq3HwmMDhUuXmKAzk9mSX/KjWa1
         XD6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PMGQxaBKPbON3ssZWMqrEm63rTUeWUDOhP6COLqPYSc=;
        b=tlX4wD4UCzzNIEjzglGRZoYOeAMXUDWzkf4/ffz4Nc1XPPULZDqWi9+XZgd0pXgafI
         AtGb6L6QCiKQ6MZZ1T0XZg30jKTrF4CrEV4wzeYzgunIR6WNrMv5Y01S5u5W8UntrW8E
         /vZlCZ+S7ZJYXQZE+AP2pVwaMUQZqKj0F6MULLdI4404N9VPisj5eHFgL0wxFdmCNbhv
         rt550wQuM8mPqxPbzR/pl1SR4BUnbIrcaAYTxCih3se4vUEvskunfg6DMXhXboq6cG8p
         5y1lbm9FXXc5MLc1iNJxG7Py9QKE6hFVS4VthbDpWAlVAvxUAz0nBwM0nsSPwIWkzpfy
         MQgQ==
X-Gm-Message-State: AOAM530hEZS6KSyDETWBRhChJkzF+ygVHYsPwv75t7bvXKGGfOIBv1TK
        6tMeYsKoXJcYm0lgMImuH3A=
X-Google-Smtp-Source: ABdhPJyPI7rDf+d21q9NzzsfoVdINl/UoWB/tNDVu6ib1rFaHHxGEc6qLhJCwAhX5Wm+j4pnSX9vTQ==
X-Received: by 2002:a17:902:eec7:b029:d1:c2e4:6b58 with SMTP id h7-20020a170902eec7b02900d1c2e46b58mr4791803plb.4.1600059161060;
        Sun, 13 Sep 2020 21:52:41 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id a13sm6945312pgq.41.2020.09.13.21.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 21:52:40 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     "linux-mm @ kvack . org" <linux-mm@kvack.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v2 1/4] mm: fix exec activate_mm vs TLB shootdown and lazy tlb switching race
Date:   Mon, 14 Sep 2020 14:52:16 +1000
Message-Id: <20200914045219.3736466-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200914045219.3736466-1-npiggin@gmail.com>
References: <20200914045219.3736466-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Reading and modifying current->mm and current->active_mm and switching
mm should be done with irqs off, to prevent races seeing an intermediate
state.

This is similar to commit 38cf307c1f20 ("mm: fix kthread_use_mm() vs TLB
invalidate"). At exec-time when the new mm is activated, the old one
should usually be single-threaded and no longer used, unless something
else is holding an mm_users reference (which may be possible).

Absent other mm_users, there is also a race with preemption and lazy tlb
switching. Consider the kernel_execve case where the current thread is
using a lazy tlb active mm:

  call_usermodehelper()
    kernel_execve()
      old_mm = current->mm;
      active_mm = current->active_mm;
      *** preempt *** -------------------->  schedule()
                                               prev->active_mm = NULL;
                                               mmdrop(prev active_mm);
                                             ...
                      <--------------------  schedule()
      current->mm = mm;
      current->active_mm = mm;
      if (!old_mm)
          mmdrop(active_mm);

If we switch back to the kernel thread from a different mm, there is a
double free of the old active_mm, and a missing free of the new one.

Closing this race only requires interrupts to be disabled while ->mm
and ->active_mm are being switched, but the TLB problem requires also
holding interrupts off over activate_mm. Unfortunately not all archs
can do that yet, e.g., arm defers the switch if irqs are disabled and
expects finish_arch_post_lock_switch() to be called to complete the
flush; um takes a blocking lock in activate_mm().

So as a first step, disable interrupts across the mm/active_mm updates
to close the lazy tlb preempt race, and provide an arch option to
extend that to activate_mm which allows architectures doing IPI based
TLB shootdowns to close the second race.

This is a bit ugly, but in the interest of fixing the bug and backporting
before all architectures are converted this is a compromise.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/Kconfig |  7 +++++++
 fs/exec.c    | 17 +++++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index af14a567b493..94821e3f94d1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -414,6 +414,13 @@ config MMU_GATHER_NO_GATHER
 	bool
 	depends on MMU_GATHER_TABLE_FREE
 
+config ARCH_WANT_IRQS_OFF_ACTIVATE_MM
+	bool
+	help
+	  Temporary select until all architectures can be converted to have
+	  irqs disabled over activate_mm. Architectures that do IPI based TLB
+	  shootdowns should enable this.
+
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
diff --git a/fs/exec.c b/fs/exec.c
index a91003e28eaa..d4fb18baf1fb 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1130,11 +1130,24 @@ static int exec_mmap(struct mm_struct *mm)
 	}
 
 	task_lock(tsk);
-	active_mm = tsk->active_mm;
 	membarrier_exec_mmap(mm);
-	tsk->mm = mm;
+
+	local_irq_disable();
+	active_mm = tsk->active_mm;
 	tsk->active_mm = mm;
+	tsk->mm = mm;
+	/*
+	 * This prevents preemption while active_mm is being loaded and
+	 * it and mm are being updated, which could cause problems for
+	 * lazy tlb mm refcounting when these are updated by context
+	 * switches. Not all architectures can handle irqs off over
+	 * activate_mm yet.
+	 */
+	if (!IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+		local_irq_enable();
 	activate_mm(active_mm, mm);
+	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
+		local_irq_enable();
 	tsk->mm->vmacache_seqnum = 0;
 	vmacache_flush(tsk);
 	task_unlock(tsk);
-- 
2.23.0

