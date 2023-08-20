Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38664781FDC
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjHTUdU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHTUdR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:17 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021024.outbound.protection.outlook.com [52.101.62.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6601703;
        Sun, 20 Aug 2023 13:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1GMqg8EWZYW2EdV5NHTDGo290yMwH0cGVLdL07zfqFlzzhgbfBckB+zcXdS0d6QOdo6SpFP5+IE24GqxPa/xsrxc6d+8yUjHLKckyDzSsw7LURBa3PNJt9kJkf1fdFnRiTmzv9hmkwJD+pPWJqwcts8P8/IxLllQ0Y0W1NXVpAzFy696+3ckcCx3bf7VlchKxmWDeVf10x0mwekqDLgZ9/It1raxDNM76Dmty9mN5rlRF2fj34llAUIZDBl6h1R+lsoAdP1SIXPu8vYbS6aaon2+zrs7j1QfooKBdGNI5iMvhJPn1oGYgqwbpoySfYivjaINp7CEkD9NzGJa82B2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvY0FUYFuLairGGJv70gMWQwytWCL4C9iuFsoe4zBFk=;
 b=Uvek6nEqefz4FcUzgjEq0PggyozQeMOUt2KutAMKEUJeFCXfF8shXBVWowvCPjt9A+Mt9FjVQzlL4pqfOICwtGO0G7jWfWNkQODOy4LUAoT7PNPHl+olGTGZU/F55rgfdqzBTw9NOfidu8Wc9qYF/XHNjNWzaNYkOi0niSvP+uAeceSVmNsPIg3fu/6IVrJaLRlZwwraZ8nolct0u0+B+NFug5ZPCx2TxGTnnM36iTfr+0qPemqeKfMqy3LMjSSpO3QCG5A4yo/icRbu9PE2eMHoPP0s6Yhdv237zxbsfEusgXt9xGkl333Tob46A/knfVlgoPtDH7rcFhT/BtzTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvY0FUYFuLairGGJv70gMWQwytWCL4C9iuFsoe4zBFk=;
 b=AO/CiBUwLBMdeJeda2ok/V+24lunxO4G16uxMYyO1DiD99EexHnf7yA5oyN/eIY+1bsNlp3Vo+V4r62F0ngtCc2Hj6vLLyiGX7nj8NI9pIqFC94edt/SvSdhdyObpBnQWfSCsZOycDWL8ETiMnmOrgwqwRmxEZYLJV0dFlSIQ0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:28:16 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:28:16 +0000
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
Subject: [PATCH v2 9/9] x86/hyperv: Remove hv_isolation_type_en_snp
Date:   Sun, 20 Aug 2023 13:27:15 -0700
Message-Id: <20230820202715.29006-10-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4b1b7cb2-1e24-4b60-faa7-08dba1bbfbe5
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 06NCLr7B4x/utGFLGiE+61BRl5DQRa+ZQ0+uzO2ndtEmYly6cyW/sYi4MAr30VSo1iYObE01KdhbSeV9XHagH5K1Z121mg90vRHQQivE96XEbXNT3o2h3oQzxYAALTYbrgLrdpZmg+mAkAKgRlxIQqTui6gDTtqhQsU0uGjmTYMgF5fcZm8Z2AfQcwuinJccLK0Cg0AzODTvbgZu2yjZMdvji8NJD13VNKqB+mI9zBE5wiAKWr+jW0DuJPdgqQ0+/hEYBRl2khBo9p+nLauRjlylNsCtaerXseLHZYr82x4TCemjYyt6OW734G/7ODa+x7RM3SNiH4JDNN3bXvPg+d0DO9pEllhOlQQ6aJ8udatXZaye6HDU8yO7ZUUwGPlVdUfZJbXRMoPUyu+AJr9LFeYRy2f11/A7wkgkkkS2vHHl9mHZ+FRW8oEWg+8CCSczY0/MN8nau3PcjyRqqTQCAps5o1shB5ba1MP7CkIsmZm1MZPPupVrWwOKETn25A7RzSIWK9D/1x6UwWcgMbpVH0xBOv+Ji8QP1mxrNpeY3XXkbGXSUxy9yiJ8G22FtLAxP8FO7EWRbeB3zisT1wDVAJfh2jSCTKKkdpDyhUKloCZ3R3cz98pEDFyfaYzmjtvdmWN8JEmsgnJNIRzVtT6K2CS0x0RQ012bX9PMjZuCrWTrbMyZR84ge5Tm2Yleprkv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6gssCXLPJza0XkLtifZNJ6DqCxfJuNip0CqYtj3dWxdwo5wEVm1LUdrJ2Pwc?=
 =?us-ascii?Q?UAoPJbIIWkjevCmwyhmJaVzRsSePF9DQoTsxXuEz0bfEFGbs+dFpcE33MpEq?=
 =?us-ascii?Q?pP5iKWuB2cF78Y0jTsx5TshFdSTwT+YSJm1sCrAwisPW+v3tCJ9iPx1ydW8q?=
 =?us-ascii?Q?MC18hFO6YbhMGI5vzEovJA4ud6tmwecuEyhyvJHQYz31Jc+6FfmiU7museEK?=
 =?us-ascii?Q?Y7S8DqspVjpL56aQzOZfl9h/LEUBoQn3LwF3oT/UwtspUkTTi+5A2TYqlrxS?=
 =?us-ascii?Q?jX5h2c8K+QUcBaszf2cAYXnpVxfmdnEhf6aZhEeeg+W4YW1+vwgnGaKLLl+X?=
 =?us-ascii?Q?UoFt5l8mnF00GwGyiuT3oFUK+oK3M1lLKjlYv4W5q0FvH7OfRb19afHyE3J4?=
 =?us-ascii?Q?u1LK2yMylP+QDDwPfM6TvtH8BoWJ3pUMmuYqGEdeysyQ/BjNuEb2bdv2GWli?=
 =?us-ascii?Q?uH7dwl3Gfjpjy37mKvgy1Zdre01CXr4nDAtXCha/2JAXRjGE2Wkwukqph7x8?=
 =?us-ascii?Q?AxiC26UTYRAkcP3TsQ63/kwkTSWdm0GPbRhjxAkePpDiwDrVpRQ7ItoKCToZ?=
 =?us-ascii?Q?C5YEp1xqVPvYKWY9zKsdCEhYbCJHG2HZLYeBDYLzgCFseUdc8XXn6ZA4lkGc?=
 =?us-ascii?Q?QcT4Vf7w7jD7I9aR4aeUJkxXfoBfTc/dmSQkoSUM74aBXXvL38bm/1gYqtBZ?=
 =?us-ascii?Q?Ch8Z5bkcDvZZIUPyqcgeC7nVs3XB8xSQ/jVJ7gzYfnoTocRj98c4INy4EoqH?=
 =?us-ascii?Q?ws6PMD9EHEdIT0W0x8LItwPcoKu7Jayf4cOGcIp3zJJ2umgI/FTmrXKnaj6b?=
 =?us-ascii?Q?7ZkvdCEH7wiiusXiwnY2Mp1MoocFzOqfsgafwDL3QGG76Q/Q2+7O9UXflKWW?=
 =?us-ascii?Q?8eEzsAR6p1+QfXyHuxMWiUu4ofqIMss5jA+ge3P+uJv7AAXdKMnv8eJlmjxM?=
 =?us-ascii?Q?xmKYdbJuQ23nx9ucHY4cDWe0rG5NFrZ3OueI72DECNGMk8EmCnjrkWslbEPX?=
 =?us-ascii?Q?b/iBZdZ3XW09+ng++OexgeXm2c/AFwbMjqBjqN8kMZ60XDweS+oYVwcc9ssr?=
 =?us-ascii?Q?FWUbIxHpWLXJ6Im2vxl8aOzBOwCHNv8enXv9/u0ubjxUmjj4t9U75n0Pg12A?=
 =?us-ascii?Q?Fh7TwpDvv76SI7/dd1PUCaN4I9Ow6+fyb1OYLprW+qSlDci7h/dLo7MdSij9?=
 =?us-ascii?Q?B6kBrNLpY5ecc9QEodSdje0+hZpkMVs98TDgpkZXCHwzv/javpCG9GRfk7zx?=
 =?us-ascii?Q?tiOT364lwfCarb7kjLJEYXPJZpcz6XFtrKY+tu12+ADATszyuyS015SHQdUY?=
 =?us-ascii?Q?ypb2rpxbv82YjCFRNFFdjU4oD1A8XufD94kWYuxb3XwgBGM2iLyFJRNEaZFp?=
 =?us-ascii?Q?TNDKGECavHJ+t0Xn4D4EaT/UW4Bvq4mvxCyA3HcctSQAwyksgdFK5mTIVEfp?=
 =?us-ascii?Q?iZO2tjJtKAlXIF2HA0vfjqsF8nRcy8+JQ01UGejusxfwFn80zkbHo8mDmJoX?=
 =?us-ascii?Q?8mXes+lUID3nT5aE+0Mv7+9Rrer0GJvkgwf2PQ4Ls8ZSmPhGqeYNgHIZIcvB?=
 =?us-ascii?Q?SE3D+dqnPR0fw95e1Dp1NeHOj32A2FSugsp7eIJPds6g24xm8v1g7kaXc6DJ?=
 =?us-ascii?Q?mODv2ogElWkypn75o5IwB/nSuL5iipRVb8y9W/ueq7X8?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1b7cb2-1e24-4b60-faa7-08dba1bbfbe5
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:28:16.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1VBs1wJreexSafg4LpgIh/Sr0VbH2gUUBKeDgVp6lliUS2nV5xQywLAwlWi9hzY9UiElYpY34IYXk4CEmoVLw==
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

In ms_hyperv_init_platform(), do not distinguish between a SNP VM with
the paravisor and a SNP VM without the paravisor.

Replace hv_isolation_type_en_snp() with
!hyperv_paravisor_present && hv_isolation_type_snp().

The hv_isolation_type_en_snp() in drivers/hv/hv.c and
drivers/hv/hv_common.c can be changed to hv_isolation_type_snp() since
we know !hyperv_paravisor_present is true there.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Rebased to Tianyu's v7 SNP patchset: the changes are small.
    In hyperv_init_ghcb() and hyperv_init(), added the test of
hyperv_paravisor_present, which was missed in v1.
    Updated the test before the call of get_vtl().
    Updated the test in hv_do_hypercall() and friends.
    Updated the test for hv_smp_prepare_cpus().

 arch/x86/hyperv/hv_init.c       |  8 ++++----
 arch/x86/hyperv/ivm.c           | 12 +-----------
 arch/x86/include/asm/mshyperv.h | 11 ++++-------
 arch/x86/kernel/cpu/mshyperv.c  |  9 ++++-----
 drivers/hv/hv.c                 |  4 ++--
 drivers/hv/hv_common.c          |  8 +-------
 include/asm-generic/mshyperv.h  |  3 +--
 7 files changed, 17 insertions(+), 38 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 18afbb10edc64..fd79e632023e2 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -52,7 +52,7 @@ static int hyperv_init_ghcb(void)
 	void *ghcb_va;
 	void **ghcb_base;
 
-	if (!hv_isolation_type_snp())
+	if (!hyperv_paravisor_present || !hv_isolation_type_snp())
 		return 0;
 
 	if (!hv_ghcb_pg)
@@ -117,7 +117,7 @@ static int hv_cpu_init(unsigned int cpu)
 			 * is blocked to run in Confidential VM. So only decrypt assist
 			 * page in non-root partition here.
 			 */
-			if (*hvp && hv_isolation_type_en_snp()) {
+			if (*hvp && !hyperv_paravisor_present && hv_isolation_type_snp()) {
 				WARN_ON_ONCE(set_memory_decrypted((unsigned long)(*hvp), 1));
 				memset(*hvp, 0, PAGE_SIZE);
 			}
@@ -460,7 +460,7 @@ void __init hyperv_init(void)
 			goto common_free;
 	}
 
-	if (hv_isolation_type_snp()) {
+	if (hyperv_paravisor_present && hv_isolation_type_snp()) {
 		/* Negotiate GHCB Version. */
 		if (!hv_ghcb_negotiate_protocol())
 			hv_ghcb_terminate(SEV_TERM_SET_GEN,
@@ -583,7 +583,7 @@ void __init hyperv_init(void)
 	hv_query_ext_cap(0);
 
 	/* Find the VTL */
-	if (hv_isolation_type_en_snp())
+	if (!hyperv_paravisor_present && hv_isolation_type_snp())
 		ms_hyperv.vtl = get_vtl();
 
 	return;
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 93d54d8ef12e1..7d1f553ec0017 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -624,7 +624,7 @@ bool hv_is_isolation_supported(void)
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
 
 /*
- * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
+ * hv_isolation_type_snp - Check if the system runs in an AMD SEV-SNP based
  * isolation VM.
  */
 bool hv_isolation_type_snp(void)
@@ -632,16 +632,6 @@ bool hv_isolation_type_snp(void)
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
index 18f569c44c39d..f0b3782884d22 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,7 +27,6 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
-DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
 DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
@@ -51,7 +50,7 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
-extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 
@@ -82,7 +81,7 @@ static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 					cc_mkdec(input_address),
 					cc_mkdec(output_address));
 
-	if (hv_isolation_type_en_snp()) {
+	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -140,7 +139,7 @@ static inline u64 _hv_do_fast_hypercall8(u64 control, u64 input1)
 		 control == (HVCALL_SIGNAL_EVENT | HV_HYPERCALL_FAST_BIT)))
 		return hv_tdx_hypercall(control, input1, 0);
 
-	if (hv_isolation_type_en_snp()) {
+	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__(
 				"vmmcall"
 				: "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -194,7 +193,7 @@ static inline u64 _hv_do_fast_hypercall16(u64 control, u64 input1, u64 input2)
 	if (hv_isolation_type_tdx() && !hyperv_paravisor_present)
 		return hv_tdx_hypercall(control, input1, input2);
 
-	if (hv_isolation_type_en_snp()) {
+	if (hv_isolation_type_snp() && !hyperv_paravisor_present) {
 		__asm__ __volatile__("mov %4, %%r8\n"
 				     "vmmcall"
 				     : "=a" (hv_status), ASM_CALL_CONSTRAINT,
@@ -295,8 +294,6 @@ static inline void hv_vtom_init(void) {}
 static int hv_snp_boot_ap(int cpu, unsigned long start_ip) { return 0; }
 #endif
 
-extern bool hv_isolation_type_snp(void);
-
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
 	return (reg >= HV_REGISTER_SCONTROL) &&
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index a196760afa7a1..c98a75ae948e4 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -306,7 +306,7 @@ static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
 	 *  Override wakeup_secondary_cpu_64 callback for SEV-SNP
 	 *  enlightened guest.
 	 */
-	if (hv_isolation_type_en_snp()) {
+	if (!hyperv_paravisor_present && hv_isolation_type_snp()) {
 		apic->wakeup_secondary_cpu_64 = hv_snp_boot_ap;
 		return;
 	}
@@ -441,9 +441,7 @@ static void __init ms_hyperv_init_platform(void)
 			ms_hyperv.isolation_config_a, ms_hyperv.isolation_config_b);
 
 
-		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-			static_branch_enable(&isolation_type_en_snp);
-		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
+		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
@@ -566,7 +564,8 @@ static void __init ms_hyperv_init_platform(void)
 
 # ifdef CONFIG_SMP
 	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
-	if (hv_root_partition || hv_isolation_type_en_snp())
+	if (hv_root_partition ||
+	    (!hyperv_paravisor_present && hv_isolation_type_snp()))
 		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
 # endif
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 6b5f1805d4749..932b8bc239acb 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -166,7 +166,7 @@ int hv_synic_alloc(void)
 		}
 
 		if (!hyperv_paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
 			if (ret) {
@@ -227,7 +227,7 @@ void hv_synic_free(void)
 		}
 
 		if (!hyperv_paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
 					hv_cpu->synic_message_page, 1);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c0b0ac44ffa3c..d3f95a1be1e99 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -386,7 +386,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		}
 
 		if (!hyperv_paravisor_present &&
-		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
@@ -535,12 +535,6 @@ bool __weak hv_isolation_type_snp(void)
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
index 94f87a0344590..ac271f3b4091c 100644
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

