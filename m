Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077876EB6CF
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjDVCT5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjDVCTk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:19:40 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021017.outbound.protection.outlook.com [52.101.62.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF75273A;
        Fri, 21 Apr 2023 19:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hxn4HZncE84mN4Vqy1NhOoTbEbQcZsnXMEK9sC2NGhQa1iV9/C0erjqmHRe2RSJU/WkQ27hIBVNfdjL+APttZ3//isjQZyIbCkZURzCGqdPXHWAPkB6MYfBjaN8mCoZGSI/oRqmn+z85BwgpfxAHQx8Pt+ke5N7j2/ADmFe8AFXNgujwtLtov1klE/O6LnsZ6KNfBlwce+DQvw9P00R2RsjgSjOAxHXfyOheX19A0Hn66uNq9c48TGW3kb6wLVp55e/OOqL3Suc59BQRY1JlARZGxA9Z0ZO7A0mrxzFcTobgtj7wb8Aa/K0NlI+Qxy4wEIobjJuPzJo9JQtN8NUPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THRGJuuH1SKLqlYToOEMCASmgDqLPN0zK7bQWcKleIc=;
 b=K0CKDi1SlDkMvtht1G7md9TmS1/Y3Yv74yg0vjA0qnCANChpD0+dFHVMnTz/YlcwocPmM3NUTF/ymVSIqduCBv+WRBgP7zN9TaV51sZbDumP8cIw0YmnsHOr3IwmdXkz7aV7XznPcO455Olg6zlYjGqzxd0ek3+MiUCxKSmXykqZp6/ARwmHGHz+z5RsGyPNvco7ULWGZ2DNOBZTqAkuG38xmvcuPc1Ln7eijU79MD5C1rx6nDJHpiheorSZlvEtav0WtFHALnl/7P++fh69J2MiUsuJfkzCbIfV6trFaZyJPJe0jiMPo1Ijhzb6c/vONSeHH6ZY1nAuuQMuSDVmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THRGJuuH1SKLqlYToOEMCASmgDqLPN0zK7bQWcKleIc=;
 b=cuyOP+EW6AYsr8+onha+voanR9OrQLgUV06bWt+/6UeDvOoQbC2t7RHgmxM6m/HPqXhjCgXR2+yVS4+UeIl95+f2+xi/NUwRgyYk8qS8aFWy2bOweAvmIZcfu7Xm3Nb0NTkDf8jlCCFu0I+E7wN45cRQe3PQmU/MkRWC5PzOPiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:35 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:35 +0000
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
Subject: [PATCH v5 4/6] x86/hyperv: Support hypercalls for TDX guests
Date:   Fri, 21 Apr 2023 19:17:33 -0700
Message-Id: <20230422021735.27698-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422021735.27698-1-decui@microsoft.com>
References: <20230422021735.27698-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:930:8::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM6PR21MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: de9b5a75-f46a-42c4-4069-08db42d8043f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB7Z95NxlZHyJE8JrSAAzwASEwL/wlc5QJJLcDA3DpCdYad+H5llY9wgUogDF/ZU5wtIUvveRWjuI/nNHS/L9ifBjf+HzCd8W0t+OGfo2v459urkBSXA5r1kdTXHkwiag6v0aXVE/P+cpI2rxSsAGvStZ7OwhwWyT2jVqtW5oZSOz5flXzCMVzo/F1CIqK6NKrATBj9uR/FsEcMs64+s9GimvDZt6u+Vg539dIq/PzBcoscLWrvDCtqpkUW4WOG9I6CsI7emGF6oBbSGs2DlO9iSqx9+tBDwQS0yH98AEfjO5LsMjia3YkRZRLBXvXyoEkjK3FeHF7KSciskCcHL0KxQZ0FGOvsb5T1ZYjOZRq8HQ9Xm0N3kdIi6jqpP317DlzXSRRX7IkYWM5JItSs5WbfY62ES31Auw7B52WMh7kHZZ1PZ/oA7dH8NlHR10bIHZecubHfHktjHX367ZSrvITr/hSSxug4enuNC5pSE9czTnO3rwdS/Ed5KOZw6TRMqt2MdhCWQdsauXESEVO2DIPP4rR+25Xtc1WAfQ9YPSEXpiOBP9vAH80tzSBd9MeanONBWUnrEUoHuRR6wFee0azP8j6e2DOm9ULz8QklPTWK7Tg0o9FuRIRsNiJMarzo8/ayqlotaq8WCsXjCsmOfEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(8676002)(8936002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(82960400001)(921005)(82950400001)(66556008)(316002)(786003)(6636002)(2906002)(5660300002)(10290500003)(7416002)(186003)(107886003)(86362001)(1076003)(6512007)(6506007)(36756003)(83380400001)(2616005)(52116002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hG4odNWdZFrqWEcp3FGlWIA84+zUpTJ8eKCOWhaVKUFgkjPyfWaqpvaGacjU?=
 =?us-ascii?Q?gVWbfvXc19Y76pqeAasTPrPh5BWqqdLyWrjH5A0j2NhGiAXa32Ma7s2g93Rb?=
 =?us-ascii?Q?8+Xymn/vXsJkY+l0xTzr/1i/r1jZRz3ITfpJWtXdVEMko8hm9qkxAENNTfrn?=
 =?us-ascii?Q?cctjw2YrgLXeZlWfAS/NOOrZV1UY0h956YSqKKhXTSubVILa0mETUNOdoTIU?=
 =?us-ascii?Q?AIW7pNcGZyiZ+xxu1FN2hrBK40J36lpkjyH4DGXmXZVPcfpkHElfRP5S7Uk2?=
 =?us-ascii?Q?Ac6mPlX93/Bfi1KTQQtb7V6aof3RwM61yo5oV2wXg8Rf41tGEr94dnPIQEJZ?=
 =?us-ascii?Q?LsSuJSv5PXaIESUc8qlur0e0D/Af8NTNv05umuAe3eXzoWNKTzrbCbIPIlEm?=
 =?us-ascii?Q?ysS9zJHL0ra2Dyt7p7SoIpridz4qtn8ZsDD9B3eEDcLL2viUOhnOocsxlTWx?=
 =?us-ascii?Q?KWdjtJEfO/WBolW7hsNBnvrUpJNf/62f5z4EQkvoAJgMOELXgty9o4olX5mK?=
 =?us-ascii?Q?qO6b37j2lVDXvoArCQJXfr0wU2yyDSG9MdnRqLILgvb3t6iSn0aIf92U/xB6?=
 =?us-ascii?Q?DoNAjd5zKV7A1ePqN1Hdk3BVNPvr/eKvtcNC7NW0JBLNj5M6AMhoT0Ij4O92?=
 =?us-ascii?Q?WydZYwqCfl2dtSDNQt6Pn5W+ZsQRQdB+2ofsiZlDl819JfMPDtzKwhazUh4+?=
 =?us-ascii?Q?hWo9fHqEGoCyCgF227rKoMdZ2/vZiOwHG9kQDXWtPubYlpW+hlhR6RYwF06i?=
 =?us-ascii?Q?GYwxRhr8/KssBFkndIx9jWevV8GIxjMcyk1W7BTFnYMmoVIwk9kZ51d1jYOM?=
 =?us-ascii?Q?WD/WpN+NN8tfxdJE0rN5pDWNZUsON47mJjfEyqFfr23/FMxZ4Q/AgPYVhOH9?=
 =?us-ascii?Q?TpL57SAszilCD3TDq0svJpPnc7gqTQa2Z6DDC4qEe2uq5d+u4B5Z2skx+DP2?=
 =?us-ascii?Q?UUKHC76rnl8yHUmSCR/1dwrBsbjVlsCa/cOL1yBBNSQLtnuJUvMXho3o0Sg1?=
 =?us-ascii?Q?FntCtCsIDDsSHRSh8HiD4PEfp5AMw0wDYdMKLQMg3ku4zrX5dJpc+iO8z9cK?=
 =?us-ascii?Q?pMKFfWbm0FHPrZjYpCrxPSU5vJ7UxYrxr+FRaqCeAfqa94Lo0x9V+Za/Dt4N?=
 =?us-ascii?Q?n5rzPewP2ojj6aY60LfLEazlPBjM94O5/DfEITLz18Um7v1iSd7jA/lIGLjR?=
 =?us-ascii?Q?+1ksB8bdHLUHhEs5dbm4LXrm1z8muk6Zi8avzZK2o1O48sBJwarUL9mQeJ+i?=
 =?us-ascii?Q?+/9ptF5eau09L0VSbNZS5Mnq1i7C2MgCndccTsmxDvtas9grL+IaZz/fM82R?=
 =?us-ascii?Q?zyzDpB4XQsqu5timPgSqOJE/GWuwpNbOnDahWTHtj4iWFj1PoEGJlJoQxs5M?=
 =?us-ascii?Q?KN45hE9pRpafOjLOQu6JJW00rUZgnCNtZi+DyJ0dl2Ih7V/04uvqF9VkWflP?=
 =?us-ascii?Q?TF+WLJ+C5o6iN15iArN57qrY/0x3QtBgrNYUiusiCCaz6fyP+HuRy/LG43D/?=
 =?us-ascii?Q?PSjlOquRg1tlS5DO7/iVU1BscZfE7QmJzX7lxYBIZ3AIlv2VVbtLdz3XHPmO?=
 =?us-ascii?Q?EP1rRLW8yoxz/t7jcK+6v3L6qfbOe1jTFrdhrbM10K3kMypCDZfxhjO95Q5v?=
 =?us-ascii?Q?jpd5ED4HpMa/A4RxtDuy6CabqXOsJYuU4dhVarYs3vcu?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de9b5a75-f46a-42c4-4069-08db42d8043f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:35.6247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7wmKzN4ols8dc1jnXyX2beOV5WozST6WyhJ4MukaJDIyaA9kMJfHk0bDIwsD9sGB4OPax2HAu8iO969rjDQ2JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A TDX guest uses the GHCI call rather than hv_hypercall_pg.

In hv_do_hypercall(), Hyper-V requires that the input/output addresses
must have the cc_mask.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
 drivers/hv/hv_common.c          | 24 ++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

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

Changes in v5:
  Added Michael's Reviewed-by.

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a5f9474f08e1..f175e0de821c 100644
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
index 3658ade4f412..23304c9ddd34 100644
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
index de7ceae9e65e..71077326f57b 100644
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
index c55db7ea6580..10e85682e83e 100644
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
-- 
2.25.1

