Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B505C732652
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 06:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjFPEr3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 00:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFPEr0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 00:47:26 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021015.outbound.protection.outlook.com [52.101.57.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F02D5E;
        Thu, 15 Jun 2023 21:47:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAOVsmocBBCPLPfkMsH6bmpeWnS5i8+ngn1xG7WWP5dESFMZlAUhFP7/nDfd2eLxrbVyYbfBw7Lm+/jXpvRMGDwdMVvCz2ozTYoWe/te8/4mmRqkNBZr9w5/+LOiya9I3tsT4BCunD4ey/Vsuc7gBQvjkkfyTLWigy++ZNvz5En59XRLksYYjYFqll6BABGtXkxhn9s/O6rjOM4VuR8NapOCJ3KwJ3T4Qg7GPtaKB8ozgcJsYc8tJGzypxtqqUgrBXUVkRKfkRGNHV9tk0o106OV4BHJ6IX2JBG5VYjpjAgUO0yocAhFSeqn2wGDZGkMJzyFlvYSKlSmwodYSpWzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QZS07VMT8YTKzlEOKl3OsPkDSLbUqrzjdJ8lnP0iQQ=;
 b=OgbM0pXF8uQ/MEmHGC0Q6miG/tw21qjAYG4WWpUkAEdefoBjlay2Kf80hWK0jCZS9VkG83q52is7f54UcpdN0Ug7dsZ4tpJD63txzQcKoDUhG2yZvVdb/UR5SwRpCk/yH2C1tsYktvdFjIxeCpTbibLSG6s5/QgSOnzAxvllo5KnhCERj87EBe9GqARE1ukS3Wn1zXansikDhRgIYqjCqsUz09uV7bBzg9y2cPG60yLKjScAf+Z+nicJX3WImhC8S2z3XSDUKXFJl1AzFBCThC9tKGni5MB4BWyEwn6vfasPq5XgE8HGG90yIB+AOsBT7xgzeQRvWXqR/TOGrIZkhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QZS07VMT8YTKzlEOKl3OsPkDSLbUqrzjdJ8lnP0iQQ=;
 b=EWm/syNizs5bFJ9RA5NX9mMcTfXCeqlZl4cw/ILEyB2n9z+1G84XLCAI9Qo9xkqqs7xS0sSm6Ipbysi2YVUAVEBHZhYG/LpbJo2vEk/vrNZsMLJCu5aZaHl/bHyGakFPmsDLjRMah202Q3F0fg1OJruiOFztKu3qciZua4uhRYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by LV2PR21MB3158.namprd21.prod.outlook.com
 (2603:10b6:408:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.6; Fri, 16 Jun
 2023 04:47:22 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6521.013; Fri, 16 Jun 2023
 04:47:22 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
        rostedt@goodmis.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        seanjc@google.com, tglx@linutronix.de, tony.luck@intel.com,
        wei.liu@kernel.org, x86@kernel.org, mikelley@microsoft.com
Cc:     linux-kernel@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v7 2/2] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Thu, 15 Jun 2023 21:47:01 -0700
Message-Id: <20230616044701.15888-3-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230616044701.15888-1-decui@microsoft.com>
References: <20230616044701.15888-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|LV2PR21MB3158:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c518d8-4640-488f-3f85-08db6e24c5ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cb0/l/KI7R4ai8f+cu6WmHaACiKrVaJh+ZXWyE8v3qxz78u9ANnMZGT6i9IK27Mqu03byJjKO/f1GfFrq9RzKqJ2PvASx/omxqIPTpqdeZnwQF58oPGMB6WzWy0XTaZHAqJYVRb9EB8PsEanQPnPaVGWxJGAUHnIILulTrVA3XOImQL/LafzkgPASGqMYcJig+mwTr4TQQu7cxrY8h1jig8mzgRIGxdlDNufc/026GfpmcRfAJn3pO1Pyb6SXIe8JqZ8wivS+4c/a3pHNnw4D04bSALFi/xvDbSbFGN9BJGFF82g9pIas9JEO5ddTivOO6Kr6qK//KA9yg2s1OhK4LuCI8B0HCjyYYf/uK36eLY8FojfAQTSeMoGOctSR+imG3FeZ9fRcrsow77u78bmTyXQVWVRkzYQDIDFDbbMUNOQP5e2DOsuC7uZOIoPxrgb3W+hpEcSm/S1EbrtgqE05+PsrbHs3cvLNA5jJILVvTV74SGX6uXEAOwiCxwZOb36eTv6E7zEVUaFzQLlUaFKEN2uX9XGVfqvh0F4iMqzf5kKI9Q4gNCCvfbEz2a5jtIGRz/tKC+zDXf9Gq5XilVZUjyJxqB5Ta+aIZRo1mBmMfeuv5it4gfs7grWOQ3pvssBKr7Ft4YSlITy6iyAMH20RQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(921005)(38100700002)(82960400001)(82950400001)(10290500003)(66476007)(478600001)(66556008)(66946007)(6666004)(86362001)(36756003)(1076003)(6486002)(52116002)(186003)(6512007)(107886003)(6506007)(316002)(4326008)(8676002)(2906002)(7416002)(6636002)(8936002)(5660300002)(83380400001)(2616005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dpcXccLaMwqU4bVpaQUu2nKq3ah3UlwKYyoyI+JXT6tuAc95OUclN9lZDTuv?=
 =?us-ascii?Q?iBqHabPziC/lRaVXWVjjVH/IJyu9UXkLL0K5P6vBIWWgQKVEVIN2j9w167Lu?=
 =?us-ascii?Q?LXEwv3d0R4Dtyuee9eNWqFHN5dgRavvtUGlAS1bGZcRB8+pYTYjx8jQbed3S?=
 =?us-ascii?Q?OgidhLVPveFts3z/qIDvR694KHMK8Mf4l4e7KNZSd86qAPaGmu5CQI4+DLyK?=
 =?us-ascii?Q?PZEz7g1ZyEavMVrqzv7U3FS4my3hDOUhclDA375BzT3ZOSQX6VeAhw2PFEcg?=
 =?us-ascii?Q?rkw5tCXn5RqVetYM40YMSkRvoelrcm6VyhpHWHTNuFuLWkOaZt74POeHRaV6?=
 =?us-ascii?Q?8EJSCnv4mB99bH9hFgsVfG2yS4yufrx8qK16S5ZV5qFhokLIMtyfsrfxZO9K?=
 =?us-ascii?Q?IawuQKcHMuHxLZFt72Nw/JjFloq1K1KHnQoRHmmjg7TWUaunACyPNW2qENhy?=
 =?us-ascii?Q?CjkyXdnespUCNg/NjMsYyTi4WBIsM+hpaK7lSllFky/gi85k9oTD+7sf/ZtY?=
 =?us-ascii?Q?C6dE3JGtXrJaiWHljcBlEeKpo5uxCYK04U/iYK482TEXlZaV1rEjha5JliFM?=
 =?us-ascii?Q?BZWboxc2NLnXGNUL5kyt8Z74QioS2Z85A/4R8ydgHAft+zGqVz+xOAFLc0Id?=
 =?us-ascii?Q?NU/7A8DPqAYYPqrxJSlC5TB9fidBxd3c2El99ZXZ8rm/E0c6rpaqnVcFwzRu?=
 =?us-ascii?Q?gfxMxd126UEnCneshpPjUOdXZRYY/hFS1rMcamWtT9/Clf2x1gmnxL7xrJdH?=
 =?us-ascii?Q?dmJPClz3UD/QRgOTnHaW/i37fIr37WQOP07lnvuqm2fA8FSnweWFohBAlEtW?=
 =?us-ascii?Q?gfnP/bfm06XSdyT+W4YjDITs4mLivhOcqk0Vfit/Br/4KRpsctKq7fOuuNgC?=
 =?us-ascii?Q?0QVnRoJ5gWQxMSXLh/TNdtI8mL0RSBxZO7YBR3eA9F/yQnpgs+DDdqqZvQMx?=
 =?us-ascii?Q?tx08uwPnGu5VQ817CcM8pHxIquqKKUGZimt1SYLJHpVpdpSJWzVyPLcFib0x?=
 =?us-ascii?Q?cAMZTDs2UiBPmSQ7XEUodf7WmHTPzXVfZXI8EncVZ8a60gGK2eK5nke3Xul0?=
 =?us-ascii?Q?HkUaJnfUqMb36LSpTDzxc1ENoRlk/Jn62aznfIrR9lO2jrtXU94NePBpccZe?=
 =?us-ascii?Q?+hAwA7sa30TCB2x7yhBiiXkIv+xEdyP0D6EfSm605C695vdcOQT8erJA1J9h?=
 =?us-ascii?Q?A0I3SzFJuOyHveEx3yYst5WJkHLw2RU2H6kteobZgLVQJIG8i5rLaDC6XvXq?=
 =?us-ascii?Q?JUk9afYUC2JZ4BClZjMs7/l+cpFMWgItgZomZyHI/TB8fbrWEXCsRZ093k6A?=
 =?us-ascii?Q?q6Hm+BmhgK4Zih62Xdd4a7cmEe6kQah9qhnyaoO1DpfEpmsI+VNGjUssorHE?=
 =?us-ascii?Q?diQomXl72cBRI1CEY9+155HyBD4/V0lheW8s3SQzufHlwczMu99R1VM9DeGm?=
 =?us-ascii?Q?1ZkVVwmAck60sP4NFCp5SUmE1Z23Gq7THpzhue4kj5bElI5HG7tu1E6xvmFK?=
 =?us-ascii?Q?qYUnHp8Q72lc59wRXdIy7mbn1d8R0Rg9bOes6P/pagqE1p2loKU+GC4uJjEq?=
 =?us-ascii?Q?b9Rxlq6PNqlgiIckw5u4Od0F91StUsXFiaGleFXA5GtCCYkaTk3pqwc865iQ?=
 =?us-ascii?Q?Qk3WjrDP0/O/lHFq39E9g9EC9UVfU5H8auQ6RTy+dUC0?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c518d8-4640-488f-3f85-08db6e24c5ff
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 04:47:22.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaSizP/uT5sgk/08FbXToZw+rlmwQgGGkFujDvNPiyruw+MqavsRK3awbn/Noshb7e1fOPRqi1cSlQT97dI3LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Changes in v3:
  No change since v2.

Changes in v4:
  Added Kirill's Co-developed-by since Kirill helped to improve the
    code by adding tdx_enc_status_changed_phys().

  Thanks Kirill for the clarification on load_unaligned_zeropad()!

Changes in v5:
  Added Kirill's Signed-off-by.
  Added Michael's Reviewed-by.

Changes in v6: None.

Changes in v7: None.
  Note: there was a race between set_memory_encrypted() and
  load_unaligned_zeropad(), which has been fixed by the 3 patches of
  Kirill in the x86/tdx branch of the tip tree.


diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5b62a1f5bd79..8b2a2dcb2efd 100644
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
@@ -778,6 +779,34 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -828,6 +857,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
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
@@ -835,37 +877,23 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
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

