Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452842B1862
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 10:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgKMJiX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 04:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726583AbgKMJiV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 04:38:21 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915D122267;
        Fri, 13 Nov 2020 09:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605260300;
        bh=TS3RQbahQ1aCWxlNBrLZsbJ5uEZyLzGE0YxtwgY+69U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sehyT5t29MrChZlNZalMKfhNWEmG8CalXXxHhNb4OeEvpSMZcxf2aJDDCrPNj093B
         bIU7FKMMHbvpyNDYmKBDjVxndotDz5017Lt1AL/DZcZRbBsoiAR8ZpJhUijb74ix1q
         WAvIpv0UGk9yyB3UPPBZmkZVWjNexEP+5J5bh0/8=
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
Subject: [PATCH v3 12/14] arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system
Date:   Fri, 13 Nov 2020 09:37:17 +0000
Message-Id: <20201113093720.21106-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113093720.21106-1-will@kernel.org>
References: <20201113093720.21106-1-will@kernel.org>
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
 arch/arm64/kernel/cpufeature.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index dfded018af44..853f3ac876a3 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1237,6 +1237,8 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 
 static int enable_mismatched_32bit_el0(unsigned int cpu)
 {
+	static int lucky_winner = -1;
+
 	struct cpuinfo_arm64 *info = &per_cpu(cpu_data, cpu);
 	bool cpu_32bit = id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0);
 
@@ -1245,6 +1247,22 @@ static int enable_mismatched_32bit_el0(unsigned int cpu)
 		static_branch_enable_cpuslocked(&arm64_mismatched_32bit_el0);
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
+	pr_info("Asymmetric 32-bit EL0 support detected on CPU %u; CPU hot-unplug disabled on CPU %u\n",
+		cpu, lucky_winner);
 	return 0;
 }
 
-- 
2.29.2.299.gdc1121823c-goog

