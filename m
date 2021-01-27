Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE2030650C
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhA0UZ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:25:29 -0500
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:44481
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231968AbhA0UZP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:25:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDtaeMy16gcPIbZkWNTJ/KlRsMVPrG+/7rbT1K/7REUYD7T2ytRBDd/8tHB7raCl+z6agG/Bp0ud9O0ZsO17Ie0Q6ZosEtaoGUONhXVPZxiWEINhJm+afsoul1mlxvWatraNF1dgkNUaUGpkJD44y9cmQdUwb/whVh94jF4GKshqqfxjKDwY82jDM7bxos+2EGCj9/Xsw8G+22eEU8ld2Vdp3x9VhRjl3DExIFrlSolnNsxKVKnPAmcDeU3yIcPhTsDVOozMVi791UYoik52mEslSRcV7cETmFqjYWaGrK1tcTRMR+cGe6BMv96TfzuesRyPiYsgphPTOB/lpTYlgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHceeEvTKmw5/BUZNhNj/pPtOMiiEHak1LnYWBAsrrY=;
 b=hIxlCdABoil5lwrIuuWqH+SdmfiFVNqg2td+DlAI5XUACgu7btGt363j7+KX+VyL5YdShemrU7B4TTgfYrtOJTjfqqgQJ627E/Yk4wzQ2BTsKxSLFQr5KsdtUlVGDsSnbgg0vNtuwoQV7Ax9ZLM3LAWfAxPgmZX00K0Q3CKWtQJNriQgB7qsKNvLfBRXULe3YtgEE/rrWjWYwRrktEq77dt30CtURs+Q5JvV8U5H6cect8A0kP/wybivvfFyY5PoOieSO5GxqiRzrmAKAK16of2HGty1ZS8DeFxgf0smai6Kv6la2SndfeteFxP8XdctHSwHl54rqzG8AtQt4NcTeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHceeEvTKmw5/BUZNhNj/pPtOMiiEHak1LnYWBAsrrY=;
 b=HcF+byc8YrOOQw7O9A3HgkurTFCTL3Lb2e2wORH5xbTPXs6mJNXV4X+PhL4v1/y8PUj7L9pNdOTeai5qRHIew8BpASwvSunL01KFe1rSRjcmzdBDV9Og+dVLSb+OCf+nV/WytcK7ZAYVE8J8k4Zq0jXTxEr+pbaJ5LxCbtrDyXU=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:18 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 01/10] Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code
