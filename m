Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1322781FCE
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjHTUdL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjHTUdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:03 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7551F8F;
        Sun, 20 Aug 2023 13:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlVKpuhj6IXci/q0wYht+wdLGNrWXfdI66+fRduQw13s73OBdnUq/gp7w4+bjm0dJ35brYMqJO7fmBwDtlTdcrAfza8bq/joRajtCL5w6T7sr6hAfdy9JDx5lq1757TkgR4EnDQXPpKwECF5hXX7BTahBoqQERSPBTemKCZLZSK0wyMEujlLRdO/Ue58VR+Mn1LJGEtb7RLe5eoxslH0JoOO1onidaMbKBunMC0S75Dmuwl2pkflFzq+Oi9oCq4LWjeXkX5oYkpAjZX9AKGt+QL47bREPIsAALmVVA8YVq2ClKRUZgW4PFdJsUL4f3FWdwMl7kZ/huQu6X7VAYpzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCahY2jdvwB3iGIicm2L3sl8nCpNQcXped8Vwo9J+XY=;
 b=LnttHJtf9WlXmwGFiVGO1H+9XPT42H4lQ3C+K6h752iEDzepYuwNu9HgWAEqMwmXsi92VRWTK2rKe9+CWJDkCv44ENaspT35YIv442Up2WXKwlElOZ2KnkteHe5jEZBqeIXysDaoMzyS9o9gxI52LOQ86dYhxJ9kHDLtlU6WE+YBDICbxHCwgKnJFvsomhOXVqKNTdtXcMpunVBaHSoN0YDv3i2gPrX0bmevwgnlu4DLTgnhNcczY8+GJFjat06j2yQacdEFYvuh4rKQPEmDkzRdofrXaqOyVXaf2RXvijlfPeHEUaemcRoqFd4lxpeVRMldja95sZ2OnYGjyzLxmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCahY2jdvwB3iGIicm2L3sl8nCpNQcXped8Vwo9J+XY=;
 b=heXEPGYBVZrnPnxvCIhVeGW3UCpkCLkfBMljAyvVxrcNPW92bYW+04xVsE02hE1SjCD56gLbvH2B/mUaFLSKZ8Mdm5JNZJainGEkryZEcJhHyOACffFSUOjPnQ0tCc7kfbTPQ+vb6iOV2VpCT4DmSXppX8JS9t6anIsTBx6yHAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:27:56 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:27:56 +0000
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
Subject: [PATCH v2 2/9] x86/hyperv: Support hypercalls for fully enlightened TDX guests
Date:   Sun, 20 Aug 2023 13:27:08 -0700
Message-Id: <20230820202715.29006-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57119700-9981-4399-daae-08dba1bbefbe
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQOLZYPiU1KPqeWTHaE93CsTGoyxGHZ/nWWWyDkltEzAIZcmPkaShyF4COh3ZmxhA/8aEkkAUlYTJQTD/vPLL7tOC5I7Y+ub2BCZKAxwObL5U185lfDC6c8yeUl6UcgtVYYSZMjUjh5PzAoA15q6XroNncWocQJH/VE3NoUQn/mxLkqDaQ65dS6EmtQ4jwwgyZ8M438wOjB/mKfI67NUsdksqSBwYOpfr9jtsuY0rKmuAznb4z4yazAG/CYd31ZTkECkeTq9kSdYW/8mjwjV0UiE2mh84u6SSxEVZhYVnjxGurPu2ZLJ0gwzRDyadRUd2PTxA8LbeSQzZaCVFaH8KcsHmEnRVmGld7XOYwj+YKgsc5/maiw2zsYO9ug3/61qYqKA48Vq0a39vOIpw4mriRT8IWaba0UEHWViWtSvQEpzJQvC0gOQhj4BmrVcBXVQ9hlxszmYNjBpG4RtUcJdNsRaiww4Y2afiDT7DVbp+H5zem5qvJbEOjkjvKiczaZqVnjfkdaJkyqgvzCMaDwaFIeBnw0NvZvi/Fa3OLl5VN44zkZiwUGW7EpwjrodmmbowRFxLrYzkgmdXSMHfXKSduHMzlRMo+m9pfxr09NoNFpHNYVpFXxolWkDGlP5DrSefguPrVkGmtlJVjk4wOfiY7yAbAcH4BDMQsNR4uHcNJ0um4Z5kn4O9eFcrqsWBSvI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pDWTQHcQsm2Q99FnyQEdTDR+UEqWGQjAmu3cvUhwxXpaXcGD0GMqnDZV00ik?=
 =?us-ascii?Q?yOsiy9YS8dZEeFLQD6i2ceOLTRLuDDPirwgiFBiIaqpHE+qr84Dcua002jJD?=
 =?us-ascii?Q?go0Vn2SJfdZhI4Lj5C/AlBZsBSrOM2uTsDlG2TAw6nX9HVC0aoapwGOTKDqI?=
 =?us-ascii?Q?5jUJQ4RUIy6I2Kv3fn5aQHi2Ut9sSy5P6lVhCIEDJbM1S2PxCyHTFA0bMhmh?=
 =?us-ascii?Q?xSJ4hc6KmazzVLahMdaU+Rtvk06zj5p4S2Bwqr3qEgBkiGHEC5BtkwpNvEtt?=
 =?us-ascii?Q?4kv9DRn0EHXc/OOCu9RT/PIXh6a/IVhcF/Ou+EuJd/R1Drc25S/79IomEoyf?=
 =?us-ascii?Q?USxXExfEkS/875C5Wx69sRWDX/A+b7GAcUhI1jgh7W7wLS21uw8oQkA5H7ZO?=
 =?us-ascii?Q?Xl2r40mb/Gh6eoVMeJY4v66jCBeGiU1xPYyMLwt1GUPhTdikpiL0GZaxJE0f?=
 =?us-ascii?Q?fM6rqGoKyOkf4SjC+Idq5iVuzHKW1feGeolMD2Im4T6zN+qCKIZCmkZpLrfc?=
 =?us-ascii?Q?Ysufa/HXeGugx+yupcnooY1i1LHaFGEohkqqXpJ8Vp54aHJ0Iye7n29zdkam?=
 =?us-ascii?Q?e07CcgKwYYAWyU48DuZ8DPvwyXaEMbtCxHCV1Bdb2GBcvYFDJq+TbAav/M8o?=
 =?us-ascii?Q?nCIvK8hsn4xe/lzmie7L39BUTIehr3TS26zEMFt0dYrYP56bYRxwByNCLnUC?=
 =?us-ascii?Q?ThSDKh4IgxJrjpLA/KBFK4Roc4kWxSvWCbEZAdlq419k0e2nLxlAE6m7kRBA?=
 =?us-ascii?Q?+6xAnGgghKpZsK3kRI0ffkHVvbFMV4zZFLXMND1Ky62Aq/vu3H+fWt/6HsMN?=
 =?us-ascii?Q?eZp0FY79+j5jI2pwomcBxYf4MD4aod3zFAJK2OqjR/UdViJ7t5Xbofntbv15?=
 =?us-ascii?Q?xEfe8qeUBUdJ7ALpXnpFUQKTdZuPnN4lHwyWbZzjb0bTrAQQJTZXRN4j12mf?=
 =?us-ascii?Q?YaAGZM7ca2nMOj61IQukKxisUrdm2hW/VIYbleRJywWXqyvsF1HZl2q/TK+i?=
 =?us-ascii?Q?1CQ7dzbDJE2rT8q494hQCQNQtKqO0BDioKFCDIIHbBOhgAVck3kYs6OxItK/?=
 =?us-ascii?Q?STeeQ3BLPOAaBmKPx5B+APxN0AjTCj+LtAI4FhpRzC/Z+MWXJj8Cj0lVV58K?=
 =?us-ascii?Q?SZE/ZfdgsbCJtPEliyHSbXf66WAcqrdWO2CR4c4cu1TQdKbf6BHq+TX/A62q?=
 =?us-ascii?Q?d13hGIIHI3X49G9cLUZhj1ihuMosIvKghJm8mg+b9MxfGnElAptFTPXxi0MQ?=
 =?us-ascii?Q?2uBLRCmXXV1L2Gi4Xd/M/jx0SKggBBQJ4AVAsO+u8Z2D7Kcpg32QUnLPyN+d?=
 =?us-ascii?Q?Ft6FeZaI4cpxY3UmcY4WJn1AXPQFYRBXZnB1GJl7gnYRMwmSXF1G9stJ/LEl?=
 =?us-ascii?Q?Cw0H9wUwJWfQLyq7D3N35vmDNNF8ZmnanbZ8buGlLmCVlN0ueXc/K8moNxFx?=
 =?us-ascii?Q?HJPKFIhpmgqxkpH0mJHoMs7FHWW671kvDCukwsrZLQF/ATM0F4Fnxl4K95Rk?=
 =?us-ascii?Q?pmDbHW2k4SmFTBNyE0tLuwPTVi02o2zv5AcnMAUeMaim7ts5DHSrAq769jEx?=
 =?us-ascii?Q?yL6dRJO4ryS86q1hMU+7pL+g08ktL2Yj1PF34j82fYmHwhisnmxMiL2IqWDL?=
 =?us-ascii?Q?qMk1f7ouFGtJPuqGRoTXzA6BPgMCTp5eo1vRzRcIdzF/?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57119700-9981-4399-daae-08dba1bbefbe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:27:55.9186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /i0b5Y0hXfBDNbWWZGmlnYXpGUmtDmkYUH4vJzdxGn6OqEuOzbLriLxX/Fk6PQn+jC7jSTa1/qj8OOlU+cvA3A==
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

