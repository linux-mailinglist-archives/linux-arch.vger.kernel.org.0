Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41F3275C4
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbhCABRb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhCABR0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:17:26 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EFC061756;
        Sun, 28 Feb 2021 17:16:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfbTeNJL7uBQTyOzicQrR5meztwos6kezebw4675uOKRapUvNQ2JrzqB4Xp9WaKUSDFNB5ocbfkNhxHrdp0Z0uVo6SHToWAOlW7jes5IHLxpqm5tH6821mR6HkzH/JXAJfONbA+CoDvMuLYkc6Sovrcn9HIYXID2Vj0OrqadEbmLN3pbBJYwF7Kyj4E5TIpvhvz/CneBlIQT3sKqXYzQFS/g0PuiU69E8KhsG9ySquvrI5AsA5SPpDiaqWe/rHnxCgCgKTq2YSycj0V2re5QuZokI0UibvcRB71kMiw5KmceX1vhlsty2Rn7brRVxuJQyEHRwbkdwPXG7ochG+ouDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkG1fv5Dl2Yq9bMEvhktXrkc18Hztqx47lG9aGHC4DU=;
 b=GfnH6YS/+wE4EHcqmqc6JT42GnMl3qEreWLj+z1t+q8uXnh92SWleKUmqiiGTGpnZshuAp2m2bUhzssKb72oMsFGgPvwhXH+WfBVdJoMB+L7y0KRDsonYCZVaIl/B2XLw9uIgagU25zAcn4is32wwujWhxMVjk3LUL3asdcP05Su0H+Crro2sRyNja1QvFtADnIlqdw5ZahJah8MqS43+RH6nqvxk4MzugexfJ+HwQf4OcGnxfojkt/P5TIYePZeldoMMWzddaD8LTDcdFiISxj93lxuy6yCWfSja4aIvWbsO5LP49rnQmsB4s9Q42OdoSLaD+KYOKXpnY6MpfrVvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkG1fv5Dl2Yq9bMEvhktXrkc18Hztqx47lG9aGHC4DU=;
 b=THB9we0cIsGKS813VvUnG5FT3zXFBSdMaQid2jVdUAl7iFKb1oCpRrwMSElLtOPgyLxnq43sND2DvPKC6/+xj0gojSJ87piu755uEyD+Xc7TIwrkCAZFQMyU9W9uXhDJlS1sGBFek63rD2vVZSvoUzjf1Lh3vAW2pz4k3hfuCsA=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:04 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:04 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 03/10] Drivers: hv: Redo Hyper-V synthetic MSR get/set functions
