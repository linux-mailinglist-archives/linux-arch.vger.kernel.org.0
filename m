Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D565E306518
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhA0U0b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:26:31 -0500
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:61825
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232702AbhA0U0K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:26:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVguhxboczW5md09grt/C4KR8m2VYYdPbUk5DYaLE+FvCF3jnCFcx1HFNCKJeQmpKlhkF9ovLG5pxBqsajrxSLePqc2/uYMaHE70W6FSz3nuUHtxTqXuVWyNQXP9VmZIRrV9afecX6EyQ/olG510YI9xNmrvmIq9CEBfofKkcWkcAd5Zrq88rQEUI8c/fqF4xq5SerMIfGMn4ORFBgU54++Y0Mb3n3f5r9+MylCn3geJu+Wz4KNKa+Bd1BnH6uKn7Kf1uezPtBLYUuqXxp0Ye3smHd8neRF4jjbxQaVRar91Ae46DANutBTXpjFyj5YHdz5O03Ojqi2MBtsv2Gpecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlPs69BH7Y19heM5a9ZfyThmQWHfKRlozZ+lnew4f1Q=;
 b=b1IaG7ih2afqIPa0TEpkZNlUjqUm7otGLWAV33/M8VAKxvf/wKRlmaODXpHLL9+q3nzO4Zj34pN+g1gAE+rH1EAZ3HubwZvtYusXgLYznf9k4KKZEGsdPdH63UMUaZ0y+fQO1yuGjF+WCaQPhS7RS7jZF9mzZ1u9InkrC1wulcn59mpb1SsQivNLSrl7dc/d8Cr8GG7qwV+9cqFQrC+gaK1qalJBz9Zr75KaK9GWFgbN10UwCuODJoqzMvr5mZ8hDTB4aKWbIPl6VVH1XxI3RmroQgG/2BpfjKrR15k7/Dyvr4iA0uPL6rw+HyUQzvAwwMIsgu4muLjZGKrGvQE19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlPs69BH7Y19heM5a9ZfyThmQWHfKRlozZ+lnew4f1Q=;
 b=imqB5EEWD5t1bgCmcjpihrDd6rzNc1BH3fzbgCyMJUPM9lvoIXAVQtuE1ceBrI9nTM4MnNBI6tksV5M12SpRIzkgCJaxqaWlpK9TKDVCEXAFv3XQrK60jJfgr7NisVpRKm8yhj/VoBxNgGc/YF8reMMJoud/K/IziphGGcGf4Sg=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:25 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 05/10] Drivers: hv: vmbus: Handle auto EOI quirk inline
