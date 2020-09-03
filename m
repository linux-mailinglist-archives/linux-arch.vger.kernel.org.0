Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9187425BE47
	for <lists+linux-arch@lfdr.de>; Thu,  3 Sep 2020 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgICJSc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Sep 2020 05:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgICJSA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Sep 2020 05:18:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23597C061246
        for <linux-arch@vger.kernel.org>; Thu,  3 Sep 2020 02:18:00 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id e23so2854926eja.3
        for <linux-arch@vger.kernel.org>; Thu, 03 Sep 2020 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kA/M5uo1pgexmorks7VPWASAyNAWS3vx6/WPRm8af9o=;
        b=Z3AwNlaf6J5hW5xgtHRnIRpOFoT8tF/HLwZ8GJ0e5cvG+dJo2ZV8Td+XYGpSz0PDPU
         yZ/Eba/KurKSLu2xTfCSNv8w3CSqYugtsRgbJhG+wLL490SlO28pS2CRnJpJnDP/DwCo
         +E/F0+gL8wXjD44TOvVWyXQD/GZW/uPbFgKF9ERR7IXDZMkzS0sEOUJoNgA1H6/Byx4y
         NSwW2yoSQkQeLoA3uSwlSJJ/rckcuNL/6FNJHtZa16XVwYykjh/5UAxiCobCQ1amihKK
         R0W7G3p7XxI5OMHuVyUdK3LZNxzxpOJDnETrkKBJ1UwfzsUT0SGPh94z2Picpt7x6ZPk
         rD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kA/M5uo1pgexmorks7VPWASAyNAWS3vx6/WPRm8af9o=;
        b=RPHJAmZhWGsBvX8q6rXU5PEM5k2z1drcBZVbMHojWCbbtiIoQmlIB41jLHVT1VFKab
         s7jvm/ZUiDK/y3YL2zit16DE3y90LTYln1V6+ZQzUCdMHTbu5V3DKi+AK0yr7BbK4KCr
         eIBPAQtHOy1mhgUh0DJgeNvZm1kdYdY9HRMexGc40Zs0ks6x26PnGXBhs53ipuAlAb4W
         UYSfW2E+z8sekGwiwn8Mbe4XqGbyNGmaHIvL620moiZzJL8PNlE2lwFFvo8lG39Xcxm0
         oh5P9u7rh+f5f86SlJSJLRdwDbQoHWQLDRmv1h8Zq14WEyhtnxBtigtwFSwAY0bKIEAr
         J+sg==
X-Gm-Message-State: AOAM532W79KiEG3mguagmnC6yZ79QKCWuD4QkbCSuhYyTr88gVqpMKqx
        +ySzblPfCzL8REu9Nd9Wk3Rcdg==
X-Google-Smtp-Source: ABdhPJxmXDw453SzS5U6zfFul53RqVj1EsU1USDwBl8Q/g0xulot4lLcRQNNUqR52/MOFV2rbWsbIQ==
X-Received: by 2002:a17:906:2f02:: with SMTP id v2mr1041974eji.465.1599124678549;
        Thu, 03 Sep 2020 02:17:58 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-919a-a06e-64ac-0036-822c-68d3.ipv6.broadband.iol.cz. [2a00:1028:919a:a06e:64ac:36:822c:68d3])
        by smtp.gmail.com with ESMTPSA id z23sm2614737eja.29.2020.09.03.02.17.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 02:17:57 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 09/10] kvm: arm64: Set up hyp percpu data for nVHE
Date:   Thu,  3 Sep 2020 11:17:11 +0200
Message-Id: <20200903091712.46456-10-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903091712.46456-1-dbrazdil@google.com>
References: <20200903091712.46456-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add hyp percpu section to linker script and rename the corresponding ELF
sections of hyp/nvhe object files. This moves all nVHE-specific percpu
variables to the new hyp percpu section.

Allocate sufficient amount of memory for all percpu hyp regions at global KVM
init time and create corresponding hyp mappings.

The base addresses of hyp percpu regions are kept in a dynamically allocated
array in the kernel.

