Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2DD6DBD0B
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjDHUtr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjDHUti (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:38 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12927D90;
        Sat,  8 Apr 2023 13:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3mQE2aF+PbGxy0zV9A+azbIfh9OMQyE8oxVUqjn2NgIfwGU80o2cmWuXud9spuD1IE1QuMH54Td916b7lMMkfb5sKzSs8Z9bPGbIh+iT+azV5nOgLZoOUZuG9gHKZSgrSosYhe9wdXaH2g6MtzyrFQy4bFxqJj4hn/G3TM4MvkfUhK+Ekv3ec4dHVV80ZrVZ/gyLJIplqsLlBPINw26mcrCTJaVEAVcGF+L8eZJWcps7TMJGW8tgtIfyaCC0af7n/Exv9zQcbrs59/Uh+Me588oC4gTbCFMFNnlQqwGtQdTNUw+V3b6zvaEHNXvWXVavYXz5eT3LVXUHPi39KdRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c271glfaaF8I7MsJtTo/QKuY8jQ6CriOvGxRWW1KDjc=;
 b=ApD1VTTDBn5NHcjiyhkseAIiMMmc5NR63s7rUhkomRJiwR3sJ+KJjCWt1uCNbx+wJbEHCBBZdnrePkoMvaekgntaFVbejp7gpuigvY9ExyuBCwf4bb+0NjKVRn7K3vjmWI7P6wTAZ22AVnkHRkSFugDdbSYcRD4YAkcUk0W91LRNY+YrJ2YN1M7LdJ30nE0ODPrb6qb1n62CgBPx7Rcy1ZBK8RIu00RaIx0BK+G+/17j2YAZMEC52KePSAbwIlAe718AG48cKxl+gwlVq4kLLoJKVSGkrVBIMbN9EAUSOIq1LSmkQKJ/245y89jBCzHC60E3uKPYQw3CBzgwKx6Naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c271glfaaF8I7MsJtTo/QKuY8jQ6CriOvGxRWW1KDjc=;
 b=BUTNqOItREJxytovrhusF5Mpu7LQyXat1C3arkIU0y8SsOk8aYmaeOy2llhyE2eW1t1gPwJdzmPSOuT26CGsKIHSFzP+CzcmkegYzJ9H+dHD64ReUFQ+5t3ruk5HR6xlduDoWPSUc0TRRiZwoOE434XLaMp/5NUfD5ULBQghZwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:34 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:33 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, haiyangz@microsoft.com, hpa@zytor.com,
        jane.chu@oracle.com, kirill.shutemov@linux.intel.com,
        kys@microsoft.com, linux-arch@vger.kernel.org,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v4 4/6] x86/hyperv: Support hypercalls for TDX guests
