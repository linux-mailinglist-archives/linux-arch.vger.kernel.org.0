Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E03781FC4
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjHTUdC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjHTUdC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:02 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABE410F2;
        Sun, 20 Aug 2023 13:27:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS+0/8GWsSJP51h8PKnd9dU7CbroyrU5QMUyaxMiq03B+ySUu1CGGze5w2yw2u+3JQly49HSE/ikVS8NdqneNKE49LEMr5Nj4qWMXvM1rUWIs2D2KBmQVD9upJpGvGIWvZhaHzcf9oJOQK+txsFuXswrEA6N1lW1UudBggf4yrJ4DfvhXTQ4akVytdLApPRJEsvoO4BqIwAfDQaPV87WUQkcH8QkJ1yCdkp7HOgwkdsGbDBHTBsZP+L2maW7Mh2xUYueI4QHj75mxcAu4f/rB8adUMPtNYnxWanbNRJTVC5Jn7g3wHC+BW0nujK1vBScXEdB9TpVk/nWQPmL1NE0iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwduPhA7Ih3xl+gl2VLQ8LTkrBX8M7OcrAksCLLVl1c=;
 b=e42fgnkqSapqnv4yFqypJX4Sp2OqU3AzwAhXqYwakHzxRre3IxXn3G3Nuk+JUzMfsfycMjesieNxhg2DnMfFk2fZBG/uzpZy3p6cT05+oI3cEjDRMVIVnRuXNK2y58+tci1Q+miZNPSJ0plcqlkK9EIJLlqXPBONXR0Ij1sTr0mcE7zymxNGN7qCH719jHlBpasGGwmoAUXTHe1bA3dD6JPhwVY8fVDdlJdzxFXWxDtH4Qyv8w8zYa5+gsnl4O+IvfhqXR11Qto8gtfgAHivlBAJvXW+ZtAWHnRJw0AQzvRTaeJD4oJI0kfAv+I7qEp6yYQpG/QYUYhyPvMW4xdIBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwduPhA7Ih3xl+gl2VLQ8LTkrBX8M7OcrAksCLLVl1c=;
 b=fx3zGb89s2nre/yc9yC89cmGp8mdoiWc4zl+CWR751baRhIkG0wvozzkZEUMeRiIQ67bGFiAFQKuWOU0Pbi9hIzyLVmMs3OoQTjvj2TZLvztIa6NL1QygCC6qmlwRBBs29o48V6ekg5Uw8IHF0+ae0dWEhTgLOA9hPU1biT3wNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:27:53 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:27:53 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 1/9] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Sun, 20 Aug 2023 13:27:07 -0700
