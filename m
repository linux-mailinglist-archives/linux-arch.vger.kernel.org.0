Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8597869B6
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjHXILB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240544AbjHXIKr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:47 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469A61BD0;
        Thu, 24 Aug 2023 01:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJyCe1YbLRUp/cndihMMTf2C50jWIMu1HnHj/4TSlvMY587YizPUva+q9QFrd2LI6OM88Ixi+QWFrnCJqSAz8eL6sJz3n/jIzah5264n4yzMyyziJNArn+bH1HPZvE5uEPJw/Y1jEh2RpcgkvG6h7DLr55VaC4WoXYG5qfPP9ZiQuFsxOppwGFcsMPKQxC31odmoxqBmbyKv3jdmWQ7chC7T8aWo8FTiyRkYRdPX69+jQ9sxjsiA1hDYtda8frBEWx1ysyyreZTtwX/qQPLoQiRvrDy31jPdbZUwYoTk7BmC5AK1cg7Nddvmqe1eRbyewhVC40is71ijh/cT7l4vCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyznhn3nWPaHh7DRBjzUhjZDgDz+gcQMYl9lzdh7di8=;
 b=K4uBMJ8CuJqCiIa/mSNRLG2GEPQkpktdvPg2z/1wZZL+TDHr0BGePLPVIA63cgskr56YX275ULIMKcnfgF2EdkZ8A4NALtuFpCgJeFhb1DrhV69uSPhl4JiU1fDsKSY8OxO6otQBwWTlbjaeIY/aqJrcFWmDJqEmJMMmZAHfvvw7GBkxDwm6PYPD+cN/UXDxHHrQU5Wm4H4iLxBlc+S7NPhdJ+TkPFqsb4l0S3UYSUVrQodkahFkbOlZFLfoFAs8oesBcaPMdq3gSbN84XDNb2CwC2IeI4PiqhXShD8RNmMPDVWxO2yOJGtdbXQpElPtcrj+E1ye8QLu2LOEu9Az1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyznhn3nWPaHh7DRBjzUhjZDgDz+gcQMYl9lzdh7di8=;
 b=NIfjKWrMV+RrXuZomC7UvVQ00RwVgn4ITdn8k+SsFTOtSrtTS4g9GCYGc7O6Vg0X2nTB6A5sxCxMIy6a+SRmIie2TdOR3YA7m4rTUrCbRNpM0jxjAr/qRvlHMB4XyINm1Si2hQn01N9en6GaQf+xz2njhm79+ORlv64nd3onSrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:13 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:13 +0000
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
Subject: [PATCH v3 08/10] x86/hyperv: Use TDX GHCI to access some MSRs in a TDX VM with the paravisor
Date:   Thu, 24 Aug 2023 01:07:10 -0700
Message-Id: <20230824080712.30327-9-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: bcda9c3a-fc05-4b51-4e39-08dba4794392
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cnx+GtKw50uW04497evVHn9uUkCz3y5SzmyJbaqMHiZoaGHBjeC9ns9+AVlR6jlL3kcY1pMCN/cJaXa4IL9hYgw+c52J28AotY3Bp1DgQLrpaH0Gl9fl5sxpHW16WbZ8jGXX9OeDdzccBRImZ/Tk6+tdXJ6L1iyO0W3FJBeBsYw/9WFKZNdxLXAsbVenbRiY1fbSNsPlOXgxVXSZmirhubw8fbRjI6k96wclXGbt7sCv6tKoartpFo24VMk6Otqt//QeLHRd48Uv9aory+oJ7/YpWtjxc8lwXGgD55fHfPWqyWZW60GPohcbr7FK+U0brzNEDryAOb/pE+RRuRECarbo6lKB3DeUu/flQCH24ruMMCqYDD683OH03W+AloXHiX5K3JyqCFohbL7YvytelEWgTAPoohjem8b3v824VMszHEibvwOhzAlbp443yfcqjWlBTYBLsTRx2gVglHdS8wodMxPV1O71xhsm89aD4dZrHh15+y5s23ImbjiFZg+l/4wzbC49NrtGlTbtzl7BO9QbXattf2HQvhF5ZElZkgAq/NuvtkU8o+zqH7OhqC3fHtdQUzu8fNp1A9eVsvB/ifEqdjC4ceqMMa4bMqIJl+j4j3OZHiMH4a1oqhMGdrW49IkPo9dIUe18z7B+s00mnLqzbcMd7gWFYmdxDvGkgLkjOLrfwux17Mschf0oxnCL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CNrcuWd+6pjNSYFwDsF0vEccDMX6fwZoSDQ83UVlX9OVbVRpu4EAWsYanz9?=
 =?us-ascii?Q?s8J7C+LulHODw03GHmupsAPGiwt4xeTkfBUjbCBhdlaq8o13wM45O+idh84D?=
 =?us-ascii?Q?5VwdoPWAwUeydIYTIVbHrVfL37hMmxwoOO0xqVHRQ/59vGZZBbE0MaX6a+zA?=
 =?us-ascii?Q?uGgd2yjEoeyDi9V5p0JEVspFuqGDUF3l32xCOGBtW/ZszQW6NpWsj/cMXM7v?=
 =?us-ascii?Q?nbn8/mGvZMlWcQoziEWw62aETIi5JiP9tDrIzGwtLLomUDCHbpNDEI3/DZV3?=
 =?us-ascii?Q?zNxVBKNNE3BU0XNLO5zKe0K1T/Ynm6VnBo074eMZxlIyhhYMMf86a846soFT?=
 =?us-ascii?Q?BMYLXq+B4or5RhPLE/PxuAOH9rxwuD8F00KNUJGFDUQOoa5xmIEykqABb+mm?=
 =?us-ascii?Q?6eU0lN6ZtkACYxgucRycyMqxcltU3NvTu6lDyUF9W0y9jeZl7vXwUUm58CWf?=
 =?us-ascii?Q?VQ/Hj07myQ+FX1iISrv2l10NBQt4rBl7M+k9yDXQt9Wt5egLF6tyfnje6ZR+?=
 =?us-ascii?Q?KM7ZC/GW7oNiURTdWOwRZFjk6pR+loSiFAfzTqo2LKoZ3rwmW1RGt3CxRGTY?=
 =?us-ascii?Q?gcBO6ObZsNZr/NMQLy1m4n5xqYpODudlAnoGV9R7kg6UGtJXEuEAiCmCWnut?=
 =?us-ascii?Q?ZaXTer2JB3wAcZ24iNeSSXNcSr7g/zYKsE4QhPB9NCsedUFR3Ku6W6C9gH5/?=
 =?us-ascii?Q?h39HnWIiO4gxTpE88bETzSunX5u2zMkgVynkF4iSiYYbVjPzRvr/67vHVclK?=
 =?us-ascii?Q?af3DJ3jKkWvel+SMiKKdt3kfr/5TPr1JhI74Ap7CLiXlPF1QAKlAP3NnKQND?=
 =?us-ascii?Q?D3yBPKFhnn3QEo2y4EzaFVYs/zt54Os53r2SSGR1xAw0LW5kLsfkcei1mZk2?=
 =?us-ascii?Q?m9FyKjCfSzfoZw5EN9kO6rJDmPqTmcO8T6CaYs5To5KOGU2yD2pUYuRP/weO?=
 =?us-ascii?Q?V/UElpz58i0NCwMeDESs+al8kkfGisBM5z0EWaY4lRiUyZlM9a8VWIZTFlVe?=
 =?us-ascii?Q?faWMS/P244PhmOlZf+VmLHiEMYThtoYqZobejygkZ3v/lAHTnBB8Ew6Xa0Bf?=
 =?us-ascii?Q?0Lk9/4pyDvCOCCXst4pRByMKBRigsyfgOg28waEh34i8j1axV+iJOqKqbmPH?=
 =?us-ascii?Q?HrCQYUqDaeAB0d8PfOaJF3mKNMkQFceHDJUADPNYeBMo4E/hkqVZgHPzCntA?=
 =?us-ascii?Q?0WR/EKHebb5Pc5W68F48MqeFHC06tC/VPXcXa4O70rX5fxcXwKAv5KtEvL8O?=
 =?us-ascii?Q?3j0cL9p8pdNXoLSH4j8m06B8suj56HIY9dURFPX4iuVXXu2S8cSfK+98mT2i?=
 =?us-ascii?Q?0c61gIpccmv2MrcX3IgVlreaAUbl5W08MW/KUHk385m6MYMQjySv0Sg7jbem?=
 =?us-ascii?Q?vVkb6Bt/Mbsjyvy6uHq/ZXwGS/9HMYwOypfm1IEWjQakfC6iNZm9H4rLKzNP?=
 =?us-ascii?Q?oXLdzQZ6y04qrsUjoY122HXpQ7kpdhEydlk1J6L2ZEjBw9VEiP+9WjqqyOY8?=
 =?us-ascii?Q?OB2D+oHcBt0AuS7PPUQJeEWS972dPshuzt6QY25SuDSBfJBFgJDj3nviTpjX?=
 =?us-ascii?Q?c5tUJ5haLHKMwoO5HPvNahtXqxMTY4CvrUCUffumV04dPfEDlTPK7DWiFvXb?=
 =?us-ascii?Q?rjbo0VLxxm/F0pyJ2PcBJrvW5PUWA6bqfNtUkDbhfW+I?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcda9c3a-fc05-4b51-4e39-08dba4794392
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:13.7173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFYMvY31VXZ7W4cg9ljAtPXydTMVAb/PpgWVGVnqLj4txlHdRfqzpWC55di3Cele4hl2Hq8Nf/Cyu6uM/vKw4Q==
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

