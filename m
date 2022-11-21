Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFF6632D6A
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiKUTxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiKUTxL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:53:11 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022024.outbound.protection.outlook.com [52.101.53.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6234623EAC;
        Mon, 21 Nov 2022 11:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOvHRzhBvFjVSkWsDPGOJRF/O8zJijfk88N1Zus6q1zB4Y17EiK6t9vDL0vj2yaalw6elKTdj/2b3XzoveLlW2XP4bnWEXRAetBfRQlFWVvygwDB5umw85wjBL0PqPmFBE14UbJPg0o3JwpovPVVzYRpFbLHKqutZNeuqit22HTSIR272zAjBeCDd1ldewfFlByayW317JetVThgKXosj2HWyyxXeR1tI5cZzRu7B99ilstPF/tsVxB0OxotR/1DFUVZfQ4iVGzOUgKKSA1rpCE6WLWGwnQCxxlPu6oilWrtYDvLPTjer9dxZkOpIS5MqUtAOQS1yUxxGyuLgnKziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RvUGjpNnrfcGibK66Xh6KWAqOypfvu/g4MB0/15czM=;
 b=kQQZCe+2jIwBIe4OAHaPg2PrcxkMCXzDAW1iCPCoJKNCgm8Ud66k5CInZLkJsvjXFolahfrWn1z3joowSetEwzsIzKALW8kOjrpfJojkMpyUWVKspIRtCOYQEwmnfq1umAMmQm801I+9mRwW1CWIFeBss0qcIY83hTdWshBe96a3ZK2iGTyxDtLv//sdkkeolhZGftRFaGhJwWx+aGR1zP7kokCOfBGQjojydz0RKCuNHsLxaC26FYVvjB866xhtpHLrgbJolZJk9KeMHO1x5qNuCYYUdlWCY2FS2eHeXf3ArpsZc42ccdQEOIF/CokU8VnMq/6CtbSNJTwhpxU7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RvUGjpNnrfcGibK66Xh6KWAqOypfvu/g4MB0/15czM=;
 b=Hc65KUccwUQM2eey2JZpKu/Kw7j+ToBZ4v2/mU21tCIvjiUDaU4szKovgQA6XT/S/dkrTJMcsTG/kdFMtrcnxjnGYTtI+3OPhV572qI88lpf4RIPMZj+FvSMHusFRZOrsD1Tc4NzN+4EFtOsAwcHJS2iKY2qYm51gIVTPoR7idU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:53:00 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:53:00 +0000
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
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 5/6] x86/hyperv: Support hypercalls for TDX guests
Date:   Mon, 21 Nov 2022 11:51:50 -0800
Message-Id: <20221121195151.21812-6-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121195151.21812-1-decui@microsoft.com>
References: <20221121195151.21812-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BL1PR21MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f8d18c-d33a-4668-a894-08dacbf9feb1
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JiOdgEZCgxIPEL03+sMgen2Cq+oKnUCssr9WXcxMY+MWX/Gkwo21k/ZF0mnq6XyMrC9eL7F0MirinpHKMywDXgNylIsH8cTp8CMvNmQrf/RfxJNUeEKGQj8ftSTVlcqxNf5cXVd+IMhv8xLUcAsIYCgZPpXT6tyK5Ro2CZuYOE/QSLnYtu7lV6/GqfiFQMo9XMnsQ4jHaeIqexHhpAkg0ZeKpalQR4L/8gT+bT6sMIXN/AEJzUM8dR7MPOsnsKUNh1dSoBai3hFc1YmUeP0OJbMy4f5DU4TseOc84tkj1DHsNxDj1nckE7dOuGlRfjQ17xDLa5PAHB7AalVqLT3IF1DOt3fdMOLyfw3shvhQ2d+dZkg2PMaGr30utmpnbk+lU85wJQFa48fbzY+iokFNZQJwihnL735x27zc1W5VA2Fk/bX2HEmHXJtLaqbBe8Qw48j6FPgofpG0i5I0fw06qTzy0DgQQ12JVTjDybgr2dWOxEeU+dY1bOGHFEoo8XLjVo6qiUsFrMDuOGWARuyqvv9WPpqwX4a6vcIAbqBTJ1XasJlRQuBeyTBNhTZVlmc3Z2b8aaAwAbkyQdkRTZM2Nw0iYG0seMlxUarxYACLCKT90wfLgIn3ANm/YQYWmSUDu6RVipuFVOZwqy4kA9RjRM9IDgJ5J3vqzYgqbxaPntry5FeOzr/VO9uBCS0UFock6IjH6z4iDxjlhafnej32qZTArO4be512eHD1+KfbqbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aomPXmDea2/RSP3uppbRKrPBSFFgbV0fH2JHyiYFVFUpehCsWLwPwZAf2FCQ?=
 =?us-ascii?Q?iOiRsaSUm/awUa66sjZYxC7g5Mk4/o0v+1DTd6fAv+nqI8TcCmlqRhr9UeNS?=
 =?us-ascii?Q?SODVL9mDyUPNRUYmTJoUysCC5nm0KgLzoNDdrg4xJXsq+ifXw7MIDS+HyJtQ?=
 =?us-ascii?Q?slM4cUjBFGkTeX9Tb4HQK+nvoAyd7FfC1AINvtqFX9kibWGUES6HT0kBE9ih?=
 =?us-ascii?Q?SrdQVwqZOvwcBbMADAUqyzewA3JufXlQYb4CMGHm7JK6Ys15+LIQX/1Ih4pm?=
 =?us-ascii?Q?ziEEthnGjB4DKxeUntCEuYT8ii6RiMDzmaLwtlIlKkm/mQDtkPtw/+q7f4cg?=
 =?us-ascii?Q?Fi9mX9uv0E6xn7ZfmaAYcrVwI/8JRQPVA7xvWlyB3hw05L75wlwi760r5PsI?=
 =?us-ascii?Q?pZ+5mI4UHAYolHeWCCnUjwNhc6o7vrW7iNlOxe+I17Urrv3NO/9Pxgm86sLn?=
 =?us-ascii?Q?Wq5pWWKB+n/VHYVyAx9PN5YIibZTYNMMWsefGTdQwsEqQjIGh+z7ViSyZcKE?=
 =?us-ascii?Q?2u8qL7uRfu2MmqsvxLAy/r0daITJOGglreq+DzKz2XU+P6hm6dYmP6E7u5Gu?=
 =?us-ascii?Q?KYvOKz6dH29IWBfN8mfZWdcY8XwMZL0wQVzZ4QS27F/n4tjfPwmDOdkdzHav?=
 =?us-ascii?Q?W63qXKBJhdmilCG7xBoVyuu9oYnDT/9Mt5qVoI3C/2Omh398+r1jhQ+ZDQFR?=
 =?us-ascii?Q?PeaoLuSqk4UxOrMo4ZPykILxlQUScHEVQVkiAxoc375Tbaj/Y3RA5+tqdMre?=
 =?us-ascii?Q?a98Pv5DSII0/p15qjKSM6lz2QujGpTShYJ4LUlywa839qoP1QUZHMyfkp3yX?=
 =?us-ascii?Q?L88Z1m0WNAeuOlmk4wAJKd55fSziUfq1YH00/rhXWAtWIsuD/bY+eBlAOATl?=
 =?us-ascii?Q?6ubNnOasL91Cr7ocjGgZv/RqUiMgyYRLYgqWAXDZQzMHzcuGpAAcviUk7piX?=
 =?us-ascii?Q?0QJa3zTD6qw5oCcF2sW3+XU3fKqJ9i7uvxCBuH5g6uwGTKcXytMvxfAunA6k?=
 =?us-ascii?Q?ADLq82lWAw3g6HdEDT4gLv98nOe8KfiXrpgV0eQn9+mo8XKi89KDmKDHnh6e?=
 =?us-ascii?Q?DQP3l5QQ8f0rcOP9MrnhfAR+dW79TYja+ustAll8tJAdl9Yj90ZosRxSz7Fz?=
 =?us-ascii?Q?3Q1W3/MaTBFKElHe2DzsO45StVVg1geA2I151zA18U51+/iP0fE0WQkxfQM1?=
 =?us-ascii?Q?B+2nrPZ6SwAVFXdHROA8BueehsrSexGyrEQ5n1XzRI4fKNQrbZDnHFW704BU?=
 =?us-ascii?Q?qvrsx4KATayRpORSGSOHaqGmrB4NsfdnA4XwUGgTQ5N7NzRPx07T/KIw69YT?=
 =?us-ascii?Q?TJyAU6lHANy1fQ54Rh9TfLCkis/TWQRQUGVG9teUR3Bu1ClzGnRhV0i73BrA?=
 =?us-ascii?Q?S7BBhnykMbaZc4hW+1PzNsPqTHoKHT1EalHPpAQQJ3pRuOXKojeBRtoBREHo?=
 =?us-ascii?Q?XdcMlS2AqKwHhUqrr0MnNRNI6TeKjvf5rUN7FJb/j719phvK/ACYgKeOoGwC?=
 =?us-ascii?Q?j/iDH0BYxxGqh9h2r7zLMavsN/iafBtZlUpJsd/xcD/2aFvKVh2ahX1xatVV?=
 =?us-ascii?Q?AP2P5B3u24tWgmmM9qgfZsNGTsiQcrMfhhUE9UNa2ogCsyJrAIAecXAgRJKn?=
 =?us-ascii?Q?imRMnr8gnyNNUqmk7mEvOSJup+nlJbfmB1bGFWI5bNdi?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f8d18c-d33a-4668-a894-08dacbf9feb1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:53:00.7947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xx8DsGBUsOqy+eTCYxUpbk08s0Gxt+ZwB4aJ65D5Dz8UCkBpapcGgTo06RXynKJgP6rgkLf4YmTESkLTJmKffw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A TDX guest uses the GHCI call rather than hv_hypercall_pg.

