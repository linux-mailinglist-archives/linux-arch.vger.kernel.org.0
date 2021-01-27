Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988A5306511
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhA0UZz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:25:55 -0500
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:61825
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232719AbhA0UZb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:25:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jRYqmt3r28CUXCQxs5VnTm+BiG3MlVspY2bm/BZ0MiauDoBdOsVF0likWtX0wDupimp3IXnp6H2KeN7i7scSFw+LCktyjXUbXEx19MESKpCaN8q65CZJ/Y6SIYkd9u2kkRKvphg8jaGRULkcKCMOqH2JqodLHy/td7C7JzN/7pRma2HR7IoEhkAujJId3OGyk8MdTJyiiOE5BMEDD3L3ubhukrPvZ9/CVarrAic4OZyHQL4924apwB46DzSE1oWeceNVJ8yANDoT/o1n0CYcGvs5gFKyekFjL7wDVpbDO5zOBmn9k9lrlFJbblyF+VettlH2/uYENGUixc4zydeifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gb9pfclqIoNRqJxJUrJngms1SfPA3lwVK1B4Xj5wm0=;
 b=MzI3E/HS1xdart5LFqo7FGAo3aj2ZGJdaYsgVq7lCKBHUNpts5iribWhoEbbuJBLSczOQ35Gm4uRq8vn1KjHE+R54Jxy909QHFyP44l2EhiHeSiJJ5oX4CLcDOlhuJcIClU8ELRNeXJXzfWJ1k6Y8daqAK/o540l4SyySjMSKkDvr2mHt76oT3QoGHhHLqVwdnDGIpeUk3z4/DKtJ1/lrNBdN3YA3WXrwWUoksgrcUNWWXqjp+b1BpGk4PLvbN7DmYUs/9H3Tiq6x02E6icgAtwsDp0Bcp0kUxFAMOFHojhF1cnfY+sJOf74ZxO1TdZZe1+mf5u9mawriffhtptGXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gb9pfclqIoNRqJxJUrJngms1SfPA3lwVK1B4Xj5wm0=;
 b=L+atnWx3m92Bi04hlCevbZdUHw+Q1Y+UGWbHlpvjQa8nf+yqpE/9mbTOsVqYdzOnC5fagJbZFGGFlMXGzcAzHBTTmls9MQOGl8SP6ugSv7s8gdVqSiBBMkwgAMQ31AWlx9LzM1weutASlymSZukDrpQ+1OnnfTfcD6ruto2eJJw=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:21 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:21 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 03/10] Drivers: hv: Redo Hyper-V synthetic MSR get/set functions
