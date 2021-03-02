Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B461D32B4D6
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448234AbhCCF3n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:29:43 -0500
Received: from mail-dm6nam12on2127.outbound.protection.outlook.com ([40.107.243.127]:25289
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350940AbhCBVk1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:40:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kig18IBc6MNVfQM1gqooBvZyzsXEOBG3SblZjciW9Y74ph5dcC4yQECyz50PMdosw0tPQv8aEnpR2L1aioCQYpWPjHmV7fl5MCAFiuxG87Wa2gj2ERsZY6OIIQjH0gFEqUgSUnVZHlvPwb9MOo925fsfKGiSyOawAH31BnsvcMqsV0dlkpecAgcoOeMIKVa9TpJsN3ih9Q1fn2muXt01ZnMhHHICTkIavoXY7wvJUKobXUJqlxoKQv3apV85ShOgtK45s9R5jILPSmEissczdgrcc71O963nubvRZ2SNmZwvyeSnATiV/MPXYGNjZG+WcgtWwlQsC/EyctQ9F5DWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+TRh52ZTTgd4leP/p8jpMpsm0exSZVaTWMcxfgH76A=;
 b=ckhG6z6BEQ3PgZSJxgjE4eU0GCBipcy6AfnA9Ji1qH1MPCZimyjVt7KcvkCq83E+maHlHwt2ayUafpDautGDHI6v6imFp6g3/if+MJUvRgP9U8oMwubhQ8N1WOhHtXK4YA2sI1P+r/jptGB0ybaNTnkEhGIei84H2yElruALw66t/fmYW7CBoUuDQgptTmswu3maw9DxvOWWWBEPrEgivMlXeYTJdvJi9VZgRrVoYBbkNCvY1ot5AOq2u1y8tiGkTsR7rcBUC0DDMAJ0WOVdzBQqiKLJga3JoLFXMlx81fHPHphnMAxPGtMjYw84WhIDxbV+RULnZkG5cp/ZU2jHYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+TRh52ZTTgd4leP/p8jpMpsm0exSZVaTWMcxfgH76A=;
 b=SWP8K1oV+OZHLfzsrPJAPR9751k/iEcfYdBkoRmbAHXnoeOk8SwPofDlQCwTm/Qvr1sXE8siJyfTt77J29OFa2ilKf1C/P5hBj0vYyq+TcAcelSTW+/mby/K5G/DnoOHZ6T7TQF9daEder09KT25xumcoW91OUPCzSWKUhUabAA=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0153.namprd21.prod.outlook.com (2603:10b6:3:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Tue, 2 Mar
 2021 21:38:59 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:59 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 07/10] clocksource/drivers/hyper-v: Handle vDSO differences inline
Date:   Tue,  2 Mar 2021 13:38:19 -0800
Message-Id: <1614721102-2241-8-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.16]
X-ClientProxiedBy: MWHPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:300:117::15) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bdfb1f4e-6a38-41fa-b184-08d8ddc39699
X-MS-TrafficTypeDiagnostic: DM5PR21MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0153BE75157F0ECDF2DA068FD7999@DM5PR21MB0153.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ps7YtObYUeTYHkiSNJix9HD3QmL1vtWq0QcZBNXaet/5JL3kYZjTB7D/rDVbHGO+Zc45j0bxhOhQEJpA29Cy0uiWdWYdlubVmmZol33sZ8ayov3tO4hGo2S0UpD8LdmxzXMON9qFUDY0ZAGXDwM2RPPh4tNFb4x+ysccm3Qk2ESB9nAvNohVmHm3URCoN7LbRaOWYINqz+pzP/emF8Fopbfv8GZmO3wEs+ex8j3l/8Rx9v4eBctBwsozPvFgd+NmCVKFu89KMUTxQ8Q44+AqZztmii9uc/xkulq5duYRjnpglVLj7BOeXdLhb66vaJrWi2WzsCND476O2uP/0sn4gTmQWcAyiY0JsseuuTFKverUHo9NmEdM2rLaHueAiMrpb/YMlPRTvVs/upB3IW6r0lAtXc/NCRFJ6YirO4qRa+nisiCVVQb/kLX49C8DE8VkLiV+ZByUvdF4mLM/9fuRXJTAjMKs/9qIhg+dRR4GK11FKTzUbxawYM9WXIu+lJzRj8mJECSoeKumUqZ9NLuWhhQegOTerHHrXCCsYumG3BD+UreG1eDqDP/5HaMJj7N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(6486002)(16526019)(82950400001)(478600001)(10290500003)(186003)(82960400001)(956004)(5660300002)(52116002)(4326008)(2616005)(26005)(921005)(36756003)(8936002)(66476007)(83380400001)(66556008)(8676002)(66946007)(7416002)(86362001)(2906002)(316002)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?jMaOSRR1PROK4gOZwr/p0T3rjmYPJI7951EeDW3fEKB6BeFFxZ9iCFjkcwQV?=
 =?us-ascii?Q?S6ZJNLtC2Aj2Tzrv3/C8hXqM8JTHyce3P9yYQ1Cc0M1L6luqgt3Jb24K6Qrz?=
 =?us-ascii?Q?KXUrJGkyWYiRyUROtnPYjQeDRzzeXzoxV596FFTBVJu4n+o9e36feD19TsXS?=
 =?us-ascii?Q?9iDONB45C6j7UnNNjA7wDdCNB1IqgGtprD1c8p1YsuXwCsVsA4DNA2tZhRIT?=
 =?us-ascii?Q?eUrgUsMpP6uWwSFmXxo9QDpIldS3peF0+yQSmiFCBQG6I/Y+OExFUCc6zNhi?=
 =?us-ascii?Q?o4bxNrKtEcZcj2vcu6u9nXzy/Lb5HMtKxiOsv4NUb/+VeyhAPxc8iKN27cUD?=
 =?us-ascii?Q?1tEioxbr1JfQIGIs5M339tBO+BSXwwM6IisVvXaL8bkg5kfiSjTo08OvZo8e?=
 =?us-ascii?Q?JiH8wOftrLI6qZPAwHi/VrmbMwfWA3WGMFMTP757e+UyLCwzxkFjKmXXS5Dx?=
 =?us-ascii?Q?Z3mTZJmxI9FHGFmVdQUPw1cDo3XqT2tkUGvtvyH5DWog4LuxCtT1Ur3pRBDV?=
 =?us-ascii?Q?VAGKSsiRQGytoy87riVQgXl+9b1eYV7fYK4utbReWCOrDVMyNA5OuG44aD35?=
 =?us-ascii?Q?rOGRrA0tnENHPeroi1JNyJwXVqXEBxZwFHMAufcDb/PW8rdrovsuPC+cEmum?=
 =?us-ascii?Q?3GjVfsFqFYVTHr7g0/7A+Ar2bimk2oeVyJJkgWMyoOsuCH78AW0qucUglD5p?=
 =?us-ascii?Q?s7ubumsyjiKlcXllWsIz6XODRfFUD4XkiQGScCa7XvLwlXKT0UYHlKJG1XNP?=
 =?us-ascii?Q?X5HiweFNuzzGs1NptuNwR66VKDnIrQQL0opvSKcFJqv54K7VkAb+JRlml4+P?=
 =?us-ascii?Q?UowGT0pAsroofAsWGRi1/NelKMswqEXftTLmS74s6UNVByA3nsbYrZFgzSTK?=
 =?us-ascii?Q?LEoly2O8o0OMlmJn+u7BlxogZgaDxDIiNhBOScPl+ACatv1858NahJy0dMl7?=
 =?us-ascii?Q?TdSVS6am69vztqGDJtGaj5mYRBR5xjcBf+0Inh/5afpmyZpqpukIJnH+Mibj?=
 =?us-ascii?Q?mb+FSzEoubLDU26kEcrbUSJ0xdA0VBTKcxwb7EdxF+m7k0l034tGMstBnRBT?=
 =?us-ascii?Q?RWy16rT5SvIXas4vrvIWc+hrgQc0vs/JTZEJZLXPB4jGj/g5u1wX8dM40wLg?=
 =?us-ascii?Q?/CifD3CCAC2cw5dpztquF5E/Y7jiK79HgCHdKuIMKKkb2oFh8cadCsoYYT67?=
 =?us-ascii?Q?YRidlqHLB5RLspUQAFpdW/derkOeiASZRzS0wMX5gPUSj28ypkgcaxGIE12c?=
 =?us-ascii?Q?C+4RLIHETuqwqT0fiAGgge93evor9hIC4goKeN0ViWfNKGJ+5t9e33jWBo45?=
 =?us-ascii?Q?nRPRrHrlY04TWY0wcaHUMLDV?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfb1f4e-6a38-41fa-b184-08d8ddc39699
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:58.9175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JKzUVAVB5dJyC7LXLp+hvHwe9qAKdPiaUvwKGab0hf7bk6xNgCUf68iJmW36iex+2gVoXOgYcvJKsNGZAQ+pnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/mshyperv.h    |  4 ----
 drivers/clocksource/hyperv_timer.c | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index c10dd1c..4f566db 100644
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
index c73c127..06984fa 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -370,11 +370,13 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
+#ifdef VDSO_CLOCKMODE_HVCLOCK
 static int hv_cs_enable(struct clocksource *cs)
 {
-	hv_enable_vdso_clocksource();
+	vclocks_set_used(VDSO_CLOCKMODE_HVCLOCK);
 	return 0;
 }
+#endif
 
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
@@ -384,7 +386,12 @@ static int hv_cs_enable(struct clocksource *cs)
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 	.suspend= suspend_hv_clock_tsc,
 	.resume	= resume_hv_clock_tsc,
+#ifdef VDSO_CLOCKMODE_HVCLOCK
 	.enable = hv_cs_enable,
+	.vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK,
+#else
+	.vdso_clock_mode = VDSO_CLOCKMODE_NONE,
+#endif
 };
 
 static u64 notrace read_hv_clock_msr(void)
@@ -442,7 +449,6 @@ static bool __init hv_init_tsc_clocksource(void)
 	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 
-	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
 	hv_sched_clock_offset = hv_read_reference_counter();
-- 
1.8.3.1

