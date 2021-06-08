Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1142E39FE81
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbhFHSGj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233702AbhFHSGZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:06:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAF6E61377;
        Tue,  8 Jun 2021 18:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175472;
        bh=DOju4Qkdazocj9FpNAdyJz+fzAXLHJIskweDvyX2/bU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OfjBOue9fuzmxPOj/KqDgcNGa3da8OVKKo7EO0duS+WlkqRCrDKbdCxVqPahZvvTb
         M+JMkvAxtYMsqFvMBljOy5Y9xumEguWoqKouE8auloXnklab3qZ6jqRmZPDsaBxihp
         IFzw4Dl9QmPzsoM4hz1yODCeXAEWzyXu8mYmMljzl+KH+rk8pN3t7xMZc1UXxdOAm1
         ERjxp0gq4jmc6HCW3eSVAPYQRJcJFqmyf3I9FVdTVzmRUk2p9wiWbb736+haSzjhot
         Lfo24qGPoj+k9iXVdUzo5b2XRSFeGe1itBj+2JWHI9jaYWF6TdjG18GzkR1y80Nih+
         dWtl0GHyM6nxw==
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
Subject: [PATCH v9 16/20] arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system
Date:   Tue,  8 Jun 2021 19:03:09 +0100
Message-Id: <20210608180313.11502-17-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
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
index d735dd13167b..55a58933e3b2 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -2877,15 +2877,38 @@ void __init setup_cpu_features(void)
 
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
2.32.0.rc1.229.g3e70b5a671-goog

