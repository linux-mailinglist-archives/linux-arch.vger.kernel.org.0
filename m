Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F6464506E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiLGAfZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiLGAfA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:35:00 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022021.outbound.protection.outlook.com [52.101.63.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7AE2FA5F;
        Tue,  6 Dec 2022 16:34:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpRpPeEZ+EJmwUA8YIxmulmq0uT/ndbRkhWyiNHCa/UDXshwH8DWxFnIAglFQelDC34ROepYzYbHg/sL6ZUXy59NllGUnV4r3lFXw48WlrQohdJRi/Tnicqf0ivQ7cXWUv2O4hYd7Om4QUM+QZagaj8QlmS4ZS/mTIjbW9pRJH+jwSkHdZms5NC0et5hJmCnD8GUc2S7MIaklNbVRrARBIZkhIj84FUTMhfMp/gGbHD+Q15YG5SrayF5D67lU6LsHPaMpyOGyNQYaiVrzv4UIOwfUhwP4gMpUjiNmgtAx/9ddiYwjoiotFJyZqV4QRBjC2oHZiyo8UmhhuEZqRuHUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5hyFVyD5Pl8VoiZaRKapfW+Nyo01fWHDixlPcPEe/w=;
 b=dEi7pkR7AIGcQ+tXkqALjscgdAo6RFWRlHsAsVHl00tTKIofPRnNFsqW1cQV2HV+1SUBfd7lXRsbsQdlF/EgujqR5mPWOkzdzewHmhoDJiRF28kk8da750wRMc1fGPoNjuYEY3tQ6mKyR9+vqPI3QV48aPkQnYashHcQtCaAA2sMmqieTEAJbEQEl7zKkgk1pwVCYVE9akVcBpO3r4wqGxKHVZdRs2NtBZRrhpHihBhQA8Dnw6qRs0kfNcrt6naLFLQm78LIbzzo2Nk3xW2FmliMFAk7wydQtpXaJ2aQy3V4s+zCpf6ReRa3lQZvnnCJbPNpeYef50YxY9ZGpxNpqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H5hyFVyD5Pl8VoiZaRKapfW+Nyo01fWHDixlPcPEe/w=;
 b=Cxpt1HjjLovDxHGVCdoi+AvZjOJ5iOJ973epwHuPM9Mwj5LESZrQJUeOeRME9VgYiLZH7KyzNIfK/tezAvfYSOb6sQ1NfySg1geiJautrFRvva6hfqTjDAQ7zGdZviZaPLiFg/xAvT7U+bbTnCe8+gb1IINuHXoe57D0z0w0UtQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:52 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:52 +0000
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
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 5/6] x86/hyperv: Support hypercalls for TDX guests
Date:   Tue,  6 Dec 2022 16:33:24 -0800
Message-Id: <20221207003325.21503-6-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207003325.21503-1-decui@microsoft.com>
References: <20221207003325.21503-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|CY8PR21MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: c31f66ed-9e56-498d-427f-08dad7eadb07
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sGuLcG1+l8g/cdBD1LdyT4FHwUlSkl+wh0IJnrJuZ2yx46+Q2TUmnK6aIAbGEUDL/QEBcbDfMZ1A/LRRUlxBVrRiHYUirXAiWnABdVJuwn4zJwnIyGj7zfjMVgcwZwaeDwocumSZWwpo18TccQpNq71YmaDfH7ULBO0TwXC2xcWuFANE7+G2sNaPIZUfsCeF6c2lSmIJm4SPwodbYNiiHJHvZB5XxQHZZy6MRA3Lz/y0+YMpJ2NSjYMUkwhgEFXGoQSBebzbVJ8TbE6eRh/s1NKb6DkH1qWdPbfVEOdwgtJEWa/lEtclJB7rakyz8yfiWgX5Zp4UKIJV601uypNLYiuX4ELWpz7ue8fb+d9YfyrUWwi4JayZAb2C8/h9G9HCs9TGeEJD12DlMvwbx+SBPzO35wtmhU6C/NRtnjLsYSH3zYopllXK5tA7Ivv1Gl6Dny06tfNsV++uIXspD+8zTEdHNAqjn1j56HCS2baTDyyvzI01uuC5Y/IoVMbCW5ujKaa8M6dlqLwrzMxeMsOU99aBKG9Z0WDYiHst1CChfQ0/nbBDXrAezUQ1jfFjIEC6lzHcuGdHLeRyOL/j2R1cAqRj3QSTm3vbvo1B0VoP6GoZ1nd476e6yYu0r53f6tmwAuvLZMSZFGdUbrvfDhTKo260bgVcioFjPxk6HcZ3Sa+x48o94UkzutE34JbEG+GyytT04Om8fg7xdaX8Agnny60sWd2tp6gDm+3WpxjRqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(107886003)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xr+eAPSRLkdbwHH30M3Dd56eW8nGThiG4KgeQRM9AGaVHlMRBChL/47KCfx4?=
 =?us-ascii?Q?kuBUJX4X2fVTdGlYgfyA5FmRPVRggtHqjhTWQ9K+afhP6KJdrb+zmdu7RH6B?=
 =?us-ascii?Q?tnNXimmbDlza4UgCA+elEBBCd5UCO9rkuOlazYetu+xhi5a/PZEzfbvK9PSR?=
 =?us-ascii?Q?KI4LRcJjizxrZDpbyHRpazl+jwsD1/fn250u+NfSTKw2irk4y9ZjrKp8oeg5?=
 =?us-ascii?Q?+BflDMB7G6aU6WxU38qo0mFaPzpa7xlGAucWMeQvPN1QxIwoHnzCZq0rxRk5?=
 =?us-ascii?Q?9Nx5Gh9FVVQ/5iSEr/EJ4j9Xo4xNtRSyyLX0E6jx6GYs6U9CLbIl7VDuVK5v?=
 =?us-ascii?Q?jjbkDHU0goyq7Y51NSbuAqwtI0G8HT5dGFbMpHRu8a64mJA8LbS16PzFe5IX?=
 =?us-ascii?Q?AU3xrUqXMc/0lRGqBZT7zmXskzzjzber+ATlfGPSCF6+nFmVOUojIK9Nqjuz?=
 =?us-ascii?Q?nAW96fazArRA/w8FBvgIwN7AgN3Ger+AO2f8Urher6NFtBmfQ7LizXRObsHd?=
 =?us-ascii?Q?vjJltkKI7SklrEbxiUD39P7z/Op+g29Mb/sI8+vQim5/uZWFDx6KMxC9ydUK?=
 =?us-ascii?Q?k6GQ89M1siD5gyW0gwwUSj3IN7fjdfOU1tEhPrtYXaaRLnK9oR3gBRivjqwe?=
 =?us-ascii?Q?L2/G+QOUjAGqg6GSB+7TUnQZy819SDbGp7yMMlXAHuvy7ZgX2Ahn+fzD2y1D?=
 =?us-ascii?Q?RCwWhTZP7BsbMY1fCxGkcr2M8L8kzqCWDK3mA73F8Ejh8hO0wirTDMSWoDIu?=
 =?us-ascii?Q?N8SiQmBTO3Qhooe7vYLSuotBQuP8i6iXxXjas/GyBE8WwHhilEugRhaL48Hu?=
 =?us-ascii?Q?tYQrBX6bdKTQGXgT46P5kYqj1uzJyowm/Qo1oQeSv7aBFMlrGwKM1O5+I4t5?=
 =?us-ascii?Q?CuCXyB7AbuJP73Sf8/NEIgczJ5uQ8+wVmBfSmCRcHb6ZT7GaHDe9cQYc67SU?=
 =?us-ascii?Q?7mUoeSecchO+nUiHk00VlNEHEZGu+HtQ2euglaQG7S8qnctisod9Qn/4Zt4A?=
 =?us-ascii?Q?WA5yeJgd52nj76lEEyztQEqxC1a1XAkK68B6qtUC9GVL7pgF1sRchg0bk2iq?=
 =?us-ascii?Q?/RUuG5xD3mci+HqFmk5ickzR2df/BaYp9D9N8YrtzCQbZUyXNe4okFq/mFel?=
 =?us-ascii?Q?IqYU05BMYSpiZi+xFWScXjv3UT0bxQd/q78k2+iCjuPKJHVB3zol5k2ZxufK?=
 =?us-ascii?Q?mjHIbWrChKKwdYNE+an5toEddXlN3wXed/vbAWKbYRYtDdR4XEYI/aaQX3+S?=
 =?us-ascii?Q?8mwMOy0WFVi3KXc9efQSv2eMB7vakzhBPXjEDT7cwdVxSFaqjVd5TRFtOFWF?=
 =?us-ascii?Q?f3ZqMpk3xxoHPqDM3/42HzqoOfviA86Q508SDy99wnXYHmWT87tn1d6n8PwS?=
 =?us-ascii?Q?Qw133DchYhxBDvB6+CUErD6f5E2ZoGFk+iI790V+4B7khYs3sOPFIPzIcIrs?=
 =?us-ascii?Q?T+ENfyZPypPrsJ/h0xQT5nt+3g8d9ykxUSRab6JHhIMLdsh6w4S+6H88+PV3?=
 =?us-ascii?Q?dwkgWYji9fu5W89+mQgaZOYvOhvQAXvdGs3zqDf30HZYRxCZ8gaBFr9hGoMy?=
 =?us-ascii?Q?CwE9xphKqybpY+Zcb8gU1Ia71iOB5XjiZjGTFhtVVuC+cxN5BOYn5ViLO89G?=
 =?us-ascii?Q?tid5m5QSrpotGGt8/hjGjsubvPw53N/7LSx/ol9f6OpD?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c31f66ed-9e56-498d-427f-08dad7eadb07
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:52.6489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuxQfMtisZLf1IBPBLVIUP/nly/DJ+SyzBPz/vncopWWDkIvTEA3aJTM9LvgRa31onTLcaDNQd9XPm0AnV33wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3819
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
must have the cc_mask.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

