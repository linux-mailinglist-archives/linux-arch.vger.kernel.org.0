Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2952D7869BB
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbjHXILG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240566AbjHXIKs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:48 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1F1BD5;
        Thu, 24 Aug 2023 01:10:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G78q8uEnVvnr8DgNsGQcdyEpJQbrs6nGaR9+FNW+AUy84NZLV0lmP7837sQYJPQSGh0b//NeacKJzgnPTMmr/EnpYttvgJw152hmrcjy3LOPnzOCuKsk+FJ7J8l7OjlqZT49Emypl9MYaSscF5yW8F1DiNGgtSH/0pDxWqsp1yPPukGdZbqS+97N7LWYDZLJIkrg5Eay9jQa5IzZ5aegQE8SdboOxAU3aDxdS50tc5CmtcVV92m3ieHrsVoSDqXziYKW8ZLlaya1ThFdl3Trw+X04Ik/L507FV0mS4luN9RsPhmaIndoF/8qxMuPphiAnJODAB9Mv82Dt3n5OJIh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+nRC+b/av7IcmGe0uxy6ASM+L3B24FoMzt7s0PObOjk=;
 b=htLUlK5FEeW6zj8nK1rLnZdRsz6eUoYPpbvOZqhFgaSHmbYaFPbbHB6bUVozGUxfcFNNWmbvdk40jkkESzti6BoRUvkMln4MPo88tdw1AzkJhibflYemHnT7Ldp3Z2kz+pooLr3NhbUjPoNFkmnip3CZqx1/hJNao/V3Ad0sx9Hy7cHEjmDSv6YoaT7r1YFOG/rQzm9N7YuNbxh/FACfiN0mBmLLBmPHhSDITxcZJCKb4uhrwCl0R7ylIMm0DN/i9Smzm5/XTMqlsnzBkYdJO8R14Hw4g8ojYaIpL3aQRUnFEo8+oZ5Ov1yA5VZP+n0dFjg2GwbMrj7LyYJeQw1syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+nRC+b/av7IcmGe0uxy6ASM+L3B24FoMzt7s0PObOjk=;
 b=e0JtTyohOSJjx633xUF2/xBv9I4TuRDuEqQB/6I1LOrpbcO8UsnxYBBXYByWgioPZko0BMFTJSCcpA6BQXuHtHlrlzcLELOdHwvO3QnzsVjucOI2+kSitRoCA03nRgJiuJDd83VJNJSwkTzfsyClLIq/Mr4YFR9zf8al1hvu+NI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:16 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:16 +0000
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
Subject: [PATCH v3 09/10] x86/hyperv: Remove hv_isolation_type_en_snp
Date:   Thu, 24 Aug 2023 01:07:11 -0700
Message-Id: <20230824080712.30327-10-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab1f1696-e1e6-4924-1f2d-08dba4794531
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nljIa4+KaR2if3K+LK7Xi/m0do1Jv/QrJGVjeyz1wLrLv3YqdnmqUsvOs/Rk+4LPBEcpHame+UrqulkKiTEeu7j+Ibh9CNaGmcyDSqUiDlugSCz/jTCDigeeI55qoA3QzXPy0C6cjvSK/2GctuYMl3hjof5k4QoRvugazmnSEEEAuHfqi3ImrAWgNYwKgS9paoSTXhUjQq4OcfsImvEHkxPI5qtyK8DvycZXbljZpkHLbdGvyRGYjeaW4t6X1wULDbL0Q0cds1L106sdTeh6YRcSsim3G6iBxyd71dY5LhqR1l4ohyEIVGLGjODVhAwZmRHnCLKYHYLIrdBc5eEwnofAO4M7f9lgG7L9iiMFto5DDDiugu4J8X4gx4KXAa0648ULBPYbG4/C7g0l34WYgVB+KOmBMtXuEh0hhpUaRTL0wXG4507YHRamd7hgx8H6x1vPM52eZ+glpzyHL7BELU3KxHaqVwBhpa4RDWAGKK6OIt+Sw5dsLu9faIiLHuYNeq+ntIcfljMBHnYEcHFfl/DZxTIpL4MZU9BF1oX/sEcfjNn1QA2vD6sfb7lFHQeM9l+dW9S68iyoGkIVT9023uxTFa2dR1wxnedmy9pt9FfEPIqn1vtgaiV9CW12x267QEnrcwXR5LDgfDSODLDddmRiUloQD7LEx7SPeaiSZuGxDQQHZNbbGjwlX+Q3IGOx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(6666004)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HcnQdvC3kOpfXnH1jMELV8+SRHbLMhz1rsyIXlVfdBb885rCn3ztkGBQ7MP?=
 =?us-ascii?Q?qMCCv3W+8ZDbN945SmwGub0AGKsGyWC5BY4QCWPQZMfO9XIAGcYGBjaO/WUA?=
 =?us-ascii?Q?1RjzEzguvEX0Y9UqIYeAveSZf16z1kOawIr3XzBjjC8mLI1P6hJM3R6YC/LG?=
 =?us-ascii?Q?G3oFyg4K9BF0hAolGaoyPiaazmXEKl0FGdclSMGNuql5krkXJt6CoSte2Arf?=
 =?us-ascii?Q?7Z3C61YG75Iis2hoBsE4F/KitxBZf6ZKFQ/Ptpp3yUErhMr27CRzuOGSHnux?=
 =?us-ascii?Q?lFb7uRbDaxTi9/iBZBnwO1ah6MGblYGYnZRXs4OH/Fb1uo175S1QozDd+9m7?=
 =?us-ascii?Q?1h7NMFkC+8r105peHVQ/roJw/R1MZ+qHN0hmUgFRNMfxReIAQ0mUn6FNYDhy?=
 =?us-ascii?Q?tMCu/k+S0gVAQjMpG5ujWQQzqpofBGFi9ATwOWVbyYd2FoA5BjYIoXrpgMeZ?=
 =?us-ascii?Q?3zD1qu11DpRU07LLtdD/A/ZLFDyTLzNdTIEiqfAD84c9oOP1dHfh7L/QjCel?=
 =?us-ascii?Q?csXR79F7CCXufVdGDgwn+9YRXMtmTqiA1o293jwedmfG4QZowxUtR21D0vKz?=
 =?us-ascii?Q?twaAKOIFa5RzFo+4MeqtONogTIJ6QzBo0HNnIWi15NMSOQYJqlBIR5eGFQbs?=
 =?us-ascii?Q?KDUetJ5hHP+3O0CjFGulkm08cPVt7R+yVe3j2rcmMtq4R8YpKKI2ZxJWdjUC?=
 =?us-ascii?Q?QcDZZhoTTb+e3GI6G93sq1MYyy8YpJPJdsTZbl4jxMchDimUI4l48Uxyzxjq?=
 =?us-ascii?Q?WYLCPg//y4dFT4q4eCeLkw5N0B95+y7RFhl8BZOCb+5m06ipgTBMnfSzapKq?=
 =?us-ascii?Q?MwOo6ndtOCaYW3Seudb99YwMOII5ZPR8XuWbc2aD1hHhU3N3nxrpaGiTTROI?=
 =?us-ascii?Q?TZZao/5MfmiaouDUK/jZyWyck43dwbtsJuVpb/Js29iB/ju6lQkOBgdYA2lK?=
 =?us-ascii?Q?4KG5nPsiyyIqdlyg+lY24P/1tLc4ONjP535wT6hcESBMlrB3MswD3P+bH3M3?=
 =?us-ascii?Q?Ivb5VOmN5cg44N/wXIbDeOB6nLLbkS/8fhnsmYVKU3L7Uo5nozn0sTorF/Jr?=
 =?us-ascii?Q?imw3zpUb93bI0l/Cvr/fvLsJpkDnU2r+UpV8jMMK3jhjXrGv7yCjhn4O82F8?=
 =?us-ascii?Q?Wt0BAoZV17Ab6flUCXEF24Rz9InnyKA5u0t7u5SHGzFr6n28SblqEjA7ZA/N?=
 =?us-ascii?Q?INgj+yVkmutnXpYnNKt9WcoT0tnKH7WvO8tbpb37jBkPD/GcD7+dWEUiW1E8?=
 =?us-ascii?Q?3RNAgP0I/afuibQwXck5Vj+oVy6RIOiO7VFM6+uJy/kXJwQD+WsdIH2uhe0m?=
 =?us-ascii?Q?pqSbWxF6/PYn/SacHwfnqoIufVCEg35S8CgIfOpJZOvboTbUsBmWAkniPR+1?=
 =?us-ascii?Q?mTYtn8/BMSk59QTsvHUSHmYl1yum0aC7ocSHwqIYaEewyZWLWF3jvbb2XgoD?=
 =?us-ascii?Q?nkfXjrmzAcxUeRaW9bOR4ozM4kpikA5Q7m+cIqYnqNc4bwi755DK/FwCcPPK?=
 =?us-ascii?Q?FkP/InLsOGhDo1bwhlBPqC0zqdRE6zQ8REB6+quFi3kRFMJXEUa0zOXZbtqM?=
 =?us-ascii?Q?dSckL7Hkp06Zuw8FUYARu1QYg/RKSzJtdKAKv6EQhTD+xePXuCcXpnpNEI6O?=
 =?us-ascii?Q?XBKxflmGhmwWTEBNGpf6hOYXdtqlf7rSO1OZu+U6Ad+8?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab1f1696-e1e6-4924-1f2d-08dba4794531
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:16.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFtzrES78bXf21eaq2Ug1oGNfBMQS/SeidmsXolz5cXekrwmgLkiJDctw/ZodSdneU1CysjXjrWVz6HE+CrXoA==
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