Date:   Wed, 27 Jan 2021 12:23:38 -0800
Message-Id: <1611779025-21503-4-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97760dd6-f737-42b7-a932-08d8c30187a0
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB12151443FA355FD81C10120AD7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R+NxZ+d2W48bOVy7ck2+LJqNDkDh/l1+IthNrHFQ294OZFs1w06QWI0VOG77HwSYoIkaVu7ALqMud7Q8dwF5YQb/aS9X0pVqxGrEyh+Mmlc6XOoRs61q4BOh+i9g7uW2D0t7z8qAmRyTds+6XWZdtg3YxPwlKSPWcopsvm7M6NCHX5tkUKz3zbWkJycaeKoRfhnD1ToTmOLgrws8Y8Mg9poEFgZ3mPEXQ7oxww62Eu/NZ50to0iCQP1x5H/ncwt8wQA+91vGX06dMnIjXr0QE1TOTS5Victz9tIG1B59l28bmloa04Jn2MJIpSqI7ZCv9Bg4RttN4xseqUsnz2KxPXiLCOL9DDe7ITqS0MUl3bc4OTiTRZpWHwMGNcSLgl0xyOL1iZqgjWi4li7I55ATgs3Dx9CC2DMJvG1SwQDD+PWaZvwh/DCItlRwPPfJf6wbhv1EbM588yC2SGlbLwZgCtV3ctTFxKxW48udsNsPIIKYDgOLlzsmBvYsj4S7bKU2TLcnDjqajXkWlrKU2kOGDkXy9E7QYRTf1fomGpNyjajRlHfJCr4VHa0wkE0B0X+X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(30864003)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?LOb2pxNW5O0d2ZnQ1A8nSSdOTU4wztVR6p2x8snp+bweUAY6Cw/Aoosfohg1?=
 =?us-ascii?Q?1LObvYvE8cSropYj+8v9QcMqKT2IH/rr5CWu3ZYhQfzdSngkELw8fJrq/sWm?=
 =?us-ascii?Q?tQ8xXU21K0epau5HuUhqLpGPX8xmBr3rK9jZ+hNjKVfbf09gYbqWzFvEpCKp?=
 =?us-ascii?Q?oC2c+erYkqPpjZlpGhSWfPqVcx6hqdK1ciLg0FUZUN/fljsAonDR7DMVrJBr?=
 =?us-ascii?Q?M2Kn6pd31hVOfFJk9U3nWBKwMR4/GrFrzcm+wdvvXVzzQeInBImaAHNxkztB?=
 =?us-ascii?Q?K8XzL4p7Jw3pcBlYvSJLOkn/FvTKtRplqLFQebWRK+mSR3m2vbwf/pl1GMaf?=
 =?us-ascii?Q?Whvlt8UcSfriGDHokVb1M/8e7C2I1dURKDY2AKi4mhmowPOlEKSj8lOPjJ/N?=
 =?us-ascii?Q?TJKJoFPwEALcYzPiSYWwleCD75ephup6f7rC1EcaOcdWyx2OvSSxzaE9+dg2?=
 =?us-ascii?Q?eR2Li/a5JprUEO8xqTL8RvD8zgaXuhvW2zSxkj5q/LFVDXrQZt9jjSXXwQRw?=
 =?us-ascii?Q?vMlHzpieOAQgD4yg04sFY5JjOEtfdZ7cW74VuY5O69WOrSpBDU4gNqE7G0cQ?=
 =?us-ascii?Q?EqHGHDzFbSZ/INWueHSV5QST0zUq6ckDb8ANS+5Tr+rMtN1cIZz8OVQvY61v?=
 =?us-ascii?Q?c4gRT+kf0ObQAy3A5UgroAQ4WAErbgWhU+Jfu7VKitFojB2lsImZzlBA6wZe?=
 =?us-ascii?Q?4Zdt0jLKut72dzQh8r6fCgdmsGSHuTEepTBO91OsqxUgENdPGFOizObrdGkP?=
 =?us-ascii?Q?DY5cMqACzfJwDrFT2A+7/dYDSQd7ViPZ2yRlxiNr18XFZrikZdm5rcfKiO3Y?=
 =?us-ascii?Q?tSgzwEKJ5VqiFzBHuksu2vzkEauFrnzdkBS6aXWyZCvSWVz9PjTqlrN7zb1B?=
 =?us-ascii?Q?I+ZRsO699hDsp7UKl3N8YjhJ1F4aKEd0b5plkKg+n31c4JuG7iBPsogGuH1t?=
 =?us-ascii?Q?Nl8VjN2BshzrRcnkrVLnrhBAfYP5Lf6OCf9CtLnwzRSenC5bVHONfQxYgjPK?=
 =?us-ascii?Q?Qo1kZtxN3R/TLJjZJmV+NI3sdhXMyWLhHykgQ1BgJzDODOynjQyu5ySjvUdX?=
 =?us-ascii?Q?sgqbhqFY?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97760dd6-f737-42b7-a932-08d8c30187a0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:21.2111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJWc+EvxblHjbFCOm8HMGP/ofS3zC7DYmEhfKyyoidT+Ug+G/MCz7oFTNnZcrmWnBJBL/cUMWuKWpbBmgGLLMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Current code defines a separate get and set macro for each Hyper-V
synthetic MSR used by the VMbus driver. Furthermore, the get macro
can't be converted to a standard function because the second argument
is modified in place, which is somewhat bad form.

Redo this by providing a single get and a single set function that
take a parameter specifying the MSR to be operated on. Fixup usage
of the get function. Calling locations are no more complex than before,
but the code under arch/x86 and the upcoming code under arch/arm64
is significantly simplified.

Also standardize the names of Hyper-V synthetic MSRs that are
architecture neutral. But keep the old x86-specific names as aliases
that can be removed later when all references (particularly in KVM
code) have been cleaned up in a separate patch series.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c          |   2 +-
 arch/x86/include/asm/hyperv-tlfs.h | 102 +++++++++++++++++++++++--------------
 arch/x86/include/asm/mshyperv.h    |  39 ++++----------
 drivers/clocksource/hyperv_timer.c |  26 +++++-----
 drivers/hv/hv.c                    |  37 ++++++++------
 drivers/hv/vmbus_drv.c             |   2 +-
 include/asm-generic/mshyperv.h     |   2 +-
 7 files changed, 110 insertions(+), 100 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 2d1688e..9b2cdbe 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -58,7 +58,7 @@ static int hv_cpu_init(unsigned int cpu)
 		return -ENOMEM;
 	*input_arg = page_address(pg);
 
