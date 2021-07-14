Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C80E3C8B03
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhGNSiG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 14:38:06 -0400
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com ([40.107.92.104]:37967
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239999AbhGNSiE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jul 2021 14:38:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8sXDtLUH72j1KD1hk/L2ZG+V+lCdpxNXQ/B3KVZWJRdcSsBXz7zN//s7WO7TutU9roW7eLvDvWJMgY1sRvmpzDQGa5r7ByCJoYxlppymsn1HfbsTuctrVUS5KM5eK10FcuHeUVdVhOkj9zNq6jgnKiwD5Dv6CrHH3FVpNzKDswAZlVsef8ErQvr9SCErMFXwG/0iFB4Fttx4E6JPnMHF7HBbDwunBAmLLb0v00Y3XeLevFScHy6Hs76fZSJZQm6LiG+2VLC+8NAT7N5AR7wdUV2R4pxHDBDZ+gxNGunFERemPIYjReOzPPPuGCl8E40pnAbEcRy9Vi4E80FDm8CSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ripn2al5/5iw1N42pHcqYTWKapiAiXtmw05rgMtz0g=;
 b=D5C+WDOt7v6rKn//YK6aJvErM4nbNO+JfmlnBeVoTBCp5i5MHfIw5pWQT0i2nI3pMcGqFxIUWjSndDo/ryDwgt3mPGkTMwmr8ACjVmeW/cFPRyzbUeidrXMVrUfr8v+6tPz86IctKip9PyHPLyx3G+DUrHSmOMzW+u/eJWQsm9Bvyeds3PHkgV1VXkLuo0gDgteef/E1lGwQPJWf562ESmZ4PcvxGjn0nIYGPNRIFgCbuJ28oDhfyjuJ07gg9X1rKxKgVI/A4wmkVLX2qLpOGFKHWsFVfuxZdYIInq2Evtg6QTt5UJJpy+hWaGCUQqGRSW6HlDhgsbvuAOk2bftCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ripn2al5/5iw1N42pHcqYTWKapiAiXtmw05rgMtz0g=;
 b=FyTjzGsyS/CTp42mP0vbovBvDnvKNB4FHF740Yq+Em6B9XvsNxvyVVYfKM0qc6W/0NU/iMOflUfYMhAfa1SjUdnOjolohMBd9hx8yrz5VkRUYO/RyI0zz88lynEnhNswv9UUUXXge9B4HTph+W+8ZQfbqbZUsCpMoUstRn4gdrk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1061.namprd21.prod.outlook.com (2603:10b6:4:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Wed, 14 Jul
 2021 18:35:10 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%6]) with mapi id 15.20.4352.008; Wed, 14 Jul 2021
 18:35:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH v2 2/3] Drivers: hv: Add arch independent default functions for some Hyper-V handlers
