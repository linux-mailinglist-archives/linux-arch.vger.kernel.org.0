Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCEA632D61
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiKUTx3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbiKUTxE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:53:04 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022019.outbound.protection.outlook.com [52.101.53.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E1115A34;
        Mon, 21 Nov 2022 11:53:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIs7HH7tVo4Wh8N/s2NcGz4RAwvP9T0wOp7mDvUkFa9ZJ/wpN2tMAIKgWR52repWq/SMBQM4W3ZL4ALzFIG3xe+CpyPPUYEEdf7LHqzFi2xw4JxLCIOOjr1XnVBYqdhwkIgbRkbq7EfYChT/Dlmjbr3KQ7hU13PPL6fr7MW8V67yRV1zofkWRGNJI6daWhZQVFEmPyfL+47hQWUfKk0ybBgNSaX4IOhIoMq5mqgnM+gaAiaUHdmWUJxzDoQPS4sTnsMXV1RZKggtV7G/dgsCQ8xWTdfwbXkDX7cZ++WtuULJAwqj/B8BJ1eJm7ZkuK08r4uwmxrz5/GRURTjduDWKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pla7uQG4lVqvFfu1Gw/DyERK93jZZt64p0einsyczpQ=;
 b=W/VNT3U0l4iwHDNyuxQtNeC5AI9EpVYxmi10XwXcolo6uZptuefeXS77VLrtaHh1mmqI8qeqzJ7cyCVYeAw2pj7oFT28o+rYdCjOCIouAGvPoPHfO9yeMdJH66cykcFrMeYcnv1Gee3PXJdJlzGwEJFuhha3k0l1HYLbkeRc2WcJRWesXifMPp1JPOv+U/r6gUy2esc52RYssyhfgQz5jlzsjJgXbwJThw1jfareih3K84A2XkeSA07vW7BCA+1AXfnaHHd2MG60935FrqF9Xa4V7UkvA/XzHqNswv9nJRQWUxW3k1LKCDtys49CJS/4xalQmoNsWicIOsNg2DbbSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pla7uQG4lVqvFfu1Gw/DyERK93jZZt64p0einsyczpQ=;
 b=cZM3eZpGOzTe2kRKWPGph5qWoHX14lnSYW1I9i2RAHwYMTe8YMuZHFrvlttYNefDNfDBYH5h7oGMmMTK2LCBTlcdbpkWYTOsI2WGVArKzj6Y839UxJ2iId+XiLubt+fK05iPHzlETDSHpI/rVss89yU0Xdp1A0eodTSdBUSqsOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:52:55 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:52:55 +0000
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
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 3/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Mon, 21 Nov 2022 11:51:48 -0800
Message-Id: <20221121195151.21812-4-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121195151.21812-1-decui@microsoft.com>
References: <20221121195151.21812-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BL1PR21MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb044d9-54f8-482c-945b-08dacbf9fb9e
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1pet3+1/gFMuw/zXD93ksb5HxBwditLhOB2Q+IH9hHacNUWuMslAwfNupInf4jz2gIbUKZZotAC+YyX+zB3b9XkV3y0Nv2jfFaV0yTgeCK1OTry45KK1Z1vUIjZLHcdzistDmn8in3RupdyTw58zSV3ec+A5TYpatJCk0n3ALYMPjsANb92NCE6Vdq59aHrMhF9GaN8SQVDe0m3pimmFNCrMxWpUbBO1akcos4aKlXRYh5nQwoe+ofb8W5izawz8kIjZmf8hiITwGSTMzv61mnDTlxaly1ZmOQADXBf/XsgieOQ8yFk1Bm+FI85t9qG5aNAX0jGrLZlKuTJJoCIjdac+7L0QzWTqBziXLndmW0qTq54P3niwtw0ffiA/9Xs1aoeKAi2XQ/NNaAsYg1DxpDpIL8xNm1UFcTt75YjikQ7RcvByPNMbmw6EBoE0JquLkJUHuCZi2LLTFiO+p9T616LNjkMJ4kCPaUChjzHrVpjiOdCFjlaLeFyYU8agpgw91/P12Yjk2N2KWqwEl+vCGxFs7HoXcm+e4pd+kdeYkNwARf97q7pieFnhK5C9UThKfLNRD2PjDoa+/wjsKMi0gyAxaBf21RZgKM3+eBs/Wi0UPGDZj2uQWDe6WPr6UPBSm3XyzBi9JI5iHkOH9AixECreffj+FPhxG/w+jzP4tx2wRQheKx8S3ubge8yrxRmINxRPvHrG2sXvXkbEPRlihXI4Er+V57MM3F3kQf6dJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FAcyz1CYOlAs13EhkkK5N7mwIwerzs0HvcOaKv+gJlQrkIuL2c7IjwBEjPuK?=
 =?us-ascii?Q?sTfBVVm+K8fxh/L109DkEOnBp6a+A88HtK9G4QffeoeGDz1lr6rBR8pbhPF3?=
 =?us-ascii?Q?H9k+krtK5vRPIdAIaODVjKTWglOzibo9UybVDXgePcE7ZYGzCB/eymWiMFQT?=
 =?us-ascii?Q?L6NkLw42jDTX8eGVBmMQTKKw5FI9CQu5f2gPYK3zeYjWokdC7BjgI3eUBRhL?=
 =?us-ascii?Q?Oz+pQjgu0Dw1+woIdc33dbvIh8Gxici0QW59GpuY/hy5tnVFKQpaplSuIIB3?=
 =?us-ascii?Q?y3V81fAH/UDpsfWBqC+PdWTSHga7ZtjI1R0x4Cux2nBBAr+x8bi0YpOBfiEy?=
 =?us-ascii?Q?VRKF7S69XU5cJyEdLY5o/dTr4m6Mz7Mz6L01Qa4DkZ18pnKARbaetcafe95Y?=
 =?us-ascii?Q?9ldavXLD7XV+pbGIOW3K2P6VulY/gR6tT2OfSx8lYTIZjoOuYhaSqgkYEIOj?=
 =?us-ascii?Q?96nuoyVWsluSjHS7s+OsDHRooL0JI6m//Dszwzfj98u9c8NLL/QvSy9lU7Y7?=
 =?us-ascii?Q?u+cDouD+A3BqL/Fx4OoKJawrrSCuBPnQFkfKEN8YznixwO7BhLl90yp6/Mw3?=
 =?us-ascii?Q?mtzRKdDFdPdcxm+9wVkbcxeW66YCjvfA9gQNYj6V+oRz/BiRsObE6TdhmpGd?=
 =?us-ascii?Q?dF2d/1HfHxaaNeE1jsu101DWiLPntkZb17Pv8PrVcXToUNFoDQJXrEK1Z5KT?=
 =?us-ascii?Q?QQ3V0CjNByr5mA6jNHOUvRr5wTM7yh+GL0oqdJlOY4lf7QQyAe7Cibmzj4Xd?=
 =?us-ascii?Q?tRfnSc9KnRGXDQGvaG4+ksS3dvpA8gZcWghsbT0TzCDba7WnycqR5R4hwM5y?=
 =?us-ascii?Q?FeubVEVZMYURf79/T9/P6UzvqF+qCrut9LQ4wC4ZXFPJMK1MTONmV4FnqT2U?=
 =?us-ascii?Q?b+IgFOVgq3hYPMhKL3OX6Lp7WmP6bq/DAZvyQwh4igkLxa/+hNoQlRhHfwla?=
 =?us-ascii?Q?4PB3p/+zMZ15hoT7B2EBuAY4EutqmTODbkQWi14YCsNgVIuXS6IXB+yF4W9Z?=
 =?us-ascii?Q?YiCKuzTCST8VAwI+ele9mxpsTtCv2KLtNZn6akCG0Foz0KWYw/M/S96kjuPW?=
 =?us-ascii?Q?elq8ywbG6pegQAQfuzuvS+RMWru/fjR+NqQpfqvJ/cz4dqSRhk3XlyNMH3em?=
 =?us-ascii?Q?IIT3UhhzCNcZhZppILwGoI27kERfBXHXHmv5rVU5ExbfxrVkoZrnzaT8Asr9?=
 =?us-ascii?Q?QHm1G8+vvrngHa58HPQCi9bQGlny9AykiMjP4Eddv0y+KuP4lwD7RiBpGiGD?=
 =?us-ascii?Q?/QVzhyHXee53qMWJoRKDnP6yiV+Dtwa/A5XEQdLAKt8Dd0+MJ2CHV6O00qc3?=
 =?us-ascii?Q?5tjGjhK6VzfoEXa/mf9UamcP8OTEvBE4akVQqz40FMR+430Z0ozaCL6jN/uv?=
 =?us-ascii?Q?K0yx2c6ZcCNjVptQY01XVdcREcnV5HONnJ/QR0/+iZi05ANa8jawV+nCi6po?=
 =?us-ascii?Q?fUC6GEt5I9G72bUcnvze4Vih9xVXlXb8XUGFPxrsP4BGaZCjGrR9sqoev6kQ?=
 =?us-ascii?Q?Qd4h7nQm3xPHFum9mDIn6nm9pLayIEZRGLVzmsqlnLTZSJHqlozOTPVSnYxi?=
 =?us-ascii?Q?4M0NokD76Q9nsfCF1YPxkxZ2rVG1EJGpO/EyfL6Bj9rEg8Tm8nORj9oC2HHx?=
 =?us-ascii?Q?97+rUJdAHlhM4QO5k3xsZeU770OY/CS3irp4/OGNhdNB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb044d9-54f8-482c-945b-08dacbf9fb9e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:52:55.6834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApMGIJ3c8vbrVpXTxtGY1kvBBw1XNSthBTR6PLAy4Ln1SpjYJEnv5EVz+9kvqGA1Cr9ZN8H1pCNyMWR9MXYWtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
 arch/x86/coco/tdx/tdx.c | 45 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 46971cc7d006..8bccae962b6d 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -754,7 +755,8 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  * the VMM or private to the guest.  The VMM is expected to change its mapping
  * of the page in response.
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_enc_status_changed_for_contiguous_pages(unsigned long vaddr,
+							int numpages, bool enc)
 {
 	phys_addr_t start = __pa(vaddr);
 	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
@@ -798,6 +800,47 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 	return true;
 }
 
+static bool tdx_enc_status_changed_for_vmalloc(unsigned long vaddr,
+					       int numpages, bool enc)
+{
+	void *start_va = (void *)vaddr;
+	void *end_va = start_va + numpages * PAGE_SIZE;
+	phys_addr_t pa;
+
+	if (offset_in_page(vaddr) != 0)
+		return false;
+
+	while (start_va < end_va) {
+		pa = slow_virt_to_phys(start_va);
+		if (!enc)
+			pa |= cc_mkdec(0);
+
+		if (!tdx_map_gpa(pa, pa + PAGE_SIZE, enc))
+			return false;
+
+		/*
+		 * private->shared conversion requires only MapGPA call.
+		 *
+		 * For shared->private conversion, accept the page using
+		 * TDX_ACCEPT_PAGE TDX module call.
+		 */
+		if (enc && !try_accept_one(&pa, PAGE_SIZE, PG_LEVEL_4K))
+			return false;
+
+		start_va += PAGE_SIZE;
+	}
+
+	return true;
+}
+
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	if (is_vmalloc_addr((void *)vaddr))
+		return tdx_enc_status_changed_for_vmalloc(vaddr, numpages, enc);
+
+	return tdx_enc_status_changed_for_contiguous_pages(vaddr, numpages, enc);
+}
+
 void __init tdx_early_init(void)
 {
 	u64 cc_mask;
-- 
2.25.1