-	hv_get_vp_index(msr_vp_index);
+	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
 
 	hv_vp_index[smp_processor_id()] = msr_vp_index;
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index dd74066..545026e 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -131,7 +131,7 @@
 #define HV_X64_MSR_HYPERCALL			0x40000001
 
 /* MSR used to provide vcpu index */
-#define HV_X64_MSR_VP_INDEX			0x40000002
+#define HV_REGISTER_VP_INDEX			0x40000002
 
 /* MSR used to reset the guest OS. */
 #define HV_X64_MSR_RESET			0x40000003
@@ -140,10 +140,10 @@
 #define HV_X64_MSR_VP_RUNTIME			0x40000010
 
 /* MSR used to read the per-partition time reference counter */
-#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
+#define HV_REGISTER_TIME_REF_COUNT		0x40000020
 
 /* A partition's reference time stamp counter (TSC) page */
-#define HV_X64_MSR_REFERENCE_TSC		0x40000021
+#define HV_REGISTER_REFERENCE_TSC		0x40000021
 
 /* MSR used to retrieve the TSC frequency */
 #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
@@ -158,50 +158,50 @@
 #define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
 
 /* Define synthetic interrupt controller model specific registers. */
-#define HV_X64_MSR_SCONTROL			0x40000080
-#define HV_X64_MSR_SVERSION			0x40000081
-#define HV_X64_MSR_SIEFP			0x40000082
-#define HV_X64_MSR_SIMP				0x40000083
-#define HV_X64_MSR_EOM				0x40000084
-#define HV_X64_MSR_SINT0			0x40000090
-#define HV_X64_MSR_SINT1			0x40000091
-#define HV_X64_MSR_SINT2			0x40000092
-#define HV_X64_MSR_SINT3			0x40000093
-#define HV_X64_MSR_SINT4			0x40000094
-#define HV_X64_MSR_SINT5			0x40000095
-#define HV_X64_MSR_SINT6			0x40000096
-#define HV_X64_MSR_SINT7			0x40000097
-#define HV_X64_MSR_SINT8			0x40000098
-#define HV_X64_MSR_SINT9			0x40000099
-#define HV_X64_MSR_SINT10			0x4000009A
-#define HV_X64_MSR_SINT11			0x4000009B
-#define HV_X64_MSR_SINT12			0x4000009C
-#define HV_X64_MSR_SINT13			0x4000009D
-#define HV_X64_MSR_SINT14			0x4000009E
-#define HV_X64_MSR_SINT15			0x4000009F
+#define HV_REGISTER_SCONTROL			0x40000080
+#define HV_REGISTER_SVERSION			0x40000081
+#define HV_REGISTER_SIEFP			0x40000082
+#define HV_REGISTER_SIMP			0x40000083
+#define HV_REGISTER_EOM				0x40000084
+#define HV_REGISTER_SINT0			0x40000090
+#define HV_REGISTER_SINT1			0x40000091
+#define HV_REGISTER_SINT2			0x40000092
+#define HV_REGISTER_SINT3			0x40000093
+#define HV_REGISTER_SINT4			0x40000094
+#define HV_REGISTER_SINT5			0x40000095
+#define HV_REGISTER_SINT6			0x40000096
+#define HV_REGISTER_SINT7			0x40000097
+#define HV_REGISTER_SINT8			0x40000098
+#define HV_REGISTER_SINT9			0x40000099
+#define HV_REGISTER_SINT10			0x4000009A
+#define HV_REGISTER_SINT11			0x4000009B
+#define HV_REGISTER_SINT12			0x4000009C
+#define HV_REGISTER_SINT13			0x4000009D
+#define HV_REGISTER_SINT14			0x4000009E
+#define HV_REGISTER_SINT15			0x4000009F
 
 /*
  * Synthetic Timer MSRs. Four timers per vcpu.
  */
