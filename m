Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9A961034DB
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 08:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKTHM6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 02:12:58 -0500
Received: from mail-eopbgr730115.outbound.protection.outlook.com ([40.107.73.115]:6211
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbfKTHM5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:12:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cE8SMRkfcE9Yxq7ug07Cvv8Nkcjs976qK9hEz9PxJLnLHRvBjfHtYIhvHUzlmLPjEApPkYlJWFWhYVrAgqi90jaVc4LMlloOGVChMLlJEGHCMW8y1DPKaypvJ7giEpQmY0tqCuAPE45zaaip4G59eZIK2HodS0/g2u40ofOC9pd2Jfs936qDusxShd+yb7zhMMwh+Ku7uxWTDVeur4OdKRXgMvbmWHlXleRnY3J06MIizcrBZpVjYHGRM30Agh+jwsIjazuTOaNIk9h6Z/C3LX4JdvRQBuY9AW74fsO/5xA0NZZVRoGzNsKQQzcbe8sMzP4vueQb9KnHzEFr6F/sLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeWWHZzdpCu3t/3G0FnFvPIhQn/G8JvI0hFMJpj7glQ=;
 b=nupwbVS90dUZShsKhyXuEUdItvRXCJDR4WEqQ8sK5LCIp+CHiTp3+RkTnU5hs5ORMyRC0GYEN3sCMhdsa0A7v9y0bBigersqeF1B879GZO7DOWBEoVE/MPsdm8eimRsK/3GaviM4DUtO7Fde6yZ8rAWSYGdftThxIt/aJWVK+cysWuu+3vmciKNrcDn/yj/nZmBV1yrVeov5zLySBGELhwd2AfsUgnkmf0JQDzOwInctKRPLo5QBVExiHzeDJSwZVxDIO70/bG8AJFgIvnZeJMVdebtToLNPUKpgHBAlx8g3EMH7cR66vO1QkrfdpqUD0cRhoyCTqr0MuYgiPXAXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeWWHZzdpCu3t/3G0FnFvPIhQn/G8JvI0hFMJpj7glQ=;
 b=hcaMAm709z40gUDLXT6iSe5PuI2k9wJhV8ir6KBF88ktVUXwqd/SbqWRTThacPj8VVs0OJncOXbh+F1fbnGdDWtH0FXGcZwGwJxv1D8AKPrFo105I/z3VYygIQV6BBlmbQ4gZ7Ns63CIv1e4WNWQOqGXL838+yvA6F7L81oxgGg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1268.namprd21.prod.outlook.com (20.179.74.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:12:46 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:12:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v6] clocksource/drivers: Suspend/resume Hyper-V clocksource for hibernation
Date:   Tue, 19 Nov 2019 23:12:26 -0800
Message-Id: <1574233946-48377-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR0201CA0019.namprd02.prod.outlook.com
 (2603:10b6:301:74::32) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR0201CA0019.namprd02.prod.outlook.com (2603:10b6:301:74::32) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:12:44 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3cd74eaf-965a-4d96-28ae-08d76d890b3f
X-MS-TrafficTypeDiagnostic: BN8PR21MB1268:|BN8PR21MB1268:|BN8PR21MB1268:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB126888E66BD752F5DD9178ABBF4F0@BN8PR21MB1268.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(6436002)(7736002)(305945005)(4720700003)(8676002)(14444005)(6666004)(66556008)(66476007)(3846002)(6306002)(47776003)(107886003)(6512007)(316002)(22452003)(6486002)(6116002)(36756003)(48376002)(478600001)(16586007)(50226002)(966005)(81166006)(86362001)(81156014)(66066001)(956004)(15650500001)(10090500001)(2616005)(43066004)(476003)(51416003)(52116002)(486006)(26005)(4326008)(6506007)(386003)(16526019)(50466002)(186003)(5660300002)(25786009)(3450700001)(1511001)(2906002)(66946007)(10290500003)(7416002)(8936002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1268;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8X8leSWW37pywsrKFH5ADPOxKy6Phb9yuLGtIhU5/hAWk666s7E5E5tmZMZ8SeiawXJlUCBMVmxBX+Rk7oLXn//BYfmZSoc/KDpdr6olR0MjFrEMsw/OAPl5GXmfI9TL2cf2ZlYRCvqDhWxPy4RMeuRUMVFADX1EqXVDrHw3iDFxKqxOHQta1ZsieyHsNtfja2U8ttEAyHUMJaOL4rt3Tbu3GWs6RIcgZJZfB4mWUJXEhnLxqRTz2K71fsXLJtTJjuTU2Bg5dOpI14zXyI/rIwusXJnfd3mXX0Ge18ES+pXiNLDpz07PhLp9SK1ylPEnZiWk6O0vIQ/QEG8Z7beCmTM4kVNMGV+u0F98eMtvqbXZT06gPHgfFzo8DRnqFeG2ErQJ35epNh78/e01w+oz710NEzR+/TaoXu1thjL00ZXrPGs10vd95n22TZqsouaO4uzobVhyyJ6JgR2aE5Tmmi/oxKI6n0ssTwboI4hc4s=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd74eaf-965a-4d96-28ae-08d76d890b3f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:12:46.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVDZ0hil4Ifjvvkk5ppBAvuxmYI7FUtk5jUfe6dfYohDx+Ot25EiYfSyiFhdFIt6ST91nqdkvo5ygvPFG5Ka6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1268
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

This patch is part of the v5 patchset:
  https://lkml.org/lkml/2019/9/5/1158
  https://lkml.org/lkml/2019/9/5/1161

  Actually v6 is the same as v1 (v2~v5 were posted with the other patches).

  Please pick up this patch into the tip.git tree, probably onto the branch
timers/core.

 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 287d8d58c21a..1aec08e82b7a 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -330,12 +330,37 @@ static u64 read_hv_sched_clock_tsc(void)
 	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
 	.read	= read_hv_clock_tsc,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend= suspend_hv_clock_tsc,
+	.resume	= resume_hv_clock_tsc,
 };
 
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
-- 
2.19.1

