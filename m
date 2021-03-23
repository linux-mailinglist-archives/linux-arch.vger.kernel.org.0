Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C529346A39
	for <lists+linux-arch@lfdr.de>; Tue, 23 Mar 2021 21:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbhCWUkm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Mar 2021 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhCWUkO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Mar 2021 16:40:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D78DC0613E1
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:13 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6so13920qvu.11
        for <linux-arch@vger.kernel.org>; Tue, 23 Mar 2021 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TXt+gLVEDlmfHDoaitlym6lqHbHvj5KHcb6MKkix6ec=;
        b=a/yUJ0QXm/MOLiUOhSWc+MJHJGUrLH4d7XtxofXeHJURcZDnAcdDXmYDaJXv007JPz
         xAPUgq+GcXSMjRNECEOcb5ceYGk5hhoMrgh3corCxHVFDnt3oxiQpzo/WEufjeNi4uYk
         kDUvaRMYPbMJQYNM55tQ3P2kEh0EhTtHjTGI0CC8Zg/irBGrycsgiRLSeENrKcmhiR+I
         bJsyyonlBCpY+NDkalPH+ykewNK1Zj1R4goiy7twtXajFwl1AWjQ/zA45qNIc2aHNXe7
         lyqrguVctk1AYoZ1oBuog71+Cw29qnmliEdTR+vA7O9FpgmlA3VhaVjPa0oDORYY38xM
         rrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TXt+gLVEDlmfHDoaitlym6lqHbHvj5KHcb6MKkix6ec=;
        b=lh/fccfRnnyodwOokh4s888kD+mVP5p7M4ToHGzB6+NRzoywN25Vo1mO4hQoNMJCRW
         60XcVRe/879oK1KmnuaFH0fgZR0OQVvE+EFiy/8CC8rCEJAWVpFiWJaIUEocgLaQ5EHI
         AhjIi6jm4QGDEkugSI3gQU6GrMK6a/zNsVlUSazQlh3sxFC8kfGUuQHcL/pyefLBaChq
         kxZk7LSfPQbtdATNSH+We7JHXMUCvd0n4gT7SQdW3x0IN25dXRDodJdi+08hHbrrMva8
         5qQtCe8PNwmPAxgl0BzB7hTwGFHXqNy5nWaQy5Kw/94NATcvPtZ1vfRTE7HGiaezg7Wk
         2osQ==
X-Gm-Message-State: AOAM533Hwf1fQtLW3xRJRfDxbjW0dMZQqtjDevtW1QLM3w41FBdOQri4
        KBHRrzoJWlKwBW/tI6DCjSpMLd8ayS6CndiZYZI=
X-Google-Smtp-Source: ABdhPJy6OMzEOHy6aXtVaxpn8SRHl25FYohWdXh4rj7GqknCA5DMEHWc/hOFNCg6er7t1Uz+avTocAMaMN2Bc434rVY=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e9a3:260d:763b:67dc])
 (user=samitolvanen job=sendgmr) by 2002:ad4:50d0:: with SMTP id
 e16mr136306qvq.37.1616532012794; Tue, 23 Mar 2021 13:40:12 -0700 (PDT)
Date:   Tue, 23 Mar 2021 13:39:42 -0700
In-Reply-To: <20210323203946.2159693-1-samitolvanen@google.com>
Message-Id: <20210323203946.2159693-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210323203946.2159693-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v3 13/17] arm64: use __pa_function
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With CONFIG_CFI_CLANG, the compiler replaces function address
references with the address of the function's CFI jump table
entry. This means that __pa_symbol(function) returns the physical
address of the jump table entry, which can lead to address space
confusion as the jump table points to the function's virtual
address. Therefore, use the __pa_function() macro to ensure we are
always taking the address of the actual function instead.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/mmu_context.h      | 2 +-
 arch/arm64/kernel/acpi_parking_protocol.c | 2 +-
 arch/arm64/kernel/cpu-reset.h             | 2 +-
 arch/arm64/kernel/cpufeature.c            | 2 +-
 arch/arm64/kernel/psci.c                  | 3 ++-
 arch/arm64/kernel/smp_spin_table.c        | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index bd02e99b1a4c..16cc9a694bb2 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -140,7 +140,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
 		ttbr1 |= TTBR_CNP_BIT;
 	}
 
