Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD0668C6BF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBFT0g (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBFT0d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:26:33 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038FA25B81;
        Mon,  6 Feb 2023 11:26:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbVjvbxKPE8aDhSi2cjIoFZUnq1uB76HcpYLr8qnNE8XdECumum/7SD0ioe1S/vZeffH9CTdXTbed6NMjVOCJ+rZKk8jguilUKAvGLUq+6o4SH3kuoQh3eIxdolcwENsLoXBekstyRVhRjD9fQmjprrB/vKIASHc/iNR5FQlFX9nIRPZePbXJlMPAw7X2RCeb7phCQImpxpzSzIpUUQvr/8XD+kAVSm9uoOd3hnoMXYaPuF+Tl0CIQB/tBh1tNYGsMazZjdq+cDYXPYh8DMr7C9Ncu483mD+YYdjgDuewAq3kqN/PoSr7GRaigNahiR483tzMMwqfcOXh7cY5Xm3iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOgQLiEonHxCwNZds7z+mDHBCZ2fWIuWAQ4zNvSPzog=;
 b=BlTB2MpalHaIrjB/BZBBPyXKxFS+W5BcigbKD+k+tRFrpeCDDHLth1CdN1w9Ue2e0Fcpkt/rohbU2fqeXE4yJeAH4QHhUi6jT4xIRQWZ871ENHEg57dX3VAglnNAzC6TRTOs0QbpJF45geuo8FbL8bTqEf2AvgBbHilhvAurSNY6H1QP7aGH9mKs+cQNG4vNo6H202Mlao/CQDUcUxWerD0MKr5I04zFdVU4Q4YapiMqlws7b0yTFlSpyGnk25jtnm3ZiA9yECAIgc6kBjmWTth2Otk7L//t/HKyohAxZDrAkPTgGIw9pdb3XbEcnp3KepzBUfeB1saA2MifAECqfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:22 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:21 +0000
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
Subject: [PATCH v3 2/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Mon,  6 Feb 2023 11:24:15 -0800
Message-Id: <20230206192419.24525-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: f6dc756a-76b2-4e3a-2e0b-08db0878071a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UkPHNQSgW7UGD02xawUcItpTEqUK79kN1Ylugg4kwLIAzg56iuD01jwFOaRw6peZ5i1FZAI+18lsymtLItxwgV9pLcJLeC0Q/QaraT6/Jq75eI+dkyoyij5dNJPjrWkH+8oIUDudB2Uv/oQe6r1AEOpucVWrHfcYqHx2Y+BD+TTOgWyap92mseIFOFh165cLNmH+vs9I/3F8bg31B6f19dDgPm5suOTj75ZP62+rRFLVMdTWa21UVuZgypjSM/rhsrDs+25HxZnF1Z5s7BPmvsThhs/Clv+CFSEV02hilPpsluiKzJB7lFFuHJiS/biUi6mkeuf1/Fo33fw7Behlr/rjUEYwQZLR96ONOKrRo3SIy6baFVHmjJ0YUhvFC07gNFs+BDmtc1q3b2I0vsSi7boCe3mNF35vefriDAJ1bngwsZ53Q0b+YQ80+4Pv6OeLAzjy9wWB4SVF0MndtaGzN/Y/0qINO2hXgADDdE+/9jG0kpDNxiImKbb5Z4E2rHmcbdDN9BLVFmXP8mWOpt22yr4CRDlmOR1QhacQh9N3k5ARHtm3OAfJD4TwZ3bWB6PIrdEOaTB2zxRAj1UZ5f6TNlV4LcmZDN4F5NABlFDuNRc3R9gFW+peuwL2ULXEZobfOD8l0ddqml9eRFbiblERLOG44vb8d8F7c+OyqxfDiUKeXZu2ZG1ehKg2OG6aIkNJ0bRV8+q/arsi85YUdqB6wNMJVv6icQpM8Bm/e5x/pDI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?enoq9TLKmAkgzo6XR0oeMHdzi7WtSiYeAKasJcuT66ahQrqHnGlw1SytY5R5?=
 =?us-ascii?Q?Jxq3CjSOMMZpd43IzUpImGmc9Kh9qVoa3dfhHz7ljR2QprhblYGZCBpaFSvP?=
 =?us-ascii?Q?P234VVOSGSV2e9wGtGuxEKenT5/xYkrONCpsdRK7nZUXvCHV5A/a2EA+HOVq?=
 =?us-ascii?Q?kgP06CIUUOAq4yRgwSTgbev47z3g/qHOfwt2XUeryXWYoWjzrNBE0fI1zIUP?=
 =?us-ascii?Q?oLz+18WWhQO2QLjbgrIQS5EyiQ7J4fjRUX8Gy3KNn8K/ruaL8ygV/v41lOWC?=
 =?us-ascii?Q?DCaiyo8B/jVxHFDRVOD20d+UfwpxqMiwb5fi+3aPbEcjsUvcDRkx2gyZaWsD?=
 =?us-ascii?Q?6e+/VZyYoLIaO2lUiMjneRuxJUz/NotzZddL5GOWDKyhnkpyjcVvOnBL+AUg?=
 =?us-ascii?Q?WLBsiZ/zYpS5S5Me/1zLrvo+7SAQI34e00XIoentu5Ng1Xfo8IJXv5XEc8k8?=
 =?us-ascii?Q?Hmwgoe+yAkc9EFo9+6D5otGw7ITIB7kpXpoT/tn/lsx5SBhB5OgFnpNf4uk1?=
 =?us-ascii?Q?R1fc8+HziIhjiG4mFe8Y0jYeZP6Sx9D1PvrCxOXVs+6bA0QpoVh2jHxngjn7?=
 =?us-ascii?Q?/AL+vqigFNlmqrktv/ISzqeyhZUqQl1oByYnaX3mPHRcvPj+pXMb9tWr4VS3?=
 =?us-ascii?Q?NYY7HYJdZ5SyWpIbpjAd8W96zpI/pZPenoVf2CHQ7I32xrCQM5ih05KMZsco?=
 =?us-ascii?Q?F1oBJoVhCkbHOUfzyatZGyvdHN7zTXfT8yP+vSbvZWL0NRksjikinycSD2Bs?=
 =?us-ascii?Q?A9SUpTWb3eM3W2OmtqLdKThFQGCiUNqJWjUq/Ql3UA7h9Hi1vSloCbc3Qugb?=
 =?us-ascii?Q?0T+2EdGt7ggigtW8qj64AFdzXahrlqicTi1Ko0UXaiU7SMrCf/7pQ1Qq60PM?=
 =?us-ascii?Q?INyBtIsL2AGHOyfc6hKp1yI/mvyTR9bqcramLYcPRXmgAmBvU3Xs++EGDuB9?=
 =?us-ascii?Q?/NUxNVkTIb1QA5GSCqFYdxEur+yNiLPe7WeHgSB3dsdheiQ5Bhw5Og9B7LRu?=
 =?us-ascii?Q?0PEBH96LwvOLHqVLreLsLsQY661Bg7GZbEexexn416GpZiivJiFiOfB+GliF?=
 =?us-ascii?Q?AZjQmFT5V+lLPhtEmRNrCB0pC3vGXNjzDQrHppLchpg+Qh5JskHwuvR69ODh?=
 =?us-ascii?Q?5MB0VYpKYvHsa0Yj/PsZXfYxJj+YV2vjeHG7uUyK+zrrNJDACbowS1NTfBWm?=
 =?us-ascii?Q?OGcI92fXA0FE9iwBE78jgujNBsj4ttTdR/eAapaGn613tH5YkgN287HcukJk?=
 =?us-ascii?Q?+0WwiBN60ElTqw18auHnToOX9/K0S5nVkpdhuLYB5DC0u7j2d7gasN31oavZ?=
 =?us-ascii?Q?w2to1zAlnPjfjSvHhKPYEW0eHCE+pfy1G+k62540f+6JXlyE3+OZoq3rU2dm?=
 =?us-ascii?Q?Au/7kpqTQKDYoM9d4f7tkiIQqspTAoYG5dXXPH4mmyD6uq46dVkNw3Yvn652?=
 =?us-ascii?Q?Yy5sxnH4kbjmPx1fOaCipJjC8U5+2sea6OzJql05u560eqaA4mRwuoqorC23?=
 =?us-ascii?Q?rCxZYIpr4mYJejLXKfAiT7YcgdKxScbR4RmceSs8jeqrCAFeb9uJqQ0UN8VW?=
 =?us-ascii?Q?rz8qfr64P93SlaGX63pfmRM3rU4Y3plKnQqpn1YLyrZQq8N5qNZdjl+SnnM2?=
 =?us-ascii?Q?WT+bh4jkw9D354CTwvTKZAqeQ6R3/oqdnnYNXEbPsxxN?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6dc756a-76b2-4e3a-2e0b-08db0878071a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:21.8978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q77ODeSPYioz6D98NthM38aawK6e7NNR3D5moVyYxhW31beAQhaN53KGsKAVQTonG/3o6ROxLd1iUUAR8GZggA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

Changes in v2:
  Changed tdx_enc_status_changed() in place.

Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
how to get the underlying huge page info (if huge page is in use) and
try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
underlying page allocation info is internal to the mm code, and there
is no mm API to for me get the info in tdx_enc_status_changed().

Hi, Kirill, the load_unaligned_zeropad() issue is not addressed in
this patch. The issue looks like a generic issue that also happens to
AMD SNP vTOM mode and C-bit mode. Will need to figure out how to
address the issue. If we decide to adjust direct mapping to have the
shared bit set, it lools like we need to do the below for each
'start_va' vmalloc page:
  pa = slow_virt_to_phys(start_va);
  set_memory_decrypted(phys_to_virt(pa), 1); -- this line calls
tdx_enc_status_changed() the second time for the same age, which is not
great. It looks like we need to find a way to reuse the cpa_flush()
related code in __set_memory_enc_pgtable() and make sure we call
tdx_enc_status_changed() only once for the same page from vmalloc()?

Changes in v3:
  No change since v2.

 arch/x86/coco/tdx/tdx.c | 69 ++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 6e2665c07395..2cad4b8c4dc4 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -800,6 +801,34 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
 	return true;
 }
 
+static bool try_accept_page(phys_addr_t start, phys_addr_t end)
+{
+	/*
+	 * For shared->private conversion, accept the page using
+	 * TDX_ACCEPT_PAGE TDX module call.
+	 */
+	while (start < end) {
+		unsigned long len = end - start;
+
+		/*
+		 * Try larger accepts first. It gives chance to VMM to keep
+		 * 1G/2M SEPT entries where possible and speeds up process by
+		 * cutting number of hypercalls (if successful).
+		 */
+
+		if (try_accept_one(&start, len, PG_LEVEL_1G))
+			continue;
+
+		if (try_accept_one(&start, len, PG_LEVEL_2M))
+			continue;
+
+		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+			return false;
+	}
+
+	return true;
+}
+
 /*
  * Notify the VMM about page mapping conversion. More info about ABI
  * can be found in TDX Guest-Host-Communication Interface (GHCI),
@@ -856,37 +885,27 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	bool is_vmalloc = is_vmalloc_addr((void *)vaddr);
+	unsigned long len = numpages * PAGE_SIZE;
+	void *start_va = (void *)vaddr, *end_va = start_va + len;
+	phys_addr_t start_pa, end_pa;
 
-	if (!tdx_map_gpa(start, end, enc))
+	if (offset_in_page(start_va) != 0)
 		return false;
 
-	/* private->shared conversion  requires only MapGPA call */
-	if (!enc)
-		return true;
-
-	/*
-	 * For shared->private conversion, accept the page using
-	 * TDX_ACCEPT_PAGE TDX module call.
-	 */
-	while (start < end) {
-		unsigned long len = end - start;
-
-		/*
-		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M SEPT entries where possible and speeds up process by
-		 * cutting number of hypercalls (if successful).
-		 */
-
-		if (try_accept_one(&start, len, PG_LEVEL_1G))
-			continue;
+	while (start_va < end_va) {
+		start_pa = is_vmalloc ? slow_virt_to_phys(start_va) :
+					__pa(start_va);
+		end_pa = start_pa + (is_vmalloc ? PAGE_SIZE : len);
 
-		if (try_accept_one(&start, len, PG_LEVEL_2M))
-			continue;
+		if (!tdx_map_gpa(start_pa, end_pa, enc))
+			return false;
 
-		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+		/* private->shared conversion requires only MapGPA call */
+		if (enc && !try_accept_page(start_pa, end_pa))
 			return false;
+
+		start_va += is_vmalloc ? PAGE_SIZE : len;
 	}
 
 	return true;
-- 
2.25.1

