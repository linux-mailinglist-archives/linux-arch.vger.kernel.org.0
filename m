Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E13C7A5D
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 02:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbhGNAFC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jul 2021 20:05:02 -0400
Received: from mail-dm6nam12on2136.outbound.protection.outlook.com ([40.107.243.136]:11072
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236966AbhGNAFC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 13 Jul 2021 20:05:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LqJMn97e96IqY+TRs40usrqYWRR695FkS//j/EANdxH223sTy40OyHqblEpsgqCoGDujhbbEni3XwCzMvRYdIOXWFHNoLEnUfW6WHVIv0PlaW/u2zJ1NLC+ZejA15vZ4tWeZxAc1keKDQ+prfqzpu+pAyQsXNBNP2XqDG6tbS+/vFgAjolhw06nAUAarIW+MsnmFIMBv4bE+EuJeq6/IqWC7T9kVKnurEfSV8IwQdT1FhJRyNxHSSj2D1oPUxvcsHwgLI5sYjXX4iXw0oQNhKrRnIsgkNK7IVZYgcNzqJAVfuWZql4yEjq1fYXGRQoQ/7PopqNqY9DRhuF7y+81Wbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZVbJdcRymz8NkBoR3PRujYg6zZFiP2mQ8c/N2Dye+Y=;
 b=Q05RC4nIQDVhcXH1LfG15YuPhT6zu0K8WVrRxfmNQYpwdjJmDdR/kzIdDV6VjnvDhHsOEjykkiZXWkfHIAEFUtJy4slnRrGsvbOkErNUrgwFwKILKPvbP++Q4jmGLVRF4uVk59pdzRuEGfsD6YrpCY8+R6tVeJ2lEnwYPBC4vBsMB7FPAUOw9ttbq3exZWO38rzf6pQvaBt0x7oBChrX2mVQZ5V9Tnx/tq6lLnQ6Slcv1gaasbvg1M9TOZtncb1almr3loxoZONEy7XPPySCAwqE+zC8sr7KR6brwNqBNXgKJRsnE8Ei4099ig0KzbMs+5t26Cld9UxHKlg03GOPHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZVbJdcRymz8NkBoR3PRujYg6zZFiP2mQ8c/N2Dye+Y=;
 b=JCF1eORTf71EjympfLoOEIaftHg642NZTts+iWFjrRdyue/2OKf+uZfNhtitFkYc5cwnD9WLHAiWVevQUsXbFBY2xhexXvuHSxGxkdi+erEBHVb7E0mR5zxa18wDjgXwSxtf75ByOQlJcrJwOabgeL3OqXnc1LqIb8av2xCHo9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1627.namprd21.prod.outlook.com (2603:10b6:5:c0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.8; Wed, 14 Jul
 2021 00:02:09 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%6]) with mapi id 15.20.4352.008; Wed, 14 Jul 2021
 00:02:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH 1/1] drivers: hv: Decouple Hyper-V clock/timer code from VMbus drivers
