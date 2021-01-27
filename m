Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B2306527
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhA0U2y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:28:54 -0500
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:61825
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232845AbhA0U0q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:26:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/RziQ4Ls6kH7FTZ7ircfQL8P3f4GJWq/JIUBUVuJOUm9Sy+4JkZ04gBGL1NMhM8MZMNS/143T1BJEGyqCeXcOMCR8n3bmaYSEnb1Q+SXMKs9RtKa0CFY2B2xGt4/tz7tDtXYh0yMzsiWjJc11I1OKIS0sJy2ci7h1scM/l3F1ZlG0x281HD+ECZ2dViiKCY5YBPjSqovZoVE4sB4d5gFGWzLP15DRyCC5tA4LMudcjM6fJ3M9RA0a5POwOz2kF5uSZyol3+GqAYoDyurD3/FLq3uK9kQe1gtFBaNHh6QCzyAiQL1QjnSopgeNJUp2bCmgEkI7fGMtKD1YkID8I8dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhAfUxw2NRZemhWTVZLK969tPuGXatFKtx9tbwUjcoo=;
 b=HLGS7QdccM74EfRJ73RTvWwqsfNGxj5E3EDTuBXQD0OcmaziCUQyzbDO7jZr5GniqmJAf3gZUCoG3eYdeUm5qjEKiH35S+O0wLw5+WZJRZU6tLs5s5NxL3c2RFTqr0lBjQElGXPravDTWrTaPocF3IC7wcKQK0cNXSibmnec6PZuPrNEY3b/x+dcon7OAH3o3Aj50UXx2AhSTTv7atVTV03CdQbE1aK805B6bQLyVM2auC7yy4aobvIm+U+/XUkFx47dHXcMMPJN6DGGzfiByx5hfFvbGULI2sexiQYcVHkTDrT6wgyqTH/oNxnNG+LPtiN/W6Lh7vMRpOC/mN3f3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LhAfUxw2NRZemhWTVZLK969tPuGXatFKtx9tbwUjcoo=;
 b=eBu2Q0hThG8oI3FroOL/r/PI9DQ54iDvFZtE/v66Xv8hsARThgxXFdcrKuyXuAnqWtvnbLjshVDOLnP0j5u8YGnGAqXiiNJ7ShTpbRzzn8knFsPTX1ogvFROAKQDuCebo6jJPaeHc5xU5kCgcohLmwsJqsu3DHDq9+al9thcgc8=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:29 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:29 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 08/10] clocksource/drivers/hyper-v: Handle sched_clock differences inline
