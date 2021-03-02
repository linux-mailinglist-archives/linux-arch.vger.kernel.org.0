Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 680DA32B4D1
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447180AbhCCF3e (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:29:34 -0500
Received: from mail-bn7nam10on2091.outbound.protection.outlook.com ([40.107.92.91]:28513
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350928AbhCBVkT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:40:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDz1S6fAQxwW6MEPw5EqeIC+GBP6Vl4l1xBC3vbJz3WXAqE0hNlbi50XbOii4VzjPMJ14t4CdgYQSiIxYdjkBVqbnEBhyEJ+NA8jtHAe5IO34q2uphTGzUyDvpQa50EaN0If7hWxAv8Y5xitpQQz4SQgtA7DF8lnrX6lxrHbr3kJXZ5qp9Fd0+VnyyYotp6pnF9FTKQht3tlJAIEDttsjNcLfYBTykynf80QL3an5rudNAdqdU3KUT/dXvtrVcCcouox/aRegusWTJZudo+P8ToJAmQvS6i28xdqLpIFRf4MgMmj8VrZItMZkeUHZ+GEgh3qEhKbnd3Kd7IuAcBSmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3suxiQNBmLzDK95gAevTg151BuVaUgANYqf6MAMq6E=;
 b=Bb+Q/OEjJfkh38l1S58jlrrHjAbgYEwn5vDPjm7QkcFjLrsDr7nWHnoJ5oROZ2M1cdAQSBcFpSw2vEG8IAwtfujslGcACXsTyK1BfLGWALU0PWKeqk6o1eiZV2qs4coiR/klBHt+Ouh472jiUUC/JklDLBPZ3dWWrLVuW/1qoMEr05vQ4sk+qJ3xJBFeHGtUIIVj1vBIuEjSSaU7XH2A1t69NTxFACI9G3GCHVKa2KDZXqzgHCNghPrjoD0r1e2r+WMvWgULEZd0Cu3UMaU/2aILT8H89yaa/j7vaPDipoNLxUfnXv4R5o+FyVkICwxBE2LuW+ED2ezw99w7FX6N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3suxiQNBmLzDK95gAevTg151BuVaUgANYqf6MAMq6E=;
 b=NOIt1r0Ob+JdvD63TCRuog0HnUNceMMkx3wdYQ+8WAHLGF9e5loGfN5RRPut/1hTdT2zJzQDmrrh2ciNV0YUPu+b5rVPDaU2olvHSG+5RaDRulDQpImR/2L816u3rrJrMOJiGaX9U3QZ6g7gGzopPcgtgx27xj5IhjzsimGGhdQ=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1739.namprd21.prod.outlook.com (2603:10b6:5:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.1; Tue, 2 Mar
 2021 21:38:49 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:49 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 01/10] Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code
Date:   Tue,  2 Mar 2021 13:38:13 -0800
Message-Id: <1614721102-2241-2-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 82d2dd93-5cc3-41b0-394e-08d8ddc38f65
X-MS-TrafficTypeDiagnostic: DM6PR21MB1739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1739C8060F8B1983ADBBCE7DD7999@DM6PR21MB1739.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRargeFkUNt+QNKCPa7Qc2j3fmKY+R0AierSstS5nP/ztzt2XldJJF3xsH8po4AEgpNemhY3k5dv0Sgd7qMsna+govWOEH67h36GpkeViWrmM5QQKXDx/evBuhzwTxFngtFJeAi0M6aI9/Hguq0lhrs1R8w1sih/dfmIeHKPPzNUE+ym+rB1MltcuqUIVoyIzGo82FX8Kh3cAdHEVc8lrTufFctqaHvtrE6pmkAhtmEcPONIUwvPVJ4eWiWPB3FxAGu6fJVhgj6umVWaoGEN69w6kC6x6EqKMqS3yGcMKkYOxnPjFNBeOFJGUUE5z08PCq8rbXXH1tnaD/nTY803EGeCOIOnUFMAG0QxUdQPgYLGpjXWNfEALqbHg9Wa8R2yHsLL7Dw7pg9j/WBU8Seyl3zbePy9zkiHDADBODIL7DvInUgN/W75L+ZQbYEI56BTOObkZi0gunCNn6f6zwdB/L/fQQiK+TUZJiyyJViqaNZ7NjE/JOVjoeMRXHFAc5Py12otd2Nen9aKMSnpWQPW32TGGhSrt08UvHPd6Q2csST36C7vOWsTOLN6FuWgZHUR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(82960400001)(956004)(36756003)(82950400001)(8676002)(66476007)(6666004)(921005)(26005)(83380400001)(66946007)(478600001)(186003)(6486002)(7696005)(16526019)(8936002)(316002)(2616005)(52116002)(4326008)(2906002)(5660300002)(10290500003)(7416002)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?APaqgu0zDhs4xRvEB71l9Gw3edy7xMxZck5J2OiGDn0l/jwRiYcb+Ig7NFDK?=
 =?us-ascii?Q?SRIS+5Lbxj7E9gMth6YgUbkq80YbD8XdGoAXUulaFhXq6yheEgx3ARHgFFPq?=
 =?us-ascii?Q?LakeAyznEvjysMdjaEIVT4k+evJpfXo7Xc79GTbGeak73Me2WhCICqyfQu27?=
 =?us-ascii?Q?mJHXRxrVtBMJXMQyPgxXk1UwU+n07iG5x3rYqY0YVlgls8x0933Up8mHV98u?=
 =?us-ascii?Q?I32+xqMTsID9eRvE5YF+Q1r7wNq9uk1DFsD4JOgVcaEZO1HkPKK3y5dzGAyb?=
 =?us-ascii?Q?Kim9xcA3Uqy2BsG52wubI6bVP+9LpI4dSaDTEfTp3Hh94DYtG/bAZSr9wP4Z?=
 =?us-ascii?Q?6dgFflW4klsbt1hZfgF0Qav0OHTWWAD+svuKUcaOyhfmA7gWI7xE1//23gIl?=
 =?us-ascii?Q?Y2OsS3a44oA0Peg2eWqQOKTNamc/FLgNuxHAfdLSMxuWarcGNHXxlm0D3swO?=
 =?us-ascii?Q?NW4IyNWyj6uwYLQXqz7XMyasnknDCwUaEq+x4TX9d+VSFHAXVuHApHk3EzHO?=
 =?us-ascii?Q?AnXM/HKwPH+scI918vo/XO8JrJSDSmaIe4dMwNNlSKmiUjQ1oaBusy3R2e6h?=
 =?us-ascii?Q?oul09z5FSnlsCWxr84DZ9s/kzeGLPxRbra7wLGz3w8Yld+Q3ZLTQHxVaQ2I0?=
 =?us-ascii?Q?Ka0U5AAISK9AaFmTFk9J3KdthpHgeiIkx70Fjh4ke/I5L0YrPHA8FnDXA2KN?=
 =?us-ascii?Q?l6mvGsLBsaepFSdXA1tI5wywrwteAXbjX/8Y/UjEGomxJja0mVjh2PDqqYo4?=
 =?us-ascii?Q?3WUbRDoTfdJNBDetzPHEMYbbhrJOY3QEH5GuLAqA3nv+Zl4bGQSXdVc3fb3B?=
 =?us-ascii?Q?TMynvmMkyuiukJdxX3HcEjthKqlkB53oiFEkr/jwBv6/yiTg5HNth3Q7A8AR?=
 =?us-ascii?Q?jioeHtfTgAC5IsCCfZr7V9R8TdBKYdNtk8tW+sQz6udc4Cd1ZNnxp4CCYR7D?=
 =?us-ascii?Q?Ld2PEu79X5ZuETcoYZ7ghy0u7hZHxIYO5ta+Zv3sgDz+mqXtyueB+MjPFOkZ?=
 =?us-ascii?Q?O4IaGiFFGq6njwKlZwUSgfsITr758fdqnttYoGZJZIF8RaEeaacXtvOKmFL2?=
 =?us-ascii?Q?sp2WWJw+1Kklz86KEMs7d7QPN2FtU+jzwLssycjxSPZc4pJEUsNZWbYtk/zo?=
 =?us-ascii?Q?7Zd5P6z1v7zrX9Mpn/r1rtXaUN0vkzBne2zhPnSVq1QPiaP0vNrGhJg8H6Jl?=
 =?us-ascii?Q?u8gRG50bLwI4NWl+lyDR4dv0L9feg8+wwCtvi7hY50POomsEfKMsjBQfr2ie?=
 =?us-ascii?Q?XR2DlHTf9a9CNS5Vzk0jZoybmldG1XjZfVyh5jucH/E1e0WhSG0plh94rDED?=
 =?us-ascii?Q?VlOeKVtNPhlASuLWPD2y9v2j?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d2dd93-5cc3-41b0-394e-08d8ddc38f65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:49.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKbtLXFat+65wSNdWmVTdMwy2S4CdllhWdVeJFBqSAWdmGBvBt884IvcFOzmNcNx9BuXp5z4JIA+1za57bCiXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1739
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Hyper-V page allocator functions are implemented in an architecture
neutral way.  Move them into the architecture neutral VMbus module so
a separate implementation for ARM64 is not needed.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/hyperv/hv_init.c       | 22 ----------------------
 arch/x86/include/asm/mshyperv.h |  5 -----
 drivers/hv/hv.c                 | 36 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  4 ++++
 4 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index b81047d..4bdb344 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -54,28 +54,6 @@
 u32 hv_max_vp_index;
 EXPORT_SYMBOL_GPL(hv_max_vp_index);
 
-void *hv_alloc_hyperv_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
-
-	return (void *)__get_free_page(GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
-
-void *hv_alloc_hyperv_zeroed_page(void)
-{
-        BUILD_BUG_ON(PAGE_SIZE != HV_HYP_PAGE_SIZE);
-
-        return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
-
-void hv_free_hyperv_page(unsigned long addr)
-{
-	free_page(addr);
-}
-EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
-
 static int hv_cpu_init(unsigned int cpu)
 {
 	u64 msr_vp_index;
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccf60a8..ef6e968 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -233,9 +233,6 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void *hv_alloc_hyperv_page(void);
-void *hv_alloc_hyperv_zeroed_page(void);
-void hv_free_hyperv_page(unsigned long addr);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
@@ -272,8 +269,6 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
-static inline void *hv_alloc_hyperv_page(void) { return NULL; }
-static inline void hv_free_hyperv_page(unsigned long addr) {}
 static inline void set_hv_tscchange_cb(void (*cb)(void)) {}
 static inline void clear_hv_tscchange_cb(void) {}
 static inline void hyperv_stop_tsc_emulation(void) {};
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index f202ac7..cca8d5e 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -37,6 +37,42 @@ int hv_init(void)
 }
 
 /*
+ * Functions for allocating and freeing memory with size and
+ * alignment HV_HYP_PAGE_SIZE. These functions are needed because
+ * the guest page size may not be the same as the Hyper-V page
+ * size. We depend upon kmalloc() aligning power-of-two size
+ * allocations to the allocation size boundary, so that the
+ * allocated memory appears to Hyper-V as a page of the size
+ * it expects.
+ */
+
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
+
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL);
+	else
+		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	else
+		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		free_page(addr);
+	else
+		kfree((void *)addr);
+}
+
+/*
  * hv_post_message - Post a message using the hypervisor message IPC.
  *
  * This involves a hypercall.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index dff58a3..694b5bc 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -117,6 +117,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
+void *hv_alloc_hyperv_page(void);
+void *hv_alloc_hyperv_zeroed_page(void);
+void hv_free_hyperv_page(unsigned long addr);
+
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
  * @cpu_number: CPU number in Linux terms
-- 
1.8.3.1

