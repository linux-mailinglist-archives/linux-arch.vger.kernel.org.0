Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A59B86EB6CA
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDVCTk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjDVCTe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:19:34 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4DC2100;
        Fri, 21 Apr 2023 19:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFTzJ5fwlU/ZS5gw4ZnQFVIQ4EKOpACdqqcdJpNpWSOuKtPw15vWca5jvvLzPyQ/JMbXf+80n9CJwn1BxF32S6qdP4s+724UchfWgSDBdHG3MMWwDi/FUvZEFLv4B0nFMaUmakFNbQzY3NzKHkLtGWkM1rFSORz0l8jCTdLCmQMjdTb5WDsMFQNxzUU96G6GHVOWc5s9YIVaAqbQMrbGw7MUt8t3nNWPjGGHjnLmfMwH3CnZ5h5NmZL7mzZDINp71f1yyf22FHisV3nfgQ8ybh9nVafWlrBNid6XA+jJGO8ZVmZ//rFjVjF8K2dieFZZydRxunPYKdQSMMzPKiNR9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNLlz0cSXewC7JIgVUN898xyrQRDEhO+WjYNVIJeH9k=;
 b=VHc3TauNPMrATcIlPhdyRRGY3vYNWkVqJHaGnheHfw1/xEELCfN99cVjVco3P3XBPgW06OJTGZ8stdGdPsZIhq6gkikO/mU/xhMS8/NOLerADRg5T7TieMSPOi+60Rc9Hz8FV1JLzXcBwj2MUjlf/H2MuRRzIXKBxA/JDQNPEiAUJkvXH5IKD0wpYmy7HaPsMRmMUmJsN3oyXmaEDt/4hGySkr/JQ1943V2VCe3KBU2VHzZsFSu8kXCxZbfoaYfr+CkCFEGHR1DUTX3OGgglkdDjEm6jjuwiHX1IOQVKJw4cKYTpUWCreFB5UwLMdGHEIrLWGvTag9tl9uonDeUDJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNLlz0cSXewC7JIgVUN898xyrQRDEhO+WjYNVIJeH9k=;
 b=Q3KIm5JE22U7xZTzs//w7OjNE8DZf3BP63taPYJ8Wj2AMq5lIbiw1eNl4wX0xRHzSAsjLKRotpB7vCTQZX3TwRzlVNods0CJbT+rF/bAho38mqrsSlbtbE9mVWmDl8gLN2M9NoTusR9Eu6v9xyFmsbFFylYeodp5iU5TU3tohe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:31 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:31 +0000
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
Subject: [PATCH v5 2/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Fri, 21 Apr 2023 19:17:31 -0700
Message-Id: <20230422021735.27698-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: fb4c005f-8932-4a13-6d76-08db42d80195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xNUbyANkpj0JXqU3Y0m2rVU+Mwc+q91EDaO75aqBvViyoNSMwazNQxVOQ5nGlfwuesrFdVJi1wmNxrbVohywi6KwqgfGIW9hIQQmEZNFVVbhUBJ8yhVb7QLPNoJNkpBBLG2sNuxG06MaYnftbsQFen+lt/ypmGylb4NJcjy3K7YypUvbdS9Bq2W9mnqKaUlwgRi4Nboen6RDrDJUhZkmTzdce3/CoA2MYv5pD7G15wcl0Fsael8mUHE0do6iKFKdsF4+QUIHRnypzKYXG3d0CJku/2FCACSnM6MwwaR6bwVtQgimR1XDYw9b1DtFPB2OZ1gWEYCDA9gV6VaHwJk66ggfIswkoNTJWVvMLQ99gdXDyhrPc4ctalOL6SpkwcM/Tpt+FRsiIK56gCuCVKKZplijQa3iQun3gOqFPfLNk9kW0tc99b93DBZSXFvjgcD3cDV4lOlF1xMqKPiz/cNQ/xSLV1ymjK9oNHc+JRoRqL/6jGuE9w+srO6iWHptl8tZGZxD9bINb9MR6KKKbfgnNfp10EFvCn6CCBdRT3NujvBN8vyRH6RLiSsFCZ1cu8DZsXiGRDh8hf11NjOYrYhmdfQ+d06TmVVn2rOqusVyARoe5K0LcA8RpZzECUBHkzK7YSiqVvJ6dz3IFXBtPfAxug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(83380400001)(2616005)(86362001)(107886003)(6512007)(6506007)(1076003)(36756003)(52116002)(478600001)(6486002)(66476007)(4326008)(66946007)(41300700001)(82950400001)(82960400001)(921005)(66556008)(316002)(786003)(6636002)(8936002)(8676002)(38100700002)(10290500003)(7416002)(186003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qT6XG4nBUrHjmAW/bBkKT69rApOFLQE0tvRu6z32i4YRO0MbypGzYaQxTPWr?=
 =?us-ascii?Q?xi9sFC6V0B8k5EkgSgDYYuVv4z2YT47yLTTDWxylpFFWcre3yg7IPnLe1i/u?=
 =?us-ascii?Q?g5XO6qLyspHRXLtzljaBJnS93qbpj35m0JV0OFqV7g3UFV3HbRc0Uwdgo9Zo?=
 =?us-ascii?Q?E64hiYn1ghbl4tnP0wGipgT41OAMhtYKGzymaFbKXXQswNlT+iHrTjtaS9Rq?=
 =?us-ascii?Q?8nN+Hw5AEeQGvDOTDJqRKj42K5bsF2D8C2OKVmWKrnhmk5SvfofmV/bNff9n?=
 =?us-ascii?Q?AC3KyXc4Wju1F1XHYC72yi5Hn8/QJvz37eh2RD3eWKMLI7HRHKv8Mzu3UwL5?=
 =?us-ascii?Q?fLu/DWWbbMtFPfuMiHL/r+XrKued5fLw4t5cGN60o2huRIxiXM/e9mOQyHIL?=
 =?us-ascii?Q?F3ijLIjii6E0luKajtjpZ5BbptDhmNwzqVELfxLiT6DLDv0bsUhUHCyGyIln?=
 =?us-ascii?Q?BMYDP9EJxvUIfASOilZSYnMli/NM4TFiT2dXg2W7yA04BjDGpYm9l+w0EqT0?=
 =?us-ascii?Q?GTSgGaQY/VyVdMJ5Hgl+xkX2GKF5vnPDeL6/ONtcuFBYj5qySnoNOg0LbOB3?=
 =?us-ascii?Q?jqD1CHCfOURc5uBLGgNMo0zoEYWIainRs0ENDIInqfeJz7eVekWxZf4uOh1d?=
 =?us-ascii?Q?nRo7RQFSTm2+4QrYkDTXfezcMW0zMRtx7SsY1+ZmUiju0sXt7D3a56jR54w6?=
 =?us-ascii?Q?vXu8YodlwbxAgdEKaS5LfO6qDBTfHo0UV7Qf9xgv5NErKaTPvSaCGDUUk/zg?=
 =?us-ascii?Q?lWNelNctY/RdjBzF4tNUQwZxROZKFp0qj+Ep6t26/vQmXuKWyL4bDx/cze6k?=
 =?us-ascii?Q?hydhiMpGBYxqs9XSFkTNJEzGhRt5JfmBERDLQlPAuzkukG05ISM+isv8i5+6?=
 =?us-ascii?Q?l5aS899PqOa9/EsO97JozjodFY0ZAe39UZhfxiQ6n4EwrySEDaRHjhvjOYOg?=
 =?us-ascii?Q?OrDbGxukIznhMEsTd7UQ/hrQdg+ewMJwhpc/A6LAcdC5WhWw9V6XIq4TMRQl?=
 =?us-ascii?Q?Y+BM574CssCK7isWH1rJTxEz8GmZF0c0aTUQnyKXagObPGc4jxYsYHB3m40u?=
 =?us-ascii?Q?8td5boAznAZhgsLzs7m09VmYLa4xauAW1LbsTBzFOQUouHhnIE8pVXYkKdXe?=
 =?us-ascii?Q?lEkJs1QTzjGcYSB31rJ9WwgaDEBuPngwCzBgAsCYw0YAzAvAe6ALniFtbfk/?=
 =?us-ascii?Q?8fnt1G6PmV7OQk3ccQR5chmg3We4FSD9BQ5jnqF50sfK3NCEmzClNVNnWXPS?=
 =?us-ascii?Q?DolL3RputIjeYcVV0COFhzj/2Ff07UAmLlAQuj92+jhX2WaOt8BFRUSr5WMv?=
 =?us-ascii?Q?tqPymNq3oxgBKE+PktavYnxqPPGU3ca7MAbehQ23h0MKqxCib8xvfwtzyDsM?=
 =?us-ascii?Q?8yA+OWMKQgww+wLyAiEaV6YTz01RPhvnZwfadOQ0MYtu/ZNhxTtzMyYibNSJ?=
 =?us-ascii?Q?segZoxqpl7iyihw2jbKm7ufah/mCKAwb11vNWKhf0uFPvYi/FvqWqmKBDZuN?=
 =?us-ascii?Q?yNjA4UvaV4XqShWTgzdEN1lnwYoCM4sUfkY1Xsu/vXkkHk5VcNQS3jNvyKmx?=
 =?us-ascii?Q?ano+caa2dVBbG+Y8c/g+JH7SMWnqK14958XE/Fv9DLqo5WKOgsYY8TiPgKHY?=
 =?us-ascii?Q?lU3hw3ahJNVXZwzirSyykibU2AWChzQCqTUHTN2OT0b2?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4c005f-8932-4a13-6d76-08db42d80195
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:31.3592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f30hbCgf03KS6aX4qmLZw7O5IeM71jQWN58wZJCGdqfAmMJCHkQbs0gLkaizHoemFTKIGmNNU2E3R7Ay2b2T8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c | 76 ++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 24 deletions(-)

Changes in v2:
  Changed tdx_enc_status_changed() in place.

Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
how to get the underlying huge page info (if huge page is in use) and
try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
underlying page allocation info is internal to the mm code, and there
is no mm API to for me get the info in tdx_enc_status_changed().

Changes in v3:
  No change since v2.

Changes in v4:
  Added Kirill's Co-developed-by since Kirill helped to improve the
    code by adding tdx_enc_status_changed_phys().

  Thanks Kirill for the clarification on load_unaligned_zeropad()!

  The vzalloc() usage in drivers/net/hyperv/netvsc.c: netvsc_init_buf()
    remains the same. It may not worth it to "allocate a vmalloc region,
    allocate pages manually", because we have to consider the worst case
    where the system is sufferiing from severe memory fragmentation and
    we can only allocate multiple single pages. We may not want to
    complicate the code in netvsc_init_buf(). We'll support NIC SR-IOV
    for TDX VMs on Hyper-V, so the netvsc send/recv buffers won't be
    used when the VF NIC is up.

Changes in v5:
  Added Kirill's Signed-off-by.
  Added Michael's Reviewed-by.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5574c91541a2..731be50b3d09 100644
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
@@ -789,6 +790,34 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -838,6 +867,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return !ret;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* private->shared conversion requires only MapGPA call */
+	if (!enc)
+		return true;
+
+	return try_accept_page(start, end);
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest. The VMM is expected to change its mapping
@@ -845,37 +887,23 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	unsigned long start = vaddr;
+	unsigned long end = start + numpages * PAGE_SIZE;
 
-	if (!tdx_map_gpa(start, end, enc))
+	if (offset_in_page(start) != 0)
 		return false;
 
-	/* private->shared conversion  requires only MapGPA call */
-	if (!enc)
-		return true;
+	if (!is_vmalloc_addr((void *)start))
+		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
 
-	/*
-	 * For shared->private conversion, accept the page using
-	 * TDX_ACCEPT_PAGE TDX module call.
-	 */
 	while (start < end) {
-		unsigned long len = end - start;
+		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
+		phys_addr_t end_pa = start_pa + PAGE_SIZE;
 
-		/*
-		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M SEPT entries where possible and speeds up process by
-		 * cutting number of hypercalls (if successful).
-		 */
-
-		if (try_accept_one(&start, len, PG_LEVEL_1G))
-			continue;
-
-		if (try_accept_one(&start, len, PG_LEVEL_2M))
-			continue;
-
-		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
 			return false;
+
+		start += PAGE_SIZE;
 	}
 
 	return true;
-- 
2.25.1

