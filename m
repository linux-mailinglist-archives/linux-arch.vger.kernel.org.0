Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85CD23B1FBC
	for <lists+linux-arch@lfdr.de>; Wed, 23 Jun 2021 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhFWRmB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Jun 2021 13:42:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhFWRlz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 23 Jun 2021 13:41:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 45DC2601FF;
        Wed, 23 Jun 2021 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624469977;
        bh=Rx8SeEsH217Fb1jNMWeORIWDLUe6VS70z2Nb3ovhPXU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LcjMdtHvOCa0Yre/OMR8XGfUMNVJU3UxKIe0+tyBo1nh8WQsM9fSj/mAtw1fcXool
         Fl1NKfew7tRBcnR8Q0wwohJHBO+4ODb3wvRADX6b1vE0YBwBNH8BGpmXumFtAUTX+0
         WliiGBajkeDnJ6Fig/PUrYca4lXDef90zsGZAutOa/HfoOKO6ZUAEjXZuI6GksiXGU
         i0xq7DWLCj4ce0KVVAoyhwVkIfJszv96Px+UBVs4ZF+rUfN1J4jKfio43RSJqx0zuz
         emtvkoJsdeW7Nzyl0+Ymvw6YdFsxbearXFBPM3WxDYRsx1Tr8TNCKr/pFEu2sJWeGD
         Y6MwWpxexN9Xg==
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
Subject: [PATCH v10 10/16] arm64: Implement task_cpu_possible_mask()
Date:   Wed, 23 Jun 2021 18:38:42 +0100
Message-Id: <20210623173848.318-11-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210623173848.318-1-will@kernel.org>
References: <20210623173848.318-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Provide an implementation of task_cpu_possible_mask() so that we can
prevent 64-bit-only cores being added to the 'cpus_mask' for compat
tasks on systems with mismatched 32-bit support at EL0,

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mmu_context.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index d3cef9133539..bb9b7510f334 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -231,6 +231,19 @@ switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	update_saved_ttbr0(tsk, next);
 }
 
+static inline const struct cpumask *
+task_cpu_possible_mask(struct task_struct *p)
+{
+	if (!static_branch_unlikely(&arm64_mismatched_32bit_el0))
+		return cpu_possible_mask;
+
+	if (!is_compat_thread(task_thread_info(p)))
+		return cpu_possible_mask;
+
+	return system_32bit_el0_cpumask();
+}
+#define task_cpu_possible_mask	task_cpu_possible_mask
+
 void verify_cpu_asid_bits(void);
 void post_ttbr_update_workaround(void);
 
-- 
2.32.0.93.g670b81a890-goog