-#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
-#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
-#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
-#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
-#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
-#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
-#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
-#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
+#define HV_REGISTER_STIMER0_CONFIG		0x400000B0
+#define HV_REGISTER_STIMER0_COUNT		0x400000B1
+#define HV_REGISTER_STIMER1_CONFIG		0x400000B2
+#define HV_REGISTER_STIMER1_COUNT		0x400000B3
+#define HV_REGISTER_STIMER2_CONFIG		0x400000B4
+#define HV_REGISTER_STIMER2_COUNT		0x400000B5
+#define HV_REGISTER_STIMER3_CONFIG		0x400000B6
+#define HV_REGISTER_STIMER3_COUNT		0x400000B7
 
 /* Hyper-V guest idle MSR */
 #define HV_X64_MSR_GUEST_IDLE			0x400000F0
 
 /* Hyper-V guest crash notification MSR's */
-#define HV_X64_MSR_CRASH_P0			0x40000100
-#define HV_X64_MSR_CRASH_P1			0x40000101
-#define HV_X64_MSR_CRASH_P2			0x40000102
-#define HV_X64_MSR_CRASH_P3			0x40000103
-#define HV_X64_MSR_CRASH_P4			0x40000104
-#define HV_X64_MSR_CRASH_CTL			0x40000105
+#define HV_REGISTER_CRASH_P0			0x40000100
+#define HV_REGISTER_CRASH_P1			0x40000101
+#define HV_REGISTER_CRASH_P2			0x40000102
+#define HV_REGISTER_CRASH_P3			0x40000103
+#define HV_REGISTER_CRASH_P4			0x40000104
+#define HV_REGISTER_CRASH_CTL			0x40000105
 
 /* TSC emulation after migration */
 #define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
@@ -211,6 +211,32 @@
 /* TSC invariant control */
 #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
 
+/* Register name aliases for architecture independence */
+#define HV_X64_MSR_STIMER0_COUNT	HV_REGISTER_STIMER0_COUNT
+#define HV_X64_MSR_STIMER0_CONFIG	HV_REGISTER_STIMER0_CONFIG
+#define HV_X64_MSR_STIMER1_COUNT	HV_REGISTER_STIMER1_COUNT
+#define HV_X64_MSR_STIMER1_CONFIG	HV_REGISTER_STIMER1_CONFIG
+#define HV_X64_MSR_STIMER2_COUNT	HV_REGISTER_STIMER2_COUNT
+#define HV_X64_MSR_STIMER2_CONFIG	HV_REGISTER_STIMER2_CONFIG
+#define HV_X64_MSR_STIMER3_COUNT	HV_REGISTER_STIMER3_COUNT
+#define HV_X64_MSR_STIMER3_CONFIG	HV_REGISTER_STIMER3_CONFIG
+#define HV_X64_MSR_SCONTROL		HV_REGISTER_SCONTROL
+#define HV_X64_MSR_SVERSION		HV_REGISTER_SVERSION
+#define HV_X64_MSR_SIMP			HV_REGISTER_SIMP
+#define HV_X64_MSR_SIEFP		HV_REGISTER_SIEFP
+#define HV_X64_MSR_VP_INDEX		HV_REGISTER_VP_INDEX
+#define HV_X64_MSR_EOM			HV_REGISTER_EOM
+#define HV_X64_MSR_SINT0		HV_REGISTER_SINT0
+#define HV_X64_MSR_SINT15		HV_REGISTER_SINT15
+#define HV_X64_MSR_CRASH_P0		HV_REGISTER_CRASH_P0
+#define HV_X64_MSR_CRASH_P1		HV_REGISTER_CRASH_P1
+#define HV_X64_MSR_CRASH_P2		HV_REGISTER_CRASH_P2
+#define HV_X64_MSR_CRASH_P3		HV_REGISTER_CRASH_P3
+#define HV_X64_MSR_CRASH_P4		HV_REGISTER_CRASH_P4
+#define HV_X64_MSR_CRASH_CTL		HV_REGISTER_CRASH_CTL
+#define HV_X64_MSR_TIME_REF_COUNT	HV_REGISTER_TIME_REF_COUNT
+#define HV_X64_MSR_REFERENCE_TSC	HV_REGISTER_REFERENCE_TSC
+
 /*
  * Declare the MSR used to setup pages used to communicate with the hypervisor.
  */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 29d0414..eba637d1 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -14,41 +14,22 @@ typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
 		void *data);
 
