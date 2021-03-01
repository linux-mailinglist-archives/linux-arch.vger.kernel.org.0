Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B43275CF
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhCABSR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhCABSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:18:13 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD78C06178C;
        Sun, 28 Feb 2021 17:16:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTbaWysf0xYago+y3+aYTwRa6XdrYzQnztXl426DbKpE5t7KH+LlL4CQQ+v/MsvrnVN0JnZqfTT+sBkZEV2xPwPTsywTTeQFwhmmDJT6RvyPweDryjwk6wcb3xtBp0D3yivEBctN0yuo0dDqB7d7UGWB4wdVaGbitC+9U+9DZfg+TFCbg45WOfD5rAbJTT1gA7g1S+BzZUAd7zwS4jMRPt3gq20nYi96JSZlpB819Zt5gyT38Reu7nL+yHSeU1++xrfuv7cp3FwFg8L9TPS/W2VkFalWkrkRgmwfjWAHeki6rNd1eeeYVE59C5VqMgk31QO3b6adqX/BDBLj9+jzlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWglr6ZxccT4b4jpd2BLjaurKAYHkVnp+u7Qh1QaAaM=;
 b=gqd5UzKObWlktgWbBjOqKnvUffRfjJBiPfOxLNN1YWSwuNE7sV1FWAs+Wv1q6y7sK7/OW+XrFFm1gHDivJ1J+Dk20CPNeSlLyWU6FGr4d6ODkVxvjU/n0AdkVatCSd5/+qad7oa0Pcf02PnKAc94WqOX2WPg8um70UXTjEWKBr9DpXGTAMZFIqyfaLtpXhI5njY5RQWRmcOKvstYA8TQhPPKkLhKOjpcy7OrSYivPZesAj3p1escBzM7xo0COW128gS6UShG8M57Au13VTwswmsVFXKM6iwEUcUa7aUjHhuEoM/tMTkHkFEnFVNzdSKMtMoyswSsk3SLJq1oRDTPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWglr6ZxccT4b4jpd2BLjaurKAYHkVnp+u7Qh1QaAaM=;
 b=A8Pa+zDYm8a7V34ry3hLSsTGzrqDEtir/ABjol+S/ZdxMoeKPh8aN/c/JBKig9hI5y/UVi2L5F9sZ1Oq4Ggn3fL/huFWb/lkBPqIZVShmZPCeOs4wN9NX2zd81fG0ns4vxszynbgoRUard6A5sGM5hq1p2Vc/XMyd8YPIgJLiTk=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:09 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 08/10] clocksource/drivers/hyper-v: Handle sched_clock differences inline
