Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A217370E9
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jun 2023 17:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjFTPtL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jun 2023 11:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjFTPtJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 20 Jun 2023 11:49:09 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020027.outbound.protection.outlook.com [52.101.61.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230DCE72;
        Tue, 20 Jun 2023 08:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6MYxDB4/EIRI4feqD14g8dl4TunB7CLMwPobFNBdnH7qJXztQtzbHMXHyemxU1GJZon/7Lt2WOTNUkJtDn2JTS6UW6VBK7lL32zMix3k4zEAUkVhwiU13lre+82JK4XXwTOJaax7PuTxJr2nb/csOvNLxJfmWi8U+8x5dDqpiHByHd0tVK1bWn9MRZwrflu1Pb2k83muvj+pKst1lcsQUyRlg9SCA9Q3RU5tmALWCGDpWv9yCKtHHUr8pLtSY3xqMR47Soa8a8S4+q8W4RFszFFPX3cU7Cww3EFF2l8Ck7vcGL7WUM5yw0I8vGIBR6r95huQUo067s1P3wyRzbT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMhMHHKXXv6Xvf1JML21B4Iw5otO8hwEC5OErWhDUh8=;
 b=NpGBOuJvH4e1NSf1j0zVU+XwSVW32HZ45r8izodITK6e5fs5EBI7F+d7Pgr4NNwr1Rw+wjqMWpHMngA2Zm5KYrWHMEFvZGs1inq0+DBJdFywuYwAxcl+FxjX4HOXsj/v14E22sIyO12mtmqlMFqa21xN4M/UUUNVW2TfVttMMxIKeYOHZkmxKIuEfHFDDbi9m+aOiqEitlcicUCzlsCh2XhIxklN/MBAOFoDVYzldC83gYySasDngHaBFKjO5tK8GnW3SCP4tvqisIHDhKt9i1h5ik+BVHs7TbCp4ODMm5/UpYNjOjBvebCl805utmItJULrBbr/oLr5LqVwz7HxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMhMHHKXXv6Xvf1JML21B4Iw5otO8hwEC5OErWhDUh8=;
 b=iJkhA8EWPC2ENCVvJKJusBMLduO8wGEP5QfoWEQYHHP8w6QJu5Yt8je23jmqVFXAc6R8trkgrHRkirfr7KJSVzbCC1/sj4fDdh2JAqWvTgN5lfXlWAhl4R++vx7fBAN4cGTxPaM06/PlQWDSn8byPp1gMkm1bYgjss57Az8AG+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM4PR21MB3585.namprd21.prod.outlook.com
 (2603:10b6:8:a3::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.4; Tue, 20 Jun
 2023 15:49:03 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::e673:bfeb:d3c1:7682%3]) with mapi id 15.20.6544.006; Tue, 20 Jun 2023
 15:49:03 +0000
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
Subject: [PATCH v8 2/2] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Tue, 20 Jun 2023 08:48:30 -0700
Message-Id: <20230620154830.25442-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1399c80-6fdf-41e7-b408-08db71a5df57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lnRjp1p8v/xpF49IJeP/Wkx+PjGlUG3/9xD9j0ve+od3FGolvvjzDNbGlw6O6Yx494/IBsXOcuz8vH/IMlsrXIVhmmmrsEzQLHP6z6hFOCYdI+6gnlyeYRbNctwsGn+IQHpBmYOub8l2IeCrp8X64cthAIP6wSFnEmSzheI+gd/Yp/qsLpvzqEYwkfBtG/zJGfuhadTwjw7Eunm07RFhI/xWWfQaxecMH4GiQzdLRmc96WLU9xvk0CLplus76epuBSqTbFgs1rDfNQqUWIb4lc1AuDjS4vGjtlzGSFW6ebOmqEuZ9xQ2UcwuE5aWaggcxV1bxUv5RVlVSimAU7euESGtvFtBpx71Bxe/2zlsGt9oWgpreyG9S5kzTkxt5Q3F1hfY1/HW4f1qX3UzCtPMni2KSFg7jnBWM6znpeaGYN43WhXJbFZZHghVBKweLD6RLW7fE+ps1W2ZE3g1TuR5TDJ867jtto+VQ2/F2jE6uyoVtUccXreY7LI/Aaedn/DpMmzXhaqBFQR1+g7SzKcVm7I0ntnIP0nZVu6Ad8NEbUPQ9KP0Ecx6/mB4Xa8gxdKeADS/R8ISU3I27RK32hS3GAHgGPZvJgoDuVs+Aem8Hpmd+EtETjrYtaMLwhfQ2JqTllXsD5snbNf04JiNlN1NjQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(52116002)(186003)(478600001)(6486002)(6666004)(86362001)(1076003)(6506007)(6512007)(107886003)(10290500003)(2616005)(38100700002)(316002)(82960400001)(82950400001)(83380400001)(66556008)(6636002)(66476007)(4326008)(66946007)(921005)(8676002)(8936002)(7416002)(5660300002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7gS22lS/czTBhKI1TvG/4V2M6iEoUkUWA0LXGGSGAho0STiz3EcoI+T3Pn9?=
 =?us-ascii?Q?ghr4OqyqG2A5I62jtPRG8rNXbryPrbQlBtFz6MHaHewGNhAXPkep65vR5C3X?=
 =?us-ascii?Q?YNlIZHZPy+J+4gwC7qcO3BXH0pXO2zd/muzyjixtxvxQCAK3+yFixi8dBkyQ?=
 =?us-ascii?Q?wxoB1duHr1Yv2PDW2L66y3nbtk86kJcYgtnrXR00ChhfYd1l9gActKZKZtni?=
 =?us-ascii?Q?dtjWJDrRcePOgWWebGug48GfBh2maRj6SwmSKWQ1tHqenIC+rFLWEGkZnG+M?=
 =?us-ascii?Q?DbBbgJTUXEXiOJisUK/JhEAi2EqzTV62XACc2RaNCEKFeQ5JIrIRedl899UB?=
 =?us-ascii?Q?joN6dZ05iF8fuvNItkagJXL+stwUfws6N0Tpin36wKC82FUKT4gxz0SWwJo+?=
 =?us-ascii?Q?0Yhg70ZP/Pv2nCQDLaFiOhDC7dBfS5R6E6f46HjztDC+pWWwnxMh6kKzCE19?=
 =?us-ascii?Q?6Hxhc8wsQCZGaTUKvYhqFjIdpMaLiG8Wvkva9IVTZi29TqKOMbyTW8QMkDkq?=
 =?us-ascii?Q?HWOwhGA0r8fqCbrYAy+N4EWrYBPwWrYmyCJxd2f1LVFq8EoT6vV6zDIWDbp/?=
 =?us-ascii?Q?foqSG819eYL5K1e9EDr+DrBHdnAO6V05ZkISyGAiipBkxSzWhaO7M9hjDYQq?=
 =?us-ascii?Q?XbGLJK4Jz2z6qnDhr4P3BbKFndYXWIqkoZhzsnqxDWg9LLSQZkvtA50KOfMy?=
 =?us-ascii?Q?yHmaw92cQP8J7NOHmVPwbBlP7TsD2xdwY7L5Hz4N6Aqj58pzq5/XkNv4lZFn?=
 =?us-ascii?Q?4Gwub55cTLqmPYTOwPn7/RyGKyeZUQ4aLiTQ4JRxK1rJmXlGQj7trLdoKvj/?=
 =?us-ascii?Q?FHWNH0K3QuiEt1KXt6XhStzy+jIYr42N4XixePkHw47t3ju5TsjfpK6Hd63B?=
 =?us-ascii?Q?ci5WcOfDFk9O/iudVgB8xAaKE6/EaZXTlz2lD6u15OqPi5+CRiSu1Mu4hB3i?=
 =?us-ascii?Q?snaq4fJKRUuC5ehgWAu53oWpptZQ4KpELij63hwftKgr8bOo7+4gGqTmrUTy?=
 =?us-ascii?Q?c4wK9TacxMYX6UlKgaWD4OAxx949GaFf2ujn7sJJ8sJt7UF2W34QnSaWRsRR?=
 =?us-ascii?Q?uCdX54H1uZDCGNVIT/I06AOY1ZChs501KE2QtYku4SM4q1rrpemJV2t9mLH+?=
 =?us-ascii?Q?+ml0dGQi0yLQCGu4LBuaQZE4ToavAnU3i7zIh7NtttyHuLk6u2r/TK3TuVwX?=
 =?us-ascii?Q?7ul9mIUFq7g4Gl3i/vXK9MeZLD/1ntzJD6P6rT+r6F4JVM8eDElYqel/U9GH?=
 =?us-ascii?Q?WJGJTAz3FN7zqo1L/YOEGRqpkfiyQZ44XjaOwSXP4bwAxoxwWBPGpyg1wZtH?=
 =?us-ascii?Q?gTnyiue+Vp+vDhbYB6LX9+E89ytXzLXDxeDlGHUXnn4LkTe3OSVK8DimGW5L?=
 =?us-ascii?Q?E0zdC/qRMeh4XsqacIVBVgn7xewNTBde95SCyu4nehbChWSTien+hrlfQXlC?=
 =?us-ascii?Q?Gd4NPb0+lsSx4f0llgTH6hiwEkqhZjn19V5cHlZc6yHH4ctZrmBHJijCxrc/?=
 =?us-ascii?Q?TB3X5JkFm19whoTUaiFkXoKe/Qqdao8ua7hYgVFuKiLo8FQ6oJbPMZ6GMc4s?=
 =?us-ascii?Q?BkhbjyPtuVJBtUQI5+m+WLOR+H2jGFgD+yKvVa8ixM24BNY9UIkzUfxlEFSY?=
 =?us-ascii?Q?7te5fiT7rfPON/cQc4TAKpFxWseEnjFc7w+kUOvNhGH4?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1399c80-6fdf-41e7-b408-08db71a5df57
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 15:49:03.5686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5x+DLxWb64xhvZ91o5FdZfAaP3LTXd76WDvP36ZsoVMwFQ79Xeh+0NdvRfgshWBgWqqRJC8ItarYZwLaIPASQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3585
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
 arch/x86/coco/tdx/tdx.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

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

Changes in v8:
  Rebased to tip.git's master branch.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 0c198ab73aa7..a313d5ab42f1 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
 #include <asm/insn.h>
@@ -752,6 +753,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return false;
 }
 
+static bool tdx_enc_status_changed_phys(phys_addr_t start, phys_addr_t end,
+					bool enc)
+{
+	if (!tdx_map_gpa(start, end, enc))
+		return false;
+
+	/* shared->private conversion requires memory to be accepted before use */
+	if (enc)
+		return tdx_accept_memory(start, end);
+
+	return true;
+}
+
 /*
  * Inform the VMM of the guest's intent for this physical page: shared with
  * the VMM or private to the guest.  The VMM is expected to change its mapping
@@ -759,15 +773,24 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
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
 
-	/* shared->private conversion requires memory to be accepted before use */
-	if (enc)
-		return tdx_accept_memory(start, end);
+	if (!is_vmalloc_addr((void *)start))
+		return tdx_enc_status_changed_phys(__pa(start), __pa(end), enc);
+
+	while (start < end) {
+		phys_addr_t start_pa = slow_virt_to_phys((void *)start);
+		phys_addr_t end_pa = start_pa + PAGE_SIZE;
+
+		if (!tdx_enc_status_changed_phys(start_pa, end_pa, enc))
+			return false;
+
+		start += PAGE_SIZE;
+	}
 
 	return true;
 }
-- 
2.25.1

