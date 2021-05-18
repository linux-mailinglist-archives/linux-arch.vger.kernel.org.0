Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6937738759D
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbhERJug (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241855AbhERJts (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9224A613BD;
        Tue, 18 May 2021 09:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331307;
        bh=Q01LQeqZQsXv68AWl8KkMRey0NZmXny9qiWfV/iWJII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JPz5w/gR25XyMMQKrC4eho1EemJnl53pOfF1NzmpglNZe2RSOE96Kds2ka+HXolIl
         ptG9/FImIbUYt4QTHoTw4vEoQczjItxnD9p0/oCyeyvLWXoDBMKJr6fM9PoEvqivdt
         Qeuo8RRkkYfZK/9d3w9v09581ROVM6otSwdPPkj3tXEhj365tYyngsuSoVk/+OVtSO
         8ciHGLSgJFmejrB5u2ec+P0dWCRnf4M8egmOVAOC5trF57+RELuZXxxmX6uvul1dS4
         0HtzSjMscx1fmZ5IerrD+r7Rbp4Ji0yqMpCqS2/VBuSDB7Zq46J+KSAenmLALaEuYy
         eEiR99C+3kROg==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: [PATCH v6 14/21] freezer: Add frozen_or_skipped() helper function
Date:   Tue, 18 May 2021 10:47:18 +0100
Message-Id: <20210518094725.7701-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Occasionally it is necessary to see if a task is either frozen or
sleeping in the PF_FREEZER_SKIP state. In preparation for adding
additional users of this check, introduce a frozen_or_skipped() helper
function and convert the hung task detector over to using it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/freezer.h | 6 ++++++
 kernel/hung_task.c      | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 0621c5f86c39..b9e1e4200101 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -27,6 +27,11 @@ static inline bool frozen(struct task_struct *p)
 	return p->flags & PF_FROZEN;
 }
 
+static inline bool frozen_or_skipped(struct task_struct *p)
+{
+	return p->flags & (PF_FROZEN | PF_FREEZER_SKIP);
+}
+
 extern bool freezing_slow_path(struct task_struct *p);
 
 /*
@@ -270,6 +275,7 @@ static inline int freezable_schedule_hrtimeout_range(ktime_t *expires,
 
 #else /* !CONFIG_FREEZER */
 static inline bool frozen(struct task_struct *p) { return false; }
+static inline bool frozen_or_skipped(struct task_struct *p) { return false; }
 static inline bool freezing(struct task_struct *p) { return false; }
 static inline void __thaw_task(struct task_struct *t) {}
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 396ebaebea3f..d2d4c4159b23 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -92,8 +92,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ensure the task is not frozen.
 	 * Also, skip vfork and any other user process that freezer should skip.
 	 */
-	if (unlikely(t->flags & (PF_FROZEN | PF_FREEZER_SKIP)))
-	    return;
+	if (unlikely(frozen_or_skipped(t)))
+		return;
 
 	/*
 	 * When a freshly created task is scheduled once, changes its state to
-- 
2.31.1.751.gd2f1c929bd-goog

