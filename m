Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7905A2B1870
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgKMJis (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:38:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgKMJiG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:38:06 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FC1322256;
        Fri, 13 Nov 2020 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260285;
        bh=J8+I2f+gPpziZ5U6sdn75jZAGik3lGxmmN6ishZFfVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H8pXASpfRCOapA6Jkxei/lB3qb4AVGc8BfhyocAUYLwjickDOqbUL+Jf91bB0+Pdl
         5ys/nQVkSOijTysjHAzCt7WWyxjKb+ncTsCBHAT7GRc+m/1xP0/qU+itAl5fRLDxLo
         qxW+bUbroDgNn97IFhkqEWra2KgpKSX/9zgiIfWs=
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
Subject: [PATCH v3 08/14] arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit EL0
Date:   Fri, 13 Nov 2020 09:37:13 +0000
Message-Id: <20201113093720.21106-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113093720.21106-1-will@kernel.org>
References: <20201113093720.21106-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When exec'ing a 32-bit task on a system with mismatched support for
32-bit EL0, try to ensure that it starts life on a CPU that can actually
run it.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 1540ab0fbf23..17b94007fed4 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -625,6 +625,16 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ~0xf;
 }
 
+static void adjust_compat_task_affinity(struct task_struct *p)
+{
+	const struct cpumask *mask = system_32bit_el0_cpumask();
+
+	if (restrict_cpus_allowed_ptr(p, mask))
+		set_cpus_allowed_ptr(p, mask);
+
+	set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+}
+
 /*
  * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
  */
@@ -635,7 +645,7 @@ void arch_setup_new_exec(void)
 	if (is_compat_task()) {
 		mmflags = MMCF_AARCH32;
 		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
-			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+			adjust_compat_task_affinity(current);
 	}
 
 	current->mm->context.flags = mmflags;
-- 
2.29.2.299.gdc1121823c-goog

