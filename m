Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F50168C6C4
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBFT1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjBFT0r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:26:47 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827BE222CE;
        Mon,  6 Feb 2023 11:26:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmEoj3vLPANNrCU98jKZrdpApz/B80ws3p5VMYSOv3ySvsS9YAkLJ8GsHZHrPyBRu5DS0hJtfvmw14ne8CqdyigAR31LzhpfrP9tOqIrerabxXXBSa3SpWEPuGstdiCkVcafHGxxeTXi1oirVVBFRcVdeJJF73e2l9/TVAyUJeJaKhBZPYElb+7avwsUm4KlmhAvpcnBMBCR70yH11Qitp5aNWJ9BMpBAVvNhxtHvSCB8C5ke/HZGVMY1ogvt5p+HFChXCY6wNOIVQqnPGd+/I8YEPrvcim4oWjZqcHXNTET7UwDfEQC/3L9SZ2LwWZOP9Edyo/3+2PwwP2nWEOwLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFt+AX/k6xIffLxvsNbXdZxsXFk4xVTsDP9D5Akff5M=;
 b=JkVLBUIQk5dUOF1lRJrpaKr3vV92M9xbBqvOi35bD/XdB/KK/jBJGcBg1xvLYb/Ql0qg7OQfyVALh5X0bCyyEAsRGI9moMcoB8haLqTgGjZDUnf42iHfF+DQ8cP5YUaoGrnSWCl+3eV18JHU6xJt31u8oNDIlmYIBn/VLZQBTHlqTXCcZFMSbJBBXrutBJwh1g9zhJPj6tDTe2LMV8iIyiUVj7ETZt146EqPE/iPcm6ftG+TRVWtelOYPPT4AN8WlRyAe6L9sKmkx/gZvyl9SS1K1R0vU0EUWODeDKplRUuUfqKQe/Lj8F/+ednZxHNra2IjB5pAhyN2lj/YvosBzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:26 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:26 +0000
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
Subject: [PATCH v3 4/6] x86/hyperv: Support hypercalls for TDX guests
Date:   Mon,  6 Feb 2023 11:24:17 -0800
Message-Id: <20230206192419.24525-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230206192419.24525-1-decui@microsoft.com>
References: <20230206192419.24525-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MWH0PFEDFF6182D:EE_
X-MS-Office365-Filtering-Correlation-Id: 33413d75-48f2-4a32-c07d-08db08780a2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUv7COSmb4yegPTmTsj4mzx1k+CB8t6/b9vUkkmwWrM1Rdn0ejQ3yD6v4X+KwGnyBwg2+vLMSk/R9Zk+4h8/FC9R3i/gTRER6bdTDlbDFbySmRaFeuUJv1GZzKrIAr5AiTBGYIb1fFLsP5BSewwOTg9mdapeu1tqmFIBIgtL00apSIBba/DsGWV3t86D2ittxGHUQtbDDUm31l+Z7ELJOMHGl5Ocw0xNibZGBbCtSmkRVJ3tQF6PdTYi+dmUie4/Yxgl9FBQ63xNadw/+k1amzEJ56XgzCRUz8oj5yut8AjGJV45y4jNSokhWfQtRT9DaYugCk9oLMnwKOzK1CsVnw6o2wEMcsAFz3+XksvGn80Bj/iDgQTrMQlYA+zNSzJ694TuTPvtKRvPAShiqTIFJovS0O3Ht6NFql4rCCkq1ZcK5YKF4wFnfv0CqfOPLf04Y5E3TGn6uTKyYhGRFCiMF9Q0WwCWCexI/VG6ijFbH/ekGBpq5qTies167yFE/OVfC/DmuK1pE0eCVCvjjLQMFNxr91mEwBJaqoOzlQJGVetKO8sEkRMHzTgnOedhZ1WjQVThaeTd0lKd+j4VuFqMe5tna/H2YEoy4TrykeNTQ8YIJN0Ieb7gEMpQG5gk6Xai7b3Py44cyVgOan7fICnn8b3vY0UQ482xgSJYbAhLR3HAV3imBlu2fHaUmotHGm9jlAhneKiDRlEwtlWjdT3RiddNq30cKoSJ8WmjT+Buoes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?05YuYi3/jN8VNs8jvIHGtZNd4kto+A5P9i/q1XZnLjlYTK8wwpUJMSTF9vfm?=
 =?us-ascii?Q?puYIr6NLZpaA2bDSpD+dfH63lPzIUnHnk1K38f4slSz2dkN8ibJNQ4gICmbV?=
 =?us-ascii?Q?AmBySAdER8IkFc+EFxEVTcemtlmT2KvAR2806b88q1M69pEd7Ah1VyRVSvRV?=
 =?us-ascii?Q?yOTYLzjrFstG092psaCkTeWckY7XTw6JWi/j3IbuVD+mVZ8ALRWZa0nkfHgv?=
 =?us-ascii?Q?MFJEupzN3PE56OE3IKmdBRQfQtYGnVjoWrlFoF47VgZXbRxDg1ny6o9BsZub?=
 =?us-ascii?Q?eNaBYM12+tXuEtfeZSGIsMOKImYUCYkMMqB8AjWetd9RtpplQJz/o4l0f1gb?=
 =?us-ascii?Q?lgLaFIkoRgqS109rFGA0weqMfi8ulYmu18jJNmyRXl9RfM9tt1nWbB/Tl610?=
 =?us-ascii?Q?IXf/YMNS3wxO3X1L7926zKdQJnDfleTLkcG/BX0vYI06VMBB+wyaV3vVMdU3?=
 =?us-ascii?Q?esO1zLWGR15xd2hmd36e6aczWw9BTtk3fqRQt/YKpHqKZzGiZbzmBLvNSnFv?=
 =?us-ascii?Q?XDnWhG29h6m94iDGtbDjagmwWlxAo4XphvU9cPQ1WfTQIuO+/vsnSkH3bFcj?=
 =?us-ascii?Q?mMSwf9J5LNNirVmH+iGI6gbosfZDF2y4Iwnzs1rjkR7d36x6rrxERsDe1vMX?=
 =?us-ascii?Q?aWM0En0Tty+mOxwmgf84KaN7fsWEBOePCaJgwtUFtLjVXf+p2N9tgj4OX3Hw?=
 =?us-ascii?Q?1oIDqPIxBbjqlc9ZHql4H4zz83I4ST0IIl4VsTnKGS5k2w5jwkfR1kW1ZhIW?=
 =?us-ascii?Q?GUC4ynx8uQXZr15PRuWBe3El6YvpBqqRaKBL9ZVS7cfBvuqwc7kAFqkXEvVS?=
 =?us-ascii?Q?YUpgy7YEUxcg7+iff2+PzJUI/nJxBtNPEjpmfdliC4jrMGrBFRjMXeiCLLlZ?=
 =?us-ascii?Q?xA6oO0J7ZpBF2O1ou/ktptW5bsYl6vQ762pbBd26qbtvt0Hs36jTp4wfFRkr?=
 =?us-ascii?Q?3JtGi0j/eB8ZS5DiDgVjIwv9Lay85LgeJ2Lc7rzqbXRKqj/zAFjJsFlUYjIN?=
 =?us-ascii?Q?aVVcm5pxCTpbHahQiE19yvnNDM81MswwUxD2aUeMtwGorZwWo5ZVY94zD+ev?=
 =?us-ascii?Q?AA6B3YwXS/RYTko6vubwsxiqNHZo2NwbSHhFBQcwGuT/F8Bql0wZ5XqMiZwi?=
 =?us-ascii?Q?GChMsrutMkhR3wD5Gog0/ICHT1HrBTwUwfWhxqpu9wdEaWdM2NPHetVcbEWj?=
 =?us-ascii?Q?EIKJTEyqAZGNsKxurUO+Eq1e9UVzyT4/kk7yIrPoC7JA60xVXRYMZKRn4KBq?=
 =?us-ascii?Q?EPy79FrjZnvT3t3lb4qYPBYSTo2zpDgBDvAO+1bKIytjCMM6gFOYNpNZGR8d?=
 =?us-ascii?Q?YluxbW2A9KPx9lQPnuZPstpVkQYFjsxoWxUFJoPtfissj2iAEY1R+YXZziUW?=
 =?us-ascii?Q?FOCb6LGcPI7i4GGMOnTm/NOWiX1ba65aTLholvE8ZM+/tWZJLZXz1FjMijbG?=
 =?us-ascii?Q?sKtMNeYTtv42bxpIE3xAtGwAH7CUkJiCmU9ac3sAJtgAMMGTccEZOzStxQEh?=
 =?us-ascii?Q?ZIJ495c0haVA45pBQtt9/6lNslzET7DCEhlK1fy6jRg3Rs0ybMI4611oDMil?=
 =?us-ascii?Q?yYVa40c2wXC0Aqz+x7+F2fItwg/n7guEA9xtlePRupoLT0yNATM3uU6VAY4Y?=
 =?us-ascii?Q?1Gb6azmsIJwzujTlZrgJEmypfmtXSPOScj7bWTBeX/ba?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33413d75-48f2-4a32-c07d-08db08780a2a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:26.4447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o+706LQS3kPv1OVOO36Db9md50QmJuQ3H5tQBxw4rUt22hUwN5kdldxbJRE3MTFievJVIpIOAtmT1qCyd7ylMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A TDX guest uses the GHCI call rather than hv_hypercall_pg.

