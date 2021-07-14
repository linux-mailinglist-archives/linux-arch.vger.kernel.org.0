Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE193C8B06
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbhGNSiH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 14:38:07 -0400
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com ([40.107.92.104]:37967
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240040AbhGNSiF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jul 2021 14:38:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOYqq6l/C7tEZXGmBR1dG/mpfSI3bXInQgDbdSONimIUz50+w7Jkq3YdB5KxqqXNb2n3v0j9s8LtZklbk3UPnH60fiHq8DCnzIAUcoG3LlF6SiWCr7Ty2bq2LQd8ZpBas5t3/BzW5g8pJERBTHz2e0uUp7FBaVJ6GEM2cZfkCB+5MdAQSUsAreLYQ5Wjehj9ES3cLVZmyFQrqS1cLoHJKwX+sb20ePfVewkQRGL4FVaxbdOh9Toy4QX/kWdRKD1S2ZmvwTYQAA8NLi8mJWDfdEcoiUtahnLtQ4Vt+054Q2yz/1sSaSjzacukXA+ygPAw9w109qu7HE3aJTp+HkWmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guVXlCsK09zdfQZ/fEPZTUTFN9VHtOp35WJ166Ot4Bg=;
 b=VxNf/q45FXrgpX9rfuBDXi2E97x8/MpXGkoEOzO9Eu9woUYSC4U670m0+L3NNNHArOlDTNAIxnq59/3Fy+1MrYQK9GDWrg+zdMW3NU6P8oNErYH+O0HDsbjXmutd5BugOaH3yjF5YqSYAxkYxtDsS62Xqin61jevN3m2USndKNZ6iIFIRgOylbGh8yU5eDPO7WldPItYiXOS4MpuwBjMxBQG5u7n4IO7Nn4EmFjJXDP38sXdLPtiZkn7pA3swQUIuEICuIObVCqlxC10ctBQfEWXjQpDKp9cRLWDS3XlDxTnnQF98BOmJDJLtAXAHX2UwJS7OOoPtBKyhp+NYKDWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guVXlCsK09zdfQZ/fEPZTUTFN9VHtOp35WJ166Ot4Bg=;
 b=JCK8lOhdI/kp4zvad8LsiJnpn7wQmsdvOauKP8eMFvlXsGB35eus87fRNLxmWKyZ77WdbKaKU02Fu7jSISovLHCxtF7PRYBxkbdlgzCXWcybYJA+uOzuHvSWarkSPjHOXz28akwhuBlIK6rWoSECb2+7SjfRNcIJeTavv8ZBU0M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1061.namprd21.prod.outlook.com (2603:10b6:4:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Wed, 14 Jul
 2021 18:35:11 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%6]) with mapi id 15.20.4352.008; Wed, 14 Jul 2021
 18:35:11 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH v2 3/3] Drivers: hv: Move Hyper-V misc functionality to arch-neutral code