-#define hv_init_timer(timer, tick) \
-	wrmsrl(HV_X64_MSR_STIMER0_COUNT + (2*timer), tick)
-#define hv_init_timer_config(timer, val) \
-	wrmsrl(HV_X64_MSR_STIMER0_CONFIG + (2*timer), val)
-
-#define hv_get_simp(val) rdmsrl(HV_X64_MSR_SIMP, val)
-#define hv_set_simp(val) wrmsrl(HV_X64_MSR_SIMP, val)
-
-#define hv_get_siefp(val) rdmsrl(HV_X64_MSR_SIEFP, val)
-#define hv_set_siefp(val) wrmsrl(HV_X64_MSR_SIEFP, val)
-
-#define hv_get_synic_state(val) rdmsrl(HV_X64_MSR_SCONTROL, val)
-#define hv_set_synic_state(val) wrmsrl(HV_X64_MSR_SCONTROL, val)
+static inline void hv_set_register(unsigned int reg, u64 value)
+{
+	wrmsrl(reg, value);
+}
 
-#define hv_get_vp_index(index) rdmsrl(HV_X64_MSR_VP_INDEX, index)
+static inline u64 hv_get_register(unsigned int reg)
+{
+	u64 value;
 
-#define hv_signal_eom() wrmsrl(HV_X64_MSR_EOM, 0)
+	rdmsrl(reg, value);
+	return value;
+}
 
-#define hv_get_synint_state(int_num, val) \
-	rdmsrl(HV_X64_MSR_SINT0 + int_num, val)
-#define hv_set_synint_state(int_num, val) \
-	wrmsrl(HV_X64_MSR_SINT0 + int_num, val)
 #define hv_recommend_using_aeoi() \
 	(!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED))
 
-#define hv_get_crash_ctl(val) \
-	rdmsrl(HV_X64_MSR_CRASH_CTL, val)
-
-#define hv_get_time_ref_count(val) \
-	rdmsrl(HV_X64_MSR_TIME_REF_COUNT, val)
-
-#define hv_get_reference_tsc(val) \
-	rdmsrl(HV_X64_MSR_REFERENCE_TSC, val)
-#define hv_set_reference_tsc(val) \
-	wrmsrl(HV_X64_MSR_REFERENCE_TSC, val)
 #define hv_set_clocksource_vdso(val) \
 	((val).vdso_clock_mode = VDSO_CLOCKMODE_HVCLOCK)
 #define hv_enable_vdso_clocksource() \
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index ba04cb3..9425308 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -68,14 +68,14 @@ static int hv_ce_set_next_event(unsigned long delta,
 
 	current_tick = hv_read_reference_counter();
 	current_tick += delta;
-	hv_init_timer(0, current_tick);
+	hv_set_register(HV_REGISTER_STIMER0_COUNT, current_tick);
 	return 0;
 }
 
 static int hv_ce_shutdown(struct clock_event_device *evt)
 {
-	hv_init_timer(0, 0);
-	hv_init_timer_config(0, 0);
+	hv_set_register(HV_REGISTER_STIMER0_COUNT, 0);
+	hv_set_register(HV_REGISTER_STIMER0_CONFIG, 0);
 	if (direct_mode_enabled)
 		hv_disable_stimer0_percpu_irq(stimer0_irq);
 
@@ -105,7 +105,7 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
 		timer_cfg.direct_mode = 0;
 		timer_cfg.sintx = stimer0_message_sint;
 	}
-	hv_init_timer_config(0, timer_cfg.as_uint64);
+	hv_set_register(HV_REGISTER_STIMER0_CONFIG, timer_cfg.as_uint64);
 	return 0;
 }
 
@@ -331,7 +331,7 @@ static u64 notrace read_hv_clock_tsc(void)
 	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
 	if (current_tick == U64_MAX)
-		hv_get_time_ref_count(current_tick);
+		current_tick = hv_get_register(HV_REGISTER_TIME_REF_COUNT);
 
 	return current_tick;
 }
@@ -352,9 +352,9 @@ static void suspend_hv_clock_tsc(struct clocksource *arg)
 	u64 tsc_msr;
 
 	/* Disable the TSC page */
-	hv_get_reference_tsc(tsc_msr);
+	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr &= ~BIT_ULL(0);
-	hv_set_reference_tsc(tsc_msr);
+	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
 
@@ -364,10 +364,10 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	u64 tsc_msr;
 
 	/* Re-enable the TSC page */
-	hv_get_reference_tsc(tsc_msr);
+	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr &= GENMASK_ULL(11, 0);
 	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
-	hv_set_reference_tsc(tsc_msr);
+	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 }
 
 static int hv_cs_enable(struct clocksource *cs)
