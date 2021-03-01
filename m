Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1863275D1
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCABSU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbhCABSN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:18:13 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ECEC06178B;
        Sun, 28 Feb 2021 17:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4Yiy6lPkCJbLSLhLiLJKED/lk2UuQjL3cTaReLNrwL39bdXLqYKDCol2C9Qt946Tk9uFHj/uXPL/PAw6TnTeAb0yTccnklkf/5dSXCL1S2dvHXlEd6acNF7asNkgOSA4HA9MuyYY9FeIL0eGGLkUXacbLR1nFu09IW/GUPokUizZX1ZhuMWUjtast2p6zG15nBE31rheQEJJcfXHLD1PfHa7JlT81AF4bGgQPXSm68WQ2Kssiowc/5/1c44hwNtAptRsBaYlaDayxjaEv2gYT/I6VJ1KOFfgoToEqQuDQnMEKtJD1KxT1WGFshx7vC5F4JSPnS+eZVGovums67HUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yua5Wbko+VHCvXHjZTQsLrB3d4+zUOgdTV8tiBGd3Mg=;
 b=cvYHpIo0VV9xMTbhoRC942RFPIJcXXcfF/nWCetoz+CfwVGdoQDxMh1g6IcniFHFHHWeAeZ8o600vm0REcks9Pfs9I43DhqMPc2OJg6a10B0q0nuiDgLMZgakIM+uGx3KP55MBgHyju0tAX5x7so47VV00AhS6Sxlmn7xaR9SbFr860I/46Cvb6o/TVsvWuG4kw7zx7oFHErGdykRIngvAa3S1Hmwkdnc0ywuFL0pkozjUyv1+qt/zlFBmYc4WhfZdMg4KR+QunW+TdFn96rWCnYJSZrl4SZ51zKltmFq0km7LEn/we3F5bTkv4Lnv1XDLmxR+QXWDKBmWTKgsy99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yua5Wbko+VHCvXHjZTQsLrB3d4+zUOgdTV8tiBGd3Mg=;
 b=Hz8lUTjVWwL1QYPdGrRP3XApXHttDE0GMC9WMv1n1sEMVosPnXAwizLgcGSAvVMnBby+965LUbXllWlKEgMrQ+3BQmE/m1PqFik32PH4p1qRGQs+eY0sxV0eDvBGqzMQWTkPeCzZ1Wjr2trbBe5ngRHC58WrOpBixE1JaugXX5k=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:08 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 07/10] clocksource/drivers/hyper-v: Handle vDSO differences inline
