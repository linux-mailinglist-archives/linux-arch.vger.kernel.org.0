Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2623B630B6C
	for <lists+linux-arch@lfdr.de>; Sat, 19 Nov 2022 04:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbiKSDsE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Nov 2022 22:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiKSDrH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Nov 2022 22:47:07 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF31BFF7B;
        Fri, 18 Nov 2022 19:46:55 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id q9so6648336pfg.5;
        Fri, 18 Nov 2022 19:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0YgLiOl0S0PjO9RGU6dEILmddfdRljq1tR8KTSAHbs=;
        b=cVPhlzU8eK/Pt3xDnHgsJ/EHF7L2/ZjJbr+pz3d5HqMIYeseRIZI1jgD6y0biQtosF
         rtieszzeSK7hKuyl2HXeDG4Mrwi/qYTrDyrOpoRqjlJ9OCEO/gZ0t36hMi7G7I5Y6dTj
         MoJ+c32mi1FDPxQdD/0+oaI+GcXzbze8q+bhg60VRpC0McbMEtP/RgOk0BNMhOeYLdsH
         lDL7T8zBTE8mVFKGK7I00Nizec9pcy6C36Q4BMB/5vjKDUSS1pZfvjJFIHqc5/jGbP2e
         trK5AoClykpbtJhpDVGaRNSyKMA0i4lSlX74HZwdOmswu+YOpcuTuJRZ5sQn+XZvNEKJ
         DE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0YgLiOl0S0PjO9RGU6dEILmddfdRljq1tR8KTSAHbs=;
        b=47yInzjKn1nxI5LL8RFim1P4KZku5EwKLsUS683dhBrr5aqsqP01rGsAzOE7LgI8SI
         0rwyAX5VPdsT6FKTmUO+0zA2fUuwiYQpAq1hMIAXuv9hXBd7RVSHKNlILheXA/Z2gekQ
         pVZrswupKZt4sKmXVvhdoZ+ByxdfsVLWW1U6CBMuV/Oe7HZVj5XjkHWUnGpbWypj3+yz
         xoK4OlU1aFP3N3QQbMTYr1TEv2zhlPWa+tQKyoINHG9dLSBfvmvjWd4LddTFsIqRL8qc
         Mvtbqb0l9/Eu4Vzl78LaHY0+gt/+5xTD5m4sVvOeKZJR/KxGLhXZQhQGHm54G+fnEHI+
         To9g==
X-Gm-Message-State: ANoB5pkDNJvfuu/yJ16zOufayeRpiepujlKjn1WRc5jr9qXZgYpLx26T
        OOBkUp19cyz1LE5dMajPJ8hGEb3YI1X3VA==
X-Google-Smtp-Source: AA0mqf56dEhRWdRWvzLyGPnEqRp10609+I0je6wOhyvoa8UBAoHSVxZY65PfscIPqv8kvCLC9fZVMA==
X-Received: by 2002:a63:4e4c:0:b0:46f:dc59:aab6 with SMTP id o12-20020a634e4c000000b0046fdc59aab6mr9347136pgl.35.1668829615127;
        Fri, 18 Nov 2022 19:46:55 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:38:f087:1794:92c5:f8f0])
        by smtp.gmail.com with ESMTPSA id e5-20020a056a0000c500b005360da6b26bsm3913892pfj.159.2022.11.18.19.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:46:54 -0800 (PST)
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
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC PATCH V2 12/18] x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
Date:   Fri, 18 Nov 2022 22:46:26 -0500
Message-Id: <20221119034633.1728632-13-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221119034633.1728632-1-ltykernel@gmail.com>
References: <20221119034633.1728632-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/x86/kernel/cpu/mshyperv.c | 75 ++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 2ea4f21c6172..f0c97210c64a 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -34,6 +34,12 @@
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
 #include <asm/coco.h>
+#include <asm/io_apic.h>
+#include <asm/svm.h>
+#include <asm/sev.h>
+#include <asm/sev-snp.h>
+#include <asm/realmode.h>
+#include <asm/e820/api.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -253,6 +259,33 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 }
 #endif
 
+static __init int hv_snp_set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static __init void hv_snp_get_rtc_noop(struct timespec64 *now) { }
+
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
+struct memory_map_entry {
+	u64 starting_gpn;
+	u64 numpages;
+	u16 type;
+	u16 flags;
+	u32 reserved;
+};
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax;
@@ -260,6 +293,11 @@ static void __init ms_hyperv_init_platform(void)
 	int hv_host_info_ebx;
 	int hv_host_info_ecx;
 	int hv_host_info_edx;
+	struct memory_map_entry *entry;
+	struct e820_entry *e820_entry;
+	u64 e820_end;
+	u64 ram_end;
+	u64 page;
 
 #ifdef CONFIG_PARAVIRT
 	pv_info.name = "Hyper-V";
@@ -477,6 +515,43 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		x86_platform.legacy.reserve_bios_regions = 0;
+		x86_platform.set_wallclock = hv_snp_set_rtc_noop;
+		x86_platform.get_wallclock = hv_snp_get_rtc_noop;
+		x86_init.resources.probe_roms = x86_init_noop;
+		x86_init.resources.reserve_resources = x86_init_noop;
+		x86_init.mpparse.find_smp_config = x86_init_noop;
+		x86_init.mpparse.get_smp_config = hv_snp_get_smp_config;
+
+		/*
+		 * Hyper-V SEV-SNP enlightened guest doesn't support ioapic
+		 * and legacy APIC page read/write. Switch to hv apic here.
+		 */
+		disable_ioapic_support();
+		hv_apic_init();
+
+		processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
+
+		entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
+				+ sizeof(struct memory_map_entry));
+
+		for (; entry->numpages != 0; entry++) {
+			e820_entry = &e820_table->entries[e820_table->nr_entries - 1];
+			e820_end = e820_entry->addr + e820_entry->size;
+			ram_end = (entry->starting_gpn + entry->numpages) * PAGE_SIZE;
+
+			if (e820_end < entry->starting_gpn * PAGE_SIZE)
+				e820_end = entry->starting_gpn * PAGE_SIZE;
+			if (e820_end < ram_end) {
+				pr_info("Hyper-V: add [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
+				e820__range_add(e820_end, ram_end - e820_end, E820_TYPE_RAM);
+				for (page = e820_end; page < ram_end; page += PAGE_SIZE)
+					pvalidate((unsigned long)__va(page), RMP_PG_SIZE_4K, true);
+			}
+		}
+	}
+
 	hardlockup_detector_disable();
 }
 
-- 
2.25.1