A fully enlightened TDX guest on Hyper-V (i.e. without the paravisor) only
uses the GHCI call rather than hv_hypercall_pg.

In hv_do_hypercall(), Hyper-V requires that the input/output addresses
must have the cc_mask.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Included asm/coco.h in arch/x86/include/asm/mshyperv.h to avoid a
gcc warning: "implicit declaration of cc_mkdec"

 arch/x86/hyperv/hv_init.c       |  8 ++++++++
 arch/x86/hyperv/ivm.c           | 17 +++++++++++++++++
 arch/x86/include/asm/mshyperv.h | 17 +++++++++++++++++
 drivers/hv/hv_common.c          | 10 ++++++++--
 include/asm-generic/mshyperv.h  |  1 +
 5 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index bcfbcda8b050c..255e02ec467eb 100644
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
index afdae1a8a1177..6c7598d9e68a3 100644
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
index e18c6c8f4fba8..24d7f662a8beb 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/nmi.h>
 #include <linux/msi.h>
+#include <asm/coco.h>
 #include <asm/io.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/nospec-branch.h>
@@ -51,6 +52,7 @@ extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 extern bool hv_isolation_type_en_snp(void);
 bool hv_isolation_type_tdx(void);
+u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 
 /*
  * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
@@ -63,6 +65,10 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+/*
+ * If the hypercall involves no input or output parameters, the hypervisor
+ * ignores the corresponding GPA pointer.
+ */
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
@@ -70,6 +76,11 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control,
+					cc_mkdec(input_address),
+					cc_mkdec(output_address));
+
 	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
@@ -123,6 +134,9 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, 0);
+
 	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__(
 				"vmmcall"
@@ -174,6 +188,9 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	u64 hv_status;
 
 #ifdef CONFIG_X86_64
+	if (hv_isolation_type_tdx())
+		return hv_tdx_hypercall(control, input1, input2);
+
 	if (hv_isolation_type_en_snp()) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index da3307533f4d7..897bbb96f4118 100644
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
index 82eba2d5fc4cd..f577eff58ea0b 100644
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

