Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2D42C2BEB
	for <lists+linux-arch@lfdr.de>; Tue, 24 Nov 2020 16:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390035AbgKXPvn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Nov 2020 10:51:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389866AbgKXPvn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 24 Nov 2020 10:51:43 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE4E208CA;
        Tue, 24 Nov 2020 15:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606233102;
        bh=NLrRi/9J8DaCVchkwFBH0cmOH7ieCC+y5agV9HnV2+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YkVT+zic8vHSeVX8CyqGlQeJYCTc1ZAC4zwzlr99goZTXgEDP/bH5RFztFcHLoEOa
         dvLcQfn33zCYuRjaz9nP0YsyjCl3h+7y0/9/RxczqYB6o0FchMBiYxfCcIYvc1XLFr
         PFfy+ip7QqVrizAmIa2NICe8yg6kcY2xmmqg9dlM=
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
        kernel-team@android.com
Subject: [PATCH v4 13/14] arm64: Implement arch_task_cpu_possible_mask()
Date:   Tue, 24 Nov 2020 15:50:38 +0000
Message-Id: <20201124155039.13804-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124155039.13804-1-will@kernel.org>
References: <20201124155039.13804-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide an implementation of arch_task_cpu_possible_mask() so that we
can prevent 64-bit-only cores being added to the 'cpus_mask' for compat
tasks on systems with mismatched 32-bit support at EL0,

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 0672236e1aea..641dff35a56f 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -251,6 +251,19 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 #define deactivate_mm(tsk,mm)	do { } while (0)
 #define activate_mm(prev,next)	switch_mm(prev, next, current)
 
+static inline const struct cpumask *
+arch_task_cpu_possible_mask(struct task_struct *p)
+{
+	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return cpu_possible_mask;
+
+	if (!is_compat_thread(task_thread_info(p)))
+		return cpu_possible_mask;
+
+	return system_32bit_el0_cpumask();
+}
+#define arch_task_cpu_possible_mask	arch_task_cpu_possible_mask
+
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
-- 
2.29.2.454.gaff20da3a2-goog