Date:   Wed, 14 Jul 2021 11:34:47 -0700
Message-Id: <1626287687-2045-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
References: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.16) by MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 18:35:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac74b87-3a22-483f-d71a-08d946f61d06
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10617AA9ED184B504DD563FCD7139@DM5PR2101MB1061.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z6B/KWECG2eenP3GWNJ30T491QxnvcxOyd8jjGM+RP0/YNNzpOmOuQRF7qoIrtGi3MxmKVfFKuoR64ZT9bIlm4snbcqdJtLWKXKwAKYutc+PeOgWCs6M6YVrzjmv4EQJQxWiS6wOtuXVhOo3tTnSSYSb0RPthPHRaJqLpaw/XkuP9jFkwdOsZkxCvZNPuCunr6dIhDcY5JBos9/L/rWf8BwIhXBHiFZNhYtP0FuURD2sHFJ76pA4tDDw75VP4/IaEYr4dXVrXaoCO/X4Ho9hdBMwzBEJWRNHRPVEbLp2qwPmAFcdNUkH9fKQoIfrDaWenkgIwcQOOmtANn64eMXF4AgcGBd9deMxGOjqRCiV8GVMNqwb9fBVNCXLvsd4wBhDN9GWLcx70fWsY4e8L83/bdzlqc0mkLicPeWas6lAmHzoX/noLpMXJG0Sk4n4OHMHTYV3y3Q6VfON0L+NO8rk/u/Swbs+0cR9b7PwrNPbdtPLXoCubgYgrheAgS1PCcdWteYSy0h3gJgB2KjUiJMKq03OQfE/8ARCE1rPLik0+qMfI4v47gCOT+4VmjPzYHkNUh3JjtUGD94mF12gTAegVAmHmMTfSDmYo+WjfmNbWwsSIgMhHyUO/eKnbbtLQ0IblDFKBVeQyk75NxL+yWLND43m5ANSvVkbL2D1xlR3UvlYz81gKbptjjdwwahogMC4YEYt5KaXrNo8TojaiYlAl4DzxrmW23NiBVlt4QbKBDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(38350700002)(36756003)(6666004)(66476007)(316002)(10290500003)(26005)(921005)(38100700002)(5660300002)(82960400001)(6486002)(7696005)(66556008)(82950400001)(2616005)(956004)(4326008)(8676002)(86362001)(186003)(52116002)(2906002)(8936002)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hPeDPU0rPK2+yVUEiUJfj9+1phCiGht+Wrd+HAvaTtyuZCxT1rvrs4r5451D?=
 =?us-ascii?Q?GHyvxdQ0tWqMm/98Lrw44SMxWklSBRVGZUT59WGWGFx9reEImyGfMeSIuD8Z?=
 =?us-ascii?Q?MCZH5qzIQG0ntdgaMGQjLfNytIt2Y6dX2CQpyJ6ET7pdtU7M8YdpoqPsbANq?=
 =?us-ascii?Q?ZWrqSuDoxAjJUl0jTTL14y+z2MeKxZY4w5fpwN3jAylRDrICAEoJ+03UnuBH?=
 =?us-ascii?Q?mLV2oYqhoZ0Ewa9MLS++QlKtYfI0nNl/inAR5MPwt/qnGUpV1KKOAfEUuwJF?=
 =?us-ascii?Q?T1Lvprfu1cGXSbq3QKG9w8oZAUng7GvZtiCqaDCOpsvbUkaYw1dR5vH7u4nV?=
 =?us-ascii?Q?apqyAqDD9Msu8pzGG8LYGkm86h2GrIkc+cgEPQcEZITEOEALlrIQUF6sAxxb?=
 =?us-ascii?Q?x3Kv4miK3Sz2Y6/lao658rhvsslGQy2TeGp+JcofH5EQSlrDXfwhTX9rR/a/?=
 =?us-ascii?Q?yEcgX5vZHWL/GQdX9bzRQCWFtqCs0QTyp7x+ci13Dkfx1sRf8QCbO75LKoDr?=
 =?us-ascii?Q?DgWqkpVmcjLF9B2tKc832r9/HyaVv65N8VmHEV8pt7UvyUGgJ1paVQo1Eecl?=
 =?us-ascii?Q?30D30ueRPgDpojAYsSrCpjCSmuRQ5xLusmK1x+j40DhX8tpKAuhYFTbDvqfI?=
 =?us-ascii?Q?C9cNmScRF9EAk0vP+eajTZte/YNGDCf29IWDH3LygmfamdwnRI/xyVtDdKO/?=
 =?us-ascii?Q?pX5BPaQSKl1vbWUquyheX0qW55Npb5NKr0nWGPiMkub9Yc2XNv4aGFowfNLo?=
 =?us-ascii?Q?cVMPCy07/5CA1MTSlI2m+PEk8J9q0+Tsuf2XtlYDE0w/FMhVzwgeyGNoGY9E?=
 =?us-ascii?Q?zshL2hK1UEMsOBwClQSBzc1y4ZRbOXvNeVA94YVasq4uqtpPX5LREvYVj9aD?=
 =?us-ascii?Q?878tME2uk+ZckNRGNudyD1wKnQcRyGAdhh4I0wo1NxICvL+J5FzUpxaavp+k?=
 =?us-ascii?Q?bzzk+IwKI3PCzFqUhuJ+pyhBfvRGJn6pWUGHPIDIrvEqs5Gpj5qCTjEeghTA?=
 =?us-ascii?Q?ZRo76XqJTNoTDSmtItuvqYZ4PW3mqAmuDaOBcuCwlf6akpj6iH7udQ9xLdjI?=
 =?us-ascii?Q?e66pYJm/VgXwWOCH+hxpAMiyJgYSvIj//LEY4wFNF1gNw3ww37G56Ett/6UE?=
 =?us-ascii?Q?g8FSkWP34wl/g+5JQ1SHfJnxePdKg7F7PjcdT9XA/T1s4CUjyTmkluQWUkYK?=
 =?us-ascii?Q?01PWSuClgHRMV4woKi1EoVyF2kzcP+n033TXkPTqreKw14Xa0Y06hKEHssNj?=
 =?us-ascii?Q?9JTqSDRaL/tm4BeE7SroCzygwYJsk2SBQzdTb67zE/5DOtI3V7Zh/65PYWdA?=
 =?us-ascii?Q?fQ9wulRfiN3oK6CPT1AIOyVF?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac74b87-3a22-483f-d71a-08d946f61d06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 18:35:11.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKugtjk3hqZLKuxQEPMncnEHhapMg/4yUCvgL3PwpwiZbexgnSDai7yAmLIhfIE/P7KXBV1j+sBYcwF/hJQnrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
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
index 4e1491c..7639036 100644
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
@@ -326,16 +325,6 @@ static void __init ms_hyperv_init_platform(void)
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
index fe333f4..46658de 100644
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
@@ -71,6 +73,16 @@ int __init hv_common_init(void)
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
@@ -204,6 +216,12 @@ bool hv_query_ext_cap(u64 cap_query)
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

