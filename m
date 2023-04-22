Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E066EB6D2
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjDVCUK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjDVCUA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:20:00 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021019.outbound.protection.outlook.com [52.101.62.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4567B30C4;
        Fri, 21 Apr 2023 19:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atsniD8imyEhsbG8mHBvDFGONOPPE9yAael21Ro0UWZsst0XrrOhNTSn5frQHlkpJpl7HgRG5uO7Qk7A3tFBNNalpaEy5PQEJEnWxuMCB+1kErZ+Tn5YVVS+/5gugt9S4QFRYIfUght7B1gY89hZ+qCENrUSTxTwPOYH5uNxPK9J8k/7tWQN0c56VirgabHvtFHgZ1d4X3myXs/VozMqdJs4YaTWkc1A4deZlRKyl6b3SzGojam+Uzv70twJVbRhFBuycXjSVfe5bnD9cP0+gFAr5wQDfS3OQ873X5LX7mEPqVpxt9dID8lg6+Fdo///J82W8ayo4PhN1Sg4nDS5xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e964X0b0oioUkfFE8R97H946t3mCN5VooqM+mJVlWY=;
 b=Upi4IjUXuTryWF2C7r345mObMwKtSyr5Uef+viwJVZk36MKlTODQRlfwF33iH1tOQLuvusNLVOktIzrySNuouzb5uroczi9zTPaaJD2u4AovO12w2AfXNe/0CJwF+6flukrwcTHW+LovsBa9z2hmSBRknzv0r/iE1qY/dEXQcGojPKB06x361xV/OqfZIk3IMS0nW5Qtj5ugWL77v0oWksARDzeGOErt+NPps5XDtbL8gD/VCy3bN7cDhtj7YhfPQUJdW+ICiF8CkLe1R5wDoiYFTGUX5tHwZd90WUgn1LJ0TrmzPTb/mN53EzI4JirmrZOoHVhURxErjOXacl18fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e964X0b0oioUkfFE8R97H946t3mCN5VooqM+mJVlWY=;
 b=Z0OE8gTAxTbKY/sEZPcY3KXhb2L3mgHUFoyTMzFazqO2K51XSAQkhurEi/N+RHgSOb3wELQ8guptU8cKp7FPdojZPe37llln8fkI35hicKazWlZCZ1TfOGp2XG1+GuLbdNmVA7YZADVXF7DA1/6RWB0SB2tjacBmLLXDs+RT1rM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:37 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:37 +0000
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
Subject: [PATCH v5 5/6] Drivers: hv: vmbus: Support TDX guests
Date:   Fri, 21 Apr 2023 19:17:34 -0700
Message-Id: <20230422021735.27698-6-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422021735.27698-1-decui@microsoft.com>
References: <20230422021735.27698-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:930:8::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM6PR21MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e9efd4-d082-4580-7a43-08db42d80583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sigEH+Ea1coOlBRFVgOLAV0dCjK/lISBjKsQ3W1QVwN0Z7KchoaRDY8WxNRWg6eQQ+ysEsK/SbGpAxQyEAQ4r29Da/W1RupI45WnifFu2mQ3Tic9suJi7vA21I3UYXWpR31I5CGwcu7S95mWvxNENqENzwf7xB4E28jQNEvqaGgzrSF1pIkW2nZkcwhUPRRvLfvNF79WzrSXkGudRRm8RZ/svQzUJ6TxKwDbaMgr3tGcx2E5KriEfnDu6uFnzee1DCLP6F6969WWFlUpRXTUSQUp+BH8jO0rgdBWLEJP+lSFyZZEW5+VHczTblouenEmHi5x1MXj/RGTzJf7NfFkDrq4FlqpJZkskiQKjlVwZtzcdPjppuOaJIQo/qXMoJTz/RPjjpxxBNuzRa3uXl8vxQZAeHHtXLSMwOEfb6F+9P1RPLetHE4fCJ3xDkvVmONJLjbON9LS2B+CpyxiSZVcgEdPPQIpmoILY9lcjtA7CzEPTGxFY2pHySAIXjMJz774Mzyja0oMpYVyydkaX7WwVRFrsewHrtXqB4K+bRf28EDI0EGnpmhtS9ER26dIYjwm/t39+LwcdfWGLd+hNLbFDjmLqVdkee1uzmm/EseDU9+n8Ug0R9NvgWYY0LpgOArLEssQGS7RrNTjil+8MBoyPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199021)(8676002)(8936002)(38100700002)(4326008)(66946007)(66476007)(41300700001)(82960400001)(921005)(82950400001)(66556008)(316002)(786003)(6636002)(2906002)(5660300002)(10290500003)(7416002)(186003)(107886003)(86362001)(1076003)(6512007)(6506007)(36756003)(83380400001)(2616005)(6666004)(52116002)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6y8RTw12ZZEnWM3iMlIibYRVFwfCSudk2v495fhq1ubgqHsL6FkLNYjJefAp?=
 =?us-ascii?Q?FHX1CIEG4qM1UruCKTbIpYOmqbtnF8Y5PTO3pywK13Mul1HkCS+7kes1E30O?=
 =?us-ascii?Q?GH/SczMYGTnc3OfXRRE2l1r5U1bH5+cvfbs7KKP7DVXbLtwwMKIjZtt8jR+1?=
 =?us-ascii?Q?uFrjy5f+ZXBoQm0XaOQT51JRq04vq6jCh1PSS+gc1s/6HZm+OMNVwTFy4E8b?=
 =?us-ascii?Q?FQK0xO2y3MjFuqbUWzruZXVy+rzFm75mbMLSnnvZyE8J9QyWbwtq3a8BOvVk?=
 =?us-ascii?Q?jyG04f/EBiSZagr1EkRIphMsHOXZt7R3u7y3alqTlwWKdHcr6ELzIya9v9l0?=
 =?us-ascii?Q?UOfLvWlPH35ygqHIiu9RU3d1PASJuVDql0Xei1hLi7e6khuI7XNGRbTi5LRw?=
 =?us-ascii?Q?L0Uov85yI9zOWyoiCJ5utMEEIXcJPhKvHMtkUyI6IX57aJzWkPwLnCVa/TWI?=
 =?us-ascii?Q?UkRRtFt9yXmh4UYss4xgxsI52CBJnuOJn1BmZOnKHa76mocskhk8DdHFyAop?=
 =?us-ascii?Q?CnwWybfA6l5Je1yTPZPEe4n0/0myIMVMm23zsFogBfff2UiFg5ZKAxJ2F7N4?=
 =?us-ascii?Q?oyBDjlgQa5mOqjxxHlcW3E5F1oPewlglDzY2EvYKfjViCNgKV+poKA01B2ET?=
 =?us-ascii?Q?6tzuQspXfsgxW4nUSxwB9G5kQQ1I6b0wQz8EImjNQTDK1536XwOD833VWlrA?=
 =?us-ascii?Q?3o/zbMzjUNzcy4GgaOjYHiQPRCvFjcIORGLDOYU0Up02Bp25wGngADBufV7Y?=
 =?us-ascii?Q?ddLSS+6/J0bshLDkFyAxN+F9MiJygsoHq+VWcYHCfxO1bKialiMxrJ/iJC8u?=
 =?us-ascii?Q?ieOiXfe7AKoU1Dscr280boRpuX+pgjVpRHTOxCF6p8D5RnArkA45S/16MzMK?=
 =?us-ascii?Q?XQeff5f5wBLTtlYMLUltPvJcjwXxJlm1BM3S84hU6x9gQFebkMRnDOlQp6+r?=
 =?us-ascii?Q?P0N8haWbnziOf3+XNwEPt19KKY+yodudD55LofdTEn4Xz8ccklT2rIp9fGrB?=
 =?us-ascii?Q?LjFvNGtDB3St8nMZpMRFvh/LdM5GnlGCxONuzJwe1P+q9x2khr3BOS9EbY8C?=
 =?us-ascii?Q?rTozjyvFJE3CXs5hW4/anESMubBUJMRB7DOjsgPRIlVzBAf41FgOL9YDGglI?=
 =?us-ascii?Q?S5Jpw9Qv0qGGfrOAeFxbPKzeu9GraWseq7TDe7zsv1xqhbgnHRlKakZzd5pR?=
 =?us-ascii?Q?Kxcb5mzI+gLeDJL1WmVbsjuf3RF4MgXZFj/xCHWyxddVTDhLnG2SO9JOQEBM?=
 =?us-ascii?Q?VsTlvMSJuB1/wAtKgRLHnrdjdwMwsOn1KtUREtpS/wiK78mvUt8FmboY5U2Z?=
 =?us-ascii?Q?Q1eL8+Fyp2kmEGiRVFT4ApfKoiNPT0FG0TFoEzg4oWcKUqpzM1hHXBESJsS9?=
 =?us-ascii?Q?/b4UsS8hDpS7Qx2/NuFyaQIzLaU3JG7JbPN1f6+3tg59NLiimu7wX6TukZuW?=
 =?us-ascii?Q?P16FHDyicnnlOf5UFztiFGd3Iyv2zSHkuC2R69XBlLYj3MxpnXN1HU/s8qhO?=
 =?us-ascii?Q?NMVdnzVaDNq2tHd7qLZZuOVUxOc74R3mEpM/Ewv0NLKzUc9+PRINBREhwAFc?=
 =?us-ascii?Q?MWj2Z1ZAAAiAveCUhR5/KIGxC6GHaSd1QuLUdlsWZgpXhO+zP/D4FjO9RHU2?=
 =?us-ascii?Q?heJdd0dGJFK+RSJS61FkOEZvFDENsLWdrCNta8LJy5wF?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e9efd4-d082-4580-7a43-08db42d80583
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:37.7544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5zAcc5Yn8e4R9nJSljbnKWVBJs2/69KtzWpX1tpoaKWWpo0vYSmWl4CJlWR/vqR7TNldbHktiLyvWf/1aNLaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 arch/x86/hyperv/hv_apic.c      |  6 ++--
 arch/x86/hyperv/hv_init.c      | 19 +++++++++---
 arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++++-
 drivers/hv/hv.c                | 54 ++++++++++++++++++++++++++++++++--
 4 files changed, 90 insertions(+), 10 deletions(-)

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
index a87fb934cd4b..e9106c9d92f8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -405,8 +405,27 @@ static void __init ms_hyperv_init_platform(void)
 
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
index 4e1407d59ba0..fa7dce26ec67 100644
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
@@ -116,6 +117,7 @@ int hv_synic_alloc(void)
 {
 	int cpu;
 	struct hv_per_cpu_context *hv_cpu;
+	int ret = -ENOMEM;
 
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -159,6 +161,28 @@ int hv_synic_alloc(void)
 				goto err;
 			}
 		}
