Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7513C41CC
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jul 2021 05:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbhGLD3H (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 11 Jul 2021 23:29:07 -0400
Received: from mail-mw2nam12on2112.outbound.protection.outlook.com ([40.107.244.112]:5176
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233079AbhGLD3G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 11 Jul 2021 23:29:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJyFRbj7eRcPo1XrHr1Dm3FazsSoULT4z+WXfcftYe/MvopBFFg4ou/mQ6gw3qtXmUeJqTq1rg0S1nI2f4N9bf2cPfsO0wNdrEtqCWi0UNoNIJT0C4S2PL/tSt0c3Wytx+br9/uaLQvonaz2lZ7YnyabqdrFPVgelNqKb5vfS8EByP2B24zzQikFJltvg3umowC4girRS++vvBn1OapUioTWOkCny/tl3l9eFa+g4p+tYYQN5ux6BGNVb2WU6LxDloc0dps8dEeEKvWORUu4s9vAc19Jl4TePVs8Tq1vlKktK+RLLnLnRVK9vmLI5HhPstwuKzQ9jQuTL1IWAqOr8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xPymjmMbxQt2Pqz55seYAsREWMDpZFeKY2C72bqRqw=;
 b=dViIPEfsjqEax6QxkLsShvUlIR/Xtctt47kSE5onc5HrGEkrsS2sALlnw+jAUiimOemawJCmGly17cHT2vn9s22uOJe4AA8Kjv/aOQyRBq19lHwZYzkyC4+7h1KtpJfMXnM9H8SNKp7QxpqVE1aMyLjGoWuYHgrkAO9M6KxynxjumOyLDkArJZvfJAQQ5V9u1S3tzH539+07y5tyuZ3QdFFP6+qtReGms9SNJ5KfaUuuN+DTLMDDxfyujMsw3t9SjandU9s/SeeXRlGh1oqWnN7xtijI3joVJV590KINlOWySuEk1SDUxtLnLR8ZJS9KuuoXbOWQj/RNeMhIUH7rzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xPymjmMbxQt2Pqz55seYAsREWMDpZFeKY2C72bqRqw=;
 b=C2WLb8r6a3IPmj59fZUrE7LOEl6DgR1iCEiTcn1tBV7m0p8o9I+TfC5WZALc7ZkKL+yDVbdmqQ+e9l24Dm4PVtme9tTUnP5tL4pvgbS0+GO9cOcSrAZwS4AgobIqssqBNs9HbwnAe3RhW5eJw8B2wRmbM6wVvxjtosInvYODFRU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1402.namprd21.prod.outlook.com (2603:10b6:5:256::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.8; Mon, 12 Jul
 2021 03:26:15 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%7]) with mapi id 15.20.4352.007; Mon, 12 Jul 2021
 03:26:15 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 3/3] Drivers: hv: Move Hyper-V misc functionality to arch-neutral code
