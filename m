Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6269B6F7972
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjEDWy4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjEDWyy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:54:54 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11311D80;
        Thu,  4 May 2023 15:54:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=As5p4FQi2sOVitQQKKj8LzX6f7aqaWdpJSygeF9LMzqglLB1NWxzqql6p2EIFGWkqK17gpe8iYKr2T6KCBD6QP4u1z5fNrtTeNsVzJS+Z4uVNWQdBOI0e/Wk4zJ1cLOcW0C1rHcS2nuNAJ1y3ZXRhzALszvjN3OE3IzJ4ZtWRKu/G5QOwaYEH5D+MTCuwJsVJ3agB0wBrQRVLIxIo1N1msQFFGi17UC+ldCgqJ15pwQqQN8P0wUmcNKfZb702OKTzc3WXVLBjjo6Fv5TwTjoBQ0BY23k35YQdfzih4lQzRW5tt6eRSb8Z/NUZsoWRkcrWIEC68AoMz/kusfWx5iltg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8E9Nk4FNiFw3SJfXQWE+zYXr8WlJktHjMyIKEPXEzA=;
 b=dVjN22pDEpRECyT25hfi7zls99PWWvc2WaPKq1ubhUoH39rkau47JKjCdY7+CKK3f5iHy5kHEcx48GzRnHwS3JZUReD8EOSK4DLcp9FkVBSUC9CKpfVp70CPmzBJWz1m9pW635y/Ni7R5nbj8kcZIix7ltX1VFKBjy2KP09ZeXFxmvq9uiXlAR6mpM85ojEg2eb5clBBJ7CnUWSW+8rfMjoDSHx6DQOSgmk6cpt79tqTU3NoQA/rqOGbDxzWFk8FikI/vs4pGLuCnvZhlezGYKFMZQm8u6EKN02tUFLPHgYeXPnFmAFH1LBMQNcHTFgIgM6sJcOoQzf+zAqSb8d/oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8E9Nk4FNiFw3SJfXQWE+zYXr8WlJktHjMyIKEPXEzA=;
 b=LZJPbVdI/ztKWxBOyvqrd+9V2iYU1CfAti3zQi9DmWffhGlzoJJZ4FM5XKSqhNI3ZRglf0vMURNFkW8QGzQvp7/Qyd/WS4RgogTpx4bFj3EjL942bYDICwos6XjVtb1p0MqTi6u6Nd9wT7FV7s9V0bmJW+XqqyKnO1R78a1SaGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:51 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:51 +0000
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
Subject: [PATCH v6 2/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Thu,  4 May 2023 15:53:47 -0700
Message-Id: <20230504225351.10765-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: b70d12be-4f96-420d-b0a1-08db4cf29171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x3+C0bFHHXzXL/S1w5vbpyD49XsXlenhxgl29TF2cR3TrxrbGF7cjtWY6nax2S4llDnFpHfL0JRrmrpDhhKPCfWGjTAKkj2PFqf76tnJZkV+JXV6aSBShMGrFVxZdwaZlNwOezXdNQhWB8M/ONY8W8NQggmBi/GWNBGKTBOLR1hcbYVuL6r2TvzUfVtSj5x0u+ay0LhxDxBXuYIuRjN0RaaRA31VL7CRHofBFgzRzJIYpJElVN+TG9Q3DMdh7daBHEN0NRbPQSs/m7/h5us7eWiPxU5zw4Kmfqgw/LrCVobW3UUtnwAJvCj5WS63kRoEHXX24DQL0gdWJDTdHNkkxy4+EqPxuenPRPPpmHJ2K9Mxl37Y+fKfPJkGSKPl6VjxaT1gTV0g06MBEJpxu/i4y/h3KZInTqGQ9nMk+bI1WkYjmpKc9u93KvEai9f6ovdOSrF4YnX3Uzruc+b/UVBJKbuteNj9AgeZ63+YC5/iGyfUIzkIOTvfoe4OczLJ7/g4d04mVxaPdHoLL5s3YFhUKfrd8qfC9C+4qnopHsosAXwTdoSQAWahYi+Yd5uMaYnY8bnKd6CehWGiAjaB1cwJlyj+FVquCr+y/+SaQKH3t+FCIkyualmBEVA6d6KN9ksl4ZRLiC9+6zgIhlkVHu46RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(6666004)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0+hKvBATs+EdyYTnwcdQODEHnEPu6354LzzewHssS+cd44yTa97CDwLCuGAK?=
 =?us-ascii?Q?PzboNIw/dlwA63zOdYTeMwTYrPfXF9EfB/OSFegmmk6QFYYRskjRNTQX6XRg?=
 =?us-ascii?Q?sZQAq4ZnCB812yoBshiDqDVvxDN9pJThbL1muZdpJ02HG7coJahhkvaA20s0?=
 =?us-ascii?Q?X5ARvLv8h0KFwANIFBOclxV9Z02zFxWogandUhvvsjHC4izGm+pxw4Nij8jt?=
 =?us-ascii?Q?2UpScG0UHfnan2Cs3XjIKTHnd/1CVgqq/4f6jOKmC0GlYqZkNh4Ik1O4Rnlx?=
 =?us-ascii?Q?9/6Us4QPlScOB8cA9VuTyppPtWZPed6362rMKbIHjZ4bAyhqtxZxjBBVGCnm?=
 =?us-ascii?Q?3UjZlK9HKBc/mdat2uV7v4o20n6k4MSQAX9413DI7ZzqA8uVlZzKVJnGWKJp?=
 =?us-ascii?Q?hRCfovOFdcycJ9ufTbikcAA4WBdHYHI8GdNsWeWQIRrH9VhwFchc8BfxCW2T?=
 =?us-ascii?Q?ucrjs9L7KllK7byFVpUPhkB3NHbvX1f/DG/lkJtlJBKEvqLTiCxqgfbFL+tp?=
 =?us-ascii?Q?joRVGR3ac50VGlXxWPxv+JL0Ff24tf+CGmCngXOITmBWim+XSH6ZCD11Rar+?=
 =?us-ascii?Q?eOOtqmVxdQ3j/1Gix3wC6F9wWZp+246h+qZE1ChJrfPYHoDu2gRhhyGMmXPs?=
 =?us-ascii?Q?Aq0+Wf+UDCG8At1pIY/k6Ra0MPmPjVDQHWpg/B+Sb1pLirc/ebMzzW695wZm?=
 =?us-ascii?Q?40mUC4nA8LBi5QlCiYuYZCGCe7X/dx2DDGsHWUrXf1lcKUqffYy2mYPQHlwa?=
 =?us-ascii?Q?TZobE0TvywaxWlAqGYowqmc/VMKFXMJEMX920bu0Fg/zHN3Z67zl+mf7wgtS?=
 =?us-ascii?Q?ojfSFnEuUdOzJBKTqIYfXUjRxVTts+fobi0JljMLlf67WLyohMxJv0PvQta4?=
 =?us-ascii?Q?jREreY6OwajyjeYlbbj+Das7DD6eg6Dgt8Eb6x7j8Q0Uy9VT3QuFHVRL+UOl?=
 =?us-ascii?Q?kTvFnsYQazUroAq9eyGEzajOg++bLaSsPsBvT/wbyG1BcWfh1pnmMWATxGzp?=
 =?us-ascii?Q?34ZT6/dXXLuCYjJmJEbsmRkitN8zGOF3lmM49R4PI8HIMWR1mGMnML04e9Uq?=
 =?us-ascii?Q?MRTnPe5UGA7trxUW2ENca0a2Mj+HYHiO2tKyMWoeQUb+XIkcmIKyAQSEYTl4?=
 =?us-ascii?Q?Ce+3iYyw5+M7KK8GT6QCqUMmJBz2/8q7+KZDrv2PiIF3bsXIcu6CjgkcEMfw?=
 =?us-ascii?Q?sSxezAP65kvSrSaNAS+kfbJ8QXXMvNsIwbt5W2V81fpJyWrIcl8PL62XXyoR?=
 =?us-ascii?Q?fmSseYdhA/mvJBp17r0SGamCU7bGXBcj62JSYsgR1TPXqzEx+5ZTwfudP6AT?=
 =?us-ascii?Q?pfjRup8G3s4N+ejQBLSghgnVhBLH0TJVt6m93spHbuT0vdqxovKJxnaTKUht?=
 =?us-ascii?Q?PP2EPFjTDxrNg1eLfYO2uRqKh4R211rI5h7LV+KrVVfOxKR/wxzHzic7fKIh?=
 =?us-ascii?Q?4c6VPgeKdJsO6W0i7l9J20WrVSgF5oJ+krAhIhwkeVj8YezH+VWoD/BI+Hfd?=
 =?us-ascii?Q?oyKJWFtIuzrMbPf2CQ9s6StNkbHHgkx2BG06aNa97OPphdvDaJbYkR8nRTR/?=
 =?us-ascii?Q?6mdYsBiv2Zz0ZlqFkUUJys2CnoO6NPttNkxG1dbjjXYxTQ0FVcbEmfpFSoRA?=
 =?us-ascii?Q?riKNzPTB20th+jdn3iqVtYknm/WTl2rgD3qVFKyNdD8A?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70d12be-4f96-420d-b0a1-08db4cf29171
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:51.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0L2WymJC7dRfrKvuFG0HKx9gxwh1oibbHPj3J/k2iWgb6gVrRuzmV0pSP3HvKwOLKLxQWglceBIyzPcPgmcgw==
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

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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

Changes in v6: None.

 arch/x86/coco/tdx/tdx.c | 76 ++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 24 deletions(-)

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