Date:   Sun, 28 Feb 2021 17:15:25 -0800
Message-Id: <1614561332-2523-4-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 66885502-4cf0-4c9d-8907-08d8dc4f953a
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB09813D50431572AA0B1C7FD2D79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FbzcJHJXN1DekgkSXbvGgY8STb8FPLzbQv8qQpJKE289iWS+FB7T+tHyQyQ2NKAu9fSWuW3q+dL6o1ZFCKRz0dMOoddX0N+xSGJORz2AXgOowSsUZyRU9RVcCUbgkkrS6wCw8f2gPQi6WXMb2R0rvNLFFYnRf57o3UthQg/wJuK7GYXfvF+5t3xY6hhrYDa3Xq4F1LjMOwO5Q0r5n0eYjZtZNBeHpbPUljGA5xjoXbqObK9ebtdKsTRTmsz2xY4Wumfsw2NTG3slsb2Fi7yDcGzPkVYF05k6jYMO8O0Mxp+fADNuoFyfkWKG79hH6VXGTwhUyKflXqYWxXzR20UPqmqUdzZ3z3hoHIVSQ70SL8DvGYELoMptfFic7IEsE/W1Z2nrJNuYE03y6g60o7fGepiRnbf2VdNp56jU7Lsob8Ef+WQ09/X3ALjffhb51r8RaPGfRKyHrCahCc/3XsdNl+bL4TpGwgoXbbix6VAqkbFyXUne+ZTDezC4nxr/vJymAzXeosvNf2o+iE8EZMLr+5+gaDEEWYHxUBTuNn9Br3W+/VyXMUAhMsQi4oryUatK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(30864003)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oZEg4vsQp0LauFGQYNQo/yhq+bfYvi94hyEUoSl92rY331yuHw2G6CLXFhpj?=
 =?us-ascii?Q?w1QlXofdzgQZVgE3A8OTV5MGgJcnnRcWK/aXYCEbTS4lqWVyDLnX+dfu5KL9?=
 =?us-ascii?Q?x9Tt+u5Ree0qxvMQAkbMvdfozvIGTXd+oW6124NsJBkPmFaUo75x40OGueMw?=
 =?us-ascii?Q?SEBpp/G0QtGLs0R6WwrAngBejk4xCkTQpWQe9tCbXlr5Gy5iPf8dJinAhRRc?=
 =?us-ascii?Q?dsCGehEkAj4YXentdxavdWa/O9yFgu/7qWbL0PdUgZr04TbjMr+VI2zoacgE?=
 =?us-ascii?Q?yUMdEpUeGvqyJCjB5Pv2MhIW3eya56osgCWrZW6QR/b/cRHKExHP8xm/kILI?=
 =?us-ascii?Q?qjY2qzopoWJe+9hWn8hBfMsfnPhazznOMcBp+hcNh8ZgLm1ZeR+pIzc8c50w?=
 =?us-ascii?Q?8z50Cb710piyogXujKsNlGCFGxRxHFfZtrl1uwNXdjbRMpMoWolgg73HiVzA?=
 =?us-ascii?Q?A5Hv6saRkA+eJVo3TPdtns0irZ/d5vbYlb3T6x8kRXX+tigY+Ex59JYRbyFL?=
 =?us-ascii?Q?iM2lTJSOKxanvDCK5KHROyBNSpJAFLUThyj9gNIyA5HxL/7fswGr9wKpR08U?=
 =?us-ascii?Q?h2ADMRkhF/OC7uHi2iVnef7kRNTzL4Q7QcjgehF/hlF7f6vim4Q+4HgDE3UE?=
 =?us-ascii?Q?BLBQCA76DCfAWvKMlhaUj4IahYJBfnhe0+RLakEcDFk+dlx7415daBIfnA9v?=
 =?us-ascii?Q?pQ03K92dHxUdeynCs+bRBnijoIrUIvTgRsMMsfLmAerbQs7iY/fI859mZ6ig?=
 =?us-ascii?Q?Bx6CdTbBKzxV2f4WkYdDhII8pF7i3Mkj3eqTbSaG+twfkKLJrPrSYM+woeeM?=
 =?us-ascii?Q?Z4pU1GkMdMF7go+9TQ7K51BEgHqnwEFRhBXZ0cQaOyBFRAcBI1q2YPWwMS2v?=
 =?us-ascii?Q?50x3PMZON1jW4cGDPe340REHNi8FsSgGSAn+wjdTuDe67QvhOVbvWqoEnR51?=
 =?us-ascii?Q?sPa935oDrIO0oXIVXLNkejOfJjCCQjb8UX1dSEMnWRF7OaUs7vQPriOk2SvW?=
 =?us-ascii?Q?K6gwvV66WAU+PRIwmcpzrUBwQr6sX3c9WAc1uwIrRP1S8f1uZelTGyWJUCmT?=
 =?us-ascii?Q?A2WQCajH5cWRpC2jYxDrCh2ljjQMtiLCep00WGn/n4OEwNyC8kxf1LKRdDYc?=
 =?us-ascii?Q?oBxccmuMZnWlV6SNAk+JnTD2ZVjiTs7/DUoJud23TBNBvFja2MOZnFz/x7cG?=
 =?us-ascii?Q?jDZ4bpgi2QMWGFq5zn+kYLy0OSox+4ExRV/u7HRIWdSC43GyfNhlvwnl60pG?=
 =?us-ascii?Q?ocsm6EVlX9WsCgEwVME3QeF6BxqlumWx7G9XnNtdEw5C/6vqREuraVi175Ko?=
 =?us-ascii?Q?KM6Ek1L83bXkiKSctvJNLYNB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66885502-4cf0-4c9d-8907-08d8dc4f953a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:03.9274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gl7TDbkcShWvCZ2/0il75PaLJtOlWe2YgS+dVx6gqehDqNoURwh1HknVq9OXlIwHxyUfFEHi1m7LQD4NYT3GPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
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
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
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
index 4bdb344..94d52c5 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -75,7 +75,7 @@ static int hv_cpu_init(unsigned int cpu)
 		*output_arg = page_address(pg + 1);
 	}
 
-	hv_get_vp_index(msr_vp_index);
+	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
 
 	hv_vp_index[smp_processor_id()] = msr_vp_index;
 
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 68b38a2..606f5cc 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -156,7 +156,7 @@ enum hv_isolation_type {
 #define HV_X64_MSR_HYPERCALL			0x40000001
 
 /* MSR used to provide vcpu index */
-#define HV_X64_MSR_VP_INDEX			0x40000002
+#define HV_REGISTER_VP_INDEX			0x40000002
 
 /* MSR used to reset the guest OS. */
 #define HV_X64_MSR_RESET			0x40000003
@@ -165,10 +165,10 @@ enum hv_isolation_type {
 #define HV_X64_MSR_VP_RUNTIME			0x40000010
 
 /* MSR used to read the per-partition time reference counter */
-#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
+#define HV_REGISTER_TIME_REF_COUNT		0x40000020
 
 /* A partition's reference time stamp counter (TSC) page */
-#define HV_X64_MSR_REFERENCE_TSC		0x40000021
+#define HV_REGISTER_REFERENCE_TSC		0x40000021
 
 /* MSR used to retrieve the TSC frequency */
 #define HV_X64_MSR_TSC_FREQUENCY		0x40000022
@@ -183,50 +183,50 @@ enum hv_isolation_type {
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
@@ -236,6 +236,32 @@ enum hv_isolation_type {
 /* TSC invariant control */
 #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
 
+/* Register name aliases for temporary compatibility */
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
index ef6e968..2590ce5 100644
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
index 269a691..c73c127 100644
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
@@ -439,10 +437,10 @@ static bool __init hv_init_tsc_clocksource(void)
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
index 10dce9f..9e63170 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1521,7 +1521,7 @@ static int vmbus_bus_init(void)
 		 * Register for panic kmsg callback only if the right
 		 * capability is supported by the hypervisor.
 		 */
-		hv_get_crash_ctl(hyperv_crash_ctl);
+		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
 		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
 			hv_kmsg_dump_register();
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 694b5bc..163d8b0 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -88,7 +88,7 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 		 * possibly deliver another msg from the
 		 * hypervisor
 		 */
-		hv_signal_eom();
+		hv_set_register(HV_REGISTER_EOM, 0);
 	}
 }
 
-- 
1.8.3.1

