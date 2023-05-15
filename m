Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0637035B1
	for <lists+linux-arch@lfdr.de>; Mon, 15 May 2023 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbjEORBU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 May 2023 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243446AbjEOQ7y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2023 12:59:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C46D7EF2;
        Mon, 15 May 2023 09:59:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-24e1d272b09so9579753a91.1;
        Mon, 15 May 2023 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684169983; x=1686761983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uuqW9g3Kzh89QsBclwPEw5z+GQNNv44ubXwM3rxo9bs=;
        b=WjhSLyyfkZ+DmhKUnLLxj+sUqsbLHlg9e06E2EbfzP29MJXAGncaO92k5DAYyAP6bn
         KZcb8ZuHEwPfQchpNDnXBz7jhj9a2kqefoBjlnd1GIEQBnykqsapQMfgs4vg6dMMYjVb
         wRspvsd6P2Yj9U8Rn3esOWk1RmHky++kBsCtGA0ixK3JF+eTOYYxTCqmMnQ5E8s0SiNB
         Dsly+S03ADlhdWwcYmpagB9yjK81MPy7dB5jBWAksBZUr/M/PHWpghpJnzwkL6KSKyhW
         7Z5Rq3UFxNA3G0K13qwGR4MDJCKwNvxh7AKGrsHcTdLxqiZuq0hAckl6m8KItx7Pk5MX
         OZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684169983; x=1686761983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uuqW9g3Kzh89QsBclwPEw5z+GQNNv44ubXwM3rxo9bs=;
        b=e5q50iXXUx3S1hl2oHTI293LafqT+bcmo45EfNc5PK27PWIXwZO62jILvieQEUawV1
         bDoUBrebF47Hl2St0E3l+60jiRgL2hPQFDVfoNd3R2eVtegKSdPYQG5Evf0iRbdaf9J5
         Awd6N7Xj8VAotnA0T917nc0jMlNAkRDYmkS+AQs4lCtP+nYdOTkzkDVYr42WbZJCS9KZ
         MDmCi5ofDGomDnFwsAcYphUGp1XzMUyDjE4435j84m+Kh0wdPyclvKOIZg2uecnVd5vc
         XzuxAOuXNc53/5hIxEGcxhzTVK9E1U3+IL1lK4dofkfnNLM++8uq4J2BgGnNesp0NGpk
         CGBw==
X-Gm-Message-State: AC+VfDySWcElNupzCy1a4jSxHjl7FVdXyXv9J5VIjbwc97mCCdUAbulA
        KtCUA42v1UqwnNABSsHazqY=
X-Google-Smtp-Source: ACHHUZ7b6649yFcCzLx6om2wHKRYIhFH3hiM3/2sh8UA/vkTQ1ZO0tZ4CbJTuMIjpE9E8k5iju1cRw==
X-Received: by 2002:a17:90a:fa85:b0:24d:eb38:bfa0 with SMTP id cu5-20020a17090afa8500b0024deb38bfa0mr35205756pjb.11.1684169983601;
        Mon, 15 May 2023 09:59:43 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:f:85bb:dfc8:391f:ff73])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090aa38d00b0024df6bbf5d8sm2151pjp.30.2023.05.15.09.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 09:59:43 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, seanjc@google.com, pbonzini@redhat.com,
        jgross@suse.com, tiala@microsoft.com, kirill@shutemov.name,
        jiangshan.ljs@antgroup.com, peterz@infradead.org,
        ashish.kalra@amd.com, srutherford@google.com,
        akpm@linux-foundation.org, anshuman.khandual@arm.com,
        pawan.kumar.gupta@linux.intel.com, adrian.hunter@intel.com,
        daniel.sneddon@linux.intel.com, alexander.shishkin@linux.intel.com,
        sandipan.das@amd.com, ray.huang@amd.com, brijesh.singh@amd.com,
        michael.roth@amd.com, thomas.lendacky@amd.com,
        venu.busireddy@oracle.com, sterritt@google.com,
        tony.luck@intel.com, samitolvanen@google.com, fenghua.yu@intel.com
Cc:     pangupta@amd.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [RFC PATCH V6 12/14] x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
Date:   Mon, 15 May 2023 12:59:14 -0400
Message-Id: <20230515165917.1306922-13-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515165917.1306922-1-ltykernel@gmail.com>
References: <20230515165917.1306922-1-ltykernel@gmail.com>
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

Read processor amd memory info from specific address which are
populated by Hyper-V. Initialize smp cpu related ops, pvalidate
system memory and add it into e820 table.

Signed-off-by: Tianyu Lan <tiala@microsoft.com>
---
Change since RFCv5:
	* Fix getting processor num in the
	hv_snp_get_smp_config() when ealry is false.

Change since RFCv4:
	* Add mem info addr to get mem layout info
---
 arch/x86/hyperv/ivm.c           | 87 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++
 arch/x86/kernel/cpu/mshyperv.c  |  3 ++
 3 files changed, 107 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 368b2731950e..85e4378f052f 100644
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
@@ -356,6 +363,86 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
+static __init void hv_snp_get_smp_config(unsigned int early)
+{
+	if (early)
+		return;
+
+	/*
+	 * There is no firmware and ACPI MADT table spport in
+	 * in the Hyper-V SEV-SNP enlightened guest. Set smp
+	 * related config variable.
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
+	 * directly without bootloader and so roms,
+	 * bios regions and reserve resources are not
+	 * available. Set these callback to NULL.
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
+	 * data(e.g, vcpu nnumber and the rest memory layout) needs to
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
index 939373791249..84e024ffacd5 100644
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
 void hv_ghcb_terminate(unsigned int set, unsigned int reason);
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
index 63a2bfbfe701..dea9b881180b 100644
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

