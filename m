Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFC362350D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Nov 2022 21:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiKIUyb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Nov 2022 15:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbiKIUyQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Nov 2022 15:54:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1441130F71;
        Wed,  9 Nov 2022 12:54:15 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 6so9102965pgm.6;
        Wed, 09 Nov 2022 12:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0YgLiOl0S0PjO9RGU6dEILmddfdRljq1tR8KTSAHbs=;
        b=QO4DvPkJIb71Vac+YgbUUc8naxai3q2LPii1mDdSVwgYpblLLIwhA/6QV1KYf15pY/
         NEUYzqFaur0JJkEXlRjtQ4KR4E4SqwsdYaV6XcvXtPNCN9AsH3foUs7OeJD8rvNSdp2H
         3MKTN62NQdiPSs2fPoNXsvAH6geS/6AjfCFpwuYSPzKWhiKpu0prdr/L4etZOFejb3cD
         KfHjXpwQsnVYIUjzopLUFAr76G9TxCtb2JqAFo+ThZk5fSwojKTsX3V8N2E1Hibf6QeS
         A0bm9BNby9qSQJ9seF1ouaDu0eE9glPVhXXZ3DR8upimA9v5vwgTFn+9t7oOdDUE6JpZ
         gomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0YgLiOl0S0PjO9RGU6dEILmddfdRljq1tR8KTSAHbs=;
        b=EQK1Baz/b7p13CT6+w88DbulCCOiVIIEaR6No2vxve2+B3oM3DAldtcP2Xd+baKbpx
         XTg9IsE5uq0uUW2fi7nf9pjOXTsNv758uV72BdiXOmf2SQ9uKR2bFH3b6br9xF8vkYZq
         lfu8LOufDw7BoezhSLg3azKBVzqBvs8Z5Ah9ps+JPYgNzB6DATSV5lV+VOjLUDXVM8/Y
         PnLcHgdHI+7uMfknXGPr1RcfUMLdAHPFy2Fy1Gdj48gvmnH307A1l13COCuniX73db+Q
         6LjQ3nnNB+LcFAgVZodKCMVH4lON6wzjsT4sJV1P8xNaj6yWoEkHLgE5YCYgYEwlldmy
         U8Hw==
X-Gm-Message-State: ACrzQf3w0m2Rer6OCB2FgHbw5inXKfotl0sw2NY9mDmNb7ObZLb5GJna
        EoZadd40RxFD57ecX9B5B6U=
X-Google-Smtp-Source: AMsMyM60Ruxwb0NOF8P4hL8khXQbh9yWk/7QP60EiXK3zdUhyTP2S4gkYhG405QgLG2mLS60n+JzOA==
X-Received: by 2002:a63:de46:0:b0:46e:c3bd:e47d with SMTP id y6-20020a63de46000000b0046ec3bde47dmr52358101pgi.609.1668027254437;
        Wed, 09 Nov 2022 12:54:14 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:a:c616:2003:6c97:8057])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090a108200b002137d3da760sm1633984pja.39.2022.11.09.12.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 12:54:13 -0800 (PST)
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
Subject: [RFC PATCH 13/17] x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
Date:   Wed,  9 Nov 2022 15:53:48 -0500
Message-Id: <20221109205353.984745-14-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109205353.984745-1-ltykernel@gmail.com>
References: <20221109205353.984745-1-ltykernel@gmail.com>
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