Message-Id: <20230820202715.29006-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230820202715.29006-1-decui@microsoft.com>
References: <20230820202715.29006-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW4PR21MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fe745a9-2f9e-4d73-8273-08dba1bbedf7
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBGzF9jm3Uf9g1oGbtdH/5d4KZLx+jLP5wsHhGPsol15CSDdhUl+3d0Ui7KErm7kHS4BupwT/gOZEG1CnFe/vim/cL7ftN9UgEszQ6g9CFDZVV+Awa8InP/S2PJUDtn+R86PfI+vp85a5StfRgZSnvGDlSukLFV+d5Z48GavW2JEX3y3uKVTbucXQeQ/tnZDsAI/CEBeEjVzD5QzOur3SJup1b000xAsTfRz8TBYuYpvKi3kGA5AIBku9UAWn004iEg7E8Xt6i/c6sI7V+Cx/YzzwUZKiGjM5aWzlDW+Y8kvQGX9DqTE1c8qTmiHKnK/vOnRyxol3YeNRQL+BkzAVzTvFT4fwnlxxd2BrQh/oXiUZQtOUIE5aA7BynT2KkUa2eum5nfhG1qo5lmAYqXd2w3QLakfy3shW6OyI71EvGT284o1rMBRq8UCZC2ctp/gCb3CoMZVc7WTcHnCnLwa+LtWrFPsemHxecnVSdjxnxyXbosV5+HzH6HaSsxXdgo3TjRrTYT+sg7cGaLiKgUihAjVViHmj5nDAKjFs/pQ1Y0No5upmXvocPWiabbmlm3Ve7arzob3ns3SHL/aHUtXixQ4fluUY6+aQjXH1RzwqJdJq1iCArTb0R5p3WVLaC/o/Pz0wpnMmDbr6pJgcL3ggzYSOIgRqPy85v/Jpf9U/dfy1kmBac1YsXwkJPHcc5lC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f+NLYmTg4SIK00GPToTNcNaQcqDPFhrA8qNODnzE1WBnMGjZZGHdTqdYjFL8?=
 =?us-ascii?Q?UvQnwm54vL5zyNuC5xurcWHe6lrft8vH5phsFVY/C++eXHvRG707tpafwV7Y?=
 =?us-ascii?Q?8CJ7tCok13Pnkq3VOItDauA0fF1UH0RCDUks5KuAOFLf3alSKXeKEXV+9MWe?=
 =?us-ascii?Q?Rqc7WVH4wsA5i8YA8vbUwNqvyWPNt6Q/m8WT+vDRawZJl4yatR9c9DCTIRVa?=
 =?us-ascii?Q?3kNfXvTjynfyH8ozgxxdlqhfVgT1wJUM3D9Yz+7HPBtkbmI19UAToIVCOx2u?=
 =?us-ascii?Q?YHxUAikHMHmyQlWf2QHxclTI3D98jTdnJHckb2JsUFp5zBaLij+MgI15B8uv?=
 =?us-ascii?Q?W/YXFUIUO6aWhKSUwUjTIr+P/5bzrsPqOJqhs4onb79pu4rrS50HDaaa6jvp?=
 =?us-ascii?Q?wcTCutoiKhDvRNddHnuWLDyrvNyR0e1cyCDeqqgxOAZZeRCUjr+xr8sE3yMh?=
 =?us-ascii?Q?4e7c7IrSMRQJjqbiobpPzF23bhUKECLk1pHWBjGq2Fvw9onKkJCBaJE78joC?=
 =?us-ascii?Q?6ME6LHTWCY2NWM65sx1Yw2SmrNGGD6+YyJJG1ym/1FPxy/PK5Y75ooR70Moq?=
 =?us-ascii?Q?nc9zojsKJyoDf1Xlihv4mEaLL6RufTPLySTzlZVh42IXvXjmNSsugJ0dWREy?=
 =?us-ascii?Q?yK7Xb/XjIAxrA1/zY9n5uE/hZYfZkqmVZAHH13Z5k1nYmU4YbEpVUDm2Pz5w?=
 =?us-ascii?Q?s+whWUkATsJrYSuztoxGFKUWXb0uU+xHdXd8VP1MQ8Zts1RN8LqNCmqEUYFq?=
 =?us-ascii?Q?xlIoIJELoSqbXZh8veZNzGMK8cWtDS4so/wGvr2ICz+D07jPktiDXMM7r8Z+?=
 =?us-ascii?Q?hd6U2XAcTD6ZpuNr9ESc3veestrg//i9kfAUSaqtis9hHpaOSdVgdbzRgfyn?=
 =?us-ascii?Q?OSpi+zM7e84GT8uq3ygN+tMXQzVKo6iIhbhnW/CmZYNoBfS0wrlqirn4UpKv?=
 =?us-ascii?Q?H3ZkTQPcfjC2tC7EaFnFbqdRy4evwKm+uOXdNLpkfF7pH+xXZvS7OX7Tg6WL?=
 =?us-ascii?Q?uvjQGfKlMzMF7HlT8lKr1OlrR6KsSRBZ3cVhKoHqtdbkgmexvn8esP7LtbeI?=
 =?us-ascii?Q?4PssgVNA0LpPChpzuPfOK1sc6Gr7v3nmd89804bMemUeR1kb4F9kCHfG0sXR?=
 =?us-ascii?Q?S0cDJnQbSnrz9V1/YQJBDckhMUkZQJ7MBvDcF3yEc/UPAZ5Pko1aDJ8wik9S?=
 =?us-ascii?Q?dPiwpjBjKewDxqfijwtTplXT5Txy1gxldBU73QYGP+32MHj6OLHmEa782qd2?=
 =?us-ascii?Q?ujLOekN4J2EXXKI9eObmyMAMbU4TePFANKbNakbYMFoanih40E0I7zlEOuaE?=
 =?us-ascii?Q?wRUtRfUy2bvq0GMihxbw385n48thgS4z7gA8ITuzl3AGwT3UHm3xSZzyw7w2?=
 =?us-ascii?Q?xogl5YOVjCK1NBhpeA463k4UqP4kWutC63W8zSHoTK7L1TpVAQVAgOJaijyV?=
 =?us-ascii?Q?Nhy5YQz8/aOuQQw6ASU1tCbQdxfJQaiFJGPUfPSQvmktEKuyLYxsOKrWrQjV?=
 =?us-ascii?Q?luSUwaiaJ3dqc1pwMcvJDmFSYwBFylq4SUbmrk1GhTR4yiNmABf+6f/FbROp?=
 =?us-ascii?Q?1wFLZqbWCz+Yb5Z1NbKXMcnNtEPIe62qLSAH/q3y6wUqSQixyhBc0xUzCBxb?=
 =?us-ascii?Q?9pbElnBQp2iFre0EGKi4O9E2QVpLkiTvC5b4vE3L1ArP?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe745a9-2f9e-4d73-8273-08dba1bbedf7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:27:52.9522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UvutWVoQiI5TKt35lp1vhVZzUbrCnOf6bjTBolfuv1YdthXhTqiSIQT+i16pgJxPPZDWWy5HAof0Z37Nz9zijg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No logic change to SNP/VBS guests.

