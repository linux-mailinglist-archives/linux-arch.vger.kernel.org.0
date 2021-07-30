Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B413DB7C7
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 13:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbhG3LZu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 07:25:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238780AbhG3LZo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 07:25:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D9B76101C;
        Fri, 30 Jul 2021 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627644339;
        bh=YiNgY8+kTBdYeqURjU5xY5wvK1Ur/VHfTq38waThEcQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B67CT5aFUcNhTgH3L8ctFQCwWykZZrvqOvBKcnUHgW/h50xBHxQhK4vIJaB3af6be
         C0fNTSFujlB5bT/U1j0qfXspeVQXejynDJKo84pFuJT7PZUYfpPIEtlPSzfV/k/6Jn
         J6H3MqxVthdE+HbgR+YLJKivoV1u9e6SRlfxRdqZfd30QD56lh3xP/is2iHEQHkYFe
         CDYjmoceAL5DkNqft0GS0VIw0LwL+Acf6BCz/GPGohEh3HJtxKcUqaAcAovRIZeJtt
         si06Z8RzXWazWG6MVHidhsOrEyuyQsUtcVDIb75Tn+KjRMtmjrrv7nUgML+DTJBBNm
         pWl+cdQvLiOMA==
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
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: [PATCH v11 12/16] arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system
Date:   Fri, 30 Jul 2021 12:24:39 +0100
Message-Id: <20210730112443.23245-13-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210730112443.23245-1-will@kernel.org>
References: <20210730112443.23245-1-will@kernel.org>
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

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 125d5c9471ac..d99a29f52aa1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2900,15 +2900,38 @@ void __init setup_cpu_features(void)
 
 static int enable_mismatched_32bit_el0(unsigned int cpu)
 {
+	/*
+	 * The first 32-bit-capable CPU we detected and so can no longer
+	 * be offlined by userspace. -1 indicates we haven't yet onlined
+	 * a 32-bit-capable CPU.
+	 */
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
2.32.0.402.g57bb445576-goog

