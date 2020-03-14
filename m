Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B041A185714
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCOBcA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:32:00 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgCOBb7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L2ptAX07Ear5eGKRKtMNdnTFJB8SvsJkAivw5Fpuil+4uKiYpJx4sZwFwxMbZdAR22mdJr9CvOf/AnQw78HznVLLlYt2oICT6MGSWfFiuOEn8BDE5epgfulMvJlcQPS3sAeEIhSYyQa63qbcQ4qDr7QFMByqdDBUJmeqE4mHwXeKNRyJpqJT7okXEeH2CoNpUrIjMoNfWJjrFU5Rwn8OPw7ovg7S5wClmkmYabWxW+NgsKRML+GsggiOzD7n5T7NRuQCVqvkkzm1Gao7C/b98fOo76+ZwfvfwpuWmoujNVg0LiQ96NahRlNn124igjR6dgkDRflKaNZUOWEpSQhZMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suUSYXNguT8xfC9uFnqAshmgUQ1E8dkQZqoj55BbqbY=;
 b=IeL38fYSx3741nlj2+QmzQ8Mvc/OZdGdSasK6XFopSAG91ZkBzXBB+3O4vOKEao3rhZYXIvEu5UN00LKLU/0Ddz1EWDm7Myrlou5Qal3Iu046/CipoXdQX8afPm46BzV6ufeUDynY8/xfFKEzmSPwDHCVxLo3mT7AqPPUyH83n+5mq3T3sSeLA/eAIOKYk8TDOtrB/6OkzLimGjqXFpYwHaTkvpIbXDNOBD/KdEqwzxoOV3v4sCS0gxtHs4iFaUYsUHblrt6zx58s/ud47nIeJZCar4VL0/SEmVKziyp8yxbW1FIjqQw7UG0jPI8fJJQMT756eTaA+MBH8C212K6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suUSYXNguT8xfC9uFnqAshmgUQ1E8dkQZqoj55BbqbY=;
 b=XXPxuMydiQ1jtACcs3hJGRgXQRcbdzFGrN8vYCh6bs3ZR2lGAoSxisjB9yxwY1xAzGg57Krf9hLGoQ2YXbOre3W1e97AfYyaumW8ay/aYCqYb6PBoarze2T6XkQf5RdwrFPP1EWQvVLb4Y0uo1WSHL94NRJlXm6P1yK3GLnIL4c=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:11 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v6 07/10] arm64: hyperv: Initialize hypervisor on boot
Date:   Sat, 14 Mar 2020 08:35:16 -0700
Message-Id: <1584200119-18594-8-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:10 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7614329-0c00-4f7e-d8f7-08d7c82d6c43
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB1632B8939A8363F2388CA171D7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jbdKXhJ3UWH/afnwm+RuDQnOGfVla2r0/EpU9HO0P5PNqVVCEnJNxhXTliCkLFiCAfqUReDRMACoZW1xiKdCVsBVKxIYrHGo7A4m7uOC9E/mnTHkNQHkXwCdgT2qVHud3sVsmmMGw1e4nvRUstnf7FHCP21zKCWC/B7XqwaNfLfsu/oZyzf0b9WRrJ4EgRDLXKHAc5rcWszRzQ7POb7f8A/GuQs+GrhMtqbM7/E7tbAzXijs1xZ9/IiRnz2W7dzeKO1B1+HK23fCvSjLqNsDyrefSX9NbcrahKlDiqf4MKA701zQ7g0KWPa7JzPOUpYxp1nIiOtkF+Wr8aPbYHRmutJE9Q8Tj1d+MUbLsiHYjNKlmgKy1Vb3bYnKA/e+b2/MZIF30PfEFI2VQyFps7/T2rHV8sSv2E4KPvRJF8mOk059lUtgMhzQudMEK4yT40iLe+0xV2n3wlWAC1NJeRLrQ9r6PIGtlRpq89WpOcR8vXh7eYJLKc4erD/2/vW/+LNE
X-MS-Exchange-AntiSpam-MessageData: DSyP+WTImJ+VSt1fR6LhWW1ftQpIZDibGieByerPDDu0NBvlJhbWU4FuBSfKNPxVTb6E/w5nwmDfFy10E5xAYgbPIsVCf3tCRbEQfzifpCNzCzEMMy3NERnfXp8MkDKgres2rZBaznMCYkhk16hpwg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7614329-0c00-4f7e-d8f7-08d7c82d6c43
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:11.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTxqta3oby9k29BG38HStTtX2q1Z1D9txN8c9QmabRJsR3W9fWUqfkLnFejERxuhOgoaBagV2kZKpkrrfu3EuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add ARM64-specific code to initialize the Hyper-V
hypervisor when booting as a guest VM. Provide functions
and data structures indicating hypervisor status that
are needed by VMbus driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/hv_core.c | 156 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 8d6de9f..b496f59 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -13,14 +13,47 @@
 #include <linux/types.h>
 #include <linux/version.h>
 #include <linux/export.h>
+#include <linux/vmalloc.h>
 #include <linux/mm.h>
+#include <linux/acpi.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/hyperv.h>
 #include <linux/arm-smccc.h>
 #include <linux/string.h>