Date:   Wed, 27 Jan 2021 12:23:43 -0800
Message-Id: <1611779025-21503-9-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c7acab73-e5d4-4930-6216-08d8c3018c84
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB12158E85556B7181FF572AE2D7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QrQsvoTCKX43IouogQAToH20WHeui2QfgaoADLeoy+2CXiF1p8vkR4P4FykKk4UpVCK1ia24BUj/YebABNjL8fIB3Rq4Rxu5mzOSBXARNLg+Tfy2K1sd9Tmp4F4uO80TVdw4WVPMAKXTU25Wtu23o6gBPbsoKjd0w1n8TZ+ols/uMaPxR5nI+V/M2Ank/Wl7yRtHIDcntgDnldSzE8gD/ia5+Ne0M7dl/ZUUNEyCo2A/UziQuLF59mxfU/Es75BfjJL7jkoGvU3KptLjzBUCZBoMO2AiihdXDHpHdBGLeyB5pvxWrn72XORwe7g4e1gt5Iu+UYvFQoGm8o4yghFPCCwEa3OJ0fGmngmAft6o9YxOewuoH5ohWVg0+W3LbeRv3qbXkbAtBvmiAZ9JludJtSRsFvnePhAx5tivJQXcyS0KgmaT+10K9pZLMXR2dor4f65xqNmrzAlHwgBFJZ7dqfUh1TwrDNcvDtpUyvs0w2lRQIoHQXzL2LWb+ecwpxVvA1a8DAHVoa2K5r/Rj+XGnAmPNHDs2GsNtjri8bwu4Tdh0W7AK8RmorepKcFHB7+2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?swLV8DZoKRKBdLxKbzsmX/rBQP42XXKfQuMCd1L5i1C3tueOPienqEQHR26I?=
 =?us-ascii?Q?cH1H0SRKPklPhbOv+OMF//jh1UYAwAI7oN3AqktuHq/5SJZZ/mu+5bcS0YJm?=
 =?us-ascii?Q?Fn7Sdtitj+IDLnlzAX2wuOfeL4JCsgAHDsZ23tZQTA1CiF0cROMkrkSVp+7w?=
 =?us-ascii?Q?sQ7ooE0T4Bt4RMfYsPx+w+rh0evx5V0rEr0G6my7Z65imrgXub+hBzimTK4Y?=
 =?us-ascii?Q?RcsaIcj6ZQjGy+ZhMITYvXMGSxJOhCZB0+iXlztdw9U5iIsX3OQmJl60eJKF?=
 =?us-ascii?Q?T1D6Hrn4DsnzZyV/TlQ8d/VZxoGZ6BjM6Vi/W9ELTpivbuM9P9X7CJumQBlK?=
 =?us-ascii?Q?6RYcctiBchIPa0Z/6PxlQL9n7cQAhzfIgprwb+cvIAUB938YZGgxYJT/hQPw?=
 =?us-ascii?Q?n1RLyBssyS7fhQqyiBVYutOlqKlF8hU0Xe4vTRvK2xi3J6eK7I1UjddErcx+?=
 =?us-ascii?Q?DY+GJctDfNY07zGxvOh2uL4DZ3TsnvYRJFkFaiJfQhXwzh6j9UY7aME6MIJw?=
 =?us-ascii?Q?+8sR9IegwC1E6wUSw8y3jHdU/FYQbp8f8RAQ9HRSgLc3bWuvOuRyJbVJB59I?=
 =?us-ascii?Q?eCaouUVqkx+ijDJygPNuDJTdv1AO1GGhrWL8SsCYtZR/b0rx/Ko4HlI2Zzn5?=
 =?us-ascii?Q?F2NsVcsdXVFxSmtkKFPtkKJ/g3UidSKWIs9TYtaMT9AyQsKc4biQsON/3mFw?=
 =?us-ascii?Q?lPVpPHmcdeBetIc+4kULKTBLcC+qE4FN65TuNER+HsBYqwPm1wRGzo5Q47aF?=
 =?us-ascii?Q?6n3Rw5rzUhCjV8U634HcbAEdLTTazCIB+/vZi0lPSCL5F2Ej1GepbcyD08lP?=
 =?us-ascii?Q?UoEPuJMsaV6gIInBFL6rtHPTZ/1SL+Pn8urODAzBFtSb26HE0RXe9PbFt9kD?=
 =?us-ascii?Q?bAWVK75qTsd/uQdLrsJBtOr2lzHQ8K6RgMBmKyGd8ZtgGoN878isJY85IjkM?=
 =?us-ascii?Q?WomRxJAxnpahmae/taH38/+70eYuF2n2a1WJkk17SICBu2h7CEMuM1iGJwXB?=
 =?us-ascii?Q?PIUVMufnq7QoQ2ZCA2Y6oaDy/BsOKEhMdxa5ZvLKC21wskGzuQbS5fWObnlI?=
 =?us-ascii?Q?1gq2DZoC?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7acab73-e5d4-4930-6216-08d8c3018c84
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:29.4154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZu+C3Od91+ipkVSZR/Vadf3dBwq6lcLW6okCJ5CwclxYnfC3sowKF8Xh87f6BzytVVtsn2dIh/6v2pvLMjOUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

While the Hyper-V Reference TSC code is architecture neutral, the
pv_ops.time.sched_clock() function is implemented for x86/x64, but not
for ARM64. Current code calls a utility function under arch/x86 (and
coming, under arch/arm64) to handle the difference.

Change this approach to handle the difference inline based on whether
GENERIC_SCHED_CLOCK is present.  The new approach removes code under
arch/* since the difference is tied more to the specifics of the Linux
implementation than to the architecture.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h    | 11 -----------
 drivers/clocksource/hyperv_timer.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ed9dc56..5ccbba8 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -29,17 +29,6 @@ static inline u64 hv_get_register(unsigned int reg)
 
 #define hv_get_raw_timer() rdtsc_ordered()
 
-/*
- * Reference to pv_ops must be inline so objtool
- * detection of noinstr violations can work correctly.
- */
-static __always_inline void hv_setup_sched_clock(void *sched_clock)
-{
-#ifdef CONFIG_PARAVIRT
-	pv_ops.time.sched_clock = sched_clock;
-#endif
-}
-
 void hyperv_vector_handler(struct pt_regs *regs);
 
 static inline void hv_enable_stimer0_percpu_irq(int irq) {}
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 9cee6db..a2bee50 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -423,6 +423,27 @@ static u64 notrace read_hv_sched_clock_msr(void)
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * Reference to pv_ops must be inline so objtool
+ * detection of noinstr violations can work correctly.
+ */
+static __always_inline void hv_setup_sched_clock(void *sched_clock)
+{
+#ifdef CONFIG_GENERIC_SCHED_CLOCK
+	/*
+	 * We're on an architecture with generic sched clock (not x86/x64).
+	 * The Hyper-V sched clock read function returns nanoseconds, not
+	 * the normal 100ns units of the Hyper-V synthetic clock.
+	 */
+	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
+#else
+#ifdef CONFIG_PARAVIRT
+	/* We're on x86/x64 *and* using PV ops */
+	pv_ops.time.sched_clock = sched_clock;
+#endif
+#endif
+}
+
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
-- 
1.8.3.1

