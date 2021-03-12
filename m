Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFBF93382E4
	for <lists+linux-arch@lfdr.de>; Fri, 12 Mar 2021 01:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhCLAuV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 11 Mar 2021 19:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbhCLAtr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Mar 2021 19:49:47 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA3BC061761
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:46 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id d26so16439985qve.7
        for <linux-arch@vger.kernel.org>; Thu, 11 Mar 2021 16:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ke/VK9feKGHIOdGZ0pPiwCA0H+8ezangCBgEAIc7UY8=;
        b=VEua8fI/YdbAAV+4vZE9LkkG6NVxbYTi4fRLVAQJzfNMohxQByrtWWMZlXvS9RQ8nE
         GCrQlGX4ECvM7L+7ShVYOcebSOytlurJV/W9GzVfy61t+13vR6iXIT3v1UZ+jyY1BeYR
         wQBYv8Oduzu+jPwNxOmMrTIBK+k2MNhOngjZrb+3mtmR/N463wuAVgjpNO6QMyDQdlGp
         fI74iB6pZmXATCWJHIMEIE1ELSESldUwtkUQ2woIlKymiMBAFWY/gPsczmQVWcgpL4RE
         PHiq5RzAAWrUYckK7pQsqJHgN14P5xf7CIR+jMOOtqlEeil1THtozna5tLtZEutzgSAp
         /elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ke/VK9feKGHIOdGZ0pPiwCA0H+8ezangCBgEAIc7UY8=;
        b=qKkpIDsfA/mECdzIr9gJk9Qs/fBzp3hre3A/aRCrM+0imRXttbLGv67YOC/K9W5kwy
         2vg3rjsCujRwPENVSdShPGzCRNGZ9hvCTMliAOnKckvDLpv0b3/DgS2ThBrce4PfpVSJ
         LoVETu1P5cxYrTpF4zgjKudUK9WSQHRTvoeRQP8KPPG7Zwtt8oXnGi/0kXoICfJtH9ND
         bSQzwWnaYyYcxpxQNY/3lxWp+oQAdpVJ7C0y8jGY4P0Di9koWN2KQeKjvdWsj6sSORwu
         ++E8L/eYMqo+jHxNR0Cqe8EEKfQUxAmRlkiogvZeN5hYc6/yCT4PwyM6P6KwB6xR+Lp6
         Iyng==
X-Gm-Message-State: AOAM532NkzvgREczjloDVw8VW/75lV79HCYr/Mp9ueUzsqVKkI3/qhDd
        pOskCQqXQopCk3ycyLFnzWQcN/noQsUCIpAAHSg=
X-Google-Smtp-Source: ABdhPJw9/Or/m/d2Vf6GucTmLluSf9xWrzOAepUCSiA4XOaY4VEMXGgCLe1+OE/2N7m70B9Io8cg6/HlLs/UXYJfABA=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:c86b:8269:af92:55a])
 (user=samitolvanen job=sendgmr) by 2002:ad4:5901:: with SMTP id
 ez1mr9997276qvb.38.1615510185992; Thu, 11 Mar 2021 16:49:45 -0800 (PST)
Date:   Thu, 11 Mar 2021 16:49:15 -0800
In-Reply-To: <20210312004919.669614-1-samitolvanen@google.com>
Message-Id: <20210312004919.669614-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210312004919.669614-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH 13/17] arm64: use __pa_function
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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
---
 arch/arm64/include/asm/mmu_context.h      | 2 +-
 arch/arm64/kernel/acpi_parking_protocol.c | 2 +-
 arch/arm64/kernel/cpu-reset.h             | 2 +-
 arch/arm64/kernel/cpufeature.c            | 2 +-
 arch/arm64/kernel/psci.c                  | 3 ++-
 arch/arm64/kernel/smp_spin_table.c        | 2 +-
 6 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index 70ce8c1d2b07..519d535532be 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -157,7 +157,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
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
2.31.0.rc2.261.g7f71774620-goog

