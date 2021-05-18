Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40F3875A3
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 11:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348220AbhERJuo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 05:50:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241535AbhERJt6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 05:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E50961400;
        Tue, 18 May 2021 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621331318;
        bh=R9BW6P5F0BMcxqhawbpZj55WsxoJwynPUjScPCDvTIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DHYBKJslYl+OETsyFh81LkpiXQ1cFVBDLzO/naT40uQr2B1dNxMIsDbm5QRs9oU2Z
         S704c6CqM37DEqMAX0U1NLMEWmSGkBhw5PpD5NpFNbIGNQ3riHGvsT8egS7XIvaRYc
         ddfJGNtVY1A3jNpKyKyqog2WD5Q8DJX9RdW2aVHD2GoCAvv+3AA1rEkASemwoWStaC
         STSqemDuneUVF9rEaqO9Azitdtec7reffxVPEc8srAEWY16QDZHqSLl5ly02jgPuPx
         I/jsjzw8Vp6IGqYqyJGRJLNXDL35IPBuaz+TLXET7FpPkHE7OAVtibCRod2500RmUR
         LwPBykiMdhBBQ==
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
Subject: [PATCH v6 17/21] arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit EL0
Date:   Tue, 18 May 2021 10:47:21 +0100
Message-Id: <20210518094725.7701-18-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210518094725.7701-1-will@kernel.org>
References: <20210518094725.7701-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When exec'ing a 32-bit task on a system with mismatched support for
32-bit EL0, try to ensure that it starts life on a CPU that can actually
run it.

Similarly, when exec'ing a 64-bit task on such a system, try to restore
the old affinity mask if it was previously restricted.

Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/process.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f4a91bf1ce0c..8e0da06c4e77 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -647,8 +647,22 @@ void arch_setup_new_exec(void)
 
 	if (is_compat_task()) {
 		mmflags = MMCF_AARCH32;
-		if (static_branch_unlikely(&arm64_mismatched_32bit_el0))
+
+		/*
+		 * Restrict the CPU affinity mask for a 32-bit task so that
+		 * it contains only 32-bit-capable CPUs.
+		 *
+		 * From the perspective of the task, this looks similar to
+		 * what would happen if the 64-bit-only CPUs were hot-unplugged
+		 * at the point of execve(), although we try a bit harder to
+		 * honour the cpuset hierarchy.
+		 */
+		if (static_branch_unlikely(&arm64_mismatched_32bit_el0)) {
+			force_compatible_cpus_allowed_ptr(current);
 			set_tsk_thread_flag(current, TIF_NOTIFY_RESUME);
+		}
+	} else if (static_branch_unlikely(&arm64_mismatched_32bit_el0)) {
+		relax_compatible_cpus_allowed_ptr(current);
 	}
 
 	current->mm->context.flags = mmflags;
-- 
2.31.1.751.gd2f1c929bd-goog

