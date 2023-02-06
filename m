Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF0D668C6C8
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjBFT1Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjBFT1D (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:27:03 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95DD2CC7C;
        Mon,  6 Feb 2023 11:26:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k/ULu553ZdDHXRpGMqe8YJwPQsnNTzGnt234z6kH9mKehfQiqdLyOFyJcJ0N/gdHZKbaWaHEOclYf92J9G6jmIhWG0GpqObKRK/FhHu7TdYCYhzBnqHf5tmYJa5kcNX0tdo7qiSlfXc9zWq8xO0DQ29u8Ku8+8X3BmJ9JkdnwqYHdoFpFzc2zZ9SfBDYXje/gEr20tfX5w/lgeJ5QNgrNLc0NnUDuPF6bI2xpkHri70BX5mLn6uRlVF8/l1hDIkytoRLrlJKggfOfVHJgk+lYJl15iv8pqqm+EMgerBYCemjAEVQZhZNOFK5b8v/wke8Wv1EQBgqhVX+EqPm4irLEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6IMo36dIMm0VCNngratirZGL6xHRxNFNvvqXuQJAL8=;
 b=Lbk7weCfsNopZCbwqqjNsJ3g+vGP6K2OK42OyV7y5JzIrQETpak7i4qmcuiYqUQy1CgGy69ZGxwrEFLdi2kYs0Xx1oFpsOjclJOZa/RCVPQotk8sDXDCLRIs+jusbFyMlloMC/a2SsTyyPNtifPitI2s2kGUKFnZuPSZpIZr+5iPqRW5OHYtJrtTehF5tj3DhuGGUmDbphEpeOEVQ2RSbu4Zvae7iweQuzUc+NI8rPObZhrJOanF9Jyj1yOts2ijuzJZY0sorqYfydTKbCDMw+KjUEicm/jtjw/CFASkOVZJTv8P7L0DghX9t1MGHdOh32YqR5/5/XbuFPxB5GVoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:28 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:28 +0000
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
Subject: [PATCH v3 5/6] Drivers: hv: vmbus: Support TDX guests
Date:   Mon,  6 Feb 2023 11:24:18 -0800
Message-Id: <20230206192419.24525-6-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: ef98d32e-ed23-4ec1-db3b-08db08780b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lLNrJIXEDzxkoHjEqB7vckDJ7Up0hLom5bv4OCkn52W0M41HL7XQner7nRB9ev99nfsHIB0YvAc4IO3mXm967163kmnk/gZH9xKIF8OMAzfLXhwNBpOfMSA0z7b6fThZg1/UO6xGDcWVK3n7MYQoRfR2Nnrjw+l5vGA0FPIdQAdw0nt2NCPKurko2KpQpAA5uOwa5KSU0uozogY3ybbRGPCh9riUF3x144KLt9Y/CSDSm7nwT7qbDmppZTe1EHiQHUfRNZj0bHWKvJgZNMn3RPgTMoNOIX3OnPyD6FcEhcWDvhOMXlH6StxdAdNJJAHS4+krmqSYIWDw0wc/sQm6XYy43NA+Ac3TxzyZQsltOyEn9iVIEqizEVNGgyPRiY/1r4mcE1mVm3pLtDdDlJRJmK2/3e5CviOhjgb2iWccVzZOPynbKHSx51zgROq3yem/9doW8HLucPExVNffb5B1OkDDt8jjkWKC/fqPHma8tprhM2dVfzYggNpNAA11uJm+/jQ8saC/fUT/ma9E8Ve1LrQKTR3u/F6itxPVutMk2Rf1hSDh9IeTRwwP2dqtHKjXp2KcxWEFd5DMN9azCl6btu0Cb+7rNo0TfHkejZ9GkLSXH7ctggu65sey8FQUuEtdmjKGQlUJ8azDDy6JP7V2kQylc2lOwaZ+fXPGXauwXJDR8IAychwaoBz3p3REzkUneSqCteLEKIYojApSbZaY8i9za/m9eAOmYTQooO3mKOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(30864003)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xc6CtnGX1khSbA3t7VfYGodR+qi/tbl+oQ3a5mahV63O9RVQVwrlqXwcboPZ?=
 =?us-ascii?Q?SKEMlDLkgy1cUzyRwR0YLpknLVoJYOhpzev4SybxWbqvyXeffNNkETut5GRo?=
 =?us-ascii?Q?MmKTIK9SRRwcdiqsqz5EFk/UXGu1TvcPrriOEhn1CdCxPx9hONiV5aWqiRm/?=
 =?us-ascii?Q?ZYEZRfCTDojc35hul78ce6MX864zmt3sdKsOjoYvTsjj4H84nwEKP0xVnCZW?=
 =?us-ascii?Q?RwwXtiO1kK11dOz3qJ2rsWzFZ0uCR5YzHPed5a2FXCEhqdjqJypxsfxRZo/2?=
 =?us-ascii?Q?ctHFcAHx1BJZckna69KjPuxYSdLKhRlNOKf5YWAjMFL4uzQO/+4iiXrBdpgY?=
 =?us-ascii?Q?9ZEO5AUQcr1+N5i+4tvOIZAuL47XfIeV1EP2xcRF0BQSO29DFMiRTU4uDqdh?=
 =?us-ascii?Q?JE2uG3jhalXZcLi/eszh+/v2NbJDy51fX/YkXWnnnoZO21bB9vrPwJoIWboG?=
 =?us-ascii?Q?05fYiCr+iEF0WWBA+Pk6uKFSCEk1TmL35UQmBnMf00fSyCbMDgnfgEQd/pRi?=
 =?us-ascii?Q?crd2qx6MjTxn50ZOlHJnMaoCG0UOV/zvyV/Ac/iwkH9JCInB3Uoem6nfreaE?=
 =?us-ascii?Q?sbkBFdf7CZ+aRPyI7ejpq+OavbcjDWy7ctk8lWVKvtGYZ8FHiQ3sBSKaUBsk?=
 =?us-ascii?Q?KmQDb2TW1egtVmL85fpY0uLaSDUGjI7CbjjobRvoC5x8awKWRwIobpGtJXaK?=
 =?us-ascii?Q?EjnDFMyThxL0NesPBZU+GYStcv/rqkWL95DYxYv0bcXTwi5Zj81TfvQb1iqz?=
 =?us-ascii?Q?hYkYtOsvrQxU0YINRsoDkQESLOs8jLlLhTEoM7dEhLjYLFFMez42OYpFKXRm?=
 =?us-ascii?Q?U+W7vo9LQXDbYGSGMC67z948Us4vHRK4bF/1WiYh3f+5IW5XJzZv1GguM/7e?=
 =?us-ascii?Q?G/QFjCttFS3LW2Mvjifn5TVv0gehfhhbJ+KPoGQ0Uy2phGXLCYVcZGYrID7t?=
 =?us-ascii?Q?OZux4SfAaFMrgnTCCDqqnLotUk73kErOm9iaPnZzNSftbPyGu7FHMXWFpnZh?=
 =?us-ascii?Q?epvUAxjEz6RKNpodhj5BVl49SRGOKW1CDQt4R/Tq/3v/x7p+wJKRJBp6FGWq?=
 =?us-ascii?Q?uj2ktiI3UDUQeu84zY27FWF0aL4T7m17lM2BbP59vzm2b+i96NO1wAO+qWq3?=
 =?us-ascii?Q?tShvys8wfUByXlf0m4uL9b8g++IMnitN13cd8SutrcadspHvrGNwdFxS/Ii+?=
 =?us-ascii?Q?Q74TEszbv5Z8rkLn2r6x3WdEJha6iT3NsdHyamaKo9S5beue1/cREo0V2gOC?=
 =?us-ascii?Q?8Eq4sf1bWSEiiTwkmN5L7cHAffxWLNoozbdXhjGYzkw8s9CsC9FJ6k+GefCg?=
 =?us-ascii?Q?PXL5GST7mQbs13Cq3rmYP0X2WalWdvMGIYoIMH4d8IRJ1y2dahJUR+8bztAB?=
 =?us-ascii?Q?9VLbz6yDBo6aUXGzfdZQyc/YTP50ZAlUcwTUSBU2fAleUzGIitXARTQZSou1?=
 =?us-ascii?Q?3ab1tD3Ozckedg00mPMlY0Vq7IUH7u5GfTEEFaEx89/m89XYKzGE72QOStwO?=
 =?us-ascii?Q?OQ+G1bv95mr4bxLSFKtzOVqv7NfOXApAgluNa0TGH42g6dwU5Lo7mnqJSPfH?=
 =?us-ascii?Q?9J+UQvE2ICwqY0qiOzUYFQDH0BayJOb6HNqgdwX7v9PZXMtyq4HYlA/5/2Pz?=
 =?us-ascii?Q?3KDba125bbfsd5Sxea5U/3h8z2yFauM5XvMDkOzYkpb0?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef98d32e-ed23-4ec1-db3b-08db08780b8b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:28.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qiLko2Ib7kzWEBq42Wu517KVWLJgMK1sPyYoTXPEYxb9jAMGdtXoJmv+Cp0iJKAJFCxHHySAw6Tx6fhMu84YZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
  Share SynIC Event/Message pages and VMBus Monitor pages with the host.
  Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().

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

 arch/x86/hyperv/hv_apic.c      |  6 ++--
 arch/x86/hyperv/hv_init.c      | 19 ++++++++---
 arch/x86/hyperv/ivm.c          |  5 +++
 arch/x86/kernel/cpu/mshyperv.c | 23 ++++++++++++-
 arch/x86/mm/pat/set_memory.c   |  2 +-
 drivers/hv/connection.c        |  4 ++-
 drivers/hv/hv.c                | 62 +++++++++++++++++++++++++++++++---
 drivers/hv/hv_common.c         |  6 ++++
 drivers/hv/ring_buffer.c       |  2 +-
 include/asm-generic/mshyperv.h |  2 ++
 10 files changed, 116 insertions(+), 15 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index fb8b2c088681..16919c7b3196 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -173,7 +173,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 	    (exclude_self && weight == 1 && cpumask_test_cpu(this_cpu, mask)))
 		return true;
 
