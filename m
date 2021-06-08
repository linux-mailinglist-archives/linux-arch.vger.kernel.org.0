Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428DA39FE7F
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 20:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbhFHSGf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 14:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234156AbhFHSGV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 14:06:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE6CF613BD;
        Tue,  8 Jun 2021 18:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623175468;
        bh=CAGkozJ61No6712GDR/oh/lD4ZjbGoSK5Iod35TLmM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YmA8do7AhGTaQlSEn5DCu1u5Mw3d+ykCuaPhbcbjb4YzF7z77fElBA2CZsGXpVnOl
         43VVepiwtVivQeqr7IFcDTBgNoEow5iBCQ97tEGjFy1SYeXtdGXpVCis/xqpsbGXEq
         qUQsnVgc1jxnAkzVhsQQDBxk5XvdIq1SdClkDIg1SIYrsg/rPyiJHHOGLsV0ra9Ah0
         f0YT+MESKoyzqDJ8oMLJIss/MGoHaIkiHAG2hTUjEEr0PyvM1nxl3l01LSiBbBEWK3
         C8P2xguMBAEnMUzjmrSlBv7DaW/LKbB+g6I8sD+AfkXJ5QbNxLrecqu2vueFJmOsXR
         Yn6cp4PAwWlpw==
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
Subject: [PATCH v9 15/20] arm64: exec: Adjust affinity for compat tasks with mismatched 32-bit EL0
Date:   Tue,  8 Jun 2021 19:03:08 +0100
Message-Id: <20210608180313.11502-16-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608180313.11502-1-will@kernel.org>
References: <20210608180313.11502-1-will@kernel.org>
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

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Reviewed-by: Quentin Perret <qperret@google.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/elf.h |  6 ++----
 arch/arm64/kernel/process.c  | 39 +++++++++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..97932fbf973d 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -213,10 +213,8 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
-#define compat_elf_check_arch(x)	(system_supports_32bit_el0() && \
-					 ((x)->e_machine == EM_ARM) && \
-					 ((x)->e_flags & EF_ARM_EABI_MASK))
-
+int compat_elf_check_arch(const struct elf32_hdr *);
+#define compat_elf_check_arch		compat_elf_check_arch
 #define compat_start_thread		compat_start_thread
 /*
  * Unlike the native SET_PERSONALITY macro, the compat version maintains
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index f4a91bf1ce0c..220134888d7e 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -22,6 +22,7 @@
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <linux/nospec.h>
+#include <linux/sched.h>
 #include <linux/stddef.h>
 #include <linux/sysctl.h>
 #include <linux/unistd.h>
@@ -638,6 +639,28 @@ unsigned long arch_align_stack(unsigned long sp)
 	return sp & ~0xf;
 }
 
+#ifdef CONFIG_COMPAT
+int compat_elf_check_arch(const struct elf32_hdr *hdr)
+{
+	if (!system_supports_32bit_el0())
+		return false;
+
+	if ((hdr)->e_machine != EM_ARM)
+		return false;
+
+	if (!((hdr)->e_flags & EF_ARM_EABI_MASK))
+		return false;
+
+	/*
+	 * Prevent execve() of a 32-bit program from a deadline task
+	 * if the restricted affinity mask would be inadmissible on an
+	 * asymmetric system.
+	 */
+	return !static_branch_unlikely(&arm64_mismatched_32bit_el0) ||
+	       !dl_task_check_affinity(current, system_32bit_el0_cpumask());
+}
+#endif
+
 /*
  * Called from setup_new_exec() after (COMPAT_)SET_PERSONALITY.
  */
@@ -647,8 +670,22 @@ void arch_setup_new_exec(void)
 
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
2.32.0.rc1.229.g3e70b5a671-goog