When the paravisor is present, a SNP VM must use GHCB to access some
special MSRs, including HV_X64_MSR_GUEST_OS_ID and some SynIC MSRs.

Similarly, when the paravisor is present, a TDX VM must use TDX GHCI
to access the same MSRs.

Implement hv_tdx_msr_write() and hv_tdx_msr_read(), and use the helper
functions hv_ivm_msr_read() and hv_ivm_msr_write() to access the MSRs
in a unified way for SNP/TDX VMs with the paravisor.

Do not export hv_tdx_msr_write() and hv_tdx_msr_read(), because we never
really used hv_ghcb_msr_write() and hv_ghcb_msr_read() in any module.

Update arch/x86/include/asm/mshyperv.h so that the kernel can still build
if CONFIG_AMD_MEM_ENCRYPT or CONFIG_INTEL_TDX_GUEST is not set, or
neither is set.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

Changes in v3:
  hv_tdx_read_msr -> hv_tdx_msr_read
  hv_tdx_write_msr -> hv_tdx_msr_write
  Do not export hv_tdx_msr_write() and hv_tdx_msr_read().
  included <uapi/asm/vmx.h>
  Updated arch/x86/include/asm/mshyperv.h so that the kernel
    can still build if CONFIG_AMD_MEM_ENCRYPT and/or
    CONFIG_INTEL_TDX_GUEST are not set.

 arch/x86/hyperv/hv_init.c       |  8 ++--
 arch/x86/hyperv/ivm.c           | 69 +++++++++++++++++++++++++++++++--
 arch/x86/include/asm/mshyperv.h |  8 ++--
 arch/x86/kernel/cpu/mshyperv.c  |  8 ++--
 4 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3729eee21e47..c4cffa3b1c3c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -500,8 +500,8 @@ void __init hyperv_init(void)
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
-	/* Hyper-V requires to write guest os id via ghcb in SNP IVM. */
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
+	/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
 
 	/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
 	if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