-	if (!hv_hypercall_pg)
+	/* A TDX guest doesn't use hv_hypercall_pg. */
+	if (!hv_isolation_type_tdx() && !hv_hypercall_pg)
 		return false;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
@@ -227,7 +228,8 @@ static bool __send_ipi_one(int cpu, int vector)
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
-	if (!hv_hypercall_pg || (vp == VP_INVAL))
+	/* A TDX guest doesn't use hv_hypercall_pg. */
+	if ((!hv_isolation_type_tdx() && !hv_hypercall_pg) || (vp == VP_INVAL))
 		return false;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6a0bcbd18306..d641c9808c31 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
+	struct hv_vp_assist_page **hvp;
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -87,6 +87,7 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
+	hvp = &hv_vp_assist_page[cpu];
 	if (hv_root_partition) {
 		/*
 		 * For root partition we get the hypervisor provided VP assist
@@ -396,11 +397,21 @@ void __init hyperv_init(void)
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
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 07e4253b5809..4398042f10d5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -258,6 +258,11 @@ bool hv_is_isolation_supported(void)
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
 
+bool hv_set_memory_enc_dec_needed(void)
+{
+	return hv_is_isolation_supported() && !hv_isolation_type_tdx();
+}
+
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
 
 /*
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 941372449ff2..6a57af60ec9f 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -345,8 +345,29 @@ static void __init ms_hyperv_init_platform(void)
 		}
 
 		if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
-		    hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+		    hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
+
+			/*
+			 * The GPAs of SynIC Event/Message pages and VMBus
+			 * Moniter pages need to be added by this offset.
+			 */
+			ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
+
+			/* Don't use the unsafe Hyper-V TSC page */
+			ms_hyperv.features &=
+				~HV_MSR_REFERENCE_TSC_AVAILABLE;
+
+			/* HV_REGISTER_CRASH_CTL is unsupported */
+			ms_hyperv.misc_features &=
+				 ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+
+			/* Don't trust Hyper-V's TLB-flushing hypercalls */
+			ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+
+			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
+			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 356758b7d4b4..e069bf28d683 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2175,7 +2175,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (hv_is_isolation_supported())
+	if (hv_set_memory_enc_dec_needed())
 		return hv_set_mem_host_visibility(addr, numpages, !enc);
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..1ecc3c29e3f7 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -250,12 +250,14 @@ int vmbus_connect(void)
 		 * Isolation VM with AMD SNP needs to access monitor page via
 		 * address space above shared gpa boundary.
 		 */
-		if (hv_isolation_type_snp()) {
+		if (hv_isolation_type_snp() || hv_isolation_type_tdx()) {
 			vmbus_connection.monitor_pages_pa[0] +=
 				ms_hyperv.shared_gpa_boundary;
 			vmbus_connection.monitor_pages_pa[1] +=
 				ms_hyperv.shared_gpa_boundary;
+		}
 
+		if (hv_isolation_type_snp()) {
 			vmbus_connection.monitor_pages[0]
 				= memremap(vmbus_connection.monitor_pages_pa[0],
 					   HV_HYP_PAGE_SIZE,
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..76a19cc56894 100644
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
@@ -119,6 +120,7 @@ int hv_synic_alloc(void)
 {
 	int cpu;
 	struct hv_per_cpu_context *hv_cpu;
+	int ret = -ENOMEM;
 
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -168,6 +170,30 @@ int hv_synic_alloc(void)
 			pr_err("Unable to allocate post msg page\n");
 			goto err;
 		}
+
+
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC msg page\n");
+				goto err;
+			}
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC event page\n");
+				goto err;
+			}
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->post_msg_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt post msg page\n");
+				goto err;
+			}
+		}
 	}
 
 	return 0;
