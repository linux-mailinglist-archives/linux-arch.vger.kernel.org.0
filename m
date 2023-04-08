Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D496DBD02
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDHUte (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDHUtb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:31 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F14A7D90;
        Sat,  8 Apr 2023 13:49:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KexR52ejMw1Dq7TlEn60rC6kYg3WE/BZLsIBRl+mST0iyQ6Xv44/hD5YmOnP/vJkC8ujipVOy/NWY9UP6faCmqKIUiQysVqZQgJcq0IQXU2XFZw1M8OqGVbdmxi0XPiVPX/xmByhaq+PWWuec09KYYZvcE3rBOd/9moioa0NJFzM4Ihf/FU8uRfs/DXJGNQxajWflh6xleCbXox9srAdA04RtY6bUPzpdPipG5Xz9xPXKMCpMBdLSrsn1S0SYKgSs86BhG9q1z/ErlHb2sVOtzBVTVRMQnnN7ZYGNNO3vyYgw4CR3wAnX4AKwZ1xZrMkeVEFcRsVMjt4HgcLHpOJJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26huhBOPS0cGboiODrKUrKRJUTfjlpFFW0syRbYW+Jk=;
 b=JPl91Ze9Jvu2/UI0RguD11VebWCysuTSjpDWSE2odr8A5IvCYYreyUYHEuosEDzwmMoBh3+hfsJGHWiVIjvQlPEqeOdi/kt8mCwTF+ZiVNeMmu7QMz0FAAGBP2bUHedp3Y+QRGYMl5Krb1PCR8L9eDz/kx7PfuRpVvhZBvRzY2EnQHzyHNltx2n+xKMOPExOL58zU1xLo3vW5FQZAENDbwDxqHOSxTFJmx43qZ7dIrIF8+7oeSWODihIyfL8D2razZsUJ7WCqLTXBmZiX4wTvlm2fAeraRAJPI9xw1wgY6P8I/iRuNPR3Nom27Bk5fBRvT9y3nXoChNE+i8bRSAz1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26huhBOPS0cGboiODrKUrKRJUTfjlpFFW0syRbYW+Jk=;
 b=TlQAmsBxAwvUFqmKc9gzf8iuVUq7lOctmO2xKf14TC42N5K0cNu3W2eJ6hQEd+pGFnKRXldfanOxla3idEZveCH0JOb9DBHa+8efbCL/RnBPu7KGetIQZretUiB6VWROv+nmRVXEgLvWwqssTYfH098/KbJ9y2Nx76hFlSqV/SE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:27 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:27 +0000
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
Subject: [PATCH v4 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Sat,  8 Apr 2023 13:47:54 -0700
Message-Id: <20230408204759.14902-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230408204759.14902-1-decui@microsoft.com>
References: <20230408204759.14902-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:303:b7::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BYAPR21MB1336:EE_
X-MS-Office365-Filtering-Correlation-Id: e375bbb7-a548-4802-3335-08db3872be1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hz3fmuyjvBORMcytMo5a8h/oW/bhPKGaZ9Y5AEyfoRBjNW/GnVq7neqfeHqqT5Bn6hv34AQACv3mcgUlAXL0dc59U4Kv07yYLqwGrMbebRuL4bWrIfxcpnkMJiyTvz6eS0JoOuZfb7vLsExWqE1kuUKtpuzh1nTLaWA8/xlGQ1jIpsvMeGpkbx+Ay+KHuqZYG4wrVGJOJXyI9zpW+XWDdXQnUTKGabglfKoZJ3Lgn43ZhGgb9TfHOXE4R6fNqLD8Qpuokdnzzt5wNjvDgX/VuTZ/FCJzW06XNF28XyGwhN5G6pSa9t5WJ/SUF2MxOVvZN6rW0gKVziguGccNVFfCvE9bbkY4OcItjVbUCaP1V/M4idLXVRkExkbC7lVCTRp3+SMs2v0b3IyTFhFmyXogF6DEw1lsFQv5/3dTin/lbjhZBr51yT9kIbctil7QeqY6jHALw3KDl9Lexw9cWCBg2P7rOs6Um8QOATT9NaQxxxgv5dIY8QquvXAVKnhrg7m2AK+sX5um07NsRSM4KBz1Z2+fnv+ArZ12X0B5gJSpvIojMwZKkk/xxPjHJZLBri6Tfjm8WkjMu/LPNReW3VgPIeDk5g/vFwV5rHPSQJE9sc6R6fhh4Wh/PK1L+F9R5GIPupQD1/TGmrvv24MZXeGhAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q1gVLLfQjoVWsGtjT422UEA29Bum+SX2Mid9oinfVygyeYT0tZwlXoy/m15o?=
 =?us-ascii?Q?K7n4X6XyjBclOGaxJ9Qs9ccO1ss87VPjINvREnTLzHFnfl66YNJdlUtCREvu?=
 =?us-ascii?Q?RQgqq8GXRK/QIAjgEPJ78mfleEiClD6OcX39yCAM6OG5EPcYpoDrfkzTVvxw?=
 =?us-ascii?Q?EnS3ENiN9Do0wwBAx3cvprI/vJ86XRWcOonMOnji7Rp+/+q5gFsBvODdXKC2?=
 =?us-ascii?Q?+DyLyiAaEghnZ4sQijXu2VuvOLKiN1jy/TBIZ+ox41eA3QPPbFCXYFPi0mIT?=
 =?us-ascii?Q?mUUmrVRGcxdN2G+jl788fQ21ZdKCcbzoq9+QrTLFU3F+15p/up5Ky2LQNeym?=
 =?us-ascii?Q?lJ14V48cI+ZbhuQWuBBnwkl95v/f6ThyTv4fZ9JOiKuPa7CQ0BzE/14Pf44c?=
 =?us-ascii?Q?LQfHoNgrsCr54iuKiRFdKw5y+tKb2ow2RJz1FpPjBpuHHmFGGP2lmlq10v9s?=
 =?us-ascii?Q?HOeURHY6GQnf6L2lPK+kvR/ZfhXHkpMRbhB7PHEnavX+pxLGR0VgNiNALQnR?=
 =?us-ascii?Q?p4EREd8osNM67hYueB/Adkme3Z+r8iv8Ez8H3khpCH89WbCh8nF3PN8A9LEg?=
 =?us-ascii?Q?U3jifSjV2MRlxL938ckN/zKz4CNW8n/8WPyKq+V04+eDiAMYPM/VYc7tLqQ8?=
 =?us-ascii?Q?03KSLzDW1yJeI9Rwe5X371kKThFu/zesQAjDMgRBRE41pUDrhOZdC1q8oJY6?=
 =?us-ascii?Q?E20JPyCY/7H5o/7l1yzpbeeJEmImmrGNIqQRRzCXozdXuJ/MoRCS+5YJLfM2?=
 =?us-ascii?Q?kt2HDs5CVvVgxNpAusFP6w/yBq44B5JTF0ow30BoquGO05rfVw7n1KJEvQyO?=
 =?us-ascii?Q?ESpebtMYTYdTnDlZ1z0ivrUuBpUCzkS1489R02qqjaxDgpGND7/VEPSy9MVq?=
 =?us-ascii?Q?A+dLhlJOyslWiCqanbRpAZUpoqwZxnjtM6as19VRyaY3UgcwWzzkgP3fjOlJ?=
 =?us-ascii?Q?J3+hSuRigH1q7fc10nTDPBj+wTs3Td8SJW98kV9Ld9wlf64ucpRPMg12HE3z?=
 =?us-ascii?Q?gZoztBg6aojzKGmW9TlXGK/YGGOjVITHUj128uYe1arhnTLAq8cjYIZCAfh7?=
 =?us-ascii?Q?yK3Phu0r9DHjxIFN/pCv/9r6MiRLayC2gXs9Q26GpXWmV3//CI3vM7IoNIpB?=
 =?us-ascii?Q?CytQLvy6U3G2XbIRFgaQ6eLvxHUfyBNgDNMomIOxUhlJidaXr4YvltGRjH4k?=
 =?us-ascii?Q?rHwmCAGAa+USeQF0Xwkl7XncjmXOPWKIcNbHzth4i+lBjsDHOFmvzg9qE/zw?=
 =?us-ascii?Q?oJyBw0zyvpc+XcjYLU5e1Pm20Pj7xnpaWCprE1bLZDD3Bz5RGw6/j4itCQeY?=
 =?us-ascii?Q?20olXN7+LDUIYprze+zZSkq3+6hZ1ohT9vi/T+55CvVLbl9FJdAKU/I80eLS?=
 =?us-ascii?Q?IwsV9NmILLR+ezRWnwwnXsSBzif+cwK5biYAYFvapwOVKogS6k+IJcjli6r7?=
 =?us-ascii?Q?8iLu7mdzrDCuYW9hwSrdySa/Xk2BCnIgcsYU1l6jtrLnDGR2tZrVJeh1vexu?=
 =?us-ascii?Q?vNHYvtCd2ORxqhKBMDE1MrpD9raAINx59SuUuxStkO6D6THju4XGXyV2Zl9l?=
 =?us-ascii?Q?1pXocBkX+PikjaHHNSoebCiOUlAieUjpE93hJtV5cdRxhwyLKZIBeMjFxD/7?=
 =?us-ascii?Q?/xoQc81J5yTaKq+MMZ30lgLrpx9VTRgnel5Iam6DJGNM?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e375bbb7-a548-4802-3335-08db3872be1f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:27.2640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JqABzvTGBF3XV83w28RNZJoCA0Q9pkQ0LuABiRXyaIKyc6GR1MaI7h6rib8RZAi1acy2lU0wdAOBCPgNVeVYjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1336
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
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

When a TDX guest runs on Hyper-V, Hyper-V returns the retry error
when hyperv_init() -> swiotlb_update_mem_attributes() ->
set_memory_decrypted() decrypts up to 1GB of swiotlb bounce buffers.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 4c4c6db39eca3..5574c91541a2d 100644
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