Date:   Wed, 14 Jul 2021 11:34:46 -0700
Message-Id: <1626287687-2045-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
References: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.16) by MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 18:35:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aab5620b-4e1a-4d90-caf0-08d946f61c6c
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10616147FD837A3FD6DF66D3D7139@DM5PR2101MB1061.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MyoWmudIXtDuj1IBY8pmOghjOys554HWhVoPovXX6itX4mAnSzXdY/4VI+t35r3Elxpdc4AbI4OmNKA0xo0PY+78H/NUZuiuMKeoI/mgQ2sGvy9/Sj3nIn94r/R5YK9V8Pz9ZHxrnD7r8YKVySXUhGciveLGEtAQDy9NDHkV1cQTVxcC2igczIv27kRWPNwNdbeYeI/gmnoabOycAJBR/K6H49N8oUWjE+P6aYFZ8bVCC04+lMdwJZxshQW8L7ha9HgdSuSfFNbQ0CJo6ka3ySGCl95X+FjPGN1pZXRbaYIVpre7yEu5fj+1mmFIFEKZ38eEPDq6D0wDiSAsKmuIOu9NLwQk8apub0Ytd8PT5dfKz403WWlzEernFFXKa69w2BYLFw7QPK1OeP0D6PrkpjnQNgIeIRteq8QnrlkRilrI8poAKvXzy7vvX8jug6RSKgdQpKjl7lnfAg1OMRWUXjmUyd9agtZw/uPoHqMN0bqBNmF1B87Dv0q747Wi1K39kLZB+CKGVzP/zBjDt6pumZQ46J6dsqXyS2yq5YiorRvItVA0mnIRGrYSq5OpaDdeXJL4XICZvYOuHj6OpWW8geiN2XHudIiiL4nber7WwdhV1xQVNTKO9MDgZytOBvM1ZbqcS9YfiQfjxuzSq4igZn2WKPYZ+pRzvwRcTLNbh4pooS7Oumz7bTVYPgFGtSAPFW0fsoS4sLSsCZqjRLJD6OeywckA2+2TolXMMEqKLrw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(38350700002)(36756003)(6666004)(66476007)(316002)(10290500003)(26005)(921005)(38100700002)(5660300002)(82960400001)(6486002)(7696005)(66556008)(82950400001)(2616005)(956004)(4326008)(8676002)(86362001)(186003)(52116002)(2906002)(8936002)(478600001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HeKkk0o+48KT7Hatwl2w8+3bMSYYdvtrqL4d3tTQuCaBigDD0v8vYT+1wBNq?=
 =?us-ascii?Q?KctNQXivD6Lpm1+fZtlx2NPsoxvYQgAWKIZfkvs4Fkw9t0Qo0akZGDAxNfY4?=
 =?us-ascii?Q?2H/88weiVGbos+QRjEpciOKHsMxRcNfgRLhg2RTRH/aH9wAriwgKQCC9xmKu?=
 =?us-ascii?Q?QbLsGoRY3VRTF3l7Btn46qjvwuHaB2ViYjmw5tAB7JBmgcOONUZ6XY3V6W6U?=
 =?us-ascii?Q?f52+dF0oHFCkwriY3HUKJIkEM+Xm0MGbXB2ENYGPp0uCmrdhJiGaqiLXOJTe?=
 =?us-ascii?Q?eTGGriRFqKDKQ9JKOYfVHqqLxTFdZckjle1kAjFHigo6ZMJ8u5fqw2pMFbfB?=
 =?us-ascii?Q?rJEooEF7JjUMJLZm6JZAkoccapaOJoNn7A9ufTZXyBDyZy+qeAstGyphV89h?=
 =?us-ascii?Q?XjJsYOvh0/ik4vcQ0DjGlmTHhQ5Gn7q/aqXKTguI0oSnJ5ILBWhNoQxmdKRx?=
 =?us-ascii?Q?Xla+aGDTPcMOXd1T03t7Mmzxd117u2/Htzc2d4RVYG+B/Q3VP7kCOr1IRmr8?=
 =?us-ascii?Q?6l2N4HkS06PB2c8nLjziGSmZluPu6g7C8kZC+I5LA35hHMkJE72MElNTqq7B?=
 =?us-ascii?Q?8Jiicsg890h54DIdQjHp4xMntr2+t/s6xVF7DGchrVOOtogEx8gL1CcDacUZ?=
 =?us-ascii?Q?eWt0O4oObYgYKw21gzKst/tqnGtbKSyth8pwVaUDi2ZDZ9rPy4jc9a7T/vPa?=
 =?us-ascii?Q?fmFVpAo/PZ9O/cif/HQ6I7bKjqLLcJQWsZBF5G5bYzPv3C9IUHu1rfjHb7Lu?=
 =?us-ascii?Q?R6GBlHNKmZITGJyLlo1Qxvf2eM4v+ParS5Q8QCk8TCnOHiHIpucByerzGy3P?=
 =?us-ascii?Q?dbUtpEFlkxY2awBwtzZSWIiY8XK16p6H5zjtliOA2e3vD9fw7zY48LS1w8j2?=
 =?us-ascii?Q?MsCoalA+GYxv8/eooy2ss3NnPKgSp0Ys59+CQvb6DZVuhTJFQTjUq8Yg+Ctz?=
 =?us-ascii?Q?PmM3Z+f6rcBEpwRyCyH/cxudqrua2YhSQw2dNIRoYrzq+7vIPdmAJKpKqhj4?=
 =?us-ascii?Q?DdOBVdlYlu2TzLRNid3lg5DNjko4ywOWpZcgG0mHeZPPsE2gGJWCHoOYU453?=
 =?us-ascii?Q?RVZbcjOpDk0D+fOtqoxpRHIWSHaLvW5G1gK3C5OVRVrPskfmSdY5jlvzSt32?=
 =?us-ascii?Q?bt9yIY+soA5j9AlKnj7BzYQJsy8apmtHToa0RMe9DeCehJ7Hm+sEFKSgedZU?=
 =?us-ascii?Q?tbCarvoZMZaJL7N4IU0eCoEC7rNF0cUeqhfn1NUg7Try/95PcOoDQcMgNU93?=
 =?us-ascii?Q?Bnkfawr7ZTOhEZbFIVNUfUMyKpsreeUS7eQliMVnDp9f+Rxf0JO+EOmU0nSs?=
 =?us-ascii?Q?qcCH8PJNhh9foDVur63uaWEM?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab5620b-4e1a-4d90-caf0-08d946f61c6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 18:35:10.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CD22W0JC3Zqx10lhEPMEiUEnIJx9pwgbhj15zYM97QG+7s4ulAnMh6VQuo7vwZr3+ekR1qlsuTmDTwqt20byDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Architecture independent Hyper-V code calls various arch-specific handlers
when needed.  To aid in supporting multiple architectures, provide weak
defaults that can be overridden by arch-specific implementations where
appropriate.  But when arch-specific overrides aren't needed or haven't
been implemented yet for a particular architecture, these stubs reduce
the amount of clutter under arch/.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      |  2 --
 arch/x86/kernel/cpu/mshyperv.c |  6 ------
 drivers/hv/hv_common.c         | 49 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 5cc0c0f..e87a029 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -468,7 +468,6 @@ void hyperv_cleanup(void)
 	hypercall_msr.as_uint64 = 0;
 	wrmsrl(HV_X64_MSR_REFERENCE_TSC, hypercall_msr.as_uint64);
 }