In ms_hyperv_init_platform(), do not distinguish between a SNP VM with
the paravisor and a SNP VM without the paravisor.

Replace hv_isolation_type_en_snp() with
!ms_hyperv.paravisor_present && hv_isolation_type_snp().

The hv_isolation_type_en_snp() in drivers/hv/hv.c and
drivers/hv/hv_common.c can be changed to hv_isolation_type_snp() since
we know !ms_hyperv.paravisor_present is true there.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Rebased to Tianyu's v7 SNP patchset: the changes are small.
    In hyperv_init_ghcb() and hyperv_init(), added the test of
hyperv_paravisor_present, which was missed in v1.
    Updated the test before the call of get_vtl().
    Updated the test in hv_do_hypercall() and friends.
    Updated the test for hv_smp_prepare_cpus().

Changes in v3:
  hyperv_paravisor_present -> ms_hyperv.paravisor_present
  

 arch/x86/hyperv/hv_init.c       |  8 ++++----
 arch/x86/hyperv/ivm.c           | 12 +-----------
 arch/x86/include/asm/mshyperv.h | 11 ++++-------
 arch/x86/kernel/cpu/mshyperv.c  | 10 ++++------
 drivers/hv/hv.c                 |  4 ++--
 drivers/hv/hv_common.c          |  8 +-------
 include/asm-generic/mshyperv.h  |  3 +--
 7 files changed, 17 insertions(+), 39 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index c4cffa3b1c3c..2b0124394e24 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
 	void *ghcb_va;
 	void **ghcb_base;
 