Date:   Sun, 28 Feb 2021 17:15:30 -0800
Message-Id: <1614561332-2523-9-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc3364d1-8ca5-4141-2fa5-08d8dc4f9871
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB098147B50B23C669B0330162D79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wF3rrCPqquwFx0VgWaxCR1J+DuoK3rcRWVKTyehBjxGrRqmxVkKwlXzmC4UmBxUFf7ruShTv9xtTfzDz4WwlwHg4ifUHeBqsMwdgnHZDpwFdyF5Wd+0uOkuoqyJ1cagqCmDNIGF3vGH+q//lMSQqirTq/BoZifoJ3wjZeUF7vmS+qSyXgqTpwK9tZBF+MQleLKpgFReAKdqASe+ig8DfmTpv4R0uYOYcQWucDTN2CaaRpybA6WGj3o3MIN953FZk5lUFhI9usvpFqtI89w59SwAIZeEPCGHzBR0OJNKuZ9zg7x7RIsWLrPgSHIuysaALfbCNULIonYTw+uvzp/4AuPgp1xYTf/f3UF15r0Czb4itVsLwhZAFgGdmS4+sRLpS0Vj0JvC//DzdtOyJbZzxJ9ODrTTyYiGuDbjeSZCId/akvUJxaNH3riPNtqvya+fep/OWv6ksPZUiVQijhmqoAZBET4Z9boKSQjSfaLEOkSIEx5lti26K5W9Fy9PfB72dOMFxPmwXz/03sohiYAUueHz4hVTIRh/vWfY4wkEP3Zsh1vee6DKonD7r3aTsqV7R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DCfGxnvRx1sfW83Oshr//oHd2O3f0Kw5eiFuqL2xgC3dj2J3kvD7EaBsqlEh?=
 =?us-ascii?Q?DcmhzwZTw9JZVN+aDQc+qDTljuCBO3iztElpZ0mzcs1YkgKU/jcpLO2VzP8Q?=
 =?us-ascii?Q?NdQ+El7GMZWXphZZFDAAV9K8iWcMwPyltMX9M/QWf/p88Rsg1+GEuHsGqYja?=
 =?us-ascii?Q?RWJyZ7OxiXtjRbr/W2swkuATL8o/AMFcWnt2sakhmbHF8VT1IkdaUr1CvGIP?=
 =?us-ascii?Q?U3sEQk9Vz8kwmtQoPOp05h0TU1ookaC5DrKpN1BVD7Lnaz1Ze/vOTt9heUA8?=
 =?us-ascii?Q?IzwWMfqEO3bXaI5cR25cpD3I+Xy7n79t4/jEJr9wgs1IRhwf5aFJWfJSJD7j?=
 =?us-ascii?Q?fyoUV8z178gGGmKltv8sWMyj1C5ScHhH1Mo4KUJ3p3Db/El12kIA5ZZU39ft?=
 =?us-ascii?Q?hOnfqMFTsydbIRHi2/c6jrXgz+FHOu3aCGWG+WoWkkzPVpc4eP0SDgq9Ul14?=
 =?us-ascii?Q?UUKotlZcWnSYpEHTTHwabUS6rdmM6ci2ZrtguS+2DKQcxgzUmUjT9gBR4MJP?=
 =?us-ascii?Q?MZf8I8+uANLmhHg1qLXmmPw+LwSdNMeJg0sQ+m+A5nha3+4xOpStrKXG9pYY?=
 =?us-ascii?Q?roFa/D8t4JQ79Ka7buA1vE0s2o3DZ+vsqQoKVdo/5UeZkqbCpi4pJehCXDzR?=
 =?us-ascii?Q?cwvdSKzCLc2g4lWCVntN4EknNpZ89neS8/kGav77VmKdPVKGfFrEn7CUaLn0?=
 =?us-ascii?Q?yZjJJq//iGIUcY1pigVLNHbGgsmIc9Y49scrgmsFAMjDZX9vypRABwd5CQGo?=
 =?us-ascii?Q?zhnB06MhWnfAamxqEdhpxDf0ZyziWw14wfy+iiWHRslKQziDZscP3zMsrUeV?=
 =?us-ascii?Q?lR6V2kE4SIcDHySR3410C8npu8A3XGazwttsySk2HnbDC+q4KYZi5teZr7/0?=
 =?us-ascii?Q?jE82DCqBqn+YM3bfjpbxDWL1JlsOvlJ7VNGm320/SmaVyTgm1l5VIjw5SJm6?=
 =?us-ascii?Q?wmZhf8s8AXKUhDsqQqDUb+FdH7vvl+0MWH8iz0tiIRLJa1r0276DGUzVqzhl?=
 =?us-ascii?Q?zWwuOHf2adQMmivgbefTsbHXSKKbwG4vq1i0TjUwo3C2mi9H7G1GB4xVOMyt?=
 =?us-ascii?Q?Wc6akSZ+JjTgn5j5p+/hMYWrOZ0d7/RLoXOglA6BnpwtbcDCnQx7pjCXsq1S?=
 =?us-ascii?Q?OJWg7ySZ8i2t1jCkDupMOdqfjqppzmHm0D+1QAgX65l5b3fXj5YrUFxA6XlQ?=
 =?us-ascii?Q?4v64nJQ60AoYxx3e0Sz//Lp3H9BdAH8/xmuOsu7gA2mPynDJfdttWtwpujg7?=
 =?us-ascii?Q?bcPO2qpk/M9j4hKXvQWuuassHzW3olBHOhrLQMQjIQRdRdYDp9fFEn283RlI?=
 =?us-ascii?Q?5S8ygWzj685gdu4GrrGCyN/N?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3364d1-8ca5-4141-2fa5-08d8dc4f9871
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:09.2301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kZ+fY1CcsXqmbzgpelavLzBS+jSvWL6SyRfB7E9Sl1g+WfN+to6sYUdgPfsOBuVKFBM4ycc5UwTmfpN2BgatnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/include/asm/mshyperv.h    | 11 -----------
 drivers/clocksource/hyperv_timer.c | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4f566db..5433312 100644
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
index 5e5e08aa..38fb396 100644
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