Date:   Tue, 13 Jul 2021 17:01:46 -0700
Message-Id: <1626220906-22629-1-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: CO2PR06CA0054.namprd06.prod.outlook.com
 (2603:10b6:104:3::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.1.208) by CO2PR06CA0054.namprd06.prod.outlook.com (2603:10b6:104:3::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 00:02:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dc64f0f-fb56-4987-04ea-08d9465a9fd7
X-MS-TrafficTypeDiagnostic: DM6PR21MB1627:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB16274E395D9CE9C233604E97D7139@DM6PR21MB1627.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S8+iZ4oImsn0J+o4wc27SJk+jzv+iG/qtM2xg7OjMnI03kfNX0V/5dCf+ZPAgZh17O+O3e1dnXujLGYyOLFIWU3q1YBFPZoYW8wBGIVMRnt4yZ6981dRpgi/2VjpLzXDDdgmOGwTLGRKhqnYII3o/p6j758CO1JyPvEStZMJAC3f+SGQfdK2+ovS58LQ51UeNijjqWcmOPSl2fuJ3GAKn+f03xIffnwI0HxnvN4Bu5+E+uQVsSvAnWa35g8BP3pd4k+GzNaQMi7axBkl/qUi80/N2yhBNlUh0dBu6+Bvd+JBzDsx2dJbyl8FePz1uKopbW8Ybmma9tAOzrQvc6DPyNdMoc1am2vW1et1HaGDYloORyK6Jq8uVkujo9PNLCuKAS1Y7w8RkCO128OVbI3fOw9fiSuDvDK7AbOwdQWwdxHkbaiPaXDrWuJ/BGkgf3HTUEiw91CUnLCK3L6SOY0h0VvxqTcQdaJwMMufI0OVIImfEG3ThjFMqYpFg2xdBP/RLjBgbX0q1SA+rBFC5MdeEswqNWM9BFcbIR+fuOC1f+7HkNNVhKU/bT4OwW6Z7oPKy6ZW1RcAsf4FN2GqGi/p0/es9kwKCSokgP9pk1m1l5cJHc4hNmNW1WAgJRgbf6IG2ejXfRQZE4FvRRR6xeaK83w61u1gmC4iKCW6283Uf2eK4pQ6RtadL/3PRgEVwvS1SB4mtwKCTAgvgefDHn8yZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66946007)(316002)(2616005)(66556008)(38350700002)(26005)(956004)(186003)(66476007)(6486002)(82950400001)(7696005)(10290500003)(38100700002)(8676002)(478600001)(5660300002)(82960400001)(52116002)(86362001)(4326008)(6666004)(8936002)(36756003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8u0cOmKrmSS8o6JyjBt6ZcLtwnFFhu03l5oBTJU6jJs1rrd8eAFmzE5XSbat?=
 =?us-ascii?Q?sfu6R9trCyqRMXDVlMROdPtwk4G+fkJjXf2j8Qab7bJlaxKM1vqIOehQntC3?=
 =?us-ascii?Q?uka3q/eMheDNHaLK8R+w7iuE+L1WdTUC/mQowrMgmXCQdGJICmEeQzj/xMjI?=
 =?us-ascii?Q?aOjqTO3HdYjrxxF9S5Qj2QljD1Ex7s3r5UZXo9HY22lw02fW5lePkRudJbhb?=
 =?us-ascii?Q?lJFZi5hZIYCNLvdy/DkLu09UafPQ+FtQB6nnTvhfDHbvFjUF09Lrr3lH4XhG?=
 =?us-ascii?Q?KG2Xgt1DDyZV5nAvPNuzcizjLIj5sSckCZefatj4WbcTZl1n6qH9Q6MgDTYR?=
 =?us-ascii?Q?qFokdvhFML2xl2yXp19PpsChNpQ1zeazvO8k6SP19kc1iscpPOrntjsxvhll?=
 =?us-ascii?Q?uh0ZE/mlij0AwIS5QOYulCtSPQj1SJalhyuaZ4k4TlnkURaqYIWsnRF9DGIF?=
 =?us-ascii?Q?glgDbrO9asig+XOFvWOuWA0YsrzBtlgsZVaT8GVrEguMFVA3t1Tx0i9VS3PD?=
 =?us-ascii?Q?Sb2Gq1nKa6pY5w+WF/LkLASiSgi3PG5KSkrBGBmfBzRDshtSauA4wOghfkx0?=
 =?us-ascii?Q?h2f8YJsGgfwT0Bkr/6WwKAzolpxLvrcAnlRVhumCda83CYV9cH8ImT5aPobG?=
 =?us-ascii?Q?svY7Y5EqwWrla0pUhRFjKt/F65tY3RNMh1dRJqQfbMJaa/BJ58cy4dqncIAW?=
 =?us-ascii?Q?zBc5Mvm3zWenMJ15MWb/g4AVUzxTW8uaVeGPRx2IrXx3OyLhl9FGthl038o6?=
 =?us-ascii?Q?puWrfe2jKuW+nwV7oKVprLWMP/Qd71F/Qqq3ldqSEb9KffXuELwYwX7ruCkQ?=
 =?us-ascii?Q?xAN+415IHuukPREsK4se10g4Y1epEmZvgDs4YbuzbxKIWm0IqyjYdNNbR4gW?=
 =?us-ascii?Q?sg5T7ZdUdKh7v5JKZZAcgP10RS5H3RytsXqlACzprc+WTV5goaetFK2ojk6x?=
 =?us-ascii?Q?WQ5TD67LW9Doglcd2z6LgJcPrIPzMYce4UXG8tlbJoSF1qHNDOHsr7vl1j7Y?=
 =?us-ascii?Q?AwqWNY0JtK8lXOsTkaGDjnTF1jZ7icBGeHOiTicXfoxEgE06aI0rA1GyIL8x?=
 =?us-ascii?Q?6qJVyEDE3loz8cfDy9WJuhPs3iJqHeAeUyR0t5+JXREIhpXHNozeyNtuX7cw?=
 =?us-ascii?Q?YZyrImU+U6DvNd83tRpizZ/KegCpbktI2hG3goo9tX/0ZY0AwL8khkbWoFbo?=
 =?us-ascii?Q?lLNKfTM5Mw73sexvdw6L8Hd4rqr3VQYJxibYqwCZrb58yU6NlPozzMS451gO?=
 =?us-ascii?Q?mFCzGqz6TVobcdveXzeLXedwFfU82iYnpaX3nAd4rp0F+vduZX+6BJPOHd5y?=
 =?us-ascii?Q?9im31yxOM0mb8u+yekyQTLSG?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc64f0f-fb56-4987-04ea-08d9465a9fd7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 00:02:09.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZIIDSCOENdMO/ocpd/S/Xx2UWYiSnMaffgS38ct8hcHIfIhmUCABU3oGOcYx+boqmlvRRcFprFbal5HdGMRg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1627
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hyper-V clock/timer code in hyperv_timer.c is mostly independent from
other VMbus drivers, but building for ARM64 without hyperv_timer.c
shows some remaining entanglements.  A default implementation of
hv_read_reference_counter can just read a Hyper-V synthetic register
and be independent of hyperv_timer.c, so move this code out and into
hv_common.c. Then it can be used by the timesync driver even if
hyperv_timer.c isn't built on a particular architecture.  If
hyperv_timer.c *is* built, it can override with a faster implementation.

Also provide stubs for stimer functions called by the VMbus driver when
hyperv_timer.c isn't built.

No functional changes.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/clocksource/hyperv_timer.c |  3 ---
 drivers/hv/hv_common.c             | 14 ++++++++++++++
 drivers/hv/hv_util.c               |  5 -----
 include/asm-generic/mshyperv.h     |  2 ++
 include/clocksource/hyperv_timer.h | 11 +++++++++--
 5 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index d6ece7b..ff188ab 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -361,9 +361,6 @@ void hv_stimer_global_cleanup(void)
  * Hyper-V and 32-bit x86.  The TSC reference page version is preferred.
  */
 
-u64 (*hv_read_reference_counter)(void);
-EXPORT_SYMBOL_GPL(hv_read_reference_counter);
-
 static union {
 	struct ms_hyperv_tsc_page page;
 	u8 reserved[PAGE_SIZE];
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 3ff8446..e213433 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -215,6 +215,20 @@ bool hv_is_hibernation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_hibernation_supported);
 
+/*
+ * Default function to read the Hyper-V reference counter, independent
+ * of whether Hyper-V enlightened clocks/timers are being used. But on
+ * architectures where it is used, Hyper-V enlightenment code in
+ * hyperv_timer.c may override this function.
+ */
+static u64 __hv_read_ref_counter(void)
+{
+	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
+}
+
+u64 (*hv_read_reference_counter)(void) = __hv_read_ref_counter;
+EXPORT_SYMBOL_GPL(hv_read_reference_counter);
+
 /* These __weak functions provide default "no-op" behavior and
  * may be overridden by architecture specific versions. Architectures
  * for which the default "no-op" behavior is sufficient can leave
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 136576c..835e603 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -17,7 +17,6 @@
 #include <linux/hyperv.h>
 #include <linux/clockchips.h>
 #include <linux/ptp_clock_kernel.h>
-#include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 
 #include "hyperv_vmbus.h"
@@ -735,10 +734,6 @@ static int hv_ptp_gettime(struct ptp_clock_info *info, struct timespec64 *ts)
 
 static int hv_timesync_init(struct hv_util_service *srv)
 {
-	/* TimeSync requires Hyper-V clocksource. */
-	if (!hv_read_reference_counter)
-		return -ENODEV;
-
 	spin_lock_init(&host_ts.lock);
 
 	INIT_WORK(&adj_time_work, hv_set_host_time);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 2a187fe..f6245fe 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -166,6 +166,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 extern u32 *hv_vp_index;
 extern u32 hv_max_vp_index;
 
+extern u64 (*hv_read_reference_counter)(void);
+
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index b6774aa..1c566c7 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -20,6 +20,8 @@
 #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
 #define HV_MIN_DELTA_TICKS 1
 
+#ifdef CONFIG_HYPERV_TIMER
+
 /* Routines called by the VMbus driver */
 extern int hv_stimer_alloc(bool have_percpu_irqs);
 extern int hv_stimer_cleanup(unsigned int cpu);
@@ -28,8 +30,6 @@
 extern void hv_stimer_global_cleanup(void);
 extern void hv_stimer0_isr(void);
 
-#ifdef CONFIG_HYPERV_TIMER
-extern u64 (*hv_read_reference_counter)(void);
 extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
@@ -100,6 +100,13 @@ static inline u64 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg,
 {
 	return U64_MAX;
 }
+
+static inline int hv_stimer_cleanup(unsigned int cpu) {return 0; }
+static inline void hv_stimer_legacy_init(unsigned int cpu, int sint) {}
+static inline void hv_stimer_legacy_cleanup(unsigned int cpu) {}
+static inline void hv_stimer_global_cleanup(void) {}
+static inline void hv_stimer0_isr(void) {}
+
 #endif /* CONFIG_HYPERV_TIMER */
 
 #endif
-- 
1.8.3.1

