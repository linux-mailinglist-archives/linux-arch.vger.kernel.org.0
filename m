Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B765732B4DB
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450135AbhCCFa1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:27 -0500
Received: from mail-dm6nam12on2124.outbound.protection.outlook.com ([40.107.243.124]:44334
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350980AbhCBVmL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVkvN+8GGE9Xc+UhRBwa/aTbfTjht+qjU0KedD7Xr2LqeibevNY9vZbcVuznK+H7m8IgLws+IyQWHgptwdiRyhdnTZU1h1ubMdhOSgiLgjmcnX7TLVvCzyDGo3X+fVnxb+rllcpQ0iI+Gj4fOapyVdI9Wa82KkoVdBjzXxHsbb8RhEdVXYN9xPgxseL5YYPdq+6AWsRRQ+EsVDYSv7JwvPRZ+MtWllfpXULP84Hv/Bc+++fZccOKzqLMZMoNBZuvBF9WRPhQ6KOU/hyFrGKbYJ5gTEvx/MGZ1k7MK7aKvCeXhz/hIyIrhgNrlg3lKJBWbgQOkjNDPGnCOdJv/E4fjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s33JdtH0GOLtnZLFgM1gANhVLcEeoO+WkHpjKMuHam0=;
 b=B6MjhJw2r/sJ+ZXTfennw3Xf6eMoRz5RM7RIuW7XAn/RKos+XfIsh+UbfMxJ2uWMoI2Zw6znQjgeUpi0Ny+5CKOMJsRcjlGbW96TgB6uprKuHmnxXbwSZYbci44quqRTMp4j+hMZdAo9T1nn5VXPB7ipaK55myXjj73Kv/LRcsUbuM7LyLAOH2iBJzkF3DGWX6gqzWzxgl1h8pCdO9uQRBDrVAF5nhx9U1efTfvWzIqrsmI6p4de2tuMAJCcghX/kOlZ8kf9KshsOVgGtDTSaYp+ISn+ulFx8L1aU1PctZwvqT2qaNPH2/04fqK+/MlRkr1S4wKvc8J5QMnwWiSMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s33JdtH0GOLtnZLFgM1gANhVLcEeoO+WkHpjKMuHam0=;
 b=DZyluklOu4SZKrPLUwla2Lhru2Kzu0ZQHIPQgcZbRkmjRSmf4gjPpcA1wvpalkcaVW+IFtPtn0JXVOUWSsVA+OjNkr/XalgqMg0vzj4XiTqaHPVppeb8tw9cIpVIZlNU6MZY48CHbi2V1xI60E2t8/+pZiY1eS8J8QtH6tGfQQQ=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR21MB0153.namprd21.prod.outlook.com (2603:10b6:3:a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.11; Tue, 2 Mar
 2021 21:39:00 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:39:00 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 08/10] clocksource/drivers/hyper-v: Handle sched_clock differences inline
Date:   Tue,  2 Mar 2021 13:38:20 -0800
Message-Id: <1614721102-2241-9-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be5a6530-2781-4953-9a44-08d8ddc39738
X-MS-TrafficTypeDiagnostic: DM5PR21MB0153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR21MB0153F51EB683940D68503067D7999@DM5PR21MB0153.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E6vQvi8Z7gbwuzCDarM5jGQJhG9zFnRhu/hJdJUhoTw3fu8Nq8VPPybpBOXfSNsF6UEShlDfTta4LziYpDm3z0VILpm3/wPQo6BhYTdSKXFP73Oe2TKFPkbwR7rLcD0fPMWMnC2kPhsrKJBAti5L2YbWhZhUsau+4kLR5Dex0y6QFnN9jlI4/uTiCU1xHys8fULVqipiq0DHIg3TVOe5tvCcZNuZb3QLA5JWpVL5aDGnS1j/fEuCzI6G5vSma9IHftgr5Mh91+HYhrxQ6c/VPkURpr8tJL3FrNezZg7jqdhHdsk3eRn9xxU+dP1RsiCzJ5lOoUFG9QhjmsRgQx+Ku/50OuXNrE6+7sBFo1zxjNf9HEkBe/fm+Ab4c/sQ4UZlNFDV5BCnKWwnnvewYIZsFGRYDdptcO8yZ1MVsDycfA7GER0rH+a0lFpbUGAJ4Mw3BYKCKOVEd84tjKt85KEOErGi4KskL+906dpBpDfKUhwf+z930RhRWzE0hoZn6j/A5Ir3Di9DRfFl1kHXRWmPI9p4QL9mWQQZ+4effQAfYsiWVkde+QICzPUxeGvwvIXO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(6486002)(16526019)(82950400001)(478600001)(10290500003)(186003)(82960400001)(956004)(5660300002)(52116002)(4326008)(2616005)(26005)(921005)(36756003)(8936002)(66476007)(83380400001)(66556008)(8676002)(66946007)(7416002)(86362001)(2906002)(316002)(7696005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?t+ZzXBO7kf2vNEQU+6HZUnXEVtBRz7ChK2Ecpg48zFDl+XXhtg0rRqEsWYca?=
 =?us-ascii?Q?dxTIdvwPzA8XH5WtlnRX3zmj4M1V1GwEwVRAwvxPVtFSq9mdk72M88Yeejjn?=
 =?us-ascii?Q?nM9IJoXBMP/WV/3eF7npFJGE0sJ4dQj4DvVaC1mL7+44xG/D2g0R/8E4A3zS?=
 =?us-ascii?Q?bn9p2SM5Su2faPeGx2HNd/xh/bqqWvn5lDxyuJa0i5jFsAXY9KiKTUj835AS?=
 =?us-ascii?Q?v9WA5YAEwHjcBrGjvJPQm/Mfrp2hoD21k5h8lEuLJE5J0R0NlvbTamfOamrN?=
 =?us-ascii?Q?q5sMYibOKSl+rRv67OI7CQmiS/C3MluVheJ0L0f2eyYhACM7s4n3+xjXd8d0?=
 =?us-ascii?Q?yQujEORuUVdL770eWJoo6UwGgZHcdqlw4yX82zRjV8+Z1gtc4DinMPZE1Yf+?=
 =?us-ascii?Q?KV1FTf1u7FLUEa/CrEWxsTkKQweTrIzJeMHP+UK5Blisfn8+wqDPNBkJM/Bw?=
 =?us-ascii?Q?LDn28vlrjvXRDz1VlJIzkyHv2iEtAFVgG9LMdvN+DbmyHJVzzZ4nOiBN4iTk?=
 =?us-ascii?Q?lvTBfqlTptN10JdDoYTg89e9cr5yxCrsOonjbThkUwyA77zBEGNiOOZKOMSe?=
 =?us-ascii?Q?xtCFLFTBWbjNBln5yGPF7/PJLI81tsdIYO88TXIFOBn2cHE4sDOOGBLnVmuY?=
 =?us-ascii?Q?c3Twg46qr2S/4LcW8swKi/y4iHxN5qMQpdkOCOnkrngweqjzCU3SDooGmcWL?=
 =?us-ascii?Q?hGLqPiY+gMiUCwzjwiQP0FQm41RE4oWzq8rCn3hdtAa9E2phznyDdUSaKE5Z?=
 =?us-ascii?Q?2Idc0vnK/0ydZKE+rM/zGtuA5/vf8bVeskQ660R0hI4Wfd6yZPOgWuQHEtIB?=
 =?us-ascii?Q?iGbUmVwAeDrxNW0jonOQzMLbahw5NskkwQ1VGq6V/qZkdgjQBHWMncIwyx1R?=
 =?us-ascii?Q?k6kty/T17o+StEORJ60ZVyr8Gg0/q+upGPk7awstXbOohZlL11SMzPzfIus1?=
 =?us-ascii?Q?Vn7k/9T9IvRacYVUbH268xyhkFHri9DkMQpZk7shgBXeKzgfktejzMkCYNV7?=
 =?us-ascii?Q?d8MMfwCIt8oSjqJJx6p9PgVJziqpI/iSfgI+eb5cdKPSaUu5Vc/LfPgt+aqJ?=
 =?us-ascii?Q?FbdEWtbJv9kzU/FUPjX1t3fcdc8nx7b+8puO/eC3OwozkkoqpN0S7nOiuAa7?=
 =?us-ascii?Q?Eu/iQ91p01xn387PVJAvUX3xmDam8MQempRVlXEapmaHMEhamlwsrjZe13W1?=
 =?us-ascii?Q?sq7dcWdTKwXwmk2UNbRx55vHkcxo1dQGGAM0FNRUkNASwYclFPt07DFPOV22?=
 =?us-ascii?Q?eVcJqmnymERijImXQHqEDKy5vN1dGO1MwfPjbgrETV9ldHNH74L7bJfND4K1?=
 =?us-ascii?Q?AzQ1iB1ro/0P/dDVNrb1ze+l?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5a6530-2781-4953-9a44-08d8ddc39738
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:59.9580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LM99oI2Xjrf9o1+hHlOaIbyKm69gzL+GQmRf1ljKmosnqxBLwMUth623xUgpxclG+kuBz1l1YMyXwu46FTGcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
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
 drivers/clocksource/hyperv_timer.c | 24 ++++++++++++++++++++++++
 2 files changed, 24 insertions(+), 11 deletions(-)

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
index 06984fa..10eb5c6 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -423,6 +423,30 @@ static u64 notrace read_hv_sched_clock_msr(void)
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+/*
+ * Reference to pv_ops must be inline so objtool
+ * detection of noinstr violations can work correctly.
+ */
+#ifdef CONFIG_GENERIC_SCHED_CLOCK
+static __always_inline void hv_setup_sched_clock(void *sched_clock)
+{
+	/*
+	 * We're on an architecture with generic sched clock (not x86/x64).
+	 * The Hyper-V sched clock read function returns nanoseconds, not
+	 * the normal 100ns units of the Hyper-V synthetic clock.
+	 */
+	sched_clock_register(sched_clock, 64, NSEC_PER_SEC);
+}
+#elif defined CONFIG_PARAVIRT
+static __always_inline void hv_setup_sched_clock(void *sched_clock)
+{
+	/* We're on x86/x64 *and* using PV ops */
+	pv_ops.time.sched_clock = sched_clock;
+}
+#else /* !CONFIG_GENERIC_SCHED_CLOCK && !CONFIG_PARAVIRT */
+static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
+#endif /* CONFIG_GENERIC_SCHED_CLOCK */
+
 static bool __init hv_init_tsc_clocksource(void)
 {
 	u64		tsc_msr;
-- 
1.8.3.1