Date:   Sat,  8 Apr 2023 13:47:57 -0700
Message-Id: <20230408204759.14902-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230408204759.14902-1-decui@microsoft.com>
References: <20230408204759.14902-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BYAPR21MB1336:EE_
X-MS-Office365-Filtering-Correlation-Id: b1d3d362-d7f5-4ba1-c91b-08db3872c216
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /xK7gVx0LQXpM4dR3Q4V6QZpvskw0xliEjGIvNmlIRc5JfvasDgBFVYNMQTuwao5mNH6dBikAPOTh0sz+EjkgWV1O6g6UwjF6qBwd+n2Dk1xvetFHH8kMySLEQHKltSPBd32OX5iUIPxkgo/49MrnQMDjD0s6DoOqzXCItyqBI4mtweZ5kBnYAxS9T3tLF/Ghky4uP5jrhM5R0gZ58BxrmBOCECXJYMQ5mGhnEJdcI9zg+FXaEwF/SGg+nMNvNhukO9WSSsHRJcJT8YAkXOSNPf0FfI9tyh/BXYBS6Nq4tf0gGHYFgzjF8NSoZrQ7+V7xXF0eKnDFwjQr52j7LecMEU7L5Rc9DvWqGah/1E/eo0ycsL/jQvEOi4yjLsqjUfHYNoVcOvbQnEdC+ZijN+3KLvNvz8MC/2431G/GwbNjvxaCrP8ibH0pR+6xEluKQAxq2K16iq7ZiRCzqtEHTwY4MnESkE21ROkdLfCr/lNn2l9KRYyohDU4F9XGtYgJ9CouXlq/PuonQi7+eU0sntwOAVekOIzUo6fP2ORMEXAWw6fRP29yzXQA7roUpHn/v1I6Z/HZnaaMh+OKu/ZQ6UuxWgnLyrjAZYcdcrON9Uph5hPFTTMdRO5Qfp75kJiz2H8n+d4elhTXo4xy9wgvPP9zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMjlY7atL6/8ArMuBSHBQfdgh8Ng9elKFGH+CjbONFC0MCWANM4WFAVrdon3?=
 =?us-ascii?Q?nzE1NE1Q6LI13S3Edzk0etYRdNEMX0GOzSvN5TEMQCunLeQZEpHd7uMN/sqU?=
 =?us-ascii?Q?zWiUQu8oTFM2ClQl4SjxQLAHx69HjCNHI38FEVQ1asqDt5JamH18/BMrrXUj?=
 =?us-ascii?Q?nR9OI14PGLlHLWg5l8wTsZttpX96dYpI8c/qsy6Xn1oBqW9OZTmuj4lFY+Gl?=
 =?us-ascii?Q?WZRnwgUHKocp38fb8gzWTZjIs6zYHHWMFkLC3DMvfQMD6KfEuxPqK1Q1IVKP?=
 =?us-ascii?Q?SVZTFAbQPO/CmMdQj6zX7KfwCFvCstMimxmxpu/86wXWG2Gl3MEO4vtHV4hi?=
 =?us-ascii?Q?KczV2dJ6OjFTmpRsY6t8CfKEGm2YU6Y1ZGdZDlx3USfp3TyUWhSN+vYDJlKm?=
 =?us-ascii?Q?lWaQ/kYwhEj95JeS3CaTjU416A1gDgZYalUfeYZCubihLi5VGwzarHg4nehe?=
 =?us-ascii?Q?OILLVolWKb9PHkBFqzqY5R4JymiqQtn+YFw+uOX92i9WcroM2Yb6TB20nXHu?=
 =?us-ascii?Q?Fbl3WrWgsyK7x2CgCOxeyedSJbn+zGqmj8axOLWEQFm9gSIC13hk1ubxh5mk?=
 =?us-ascii?Q?dM/SJ/mszHb4qcp2fmxhOluUst9pQFoq1CPR43E5pUyO1dM7UWE/1zBdaIdE?=
 =?us-ascii?Q?rC2hXLiZSae5KP8WCzh7Y20bMTVb8wQR28g/VTh77tUlylvWYK1TanJQzxsh?=
 =?us-ascii?Q?G13QQDv7z0/noo3Be6lxwbdwSnu11qniCVKA6kgcqW0rEoM/W5Ed+VDhklxg?=
 =?us-ascii?Q?dLuymQya67m+C7T3iq9Cpyzk598eMgqQcJ9ZUlHz5ozAFrd9WeFjlgK5M+OP?=
 =?us-ascii?Q?+d/y5WC98CABn5Q+KYjelo+WXtJWG8WAmI7BbeGCQQ2FeyQLysjrMFBPzsCA?=
 =?us-ascii?Q?5uphcPyQd4zVAGqb+AouzwNDewbwKq9CAKsDDYZzBUhlHOvaQxqKHMVOn5Qc?=
 =?us-ascii?Q?jPI8iZ7TXEiuZfsa3leg9seEdOEerFBuMDhctfoht6AQB1LqxOaL7O6+THwe?=
 =?us-ascii?Q?IA8KUTwqmrV079nKJikStFR75eaQwqf4DdZJrHMwTXiDfOif7ffHOW1vVWuk?=
 =?us-ascii?Q?412kkJDEByyajARs6DQSM8O2+yTK8NfkxXyc6ZBWZpgBMMAPgDrP/D8dVw2n?=
 =?us-ascii?Q?FQKAlsSAkbxC3uto+HWjtNfzZfYRhAEoY2TS45/79VEcViQYF0bT6hDZAubL?=
 =?us-ascii?Q?zjtz/XCM3iinMnh2rOG0sMwmxROIJQ89HhNIgjz/1BZh35MH+WbA/iFjmwbY?=
 =?us-ascii?Q?Un1OUCqXkYNYwQ4teniidcXVVgZOz1o47CXRVxTMIWt6DMeaeXCUAKi7iVpN?=
 =?us-ascii?Q?UC64dOKp4eajqTL8bEuBzhG2MzHMGwKAQj4jkhG76rJHEB9EpRTzf19jBl6T?=
 =?us-ascii?Q?zyMqCE9BjJFqXdME1J7yAIl+CAYdPnWGpLTtNzGoHgOHSjbOtxWNQRSCMRTn?=
 =?us-ascii?Q?CQOx/6EmALAFyxqIyWvHmlMMgKjGyBCrqTbHeojtc9RUqOcaEyEFVwaOIoZN?=
 =?us-ascii?Q?ZPI4Z8oblW5erE7Hae9l+hDd0TjKfEsdqZdB36UH78uWzkOHF2gGe77EyzoF?=
 =?us-ascii?Q?IqiJnHDrri7UAfJ/MncVYled3Ujg7v6GKmXwRuw7twB2K0MAWcO5yAKLYeia?=
 =?us-ascii?Q?pa3JBsRHpR2xhteftdL1Ey3PZ463Hx41V4esJTFbtD6c?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1d3d362-d7f5-4ba1-c91b-08db3872c216
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:33.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMGdfJ2WGYKguby92c4pheFC6wK0qR9I/6BfZEAEDi7Tzyah8W4ZBDHEKGmQTF3ATY8MCv3KgxyX0hsI0Kxk1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1336
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A TDX guest uses the GHCI call rather than hv_hypercall_pg.