+
+		/* It's better to leak the page if the decryption fails. */
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC msg page\n");
+				hv_cpu->synic_message_page = NULL;
+				goto err;
+			}
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC event page\n");
+				hv_cpu->synic_event_page = NULL;
+				goto err;
+			}
+
+			memset(hv_cpu->synic_message_page, 0, PAGE_SIZE);
+			memset(hv_cpu->synic_event_page, 0, PAGE_SIZE);
+		}
 	}
 
 	return 0;
@@ -167,18 +191,40 @@ int hv_synic_alloc(void)
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
+					pr_err("Failed to encrypt SYNIC msg page\n");
+					hv_cpu->synic_message_page = NULL;
+				}
+			}
+
+			if (hv_cpu->synic_event_page) {
+				ret = set_memory_encrypted((unsigned long)
+					hv_cpu->synic_event_page, 1);
+				if (ret) {
+					pr_err("Failed to encrypt SYNIC event page\n");
+					hv_cpu->synic_event_page = NULL;
+				}
+			}
+		}
+
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 	}
@@ -215,7 +261,8 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
-		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
+		simp.base_simp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page))
 			>> HV_HYP_PAGE_SHIFT;
 	}
 
@@ -234,7 +281,8 @@ void hv_synic_enable_regs(unsigned int cpu)
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

