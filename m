Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966133904FF
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhEYPST (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 11:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhEYPRt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 11:17:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AE7761436;
        Tue, 25 May 2021 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621955779;
        bh=2Tu/2JiXMKcPPPKmdOfa8s5PZpHuaTBt8RxTqRmrXV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QjROUIYpRep4wk4NrxWkdXd9BKzpYBLggho3ynNEsiA7QOFn+2BsNSDSt8Bc5rRgn
         U5zTEKARsOYWhGzW3bhHU7WspRpp+kK2IqA6p1yJsw702ImoI2d3jJMdmkNxOl77yc
         IAhB3lCf++kFf7063e3+g3HG9eDGc+D0UV020MhLWq8f7c+Yu19aVGWdOqux6/eRYO
         MyGaQg3+xLJ0KdKBO1acQVNRCnI8XDemC3ZWXStjSygTMMpY0TZeSUq9W4yA/26Uh/
         Y/7oQAGTeOv+uz2swF+3qxWd6Pzww7VjOofJqK2qbl12lu+P4s/VoAfe3LinlsRGFM
         WqWT2wKoXmPVw==
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
        kernel-team@android.com
Subject: [PATCH v7 17/22] arm64: Implement task_cpu_possible_mask()
Date:   Tue, 25 May 2021 16:14:27 +0100
Message-Id: <20210525151432.16875-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210525151432.16875-1-will@kernel.org>
References: <20210525151432.16875-1-will@kernel.org>
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
2.31.1.818.g46aad6cb9e-goog