@@ -590,7 +590,7 @@ void __init hyperv_init(void)
 
 clean_guest_os_id:
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 	cpuhp_remove_state(cpuhp);
 free_ghcb_page:
 	free_percpu(hv_ghcb_pg);
@@ -611,7 +611,7 @@ void hyperv_cleanup(void)
 
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
-	hv_ghcb_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
+	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
 
 	/*
 	 * Reset hypercall page reference before reset the page,
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 7bd0359d5e38..fbc07493fcb4 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -24,6 +24,7 @@
 #include <asm/realmode.h>
 #include <asm/e820/api.h>
 #include <asm/desc.h>
+#include <uapi/asm/vmx.h>
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
@@ -186,7 +187,7 @@ bool hv_ghcb_negotiate_protocol(void)
 	return true;
 }
 
-void hv_ghcb_msr_write(u64 msr, u64 value)
+static void hv_ghcb_msr_write(u64 msr, u64 value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
@@ -214,9 +215,8 @@ void hv_ghcb_msr_write(u64 msr, u64 value)
 
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(hv_ghcb_msr_write);
 
-void hv_ghcb_msr_read(u64 msr, u64 *value)
+static void hv_ghcb_msr_read(u64 msr, u64 *value)
 {
 	union hv_ghcb *hv_ghcb;
 	void **ghcb_base;
@@ -246,10 +246,71 @@ void hv_ghcb_msr_read(u64 msr, u64 *value)
 			| ((u64)lower_32_bits(hv_ghcb->ghcb.save.rdx) << 32);
 	local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(hv_ghcb_msr_read);
 
+#else
+static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
+static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 #endif /* CONFIG_AMD_MEM_ENCRYPT */
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+static void hv_tdx_msr_write(u64 msr, u64 val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_WRITE,
+		.r12 = msr,
+		.r13 = val,
+	};
+
+	u64 ret = __tdx_hypercall(&args);
+
+	WARN_ONCE(ret, "Failed to emulate MSR write: %lld\n", ret);
+}
+
+static void hv_tdx_msr_read(u64 msr, u64 *val)
+{
+	struct tdx_hypercall_args args = {
+		.r10 = TDX_HYPERCALL_STANDARD,
+		.r11 = EXIT_REASON_MSR_READ,
+		.r12 = msr,
+	};
+
+	u64 ret = __tdx_hypercall_ret(&args);
+
+	if (WARN_ONCE(ret, "Failed to emulate MSR read: %lld\n", ret))
+		*val = 0;
+	else
+		*val = args.r11;
+}
+#else
+static inline void hv_tdx_msr_write(u64 msr, u64 value) {}
+static inline void hv_tdx_msr_read(u64 msr, u64 *value) {}
+#endif /* CONFIG_INTEL_TDX_GUEST */
+
+#if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
+void hv_ivm_msr_write(u64 msr, u64 value)
+{
+	if (!ms_hyperv.paravisor_present)
+		return;
+
+	if (hv_isolation_type_tdx())
+		hv_tdx_msr_write(msr, value);
+	else if (hv_isolation_type_snp())
+		hv_ghcb_msr_write(msr, value);
+}
+
+void hv_ivm_msr_read(u64 msr, u64 *value)
+{
+	if (!ms_hyperv.paravisor_present)
+		return;
+
+	if (hv_isolation_type_tdx())
+		hv_tdx_msr_read(msr, value);
+	else if (hv_isolation_type_snp())
+		hv_ghcb_msr_read(msr, value);
+}
+#endif
+
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index a9f453c39371..101f71b85cfd 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -275,14 +275,10 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 
 #ifdef CONFIG_AMD_MEM_ENCRYPT
