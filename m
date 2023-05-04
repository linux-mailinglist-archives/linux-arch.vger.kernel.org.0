Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA96F7975
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjEDWy7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEDWy5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:54:57 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870DC120BE;
        Thu,  4 May 2023 15:54:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYNe6b3SSOn4OAxNFvx2ZteJChO4pgigqO7XPYNTFtCqYo1QULz87/ewfAu35aR3hF5X4SRs6E5WsbeyvWjCI5f3tJEMeIGjAu5G2piFe2AiAsEQDCQ32TzMoZMiMvG7tCL5vHghFABkIujpEiGKITUhqcsskWV8nN3hF9PdCVZBbTMQl0fVC8SlxwflR5YibO4IZXqOlICKAraEupeUmXEfoYrpRvDGjULT0ayTWKh/1nYDYaltg6ezSGVHr2hVmJhzhHnjCQpsQeLdKDSdwdm34dBajPC3Kwzdmj/8jWLlKQHA14G635vETNNPuquuYczzV6XlIj4xgr6vSEjO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFkwAzDbnM+6fr8oaghD3/GiUHCe0E2goDYodXrWc5o=;
 b=hAK+OaUc94CDMuqGfgXmKh98HIv0QhGMtdXhR1Bil4PpNCWBNEb8M5aS9vWGtOOcZYDUt12JVXOI1Fd7tffrdDRrOf6y5LnbQQTj3y6t6lCMyz/uXkjlp0hAuJUzgXBGOOD3yo+ta9zyc4znfArnw1K0Fh4SachZlHxlnuBWH9RXGmWN6O5UnHqIHPCQXVwOL+8fqDpl2WLZ1rTQjn2/hk8DQja9DEUsU3W8l59neoC74LKgO5eWUFZjnglrKxywyq17Wl1KOa7Cuv7N4L3gpC0MRKrRAefVNqcuwHsxaWdUfulJ/B4bX83fwz5w4aIyoHtk0HvbnxSa3WSv+txG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFkwAzDbnM+6fr8oaghD3/GiUHCe0E2goDYodXrWc5o=;
 b=YzOEhVs+NhlaFuBJsfGGc/IdDiU3s0EWndp5bve/S5i+T/S1723pUD8VAMRAPffR2VgM27ZhQCw9Q8HJQU4sX4D1aAXpfSUTCoLiCzcPfM70SHcm5PpkP9u9YcRUK0tfQb5q+oQl9VcM5WVu++i9RmuyiGj/bluozgxmtYfsKvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:54 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:54 +0000
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
Subject: [PATCH v6 4/6] x86/hyperv: Support hypercalls for TDX guests
Date:   Thu,  4 May 2023 15:53:49 -0700
Message-Id: <20230504225351.10765-5-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230504225351.10765-1-decui@microsoft.com>
References: <20230504225351.10765-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:930:d2::10) To SN6PR2101MB1101.namprd21.prod.outlook.com
 (2603:10b6:805:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1101:EE_|SA0PR21MB1883:EE_
X-MS-Office365-Filtering-Correlation-Id: 89448e2e-5c5d-47c4-6713-08db4cf29379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: by20hvDjI1RD/GgkhCXuJgWKWNUQO8BHIXNNeTNuwyIW3BNCQTJ1M//0POivWpLwBlUk2k2qILH6J7GCYa9ZF/oEUMPEiyWALdWe4E3eOmpoux4/RenZWuI4tG9qTU78tFs8RR7TfPgRJJYaUitAtapptaA8sBHUUmVqtfi6FAtSxRn+fOSB8Kam0F7GKsBgztIHY0HBPddbFtQhYwDwUAACViTVVj9l1PQtaCmE74JRD2AkkPlXaQHORP+mCQ+2b8TPoPYrd7vGVBByFsf2l3UhAHCZSKbGkwI1V2i/nnTdyVGzMK6ga/RczN2FnPQWhWCA1iMQ1oDFinz/5CmtfEeyBA6jDP92zEYPk02TdekQwXDTg/Eiwy6vOb2Vg1hAcpChr74INC/rNrTQJBRgIq3DwN+DTqvM8NkBsxBkYlrlKKHVEPK0Phm9mFSVcj4+4/bGSND4wLRVWfmGVy2bNhNhkmFzAeztw8HYJxfPOHd1RfrTO3rDWffv5JkcwbXZo28FkG7o6pKTQqv+YkUGWVEntxgi3nSutxxgw1qHlQm9FWieaXuKIxc6nn+5pCuUU9r+vFH1DVWNuBGMqdRiBZJnjp48tDz9qfRTixMgAzD8S80G+WX5pROToxxnG4/eI8YzrasMgFRLUuflNj6VzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(6666004)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?22lNv78yYcSQSHuQI9pXertietr97MQjnnrdyxqaCYqgkEDxkSJoVurYedWd?=
 =?us-ascii?Q?d1p+qaVPmEWYvYPH5lXdltbm16jHVHoWvtHgJyvFVjbXQH8CspMWCPRIganW?=
 =?us-ascii?Q?AsQ8r1D67rwgkBeYxZ/v0M+RxYkjEx5VK4gy9vpSOqgcNkAAMRU1Z1Zcrcg7?=
 =?us-ascii?Q?D7mfdFpUZSOgGZaRbG33EKKsZ8L1aDmNE0eVqg4qipE1Qfcc4VnQ6f0y27/H?=
 =?us-ascii?Q?uJgmxTF2jp7OtmbysQQVbXD2++GXO4xHXzUXqbsTtFzMV++DDO9CsMudY3Im?=
 =?us-ascii?Q?K8mtDNjVnXGo33VfTjU7GFd6ZH2Mp50h9Cm8+atCmcaCfRdWX4Jxkm9K5luN?=
 =?us-ascii?Q?2KviE+L3iEr57lRG3xhSKmQbC1vqFdSyYjFnUQSL6usjOx68BuRd/yWK5Ir5?=
 =?us-ascii?Q?haxSp3AX1l43qe1AXciNwg8bzGAgpVC+ixouGcchXVcBqjo8rRJiQYJWWub8?=
 =?us-ascii?Q?ALb4KSERo+zkpiNaAFaiwNFrORw01gHgg9SYFYt9sOrCzuxhkMuyuba215MR?=
 =?us-ascii?Q?7vETmRmQ6BQWp6gKT666nuqrmq7mIICHQVzKqc84RQ+t8kkKVKY7uheH3Gpc?=
 =?us-ascii?Q?PARpB6mSiu/H8m1+FSfdCPax6TN4+PNw27HzwK7g4gLs9Q2RjtP6vMEPYBxH?=
 =?us-ascii?Q?lMmjIY3WTYpEd8vPxpgigWCeAhqOa3rYaxSFIPCSH3gwVimB4kUE2cXyYxG3?=
 =?us-ascii?Q?KEwjfpGkcjNU3UHRjGnFkb4BZwarLyk5zMNaYG/j62LAg7M0rsPplWNvC8K1?=
 =?us-ascii?Q?43UwRzoav28uGiVqMS0TrR90I8hQ0APK9eWLPpgCJTxGnMmq+2lfRcqa6KuT?=
 =?us-ascii?Q?XG/85dHPn9riuZNwFoOiAugacgZM8flLmV9oeyW3219DRgYPG0E1stqGV3bI?=
 =?us-ascii?Q?5xryujReb5akxdl4lf4vSPDs9oajSvV5CEe9KQzdCtArttAQBw0nokA4JUoV?=
 =?us-ascii?Q?Q0DZGRYpYG6B9YYCGX2CLkAG+ID530oJS3C9Uxn4X5yf+4RskL3yBh5MGFRi?=
 =?us-ascii?Q?QtOAHywU4191vXj69b9QpaHi2yWnFJYLhSkUvYwtCmz9DpqLZqu+SvTt2CGq?=
 =?us-ascii?Q?03zu45AHrq8MdKq9rH1V12BxvwRYe/FgiHpOIAmX+0+/r9oyJYn5wGeWYtXp?=
 =?us-ascii?Q?ndbkMV3mcAtLs2kQNZFImfqwDqkbO3FZZlnR9J8Xe9BbkPqeXjLitPRcb8cr?=
 =?us-ascii?Q?m4xM/k5zR786TcRdSZ/Cy9xpRhU4w6TrE7EdM/amFecP5IIA4P4becjShoGL?=
 =?us-ascii?Q?mCGLY1S1pyJerOThhqaqDYN9gELK0l5PSMF70iJHZHZxvt81nlonf17tpV9V?=
 =?us-ascii?Q?Ub2PIq/jU1PwspgOgEHCjeliDo1Du3hve4x2755e3AiZ5KxvqHj6KjRjVhP3?=
 =?us-ascii?Q?cKLDEQR+sdDAsFLDFYvtQVpHoZM/KP6h2+txloDsCQ2IYYbbVUnTK9bvzghl?=
 =?us-ascii?Q?lwfN6u1sYApABLGEu+AcnkRD+LsU818an64Yipjw6DDC//d46IY1ttqyJI1F?=
 =?us-ascii?Q?efYTRf/9fFeE0lUmEt9D83kCcXscRgT8Rk6jnmXmvJrWVlCsAjuc6xJDEwIy?=
 =?us-ascii?Q?yIlnhOLOhwMzUuemZAey6rx6qTQlrmgyV9m2AhfXTM+Eg0YQFESWS+1F61mr?=
 =?us-ascii?Q?y4OjTpfC1+V1EBq3FO/iZ1Jqg8e8rf1fpWQhSDvA0otB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89448e2e-5c5d-47c4-6713-08db4cf29379
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:54.5230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hoz1HvYb1lr3LfSpLo4vtCH9zEdeizZWXxdeD7XqWlIBobBmpkoPvWeEojlm6WrId5OMaZjDtz3dmiKDGcGapg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1883
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Changes in v6: None.

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
 drivers/hv/hv_common.c          | 24 ++++++++++++++++++++++++
 4 files changed, 63 insertions(+)

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
index 952117ce2d80..61ff7060b39b 100644
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
index 231e56631295..945e5afaba69 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -10,6 +10,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
+#include <asm/coco.h>
 
 /*
  * Hyper-V always provides a single IO-APIC at this MMIO address.
@@ -54,6 +55,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
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
@@ -61,6 +68,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control,
+					cc_mkdec(input_address),
+					cc_mkdec(output_address));
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -104,6 +115,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	{
 		__asm__ __volatile__(CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -149,6 +163,9 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	{
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6156114cd9c5..5b32adff0e61 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -24,6 +24,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
+#include <linux/set_memory.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
@@ -359,6 +360,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
 	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
@@ -368,6 +370,17 @@ int hv_common_cpu_init(unsigned int cpu)
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
@@ -388,6 +401,8 @@ int hv_common_cpu_die(unsigned int cpu)
 	unsigned long flags;
 	void **inputarg, **outputarg;
 	void *mem;
+	int pgcount = hv_root_partition ? 2 : 1;
+	int ret;
 
 	local_irq_save(flags);
 
@@ -402,6 +417,15 @@ int hv_common_cpu_die(unsigned int cpu)
 
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

