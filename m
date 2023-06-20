Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC07370E7
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 17:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjFTPtJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 11:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjFTPtH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 11:49:07 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020024.outbound.protection.outlook.com [52.101.61.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EB4E6E;
        Tue, 20 Jun 2023 08:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cex+Vgk+ISpA8upn//2vk3TN9wUkCyxmAQAaXH1tl4u+E8hhZ/pf39YDGjeN0LZ2O8edATYksiYhtqup1Lg91zItMPKburYebOWjTkDZRqQrjYOptm4+lesJzg4yDew625UknjnIdH5pTwgFnc2kox7y/yATByI1OItMjrX1zANbXcbIXv75IcZIInLuWqkQlr8SFvHK9imzwaw05O9YwbvNxgfe8zLORm9TprGeaf4fT0eG89YYjtkMf92su3HHeCf04Z3r3nEontwVhLITHzRMyQZe0neZCVTEflYcrwCJsTgZqlbxR19uZHGjgJfQoI5hxhzSrsDp5ShrxMw7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVr+XxLW7TIxPbTF/rIR4CSsiOeMRaOvbCn2pLWSnPA=;
 b=gxLWtxfwWl2dIjRLdr3NnVMdPgU4uXVSpuYlAS/uuJXV3Qc9st9FEivl0Gw/a0XPe0bagzbZzVRLu8vH72IpeoIMyzIxogBRNGPDo/tyAeLZttXSs/4zyXe7HGFhOMCTN0+SwK5nRt5T9zp7aEA4BqkiVCvP82ZGSuW0RxZeHquhI/B/HsEXYtOG8tbRWRclTV71Eo/wfmoMn8V/YIuuQGxtTefSIWbXIPvHCCWwJH4GKXvdu5RdEfpSbTQ6jGC1TA76A81v0HpEPVI8a8ZO4H4AVhya1pnklBio+E0s0eHNiHbl8GP25VBVuCw+0glaz89NIfX4mx1Vf7O3TP0IdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVr+XxLW7TIxPbTF/rIR4CSsiOeMRaOvbCn2pLWSnPA=;
 b=ClLusvVbCmMqUkdv1EnCTbNPw80SiaYoUlQOzUOUBUwsKO9sSqQqO2vKwVVeZmVMQd+z1J2usm9FeJbmbzRTPvqswQo3uK+zPN8QyMMO7/UTJN1EIgMLx8U8WV3w868CoJeJ9wykqntJ6S+nloYrEOY1qw5Sp35Cdzxi4gBO5ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM4PR21MB3585.namprd21.prod.outlook.com
 (2603:10b6:8:a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Tue, 20 Jun
 2023 15:49:01 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6544.006; Tue, 20 Jun 2023
 15:49:01 +0000
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
Subject: [PATCH v8 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Tue, 20 Jun 2023 08:48:29 -0700
Message-Id: <20230620154830.25442-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230620154830.25442-1-decui@microsoft.com>
References: <20230620154830.25442-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0023.namprd16.prod.outlook.com (2603:10b6:907::36)
 To BL0PR2101MB1092.namprd21.prod.outlook.com (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM4PR21MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: ae9a5705-9ac0-4220-e21d-08db71a5ddd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GpxsfDt7YsxjzbVnnFgq70/4hhpImJ18CH44SwG4COQaHMfaEtJV7/cFxTjai1H9EsVqHdxNby10Y+r6Wyx74A9h+wqEihRMRlbv2rnYzb91tAr+Dhv6ff+uw697dWb43jsg/o+w2HUYebajrNbe+geEnWncYYuTcQUbjp1xSlIorFd1gqWlWAABWDK29aKKb9T2pIGoPCQ9IONB4OO/zQbZJhiZI0MZIh4WtXD7vE4oPP8g3qDgjPd9qrFaMy9i+o1s0Mbf+klvlPfdhiZgsDeXD5RHuwqnj5u77etnAwKE9ZwuXlDxeflO31zA/qC87e2rOxXlK5no2KUVlvhLJIJ61cdR1PYGpuQVL8CgAhUDE8VRrlejC5QE8RhGU7vFBAkJ6s52P5YNqH0vNee8bglpk0YN5giVC1aN8S2sP2FfSZnhhPLvqMmVwy4jJB66vaWIJxXmM/VbV3YYGcPJOhDXmlL+M4eKpZ7ZVLM9odeAPRNwDXgv9X7vdxXvpJHAh337FDK1/7ig/QmszRhUILyNSrmxNyWXV6ALOsUe3Wc7JneszCylmb0V01WhEKBNq30KwUy8GuFaXCn59J+Isv9B6EtvIFIMtcS9kSKiLw8o7LROg3l27OEb2eJQY4TtnrQEKS92NKRbnpjKPjGLDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(52116002)(186003)(478600001)(966005)(6486002)(6666004)(86362001)(1076003)(6506007)(6512007)(107886003)(10290500003)(2616005)(38100700002)(316002)(82960400001)(82950400001)(83380400001)(66556008)(6636002)(66476007)(4326008)(66946007)(921005)(8676002)(8936002)(7416002)(5660300002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgNClseu66F3LlmewTDjjQUAxkgLBDoS+JX2rra+1owPerdd1G/78Mhf+k29?=
 =?us-ascii?Q?ilMH36gQZmeFhKNefwtLQJD/1FguRQNJRaIFCpDvvR/HKXReGElkkNgoUEK2?=
 =?us-ascii?Q?rJiuKzy7Mqhzxj5ftuJviXozv8jl0orIFl1s5uD0lKaEvS+CZCW+q/eJydJo?=
 =?us-ascii?Q?wnszl2W+41Ehk/pqsZPXH6FCMVie7QJuWT17Y0AkFkoq+97pH4r4yA2/joIJ?=
 =?us-ascii?Q?52Kopa02rf/B3uLkpku7DtkUIIwoFUefLLwsr1L9NwP7SbFwn/QOR9CUf8xU?=
 =?us-ascii?Q?K18XFIXBkyJ7RFo0LS+JW8VrWMXXYMgCW9aWrpWt/g1LZ/E9M2TiiEfg8wnM?=
 =?us-ascii?Q?wFrmIOARQ6pXezCFc4JHhKJJ6dW6DrmJMvLPz2r6vJl4HJFJikvDg+rMG7IC?=
 =?us-ascii?Q?S0SR0DQ/ugSdO4m36Qb6PFbFwD7OGgaw+kao6RJ83G68ds+/ZVe0/lEK4NSj?=
 =?us-ascii?Q?u/mnPNvLE2u7UBSiI3RdR2vjGo+B4s5C311ezOJZSBR82imEJ728X2cnaEsL?=
 =?us-ascii?Q?q5p70B+cgUKH6sgUDJdBZL0eW5JJYD41frR900Hhu9BPGiCNk+y5PRMnqvmq?=
 =?us-ascii?Q?IHYnnpZ+k62rDucc4kr3oevoBv19kXbRDnUrPbA/5XkAZ92hSuQ4WbrEB589?=
 =?us-ascii?Q?xGzZeSeN/nhnxPHzD5fe+4NE5izDk+FPgYb9zNR6J2CiThTh7glhAuAUe0d9?=
 =?us-ascii?Q?oUbtzlx5+gZ3mVI2kxWUr0qbLAxya9NDy2WJ16WwUIj/xt363XQTn/ZG8yNu?=
 =?us-ascii?Q?zrOsqjBnbXXxbTN7CKFd49B/EofVw/QgKbn2JZQN0/v3/WKiVRNxTGIdfDF+?=
 =?us-ascii?Q?l81IDDM032hn9BaeOtZUiVDUbVOj/ojnGrmP1Ymny8fgh8mSVJN4i7XaqyaQ?=
 =?us-ascii?Q?dyC2oLs9jfCaSlYPZu3NrAE4IM6YqCf6cvUlpvPwvwvb4lI18NQ5ZkXmBm03?=
 =?us-ascii?Q?nufb/Fz9Q3clXXeYOBWk9hP6jgWGar3sAT9r5DjN6foId5NJjjKeMrGZnB5W?=
 =?us-ascii?Q?Rw4hlinRBpI8beToABcimBY4TcSyrzsRKakLV33Mi1uaVz8qNtFPgy2BOs54?=
 =?us-ascii?Q?NaAbVa9rqrChXvfspeqiUvcDtHLIJ9BMpRd+s19j+7D4ZqJvQMLpB4ssUN6N?=
 =?us-ascii?Q?zPHhIXq6NOdHvHuP3Wcl8F0Bk5C5JOSjMCzrVW1O/ZuvYBpRuCyOkG+9Vq+t?=
 =?us-ascii?Q?J6gNenxnjlH7gISjGbWL8noYfVL+W79YICZ3TELTvPqG+2h46ZzjJbjjSx3f?=
 =?us-ascii?Q?mvD/35tkmR+e4m9v1T4IJoqlnL0nokeipQ4KqXWlmLmE0RF3rSqk8J79EzCQ?=
 =?us-ascii?Q?VmvT5z95eCVzPjPFS05yV7mPe3UI8TQNV0EownPX6fiUn05X3iUt1Fmt4onH?=
 =?us-ascii?Q?BjxW7HxncK/OB7zTQhZNQ3X6dAO5Wjj2UfFF7j/KfZZXaBu9kpilhkTN4qU7?=
 =?us-ascii?Q?hPc5WwM1L8kOHAAJYkVGqI3W2D5m1FgOszf/WKqKv9rJNprP8A+69GL+qcca?=
 =?us-ascii?Q?iqtT1fBhoxahMcf3cojH/sJMSXlmIHc+zHrnb20Fmn+NgBYrN6vqLZiZobDw?=
 =?us-ascii?Q?Xs0CuwZ48jPleEoqjR5spMe/Sy0OhrcjawQgDWiF09hniSSNBMqpj9oe/7yZ?=
 =?us-ascii?Q?BEfGEbO9vD1RYcJkcoASmGNcKGgWXVMaQQQY3ODQBFKU?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae9a5705-9ac0-4220-e21d-08db71a5ddd7
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:49:00.9898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82V3TPlc8r3FmtG3qiuRclx3NxoxqrOEP252VfA+ZKzJan2EJwlxnSIWkmdxYHp7TApK4zmZ0n2SXzL9AU8uOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3585
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
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

 arch/x86/coco/tdx/tdx.c           | 63 +++++++++++++++++++++++++------
 arch/x86/include/asm/shared/tdx.h |  2 +
 2 files changed, 53 insertions(+), 12 deletions(-)

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

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 1d6b863c42b0..0c198ab73aa7 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -703,14 +703,16 @@ static bool tdx_cache_flush_required(void)
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
+	const int max_retries_per_page = 3;
+	struct tdx_hypercall_args args;
+	u64 map_fail_paddr, ret;
+	int retry_count = 0;
 
 	if (!enc) {
 		/* Set the shared (decrypted) bits: */
@@ -718,12 +720,49 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 		end   |= cc_mkdec(0);
 	}
 
-	/*
-	 * Notify the VMM about page mapping conversion. More info about ABI
-	 * can be found in TDX Guest-Host-Communication Interface (GHCI),
-	 * section "TDG.VP.VMCALL<MapGPA>"
-	 */
-	if (_tdx_hypercall(TDVMCALL_MAP_GPA, start, end - start, 0, 0))
+	while (retry_count < max_retries_per_page) {
+		memset(&args, 0, sizeof(args));
+		args.r10 = TDX_HYPERCALL_STANDARD;
+		args.r11 = TDVMCALL_MAP_GPA;
+		args.r12 = start;
+		args.r13 = end - start;
+
+		ret = __tdx_hypercall_ret(&args);
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