-	replace_phys = (void *)__pa_symbol(idmap_cpu_replace_ttbr1);
+	replace_phys = (void *)__pa_function(idmap_cpu_replace_ttbr1);
 
 	cpu_install_idmap();
 	replace_phys(ttbr1);
diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
index e7c941d8340d..e7f3af6043c5 100644
--- a/arch/arm64/kernel/acpi_parking_protocol.c
+++ b/arch/arm64/kernel/acpi_parking_protocol.c
@@ -99,7 +99,7 @@ static int acpi_parking_protocol_cpu_boot(unsigned int cpu)
 	 * that read this address need to convert this address to the
 	 * Boot-Loader's endianness before jumping.
 	 */
-	writeq_relaxed(__pa_symbol(secondary_entry), &mailbox->entry_point);
+	writeq_relaxed(__pa_function(secondary_entry), &mailbox->entry_point);
 	writel_relaxed(cpu_entry->gic_cpu_id, &mailbox->cpu_id);
 
 	arch_send_wakeup_ipi_mask(cpumask_of(cpu));
diff --git a/arch/arm64/kernel/cpu-reset.h b/arch/arm64/kernel/cpu-reset.h
index ed50e9587ad8..dfba8cf921e5 100644
--- a/arch/arm64/kernel/cpu-reset.h
+++ b/arch/arm64/kernel/cpu-reset.h
@@ -22,7 +22,7 @@ static inline void __noreturn cpu_soft_restart(unsigned long entry,
 
 	unsigned long el2_switch = !is_kernel_in_hyp_mode() &&
 		is_hyp_mode_available();
-	restart = (void *)__pa_symbol(__cpu_soft_restart);
+	restart = (void *)__pa_function(__cpu_soft_restart);
 
 	cpu_install_idmap();
 	restart(el2_switch, entry, arg0, arg1, arg2);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 066030717a4c..7ec1c2ccdc0b 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1460,7 +1460,7 @@ kpti_install_ng_mappings(const struct arm64_cpu_capabilities *__unused)
 	if (arm64_use_ng_mappings)
 		return;
 
-	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
+	remap_fn = (void *)__pa_function(idmap_kpti_install_ng_mappings);
 
 	cpu_install_idmap();
 	remap_fn(cpu, num_online_cpus(), __pa_symbol(swapper_pg_dir));
diff --git a/arch/arm64/kernel/psci.c b/arch/arm64/kernel/psci.c
index 62d2bda7adb8..bfb1a6f8282d 100644
--- a/arch/arm64/kernel/psci.c
+++ b/arch/arm64/kernel/psci.c
@@ -38,7 +38,8 @@ static int __init cpu_psci_cpu_prepare(unsigned int cpu)
 
 static int cpu_psci_cpu_boot(unsigned int cpu)
 {
-	int err = psci_ops.cpu_on(cpu_logical_map(cpu), __pa_symbol(secondary_entry));
+	int err = psci_ops.cpu_on(cpu_logical_map(cpu),
+				  __pa_function(secondary_entry));
 	if (err)
 		pr_err("failed to boot CPU%d (%d)\n", cpu, err);
 
diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
index 056772c26098..a80ff9092e86 100644
--- a/arch/arm64/kernel/smp_spin_table.c
+++ b/arch/arm64/kernel/smp_spin_table.c
@@ -88,7 +88,7 @@ static int smp_spin_table_cpu_prepare(unsigned int cpu)
 	 * boot-loader's endianness before jumping. This is mandated by
 	 * the boot protocol.
 	 */
-	writeq_relaxed(__pa_symbol(secondary_holding_pen), release_addr);
+	writeq_relaxed(__pa_function(secondary_holding_pen), release_addr);
 	__flush_dcache_area((__force void *)release_addr,
 			    sizeof(*release_addr));
 
-- 
2.31.0.291.g576ba9dcdaf-goog