Date:   Sun, 28 Feb 2021 17:15:29 -0800
Message-Id: <1614561332-2523-8-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5df9507e-56b3-4740-9e85-08d8dc4f97d5
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981D1B3624556A5481D3014D79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YX9zloe5f2jC8bZmM7fG6zKAWAqRZfPE5BLefsquw/8j/KTZthWZTUi/6cg3Rp9uxWC/eeWIImx4ASydv+EwoR3d4ri/Qrnlaepmh6vAnJ7kGf/DQNdR+MNdK19S9PQNSy+M7VXPmdvb3Zbg71jJXcoTGOXKO7bgBuKHnba23eGrRNiMAxQ8Hl0XnPIKNOd0TlUXuXoypaCWQUMILtJuYRdhoccCfK57PmJoa7zlskhHPaqIRG0+vVa4awoTiD4m2A/xuJ2/ausDclt8SiBNEVC7czPcjFTrhWbtPq5gcU3Qxu+ajrqGWHfn5nffLkXJZ3A6HKyT5F9aiYcI7dFOUVoBwwhV4CAmowc8IfQILmpP6g7kLm0HAbYyLZnWM7snQZDJlkDJBayTKXr8Q/DokwfFVQRJPsg5E8+4JsSf7oRj0X0LswFiiXXnSUUKbZMD+HQj9vLoB+dEXT2FJKUrYhr78DUTjGWd2IEaKTQ3Dy4JbzXGSi91xnBMgL/f5ZFmnz/pnmo2eTDlHpJbGRsHwo73pCDl6y5doPdrEAvoumUnI216o0WRWJkzQOKTV303
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?3AMCGxHxsww7gs6TzN8B3oMr0tktEpPhmLcfOHzrv+DlPp7qxqrWLQ2Nr34E?=
 =?us-ascii?Q?RdnjflGvOOQzpop2aMACsmMT4Cski0TctlmbYFps9YFIByrA7Pd52LIOJnqD?=
 =?us-ascii?Q?utT4xWhIGVWY1j/Whw5OKtqE+0GUpHlNfFtEFIzrQD8b/3IA2Dwo1O1aGych?=
 =?us-ascii?Q?VucWdGT2tdmtU+6U9uktBv1Jc+lnQgQ/n8zjeDjFX+ya2XBzzE7KwSF+HcbN?=
 =?us-ascii?Q?5IBOF9lL7O8g3qcGso7nGvb1RjVxytI9lxo+ZfXkMOdU1dAXTxPwm53ukFQ2?=
 =?us-ascii?Q?WAQ0mzt2EP48DOOWMkIUt5Nihv4brXV3xX7f4LB7g1LWMfrLK6DdsFq6uMFb?=
 =?us-ascii?Q?8pp5AcJNOgx0gjn1bjIKd9qc0c/aTsggN4P816ZZfZ1eiUj4XOxDDufyxns9?=
 =?us-ascii?Q?8vAaQMnAia+QxElDXFIUevmtXlX9E6rhbWlX0heYDPxO6zOLjT1ChFtFiADJ?=
 =?us-ascii?Q?SDUy+6wiPp0F+qsgKmWdpx2Yb1ltAnFjz6Gy0q89O73DcXzgipdZle3h1WjF?=
 =?us-ascii?Q?OdPl2dw5hK2gXzSvX/5AERpCISlzqY4aHYEEw5NrOYzjYop+yot81EsNpKGO?=
 =?us-ascii?Q?I4q3TRxyQEStETNtUQSShxRhB/kx2UfDjYFUdJ9WOk6TB4rAsmkouPJOzfEv?=
 =?us-ascii?Q?mqrHSjvQYyaeiJPX9QaWg/YZce5M0Tvbu8a2P99wzFQySIMtHtgNZkhBgkZN?=
 =?us-ascii?Q?CzWIl4rs7MG8+n+2PEOmcNUIOdia7oKes/k74rE2cUiO32UfSXVgq77zyKaO?=
 =?us-ascii?Q?YH6YPaULLIdTZGi5asjqnPhCv9BtWWs/KVO+TmHZcdXJCJ40zuPQnsTl30Ms?=
 =?us-ascii?Q?Y/OFYjDPD6u4Qhg6HlcI0Z5HSyMW6N6aHNTBk510BQDrL7Qf6lcjsBwRxGhq?=
 =?us-ascii?Q?CmvvBVEYsh47EqmshheporunJRTVDDo/1XjTTJo50m7UyBZml+E0cjrknzEW?=
 =?us-ascii?Q?AlF2agSWg3vmvw/6EF72QZcqSaTlaettWQ89vDxsyjWGh7Xq5ewKqwcWLNuK?=
 =?us-ascii?Q?8BLJmgwBMkccauJosWRNDGv4xvG0KMaBF6AWOwHmPI/xwpE81oeBq/76u+Uo?=
 =?us-ascii?Q?2galxPHVUaZSxduSNbP8K7r3FFBth2S12yU4rT1qhZWzkfVgRNVhwD3EmFcQ?=
 =?us-ascii?Q?FtuledX+Lt+ikNExC4BbQUtK3Tbtn8WMtYnCO43+XbScuXm7WR/tIqwD6R5B?=
 =?us-ascii?Q?W9+DEshvP05qn52B3lXV4gxY0LsR4Ww0v9A5wycJptFcRFuDDgFHQlUFVqcB?=
 =?us-ascii?Q?/xLnuiMkjGAy4+QdDxTO+ySD9g81SQlXgEgdhstqJHcyqfXCWrudXFbh8vTG?=
 =?us-ascii?Q?ERDooFJd+sQ8nZV7bRX8SU5R?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df9507e-56b3-4740-9e85-08d8dc4f97d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:08.1946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPi82RssLbbz30wQJG0nG3kSVv25BpiZ8l/Z7UKPta1goCbbHwoxwrS6s1eQgK8f9f6VN7Rp9Lh8gQ3x5MTzvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
index c73c127..5e5e08aa 100644
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
@@ -442,7 +449,6 @@ static bool __init hv_init_tsc_clocksource(void)
 	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
 	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 
-	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
 	hv_sched_clock_offset = hv_read_reference_counter();
-- 
1.8.3.1

