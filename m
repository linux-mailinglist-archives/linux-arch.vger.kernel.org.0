Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343396F797A
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjEDWzC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbjEDWzA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:55:00 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021016.outbound.protection.outlook.com [52.101.62.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A5C11DB0;
        Thu,  4 May 2023 15:54:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VXPPikV3EySHSo6r7tVD1Hs+rxlWQ1K5bu5ty995M4ZOSrl4Q97bzuqDJd4kO3YlC62lx6QwtuMvrp+nMrAv0iiQYNVO4yKJFRgDlc2R3su9B2xJGblRHrXipSxlSwIsCk4ezu2MXna2D/YoGPlA47Q/SaWqN1e7/VGsOf4SdV8IhFw6EeBzsnSBaXDgWTxS8HkXAqu9AR+hOPeOUyHNb80v7E0LM8eVdG6lVlAQF/U8LZLUEtJ8eUkr81GCmSced+Wg7qvmUR0go4FEyDy707ZmEvwA9nW8H7bGkw/fW2xWq8V9CJIiQp/iF3YvaZjQiCo7QmRaqYmaJWKG8u0jXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fta8+0e6UUqJv4EdrFHymmWFDpNIxydJnyKMfTInjP8=;
 b=SYMpkQ5hu8tQSzicVfEy12GzWhPySXxI/vetb+RVamyx6syf1skdxhTGDXhF/5d6Gb7WO8+Ivuq7Ry91WaHPPIS6oxu8N5P6FpNhXQyTppfNRzc43Ev7swbCQQ4FGWmLT3Fie7djI8FRHAI+OcO60fkYBVVJVQgkfoOnilFpd7zyr/xK3TJLqTvKhUa7rygt1laiYZTTjVq7bav7rNhE8uS+PugH7RNHxVZkSgQci6JSRO6yNWAPo4loYVGmO/aVTUnbKFT7YVvinCbw0mTZIwb5e0kmVnU3ab2Q9T4mJyNJcBDtFrmMCm8nuSuDoawWIP6s/tUEpy8NnFzAQned2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fta8+0e6UUqJv4EdrFHymmWFDpNIxydJnyKMfTInjP8=;
 b=Yn/igQO671cG4+DGq4aELueRRXoskKWwqItM/3uhYqQ40u3sxqpvCRquGxYDUbH/XufW8WOpa64cN1rah6EMkSfZUi98hCRnTGpqY/jVfw1R4rsvqp6hlF6wA4ep5poXVkov8wr6Daduth42knUajECus9hJlXnPLdz0P6qpPyM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:56 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:56 +0000
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
Subject: [PATCH v6 5/6] Drivers: hv: vmbus: Support TDX guests
Date:   Thu,  4 May 2023 15:53:50 -0700
Message-Id: <20230504225351.10765-6-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37130880-6321-45be-cb6f-08db4cf29486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hnyDPcjG5FoKN4ulnqqR3C6CoSIKa3vpHECnn4eJh/7/Bh+Dd4y17mN+47NC2bwy3uKvka7HFvWbu5FEdSwOVG4hgWvaCvGAdoFg6hbWAIwGDFbQdJYVB+RdXeNAjNRqJBEsq7whAWfueZCl8MoeU+fgvMfx/KQIYHsM7vxR+s0KijEJ0/dZW7L8X7HD7SPhMO2budvOH+hqgAGsPfQAX/mnhMPfvv9HjMS5TRLyEH67Hex9QfSpm/8Ak9sHT1Bi+HUf5sGxt1smVRcuS7NqG1kdD/oJ/ceydG/SWFW256+aZDzzuCfZ1R5mECft65LbZX181nPTlogntESefkimwLcjy6sDEEvM0BLvZiTy9t9hszGWLu03KnswHrkQlY0/FnB6SmBFN9bqWb0pRQDM3kyxFwwGpQg+hof98m1vcNgXZl6kv7QXsFMuADoYClQ7mrKsX5nsIsoDjXCK/gzF+99r1vuqFyCl5YUkGPfkUo8dqER1obv3jSOZJ4XUegVE03kqNSVC5oNSw7kWSAV9ox7bvmSPaASo4aW09nZTkAt95znJL+8ETRzUt2u5AMIRpZ04LrGFciRaxMSKrr5GOGo8c3hL4RiS+c+UYH0VwZVFh9ObvpGHIVb78BDTFg3DujkBxtdLh/ySHXpmAuh5xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(6666004)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USHDpZoWOM+cnTxl2gyLMBSlYKnLP3YaJW2rVDwvFa3E3ybXEFcmdwtoCT5+?=
 =?us-ascii?Q?FK+fTyMvv8rtjXZI9IiaU7XFxcOLIxVMZ7hWGpcIX64l6TnNfGx85S9NSsh7?=
 =?us-ascii?Q?pxyUOscKErwH6cDxObnMMc7lSNw3WIo4Tm+gKg+gb94fQkhAjFKuBE0+cj7D?=
 =?us-ascii?Q?Dbh8TTmgPNDNP/DdzEdiak/09W1jO3m1d05FLf+UDKTyc05I11x3YcItr7sS?=
 =?us-ascii?Q?azN8hq8IBhvHVw/WOTcwPpjLt9KQG9RwQ2Z/FAizfljJ4H1G7LH01cLNMJ/H?=
 =?us-ascii?Q?gAYiua5xdgZGzD5ZY4zqYsPslSOHaPoBxQGBsbPaUwZ5K+dCBLzQeed7jrST?=
 =?us-ascii?Q?lORHKfOpNWHejRCO8MS8UgsvwW7+ZkMpLpClPw3XlQE+0jK9tzONTsH/tjuD?=
 =?us-ascii?Q?NmDRggNMXHO0UACU5sXAEmb2BE1+RQTStmXwzH5sD67mT+cWmtkeL1fCy/oq?=
 =?us-ascii?Q?FFQsgYQ21LFSYDqRp0ngSz14U2Bwq2DL0C/T0SG2Im/Z2LAbS+2r+3crrnS4?=
 =?us-ascii?Q?wGI9ViSVOiMbTHV9Qmpf/UDefvrye0ZkRrqikdBK9z3QaGmCbwB7ly0C90RT?=
 =?us-ascii?Q?oZmlJZb0pVU3ClS7cP139y2sdJdHlqDBRCkkbSCEKT3NzaBtZtHBduJAudZH?=
 =?us-ascii?Q?4SnKY1Y/gBj2gIdnp2RkH9e3+VF7klizSBrYNeBOPXYXV0BustgttyBF/e+I?=
 =?us-ascii?Q?caCDZGzS9rBXuMTD2fmiC7ovzEM2QBdir+bWZCqrmctdrTyk0PXAlKvr362O?=
 =?us-ascii?Q?FRJvTxYMg8r+mT2Bs1Io0R53OuSYCSrVrDp/2T7bEw7m+XdfKOJ5ZrBKaDcl?=
 =?us-ascii?Q?OTVxGmFO38dTJ8iMZ/YopqjzOEHnl/tj4Oxa6rkkJSLLoOB7yvBj2znVE0Ea?=
 =?us-ascii?Q?RFnMTZdNVbjH3jR/S+nXivZkp2Ruv/4JOWAqmUBdIY8pQVmCXNugZ1hvMA6j?=
 =?us-ascii?Q?OPA5HcbIJzSHfIQ2Cllri1izPagNVHkJil1nybCxQqf+ZSFBEEym0L4IHMWI?=
 =?us-ascii?Q?Nm37JZPPGKL2uQpoBElfTY35gT8i8NuPZUg7eY5/nVfwMGDW8jAJDrLYhWHC?=
 =?us-ascii?Q?z2OfqlfhUt1Scq83xSsLMoCvKBK7R6FSMOUxqhK6U3X9j1DV0qY7rKV0X0/1?=
 =?us-ascii?Q?2ThXksB/eO5ByMqT2tnnplD16zQkfdq29vdXzublmOm0J7FMl+uYcoAMCJiJ?=
 =?us-ascii?Q?spT4nu70pYxyzG+HbXZ+DveZGmSwMw6kTWwx89xj+JCjIyjXFSvcIN7mnR+p?=
 =?us-ascii?Q?k7vl+x4QvBw6jh5gJv3IPaM8+NbTzy1+YJkwXM2daQmO3l05Cv8wpBmGhu1N?=
 =?us-ascii?Q?TDbyCT7pASAanb6Q4P0JeFawg3MY9IWkPZm2wSvi+1LPb17JWnBiGs7IuSc9?=
 =?us-ascii?Q?RVVR9dN+PYrRTi9p6q8i5KqEHrrhNIheWwfH/G1FW6WLG0OsNHHH6eA+wuiT?=
 =?us-ascii?Q?OdwFv4iP11ud1Dmh19Em3j2k5CC3TZ99juvvXkcDWXNC/sZLBuqjahhfZWcN?=
 =?us-ascii?Q?SGn+KkDsKd8CBbxhDhZFf6OoxOlkZQZHCNUPHs0wRfvNOtCo1oMcgG0EqlR2?=
 =?us-ascii?Q?srn0FAyyFAISNnBH4oRAWpq0HI1698euSvsOq0BnRipyv4R9YY/juW1+92xi?=
 =?us-ascii?Q?24D/QqA1KfLpaFfF1p5g1nqtVqPcDroagALg0O/Xs5wb?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37130880-6321-45be-cb6f-08db4cf29486
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:56.2236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XIzoJKDt+qUJp3bSaCMDHgOfoJ2H4eUye1rohX5jkUikoVU9BIhVl9H1PkA0tG8Zf7UcJoM9DKRHIMVhpoKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1883
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
  No need to use hv_vp_assist_page.
  Don't use the unsafe Hyper-V TSC page.
  Don't try to use HV_REGISTER_CRASH_CTL.
  Don't trust Hyper-V's TLB-flushing hypercalls.
  Don't use lazy EOI.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Used a new function hv_set_memory_enc_dec_needed() in
    __set_memory_enc_pgtable().
  Added the missing set_memory_encrypted() in hv_synic_free().

Changes in v3:
  Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
  (Do not use PAGE_KERNEL_NOENC, which doesn't exist for ARM64).

  Used cc_mkdec() in hv_synic_enable_regs().

  ms_hyperv_init_platform():
    Explicitly do not use HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED.
    Explicitly do not use HV_X64_APIC_ACCESS_RECOMMENDED.

  Enabled __send_ipi_mask() and __send_ipi_one() for TDX guests.

Changes in v4:
  A minor rebase to Michael's v7 DDA patchset. I'm very happy that
    I can drop my v3 change to arch/x86/mm/pat/set_memory.c due to
    Michael's work.

Changes in v5:
  Added memset() to clear synic_message_page and synic_event_page()
after set_memory_decrypted().
  Rebased the patch since "post_msg_page" has been removed in
hyperv-next.
  Improved the error handling in hv_synic_alloc()/free() [Michael
Kelley]

Changes in v6:
  Adressed Michael Kelley's comments on patch 5:
    Removed 2 unnecessary lines of messages from the commit log.
    Fixed the error handling path for hv_synic_alloc()/free().
    Printed the 'ret' in hv_synic_alloc()/free().

 arch/x86/hyperv/hv_apic.c      |  6 ++--
 arch/x86/hyperv/hv_init.c      | 19 +++++++---
 arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++-
 drivers/hv/hv.c                | 65 ++++++++++++++++++++++++++++++++--
 4 files changed, 101 insertions(+), 10 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 1fbda2f94184..b28da8b41b45 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -177,7 +177,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 	    (exclude_self && weight == 1 && cpumask_test_cpu(this_cpu, mask)))
 		return true;
 
-	if (!hv_hypercall_pg)
+	/* A TDX guest doesn't use hv_hypercall_pg. */
+	if (!hv_isolation_type_tdx() && !hv_hypercall_pg)
 		return false;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
@@ -231,7 +232,8 @@ static bool __send_ipi_one(int cpu, int vector)
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
-	if (!hv_hypercall_pg || (vp == VP_INVAL))
+	/* A TDX guest doesn't use hv_hypercall_pg. */
+	if ((!hv_isolation_type_tdx() && !hv_hypercall_pg) || (vp == VP_INVAL))
 		return false;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f175e0de821c..f28357ecad7d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -79,7 +79,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
+	struct hv_vp_assist_page **hvp;
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -89,6 +89,7 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
+	hvp = &hv_vp_assist_page[cpu];
 	if (hv_root_partition) {
 		/*
 		 * For root partition we get the hypervisor provided VP assist
@@ -398,11 +399,21 @@ void __init hyperv_init(void)
 	if (hv_common_init())
 		return;
 
-	hv_vp_assist_page = kcalloc(num_possible_cpus(),
-				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
+	/*
+	 * The VP assist page is useless to a TDX guest: the only use we
+	 * would have for it is lazy EOI, which can not be used with TDX.
+	 */
+	if (hv_isolation_type_tdx())
+		hv_vp_assist_page = NULL;
+	else
+		hv_vp_assist_page = kcalloc(num_possible_cpus(),
+					    sizeof(*hv_vp_assist_page),
+					    GFP_KERNEL);
 	if (!hv_vp_assist_page) {
 		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-		goto common_free;
+
+		if (!hv_isolation_type_tdx())
+			goto common_free;
 	}
 
 	if (hv_isolation_type_snp()) {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 2fd687a80033..b95b689efa07 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -404,8 +404,27 @@ static void __init ms_hyperv_init_platform(void)
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
 			static_branch_enable(&isolation_type_snp);
-		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
+
+			/*
+			 * The GPAs of SynIC Event/Message pages and VMBus
+			 * Moniter pages need to be added by this offset.
+			 */
+			ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
+
+			/* Don't use the unsafe Hyper-V TSC page */
+			ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
+
+			/* HV_REGISTER_CRASH_CTL is unsupported */
+			ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+
+			/* Don't trust Hyper-V's TLB-flushing hypercalls */
+			ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+
+			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
+			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index de6708dbe0df..af959e87b6e7 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -18,6 +18,7 @@
 #include <linux/clockchips.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/set_memory.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -80,6 +81,7 @@ int hv_synic_alloc(void)
 {
 	int cpu;
 	struct hv_per_cpu_context *hv_cpu;
+	int ret = -ENOMEM;
 
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -120,9 +122,42 @@ int hv_synic_alloc(void)
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_event_page == NULL) {
 				pr_err("Unable to allocate SYNIC event page\n");
+
+				free_page((unsigned long)hv_cpu->synic_message_page);
+				hv_cpu->synic_message_page = NULL;
+
 				goto err;
 			}
 		}
+
+		/* It's better to leak the page if the decryption fails. */
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC msg page: %d\n", ret);
+				hv_cpu->synic_message_page = NULL;
+
+				/*
+				 * Free the event page so that a TDX VM won't
+				 * try to encrypt the page in hv_synic_free().
+				 */
+				free_page((unsigned long)hv_cpu->synic_event_page);
+				hv_cpu->synic_event_page = NULL;
+				goto err;
+			}
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC event page: %d\n", ret);
+				hv_cpu->synic_event_page = NULL;
+				goto err;
+			}
+
+			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+		}
 	}
 
 	return 0;
@@ -131,18 +166,40 @@ int hv_synic_alloc(void)
 	 * Any memory allocations that succeeded will be freed when
 	 * the caller cleans up by calling hv_synic_free()
 	 */
-	return -ENOMEM;
+	return ret;
 }
 
 
 void hv_synic_free(void)
 {
 	int cpu;
+	int ret;
 
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+		/* It's better to leak the page if the encryption fails. */
+		if (hv_isolation_type_tdx()) {
+			if (hv_cpu->synic_message_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->synic_message_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt SYNIC msg page: %d\n", ret);
+					hv_cpu->synic_message_page = NULL;
+				}
+			}
+
+			if (hv_cpu->synic_event_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->synic_event_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt SYNIC event page: %d\n", ret);
+					hv_cpu->synic_event_page = NULL;
+				}
+			}
+		}
+
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 	}
@@ -179,7 +236,8 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
-		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
+		simp.base_simp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page))
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
@@ -198,7 +256,8 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
-		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
+		siefp.base_siefp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_event_page))
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
-- 
2.25.1

