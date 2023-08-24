Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66077869A6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjHXIKa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbjHXIKB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:01 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6001711;
        Thu, 24 Aug 2023 01:09:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj1ZpUaH/+vfovkc7v6DTw+7yFV0k454JnZTXy2nmFkZ+W/SSW7EQzzmFoczvrCl/FDxzt4xnyYi/ukpuTxDJfDLe3Cd3J1DXE/XVxbba/bOnWk1ERpKpT3To6ZSEKpX4sBdNsse7Z/efepJ6WgDC3F0ha3V/QZgJuzMi2Fajrwx6x4JoDR5RFtis5W5UGH6OkPLk1sW929Bn0MaAz+xbYLv7ykikBFXyn1l56wdCiTl2eN1Wj1KIC3KHptYpNv0sWFrb+HNNIQvJnjBgOjOzAHP/Ww7Ju2c9kGHHMIykcJEeR9QNiYHgi8nmMJwJjJ7prgF8D/tzXLV+8OfG9E+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJO0dTUqrjmxy/9FRCN2EjxqSxtkuSOQhjpYPBOtZpU=;
 b=hrGhp8B6wI/TQgOXwrXf40YYhle67iX0eRuC058p35kMqpqx//FXzok8MRVe/UPG/Wo7haXqoJOrG0/gHa5VRPDQyl7hQxz9vOcdHgUXvia/cJ6sfnabK49d9wN5++UDH079iLOa2q708QnPh75xeAOE1oFlkWiLCyeoTFXAuXlXSCSsyL7o2q30L/ue1R8oX6Z2AWefdKM9MZfhB+cnuIkwbSH2/rcohHA1EE/DxCXSP5UAThvhyqoP/InxU1PjpWAuEg++BFOyGZTC8a9JTNCUhMicF/xerPtXdcTyspKv9csWTSqBkOznE0/IOF1Xd1LZqlbv5SFzX9YBbfYT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJO0dTUqrjmxy/9FRCN2EjxqSxtkuSOQhjpYPBOtZpU=;
 b=QKtB//cHNs9fhdrYZ3S1adTgQVCQuGDwLxZQumgCbkSgBOP+wRsSXtV5K5kiZ3smhcAiqZmliGsi4Ny/4BN/SAc7zi5Rqi6HKGQqphF4KRHJdLPdjrbRTkCtBvNTN3JM0ThXIQw23vMhgNaihA3XwRTijNFjdQqZMlCh4EWYv50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:07:57 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:07:57 +0000
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
Subject: [PATCH v3 02/10] x86/hyperv: Support hypercalls for fully enlightened TDX guests
Date:   Thu, 24 Aug 2023 01:07:04 -0700
Message-Id: <20230824080712.30327-3-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
References: <20230824080712.30327-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: f8633869-d7c5-4b39-a3b8-08dba47939d4
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXx7pIR4cwlCTpXilpMTujpRJBXzjSuBiAfpXSpp+IL/Ax5fzTwFasyRuf+4Fb2B4C+5BKd5pxyc6DHHdsSEl3lOvLuVZrTUsq3Mk4SGG58CkTOk4Pk6BHilwiCXC8YlnMx23/CluLosv068D70ayXw8u1kstdSjMnvlqZ7bIed6Pisk5Xuxvk6JDd64low1yGU/DfWWfj3vQjMdYT17KdeTY/35dpF9YtFe8+7EqEamhZm8zR8UAEFSzCkkbu/5hNjpBJYTSlinOkMbl98Icm3nasWrSKUxhETYIme0+TU2wXWSHcx0M5rTZbl0CSbPTuBPMi96JGseOx63YGoKIGQwK5YLhpFqTelf+tH1FbKCZYKrpu0YGktGCwRuiRjQ7S0M2PB9y98hxhcihSPaBSs/MJG8Tv1JBCmXVric4DonjlrIZ4KUGKKZahD51E8bdgDrhtp0gW9aHOiwCFgTU439R5OmlUiaZhMcrn8vgXlQe033uJmVVtNSHgMxmvytoRRqsCd9Vq7CCNPS3MGhCDVPhgvz8/Xmq6woQKJIa22Xo907PpPCpskgEmHVvxU/kiRcd0WKJ865j480oncS+Bpctt6ope1gWjGIE6QJaRWWtdD7+RJtsUkLANdz2L7xzYJ1RucP/O3nElsDGah2F5woO/3dD1INpLlvCB7gQQMlnl+FKDxDFd9526Y612Wb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(6666004)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKgVYUjQB1fQsC7UAeR3dBzcW/5NfN0Xvn59SclpXjb07wj8oEJDOrOAeJZY?=
 =?us-ascii?Q?tkWWcd90ABp1tmf+J5Z7JLrXMb0GXRMguBW4PUbU0fV7rPTyyfZnwILocKrD?=
 =?us-ascii?Q?keloxN7JNbcdTb83fbj08/9RUK8pZCDgoZU/3NaOspal1z7ajHfyhrFYiZKs?=
 =?us-ascii?Q?2GIhkSQDp7p8ONPz9aTj36uSBWMmismuQkQb7gCffPNSij24/dfdPcgFA5sv?=
 =?us-ascii?Q?tfQ5OQ2IR0C05ovM+EvqeyMRPACvTpM059jsZ7RRyT6U0JvX7ruay5pcE6ka?=
 =?us-ascii?Q?vOROvRwASDQJi9gc7d0qtY3z+z3oOl2sVKPFHXcgmtDJYWjtCTCbjSg0D5ZO?=
 =?us-ascii?Q?zSqSRlqpY7kFmKMKBACErr/VWCfK2W0ICWVemUjDjr8NT7el+8hlVQyU816H?=
 =?us-ascii?Q?3A4e5USu82xMRfjqVkTUmenwIF34J5JDJdT2C8lIFW8Wj9ZG1y+Ih8MW4l61?=
 =?us-ascii?Q?IahgIRnwDhuSSqcMRktnAdd4t0iH8AJ9i9BmpfHR3BJdwLwEaASNnIqxeIpp?=
 =?us-ascii?Q?7WG1GmG8BuHRRAZTVXbwTXtbLftjBVYClqlyf4VgmnBTu6+Y2G1wpdsEbeeV?=
 =?us-ascii?Q?QB3FJZPJMVSrtUSKoLhaaiWOW2j5aREGVt0REyItu/TyBlVh0MwRYtND+Qke?=
 =?us-ascii?Q?hTcuREagLj5uwzRwEdV5sscpNEM4sre7DKC142Xq/O3v8R4tqP1W5AX1XB4g?=
 =?us-ascii?Q?c18+rtdEC04MtHMlzD9HG/OJyxeoe8xf3KtM2vcAVq4wAdCEg/vKYvRx3OWi?=
 =?us-ascii?Q?XpCs3VFJkkJ9fvy1oXATVsUKlNd7bSghZqEvDFwGC4z+PXDFy7zUyr0gH3a7?=
 =?us-ascii?Q?39hEGuYmMRezjevETdnxpPDjuYVMx/oH2OKQ2bvTPDOK6VYKuAtnzjD5fped?=
 =?us-ascii?Q?xbPDAeMXRIPhFrRl2zZ1E/uBeeBbMjfX64mULyWTulbSQbZB3W7dIroDr4/5?=
 =?us-ascii?Q?NN79gDvhmPZBH4hO62V7H3JVWojWb5XUdh+MBoV0mP3EG72jGIDipudkYteM?=
 =?us-ascii?Q?VotC55mXZDV0AYKC+LMw4q1/g4tO4TL4NnGFT9gUmCq6KhqCNWl/jQ072VI3?=
 =?us-ascii?Q?ZmtrS/ujjV/GsdA5mgbuupp/hJyWCuL++Q4Gy9tU0o1oTqeE5wuX1G/4Coq+?=
 =?us-ascii?Q?KT1md0yexg8+IbHyCNNK6sd/5cWNMCGw/nxFm3wXAddjqybxZ43GI5lgwGy2?=
 =?us-ascii?Q?49oKgkFMZ/6rWJ99ifky6yRUTxLmtBXLYHblRYDzsgrPZV5CG6RuGZ+UIWzA?=
 =?us-ascii?Q?N9s9E5iTWcdilx3DXSRwDpc4mt4ZW/VhzC1TIWV4fwlzZwsC1OG2QId0Kv4Q?=
 =?us-ascii?Q?R+rswxcgM/kizyntKTbc9hxPK2OtBAn5NAK6g+8AQLERbG5MYYhyQ/HzTBs/?=
 =?us-ascii?Q?eB6EylCmFqepCyp08awCSVKJ3arR5r1nRzcveSbSOtGMKjc9ImTHYSM1nJqj?=
 =?us-ascii?Q?TjKnVg7igqG1aa7/BVZ9CSpK5a5MfSrk10MkLbSOjN3TkaXhE1Om0qr+s1Nz?=
 =?us-ascii?Q?782SOOuprk4eTpA+TP5GuGydaiQKEbZeMnBbStsQ7IekgZppDA2cfyX5ba95?=
 =?us-ascii?Q?SYqtlLG8uuIu/BarVRnb1msfWBvGRzjrYN/YX4HfH7dilrncjT6i5xL9Bftv?=
 =?us-ascii?Q?ykt7UWeggQJRZd7LJcGpUOe4lcW1Ms3A5FBd1lRC0MRd?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8633869-d7c5-4b39-a3b8-08dba47939d4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:07:57.4029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8hXF+yA6gwekYQKLTGDnjeqcVzFJiHcP/RDdpeARGXQnevwF4md6cmAz3+DijKbYz+Vnyjfh3jm5+W2Q35qIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

