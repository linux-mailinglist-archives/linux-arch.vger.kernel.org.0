Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC986EB6C6
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjDVCTi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDVCTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:19:33 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B791FFE;
        Fri, 21 Apr 2023 19:19:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESpR1mOm/iWIuGYFAnPr6BuUOOR4BVnM2PhSvvTAPfvwlEdtupTQ1+di9OpNsJLomcrAA+9oQ3/h00LqRtOb9FEqtZj0uZYxSLyNOhVaWieuLYoisu56/WpgaQ2hiezt0xlooRU4XBBnm7PR1SXw/ARBqRoiSJMWLgP6WbUe/UrzvnTtJy+tE/QUww06h6z8ijqWBDcUX/WO4+1tbtBu8ze/9C2Zzao9VMAsAQ1InHka842Pb8avN0jN9NbPGSh4psu8FIhtf4iMfH4KE9awoC+Eb6BBvg61lXuDHXy60bd1DFXuTwjnHBYCeMBb+QpT1i6QY1RiwHS8nUwyeaVvqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HU2Bt79BFoMpAhMMCkLW9mbW/eTQdPppArjP7XzLuN8=;
 b=QMf3rPuFfA+4MCn1dnnZpXx5L4cO+7kU5T1cd9LadTBClGZcHtEQ0VeMYlL1gbUkSWwXxWq0W7i/ktMdbgnOhYCuIBimU6lQBhurYKCorV9Ljv76HNsK/IS7ZKcSgSujWNhrzIP+RmFxegIVclYc6fvGPDVT557Q36DDG5V3dkajgV/zN241pK+VAn12cgvYm7XAjnyST9IKK7KwT5ZzXIdgEBgydS/Ec4FY9hLcqd3KeFYr49Qn7n+qCiYxvlCOtU74K7JfXVJso/Da/MwhnV11ZLf4LuGzlV/0dWVIQwgF1Mvwrjdd3yS0/8oA7vMJoF9/Gn0/az3f4QgPqOUTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU2Bt79BFoMpAhMMCkLW9mbW/eTQdPppArjP7XzLuN8=;
 b=WeOot1TGj8V2pt3cTRa+XdFax1toYG+6UcS3/FUX+Xr/981rPmNEnNktycLPXKkzrR9nccYK5uXXTpDlrG76R+A0NpbS3/r7047uYI931mRriK3zBNV0nXScn0AAl/nVxc+Y3l0EReSlgPmHapQNkOYrEil/nPcXUjDJLhMNWxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:29 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:29 +0000
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
Subject: [PATCH v5 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Fri, 21 Apr 2023 19:17:30 -0700
Message-Id: <20230422021735.27698-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: b2f1ba7a-504f-4a0f-6f88-08db42d8004c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WohpIpcIDJgiYVOKvUMfuGMt0v7DI4iXgLPZfSt9zrWz2/bqgq11VTBdHZ/mVJTp1ycH4h7Ae64HZSRg9SN08Dd0oAFL+8CAXTkYHMCzO6UxlK/ctvEut59v4FuLijq8wHfs0GC2vU/fuUryx0wAk92j+q8j8gLloG3ivxTWfNy4iQwoAVa1XRkuF/MZvqEUX+XCNUSyOqS0gHsaIe5aTzDddeiP/mW9B/ZRfHbofdj/nG6SxTGYpQlEvhT6VsIYv/rLmfFYkaWq+D25XzRoU1Jbc8g1zAJdU6lr9m6SVbsjjpNUv8ru159hXZ4HQe3u3W+Tqq1Qs9yxab/+iCCXSf/smOLeilDIIXo7xwysS814b+SJaHhW2GdW0XK6ge5Hswy7IdWCiWRpPnSltk/knLdF98WILvYEhtvUpdc/ZJn4l8dGXrLnJ2IJ84UXiC+w8514vRROPQqKN7kjgWi0szpyDV5nya/ibBiapMu05ymExvqq9sAtHr7X07oZk3An3EfEQXA20SUU83uksXG69dxAKdAvr13Xy4s7GbFr4DQTnrnDtkns8vYMuXVM+IzHBIVBfAOFQ1ExlWXxSAUk6SpYS2USq3cAjh7GAkAN0KFYOSwLWAQ6Ynn5ZuSXwsbZuBvyPK0yaJwkHWLBf428dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(83380400001)(2616005)(86362001)(107886003)(6512007)(6506007)(1076003)(36756003)(52116002)(478600001)(6486002)(6666004)(66476007)(4326008)(66946007)(41300700001)(82950400001)(82960400001)(921005)(66556008)(316002)(786003)(6636002)(8936002)(8676002)(38100700002)(10290500003)(7416002)(186003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Djw7lO7OjEgI/JlKl/f7d7VjZiSQeGGuOaEj5NR1mF38Vm8pZcH9DHqcKdO+?=
 =?us-ascii?Q?iWSvkxyKsdK9jxEoyJ6CsQ8ovgM2ydzwrZUxe5//CPyY015V5EJhz+tQlHZZ?=
 =?us-ascii?Q?1e4Drgf+w+2HtvXB+rS4Mgltjws2NvawYZZpRuIX/fs5ygB4AjkkbuLLlw5U?=
 =?us-ascii?Q?2TIsJrqe9krvO2XoGWkFbdKcg2DVCr5KSqqCpQy78K6DYHmJ4aPMqPbGKDc+?=
 =?us-ascii?Q?X/IU7UZjvcPFkc8pPzKPNh4abZznRapcq0l138fXKWMPoWwlkHPlzjJtthAV?=
 =?us-ascii?Q?aV+g3CLiQ20rn6UHzZo7W2kLnGSkZE8LqhhFZqBD77MlO+4fXIgkVp4UV+z3?=
 =?us-ascii?Q?XQ9oiUWVUAh1Jmw/2JyNXF2MqdoNOCaiFDtNqH8H3E6dHwpr14ofJriAY2y2?=
 =?us-ascii?Q?oJdHi8am4X+ghFkKIM22a7lKUOkbtuiPuqmKeJIUhGHcVVkcTQAhWbPE8ZOx?=
 =?us-ascii?Q?Tr3Lso2wBBAEASqDspvclTiX+2MD2IRUrfUJpvKmuaXH4rqFWjS9zgwX3T+f?=
 =?us-ascii?Q?42XQi8ltDZQjyyT7C3FYociZ/9tUhCJz+SHvzN4Ckmp/fjLuf6lCfVaszUN/?=
 =?us-ascii?Q?WtYGulpSILtdX5TQXFMzLJuqkadyk5XP+3TSIsmv5agh/Jbd21KfogIfcgSY?=
 =?us-ascii?Q?76mHHUBj+Uebo2N23rEcGJgWvjjIFII2/1yl+veuF46ryNJPieBhXk/KO/up?=
 =?us-ascii?Q?yptYNkJqOEyULXhtRD3x/PhH3WuW1EtlYUlkBO2c6TJ8fuTNXqhIfmW3p9yu?=
 =?us-ascii?Q?KT5zecTxmrQanmc7UGphMeJwqM64wRLoZ34WOOH1+gh7TNIqNg+PtmST76ml?=
 =?us-ascii?Q?0Vuiadn6jSsN4ZxZWCqWr6rSA/cgAR9/rf7USkNPonaQMF7fu/qzs4sH4BLr?=
 =?us-ascii?Q?F8A2iIQnQ+ATKTUCjVO8nEOmJQo8P7ODsYPrVAV2NRbn2MCaUvituEMRYpYC?=
 =?us-ascii?Q?6glJybcV16QabbqSXzKnYNGvqCqtKcEJYsPIx+N7njRoWkbk8/BrUa/5/CoZ?=
 =?us-ascii?Q?iUGy1tH6J9S8eDsyaDthSKcOO/4BEs6PN9zs6PkiK1PxrJG6DKsvsmMmaIOe?=
 =?us-ascii?Q?nj+RPbGkMFFxEQ4bSLKEwuRImbYb9ZhsP8/WjsDLrSLcQnlpiE6lQAymOq8o?=
 =?us-ascii?Q?YQNlBLm4iJG/hpqTPpGaN9r+C7d5VkB81Hw0pIYSY4REJePkPoOXlpNJW8bz?=
 =?us-ascii?Q?b9cVO2fQeqQh9rFVhOvc8XebZ1t/9XJcE3w44bx1FQpDwYP36z2PEyjNg88t?=
 =?us-ascii?Q?3VBCrQmBthfkTbSTMbGwBvzHEH/IynMabmnU8rb1zK7oz+3uzeWk9XKrHt92?=
 =?us-ascii?Q?C9fhh748dTG1lRIkrpiXer+9ARjsDnaHF9YKoOugVQADSOLDEyBSdKtV9Lj0?=
 =?us-ascii?Q?LOXwx6UP6dFXin+74f4mXssfNmGskB/eD/kc0zYbjubnIlQrHb0+zKzQg24Y?=
 =?us-ascii?Q?dnYEu5ogauS8B9jFx/n6Wx/FYDCRx1VvivHqyMqyBCI39SmJ/EjSGzU9BoC7?=
 =?us-ascii?Q?6H7P+ngrAo9WTPPy/LBAK2w/hGHBaWcWwAvy2SIfA6frwCWv4TdMYB4trtH4?=
 =?us-ascii?Q?7fssml5l0Os2yNJbHhLXYslJwfHtKAQzK0hmHSIZ7ksJ1MoiRdm0kIx6y79g?=
 =?us-ascii?Q?LisFru8xfcLbZIl9eKsMIaM6w9SIw0gi2xQ3/bemPnLt?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f1ba7a-504f-4a0f-6f88-08db42d8004c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:29.0360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 406ZXY5dPxNoENfWqc2Spy4EPi7fg1slOfqN9MHPZOojr5r2KBtp2vT300Ddnn2iJtnsSrYJpKPwUh5/F//i/A==
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
 arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 12 deletions(-)

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

