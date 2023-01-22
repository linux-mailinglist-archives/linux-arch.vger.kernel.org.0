Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DA7676AC6
	for <lists+linux-arch@lfdr.de>; Sun, 22 Jan 2023 03:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjAVCqi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 21 Jan 2023 21:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjAVCqe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 21 Jan 2023 21:46:34 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBE2244A9;
        Sat, 21 Jan 2023 18:46:23 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g68so6744374pgc.11;
        Sat, 21 Jan 2023 18:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnYtQQ1Y/HFKXDggPejFZRMsOajwCKlrShZxOBZUhc0=;
        b=ezxHRcyG1q3A3Vkb0DVGE2OVKiUCYY2LT6X7ODIti2UAcIkELTKv/p89t8n2Ey5afB
         o/g5npJBVqmKcrXeTOsg5fCM/MUKnmoTrYMfmH0M1W+enV9nRiE8NgShSPJfcULJWUws
         jGtZdrqVlbVfGu9RfaC3KhofEZQX/Gl1BdcEic95k1iCnNzK48favo5b5Zu1Y/lNOdiJ
         a2se4JewEAYWTMNggyOgVj29O4KBZYeOk1yOPbeQFNzqySaaNvZe10AOeZlpzNr61clJ
         50ql37m4X9ZRvlCalFT3akvGAC1cKvTMS+2jqsGJ94HjGuKSYxzfJwOg1C+cEhIt3/uO
         rOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnYtQQ1Y/HFKXDggPejFZRMsOajwCKlrShZxOBZUhc0=;
        b=HoL6YdyQCskwnvXJBDyf5vXvKAbRGaaaC/1q7xLmFiaqfyVwbl1yCZWKev1OxTTK/X
         nudZXHfu/NUhOUTfJqUD58LbG2bH7Hky3yvikEwa0uVkE6e/fEnHBnq2VOc/GOzkVprR
         pctc8h73eh8WElIMhxtgR2A2PfRhBEfTXtGHAjS39rbUFDk76ItnumfLWxL0vP6AN5kQ
         2yosDhhMtNG+YI7qlIG2zwXWqWHYNsq2gjnrApJ0ZJEwCFY+Tor/IhRyMaHLZDhoutKN
         ytnr8/iUtrmP060nGca2ioZrtaiCZF6EQblWs0chmdETd2Uqz1JmJoSxtAlny1jK9Vzd
         8y0Q==
X-Gm-Message-State: AFqh2kqn0IS2FwdRQwg+rZtLZW1qXqn0yJMXXyiKKBHUtGp87oNFZCq+
        idyRAIUB1ndFrFoMgS8c1Yo=
X-Google-Smtp-Source: AMrXdXucsaaYtNVA/g7jMccZBqdEqIy30skzYtj5NDJQwyiIMH+H6yV4LgagcWsf8el85V8qlL0rBw==
X-Received: by 2002:a05:6a00:278d:b0:56b:f51d:820a with SMTP id bd13-20020a056a00278d00b0056bf51d820amr20193929pfb.7.1674355582863;
        Sat, 21 Jan 2023 18:46:22 -0800 (PST)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:d4:8b9d:a9e7:109b])
        by smtp.gmail.com with ESMTPSA id b75-20020a621b4e000000b0058ba53aaa75sm18523094pfb.99.2023.01.21.18.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 18:46:22 -0800 (PST)
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
Subject: [RFC PATCH V3 08/16] x86/hyperv: Initialize cpu and memory for sev-snp enlightened guest
Date:   Sat, 21 Jan 2023 21:45:58 -0500
Message-Id: <20230122024607.788454-9-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122024607.788454-1-ltykernel@gmail.com>
References: <20230122024607.788454-1-ltykernel@gmail.com>
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
 arch/x86/kernel/cpu/mshyperv.c | 85 ++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ace5901ba0fc..b1871a7bb4c9 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -32,6 +32,12 @@
 #include <asm/nmi.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/numa.h>
+#include <asm/coco.h>
+#include <asm/io_apic.h>
+#include <asm/svm.h>
+#include <asm/sev.h>
+#include <asm/realmode.h>
+#include <asm/e820/api.h>
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
@@ -251,6 +257,30 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 }
 #endif
 
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
@@ -258,6 +288,11 @@ static void __init ms_hyperv_init_platform(void)
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
@@ -466,6 +501,56 @@ static void __init ms_hyperv_init_platform(void)
 	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT))
 		mark_tsc_unstable("running on Hyper-V");
 
+	if (isolation_type_en_snp()) {
+		/*
+		 * Hyper-V enlightened snp guest boots kernel
+		 * directly without bootloader and so roms,
+		 * bios regions and reserve resources are not
+		 * available. Set these callback to NULL.
+		 */
+		x86_platform.legacy.reserve_bios_regions = x86_init_noop;
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
+
+		/* Read processor number and memory layout. */
+		processor_count = *(u32 *)__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR);
+		entry = (struct memory_map_entry *)(__va(EN_SEV_SNP_PROCESSOR_INFO_ADDR)
+				+ sizeof(struct memory_map_entry));
+
+		/*
+		 * E820 table in the memory just describes memory for
+		 * kernel, ACPI table, cmdline, boot params and ramdisk.
+		 * Hyper-V popoulates the rest memory layout in the EN_SEV_
+		 * SNP_PROCESSOR_INFO_ADDR.
+		 */
+		for (; entry->numpages != 0; entry++) {
+			e820_entry = &e820_table->entries[
+					e820_table->nr_entries - 1];
+			e820_end = e820_entry->addr + e820_entry->size;
+			ram_end = (entry->starting_gpn +
+				   entry->numpages) * PAGE_SIZE;
+
+			if (e820_end < entry->starting_gpn * PAGE_SIZE)
+				e820_end = entry->starting_gpn * PAGE_SIZE;
+
+			if (e820_end < ram_end) {
+				pr_info("Hyper-V: add e820 entry [mem %#018Lx-%#018Lx]\n", e820_end, ram_end - 1);
+				e820__range_add(e820_end, ram_end - e820_end,
+						E820_TYPE_RAM);
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