Add NULL checks in PMU event-reset code as it may run before KVM memory is
initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 19 +++++++++--
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   | 10 ++++++
 arch/arm64/kvm/arm.c              | 56 +++++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S |  5 +++
 arch/arm64/kvm/pmu.c              |  5 ++-
 6 files changed, 90 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 2b89817cdb01..c87111c25d9e 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -72,8 +72,23 @@
 #define CHOOSE_VHE_SYM(sym)	sym
 #define CHOOSE_NVHE_SYM(sym)	kvm_nvhe_sym(sym)
 
-#define this_cpu_ptr_nvhe(sym)		this_cpu_ptr(&kvm_nvhe_sym(sym))
-#define per_cpu_ptr_nvhe(sym, cpu)	per_cpu_ptr(&kvm_nvhe_sym(sym), cpu)
+/* Array of percpu base addresses. Length of the array is nr_cpu_ids. */
+extern unsigned long *kvm_arm_hyp_percpu_base;
+
+/*
+ * Compute pointer to a symbol defined in nVHE percpu region.
+ * Returns NULL if percpu memory has not been allocated yet.
+ */
+#define this_cpu_ptr_nvhe(sym)	per_cpu_ptr_nvhe(sym, smp_processor_id())
+#define per_cpu_ptr_nvhe(sym, cpu)					\
+	({								\
+		unsigned long base, off;				\
+		base = kvm_arm_hyp_percpu_base				\
+			? kvm_arm_hyp_percpu_base[cpu] : 0;		\
+		off = (unsigned long)&kvm_nvhe_sym(sym) -		\
+		      (unsigned long)&kvm_nvhe_sym(__per_cpu_start);	\
+		base ? (typeof(kvm_nvhe_sym(sym))*)(base + off) : NULL;	\
+	})
 
 #ifndef __KVM_NVHE_HYPERVISOR__
 /*
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index 3994169985ef..5062553a6847 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -18,5 +18,6 @@ extern char __exittext_begin[], __exittext_end[];
 extern char __irqentry_text_start[], __irqentry_text_end[];
 extern char __mmuoff_data_start[], __mmuoff_data_end[];
 extern char __entry_tramp_text_start[], __entry_tramp_text_end[];
+extern char __kvm_nvhe___per_cpu_start[], __kvm_nvhe___per_cpu_end[];
 
 #endif /* __ASM_SECTIONS_H */
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7cba7623fcec..5904a4de9f40 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -15,6 +15,9 @@
 
 #include "image.h"
 
+#define __CONCAT3(x, y, z) x ## y ## z
+#define CONCAT3(x, y, z) __CONCAT3(x, y, z)
+
 OUTPUT_ARCH(aarch64)
 ENTRY(_text)
 
@@ -191,6 +194,13 @@ SECTIONS
 
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
+	/* KVM nVHE per-cpu section */
+	#undef PERCPU_SECTION_NAME
+	#undef PERCPU_SYMBOL_NAME
+	#define PERCPU_SECTION_NAME(suffix)	CONCAT3(.hyp, PERCPU_SECTION_BASE_NAME, suffix)
+	#define PERCPU_SYMBOL_NAME(name)	__kvm_nvhe_ ## name
+	PERCPU_SECTION(L1_CACHE_BYTES)
+
 	.rela.dyn : ALIGN(8) {
 		*(.rela .rela*)
 	}
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 8a1fcf4dffca..df7d133056ce 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+unsigned long *kvm_arm_hyp_percpu_base;
 
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
@@ -1255,6 +1256,15 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
+#define kvm_hyp_percpu_base(cpu)	((unsigned long)per_cpu_ptr_nvhe(__per_cpu_start, cpu))
+#define kvm_hyp_percpu_array_size	(nr_cpu_ids * sizeof(*kvm_arm_hyp_percpu_base))
+#define kvm_hyp_percpu_array_order	(get_order(kvm_hyp_percpu_array_size))
+#define kvm_hyp_percpu_start		(CHOOSE_NVHE_SYM(__per_cpu_start))
+#define kvm_hyp_percpu_end		(CHOOSE_NVHE_SYM(__per_cpu_end))
+#define kvm_hyp_percpu_size		((unsigned long)kvm_hyp_percpu_end - \
+					 (unsigned long)kvm_hyp_percpu_start)
+#define kvm_hyp_percpu_order		(kvm_hyp_percpu_size ? get_order(kvm_hyp_percpu_size) : 0)
+
 static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t pgd_ptr;
