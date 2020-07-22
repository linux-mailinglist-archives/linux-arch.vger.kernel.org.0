Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9A229D69
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jul 2020 18:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgGVQp0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jul 2020 12:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731195AbgGVQpP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jul 2020 12:45:15 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CBAC0619E0
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id f139so2619177wmf.5
        for <linux-arch@vger.kernel.org>; Wed, 22 Jul 2020 09:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=V96ak4i8UKYW1530XCTpq7OSsFZ4sEMYY/vy7g+OwDs=;
        b=O+j9vJMxDWg4Y7iNQtrBdo/PaCRmPCN0IrEKu0IAOXYNS4QWENM1txkn/akKPubHQt
         2Q9bO5sSIjnp7XX8FPY3pwRcbHoMqdMJkGzXaT88liZXeU7cj6sVsFUDq1KO/ckOzlAz
         QczOXDyjtOBABv852W5Tzx6/2+oXjm/PTaAoZQsN+a7dWEbseiKUqyXAyZZWizDvGnjU
         1FZUbG1JADmor77thW2lzkIlb3rOoNPKVh6tb9aPE4gepPFwYQCfH9Zb86Pby+wMTA/O
         NAZylWO739DSTe2kT8txIfBsXMeHOQKFBra06R5Omocjlvxtbruuk8RbcoziaI81HyVd
         QAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V96ak4i8UKYW1530XCTpq7OSsFZ4sEMYY/vy7g+OwDs=;
        b=l92FIw1dILX0fWFfOHURu/fBz6yAaLBo1N8unqMLGvR0naumz4XD3nQxA2zFFaKjJt
         PYI6tRxLviDspMwNFmSE1VIiFd7F3642d6BkoVfGWbTMOBPBd0PHY4uyYKlZMUi2P7iD
         WxqbB1PeL8mHZkuQF2awBLu54jNqZeFokKYD2ys/OB3DBKPI8RUuG3JMNf0HtYeqqleN
         Qkk2yN9sXdpRtwmsdQh7/VsOrrMdVMpb043vq7PO6MMYqk/90Z0UAtquxfyxSEt+0+a0
         a2QHv+657T4X0hrMigLiNEFIRtOf4k2bPOOi+LkAJMdSOeeg3+SdrWgY8+diqwoDfhvj
         HsKg==
X-Gm-Message-State: AOAM532Z1Ku2Pwn+RqkDj0q42UJBDLcOONLXQbYm8EB1vtOPMdsnnHv7
        GUIxvti0HqUvjxrShvYMrwd85A==
X-Google-Smtp-Source: ABdhPJzzu8w3H0zHy13NXlQtb/DWOK/nCH71MNq45VhKumCJJVIQ8gvuKohqxVj5jKeuYtcbVRZ2Vg==
X-Received: by 2002:a1c:2045:: with SMTP id g66mr452060wmg.184.1595436313169;
        Wed, 22 Jul 2020 09:45:13 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:b0ee:900a:e004:b9d0])
        by smtp.gmail.com with ESMTPSA id h5sm521647wrc.97.2020.07.22.09.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 09:45:12 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org,
        kernel-team@google.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 8/9] kvm: arm64: Set up hyp percpu data for nVHE
Date:   Wed, 22 Jul 2020 17:44:23 +0100
Message-Id: <20200722164424.42225-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
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
init time, and create corresponding hyp mappings.

The base addresses of hyp percpu regions are kept in a dynamically allocated
array in the kernel.

Add NULL checks in PMU event-reset code as it may run before KVM memory is
initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 19 +++++++++--
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/vmlinux.lds.S   | 10 ++++++
 arch/arm64/kvm/arm.c              | 55 +++++++++++++++++++++++++++++--
 arch/arm64/kvm/hyp/nvhe/Makefile  |  2 ++
 arch/arm64/kvm/pmu.c              |  5 ++-
 6 files changed, 86 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 3d69cab873e4..22e63e651702 100644
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
index 6827da7f3aa5..c678615ccd6d 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -16,6 +16,9 @@
 
 #include "image.h"
 
