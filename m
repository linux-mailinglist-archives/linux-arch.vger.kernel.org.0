Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C2173264F
	for <lists+linux-arch@lfdr.de>; Fri, 16 Jun 2023 06:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjFPErX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Jun 2023 00:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjFPErW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Jun 2023 00:47:22 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021022.outbound.protection.outlook.com [52.101.57.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783402D5F;
        Thu, 15 Jun 2023 21:47:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsQNFtULFsiO6g8WyQA4bsi+lYneMkr0ORbr1Zb2aoYRBGBXbQL2kJQp4cwZ9CFaLUSKSulZsSo73PAsvDMM46gGCTJElt09uijRVMSosOqsPC6PR2AsnrMgWCbtvdGwe1oBvOkYqHTxUOCR/TnHpmPjQc/7WlJm+NA2Ge5dcXinaBUHi3d+Elxvw4IzG2oKZv9Dbl5NGSEIfmT1q5JyKXzwZ0ztTl2YCm28arsl4kM1MsY/cxc3KZK2vyAATKdP4PojQRuaqFVwS7RV+t/AIm9xAqmlrhGSH/UkSvPY+kQa7pZ0g+nXtTs5883FFTVhuUJhmhrlzeFEHjIkT5/6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GvG51ZG1C5VkW6dYuRBLwEnLrB62+7EGKcR27FiqnY=;
 b=J8rf7ri0XcRMOTW8xpi/lcjYdTH8CId+zn+Dg0g8KcvmMejv38WTtEiOvW2ibPaY1woNHKRbSbbUBf9VTYm9WQDsHSB5p9BfHKdXj/tnLRVhMza9jPoU5wYkeBVFmjw6LzhA/NzjuteAMriokbSx3r6FeWFOapkEd9rEMG4bR6hOm/5N8yQ5o/aVczjjsxdFoHgelQ4U4JZH9+Xe+ahBBftPyFSRc5uo4Sp92M9/xMpiuUnvsOPwVMyWF+hBHB5ZVUrycTGh9B/6O6ts1zSr8lEwM5yOY5Y4FxKVhPbrbEUzKxZcpoGUH7/vVF8vY2heZdCEkobhcl1fXZ7sF7KbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GvG51ZG1C5VkW6dYuRBLwEnLrB62+7EGKcR27FiqnY=;
 b=cGebcxeyDyHBTufHtQf5zXR39dJoSV5/6S0Kwwd+fXvjWq/SIq6Lo4v4PKuo0SI18sUVyUFhUv3gQxvYnFvPAGZuyQXewk5c7hvDv8uKNO2hZjzJPc5AgknITzrBDC6Xwa0AunOhobZZmUbGuK8LQvsmTp8aTuRD6nMuF3szVV4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by LV2PR21MB3158.namprd21.prod.outlook.com
 (2603:10b6:408:174::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.6; Fri, 16 Jun
 2023 04:47:19 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6521.013; Fri, 16 Jun 2023
 04:47:19 +0000
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
Subject: [PATCH v7 1/2] x86/tdx: Retry TDVMCALL_MAP_GPA() when needed
Date:   Thu, 15 Jun 2023 21:47:00 -0700
Message-Id: <20230616044701.15888-2-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6372be61-173d-4565-0eb4-08db6e24c43f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGCMt4CFPNQ2zX1mgTapD6trXfVaw2u0mGFqj1OP7IZmADAYfVvEzQ2afUlSvLwuIzTDscuhhbiQ2z9nd8MGppwV7wb7hfotNfb/vKYpaZ9fLba4JcluXxVm8Ia4pRQrhDbKJC3mqjiL3cU835pyuZDRqdfUAwPv/TWOISzAJsHdPvn9zshWDXvksdHj0eM1+m3FmnCySOufeiqhc3G/OcbjIbt694gUSTEzaWy7JQsISKULO4CSws6TJzy7OuUXUKMUCF30BLQ0yYkht2INwK/s4S1NqS7Ih+E8LGVpxcGCaX2gBHiAVJRtAmcfC1dFeeNTejXsJbMzBMpHyItOZ4YOnkQIn6RddhG+6C9fIsbpOD8FMB3J7exhyu6L/3bbbmaAVS6HNhfKyTZM9nDv2/xLGwlw2TwOR0/7T7NVbnJ85IKV3wyX8OGEjwP3sZ4iUTqNT9oPxLU/6J849eeq0PPsqWMJgAunMsnCsLke2DBhPFmkD7uLBlfOIUoVuKdCHPa6dPxlaY5OxhpOqzGk7ZXMzWRzCh6oSL1Fdk1MPqA/l8Pp9TidMrH1FsoOtevcpzCeBfHX8coCbVUB7GeBl1JgrKD5FgjlUUWmpj1vLIgJT37quMsY3kWGLBbzcxD0sjsCZxMB6HwiRRikthWoNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(921005)(38100700002)(82960400001)(82950400001)(10290500003)(66476007)(478600001)(66556008)(66946007)(6666004)(86362001)(36756003)(1076003)(6486002)(966005)(52116002)(186003)(6512007)(107886003)(6506007)(316002)(4326008)(8676002)(2906002)(7416002)(6636002)(8936002)(5660300002)(83380400001)(2616005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jlcmx8V3ZYiQsQZYEUVj96HYkAvgraLKhXcacwLDX6MTXHHj/4N3xRbNsKuw?=
 =?us-ascii?Q?CFWOdMD1FqL767+EdTA9BL0XkejremK3iPR85SyF1f2lO8q+cl3ae8no43Ik?=
 =?us-ascii?Q?9iN4AsxZe5UMo/WPWry+ZGMqP1KkYZL00SgL30Pj180mvnQLR9Q/KQC8dcNd?=
 =?us-ascii?Q?b1YsGfb6xmHu6na3PSXMox1PHC+fYSAQUGJHt67nfzXZOi03DjaDpSoRgsjO?=
 =?us-ascii?Q?m3G7ToUQClHJdbtgJSkkzhwua6S6KCESjf2fdznGrjDGfkp8o9wppxGDph7Z?=
 =?us-ascii?Q?ssodlKMY0P6ziilB7quFdQDjSdFiXgrLPp26VVJQT4KkTfPvy8H6OktVhu3R?=
 =?us-ascii?Q?vbxrdztqAKDAQTnjE2UxjqwxaI0QuWuraBJBl1yeWhrvsYJpTatg6CUNgGAS?=
 =?us-ascii?Q?Rjz/Zbbtg9KQnO0m8P5VR4lt36J/scG6U075H8D8YmHrv7aFNIcJeKeUiJdt?=
 =?us-ascii?Q?EVxbOMEu5otOdyuELL/WUy8edFEsz2j9w9ve9PB2moHKEsnBgSew3hFFFlIX?=
 =?us-ascii?Q?jKBVgVEll909G3l9WEzj5Gme89Q8AL9fC3ggvgRau+zQWOD6kaMKMkJFzT9w?=
 =?us-ascii?Q?UFmPDrJjGHG248+b7aFe5Q1CYP1FhoYL5OyJBWDz5OZPBY4Mkcd6RSldBLmJ?=
 =?us-ascii?Q?u4NyZ3O457xXD8T3o1y5pXZYE4TgIoqJ4Ml0IpHkcj054XrI7BO/3+jufQgv?=
 =?us-ascii?Q?IOOtMrHfGEeUbK0Z4y7LtAL/I6GZoj9akWIMGlpvChlk25caOmNiHmCGkWLB?=
 =?us-ascii?Q?avSbVlvQ4YiZhZWy+nlo0leBNENJ1QRemEKjuN24DYVbCDLRK7ZZLehdLeJp?=
 =?us-ascii?Q?7QFxjnT/wAfsz2tefD/Yb1XVy+DAOmh2X8MxZyPwBqcR72orZz11V5SdIQxT?=
 =?us-ascii?Q?udbota3WUij9Yr6NpDuUEhnZjQmGVnnLxHHViEMNKVBqy++HTEnLnJtLyvaS?=
 =?us-ascii?Q?hquPiEn5PxV/WEh2ufIZ9+cphqVSbcJhjdcURRa0+Gu1/4WSJVmb91Pf0gXQ?=
 =?us-ascii?Q?RFFot4t4hLKLr7Vo8F4ok0ELo2umK+sSWbUkMDNpWeODFMaVgeK274WMUWMd?=
 =?us-ascii?Q?ElA7KjKN5crsF5rQdAtkWxqzzk9Uvr/oT+jDSKU6h1nTIMIWKGLJgku/RfQI?=
 =?us-ascii?Q?moCPfg1pE+vVwoLgEVRBgioPREZbmt0ZaCPGDkTU/KAP1wenZ5C7oDDjE2GS?=
 =?us-ascii?Q?kvOEFU+S8eD0sY5lo9pzHFFZeglCLQTPMwHEvBEi9EPVp5pAJKuNqNqSzHK7?=
 =?us-ascii?Q?9K0iYPzhtxeJimrW6ZY1lRbdn/o+TwgABEzNYR3MhKCK54XKZglpKdk/zpAt?=
 =?us-ascii?Q?saAtIlerc9kiBw53tDm3mEhVNdUlaDIfWG2+quGNzRCxzuszBp6Mr+zJfahR?=
 =?us-ascii?Q?y4+j9Jepr6iXKVXu7fpvgkrUCv1gFakwMCavNlDcPOYtF+v6mLWBbGPJdB9f?=
 =?us-ascii?Q?77VaJwCStRNbPHtzOzjaIHRrqrvJBsurSNsFbZu89tSjJ0NfTvtkToLG5BDp?=
 =?us-ascii?Q?82aIa9morGy7V2Lq0H87OQ4Kbxy8G0YI5wyrlNJeJMf9BLw2gjYVGyLYliDm?=
 =?us-ascii?Q?sHm5mxE3egb5Vrm7LfK/rDfjhkqNSVaxAwaMcKYTrCb++k4fOaSmBk6YbyTX?=
 =?us-ascii?Q?EnRd3Kp+L1XbDubtXV7DFFEqFt7rI6apFaiEHYEqHs7b?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6372be61-173d-4565-0eb4-08db6e24c43f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 04:47:19.5437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dLmMk689oDmAU0n0pQ8eTirL8Bj/s6dS0NycN1/HYtkh7ncMU3y8umnIsJu3HQHYOMxZbnTSTxEeg1KH8XdzKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR21MB3158
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


 arch/x86/coco/tdx/tdx.c | 65 +++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cde174f4e239..5b62a1f5bd79 100644
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
@@ -777,14 +779,16 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -792,12 +796,49 @@ static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
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