Date:   Wed, 27 Jan 2021 12:23:40 -0800
Message-Id: <1611779025-21503-6-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d12e72a-aa15-4511-3f30-08d8c30189a6
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215D1845FE39B65F9D7631FD7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51f5o5DDJAUfEExHlvatHTRHevnSjuo52scRbRTUlVrLsexy4UHVcvWcUmy0gFLqDLZFeHUU2bCAwoDuDS2ax+8VY48Jm5uYp4ptUpESP0hDmq/kI+plsoheEhUuwQrjZYymSkNoiOfp2gqvBsOCmgTXV8Pu7ekkwzPfR9D+N0baG/WKtj5U3UlDsNaLCeepThacebJ/re5vUDF0muQbOc6z0zB1y2yMj72PQWxHstMVX6jWB2RLkQp4ZhywHXbAjdjmpM2SFblCn+mr4PfvmF18TBG/Tipzyomf+4New0BentZwKwv4R4XDlCNGryMDxn+56kXjxDBE29AgRVxbId1bN2q6scwb6YtipTeJnscqKwNeowCTrFVRSmb4MfGZ+8b4fk5lU+0rJSQBxlaCvseyrTgHvtS9gszuiXntuKgET1YtkNEMeXE/6ZtyCYzFhFK0iSvWlA0pjlK93jH5SiqtCIcOPFoJkvrFR8MqGf7/Y7ZEfZ+47wtRjoTg84xMJ46nPsoZz8IyPAFrw4Y3Au0BE/RPT/th1ZuHm5jMsOkp5NbngwtDhXsDYj3pJcVQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OVLI96+4wwOJHzKdgWGwAZJnT63QlTWK2+EcjFXqGvUOQAU3iO2QzPkElH9u?=
 =?us-ascii?Q?o1ULiHXMuYbPFxEEASpJcI01URYWGWctQ19HkI9wSSrYK9rMVtzZwU7ScSjp?=
 =?us-ascii?Q?IQh0hlzgeYWOF/VgzlGHPSuASvxSWb5zTPEzPgl/mARpZtCAAAU7yabDImpd?=
 =?us-ascii?Q?smSfdZ4Tz/9z/tbZutFMqBJL41rnioyxdkD9OYvdLDNcjXhyLMp9PeYutpYF?=
 =?us-ascii?Q?I9rkgRSVua82XzOn/B9WamWZr3QIPKRcnDO/SQ9ajzxhK3lMoO2ooyseDCb3?=
 =?us-ascii?Q?EIDPWtklpoMQ6lMy6++Rva32ywEkuHCoAF9ayntl4W8WdWl7bqfGvXv6xvkU?=
 =?us-ascii?Q?bZFSXQ58uUeAwVyKTdXSqevfGkEqYLDfcd7xmtcltffXzdlfxvnDyJUt4VjJ?=
 =?us-ascii?Q?psfhaUM2mpevIJmKPIrxLjZ3dz3dOI5iWDzpmBaPR+TM1bxTfcILzo12Q8Nw?=
 =?us-ascii?Q?VXcwgxaOXOtt9XpCuZ3mITBMbIMUYIbAMRR105QG8D17+OR4C0rruhcfpIyz?=
 =?us-ascii?Q?Yg2K4oi4E9hwnlc3aL5aDGT4sDcrr+WQ/f0ymPV/u9Yvt06yw1lsjFpqFEUa?=
 =?us-ascii?Q?x6YjsHBAJfRFBtI5ZN3dY50NTJVgWIBnDuOlu2yORgvCbQz4kF7fowBnqI2f?=
 =?us-ascii?Q?MhEe/ITizR9ouxew/3WcJoYB3Mrt6T0YXwdIQEhnWsJMHnll9umBsFwKWaYN?=
 =?us-ascii?Q?uLrOlsMoFU/9ulihrNf/aVzKWERCXCoVaVVquEvAuI0AF6J+4kFLENaNagKh?=
 =?us-ascii?Q?3a55RblYyhBzb9XGrQIywXX8fhx6ohmhqbfJI3AWRsEf4khPbrvLvQu+E9qU?=
 =?us-ascii?Q?bKNZe9LcSNuNtpt4RTheRN345J7UYr0F6B2bBsfZxfCuo1BvGy3o5H4SX78s?=
 =?us-ascii?Q?ueoj5P23FQHE+tkc858P6HJ595IrGDVpLsDNR2dZx7X9y812tr4Yf82pEYJH?=
 =?us-ascii?Q?rl3xZtb5EqsApVj68T9AHkGMr2VrVrGTGX3Lr69TKn9ff803JCy813pxCrjU?=
 =?us-ascii?Q?jW1hANdTDBe10DC4GM6nbdPNcv/8XA3fH0DrEeFbv4NvhgjfVCUKIPRQzXuS?=
 =?us-ascii?Q?UiYYzq4b?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d12e72a-aa15-4511-3f30-08d8c30189a6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:24.7041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NbIXie60sk0PxhTPEvNEoB6YQlRW/rytn/zMV6g07qIo/AzTdFKqZ9/vbBU99j3fdzCfWyAj5yt9D5it4dbFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On x86/x64, Hyper-V provides a flag to indicate auto EOI functionality,
but it doesn't on ARM64. Handle this quirk inline instead of calling
into code under arch/x86 (and coming, under arch/arm64).

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  3 ---
 drivers/hv/hv.c                 | 12 +++++++++++-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index eba637d1..d12a188 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,9 +27,6 @@ static inline u64 hv_get_register(unsigned int reg)
 	return value;
 }
 
-#define hv_recommend_using_aeoi() \
-	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
-
 #define hv_set_clocksource_vdso(val) \
 	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
 #define hv_enable_vdso_clocksource() \
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 0c1fa69..afe7a62 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -219,7 +219,17 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 	shared_sint.vector = hv_get_vector();
 	shared_sint.masked = false;
-	shared_sint.auto_eoi = hv_recommend_using_aeoi();
+
+	/*
+	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
+	 * it doesn't provide a recommendation flag and AEOI must be disabled.
+	 */
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	shared_sint.auto_eoi =
+			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	shared_sint.auto_eoi = 0;
+#endif
 	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
 				shared_sint.as_uint64);
 
-- 
1.8.3.1