+#include <linux/cpuhotplug.h>
+#include <linux/psci.h>
+#include <linux/sched_clock.h>
 #include <asm-generic/bug.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/sysreg.h>
+#include <clocksource/hyperv_timer.h>
+
+static bool    hyperv_initialized;
+
+struct         ms_hyperv_info ms_hyperv __ro_after_init;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+u32            *hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32            hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
+
+static int hv_cpu_init(unsigned int cpu)
+{
+	u64 msr_vp_index;
+
+	hv_get_vp_index(msr_vp_index);
+
+	hv_vp_index[smp_processor_id()] = msr_vp_index;
+
+	if (msr_vp_index > hv_max_vp_index)
+		hv_max_vp_index = msr_vp_index;
+
+	return 0;
+}
 
 
 /*
@@ -57,6 +90,117 @@ void hv_free_hyperv_page(unsigned long addr)
 
 
 /*
+ * This function is invoked via the ACPI clocksource probe mechanism. We
+ * don't actually use any values from the ACPI GTDT table, but we set up
+ * the Hyper-V synthetic clocksource and do other initialization for
+ * interacting with Hyper-V the first time.  Using early_initcall to invoke
+ * this function is too late because interrupts are already enabled at that
+ * point, and hv_init_clocksource() must run before interrupts are enabled.
+ *
+ * 1. Setup the guest ID.
+ * 2. Get features and hints info from Hyper-V
+ * 3. Setup per-cpu VP indices.
+ * 4. Initialize the Hyper-V clocksource.
+ */
+
+static int __init hyperv_init(struct acpi_table_header *table)
+{
+	struct hv_get_vp_register_output result;
+	u32	a, b, c, d;
+	u64	guest_id;
+	int	i, cpuhp;
+
+	/*
+	 * If we're in a VM on Hyper-V, the ACPI hypervisor_id field will
+	 * have the string "MsHyperV".
+	 */
+	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
+		return -EINVAL;
+
+	/* Setup the guest ID */
+	guest_id = generate_guest_id(0, LINUX_VERSION_CODE, 0);
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, guest_id);
+
+	/* Get the features and hints from Hyper-V */
+	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES, &result);
+	ms_hyperv.features = lower_32_bits(result.registervaluelow);
+	ms_hyperv.misc_features = lower_32_bits(result.registervaluehigh);
+
+	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
+	ms_hyperv.hints = lower_32_bits(result.registervaluelow);
+
+	pr_info("Hyper-V: Features 0x%x, misc features 0x%x, hints 0x%x\n",
+		ms_hyperv.features, ms_hyperv.misc_features, ms_hyperv.hints);
+
+	/*
+	 * Hyper-V on ARM64 doesn't support AutoEOI.  Add the hint
+	 * that tells architecture independent code not to use this
+	 * feature.
+	 */
+	ms_hyperv.hints |= HV_DEPRECATING_AEOI_RECOMMENDED;
+
+	/* Get information about the Hyper-V host version */
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
+	a = lower_32_bits(result.registervaluelow);
+	b = upper_32_bits(result.registervaluelow);
+	c = lower_32_bits(result.registervaluehigh);
+	d = upper_32_bits(result.registervaluehigh);
+	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		b >> 16, b & 0xFFFF, a, d & 0xFFFFFF, c, d >> 24);
+
+	/* Allocate and initialize percpu VP index array */
+	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index)
+		return -ENOMEM;
+
+	for (i = 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] = VP_INVAL;
+
+	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+			"arm64/hyperv_init:online", hv_cpu_init, NULL);
+	if (cpuhp < 0)
+		goto free_vp_index;
+
+	hv_init_clocksource();
+	if (hv_stimer_alloc())
+		goto remove_cpuhp_state;
+
+	hyperv_initialized = true;
+	return 0;
+
+remove_cpuhp_state:
+	cpuhp_remove_state(cpuhp);
+free_vp_index:
+	kfree(hv_vp_index);
+	hv_vp_index = NULL;
+	return -EINVAL;
+}
+TIMER_ACPI_DECLARE(hyperv, ACPI_SIG_GTDT, hyperv_init);
+
+
+/*
+ * Called from hv_init_clocksource() to do ARM64
+ * specific initialization of the sched clock
+ */
+void __init hv_setup_sched_clock(void *sched_clock)
+{
+	sched_clock_register(sched_clock, 64, HV_CLOCK_HZ);
+}
+
+/*
+ * This routine is called before kexec/kdump, it does the required cleanup.
+ */
+void hyperv_cleanup(void)
+{
+	/* Reset our OS id */
+	hv_set_vpreg(HV_REGISTER_GUEST_OSID, 0);
+
+}
+EXPORT_SYMBOL_GPL(hyperv_cleanup);
+
+
+/*
  * hv_do_hypercall- Invoke the specified hypercall
  */
 u64 hv_do_hypercall(u64 control, void *input, void *output)
@@ -260,3 +404,15 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
 	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
 }
 EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
+
+bool hv_is_hyperv_initialized(void)
+{
+	return hyperv_initialized;
+}
+EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_is_hibernation_supported(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
-- 
1.8.3.1