Date:   Sun, 11 Jul 2021 20:25:16 -0700
Message-Id: <1626060316-2398-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.16) by MW4PR04CA0215.namprd04.prod.outlook.com (2603:10b6:303:87::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21 via Frontend Transport; Mon, 12 Jul 2021 03:26:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: decbeb84-6be2-47c8-098d-08d944e4ce1b
X-MS-TrafficTypeDiagnostic: DM6PR21MB1402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB140262D01F792A512F28A99ED7159@DM6PR21MB1402.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIclWNEVsCp/oXueX51661ZCRqPcS6/UR75gxXOTxAcfxVBnrib2/7BQZi3McENh3I7Yz0qYbE5OYTmshUr10xR4PD2SpX6jklkWCFG6zkXfq7wyNKZSraiOt0g57kSiRB9d7by7DZoKCtytcFyOmQnCiN/oiKZ9o2EtU3WX3SRGSO0BFBhN4KKEHJIdmF9iicabbCvIpn7zqdeKpx4yCTfIut8GXGapsFgJw+r+GlAfhedo0rQWzCU1yD53gOghQ3plTRx17RiPthX3TjXt0ruxhHFjDiVvMZyaOjNonmdi7gmPQKWQb8g64t0IzKvCB/SM2KtSnm5FFaIuUToaPHlVlAQ038xXe/pppXiBKgpCK2LtJxvSBK3JxNy6MHr+xj6FqaWTqRWmiNcqvFNGqKFd+WdCURHD4sVz/tHkvuYQHjR2WJKf3P+GQn5wUfE2oe6tBY14SQqx1If4sLzczSKRPxK0lwwgsNHPu8FVVqhfd37FXX04y2SUczn4XIL8WylE2NggWkwAvgl46vIQYxDPGQNsruait4dnH1qV31OeDKBpWuXPaopNqqfJTxalLPmvhS3PjyZ4lnTHFdkoR1de6eMzq5ksURTF0+DllG4bPYQ9QSH8nh7YFLVeiqWyUB7c39smo76VssaJhillBNCIVDGy7GtH4xwbl7wWKHRjUSQMthZvBQcW0UmoY9v1EdCHKbNrEBER6mSompvY2Jna2NMkCVU/Vk+KuwkAd7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(8936002)(7696005)(66946007)(2616005)(316002)(186003)(38100700002)(26005)(36756003)(38350700002)(83380400001)(478600001)(52116002)(8676002)(86362001)(7416002)(6486002)(66556008)(4326008)(82960400001)(82950400001)(921005)(5660300002)(66476007)(2906002)(10290500003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sqferprz4iqRmrat5UZo4WBKvF+u8T6rKa0alRfG5vz6S1qBdPsEtwuTgDOA?=
 =?us-ascii?Q?a1ODmHhx4RwgiEFYDH5AvhFKvHr1z8ivZHnZ19UMXXc9P+C57EQCIW69aYKE?=
 =?us-ascii?Q?zKScZFteD4zMsRLdsvM5lmLj4NIhnA6Jgm5AN00P0qgalysDHgMAol2W6yCC?=
 =?us-ascii?Q?6WX9Dnn/mGfaxv5ylbwU87uW9a0GA+mfFI+BQWj7IzqkKXBoP6slBLXk20TO?=
 =?us-ascii?Q?qmevYpbymF9A6RVVYNZAV+S7KsR3/UuagZ242O8M9hOp/o+ufpS8R8WNGC3g?=
 =?us-ascii?Q?it/c9CJnUJFHihhV8ecD6p69UI5doMJ10JkBPWN8oS+GDbNDv/uvKyPE2Mcu?=
 =?us-ascii?Q?bUGIXlyra7rtGY2K0F6jHx98TXzYsrjXAz6ylohNDW+Ygdi44mzVYVcCiEhi?=
 =?us-ascii?Q?UvJPVZ8HYe29DnCi5NEOM4/fine2nvPYkYV0pPh9RcuDlMEmKqYtZHgAYO8+?=
 =?us-ascii?Q?e2OyiYnC5kmkwyY0Btr7xEA84AlaP44gIbMI0vf0UWiDD2nSUli1D0DfPEKn?=
 =?us-ascii?Q?cSOep4zDvrMlGewbIinKMrTDmEo4LFFFtNXwNPcbN2pXSEtH10S9uvEubDo8?=
 =?us-ascii?Q?XwzxxK7heXms11bF3ZYqzan7uYTOy6CpRf68kiG69L3UUiJP5uX/7MZevjhb?=
 =?us-ascii?Q?eDglO23UJ59u22luYuq2w4mm7p5o+wNexxnaGzQyjvA//5rvf94iitMyDKsM?=
 =?us-ascii?Q?qsW9vsHrHDQYyItvBM/TG1f8xBMSGtJKXCp2rxg7XTbSAOUuqihfr331CglA?=
 =?us-ascii?Q?z8bI0TalmP3/JMH+tSpNPBqLHcVapVikCzuCCgzEZeKJHEcERQVXcxKe7RCy?=
 =?us-ascii?Q?cY3CthNMJhIA5i+LhfHSqBxnTz2V/hCQuvW452gnAvImr5w4/D5wT4p2ftFb?=
 =?us-ascii?Q?glBGijn98cD7ubQflOebPKLnD1SFq0RmaqhctC3lIJF1CZZp6qbDx/cojgeq?=
 =?us-ascii?Q?glc97YjPMNy8y9vhNODRuQts+O2QnO2I8JM+Y1CFDZsIvUUtYofiuBwXMTVy?=
 =?us-ascii?Q?sIPEInTVJCjFVbJmvAyRwFjcLMa4GuEEE1uETBDyQUCs/KK+Yp/MN56YH/xI?=
 =?us-ascii?Q?Fe3Lk3XxpMt2f7nqJiUSUTLBnSnZ70b8v6Ffhqyms6FHxxQZ4tcr4UlSRRgz?=
 =?us-ascii?Q?3I9y5iJ2nOCKgC7LNBnA/WEqR3osbr7Y9wXO2oaDqVFpQye8K6A16NtMb2jZ?=
 =?us-ascii?Q?n79e0gh9l2hjmSBEpy3sDM+l+1P+D8UhMf4wqq4hbGQvLPUdBMs9kTbbHS0t?=
 =?us-ascii?Q?gNUCuYDV9WkXUXdBb6OoT7LGMgv7V08mJHvHFztBVzwFN3hhreKLpZTuDkr/?=
 =?us-ascii?Q?7Xj63B1r+6G7VwBXmRL/0ogx?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decbeb84-6be2-47c8-098d-08d944e4ce1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2021 03:26:15.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D611SYBm8/fkVz3YmoWaRVJQf8ihvN3h+Ftwf0HRdALs3RlLNncwO4EDrsAemf3+VZwg7Sk/9RLTs6OhkURx2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1402
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The check for whether hibernation is possible, and the enabling of
Hyper-V panic notification during kexec, are both architecture neutral.
Move the code from under arch/x86 and into drivers/hv/hv_common.c where
it can also be used for ARM64.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      |  8 +-------
 arch/x86/kernel/cpu/mshyperv.c | 11 -----------
 drivers/hv/hv_common.c         | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e87a029..6f247e7 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -7,10 +7,10 @@
  * Author : K. Y. Srinivasan <kys@microsoft.com>
  */
 
-#include <linux/acpi.h>
 #include <linux/efi.h>
 #include <linux/types.h>
 #include <linux/bitfield.h>
+#include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/hypervisor.h>
@@ -523,12 +523,6 @@ bool hv_is_hyperv_initialized(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
 
-bool hv_is_hibernation_supported(void)
-{
-	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
-}
-EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
-
 enum hv_isolation_type hv_get_isolation_type(void)
 {
 	if (!(ms_hyperv.priv_high & HV_ISOLATION))
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 3e5a3f5..ec428e2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -17,7 +17,6 @@
 #include <linux/irq.h>
 #include <linux/kexec.h>
 #include <linux/i8253.h>
-#include <linux/panic_notifier.h>
 #include <linux/random.h>
 #include <asm/processor.h>
 #include <asm/hypervisor.h>
@@ -322,16 +321,6 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.nested_features);
 	}
 
-	/*
-	 * Hyper-V expects to get crash register data or kmsg when
-	 * crash enlightment is available and system crashes. Set
-	 * crash_kexec_post_notifiers to be true to make sure that
-	 * calling crash enlightment interface before running kdump
-	 * kernel.
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
-		crash_kexec_post_notifiers = true;
-
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
 	    ms_hyperv.misc_features & HV_FEATURE_FREQUENCY_MSRS_AVAILABLE) {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c429306..3ff8446 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -13,9 +13,11 @@
  */
 
 #include <linux/types.h>
+#include <linux/acpi.h>
 #include <linux/export.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
+#include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <asm/hyperv-tlfs.h>
@@ -64,6 +66,16 @@ int __init hv_common_init(void)
 	int i;
 
 	/*
+	 * Hyper-V expects to get crash register data or kmsg when
+	 * crash enlightment is available and system crashes. Set
+	 * crash_kexec_post_notifiers to be true to make sure that
+	 * calling crash enlightment interface before running kdump
+	 * kernel.
+	 */
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		crash_kexec_post_notifiers = true;
+
+	/*
 	 * Allocate the per-CPU state for the hypercall input arg.
 	 * If this allocation fails, we will not be able to setup
 	 * (per-CPU) hypercall input page and thus this failure is
@@ -197,6 +209,12 @@ bool hv_query_ext_cap(u64 cap_query)
 }
 EXPORT_SYMBOL_GPL(hv_query_ext_cap);
 
+bool hv_is_hibernation_supported(void)
+{
+	return !hv_root_partition && acpi_sleep_state_supported(ACPI_STATE_S4);
+}
+EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
+
 /* These __weak functions provide default "no-op" behavior and
  * may be overridden by architecture specific versions. Architectures
  * for which the default "no-op" behavior is sufficient can leave
-- 
1.8.3.1