Date:   Wed, 27 Jan 2021 12:23:36 -0800
Message-Id: <1611779025-21503-2-git-send-email-mikelley@microsoft.com>
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
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 77b8f8eb-8a5c-40ce-e5bc-08d8c30185b7
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB1215621A2DCC5D907DFAAA40D7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfz83W8jrFKMoGDu6/mD4Q65tJuj4At5qc6yYY12LxEarnAk/ot436Vj6hC9Mv1PqMfxMzHKtsbMxrWg3FnBGz37U/98/z8cBdysTChNbRqF+3gcOs6Db4xu26pgms7zq7q88F3mBWZoXNCutNCbgsO1AZKog4hc+yg1ZW+fxBRmivZPjVnthGvFtkae6iD/j/aqAsa0GeUpdlax8fFa/94O/BHmAbox5i2HoAMPv7bXtN4JOISSggLJoJaQ9VGCPV1w7Fg1Nl53sDXqBpspD2UMSYASNscsAdn3j6881u5Da0uFocYhToP/mXP6r0Znkqg0onB1wZnyJv8pAs7uHZWGbKNSuUNCSZcDNQnLPQH6Lm34vsP9v7PrHHj+Jn7M6xKvuhz/sl5/hmTIgs+WuQE4dAHg9Tj6y5yDA1n5AIwFc6sm1fXgqK6YARQcL2pG/Ur0uu0OJlm7etxCc/vjeAjATowhRLvXXDX4HJPADsALVwkxsM3HtWKMoXiz29u5w3VM3mfg8z1L97ZV+smD4g7vz53VD9An9OZNulWINthUd/4jGlJhHPDo4nAFABMp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HFM11gvpVa2/abdkXN1wJXka4XDS1Ono4H/Tzvnlyk7OKr3OLDwTb5hg6+AD?=
 =?us-ascii?Q?s2l/M5+YcpJyp88YGy8VnHSWKn/jSbyAh2+hXptoaI3f1y2bjVGoHgIdQmcr?=
 =?us-ascii?Q?I3WAwAoA7WJNvpkpsuu7IY3P9L78A3XIsUR+SUje29yR38v2Tulh9KOR2O/L?=
 =?us-ascii?Q?YaYmxDn34jMcuVmif+uFddRV73guT/GmsXc+yDP0hlcQ8qsWy2lHCcTnpTt0?=
 =?us-ascii?Q?XcbNZq3MqWcAiliMddsnmrpoRezXaIIQhCxFzohiZkX/mzBcyvqrkSRDO5Ud?=
 =?us-ascii?Q?ShPQUU+7T1Cbx99+567xVDn0Sl4bSRB8ZG8DGTSQvbiiOhJ7MQ6fv9suRrNl?=
 =?us-ascii?Q?WBpiY9tSBvhxTcNT7YOkG71HXKKyqjKjLCo1KuBTuX/oEomdR7WN4jwgCD+4?=
 =?us-ascii?Q?ob4etl1knqD/GAOnJJqDH4lh7J997fDwfelxCFDPqNOjKfeyY3/MYfWBYYT5?=
 =?us-ascii?Q?tmRjl6+ZJFh6B9nR54urBjdftMlf7LP0TjaKDOJFHegP4vgxNB+kySuQTuTy?=
 =?us-ascii?Q?wFBqpK/2bo3tvYwORwqtNrQxv6TpB2Lr11sNV1wHfLamQsNrWfels5LzZDM5?=
 =?us-ascii?Q?hztU4ZIREkOC8yRbHV/gCUCTgbMvwqFEFfyTj+hdnicQM7jIG4JJcsSZC3L/?=
 =?us-ascii?Q?du7/nhamYgZqw4OvxMItizoCN4QT24QzxrR0sZh2WQs0hmPXZeAJKZLqsbjh?=
 =?us-ascii?Q?gm2CEEiyeWuwuFcsVYTvfdotXjVVYUy0pDkG9Mcby1aqmC8N1615FWvqbQaN?=
 =?us-ascii?Q?CrNrkDgcM1POL0OXl35Erf6HXPHXRb5RNyNNVomytxhNFyrMrucJ/z0VvqrL?=
 =?us-ascii?Q?yGF5LJVRpWH8q3vELGSxVFjfw48Xfs9+yA3WWJvK0HlTI8HckDp5Op77w53d?=
 =?us-ascii?Q?E9flcNJR9Z2vnCD4jGIq+JGCaOVI95ApUcLxTsKw6R+loK78unG/YO97mMow?=
 =?us-ascii?Q?G9LTPbwrM1GF7EmTq/bFoQKwJdh6M7URh6/XS00cDaO9ddtuUL3SCYXq2aA9?=
 =?us-ascii?Q?Ik+HVpUjoWsn1W+BnL58+TXawPX/4f+5ZRejkZpJCuHRPYWPlMM7UnPHYOGS?=
 =?us-ascii?Q?x4AHEjtz?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77b8f8eb-8a5c-40ce-e5bc-08d8c30185b7
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:18.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBIvrP5v2mITONoCrnIphTh/nJW8N+PtCXVuW3IIjtlZinbuDGpJaVA/RyUlh5PllDSnDyANgHt85uYyX1rgwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The Hyper-V page allocator functions are implemented in an architecture
neutral way.  Move them into the architecture neutral VMbus module so
a separate implementation for ARM64 is not needed.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       | 22 ----------------------
 arch/x86/include/asm/mshyperv.h |  5 -----
 drivers/hv/hv.c                 | 36 ++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  4 ++++
 4 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index e04d90a..2d1688e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -44,28 +44,6 @@
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
index ffc2899..29d0414 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -224,9 +224,6 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void *hv_alloc_hyperv_page(void);
-void *hv_alloc_hyperv_zeroed_page(void);
-void hv_free_hyperv_page(unsigned long addr);
 void set_hv_tscchange_cb(void (*cb)(void));
 void clear_hv_tscchange_cb(void);
 void hyperv_stop_tsc_emulation(void);
@@ -255,8 +252,6 @@ static inline void hv_set_msi_entry_from_desc(union hv_msi_entry *msi_entry,
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
index c577996..762d3ac 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -114,6 +114,10 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
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