+#define __CONCAT3(x, y, z) x ## y ## z
+#define CONCAT3(x, y, z) __CONCAT3(x, y, z)
+
 OUTPUT_ARCH(aarch64)
 ENTRY(_text)
 
@@ -187,6 +190,13 @@ SECTIONS
 
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
index dc557b380c87..bbbc5c1519a9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
+unsigned long *kvm_arm_hyp_percpu_base;
 
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
@@ -1253,6 +1254,15 @@ long kvm_arch_vm_ioctl(struct file *filp,
 	}
 }
 
+#define kvm_hyp_percpu_base(cpu)	((unsigned long)per_cpu_ptr_nvhe(__per_cpu_start, cpu))
+#define kvm_hyp_percpu_array_size	(nr_cpu_ids * sizeof(*kvm_arm_hyp_percpu_base))
+#define kvm_hyp_percpu_array_order	(get_order(kvm_hyp_percpu_array_size))
+#define kvm_hyp_percpu_begin		CHOOSE_NVHE_SYM(__per_cpu_start)
+#define kvm_hyp_percpu_size		((unsigned long)CHOOSE_NVHE_SYM(__per_cpu_end) - \
+					 (unsigned long)CHOOSE_NVHE_SYM(__per_cpu_start))
+#define kvm_hyp_percpu_order		(kvm_hyp_percpu_size \
+						? get_order(kvm_hyp_percpu_size) : 0)
+
 static void cpu_init_hyp_mode(void)
 {
 	phys_addr_t pgd_ptr;
@@ -1268,8 +1278,8 @@ static void cpu_init_hyp_mode(void)
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
-	tpidr_el2 = ((unsigned long)this_cpu_ptr(&kvm_host_data) -
-		     (unsigned long)kvm_ksym_ref(&kvm_host_data));
+	tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe(__per_cpu_start) -
+		    (unsigned long)kvm_ksym_ref(kvm_hyp_percpu_begin);
 
 	pgd_ptr = kvm_mmu_get_httbr();
 	hyp_stack_ptr = __this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE;
@@ -1501,8 +1511,11 @@ static void teardown_hyp_mode(void)
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
@@ -1535,6 +1548,28 @@ static int init_hyp_mode(void)
 		per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
 	}
 
+	/*
+	 * Allocate and initialize pages for Hypervisor-mode percpu regions.
+	 */
+	kvm_arm_hyp_percpu_base = (unsigned long*)alloc_hyp_pages(
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
+		memcpy((void*)percpu_base, kvm_hyp_percpu_begin, kvm_hyp_percpu_size);
+		kvm_arm_hyp_percpu_base[cpu] = percpu_base;
+	}
+
 	/*
 	 * Map the Hyp-code called directly from the host
 	 */
@@ -1579,6 +1614,20 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	/*
+	 * Map Hyp percpu pages
+	 */
+	for_each_possible_cpu(cpu) {
+		char *percpu_begin = (char *)kvm_arm_hyp_percpu_base[cpu];
+		char *percpu_end = percpu_begin + PAGE_ALIGN(kvm_hyp_percpu_size);
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
 
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 0b34414557d6..1d415698e60e 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -23,6 +23,8 @@ $(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
 quiet_cmd_hypcopy = HYPCOPY $@
       cmd_hypcopy = $(OBJCOPY)	--prefix-symbols=__kvm_nvhe_		\
 				--rename-section=.text=.hyp.text	\
+				--rename-section=.data..percpu=.hyp.data..percpu \
+				--rename-section=.data..percpu..read_mostly=.hyp.data..percpu..read_mostly \
 				$< $@
 
 # Remove ftrace and Shadow Call Stack CFLAGS.
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 717941910723..b4c8302f0798 100644
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
2.27.0