Changes in v2:
  Implemented hv_tdx_hypercall() in C rather than in assembly code.
  Renamed the parameter names of hv_tdx_hypercall().
  Used cc_mkdec() directly in hv_do_hypercall().

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 14 ++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index a823fde1ad7f..c0ba53ad8b8e 100644
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
@@ -604,6 +609,9 @@ bool hv_is_hyperv_initialized(void)
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
index 8a2cafec4675..a4d665472d9e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -10,6 +10,7 @@
 #include <asm/nospec-branch.h>
 #include <asm/paravirt.h>
 #include <asm/mshyperv.h>
+#include <asm/coco.h>
 
 union hv_ghcb;
 
@@ -39,6 +40,12 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
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
@@ -46,6 +53,10 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control,
+					cc_mkdec(input_address),
+					cc_mkdec(output_address));
 	if (!hv_hypercall_pg)
 		return U64_MAX;
 
@@ -83,6 +94,9 @@ static inline u64 hv_do_fast_hypercall8(u16 code, u64 input1)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	{
 		__asm__ __volatile__(CALL_NOSPEC
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -114,6 +128,9 @@ static inline u64 hv_do_fast_hypercall16(u16 code, u64 input1, u64 input2)
 	u64 hv_status, control = (u64)code | HV_HYPERCALL_FAST_BIT;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	{
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     CALL_NOSPEC
-- 
2.25.1

