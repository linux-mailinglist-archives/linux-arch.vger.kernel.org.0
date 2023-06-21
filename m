Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8014F738FCF
	for <lists+linux-arch@lfdr.de>; Wed, 21 Jun 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjFUTO1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Jun 2023 15:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFUTOX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2023 15:14:23 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020025.outbound.protection.outlook.com [52.101.61.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B289E171C;
        Wed, 21 Jun 2023 12:14:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCNUhLy7KpXsaen06Ns4nmsSgvFqKkg6XZqLDSrChhAvNMJ/Rhha8xjv/qtGQMmXGDok8/bR12viYDgastzYk19s/+eKvtM12dFbli1zpEu+D2KWvCpx2xMBx7wtnZYi5eLE2S7i8Xf4AdpJt0FwQYKAXAJKNe4KPmvo+8EjrXoC+e7wQwb09Q+lACwFcEQ7XpZgtB9dhJOj94kzL6jqzMvsVshL/oiWRu/Srh+ZBX6wlXQ+Fl3hmGn930Re7G10iMRkGQimTzwTRdBxkcm/vwYCxbkrLOv15uYbKqHSMaVgMmi723HX++PuggMe1FxGEPTaWRUy9ECU3mZBWX5hEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NoShCcok9v3RsEqshNsG1W/xu9wjx6Hb1pOatLGR5DY=;
 b=iCgKIe1ft5w7r4dzt5TnOsocv/l1oTsqCAPqWgmlf7KQjMhuaZWPaLvOSE9ACw9JvysXRkCdYfmJDJgkiJaoPhgheL/H4tt6gm9p4d8/uLUBmDa9dGrYJ3b64UYba9NzMfcVK7KNOu4HnXlNUCt8gn/YR6EgVvauKAvdf543FLyhuSuZrdnorYZyiE+pmYbC4QURi3ND5VpiXjUisWADmqXcGJbtmjoUFjqRiOQX4+iuJIqeVQLxJV5t3ili4pgedvCtM1A1SsrbFnHmFiKv8Ht6vIiupYwGrlciMDnrREn5Xt1EFX7hCxyY00wbvasdvM/4iKP1Djvtwszeri76Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NoShCcok9v3RsEqshNsG1W/xu9wjx6Hb1pOatLGR5DY=;
 b=RgbcgFw7MVmKtAaMnXC+U+Y7Ud6PhNb/0+jOgERAhrmXbkQZBUlc0bzxWL/Cthk6CqaipzVXKo2AIGJC+2GBj1Dj5mXfrlFIfh/2tgKFPSZB6Poxxdo3/+pAtC25FGOYLFjRcu0WXTNV1vxXkJ9PuUx5sn+ZTm8emEta9p8SQrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW6PR21MB4009.namprd21.prod.outlook.com
 (2603:10b6:303:23f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.11; Wed, 21 Jun
 2023 19:13:54 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6544.008; Wed, 21 Jun 2023
 19:13:54 +0000
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
Subject: [PATCH v9 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Wed, 21 Jun 2023 12:13:16 -0700
Message-Id: <20230621191317.4129-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621191317.4129-1-decui@microsoft.com>
References: <20230621191317.4129-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0072.namprd15.prod.outlook.com
 (2603:10b6:930:18::34) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW6PR21MB4009:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8eb6b0-dc1b-4f89-5387-08db728ba7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZlLlAv2WkUHjMJS23U3zjkkD+4119W9+VB99iBVnet13MFuGIc6c5+7hv3IzagKojfBCdIxBeUgl4iUxG/ByRxzBLSReqb/RMM1BbWSolHy6vofHioezYM769T/dIJuVQWsQiz7W/htGMJHy/QleDLfQ+sDpT5vYYWS1jAEczx4pPaBSDbJHLggrcdGqcco47EfLUqGwn5ICwWWIzBbEY++HyvNt8jlkfH+2fLF8jxGqc2ht1fTyGtzGRk2CPaTihi+J92cF1sDglXgfd4hYoJg7zCbSpFh0ljuoDsGN+PD/YqMGwTxpKfQ331FWYge77zlUJcL16FxyCDUWbuKop34T9YtGb1ZM0wq0gRj+TFZxPwdjhVtl6AK86gGLHRgu4r8m9GoujhOOJVpN6YuGskiRLQ+B0JXCEE9VNx7cu0JThwJyAUTZENe178nq0y5dEmFzyLXqQUjLuaMaaWTsHWBxLqHFcvCau4ynrQ/w1FifKSbpQ+U2he82XESbd793R9lzG8zWnPzKUhpc+PYDCSTRn6tWU1hFcyCHcfay+KodfLMDmw9OnNIhzG3dk7T6Q06lYHXDUp3Bdtfe6tmywJT25elzeem6/f3BXkuouUn6c84ZofmghShPkea7RqnKs02Uhbde0ieHG6SexX3glw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(86362001)(38100700002)(316002)(4326008)(66556008)(66476007)(66946007)(41300700001)(8676002)(5660300002)(8936002)(2906002)(7416002)(186003)(6636002)(107886003)(6512007)(1076003)(6506007)(36756003)(83380400001)(2616005)(478600001)(921005)(82950400001)(82960400001)(52116002)(6486002)(10290500003)(6666004)(966005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lx6pL9HHMnOdf3uobhGIH96hUT+jhri6ZOn8jF0E5lJj07lFevCwBFvtIz4t?=
 =?us-ascii?Q?YKv0TErvg8WA+5Qi2p+gbtmRRgYt/tmF4dCXxSSlcKbWd2ciE8UlqTZ+WuQm?=
 =?us-ascii?Q?Hzztq2iXm9jYASzcZ6tG+uiddLxsE7wPR1jLueRalC3YWvnqYA3exsbVLro2?=
 =?us-ascii?Q?X1pDvUrJm8UcyVh8cyKzWEMKnUhatEqNcn5MHi3vkCwPlPRLO3srm+6Ob1+g?=
 =?us-ascii?Q?Rj7zEpuilbSvAlkXpGP4foWs2I7FSkBul3v4Y/Xdn5XUCIsTFF/0YJ+8r70w?=
 =?us-ascii?Q?EWPAbzj+VYGablX9rRJtnLHYAJ4VnZbWvyl7nTEzzwFWU4KimAjECjS9hIey?=
 =?us-ascii?Q?ul++bLr9pZ0E92nwp8voDRdVkaW5xRRFJ2cNBI8CAGP2f8rwuk6UjGgRvBUq?=
 =?us-ascii?Q?/7qtFePZOQ9im/5nuPbd5z7eWmNolr2/khFPN5HIe/28Qeg5ZQlldZFiSOTY?=
 =?us-ascii?Q?yISwtku/HsrKqHnI/YXhpIjdSiFZTOUUGeUyKJ4yMHJNfFa0trgKtcz35YGj?=
 =?us-ascii?Q?cpvoCgyaPIE8cW1mwQI4WjiA0sD87gUDty9fHkB+amWSbNYTUw6buF1Bf1Cs?=
 =?us-ascii?Q?JVMQc50Yccjd4N8G7UQ7GZUsqWpRUlg8Xpb7EZ32pKiakS3248sXSwDXjLna?=
 =?us-ascii?Q?Eu6Nb1x+pJzDG2VTGh954Drk1C2P4G6IcVPHgi+sXQu21IdQjBsq77MaOFWL?=
 =?us-ascii?Q?YINNCSbpPP5buzaC+pd7nNusrK3pAwFu6SvLCAPwemQj2TtnsZg91AHhi7n2?=
 =?us-ascii?Q?bc9v8fvHWYGwFhhNlTyvUzsrMiKEHVVO3rrE4HbPUyYPHrTgRXM/RmAyFK9K?=
 =?us-ascii?Q?yyf8duK1wkTTeijFen6kRsgraE7CQTVJskfR45njQtVlOzb+x320WBF6STDn?=
 =?us-ascii?Q?zLNg0WCWrH6D6YOYBMmDwJ0FZVrsd5FeayOOMC0xFgKSnjAxGXb61rqZOlGk?=
 =?us-ascii?Q?ZcJigs/X704k3Bl1dyw4mxW75rdi87ec/WhiVWy0GU5uAhJkOupFIoBCxUF8?=
 =?us-ascii?Q?ByV10bNekYPZU3vouG7N9FTrbvTYMO3WIpI5QNhV+SCsWNlodM8R+QdbudDI?=
 =?us-ascii?Q?aoalf91mH0I3XEZzUc+RpBIKhtjnJyyJtkSDtAO/pAzdUYdX0WqINLQ3PJb6?=
 =?us-ascii?Q?FQxDFh6L185eNVNpzjOhGf+RM5ZcgdMUqZdLXO4DNANoRiJol4jUU6TlX7SK?=
 =?us-ascii?Q?bqPLxP4iZDjgi/VL4fMB9KJbfHJLanqBPGuO8Jj6gfF4MjTu5GvbUKhUomCf?=
 =?us-ascii?Q?5kc3XvZg2vwNi3Y+Bg9U9QpN7Im2VNpLiX4UNy7vWXxp5cib6P2gGqBZ0UeT?=
 =?us-ascii?Q?gBnQbOLUpkhBycI30roIFcVYOuCWv2oQtYZ1hcBoQcnof9wrKzEP6nbNvIK5?=
 =?us-ascii?Q?9MefOrILQBMySh2aZKN5r4CQH/U0PAmkbofvvkIrf0xGQc53LtbeiPFo9P01?=
 =?us-ascii?Q?LKQVia1M1w/zf/WAoVl5gZIrDeVL6ddyoiiW+6BHdyvBanuL+ZXLKq3t75Cp?=
 =?us-ascii?Q?Q08HDRe8H/xfOsm4XjVlbxdV5xThz+fVzkyg65kxArOqzEuzdiKsZVHtyNpz?=
 =?us-ascii?Q?cjske3JfhpPQB0njtr4bTOL+cxnpwl/bZVlXOZw6TVajYIHqhZ4QI6EfTwJn?=
 =?us-ascii?Q?Q2CDu/qzfU6yPK3KwhRvWRrwSuAStxoOjEWkHBQq8EC2?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8eb6b0-dc1b-4f89-5387-08db728ba7bd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 19:13:54.5073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HLBbNpXT9LJIl7NfJo202NwRy7uKbSbgJy/YIrXRuI4zx27FVFPy57EnyeoHvGCxsPC3SkIB5wHbul3iTc1Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR21MB4009
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
operation for the pages in the region starting at the GPA specified
in R11.

When a fully enlightened TDX guest runs on Hyper-V, Hyper-V can return
the retry error when set_memory_decrypted() is called to decrypt up to
1GB of swiotlb bounce buffers.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c           | 64 +++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 54 insertions(+), 12 deletions(-)

Changes in v2:
  Used __tdx_hypercall() directly in tdx_map_gpa().
  Added a max_retry_cnt of 1000.
  Renamed a few variables, e.g., r11 -> map_fail_paddr.

Changes in v3:
  Changed max_retry_cnt from 1000 to 3.

Changes in v4:
  __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT) -> __tdx_hypercall_ret()
  Added Kirill's Acked-by.

Changes in v5:
  Added Michael's Reviewed-by.

Changes in v6: None.

Changes in v7:
  Addressed Dave's comments:
  see https://lwn.net/ml/linux-kernel/SA1PR21MB1335736123C2BCBBFD7460C3BF46A@SA1PR21MB1335.namprd21.prod.outlook.com

Changes in v8:
  Rebased to tip.git's master branch.

Changes in v9:
  Added a comment before 'max_retries_per_page'.
  Moved 'args', 'map_fail_paddr' and 'ret' into the loop.
  Added Kuppuswamy Sathyanarayanan's Reviewed-by.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..746075d20cd2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,14 +703,15 @@ static bool tdx_cache_flush_required(void)
 }
 
 /*
- * Inform the VMM of the guest's intent for this physical page: shared with
- * the VMM or private to the guest.  The VMM is expected to change its mapping
- * of the page in response.
+ * Notify the VMM about page mapping conversion. More info about ABI
+ * can be found in TDX Guest-Host-Communication Interface (GHCI),
+ * section "TDG.VP.VMCALL<MapGPA>".
  */
-static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	/* Retrying the hypercall a second time should succeed; use 3 just in case */
+	const int max_retries_per_page = 3;
+	int retry_count = 0;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
@@ -718,12 +719,51 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	while (retry_count < max_retries_per_page) {
+		struct tdx_hypercall_args args = {
+			.r10 = TDX_HYPERCALL_STANDARD,
+			.r11 = TDVMCALL_MAP_GPA,
+			.r12 = start,
+			.r13 = end - start };
+
+		u64 map_fail_paddr;
+		u64 ret = __tdx_hypercall_ret(&args);
+
+		if (ret != TDVMCALL_STATUS_RETRY)
+			return !ret;
+		/*
+		 * The guest must retry the operation for the pages in the
+		 * region starting at the GPA specified in R11. R11 comes
+		 * from the untrusted VMM. Sanity check it.
+		 */
+		map_fail_paddr = args.r11;
+		if (map_fail_paddr < start || map_fail_paddr >= end)
+			return false;
+
+		/* "Consume" a retry without forward progress */
+		if (map_fail_paddr == start) {
+			retry_count++;
+			continue;
+		}
+
+		start = map_fail_paddr;
+		retry_count = 0;
+	}
+
+	return false;
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest.  The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
 	/* shared->private conversion requires memory to be accepted before use */
diff --git a/arch/x86/include/asm/shared/tdx.h b/arch/x86/include/asm/shared/tdx.h
index 90ea813c4b99..9db89a99ae5b 100644
--- a/arch/x86/include/asm/shared/tdx.h
+++ b/arch/x86/include/asm/shared/tdx.h
@@ -24,6 +24,8 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 
+#define TDVMCALL_STATUS_RETRY		1
+
 #ifndef __ASSEMBLY__
 
 /*
-- 
2.25.1