In hv_do_hypercall(), Hyper-V requires that the input/output addresses
must have the vTOM bit set. With current Hyper-V, the bit for TDX is
bit 47, which is saved into ms_hyperv.shared_gpa_boundary() in
ms_hyperv_init_platform().

arch/x86/include/asm/mshyperv.h: hv_do_hypercall() needs
"struct ms_hyperv_info", which is defined in
include/asm-generic/mshyperv.h, which can't be included in
arch/x86/include/asm/mshyperv.h because include/asm-generic/mshyperv.h
has vmbus_signal_eom() -> hv_set_register(), which is defined in
arch/x86/include/asm/mshyperv.h.

Break this circular dependency by introducing a new header file
for "struct ms_hyperv_info".

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 MAINTAINERS                          |  1 +
 arch/x86/hyperv/hv_init.c            |  8 ++++++++
 arch/x86/include/asm/mshyperv.h      | 24 ++++++++++++++++++++++-
 arch/x86/kernel/cpu/mshyperv.c       |  2 ++
 include/asm-generic/ms_hyperv_info.h | 29 ++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h       | 24 +----------------------
 6 files changed, 64 insertions(+), 24 deletions(-)
 create mode 100644 include/asm-generic/ms_hyperv_info.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 256f03904987..455ecaf188fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9537,6 +9537,7 @@ F:	drivers/scsi/storvsc_drv.c
 F:	drivers/uio/uio_hv_generic.c
 F:	drivers/video/fbdev/hyperv_fb.c
 F:	include/asm-generic/hyperv-tlfs.h
