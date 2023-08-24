Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F334F7869AA
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235950AbjHXIKb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240542AbjHXIKU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:20 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6719AC;
        Thu, 24 Aug 2023 01:09:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOVCvzJ+0ucAjfikJdj+Q5KOt5gU8MiyvLc5rsxx9/lv8OjO34/5f8RcoPS1EDVMyBS3xMjK6MuYwZUd7N7QoQ10u7QbS262q+J5n0WI6HYJ9VShpLQZtiFKFw/pcg3j54SP2vdfJiz/J9kXugGSespQaTsKwesJkj1Lyg2dY2gQO4So0wVoCiFxxkLewb8kwRTXg79dbp257qQoEgHYbnsHGDL4V+GqM7UGeRtc9OMSW4rOXLaq+O7TH6Wf5Jr9IYU/PqFMdxZo6LP0mKUDLX1tOufJjQjBjCagG0woLDgRQHLSC/oOpCFpSSpmk8B6qo5Gaps9CGYS3+6FIgJ9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gp++m1rz7QMhIaw8w5ngvgVSlt7AgJlBNmZNhW7QHzM=;
 b=DZUGmX+xOthLZ/n83Sue4qC308Q8a2TEHqs2DmFn6TCwfB1hVKpjYg2IWy+LWavkOYnOREeCbGm0ALSGYr3d2n3BNcCUAR7Vvuv1pK8/MCUNP4eolkiO6jH2JVu8IMdFEy+Y66/HEJVAPe4+zZDCAh8fiM9LvlveDikvRADhzdXIRCtfUleBGxYf9bfGqvwm2q8Lrt9eIGx6at7s6A0q8XG2VZcAGNHn/AXyQGERrqr2D9ms2KLSqPgcc3eV86LWZ5H6hWPVjvdY5fH6ncS7sKhQLihEPy4sPLxIhNl9fR2yFnwozMTycQHZ5HcDzo7322FNwPZYcvuL202+gFgnbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gp++m1rz7QMhIaw8w5ngvgVSlt7AgJlBNmZNhW7QHzM=;
 b=h93XP77Epa6449FkgubZQaTpgwkR6yqPOaJs3q0nKgUGujyv3uoU7JntebCNTsJMZHmBTn2m6SzMnIQzNuQgHO5Ec8U7Z3Peo8dAcxcHs0fnjqvYgSj36VChuGvI/44k3XhcFZ4taeONKTiJ9i57mheJvrR+E49KlDGiWk3l38s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:08 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:08 +0000
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
Subject: [PATCH v3 06/10] x86/hyperv: Introduce a global variable hyperv_paravisor_present
Date:   Thu, 24 Aug 2023 01:07:08 -0700
Message-Id: <20230824080712.30327-7-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: adf33ea3-ae03-4408-ac32-08dba4794054
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: in5/snVR9j7QfwgGeCtVCOpkmneYIjgY6ux7vLRwS9tfPL0jr2uKzc8TpPY9RZL4dAwHmIX68brYNUELiPPOE4jOBSP8sUNN8LKNIGd2Y2CUCeToll/ulfZ0OT3Qxo2Lu9yY0IzIg3XzvByNGrk1v2WOaSmKuutKSvEXDLsR4tnPV4WANBTcKlhUOxYNC+E2e2clNhgr9IEy53msqSA1j6YoxTdzjwpRO2XtiOZcrGfduOizWD2DauS9WhigIm16UCYMI2yTbXos7w36N0O4tdSklt5PddR+uC3tp/JRDknQ0KweNAceDfGqitcgTBUysUd9xz5yEAn5NguGOwdyXyWL6Y/R1MCcWSiZ2OiRn9LZoj1+FifDmqqZGPSuaFjdG/OptdsQZLbPw8ql8KHLqYJn0DdBZ0o/5kE8xBkn3IgrfvvtM9016Jz2f9/6e8lwPYU9QfI9c/0ofaV136aqYBzLQBS0BGD4kij6uswoxEZoFOdPnC016TrccAJpPDbmd6dXXno6ycYlgpTrfQd0n0XptFtv2WTCuAog6eAyDA4rZTFMvA0+p+6fiRRDLmU1Xm2cF2K42O2vIdqmOr/Da6/c6/3/i9A3wKgW3pPG2fKvEhygX3zYOkVYX8KSxpweuBAzINWhJcT6t83x/hNeKSebaAMPfWj6BJmtdyCUkE9Df+6DMDpibOxdNg3bd5OZuZL6c942ZacYxAizr6AkoGSXAbATskae88D8UMvxhSvZUMoy1cXWmCYbVRWSjllD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(30864003)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001)(334744004)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXf4iT+l9uRLwV/W2r2zblZu6DEdh9jBVGcFPpGxhw2qvWe5zRgq8iBJzZTh?=
 =?us-ascii?Q?SBu1tUnSIftd7GCCl12WZWgQOC5NHXQUyr5pOKe6LPRRgmouEaDRXBPDqeZK?=
 =?us-ascii?Q?E78Anb65jXk6tyj8N5Mb+w85zDUF2dAXykqQbxeXhOlxQjnxsLwbqtx5H8ZB?=
 =?us-ascii?Q?AjQAfyBEqM6bJhhgRI+nyg5aRoqT7SecAHqXBjR+mYwLt7/y6ivPtYGsh053?=
 =?us-ascii?Q?olherjmvVeG0idas+YzRN6uZkmM5KK6cP/L2eg06GToA2W/rmPM07nZK11A3?=
 =?us-ascii?Q?RC+RvvNyYdDu/bS13foJSxslrd320BYiufMo6dhSPcxt7gMWrBy3bi6KPiEW?=
 =?us-ascii?Q?VnfhuLmzEfLbgmMBfciyeBsIWw64I9Dd47ElJOBYe9GgBCLLqdvNK/ruoff+?=
 =?us-ascii?Q?asUL4IDgn9OV/lDxXlSOYYu6ceguJGcYowhwxQtho6mbjtJcE+r/h3koX7bM?=
 =?us-ascii?Q?/BeNh292/AfPBQigC0ckrmV6cHg8TJbuPj3dN7EVaXOdqsyROMbM4WyIJqDQ?=
 =?us-ascii?Q?WMCKS7PDVKpS80b5Awxsrk3bYSkjHdNWwKJOOy9JjPLFMv0mZIyKKHxwwfPE?=
 =?us-ascii?Q?IOEnbySYbvdPfrBfMDei/q42YloebupjoRonNf3C/eT8n84HefxTXxNk/Ivr?=
 =?us-ascii?Q?JWHqGGfG+61BE5UMmNqJ20mkiDo1ZQ1k/PKYknKdWvxa709H6eweYygoaUBz?=
 =?us-ascii?Q?L1JIqYFmkaoH/9vJihIkGe2ssc8aqoT1LKtwJR+pFnZoXX06ZXbxtGHeuIiQ?=
 =?us-ascii?Q?rcOsK+oehEC6534Hx5RO0goXrzaDnA21vR1t9zf1MZT9e5TGA2iVDzi7ZsQE?=
 =?us-ascii?Q?FnpvJiNNCMOO7XQ1sugvGuH4QJHk4P5rYZ5sDuiMOCdF6trHJM7bwkvG2xuR?=
 =?us-ascii?Q?zyt5bNCYPBDQyL6X3gsi4YNJnk4mb9I2hllU2RUlo0zku8Tkstk1gGnGzg71?=
 =?us-ascii?Q?kmxnKv3MEeZC99kt/ZKgmtfvuwOuVWa4/Xx4geUnomkdZHQExPjnZHtal5zT?=
 =?us-ascii?Q?dvUvxKc5LJ69Cry7Lt7A1emw7NWNPyD+koP+Ealzxztd9v08v43b/nOZo4vI?=
 =?us-ascii?Q?W/sUsZ8QF5VSofqjiHUOL/z0Xd2VWQZ05S9z6CmMOB9bxdnpCaHTHQNlmg+w?=
 =?us-ascii?Q?d14UOPPr3vZnkoaxLM8duTdkX/E1ZIh7ho10nnN5xVuj1n3rD8f7CVx/Ae6w?=
 =?us-ascii?Q?5hr6QWZBZX391btMsi8VEdGaWZWaD6/NpURxP1r481x/NodNVBn7hHxX9Dqv?=
 =?us-ascii?Q?hl3butIFipeer0971yUU94oMJe1xa5f7LnjkcKpcz50oC8hAAZiGvtLt6Ogf?=
 =?us-ascii?Q?UGiGoIulG587+9Ei3KWpOfilhmILIJrNRe+rbsaOn+nsYb+XhHu6PrH4ww0S?=
 =?us-ascii?Q?BnUfv8mxOlRTZnAcD7K3gXl/FAFkFe5Q4ytwWIa2RVnV+KMaDI/9pb+bqrnA?=
 =?us-ascii?Q?EXZheDobMGZfVwsdR2RwW7z7G2hZA5EvGplgNuf4xdzBdcXGfHODI15dgGYw?=
 =?us-ascii?Q?mLi2QZKXvTy18hHLvsmf195Mp/WpFGmbmUrfVPzwvS1t1Z2F2ZGvFihmW5Ji?=
 =?us-ascii?Q?lQ5vdNzqLD8FNcQo3puFVAkbkdnQR+YjkQDkwZdS91JrW9jkLPBn7qn3EG0u?=
 =?us-ascii?Q?Q57ajKSnOt5yS9SiJQjrAQKXgg1KVqQmS++CjnjJNNlQ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf33ea3-ae03-4408-ac32-08dba4794054
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:08.2751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wf+2ehr+UBHuSqyEkDzZApAAVwberNmev2LOTRNFhtlYdxEAoF4UkUETyGCCFwS1NPCqXZj9b8Uy30r+lUeisA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The new variable hyperv_paravisor_present is set only when the VM
is a SNP/TDX VM with the paravisor running: see ms_hyperv_init_platform().