@@ -389,14 +389,12 @@ static int hv_cs_enable(struct clocksource *cs)
 
 static u64 notrace read_hv_clock_msr(void)
 {
-	u64 current_tick;
 	/*
 	 * Read the partition counter to get the current tick count. This count
 	 * is set to 0 when the partition is created and is incremented in
 	 * 100 nanosecond units.
 	 */
-	hv_get_time_ref_count(current_tick);
-	return current_tick;
+	return hv_get_register(HV_REGISTER_TIME_REF_COUNT);
 }
 
 static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
@@ -436,10 +434,10 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * (which already has at least the low 12 bits set to zero since
 	 * it is page aligned). Also set the "enable" bit, which is bit 0.
 	 */
-	hv_get_reference_tsc(tsc_msr);
+	tsc_msr = hv_get_register(HV_REGISTER_REFERENCE_TSC);
 	tsc_msr &= GENMASK_ULL(11, 0);
 	tsc_msr = tsc_msr | 0x1 | (u64)phys_addr;
-	hv_set_reference_tsc(tsc_msr);
+	hv_set_register(HV_REGISTER_REFERENCE_TSC, tsc_msr);
 
 	hv_set_clocksource_vdso(hyperv_cs_tsc);
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index cca8d5e..0c1fa69 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -198,34 +198,36 @@ void hv_synic_enable_regs(unsigned int cpu)
 	union hv_synic_scontrol sctrl;
 
 	/* Setup the Synic's message page */
-	hv_get_simp(simp.as_uint64);
+	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 	simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
 		>> HV_HYP_PAGE_SHIFT;
 
-	hv_set_simp(simp.as_uint64);
+	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
 
 	/* Setup the Synic's event page */
-	hv_get_siefp(siefp.as_uint64);
+	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 	siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
 		>> HV_HYP_PAGE_SHIFT;
 
-	hv_set_siefp(siefp.as_uint64);
+	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
 
 	/* Setup the shared SINT. */
-	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
+					VMBUS_MESSAGE_SINT);
 
 	shared_sint.vector = hv_get_vector();
 	shared_sint.masked = false;
 	shared_sint.auto_eoi = hv_recommend_using_aeoi();
-	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+				shared_sint.as_uint64);
 
 	/* Enable the global synic bit */
-	hv_get_synic_state(sctrl.as_uint64);
+	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
 	sctrl.enable = 1;
 
-	hv_set_synic_state(sctrl.as_uint64);
+	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
 }
 
 int hv_synic_init(unsigned int cpu)
@@ -247,32 +249,35 @@ void hv_synic_disable_regs(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_scontrol sctrl;
 
-	hv_get_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	shared_sint.as_uint64 = hv_get_register(HV_REGISTER_SINT0 +
+					VMBUS_MESSAGE_SINT);
 
 	shared_sint.masked = 1;
 
 	/* Need to correctly cleanup in the case of SMP!!! */
 	/* Disable the interrupt */
-	hv_set_synint_state(VMBUS_MESSAGE_SINT, shared_sint.as_uint64);
+	hv_set_register(HV_REGISTER_SINT0 + VMBUS_MESSAGE_SINT,
+				shared_sint.as_uint64);
 
-	hv_get_simp(simp.as_uint64);
+	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 0;
 	simp.base_simp_gpa = 0;
 
-	hv_set_simp(simp.as_uint64);
+	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
 
-	hv_get_siefp(siefp.as_uint64);
+	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 	siefp.base_siefp_gpa = 0;
 
-	hv_set_siefp(siefp.as_uint64);
+	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
 
 	/* Disable the global synic bit */
-	hv_get_synic_state(sctrl.as_uint64);
+	sctrl.as_uint64 = hv_get_register(HV_REGISTER_SCONTROL);
 	sctrl.enable = 0;
-	hv_set_synic_state(sctrl.as_uint64);
+	hv_set_register(HV_REGISTER_SCONTROL, sctrl.as_uint64);
 }
 
+
 int hv_synic_cleanup(unsigned int cpu)
 {
 	struct vmbus_channel *channel, *sc;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 502f8cd..089f165 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1494,7 +1494,7 @@ static int vmbus_bus_init(void)
 		 * Register for panic kmsg callback only if the right
 		 * capability is supported by the hypervisor.
 		 */
-		hv_get_crash_ctl(hyperv_crash_ctl);
+		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
 			hv_kmsg_dump_register();
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 762d3ac..10c97a9 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -85,7 +85,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_signal_eom();
+		hv_set_register(HV_REGISTER_EOM, 0);
 	}
 }
 
-- 
1.8.3.1