A fully enlightened TDX guest on Hyper-V (i.e. without the paravisor) only
uses the GHCI call rather than hv_hypercall_pg. Do not initialize
hypercall_pg for such a guest.

In hv_common_cpu_init(), the hyperv_pcpu_input_arg page needs to be
decrypted in such a guest.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Included asm/coco.h in arch/x86/include/asm/mshyperv.h to avoid a
    gcc warning: "implicit declaration of cc_mkdec"

Changes in v3:
  Added Tianyu's Reviewed-by.
  Removed the cc_mkdec() from hv_do_hypercall(). This is no longer
    needed on generally available Hyper-V.
  Removed the inclusion of coco.h

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 17 +++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 14 ++++++++++++++
 drivers/hv/hv_common.c          | 10 ++++++++--
 include/asm-generic/mshyperv.h  |  1 +
 5 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index bcfbcda8b050..255e02ec467e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -476,6 +476,10 @@ void __init hyperv_init(void)
 	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
 	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		goto skip_hypercall_pg_init;
+
 	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
 			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
 			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
@@ -515,6 +519,7 @@ void __init hyperv_init(void)
 		wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 	}
 
+skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
 	 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
@@ -642,6 +647,9 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
+	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
+	if (hv_isolation_type_tdx())
+		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
 	 * that the hypercall page is setup
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index afdae1a8a117..6c7598d9e68a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -571,3 +571,20 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
+
+#ifdef CONFIG_INTEL_TDX_GUEST
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
+
+#endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 3feb4e36851e..6a9e00c4730b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -51,6 +51,7 @@ extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 extern bool hv_isolation_type_en_snp(void);
 bool hv_isolation_type_tdx(void);
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 
 /*
  * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
@@ -63,6 +64,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+/*
+ * If the hypercall involves no input or output parameters, the hypervisor
+ * ignores the corresponding GPA pointer.
+ */
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
@@ -70,6 +75,9 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input_address, output_address);
+
 	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
@@ -123,6 +131,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__(
 				"vmmcall"
@@ -174,6 +185,9 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index da3307533f4d..897bbb96f411 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -381,10 +381,10 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
 			ret = set_memory_decrypted((unsigned long)*inputarg, pgcount);
 			if (ret) {
-				kfree(*inputarg);
+				/* It may be unsafe to free *inputarg */
 				*inputarg = NULL;
 				return ret;
 			}
@@ -567,3 +567,9 @@ u64 __weak hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_s
 	return HV_STATUS_INVALID_PARAMETER;
 }
 EXPORT_SYMBOL_GPL(hv_ghcb_hypercall);
+
+u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
+{
+	return HV_STATUS_INVALID_PARAMETER;
+}
+EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 82eba2d5fc4c..f577eff58ea0 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -283,6 +283,7 @@ enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
-- 
2.25.1

