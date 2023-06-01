Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B4471A240
	for <lists+linux-arch@lfdr.de>; Thu,  1 Jun 2023 17:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjFAPRQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Jun 2023 11:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjFAPQj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Jun 2023 11:16:39 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66983188;
        Thu,  1 Jun 2023 08:16:37 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d44b198baso834386b3a.0;
        Thu, 01 Jun 2023 08:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685632597; x=1688224597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ryR3MCsZM/kE0vPKzSbMRAS9TkDfhZ1z5k+dMI2sQM=;
        b=fucOwaf1+OoDknMxiJnsAstyMXS8k3K1kx3ZtalFue2T/KM7gPPOgbASYDShrl/R2g
         jcUaVyxX1jIvc5cEw1Lwg3NJOElXM/yfCzdBmQtFNt0KQ+kYvTLNx6tu1sfXvwxEv1kb
         hQ9xJjQ+hdGX6CXA89e5SpeXeOCDNgW16T6mIFW4Z6Qtkyzmh3z/yshP0P1RpRDsOjuA
         R8ILWMxQi2gQ3fHKs+lrcIH3qlClRsGvyvJHWiKCGca+/PzTUdw5dujiBdlXchdnvEKp
         b8FgFs2920gMv9S8JE6PGcKmHb4q6ZOt2WUSDWS6VVjgp4PFn9lZV7Vyk8jBGDP/llFr
         44Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632597; x=1688224597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ryR3MCsZM/kE0vPKzSbMRAS9TkDfhZ1z5k+dMI2sQM=;
        b=Fsl+aADyQ/ZpAbJhd9aVWeKUAYHwbSuHggnv946WwziF+NDXoDVkW7T6P8Kb7E5Xs+
         aW1wPSkVmNQrpzSykxRxhcPm+8x6wJuaSSgRO0MstbspzBqQwE4QS9eSyXZX1U7fft0r
         IvoJwYDnfPOYNI4IOv6+sF8GQJukZzdgCzkTCY0awEQA6ARuc9drcPPsOTv4hT+Y1eLI
         xx82FgCUnJzPy5f44696XwNgUpTFHH0OWBmgBX4L979PiF0UYk/yDH44cIehaMvNsS7M
         695eMllvtvJVRhdQuQhzM8rFe+r2JokPAMhHo1Nm7Ddqv3dmx7YQkwxSuBQj1xfvo7e7
         2gYw==
X-Gm-Message-State: AC+VfDzyZlgUa/KoUF+JzI7ga/dqG8s2YoIV7anzf85biasHITBlLguq
        aEzDpyIIxHlcTF8CVz9OU00=
X-Google-Smtp-Source: ACHHUZ46u/DNVKakts88R/QrmsOhe5g5xo3zgf8d6BBugcoZT2M+XNVbZMZ3YEc0nmQYw/Vvk/wMdQ==
X-Received: by 2002:a05:6a00:987:b0:5a8:9858:750a with SMTP id u7-20020a056a00098700b005a89858750amr2663216pfg.13.1685632596768;
        Thu, 01 Jun 2023 08:16:36 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:9:e0c3:5ec1:4a35:2168])
        by smtp.gmail.com with ESMTPSA id f3-20020a635543000000b0051b460fd90fsm3282639pgm.8.2023.06.01.08.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 08:16:36 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 7/9] x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
Date:   Thu,  1 Jun 2023 11:16:20 -0400
Message-Id: <20230601151624.1757616-8-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230601151624.1757616-1-ltykernel@gmail.com>
References: <20230601151624.1757616-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <tiala@microsoft.com>

Hyper-V enlightened guest doesn't have boot loader support.
Boot Linux kernel directly from hypervisor with data(kernel
image, initrd and parameter page) and memory for boot up that
is initialized via AMD SEV PSP proctol LAUNCH_UPDATE_DATA
(Please refernce https://www.amd.com/system/files/TechDocs/
55766_SEV-KM_API_Specification.pdf 1.3.1 Launch).

Kernel needs to read processor and memory info from EN_SEV_
SNP_PROCESSOR/MEM_INFO_ADDR address which are populated by Hyper-V.
Initialize smp cpu related ops, validate system memory and add
it into e820 table.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
 arch/x86/hyperv/ivm.c           | 93 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 ++++++
 arch/x86/kernel/cpu/mshyperv.c  |  3 ++
 3 files changed, 113 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 5d3ee3124e00..e735507d0f54 100644
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
+	 * The "early" is only to be true when there is AMD
+	 * numa support. Hyper-V AMD SEV-SNP guest may not
+	 * have numa support. To make sure smp config is
+	 * always initialized, do that when early is false.
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
index 9186453251f7..48b9eab3daf6 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -528,6 +528,9 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
+	if (hv_isolation_type_en_snp())
+		hv_sev_init_mem_and_cpu();
+
 	hardlockup_detector_disable();
 }
 
-- 
2.25.1