-void hv_ghcb_msr_write(u64 msr, u64 value);
-void hv_ghcb_msr_read(u64 msr, u64 *value);
 bool hv_ghcb_negotiate_protocol(void);
 void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason);
 int hv_snp_boot_ap(int cpu, unsigned long start_ip);
 #else
-static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
-static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
 static inline bool hv_ghcb_negotiate_protocol(void) { return false; }
 static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
@@ -292,8 +288,12 @@ extern bool hv_isolation_type_snp(void);
 
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
 void hv_vtom_init(void);
+void hv_ivm_msr_write(u64 msr, u64 value);
+void hv_ivm_msr_read(u64 msr, u64 *value);
 #else
 static inline void hv_vtom_init(void) {}
+static inline void hv_ivm_msr_write(u64 msr, u64 value) {}
+static inline void hv_ivm_msr_read(u64 msr, u64 *value) {}
 #endif
 
 static inline bool hv_is_synic_reg(unsigned int reg)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4c5a174935ca..4f51dac9eeb2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -70,8 +70,8 @@ u64 hv_get_non_nested_register(unsigned int reg)
 {
 	u64 value;
 
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp())
-		hv_ghcb_msr_read(reg, &value);
+	if (hv_is_synic_reg(reg) && ms_hyperv.paravisor_present)
+		hv_ivm_msr_read(reg, &value);
 	else
 		rdmsrl(reg, value);
 	return value;
@@ -80,8 +80,8 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_register);
 
 void hv_set_non_nested_register(unsigned int reg, u64 value)
 {
-	if (hv_is_synic_reg(reg) && hv_isolation_type_snp()) {
-		hv_ghcb_msr_write(reg, value);
+	if (hv_is_synic_reg(reg) && ms_hyperv.paravisor_present) {
+		hv_ivm_msr_write(reg, value);
 
 		/* Write proxy bit via wrmsl instruction */
 		if (hv_is_sint_reg(reg))
-- 
2.25.1

