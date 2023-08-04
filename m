Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7F77046F
	for <lists+linux-arch@lfdr.de>; Fri,  4 Aug 2023 17:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjHDPYB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Aug 2023 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjHDPXk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Aug 2023 11:23:40 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01BE4ECA;
        Fri,  4 Aug 2023 08:23:13 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2680182bc21so1211168a91.2;
        Fri, 04 Aug 2023 08:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691162592; x=1691767392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ilQ+OtySQykbmOy9rH55sJLBXlE4zan0gUeshOZx4U=;
        b=fjCSmhXXXjiFcUCVjV/wXBFi1uQXwKZumQQzsVZLfFZ5hVvj2DEFEaHPouVLB5TE9p
         rjU1+xwjW1BaVAtcVf6n2MmZtA70isRiUMcv8/ZCR0hlMOjRwFWdWBwMY6+pRlh7eTJx
         UX0NoZwwvk2hlYqb1Ij5ucQCRAB7V+EVx2NyV6kdTUkuUG4afPMUIyKB6ksJwl8rrSkD
         MlnW1GNIuRYNolc7BcFepHzT3cAdSeD5MCj962U5i1JlD1psD5lz152QI79B37PHqhE/
         jgDncRzvN1wYES9D3jaL44gBXhVqiUx/5U55PtFJ1/66Op+M+Do8PuLHHo0I6yvt33hL
         3FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162592; x=1691767392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ilQ+OtySQykbmOy9rH55sJLBXlE4zan0gUeshOZx4U=;
        b=VtbNSlEA3lQ5/lFzaWtcCIso74gQW3PNSzFHy1GphLhflTcyWiyeiC5zbY3ylyepEp
         DBpGn+Eng5Rrwz7quyDT2XvhMJeCrMNwfiyn+Law8byUAkkJvIlk5pSMfHA56gpysSnj
         lwxfUJeMuciikozzncPyYwnZzToQHWTCsd0ptnjoub4hqLPnTTvBsRrbjoxgHZ3LaIcT
         0fG7PxNpZL5Vmd3RB+okUsYUxXUkKZhkwLqdEy+BgdGL/ZgiM0/HVPJ3tTDbt0OBireQ
         Oh92VAGMo3cT5028TU0EH6D//EooqbtHkijh/vsrYW08NFHv3ZI8g59vKPUKru5j5yOF
         riXQ==
X-Gm-Message-State: AOJu0Ywn+NvI54ZlMIF+a4XzZbSSFqs+P+zhEp5sBBIBk6d8DfD0PVxB
        VbIoQY1hQCZ2rPj4nuIj6Zw=
X-Google-Smtp-Source: AGHT+IHw7eZU8kcuuXguiRFJGnk67UxM9091Iw/TOxbnqpvK854OpxpwRnFvB/u+JoEIxLh4dHzwXA==
X-Received: by 2002:a17:90b:4c51:b0:25e:d727:6fb4 with SMTP id np17-20020a17090b4c5100b0025ed7276fb4mr1710426pjb.2.1691162592540;
        Fri, 04 Aug 2023 08:23:12 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:a0bf:7946:90be:721b])
        by smtp.gmail.com with ESMTPSA id s21-20020a170902989500b001aaf2e8b1eesm1891325plp.248.2023.08.04.08.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 08:23:12 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, daniel.lezcano@linaro.org, arnd@arndb.de,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <tiala@microsoft.com>, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com, Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH V4 9/9] x86/hyperv: Initialize cpu and memory for SEV-SNP enlightened guest
Date:   Fri,  4 Aug 2023 11:22:53 -0400
Message-Id: <20230804152254.686317-10-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230804152254.686317-1-ltykernel@gmail.com>
References: <20230804152254.686317-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
Hyper-V. The data is prepared by hypervisor via SNP_
LAUNCH_UPDATE with page type SNP_PAGE_TYPE_UNMEASURED and
Initialize smp cpu related ops, validate system memory and
add them into e820 table.

[1]: https://www.amd.com/system/files/TechDocs/56860.pdf
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since v2:
	* Update change log.
---
 arch/x86/hyperv/ivm.c           | 88 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++
 arch/x86/kernel/cpu/mshyperv.c  |  3 ++
 3 files changed, 108 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ee08a0cd6da3..e86b2a54cdfd 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -67,6 +67,8 @@ union hv_ghcb {
 
 static u16 hv_ghcb_version __ro_after_init;
 
+static u32 processor_count;
+
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 {
 	union hv_ghcb *hv_ghcb;
@@ -457,6 +459,92 @@ int hv_snp_boot_ap(int cpu, unsigned long start_ip)
 	return ret;
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
+	 * and legacy APIC page read/write.
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
index 5173c3524873..c8f33a7af90e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -57,6 +57,21 @@ extern union hv_ghcb * __percpu *hv_ghcb_pg;
 #define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
 #define HV_AP_SEGMENT_LIMIT		0xffffffff
 
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
@@ -242,6 +257,7 @@ bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 void hv_vtom_init(void);
 int hv_snp_boot_ap(int cpu, unsigned long start_ip);
+void hv_sev_init_mem_and_cpu(void);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
@@ -249,6 +265,7 @@ static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline void hv_vtom_init(void) {}
 static int hv_snp_boot_ap(int cpu, unsigned long start_ip) {}
+static inline void hv_sev_init_mem_and_cpu(void) {}
 #endif
 
 extern bool hv_isolation_type_snp(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 29e836b950e1..ba9a3a65f664 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -539,6 +539,9 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
+	if (hv_isolation_type_en_snp())
+		hv_sev_init_mem_and_cpu();
+
 	hardlockup_detector_disable();
 }
 
-- 
2.25.1

