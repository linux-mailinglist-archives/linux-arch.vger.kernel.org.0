Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB723875A4
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243449AbhERJuo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242093AbhERJt7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1FDA61401;
        Tue, 18 May 2021 09:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331321;
        bh=6g9NVbkObRxGunwkaQ5JxyE6uDt34ueHBKqyl0oVxYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kbkOc+WKgFFl0HV+uacnOtz0MtG+VG7IhssMjNOO3i3md9AUXwFLFbGvOlpJpP2UK
         f2exwaDNgrJDxMFDR5OlCqmVex9lfkqHocqc6c3LInUzFdAFzLPcI9gCtH4YNVksco
         f+lMksvAgtytTY+DC1MbXoWtJDcR2JormPvecHdqDcBPcLYqp0pzb2jYqu/Wn1RQNT
         zJ+Y73ZOzrAKdEYP/S3kDgZqofiXT0z6KJlaprpYRMtofQNdN0g7rm9ysamPRUDA7D
         bDugtVJzZ5+Nx0fCM7DDgQvkYtTx8Zn3xOlpnl7S9DmXA/SsDgYKH3N9wC7BOyL6Lt
         SMBvCK4BI4tJQ==
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
Subject: [PATCH v6 18/21] arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system
Date:   Tue, 18 May 2021 10:47:22 +0100
Message-Id: <20210518094725.7701-19-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

If we want to support 32-bit applications, then when we identify a CPU
with mismatched 32-bit EL0 support we must ensure that we will always
have an active 32-bit CPU available to us from then on. This is important
for the scheduler, because is_cpu_allowed() will be constrained to 32-bit
CPUs for compat tasks and forced migration due to a hotplug event will
hang if no 32-bit CPUs are available.

On detecting a mismatch, prevent offlining of either the mismatching CPU
if it is 32-bit capable, or find the first active 32-bit capable CPU
otherwise.

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 959442f76ed7..72efdc611b14 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2896,15 +2896,33 @@ void __init setup_cpu_features(void)
 
 static int enable_mismatched_32bit_el0(unsigned int cpu)
 {
+	static int lucky_winner = -1;
+
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
 
 	if (cpu_32bit) {
 		cpumask_set_cpu(cpu, cpu_32bit_el0_mask);
 		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
-		setup_elf_hwcaps(compat_elf_hwcaps);
 	}
 
+	if (cpumask_test_cpu(0, cpu_32bit_el0_mask) == cpu_32bit)
+		return 0;
+
+	if (lucky_winner >= 0)
+		return 0;
+
+	/*
+	 * We've detected a mismatch. We need to keep one of our CPUs with
+	 * 32-bit EL0 online so that is_cpu_allowed() doesn't end up rejecting
+	 * every CPU in the system for a 32-bit task.
+	 */
+	lucky_winner = cpu_32bit ? cpu : cpumask_any_and(cpu_32bit_el0_mask,
+							 cpu_active_mask);
+	get_cpu_device(lucky_winner)->offline_disabled = true;
+	setup_elf_hwcaps(compat_elf_hwcaps);
+	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
+		cpu, lucky_winner);
 	return 0;
 }
 
-- 
2.31.1.751.gd2f1c929bd-goog

