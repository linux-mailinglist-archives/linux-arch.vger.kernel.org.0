Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1147306523
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbhA0U2h (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:28:37 -0500
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:44481
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232880AbhA0U0d (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:26:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9NAeHHVujmuvpEvOTnivj5hHVMrA2SPsyTL/zOtmIRHLEto9JDKu3ozeoan7MZspAHuKSU/pPZF8aCKgp9z7xC0HkeG6dCUTyntDN1+OIFOJ94D54E1sbwVI9MhrqDXcsfQ4CM8y5RkqCjt9X8Zj2ot6jvl1FcODHvFASr3Qu8fCHHvaiPFGb7uKIfoB3q3UX1N+IC/Dfi17P/yrBPm2hR4CwlulvhyBNjH542X+xMXbKuoVFIPrHqM5HiVByPGrnDwLn9qGezfTBonG3ApQVz8MXe8c4H4uISLg5+ZuS3wVfbkGbWOJlzPIrOxz4a3O6/rWKL6KNh8Sm+MfWXXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhNUaOmoDEf/5RxN+vsAYSxI/++E8sybu0r4qz2zEYs=;
 b=Dur6pqmyBGtfoCtBx7oh6ADyx4MG+DyxaFlU//npyFsvCtnDlQ9a+FmkSCLrzCn5KdbdxJ2QH9Z3AsumSWXdWBl7hfquC5VpQ/vkAMgUzbR5C0CzmUjL/UJ3RE3QVHgL5J5E8U56+cXn3E+Wh0H0C4kkhXh80BaiI8MRQCZ5DvlYpsq0j1KvYpXRcS8gTOeF0h64lLxYy7x5jeiilfwecHhvxakZpIKLiEx+2/dFj4wnSE666AKXZl5YO+U/YtfOcJfuaHVKnuMaadN9kxzv8KCS0Kd1xl2ocCAbhOMOknEgBN9Zk+ClcFtb6nCNrmXXXW55reuRIOECETmjdfrM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhNUaOmoDEf/5RxN+vsAYSxI/++E8sybu0r4qz2zEYs=;
 b=X/VPVuqBcf13Y/ORNFOJbHMDJnJcDa89zhXOC8LFEzkOR/1Si3EvNhkZzYAHaZfMndMyF6NSbax/qa5yE/pVYp7iWwPGlJsKiwRXiA0i8ZLe7qznl9PnwVcoohzqxdZw5xte2z42svVahH/5hjmZ0IDumWhTaOFWHXiC7u4ZsQM=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:28 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 07/10] clocksource/drivers/hyper-v: Handle vDSO differences inline
Date:   Wed, 27 Jan 2021 12:23:42 -0800
Message-Id: <1611779025-21503-8-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To MN2PR21MB1213.namprd21.prod.outlook.com
 (2603:10b6:208:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c1c09900-ef71-4e8c-2489-08d8c3018b9a
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215AA4625BED7D3C951D6FCD7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p7xSNc79X5TqGINDQAvyK6lZxyoMnsJYO1ofzRKEs+wiv0ly3DNgZs937pAUSxhm1hhTnqkIrwRqTynpHbWKtL2Ar84KsVGxDDDu6gQ/ZHuhgwwdwS7Q6h+t9lbaV+X+UH64g8agDtMoO1XeVp6xujEV3/7EcZcWIc+B1KvMsHEIxOyrK0U3YNEGUQKx5c1bD05dneCK7Wa7DEJT/zybeI9Vk2PBOF20rvBz4WywsJGBOO1Xqnz4IEZtpykNDz+2oeX+LgngGdLAcUVH3CoovVDK35hWz9SlWrmCYjztYlMkC0oGNr156geRqXbjoTaTM4wg0A+sBlSEVSn87k0WLJCJBv7zLSD7aBs2xkCGAYuWiG30rNapJ93Qlqtre8+zG4HtX59tqMzkoYxI+mimX0BV3NGsSDUuOF6qm/ghYIcXDEN5uCqSwrZb40eIsKcWZ+aP+AOuBKLNG3+VrE5mizgNZC0XwAtftWxUmPg8GiHUrGbimnkH06B0wCSQpFRz+XqN8+1cJMdJwm5Fuf1kZxy03UiZ/PRDLIvX3ZFCA+cOzNiTeKQOVVP1HTluYOMD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?envdOYH3vDZqxQ8WjugVWjXkgdW0vkI8qJLxUb5En9gN1mH2TfkX7PjrVoEX?=
 =?us-ascii?Q?21qGEFMB4wO8MHdkdaNkaXCOn37tNWtCdbbjuwiaxn/xtVwBKPsN2nazGagb?=
 =?us-ascii?Q?8srTAoRK5LDOnsJbXBm1JFPhehON5X2cZFjxIgj1l2htwj31lLOXryLrJigK?=
 =?us-ascii?Q?giyGd5NqIK6KJaxWSRUvXBF3ks/cQOmquMfrO2A1v+T4Dgx2K5Eh6ANFMWch?=
 =?us-ascii?Q?VYFrX3pG2by+yYY6ZKTx0f6quxA2l/Nkq8o9Rj41qCuOxc5v9e538P5i96S7?=
 =?us-ascii?Q?Im9QbEQ+/1SFuiNKoQAXpGvA6Jval1k7+2eVzHQb17XcD2dC1dW9B62x7fDV?=
 =?us-ascii?Q?DEbUoDNXius4Sq/Qy20t3nmWODuCJ9qEeY5JGQoMdnMB1lOW89AtZABMfXdx?=
 =?us-ascii?Q?7uswTZKrZE8M4TAh1Vizs2KiJfP3mGDukyvTC7P0LpYIMUccPtRWVZ3dV8OP?=
 =?us-ascii?Q?dM0zq1uXcLFdlily8KUfl7ihmZoCCrxMfJbS1u3zL300qxAz2aFLyPTiw+Ei?=
 =?us-ascii?Q?EOwbpoD0yJMbAk9B424y6b3qr5MY8lF21F1wn3qPqs+Q3WhRYRmGF6KuhodL?=
 =?us-ascii?Q?3Y1xQEboxhYOVn7mXJW8nfqFsypILVBgtLijFjye4UrgphcEasPmN3HQ5wQ/?=
 =?us-ascii?Q?4n5Hj5yU5IIvDcJVyCis4JpwCpWLS7gedqHnAj/+hdw5fg8/NnRSKVszCOtP?=
 =?us-ascii?Q?J0d7uZZY3YXzDyvlyWhJa2Z9Nj3gQ+ByE+/SiVKjerRRCbuyhCDQFfhPUIiq?=
 =?us-ascii?Q?ZO796K2L93LbStZCJjXLFjcv7Q+swLDQzgrhflpfshou53JHS+oMhWcBfa/D?=
 =?us-ascii?Q?ig5qX4JEnsqkMCceD/lh9R9rCy2rja+HialhVDRdu4wCT4JwWKmovibsR8PH?=
 =?us-ascii?Q?cEvuWoTbcl6SsFrSRtE02LYaB1HkHl9vClu0YE7JCxgAQrA5YvHhNhL2YYXa?=
 =?us-ascii?Q?YdWRhb8Oy9IhKfwXpGuaB/cKIcDm34DTfk0b10XoHPAYnzhS8q081w483yef?=
 =?us-ascii?Q?t/gWKLFVT1ow7u12mc9QJsAk/yAuT75asei0f+Z71VIWwoDe2axQDeQKW/tF?=
 =?us-ascii?Q?sYR0MX+P?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c09900-ef71-4e8c-2489-08d8c3018b9a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:27.8832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Oa7yO1JgcsV0PDCCQptiK3Y5VUbqkuXVM1WTngzNsK8VRUUw3+qOV83psMMR0IyK+I+qtze8bSq0F6fgulyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

While the driver for the Hyper-V Reference TSC and STIMERs is architecture
neutral, vDSO is implemented for x86/x64, but not for ARM64.  Current code
calls into utility functions under arch/x86 (and coming, under arch/arm64)
to handle the difference.

Change this approach to handle the difference inline based on whether
VDSO_CLOCK_MODE_HVCLOCK is present.  The new approach removes code under
arch/* since the difference is tied more to the specifics of the Linux
implementation than to the architecture.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h    |  4 ----
 drivers/clocksource/hyperv_timer.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4d3e0c5..ed9dc56 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,10 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
 	return value;
 }
 
-#define hv_set_clocksource_vdso(val) \
-	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
-#define hv_enable_vdso_clocksource() \
-	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
 #define hv_get_raw_timer() rdtsc_ordered()
 
 /*
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 9425308..9cee6db 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -372,7 +372,9 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 
 static int hv_cs_enable(struct clocksource *cs)
 {
-	hv_enable_vdso_clocksource();
+#ifdef VDSO_CLOCKMODE_HVCLOCK
+	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
+#endif
 	return 0;
 }
 
@@ -385,6 +387,11 @@ static int hv_cs_enable(struct clocksource *cs)
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
 	.enable = hv_cs_enable,
+#ifdef VDSO_CLOCKMODE_HVCLOCK
+	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
+#else
+	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
+#endif
 };
 
 static u64 notrace read_hv_clock_msr(void)
@@ -439,7 +446,6 @@ static bool __init hv_init_tsc_clocksource(void)
 	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 
-	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
 	hv_sched_clock_offset = hv_read_reference_counter();
-- 
1.8.3.1