@@ -176,18 +202,42 @@ int hv_synic_alloc(void)
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
 
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_encrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to encrypt SYNIC msg page\n");
+				continue;
+			}
+
+			ret = set_memory_encrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to encrypt SYNIC event page\n");
+				continue;
+			}
+
+			ret = set_memory_encrypted(
+				(unsigned long)hv_cpu->post_msg_page, 1);
+			if (ret) {
+				pr_err("Failed to encrypt post msg page\n");
+				continue;
+			}
+		}
+
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 		free_page((unsigned long)hv_cpu->post_msg_page);
@@ -223,8 +273,9 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_message_page)
 			pr_err("Fail to map syinc message page.\n");
 	} else {
-		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
-			>> HV_HYP_PAGE_SHIFT;
+		simp.base_simp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page)) >>
+			HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
@@ -241,8 +292,9 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_event_page)
 			pr_err("Fail to map syinc event page.\n");
 	} else {
-		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
-			>> HV_HYP_PAGE_SHIFT;
+		siefp.base_siefp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_event_page)) >>
+			HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 219c3f235c50..42f9274a3f82 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -283,6 +283,12 @@ bool __weak hv_is_isolation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
 
+bool __weak hv_set_memory_enc_dec_needed(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_set_memory_enc_dec_needed);
+
 bool __weak hv_isolation_type_snp(void)
 {
 	return false;
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index c6692fd5ab15..ae3b3cd7ddbe 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -233,7 +233,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 		ring_info->ring_buffer = (struct hv_ring_buffer *)
 			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
-				PAGE_KERNEL);
+				pgprot_decrypted(PAGE_KERNEL));
 
 		kfree(pages_wraparound);
 		if (!ring_info->ring_buffer)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index d55d2833a37b..c8c16b3df68d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -263,6 +263,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
+bool hv_set_memory_enc_dec_needed(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 void hyperv_cleanup(void);
@@ -275,6 +276,7 @@ static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 static inline bool hv_is_isolation_supported(void) { return false; }
+static inline bool hv_set_memory_enc_dec_needed(void) { return false; }
 static inline enum hv_isolation_type hv_get_isolation_type(void)
 {
 	return HV_ISOLATION_TYPE_NONE;
-- 
2.25.1