+F:	include/asm-generic/ms_hyperv_info.h
 F:	include/asm-generic/mshyperv.h
 F:	include/clocksource/hyperv_timer.h
 F:	include/linux/hyperv.h
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 89954490af93..05682c4e327f 100644
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
@@ -606,6 +611,9 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
 	 * that the hypercall page is setup
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 9d593ab2be26..650b4fae2fd8 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -9,7 +9,7 @@
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
-#include <asm/mshyperv.h>
+#include <asm-generic/ms_hyperv_info.h>
 
 union hv_ghcb;
 
@@ -48,6 +48,18 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+#if CONFIG_INTEL_TDX_GUEST
+	if (hv_isolation_type_tdx()) {
+		if (input_address)
+			input_address += ms_hyperv.shared_gpa_boundary;
+
+		if (output_address)
+			output_address += ms_hyperv.shared_gpa_boundary;
+
+		return __tdx_ms_hv_hypercall(control, output_address,
+					     input_address);
+	}
+#endif
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -85,6 +97,11 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
+#if CONFIG_INTEL_TDX_GUEST
+	if (hv_isolation_type_tdx())
+		return __tdx_ms_hv_hypercall(control, 0, input1);
+#endif
+
 	{
 		__asm__ __volatile__(CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -116,6 +133,11 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
+#if CONFIG_INTEL_TDX_GUEST
+	if (hv_isolation_type_tdx())
+		return __tdx_ms_hv_hypercall(control, input2, input1);
+#endif
+
 	{
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 9ad0b0abf0e0..dddccdbc5526 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -349,6 +349,8 @@ static void __init ms_hyperv_init_platform(void)
 
 			case HV_ISOLATION_TYPE_TDX:
 				static_branch_enable(&isolation_type_tdx);
+
+				ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
 				break;
 
 			default:
diff --git a/include/asm-generic/ms_hyperv_info.h b/include/asm-generic/ms_hyperv_info.h
new file mode 100644
index 000000000000..734583dfea99
--- /dev/null
+++ b/include/asm-generic/ms_hyperv_info.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_GENERIC_MS_HYPERV_INFO_H
+#define _ASM_GENERIC_MS_HYPERV_INFO_H
+
+struct ms_hyperv_info {
+	u32 features;
+	u32 priv_high;
+	u32 misc_features;
+	u32 hints;
+	u32 nested_features;
+	u32 max_vp_index;
+	u32 max_lp_index;
+	u32 isolation_config_a;
+	union {
+		u32 isolation_config_b;
+		struct {
+			u32 cvm_type : 4;
+			u32 reserved1 : 1;
+			u32 shared_gpa_boundary_active : 1;
+			u32 shared_gpa_boundary_bits : 6;
+			u32 reserved2 : 20;
+		};
+	};
+	u64 shared_gpa_boundary;
+};
+extern struct ms_hyperv_info ms_hyperv;
+
+#endif
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bfb9eb9d7215..2ae3e4e4256b 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -25,29 +25,7 @@
 #include <linux/nmi.h>
 #include <asm/ptrace.h>
 #include <asm/hyperv-tlfs.h>
-
-struct ms_hyperv_info {
-	u32 features;
-	u32 priv_high;
-	u32 misc_features;
-	u32 hints;
-	u32 nested_features;
-	u32 max_vp_index;
-	u32 max_lp_index;
-	u32 isolation_config_a;
-	union {
-		u32 isolation_config_b;
-		struct {
-			u32 cvm_type : 4;
-			u32 reserved1 : 1;
-			u32 shared_gpa_boundary_active : 1;
-			u32 shared_gpa_boundary_bits : 6;
-			u32 reserved2 : 20;
-		};
-	};
-	u64 shared_gpa_boundary;
-};
-extern struct ms_hyperv_info ms_hyperv;
+#include <asm-generic/ms_hyperv_info.h>
 
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
-- 
2.25.1