In hv_do_hypercall(), Hyper-V requires that the input/output addresses
must have the cc_mask.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
Changes in v2:
  Implemented hv_tdx_hypercall() in C rather than in assembly code.
  Renamed the parameter names of hv_tdx_hypercall().
  Used cc_mkdec() directly in hv_do_hypercall().

Changes in v3:
  Decrypted/encrypted hyperv_pcpu_input_arg in
    hv_common_cpu_init() and hv_common_cpu_die().

Changes in v4:
  __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT) -> __tdx_hypercall_ret()
  hv_common_cpu_die(): explicitly ignore the error set_memory_encrypted() [Michael Kelley]
  Added Sathyanarayanan's Reviewed-by.

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
 drivers/hv/hv_common.c          | 24 ++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  1 +
 5 files changed, 64 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a5f9474f08e12..f175e0de821c3 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -432,6 +432,10 @@ void __init hyperv_init(void)
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		goto skip_hypercall_pg_init;
+
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
@@ -471,6 +475,7 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
+skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
@@ -594,6 +599,9 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
 	 * that the hypercall page is setup
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 3658ade4f4121..23304c9ddd34f 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -415,3 +415,17 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
+
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
+{
+	struct tdx_hypercall_args args = { };
+
+	args.r10 = control;
+	args.rdx = param1;
+	args.r8  = param2;
+
+	(void)__tdx_hypercall_ret(&args);
+
+	return args.r11;
+}
+EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index de7ceae9e65e9..71077326f57bc 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -10,6 +10,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
+#include <asm/coco.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
@@ -45,6 +46,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
+
+/*
+ * If the hypercall involves no input or output parameters, the hypervisor
+ * ignores the corresponding GPA pointer.
+ */
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
@@ -52,6 +59,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control,
+					cc_mkdec(input_address),
+					cc_mkdec(output_address));
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -95,6 +106,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	{
 		__asm__ __volatile__(CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -140,6 +154,9 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	{
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c55db7ea6580b..10e85682e83eb 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
+#include <linux/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -128,6 +129,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -137,6 +139,17 @@ int hv_common_cpu_init(unsigned int cpu)
 	if (!(*inputarg))
 		return -ENOMEM;
 
+	if (hv_isolation_type_tdx()) {
+		ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
+		if (ret) {
+			/* It may be unsafe to free *inputarg */
+			*inputarg = NULL;
+			return ret;
+		}
+
+		memset(*inputarg, 0x00, pgcount * HV_HYP_PAGE_SIZE);
+	}
+
 	if (hv_root_partition) {
 		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
@@ -157,6 +170,8 @@ int hv_common_cpu_die(unsigned int cpu)
 	unsigned long flags;
 	void **inputarg, **outputarg;
 	void *mem;
+	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	local_irq_save(flags);
 
@@ -171,6 +186,15 @@ int hv_common_cpu_die(unsigned int cpu)
 
 	local_irq_restore(flags);
 
+	if (hv_isolation_type_tdx()) {
+		ret = set_memory_encrypted((unsigned long)mem, pgcount);
+		if (ret)
+			pr_warn("Hyper-V: Failed to encrypt input arg on cpu%d: %d\n",
+				cpu, ret);
+		/* It's unsafe to free 'mem'. */
+		return 0;
+	}
+
 	kfree(mem);
 
 	return 0;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index afcd9ae9588cb..83e56ebe0cb7f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -58,6 +58,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_tdx(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

