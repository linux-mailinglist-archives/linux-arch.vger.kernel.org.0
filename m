Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4571773F2B8
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 05:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjF0D3E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 23:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjF0D2V (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 23:28:21 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B4211B;
        Mon, 26 Jun 2023 20:23:02 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55767141512so1729752a12.3;
        Mon, 26 Jun 2023 20:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687836182; x=1690428182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJTPSxR2JGN4fgMuHptSG8Hdo91/jubbscb7t5UbRBo=;
        b=rzDQGPnaqRnWoXI/FbVlXs2gDJI3IyYY8/Rj6Qj5+N2MJO35f66NUsLN3FZOKOxvSL
         WGIL4dO94S5C2vQEwP9Lsla+yoJpHQyNF7FI4yQulIMmk8XZK7HYG3Optpme14KVrNcc
         tfS6oMBXyV4T0FFCGQvEtsnihEy7EByahZhuCDvdAPZZ05cudg/bR6tQNmMWLeJjeokm
         iYflSwyu70PMdtzqFKRyKKwRSpHJaQQ41x+DJrnvt0kDrm7Pc15pRNsEbODakM1LMkiV
         VzHnMBb2hmaT1Gzi1v9FnexRjuNen5KcLwHnTjuv99mHPrN6biEG8TMgC0VrLPyo8C1z
         6TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687836182; x=1690428182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJTPSxR2JGN4fgMuHptSG8Hdo91/jubbscb7t5UbRBo=;
        b=QcoXjYaLniFBGaqmnqiEGFJ2da7c3GCrerxgqt/H+BRq8bxTPJ8tX0zchvlSJqig+c
         diZvuGZqemmn4U+7Cn/YGXKcxy56FjgPbT9nOfMS5e4hA15swn+yuihLrmFZ1eg9B52r
         nUgvYbWdf8eDd3qipFiJnW+iD6l0yL/Pl7VqTLjujXgElXLk9s1nFMHwzwdjw6xAr36o
         yoSxlliyyggZyMhUPsb5uEST0LC614N7GdnYSo973mLgYAeE25vGU4d0jrPVC+TQkwPF
         X1DVKFEn4oaipoCwvj0fnQUiM39M343L9tsJ/hWAZ5J+oK/FUMxqNctv2sI6ELo+R9EJ
         Umgg==
X-Gm-Message-State: AC+VfDwWmP0ZcX+2Mi/XdCRflqCzceBLhflHTDCr8FktOPnT7JW0kbl1
        5YaggEr1k3YuED4CPOx9l5k=
X-Google-Smtp-Source: ACHHUZ56iBuJLtVAaukBPyoox0Oef7/mADkIlMpGB/6P5aYK5LdhBfhzgwxNQaxPDd3TH6lp+RkCUg==
X-Received: by 2002:a17:90a:4902:b0:259:a879:cb8f with SMTP id c2-20020a17090a490200b00259a879cb8fmr16077197pjh.7.1687836182033;
        Mon, 26 Jun 2023 20:23:02 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:37:c5e9:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b0025ec54be16asm618756pjb.2.2023.06.26.20.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:23:01 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
Date:   Mon, 26 Jun 2023 23:22:45 -0400
Message-Id: <20230627032248.2170007-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627032248.2170007-1-ltykernel@gmail.com>
References: <20230627032248.2170007-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V enlightened guest doesn't have boot loader support.
Boot Linux kernel directly from hypervisor with data (kernel
image, initrd and parameter page) and memory for boot up that
is initialized via AMD SEV PSP protocol (Please reference
Section 4.5 Launching a Guest of [1]).

Kernel needs to read processor and memory info from EN_SEV_
SNP_PROCESSOR/MEM_INFO_ADDR address which are populated by
Hyper-V. The these data is prepared by hypervisor via SNP_
LAUNCH_UPDATE with page type SNP_PAGE_TYPE_UNMEASURED and
Initialize smp cpu related ops, validate system memory and
add them into e820 table.

[1]: https://www.amd.com/system/files/TechDocs/56860.pdf
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c           | 93 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 ++++++
 arch/x86/kernel/cpu/mshyperv.c  |  3 ++
 3 files changed, 113 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 5d3ee3124e00..b1639ec07155 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -17,6 +17,11 @@
 #include <asm/mem_encrypt.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
+#include <asm/coco.h>
+#include <asm/io_apic.h>
+#include <asm/sev.h>
+#include <asm/realmode.h>
+#include <asm/e820/api.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
@@ -57,6 +62,8 @@ union hv_ghcb {
 
 static u16 hv_ghcb_version __ro_after_init;
 
+static u32 processor_count;
+
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 {
 	union hv_ghcb *hv_ghcb;
@@ -356,6 +363,92 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
+static __init void hv_snp_get_smp_config(unsigned int early)
+{
+	/*
+	 * The "early" parameter can be true only if old-style AMD
+	 * Opteron NUMA detection is enabled, which should never be
+	 * the case for an SEV-SNP guest.  See CONFIG_AMD_NUMA.
+	 * For safety, just do nothing if "early" is true.
+	 */
+	if (early)
+		return;
+
+	/*
+	 * There is no firmware and ACPI MADT table support in
+	 * in the Hyper-V SEV-SNP enlightened guest. Set smp
+	 * related config variable here.
+	 */
+	while (num_processors < processor_count) {
+		early_per_cpu(x86_cpu_to_apicid, num_processors) = num_processors;
+		early_per_cpu(x86_bios_cpu_apicid, num_processors) = num_processors;
+		physid_set(num_processors, phys_cpu_present_map);
+		set_cpu_possible(num_processors, true);
+		set_cpu_present(num_processors, true);
+		num_processors++;
+	}
+}
+
+__init void hv_sev_init_mem_and_cpu(void)
+{
+	struct memory_map_entry *entry;
+	struct e820_entry *e820_entry;
+	u64 e820_end;
+	u64 ram_end;
+	u64 page;
+
+	/*
+	 * Hyper-V enlightened snp guest boots kernel
+	 * directly without bootloader. So roms, bios
+	 * regions and reserve resources are not available.
+	 * Set these callback to NULL.
+	 */
+	x86_platform.legacy.rtc			= 0;
+	x86_platform.legacy.reserve_bios_regions = 0;
+	x86_platform.set_wallclock		= set_rtc_noop;
+	x86_platform.get_wallclock		= get_rtc_noop;
+	x86_init.resources.probe_roms		= x86_init_noop;
+	x86_init.resources.reserve_resources	= x86_init_noop;
+	x86_init.mpparse.find_smp_config	= x86_init_noop;
+	x86_init.mpparse.get_smp_config		= hv_snp_get_smp_config;
+
+	/*
+	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
+	 * and legacy APIC page read/write. Switch to hv apic here.
+	 */
+	disable_ioapic_support();
+
+	/* Get processor and mem info. */
+	processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
+	entry = (struct memory_map_entry *)__va(EN_SEV_SNP_MEM_INFO_ADDR);
+
+	/*
+	 * There is no bootloader/EFI firmware in the SEV SNP guest.
+	 * E820 table in the memory just describes memory for kernel,
+	 * ACPI table, cmdline, boot params and ramdisk. The dynamic
+	 * data(e.g, vcpu number and the rest memory layout) needs to
+	 * be read from EN_SEV_SNP_PROCESSOR_INFO_ADDR.
+	 */
+	for (; entry->numpages != 0; entry++) {
+		e820_entry = &e820_table->entries[
+				e820_table->nr_entries - 1];
+		e820_end = e820_entry->addr + e820_entry->size;
+		ram_end = (entry->starting_gpn +
+			   entry->numpages) * PAGE_SIZE;
+
+		if (e820_end < entry->starting_gpn * PAGE_SIZE)
+			e820_end = entry->starting_gpn * PAGE_SIZE;
+
+		if (e820_end < ram_end) {
+			pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
+			e820__range_add(e820_end, ram_end - e820_end,
+					E820_TYPE_RAM);
+			for (page = e820_end; page < ram_end; page += PAGE_SIZE)
+				pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
+		}
+	}
+}
+
 void __init hv_vtom_init(void)
 {
 	/*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index d859d7c5f5e8..7a9a6cdc2ae9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -50,6 +50,21 @@ extern bool hv_isolation_type_en_snp(void);
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+/*
+ * Hyper-V puts processor and memory layout info
+ * to this address in SEV-SNP enlightened guest.
+ */
+#define EN_SEV_SNP_PROCESSOR_INFO_ADDR  0x802000
+#define EN_SEV_SNP_MEM_INFO_ADDR	0x802018
+
+struct memory_map_entry {
+	u64 starting_gpn;
+	u64 numpages;
+	u16 type;
+	u16 flags;
+	u32 reserved;
+};
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
@@ -255,12 +270,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
+void hv_sev_init_mem_and_cpu(void);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
+static inline void hv_sev_init_mem_and_cpu(void) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 5398fb2f4d39..d3bb921ee7fe 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -529,6 +529,9 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
+	if (hv_isolation_type_en_snp())
+		hv_sev_init_mem_and_cpu();
+
 	hardlockup_detector_disable();
 }
 
-- 
2.25.1

