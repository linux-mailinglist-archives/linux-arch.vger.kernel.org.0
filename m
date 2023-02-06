Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAEE68C6BC
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjBFT0Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjBFT0X (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:26:23 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A0A1C7F5;
        Mon,  6 Feb 2023 11:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjqSGyn9oCqJPBBwBdtBMrqu/Rm4F+30pSNElUMH64lpz/uP+4c8HdukRRvvZODzCxz4ulBrVhDiaV2M/MYZ6jbGqfJVz/kWiwa5cIVp9tRU3oKFxBmX9Y0S7E5mzUOS5Op5le5+GgthvP8PfbzStqkXzbd4yXD7faG36KEz5cbZBLt4eNWk6f/7SPnXltqb+iOdO7hVrfC2o+eorl37Yu+lKGpd2BDF8BrD5RdW3dZBQAeNn9sGcjn8Y3TodKvvLNWjDmrYnPhcIoScbXEzO7L44FCwZhawNeD+tOzD3AWrbtrXMFPArD2OOknNEXdEJbLmwtBOsKtMAmTIchbJ8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IW+h5yxBvtHo6MF5lw5E9Vq1D12/RoV5NdvMkoOACo=;
 b=KahL6S+wNwxwVb04AAwcfmZM6UmOSJozhTQeYlr9DtFv+OcuVzQd6W38q9pL0DZZZd990Fi1Qju7oAG/rQu7vCkl3bRb8nLtYSlB8sDCSR+r4zvuqiBRTiKUWFbpNMCuKcBeyOs8knfRuj7rbvDR3JTQJ6L/wZkQw60Bn71W2aNrANYmV1KagJ9KqKX4n4EKkehNzNS3DQMCcPi2TZHAiLf5rS8dgQcTwejp+uSIkI9gucoZa8lXEvSoe1omm/Sp3caO/lhHGTQNfTvHbJ60y58hofvBu3YPp/GPqo6vhh2MQHHJrUVp61ROaixtpsbdrhbR7JxCVy3jCoXGuxE4iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:19 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:19 +0000
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
Subject: [PATCH v3 1/6] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Mon,  6 Feb 2023 11:24:14 -0800
Message-Id: <20230206192419.24525-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: b05092eb-40f3-4928-7a55-08db08780589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vmodo7yk95IwDDc8yla1thSV6/Pk9aZ3KV3bJuy+go0yRkqAAGEMiJruirHlsNUVCZRvty9CmBz4bYygVJVB5WxU+nasu4G2Xb8V6K3DimFNlCfxVVQdcV+JLJgLaRUQ3wOdgJ9g91VNYI4BdPGACBEsAIdcY9QKoLkoejhcn6GeqCkDiiaMNv9t8HAT9fkofUv6c2q7oUqL+s7rQtppDq4aHapZdVA9sP1sEOfZDKn6/6BXO4SH0e8m5+t9czZUyPYqwm8hyLzzuw4QHXIVjubsXb4XQa94QJorCCj/Q6hElqCsVH8tPkpnf3xLRHbrxun2GxSfuKvJkIqfMJoIuSRmkVwoOAV28GEGeqUAjt8GGhIhIotSbTVSYal5+XfwV817vpTZJgptAzSqv5anfnTjez1NYeKd2cc8warjo1hcj+2hU4aOChbprF1NJSAHWZKpV4/3ZlKMxrDRqGRAqF5vEPUhlNVp9qPGJROWY4cwO04bl1kcCMxnFk7RdC13l4khP8bFCAtX0usxsP0hKR5HxNvm+CcEugXGdyfRsiY7yHf+WDP2t1rbtDH8SC0Q+YlO2R5FYYIle8OkJt2e72xiV5I/VGa3X3PefVb0tPA6+0GXKsFvFl6Jsmf6RkULg1Yx7oO4x5kvvJ1NzITslka7y45TSR/uzkZxnv5SxISTbXDuekTrK1TEcEXQZeohGxsk+AOutaVxoyZ4QhGELeBIG0iBfNc+5bhG4epPbZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nBFUOB8EXN2o3y5DfFfzERjoDpIvfw9vl50CMDBvLFhlt3jR8HgHMUx56ScG?=
 =?us-ascii?Q?dxKiXe+EtousiXlL4+1Sg+PgnpjBDNANkA0DL+N0b7HyBRJrZDSUgyWzj8dA?=
 =?us-ascii?Q?aNEFLf0kJgwamHF6sTiDHPpx21V3CBvH2CcAGFaPHnpeQhiYyEsHVHKVd+66?=
 =?us-ascii?Q?2NC10LiQoTfwuMKriPFhCG+xZokcguReWThVwz1VO1TeWZjy4Tpz6YNov0x8?=
 =?us-ascii?Q?6symR7QnWi3aaoMCLoPig6L8E16+3OWT7ZnlA+Q+ViqIOUS3b3+I0ICnPnY9?=
 =?us-ascii?Q?zcCFz+utmun9CBCFph6W5TLEY/Tn/HQtEFRkH3/UB3P9eBkUsaUZKbDkHfUj?=
 =?us-ascii?Q?7G9dIjkU+kGT14kzv0DKnS5et7AhWqfV5TaTSbMqWG3VKP1tNyDv7OxdeDmP?=
 =?us-ascii?Q?VN3/7v8KEdG8dngxUjmWagLkdgf+7aJ60RTTYkh/yyyzth3uAo1zoNRDdf5b?=
 =?us-ascii?Q?3e/au7aNTa9CCZOiMPy+6YZ3VAtufdm8/iv567OXjFJiYug3cP8+bVCMrRix?=
 =?us-ascii?Q?pA1MS4rxB1DLyslntU+gWm4ZoCQn4Ayjdp00mQ2im3XVHVagG1iF46aMXATc?=
 =?us-ascii?Q?+ASq+9WByed1wK9FjfFNC1PYCrmyop4XSI9haMy4Vgd2S6ThfDKe9UxqLtTh?=
 =?us-ascii?Q?0W/3WxhFA6J9j5sBS/0bDGwH/Bequ3IzbyYFUEYZrc0X1i2TW4upsQvyZdTF?=
 =?us-ascii?Q?y2bQ5tgimcs76MZglnUNHBMrkGi3JVJGsv9feHnJVBj2z9Ak9nArvO/fJIxm?=
 =?us-ascii?Q?MGnFnl7On1UBXfPWibUJxezB/yuZhWwgsry5Ht/e7lYC9sDF8m3urC8QoWBs?=
 =?us-ascii?Q?ozg6Ku32Hn7zZbsTMouFHwv2a105IELcS8x3dPZ52HWmWhbQGJcFG+WNvyM6?=
 =?us-ascii?Q?afr4NZOQvRadVI44vgs5viApvXEIPQJ/4AUQfSMiUP1zNy9IDfIk7KfkUAFH?=
 =?us-ascii?Q?t2XPuz3Jf/EpYEe7U1pE0RC1KvzBR56slvC6ng8oYMSdXwH/rNnokX4hj3lw?=
 =?us-ascii?Q?8LPX/t9XpCyITrkrXAQ/5M5s4DN8+l7/sxoua5G9YErZjT89F9znoLFWDSSf?=
 =?us-ascii?Q?ldDne0kvXdBpEetGpT57GFjvpHUZxeb6Z2oJaVpQKqjUTH9p7zAKNSwlmSEy?=
 =?us-ascii?Q?UDcNuCXDXIIHjP2klNdzV/+qib9igyE8kh/wGAmXvaKY01+cZ7O/O1DsiBgu?=
 =?us-ascii?Q?owDLZKW+rft8/xYILE163+oJ+9xwD/NDYv2T4amx6nzFd2Hch9FQvVgZjdKX?=
 =?us-ascii?Q?EREHry7FD63zlU5I/E+9Cxnyu/JjzOhilKw8wB04EBKmFxmAIPmr0CDkgKOx?=
 =?us-ascii?Q?B2azjsAvyQRmWumOVjN/cUSBdiFnrbm6WVTZQlZBC/07Q+TwA8M0i8ijETx6?=
 =?us-ascii?Q?TGXs2DEhK0VODI4ZCAESPckTi6zI38RtFtJohCJLuWHBwoNYohO7qtIXpKRR?=
 =?us-ascii?Q?4agHqD+dhW/CRbXosjY6XI/govuh3fSXqz+iVb/ukfUJxu05AH0Bl7nHmaDc?=
 =?us-ascii?Q?ATcZhTG8xGZa2rAxBdL7sHVjUVA8Hls90L0zOWmT1q7I8Ph95CjLZja8ZlQi?=
 =?us-ascii?Q?RMw3n+y8zNx59oKLtnVB4R0Edys9uzsiZWurogOnn0dt8Yh0XkQuwWhdQBvK?=
 =?us-ascii?Q?I6Fw7LRibNgzivuzXlym6c3SlXc6khHmMoz1hj8bOHfu?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b05092eb-40f3-4928-7a55-08db08780589
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:19.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4B5ANL2UxHn69ocuohqchOLsaUoG8OlzHTLdiOYgqDJWPyaVuhoNqHgORWcA3rC2YQmHMbpSCb2w9DSQ9gp9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

Changes in v2:
  Used __tdx_hypercall() directly in tdx_map_gpa().
  Added a max_retry_cnt of 1000.
  Renamed a few variables, e.g., r11 -> map_fail_paddr.

Changes in v3:
  Changed max_retry_cnt from 1000 to 3.

 arch/x86/coco/tdx/tdx.c | 64 +++++++++++++++++++++++++++++++++--------
 1 file changed, 52 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 583ac2f1a5fe..6e2665c07395 100644
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
@@ -799,14 +801,15 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -814,12 +817,49 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
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
+		ret = __tdx_hypercall(&args, TDX_HCALL_HAS_OUTPUT);
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

