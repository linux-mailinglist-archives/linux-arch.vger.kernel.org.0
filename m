Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF242503CB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgHXQvN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:51:13 -0400
Received: from mail-dm6nam12on2104.outbound.protection.outlook.com ([40.107.243.104]:1074
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728738AbgHXQtE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:49:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gdv8x8/WPQTVu+yOQylZtAbV7qsUmK8SHBUbdNioy2kQ7SWyNIlvmNJn7xwDw9g9g1UyxeP0PMQlkFLuYDmyPI3TaxyzJEgw7UPQcOOXf9uFI1OtiSHerpS/F5gU5lsExChDHWiN/xSpwNTmGnkEDgTdwr8tK/A3aJ67bD1dZHHgR0BNMsyKAl522i2IW+RuchL38Ys7lPoP3vsL/JB9nI4CkxkMBWtJyaMK5ux74ubiynJ3AEKkW13ERe0Cw8xCH+QhYWVvCUzI6rmiQGdGr3MFwt72NKDEVOcnPL7r2Rii13ktpAdDz+NdJyVchwHfPjGh12ey3fFNcXwLbYE8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHgTfSh2/H9zYVYFD/dOYfqhNAkUx8fqSOk4VlRqeqA=;
 b=lC+vIEMdh8UkxMcASBNuT56M0tQY9c86vbK/+XrfnbSyXok2uvNa9y8d/dPSK30iZqbOPKiRRM3ZsVrOjYY01ZNv6iYfAkkIfMxe4r8HTnv2LpTgGHvxYGzCaohcaZb7hUSdE4EKzqdgUUwpm+VMhxBsPsoxYz3D1NoABTLdDrlFKPLtbg7YiU/HdrNAOOzVK5VfWqAlubqoQuFKUDhSCnU8eN+KyNlFB1XPYLdLh1g3Mblb2Ng29uzBXcq2N8nTqrTU+r3kh1Ie+SkqKjoVEVV5lMX1jLSFXFkM7UdkxRechDjjwN319hLybX4LFXitjuOXOw7NKIiDPlZii7Qy8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHgTfSh2/H9zYVYFD/dOYfqhNAkUx8fqSOk4VlRqeqA=;
 b=QBwwG7IA9giO4yspRudx2yRMLucV2myBefxCypFrs8j8/tykpimNxUHW4RAYQIFlwEWhPlfTHpIB6VPvg0g3qK6zNoE0CF4OoknNJ20pt5UiiDLU00AvvjNe5ADdG0/YDAW+ja2yVAMt5EBMxvoS7FlLzra4K76aGqj9UwI4hjc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:48:02 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:48:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 07/10] arm64: hyperv: Initialize hypervisor on boot
Date:   Mon, 24 Aug 2020 09:46:20 -0700
Message-Id: <1598287583-71762-8-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:52 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9294b233-cdce-4fe6-afe5-08d8484d7275
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB075379189FC4016AAF07299ED7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrQPtAK7Jsu8sCnVc4NSVYPNXjIsGjwUWeG2l4gznLVHH6Tj6vv+lf9WYN2jRsIdb2eQjOKuMwXVt8VNUY4a3NZFPFjKy6Mntc9+HD/v+STXe8u1tIMjiDB7vXSJh31oFAVkyGpOHxy5HToT5BghxNtI6vRAWMFnQHQi2S87rUXi6fc/YtPIIeHbGAz7+s3ExxJ9gIY7Zj0ndunbZJq+aldrfxskwb3rscIs2ubVnt1Dv7re7xzKi0Cx0/Ky1woiv1/xaqpNoPp3cvN8pPJvcYbrEOOMg/KhY3Ft0A8YWjw0VV48Wqpm/pDlTW6HLOKfaR+7bWwZ50xA5xZmSXXZlgKREQrhP4FJRN0DWC4GPW6RvjYv6OR3YkFv/XOHsQ5h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: p4lJb7dkjAc8d0RMuPlTCwKQzCLM3zmHvyPzgCZFgYg/UWaW/6trianOYiOMePHrCl1pFjMI+Bu4/K0nJPmTHsMP8Cp0LWj6xHyJv74haahVQ9qkNXGW+dGeGfCdPJeR91QSaAFmVBJ/E6ScdoGNDSszxNQEcRz9yDX8Z+OhVFOqkFq5ftmyDxCojG7gm82VJMV0BRa8/e67w9EV6mDv7MZQR5SoAxYAlqyhAArWT+Vmq0TKijSbqecdxawiRJcr24yXc1FIF+Kik3xRNomAw+y5n+ZQy5JBoUZrObnXNnSDiGMJPTWmTsNQ/43QWbt934q1My6JEBkhShesr4L8DKccydgF/92sRm/e6qvnPWOYA2MUdEC9/kk2srdvyYaFp9ovA9He+TcL71w6Oc7pm5a+nHYVzBuoLdRfoVhLYDz+Psf8Uq0+ZzGwwqJoZpUSBTbhjwER44kiznUsxqTuQKB6/oo+pQkKUX6MFAyJrLlVMw58Lw4/K1aqH/CfmQkq0gjwDajaI17vwGy5sBXpKLaaOpepYtSjI/khSXmrCe8a2ynpYNPUKYO04doPBbN2Rz/1xr197uXSamFNwcbwcYArrcrkAHuF/y8rMswirNX7mnXgMF2S8jarbU/rMzdV5CBsIU9KGwm19hS+9Sl15A==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9294b233-cdce-4fe6-afe5-08d8484d7275
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:54.8169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N7mH9/PkUYdE8WBambmUTI3VJrllwwXNgyce+55+MmYeByFgbhbRNYl4SuUPrf6BihQP69qZ2+KpUl1nHn0TQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
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
 arch/arm64/hyperv/hv_core.c | 144 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 966d815..831a69c 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -18,10 +18,41 @@
 #include <linux/slab.h>
 #include <linux/hyperv.h>
 #include <linux/arm-smccc.h>
+#include <linux/vmalloc.h>
+#include <linux/acpi.h>
+#include <linux/module.h>
+#include <linux/cpuhotplug.h>
+#include <linux/psci.h>
 #include <asm-generic/bug.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
+#include <asm/sysreg.h>
+#include <clocksource/hyperv_timer.h>
 
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
+	msr_vp_index = hv_get_vpreg(HV_REGISTER_VPINDEX);
+
+	hv_vp_index[smp_processor_id()] = msr_vp_index;
+
+	if (msr_vp_index > hv_max_vp_index)
+		hv_max_vp_index = msr_vp_index;
+
+	return 0;
+}
 
 /*
  * Functions for allocating and freeing memory with size and
@@ -67,6 +98,107 @@ void hv_free_hyperv_page(unsigned long addr)
 
 
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
+	struct hv_get_vp_registers_output result;
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
+	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
+	ms_hyperv.features = result.as32.a;
+	ms_hyperv.misc_features = result.as32.c;
+
+	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
+	ms_hyperv.hints = result.as32.a;
+
+	pr_info("Hyper-V: Features 0x%x, hints 0x%x, misc 0x%x\n",
+		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);
+
+	/*
+	 * If Hyper-V has crash notifications, set crash_kexec_post_notifiers
+	 * so that we will report the panic to Hyper-V before running kdump.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		crash_kexec_post_notifiers = true;
+
+	/* Get information about the Hyper-V host version */
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
+	a = result.as32.a;
+	b = result.as32.b;
+	c = result.as32.c;
+	d = result.as32.d;
+	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
+		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
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
@@ -291,3 +423,15 @@ void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
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

