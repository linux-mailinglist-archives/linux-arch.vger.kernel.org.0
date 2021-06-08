Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFEC39FE7E
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbhFHSGe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232634AbhFHSGR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:06:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C735F613AD;
        Tue,  8 Jun 2021 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175464;
        bh=lPiqbs5bNC1XfYw4dGVM5dcp8Q2l9mwJXLtvvoVPjzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcFi8tJUutu2sOKFQVYjW9TDRUXI/6EViDXQi702e0oFa7sApRuStLB8xf0+b6XFI
         SWif8+5Pl6+5zaUPyIX/0rlKmnRR2Yh5/YwcHnOfNI0cnYYiWYgOOZeXQ/s1tlj50z
         XNeW34/HxfaLA3ltavhnXlDD0i5/GUwZa6Af7zAyMA0wuUsWxXZceUY598h2vYWoZL
         ATtrKrghZ9fwYiNAHEuwBqGjddKugAryb4wDvmRTj6a83pPQcTZIUHhQ62EVxqMd8J
         SYFyNqr3dxytQps/M4rIuDrppJUpo0XW3uRCqvx+tTUwDQwBG4vN/BakD4FhLBgIOM
         0QXbIn80az/DQ==
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
Subject: [PATCH v9 14/20] arm64: Implement task_cpu_possible_mask()
Date:   Tue,  8 Jun 2021 19:03:07 +0100
Message-Id: <20210608180313.11502-15-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
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
2.32.0.rc1.229.g3e70b5a671-goog