-	if (!hv_isolation_type_snp())
+	if (!ms_hyperv.paravisor_present || !hv_isolation_type_snp())
 		return 0;
 
 	if (!hv_ghcb_pg)
@@ -117,7 +117,7 @@ static int hv_cpu_init(unsigned int cpu)
 			 * is blocked to run in Confidential VM. So only decrypt assist
 			 * page in non-root partition here.
 			 */
-			if (*hvp && hv_isolation_type_en_snp()) {
+			if (*hvp && !ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
 				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
 				memset(*hvp, 0, PAGE_SIZE);
 			}
@@ -460,7 +460,7 @@ void __init hyperv_init(void)
 			goto common_free;
 	}
 
-	if (hv_isolation_type_snp()) {
+	if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
 		/* Negotiate GHCB Version. */
 		if (!hv_ghcb_negotiate_protocol())
 			hv_ghcb_terminate(SEV_TERM_SET_GEN,
@@ -583,7 +583,7 @@ void __init hyperv_init(void)
 	hv_query_ext_cap(0);
 
 	/* Find the VTL */
-	if (hv_isolation_type_en_snp())
+	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp())
 		ms_hyperv.vtl = get_vtl();
 
 	return;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index fbc07493fcb4..3d48f823582c 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -637,7 +637,7 @@ bool hv_is_isolation_supported(void)
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
 
 /*
- * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * hv_isolation_type_snp - Check if the system runs in an AMD SEV-SNP based
  * isolation VM.
  */
 bool hv_isolation_type_snp(void)
@@ -645,16 +645,6 @@ bool hv_isolation_type_snp(void)
 	return static_branch_unlikely(&isolation_type_snp);
 }
 