hv_isolation_type_tdx() will be used to instruct a TDX guest on Hyper-V to
do some TDX-specific operations, e.g. for a fully enlightened TDX guest
(i.e. without the paravisor), hv_do_hypercall() should use
__tdx_hypercall() and such a guest on Hyper-V should handle the Hyper-V
Event/Message/Monitor pages specially.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Added Tianyu's Reviewed-by.

 arch/x86/hyperv/ivm.c              | 9 +++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 ++
 drivers/hv/hv_common.c             | 6 ++++++
 include/asm-generic/mshyperv.h     | 1 +
 6 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cbbd3af4c3daf..afdae1a8a1177 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -562,3 +562,12 @@ bool hv_isolation_type_en_snp(void)
 	return static_branch_unlikely(&isolation_type_en_snp);
 }
 
+DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
+/*
+ * hv_isolation_type_tdx - Check if the system runs in an Intel TDX based
+ * isolated VM.
+ */
+bool hv_isolation_type_tdx(void)
+{
+	return static_branch_unlikely(&isolation_type_tdx);
+}
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 4bf0b315b0ce9..2ff26f53cd624 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -169,7 +169,8 @@
 enum hv_isolation_type {
 	HV_ISOLATION_TYPE_NONE	= 0,
 	HV_ISOLATION_TYPE_VBS	= 1,
-	HV_ISOLATION_TYPE_SNP	= 2
+	HV_ISOLATION_TYPE_SNP	= 2,
+	HV_ISOLATION_TYPE_TDX	= 3
 };
 
 /* Hyper-V specific model specific registers (MSRs) */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6bd9ae04d9c36..e18c6c8f4fba8 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,6 +27,7 @@ union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
 DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_tdx(void);
+
 /*
  * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
  * to start AP in enlightened SEV guest.
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 26b9fcabd7d95..e0640fe6f6b82 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -417,6 +417,8 @@ static void __init ms_hyperv_init_platform(void)
 			static_branch_enable(&isolation_type_en_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
+			static_branch_enable(&isolation_type_tdx);
 		}
 	}
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2d43ba2bc925d..da3307533f4d7 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -521,6 +521,12 @@ bool __weak hv_isolation_type_en_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
 
+bool __weak hv_isolation_type_tdx(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index efd0d2aedad39..82eba2d5fc4cd 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -66,6 +66,7 @@ extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
 extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_tdx(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