We introduce hyperv_paravisor_present because we can not use
ms_hyperv.paravisor_present in arch/x86/include/asm/mshyperv.h:

struct ms_hyperv_info is defined in include/asm-generic/mshyperv.h, which
is included at the end of arch/x86/include/asm/mshyperv.h, but at the
beginning of arch/x86/include/asm/mshyperv.h, we would already need to use
struct ms_hyperv_info in hv_do_hypercall().

We use hyperv_paravisor_present only in include/asm-generic/mshyperv.h,
and use ms_hyperv.paravisor_present elsewhere. In the future, we'll
introduce a hypercall function structure for different VM types, and
at boot time, the right function pointers would be written into the
structure so that runtime testing of TDX vs. SNP vs. normal will be
avoided and hyperv_paravisor_present will no longer be needed.

Call hv_vtom_init() when it's a VBS VM or when ms_hyperv.paravisor_present
is true, i.e. the VM is a SNP VM or TDX VM with the paravisor.

Enhance hv_vtom_init() for a TDX VM with the paravisor.

In hv_common_cpu_init(), don't decrypt the hyperv_pcpu_input_arg
for a TDX VM with the paravisor, just like we don't decrypt the page
for a SNP VM with the paravisor.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

Changes in v3:
  Improved the changelog
  Use ms_hyperv.paravisor_present in general and only use
    hyperv_paravisor_present in arch/x86/include/asm/mshyperv.h
  Fixed the build when CONFIG_AMD_MEM_ENCRYPT and/or
     CONFIG_INTEL_TDX_GUEST are not set.
  Updated arch/x86/include/asm/mshyperv.h accordingly  
  hv_vtom_init(): Fixed/added the comments
  Handled the TDX special case directly in vmbus_set_event().

 arch/x86/hyperv/hv_init.c       |  4 ++--
 arch/x86/hyperv/ivm.c           | 38 ++++++++++++++++++++++++++++++---
 arch/x86/include/asm/mshyperv.h | 15 ++++++++-----
 arch/x86/kernel/cpu/mshyperv.c  |  9 ++++++--
 drivers/hv/connection.c         | 15 +++++++++----
 drivers/hv/hv.c                 | 10 ++++-----
 drivers/hv/hv_common.c          |  3 ++-
 7 files changed, 72 insertions(+), 22 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index c1c1b4e1502f..eca5c4b7e3b5 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -658,8 +658,8 @@ bool hv_is_hyperv_initialized(void)
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return false;
 