-DEFINE_STATIC_KEY_FALSE(isolation_type_en_snp);
-/*
- * hv_isolation_type_en_snp - Check system runs in the AMD SEV-SNP based
- * isolation enlightened VM.
- */
-bool hv_isolation_type_en_snp(void)
-{
-	return static_branch_unlikely(&isolation_type_en_snp);
-}
-
 DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
 /*
  * hv_isolation_type_tdx - Check if the system runs in an Intel TDX based
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 101f71b85cfd..66ca641a164a 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -26,7 +26,6 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
-DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
 DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
@@ -50,7 +49,7 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
-extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 
@@ -79,7 +78,7 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input_address, output_address);
 
-	if (hv_isolation_type_en_snp()) {
+	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -135,7 +134,7 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, 0);
 
-	if (hv_isolation_type_en_snp()) {
+	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__(
 				"vmmcall"
 				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -189,7 +188,7 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, input2);
 
-	if (hv_isolation_type_en_snp()) {
+	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -284,8 +283,6 @@ static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 static inline int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
 #endif
 
-extern bool hv_isolation_type_snp(void);
-
 #if defined(CONFIG_AMD_MEM_ENCRYPT) || defined(CONFIG_INTEL_TDX_GUEST)
 void hv_vtom_init(void);
 void hv_ivm_msr_write(u64 msr, u64 value);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 4f51dac9eeb2..b63590ffc777 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -304,7 +304,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
 	 *  enlightened guest.
 	 */
-	if (hv_isolation_type_en_snp()) {
+	if (!ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
 		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
 		return;
 	}
@@ -440,10 +440,7 @@ static void __init ms_hyperv_init_platform(void)
 
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
-			if (ms_hyperv.paravisor_present)
-				static_branch_enable(&isolation_type_snp);
-			else
-				static_branch_enable(&isolation_type_en_snp);
+			static_branch_enable(&isolation_type_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
 
@@ -556,7 +553,8 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition || hv_isolation_type_en_snp())
+	if (hv_root_partition ||
+	    (!ms_hyperv.paravisor_present && hv_isolation_type_snp()))
 		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 523c5d99f375..51e5018ac9b2 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -164,7 +164,7 @@ int hv_synic_alloc(void)
 		}
 
 		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
 			if (ret) {
@@ -225,7 +225,7 @@ void hv_synic_free(void)
 		}
 
 		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
 					hv_cpu->synic_message_page, 1);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index e62d64753902..81aa8be3e0df 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -383,7 +383,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		}
 
 		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
@@ -532,12 +532,6 @@ bool __weak hv_isolation_type_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
 
-bool __weak hv_isolation_type_en_snp(void)
-{
-	return false;
-}
-EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
-
 bool __weak hv_isolation_type_tdx(void)
 {
 	return false;
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index f577eff58ea0..e7ecf03f675e 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -64,8 +64,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
-extern bool hv_isolation_type_snp(void);
-extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
-- 
2.25.1