@@ -1270,8 +1280,8 @@ static void cpu_init_hyp_mode(void)
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
-	tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
-		     (unsigned long)kvm_ksym_ref(&kvm_host_data));
+	tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe(__per_cpu_start) -
+		    (unsigned long)kvm_ksym_ref(kvm_hyp_percpu_start);
 
 	pgd_ptr = kvm_mmu_get_httbr();
 	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
@@ -1503,8 +1513,11 @@ static void teardown_hyp_mode(void)
 	int cpu;
 
 	free_hyp_pgds();
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		free_hyp_page(per_cpu(kvm_arm_hyp_stack_page, cpu));
+		free_hyp_pages(kvm_hyp_percpu_base(cpu), kvm_hyp_percpu_order);
+	}
+	free_hyp_pages((unsigned long)kvm_arm_hyp_percpu_base, kvm_hyp_percpu_array_order);
 }
 
 /**
@@ -1537,6 +1550,28 @@ static int init_hyp_mode(void)
 		per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
 	}
 
+	/*
+	 * Allocate and initialize pages for Hypervisor-mode percpu regions.
+	 */
+	kvm_arm_hyp_percpu_base = (unsigned long *)alloc_hyp_pages(
+			GFP_KERNEL | __GFP_ZERO, kvm_hyp_percpu_array_order);
+	if (!kvm_arm_hyp_percpu_base) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+	for_each_possible_cpu(cpu) {
+		unsigned long percpu_base;
+
+		percpu_base = alloc_hyp_pages(GFP_KERNEL, kvm_hyp_percpu_order);
+		if (!percpu_base) {
+			err = -ENOMEM;
+			goto out_err;
+		}
+
+		memcpy((void *)percpu_base, kvm_hyp_percpu_start, kvm_hyp_percpu_size);
+		kvm_arm_hyp_percpu_base[cpu] = percpu_base;
+	}
+
 	/*
 	 * Map the Hyp-code called directly from the host
 	 */
@@ -1581,6 +1616,21 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	/*
+	 * Map Hyp percpu pages
+	 */
+	for_each_possible_cpu(cpu) {
+		char *percpu_begin = (char *)kvm_arm_hyp_percpu_base[cpu];
+		char *percpu_end = percpu_begin + PAGE_ALIGN(kvm_hyp_percpu_size);
+
+		err = create_hyp_mappings(percpu_begin, percpu_end, PAGE_HYP);
+
+		if (err) {
+			kvm_err("Cannot map hyp percpu region\n");
+			goto out_err;
+		}
+	}
+
 	for_each_possible_cpu(cpu) {
 		kvm_host_data_t *cpu_data;
 
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
index aaa0ce133a32..7d8c3fa004f4 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -11,4 +11,9 @@
 
 SECTIONS {
 	HYP_SECTION(.text)
+	HYP_SECTION(.data..percpu)
+	HYP_SECTION(.data..percpu..first)
+	HYP_SECTION(.data..percpu..page_aligned)
+	HYP_SECTION(.data..percpu..read_mostly)
+	HYP_SECTION(.data..percpu..shared_aligned)
 }
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 6d80ffe1ebfc..cd653091f213 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -33,7 +33,7 @@ void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
 {
 	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
 
-	if (!kvm_pmu_switch_needed(attr))
+	if (!ctx || !kvm_pmu_switch_needed(attr))
 		return;
 
 	if (!attr->exclude_host)
@@ -49,6 +49,9 @@ void kvm_clr_pmu_events(u32 clr)
 {
 	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
 
+	if (!ctx)
+		return;
+
 	ctx->pmu_events.events_host &= ~clr;
 	ctx->pmu_events.events_guest &= ~clr;
 }
-- 
2.28.0.402.g5ffc5be6b7-goog