In hv_do_hypercall(), Hyper-V requires that the input/output addresses
must have the cc_mask.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

Changes in v2:
  Implemented hv_tdx_hypercall() in C rather than in assembly code.
  Renamed the parameter names of hv_tdx_hypercall().
  Used cc_mkdec() directly in hv_do_hypercall().

Changes in v3:
  Decrypted/encrypted hyperv_pcpu_input_arg in
    hv_common_cpu_init() and hv_common_cpu_die().

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
 drivers/hv/hv_common.c          | 21 +++++++++++++++++++++
 4 files changed, 60 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 41ef036ebb7b..6a0bcbd18306 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -430,6 +430,10 @@ void __init hyperv_init(void)
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		goto skip_hypercall_pg_init;
+
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
@@ -469,6 +473,7 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
+skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
@@ -602,6 +607,9 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
 	 * that the hypercall page is setup
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 13ccb52eecd7..07e4253b5809 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -276,6 +276,20 @@ bool hv_isolation_type_tdx(void)
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
+	(void)__tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
+
+	return args.r11;
+}
+EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
 #endif
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 49bca07bbd2c..159ab74d80e6 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -10,6 +10,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
+#include <asm/coco.h>
 
 union hv_ghcb;
 
@@ -37,6 +38,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
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
@@ -44,6 +51,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control,
+					cc_mkdec(input_address),
+					cc_mkdec(output_address));
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -81,6 +92,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	{
 		__asm__ __volatile__(CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -112,6 +126,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	{
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a9a03ab04b97..219c3f235c50 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -21,6 +21,7 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
+#include <linux/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -125,6 +126,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -134,6 +136,17 @@ int hv_common_cpu_init(unsigned int cpu)
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
@@ -154,6 +167,8 @@ int hv_common_cpu_die(unsigned int cpu)
 	unsigned long flags;
 	void **inputarg, **outputarg;
 	void *mem;
+	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	local_irq_save(flags);
 
@@ -168,6 +183,12 @@ int hv_common_cpu_die(unsigned int cpu)
 
 	local_irq_restore(flags);
 
+	if (hv_isolation_type_tdx()) {
+		ret = set_memory_encrypted((unsigned long)mem, pgcount);
+		if (ret)
+			return ret;
+	}
+
 	kfree(mem);
 
 	return 0;
-- 
2.25.1