-EXPORT_SYMBOL_GPL(hyperv_cleanup);
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 {
@@ -542,4 +541,3 @@ bool hv_is_isolation_supported(void)
 {
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
-EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4e78643..4e1491c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -62,14 +62,12 @@ void hv_setup_vmbus_handler(void (*handler)(void))
 {
 	vmbus_handler = handler;
 }
-EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
 
 void hv_remove_vmbus_handler(void)
 {
 	/* We have no way to deallocate the interrupt gate */
 	vmbus_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
 
 /*
  * Routines to do per-architecture handling of stimer0
@@ -104,25 +102,21 @@ void hv_setup_kexec_handler(void (*handler)(void))
 {
 	hv_kexec_handler = handler;
 }
-EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
 
 void hv_remove_kexec_handler(void)
 {
 	hv_kexec_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
 
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
 {
 	hv_crash_handler = handler;
 }
-EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
 
 void hv_remove_crash_handler(void)
 {
 	hv_crash_handler = NULL;
 }
-EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
 
 #ifdef CONFIG_KEXEC_CORE
 static void hv_machine_shutdown(void)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e836002b..fe333f4 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
+#include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
@@ -202,3 +203,51 @@ bool hv_query_ext_cap(u64 cap_query)
 	return hv_extended_cap & cap_query;
 }
 EXPORT_SYMBOL_GPL(hv_query_ext_cap);
+
+/* These __weak functions provide default "no-op" behavior and
+ * may be overridden by architecture specific versions. Architectures
+ * for which the default "no-op" behavior is sufficient can leave
+ * them unimplemented and not be cluttered with a bunch of stub
+ * functions in arch-specific code.
+ */
+
+bool __weak hv_is_isolation_supported(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
+
+void __weak hv_setup_vmbus_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_handler);
+
+void __weak hv_remove_vmbus_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_handler);
+
+void __weak hv_setup_kexec_handler(void (*handler)(void))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void __weak hv_remove_kexec_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void __weak hv_remove_crash_handler(void)
+{
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
+
+void __weak hyperv_cleanup(void)
+{
+}
+EXPORT_SYMBOL_GPL(hyperv_cleanup);
-- 
1.8.3.1

