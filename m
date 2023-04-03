Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1036D4F61
	for <lists+linux-arch@lfdr.de>; Mon,  3 Apr 2023 19:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjDCRo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Apr 2023 13:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjDCRoY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2023 13:44:24 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E572D79;
        Mon,  3 Apr 2023 10:44:21 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso31375857pjb.2;
        Mon, 03 Apr 2023 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680543861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EILUdjprvW3YCHuPVyOQT4JHVYk96Hi+rg/ChRnI6Q=;
        b=jPWllsA8sC/dmhbOuAo2Qx+3epE0R3wQgHMAcuJnzsLaz/a11VO0LTijIT+QuuDB9Z
         yG4qRWkEFTp/wR2EZevUqd1Kgrr7xy6KdAgr06eqR4Jdvdagb6g1RVoAXCj1olIlgf/k
         zt+EKUlufTHJ5U5NnUhrtI/7nX/vehXZTDywjDkP3kX5LdsxTMSLjOvRdxLHmG8ol6Uk
         1LKdEqyWzbzneDb094Mv/hvP32pymymL1nq6ICP2Qls/W3y/ZTvfb3pyXwt5Mi4zwczt
         vGTD9+7kntgIpUAfkYpUNVFEZ7dAu7+chyuW+ZIyANejzXY3ENb9Y/PBha4zQqAl7MSu
         ISKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680543861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EILUdjprvW3YCHuPVyOQT4JHVYk96Hi+rg/ChRnI6Q=;
        b=ed8b3LudEnDktTTJDzVKailTt+XjiMzNsi7lNZdyL3iC4OYBSy4zTV+dzbGr+lBJGj
         Vz4FcwtXm2wAU3pmztaPYlfAtLHetw6uA69ShzrLD6ZzbwEiozurv1mTmbeJX1PmOv8/
         1DXeZOVzgjE4o/s4E7F/D7KCiQVkFbQz2lBNxi4fEv98ca7PIDlUCdPGkApBizMD6bGf
         /1oYO9okwulknjE5PqhT7YQyoQiYB3j7worYrjiZCTazw6QepAdBvOXNjQwyz6Hn0c5q
         SU5McAfg3PVPxxZaqf6ifMqr+KiMPxOdodhbhZqxGX+C1scivlZfdpsSydlCgYmZ8gxY
         ca/Q==
X-Gm-Message-State: AAQBX9eDLgmJ6BwmNvo591PgPBqt8xYD6L7Te1cc2sqVaE2qgfsCqJnP
        UGUNpAU5TEKx5uYH1UAEvsU=
X-Google-Smtp-Source: AKy350Z0owT7mIkpcsyOL9tzWiFhFZY6B1QNzoj6nkv9SjCb9v7wJAwc1HXbKbL/RUnzRDBDTqIQoQ==
X-Received: by 2002:a17:903:32cd:b0:1a2:9ce6:648b with SMTP id i13-20020a17090332cd00b001a29ce6648bmr17755487plr.12.1680543860731;
        Mon, 03 Apr 2023 10:44:20 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:2:8635:6e96:35c1:c560])
        by smtp.gmail.com with ESMTPSA id jj21-20020a170903049500b001a19196af48sm6883803plb.64.2023.04.03.10.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 10:44:20 -0700 (PDT)
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
Subject: [RFC PATCH V4 08/17] x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
Date:   Mon,  3 Apr 2023 13:43:56 -0400
Message-Id: <20230403174406.4180472-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403174406.4180472-1-ltykernel@gmail.com>
References: <20230403174406.4180472-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/x86/hyperv/ivm.c           | 78 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 16 +++++++
 arch/x86/kernel/cpu/mshyperv.c  |  3 ++
 3 files changed, 97 insertions(+)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 368b2731950e..fa4de2761460 100644
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
 
@@ -57,6 +62,22 @@ union hv_ghcb {
 
 static u16 hv_ghcb_version __ro_after_init;
 
+static u32 processor_count;
+
+static __init void hv_snp_get_smp_config(unsigned int early)
+{
+	if (!early) {
+		while (num_processors < processor_count) {
+			early_per_cpu(x86_cpu_to_apicid, num_processors) = num_processors;
+			early_per_cpu(x86_bios_cpu_apicid, num_processors) = num_processors;
+			physid_set(num_processors, phys_cpu_present_map);
+			set_cpu_possible(num_processors, true);
+			set_cpu_present(num_processors, true);
+			num_processors++;
+		}
+	}
+}
+
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size)
 {
 	union hv_ghcb *hv_ghcb;
@@ -356,6 +377,63 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
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
+	x86_platform.legacy.reserve_bios_regions = 0;
+	x86_init.resources.probe_roms = x86_init_noop;
+	x86_init.resources.reserve_resources = x86_init_noop;
+	x86_init.mpparse.find_smp_config = x86_init_noop;
+	x86_init.mpparse.get_smp_config = hv_snp_get_smp_config;
+
+	/*
+	 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
+	 * and legacy APIC page read/write. Switch to hv apic here.
+	 */
+	disable_ioapic_support();
+
+	/* Read processor number and memory layout. */
+	processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
+	entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
+			+ sizeof(struct memory_map_entry));
+
+	/*
+	 * E820 table in the memory just describes memory for
+	 * kernel, ACPI table, cmdline, boot params and ramdisk.
+	 * Hyper-V popoulates the rest memory layout in the EN_SEV_
+	 * SNP_PROCESSOR_INFO_ADDR.
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
index 3c15e23162e7..a4a59007b5f2 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -41,6 +41,20 @@ extern bool hv_isolation_type_en_snp(void);
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+/*
+ * Hyper-V puts processor and memory layout info
+ * to this address in SEV-SNP enlightened guest.
+ */
+#define EN_SEV_SNP_PROCESSOR_INFO_ADDR 0x802000
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
@@ -246,12 +260,14 @@ void hv_ghcb_msr_read(u64 msr, u64 *value);
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
index 2f2dcb2370b6..71820bbf9e90 100644
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

