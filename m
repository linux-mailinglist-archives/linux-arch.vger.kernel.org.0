Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47D6F7970
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEDWyz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEDWyx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:54:53 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24C111B65;
        Thu,  4 May 2023 15:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RILn03F5Y4Dj1r5Xke8qwNTXbbC7zH1B3CHGUQ2BSIB9pnfzkI5wxnDpSD/XzBifxyRuc4nUlxkbLYnyMidfA+cL1eUYdrkpfheTVe7UBJwzkkjW1nS+pKg9iypSSYpwchrmfxX3yJ11ZQgyXvI3lDbEFo8Fml1+Kaq4ucRP9gjYOhYSMMfnD9xuk7Xrdfj7pFsZsoKPLvdjxHoQW+8XZ6UAbLH9LC0uFWCGLjijXxXL9l8rVpYrBym60+JCDgvdfpIqwDCVG0o3ib49QwI2mLrsxrg3U5sNyEsl45nsqxiCkswMqle2KhM2PE4hxKzjJlKIiO56fL2yozKN54TK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZ2FgUj8NAsudVWESIa0P9z62Q+QvUqm2435JD6xthY=;
 b=SmG/OVl6P4N+Er9rnu7JX0buc7o1Kvimb35P7zuSNpuFmHXrFyR8kFo1GcEU6MJG4uN0W2pbAfiFW1e2AX5vSo8OUyGYuszOv3Ip3yqolRwe9NENC/wcX1J1WUYaAj9EcKH3a4WaahY3hXscAtY4ubzt+lzMPPR9oTMT/nJuvO1uEYbtLx8GRabQqIiYqF9HH6QkShivuJe3B1Q7rb2z/6nDYSVasN83gNt5Dj7v4C74Bcz7PH4T5p5gS5I/xmUAjAkOKiatKYwwEi0ZYHfAFe9XYN3XPH9si6ApMgNeBTuT9vnVjE7ihgC35Xm6f7lUGvTjVo6jNPfUSe5gBp5lUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZ2FgUj8NAsudVWESIa0P9z62Q+QvUqm2435JD6xthY=;
 b=bx7i01W6mTf2ja0NYTlVafAzRb5R88E66xrDeRR0GRisMZjUND1VzUpeUQJBbkIZjf+5bonG8qa+rro7gbZX2MenHOy+rsDdt/pdWRU+5UzMiqrUfYGK7Q7s2cTpDV9dfn/RlfDh1cBnRbIcHrlVmg93makeU07Q0oEUok8i1QU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:49 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:49 +0000
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
Subject: [PATCH v6 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Thu,  4 May 2023 15:53:46 -0700
Message-Id: <20230504225351.10765-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7dd1a140-0e47-4afe-ae73-08db4cf29066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BeH8wj7Fk+4xEsYCp3vHU3Fw5ccOrgjsFw99IVYS2OiZd+A+ZOCao5iK8A/r9sP430QJwobGEmbqAhJ1N2tdI7cQSJUhzfhmVPG2HeXMkNginJC6BCcN/b+MCU6Z+pIILTzuCPZoxzBNmxsGTLc+3rXswlxqIbScN2Djr/tIVCa9Gr1Vk6TH+yK0IUwOe630GUpyzDtzIZOyS5VWpBB/5+2bb2p/F0UymdgbfSeYx4tuMWmSkvta58s4kVgSP3xTZQoHN2J4W1AsCuyDVk5FSlNVP6BspnXg5MGyWi2HuYzeIp3e0uAlPD5uLoHJ0FusYF7g3J3uz0f+Rp5AU4wzLdSaiLQI0wDWODTd+35TNwkuUxbTDZQ3hGB4EaBl2+0RZcI6yHbTdY7wVORvKnLMfDdZ+B8HFFDVb3HrcrvyDjTKMtVLrdFpCuLKeZDOBKSr8mH0MnIOQdjhV5aJ/IGAPE0OYLAZNfjrUEA96tdh7pV7y8ZRMEIGPdwz1XnHNH/MPZxC86MWgzgaVuZ1XYOD/ChvVsXcAUzR5MkjYM/oBNb9hgap8N3h/ngWEasHh1SK+srhEU3quowidBdwVTi67FVjMWgxrihNlqnjyGwemoF8HbrSmNwXoP/6AoGcUEQ1Rui1GQyaIKRtZfXoifB9/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(6666004)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gi9gcNfvxisYvMGS5Vme1G8AMoREN74gP0TNlsx76v690ypq15E7X5B2Irg9?=
 =?us-ascii?Q?9Y2NRb0iAX2k7mI0of4rgR5oqLNwb6u/EuryqrGm9qflzs4E0BsokROEr3rw?=
 =?us-ascii?Q?3iT+VpRxhkl1NuYWM58J1Gtm3zbiSQIiJi/7aNvgoa94M9wWlOFOOYdV8Jql?=
 =?us-ascii?Q?nLTlXZRxm2IK0o+4tRTt/KlgS5+/W1YmU9/37W95Z89mWypZ3Em31LRm23S0?=
 =?us-ascii?Q?0UvqBXdACkN+I0ARDK79g/udzhffxKAY9hxxiPCpTzdNehuRmfnIae+m1L5Q?=
 =?us-ascii?Q?DKvn00oPWP/mq2NQM+5csM58JXRDhaaLZX5/7440i/scPo/ddep3UWqFvDB3?=
 =?us-ascii?Q?Q/rxxP3MZVsi59Icv9yRqFXY7bGP9gmpnO6pYgmBrU73v5KH9T/cUAFhX53G?=
 =?us-ascii?Q?EArxUNKfkq3YgC2iA4TDji+fhW9NOe8FuClVqzsOnBzkirNfHavyRztdRePF?=
 =?us-ascii?Q?xPXOt2mK5rKjqJ0iUISB8nLrAs2HcOXOABp83QVTrVBEWGGSICau7l23SmpW?=
 =?us-ascii?Q?/xUYLLi6srPeNaCv+9G55o89WdFoJv/XFa4U/5ouu/RQ5rEU0L/wqjqZdS8k?=
 =?us-ascii?Q?EKk8iuRXhko9euHvtt1i4qI1aHhVy3RDWZo8HCDJofQBRWwWbhjN+IQZDKgK?=
 =?us-ascii?Q?L9gqH4KbgBQL/gnA16t1hNAPeig0/yqof20y/WSlCKbVH/9Qi4wIxYFCjqiA?=
 =?us-ascii?Q?ElUP/jdILewLjWnv0yWIuJQGxWHuTj/dGlHnCdlrDCOH6k8ByqGY0kZjAdWp?=
 =?us-ascii?Q?RSDNwYkwx48RmJh4WXdfpFb9Im7wqKUVPIaHN3PqiPxyiPivcLadjQW0QJS3?=
 =?us-ascii?Q?/nYvPaZuzNByNavko/eTD6sd2IDAeTV4z80U0Jlez5XkhmV0cFpTol+WPQ6Y?=
 =?us-ascii?Q?23jFbxd80YCTgHymWebMcYUkVvQoT8dVSbSi2yAuHop2zfc80URp6J1aeT7q?=
 =?us-ascii?Q?k8w3ZMSRGwTMwsYoBEqyVGIK5NOgT+T6zCd6Mvos1g0+wqDyesIy/Cu7++04?=
 =?us-ascii?Q?U2n+yrJyu3xhIFRdO3rhEBSgw8VUsL1FAtqV1klT5qB/hGU6sO6X6EPTy9YA?=
 =?us-ascii?Q?RYHI1aTdWwfKk4W46mkXIRX+xA91TdLkqHau6/h/I8Piw1Su9b7CiDtO7tkQ?=
 =?us-ascii?Q?tLqgar7+IU0d7TEFYXfpk+fo2yZFO/POTB5uxKppPVvoIqvei4+AiJ2E05nT?=
 =?us-ascii?Q?fOnPHKUTyWb89LRnPBYXHwxaCK9rNm2+XyQhDgD4kiYAv603qMQJ+B5wTfFb?=
 =?us-ascii?Q?FfMZ0QTUsHpewvMMcHrbakBDYro/FyrIwGonbIi44GFvTl96OGiN3zJMAIzv?=
 =?us-ascii?Q?utM4IBs2Nai50KL4kG82sD2GHgzv4h/QqqBcmcJPCucOJbJnzObLegdbRy/B?=
 =?us-ascii?Q?j9Y0FdUQyoAdpA2wxxrBeSwn+OljQaI6n6lRHs0V2Gm59GOKHHui8zVIyk9w?=
 =?us-ascii?Q?0dde8Qj4Wp6Z7500r6q95SgW1mVAQWH2wY61sdTjoZk3eIEzhkezOK0Uh6VK?=
 =?us-ascii?Q?7ToCj9fZHXHVodl6ETqS2LiMmsVugEOX85qhWDbr65VJOq+C5o0g4hWTS9um?=
 =?us-ascii?Q?nNFOqniEhRkjNqhjkVAGMRo71JsyaCc4CpaB71Bpedd6T8qz1XECIIcUwWmn?=
 =?us-ascii?Q?/IpoaQKbCAB3agTS/V1OkpP3pzROSjC17ayxlNKQiixB?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd1a140-0e47-4afe-ae73-08db4cf29066
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:49.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VitlBIzQNhh73axCBMWkS0w2vXo0O3I+QCfVczfOWkFP6NnhWbaFX7mYn3JLSPGQiYPmM6FhsmZ0lme0wW1+zg==
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

GHCI spec for TDX 1.0 says that the MapGPA call may fail with the R10
error code = TDG.VP.VMCALL_RETRY (1), and the guest must retry this
operation for the pages in the region starting at the GPA specified
in R11.

When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
when hyperv_init() -> swiotlb_update_mem_attributes() ->
set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

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

 arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 4c4c6db39eca..5574c91541a2 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -28,6 +28,8 @@
 #define TDVMCALL_MAP_GPA		0x10001
 #define TDVMCALL_REPORT_FATAL_ERROR	0x10003
 
+#define TDVMCALL_STATUS_RETRY		1
+
 /* MMIO direction */
 #define EPT_READ	0
 #define EPT_WRITE	1
@@ -788,14 +790,15 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
+	int max_retry_cnt = 3, retry_cnt = 0;
+	struct tdx_hypercall_args args;
+	u64 map_fail_paddr, ret;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
@@ -803,12 +806,49 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	while (1) {
+		memset(&args, 0, sizeof(args));
+		args.r10 = TDX_HYPERCALL_STANDARD;
+		args.r11 = TDVMCALL_MAP_GPA;
+		args.r12 = start;
+		args.r13 = end - start;
+
+		ret = __tdx_hypercall_ret(&args);
+		if (ret != TDVMCALL_STATUS_RETRY)
+			break;
+		/*
+		 * The guest must retry the operation for the pages in the
+		 * region starting at the GPA specified in R11. Make sure R11
+		 * contains a sane value.
+		 */
+		map_fail_paddr = args.r11;
+		if (map_fail_paddr < start || map_fail_paddr >= end)
+			return false;
+
+		if (map_fail_paddr == start) {
+			retry_cnt++;
+			if (retry_cnt > max_retry_cnt)
+				return false;
+		} else {
+			retry_cnt = 0;
+			start = map_fail_paddr;
+		}
+	}
+
+	return !ret;
+}
+
+/*
+ * Inform the VMM of the guest's intent for this physical page: shared with
+ * the VMM or private to the guest. The VMM is expected to change its mapping
+ * of the page in response.
+ */
+static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
+{
+	phys_addr_t start = __pa(vaddr);
+	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+
+	if (!tdx_map_gpa(start, end, enc))
 		return false;
 
 	/* private->shared conversion  requires only MapGPA call */
-- 
2.25.1