-	/* A TDX guest uses the GHCI call rather than hv_hypercall_pg. */
-	if (hv_isolation_type_tdx())
+	/* A TDX VM with no paravisor uses TDX GHCI call rather than hv_hypercall_pg */
+	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
 		return true;
 	/*
 	 * Verify that earlier initialization succeeded by checking
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 6c7598d9e68a..7bd0359d5e38 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -248,6 +248,9 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 }
 EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
 
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+
+#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
@@ -368,6 +371,10 @@ static bool hv_is_private_mmio(u64 addr)
 	return false;
 }
 
+#endif /* defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST) */
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+
 #define hv_populate_vmcb_seg(seg, gdtr_base)			\
 do {								\
 	if (seg.selector) {					\
@@ -495,15 +502,40 @@ int hv_snp_boot_ap(int cpu, unsigned long start_ip)
 	return ret;
 }
 
+#endif /* CONFIG_AMD_MEM_ENCRYPT */
+
+#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
+
 void __init hv_vtom_init(void)
 {
+	enum hv_isolation_type type = hv_get_isolation_type();
+
+	switch (type) {
+	case HV_ISOLATION_TYPE_VBS:
+		fallthrough;
 	/*
 	 * By design, a VM using vTOM doesn't see the SEV setting,
 	 * so SEV initialization is bypassed and sev_status isn't set.
 	 * Set it here to indicate a vTOM VM.
+	 *
+	 * Note: if CONFIG_AMD_MEM_ENCRYPT is not set, sev_status is
+	 * defined as 0ULL, to which we can't assigned a value.
 	 */
-	sev_status = MSR_AMD64_SNP_VTOM;
-	cc_vendor = CC_VENDOR_AMD;
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+	case HV_ISOLATION_TYPE_SNP:
+		sev_status = MSR_AMD64_SNP_VTOM;
+		cc_vendor = CC_VENDOR_AMD;
+		break;
+#endif
+
+	case HV_ISOLATION_TYPE_TDX:
+		cc_vendor = CC_VENDOR_INTEL;
+		break;
+
+	default:
+		panic("hv_vtom_init: unsupported isolation type %d\n", type);
+	}
+
 	cc_set_mask(ms_hyperv.shared_gpa_boundary);
 	physical_mask &= ms_hyperv.shared_gpa_boundary - 1;
 
@@ -516,7 +548,7 @@ void __init hv_vtom_init(void)
 	mtrr_overwrite_state(NULL, 0, MTRR_TYPE_WRBACK);
 }
 
-#endif /* CONFIG_AMD_MEM_ENCRYPT */
+#endif /* defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST) */
 
 enum hv_isolation_type hv_get_isolation_type(void)
 {
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6a9e00c4730b..a9f453c39371 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -42,6 +42,7 @@ static inline unsigned char hv_get_nmi_reason(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;
+extern bool hyperv_paravisor_present;
 
 extern void *hv_hypercall_pg;
 
@@ -75,7 +76,7 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input_address, output_address);
 
 	if (hv_isolation_type_en_snp()) {
@@ -131,7 +132,7 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, 0);
 
 	if (hv_isolation_type_en_snp()) {
@@ -185,7 +186,7 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, input2);
 
 	if (hv_isolation_type_en_snp()) {
@@ -278,19 +279,23 @@ void hv_ghcb_msr_write(u64 msr, u64 value);
 void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
-void hv_vtom_init(void);
 int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
 static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
 static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
-static inline void hv_vtom_init(void) {}
 static inline int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
 #endif
 
 extern bool hv_isolation_type_snp(void);
 
+#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
+void hv_vtom_init(void);
+#else
+static inline void hv_vtom_init(void) {}
+#endif
+
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
 	return (reg >= HV_REGISTER_SCONTROL) &&
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index fe5393d759d3..4c5a174935ca 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -40,6 +40,10 @@ bool hv_root_partition;
 bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
+/* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyperv.h */
+bool hyperv_paravisor_present __ro_after_init;
+EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
+
 #if IS_ENABLED(CONFIG_HYPERV)
 static inline unsigned int hv_get_nested_reg(unsigned int reg)
 {
@@ -429,6 +433,8 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.shared_gpa_boundary =
 				BIT_ULL(ms_hyperv.shared_gpa_boundary_bits);
 
+		hyperv_paravisor_present = !!ms_hyperv.paravisor_present;
+
 		pr_info("Hyper-V: Isolation Config: Group A 0x%x, Group B 0x%x\n",
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
@@ -526,8 +532,7 @@ static void __init ms_hyperv_init_platform(void)
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	if ((hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS) ||
-	    ((hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) &&
-	    ms_hyperv.paravisor_present))
+	    ms_hyperv.paravisor_present)
 		hv_vtom_init();
 	/*
 	 * Setup the hook to get control post apic initialization.
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 02b54f85dc60..2dd972ca85dd 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -484,10 +484,17 @@ void vmbus_set_event(struct vmbus_channel *channel)
 
 	++channel->sig_events;
 
-	if (hv_isolation_type_snp())
-		hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
-				NULL, sizeof(channel->sig_event));
-	else
+	if (ms_hyperv.paravisor_present) {
+		if (hv_isolation_type_snp())
+			hv_ghcb_hypercall(HVCALL_SIGNAL_EVENT, &channel->sig_event,
+					  NULL, sizeof(channel->sig_event));
+		else if (hv_isolation_type_tdx())
+			hv_tdx_hypercall(HVCALL_SIGNAL_EVENT | HV_HYPERCALL_FAST_BIT,
+					 channel->sig_event, 0);
+		else
+			WARN_ON_ONCE(1);
+	} else {
 		hv_do_fast_hypercall8(HVCALL_SIGNAL_EVENT, channel->sig_event);
+	}
 }
 EXPORT_SYMBOL_GPL(vmbus_set_event);
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index d1064118a72f..48b1623112f0 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -109,7 +109,7 @@ int hv_synic_alloc(void)
 		 * Synic message and event pages are allocated by paravisor.
 		 * Skip these pages allocation here.
 		 */
-		if (!hv_isolation_type_snp() && !hv_root_partition) {
+		if (!ms_hyperv.paravisor_present && !hv_root_partition) {
 			hv_cpu->synic_message_page =
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_message_page == NULL) {
@@ -226,7 +226,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	simp.as_uint64 = hv_get_register(HV_REGISTER_SIMP);
 	simp.simp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (simp.base_simp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -245,7 +245,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 1;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition) {
 		/* Mask out vTOM bit. ioremap_cache() maps decrypted */
 		u64 base = (siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT) &
 				~ms_hyperv.shared_gpa_boundary;
@@ -328,7 +328,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	 * addresses.
 	 */
 	simp.simp_enabled = 0;
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition) {
 		iounmap(hv_cpu->synic_message_page);
 		hv_cpu->synic_message_page = NULL;
 	} else {
@@ -340,7 +340,7 @@ void hv_synic_disable_regs(unsigned int cpu)
 	siefp.as_uint64 = hv_get_register(HV_REGISTER_SIEFP);
 	siefp.siefp_enabled = 0;
 
-	if (hv_isolation_type_snp() || hv_root_partition) {
+	if (ms_hyperv.paravisor_present || hv_root_partition) {
 		iounmap(hv_cpu->synic_event_page);
 		hv_cpu->synic_event_page = NULL;
 	} else {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 4c858e1636da..e62d64753902 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -382,7 +382,8 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
-		if (hv_isolation_type_en_snp() || hv_isolation_type_tdx()) {
+		if (!ms_hyperv.paravisor_present &&
+		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
-- 
2.25.1

