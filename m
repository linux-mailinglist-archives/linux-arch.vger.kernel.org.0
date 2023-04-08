Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791806DBD04
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjDHUtf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjDHUtc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:32 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021023.outbound.protection.outlook.com [52.101.62.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD0A7D99;
        Sat,  8 Apr 2023 13:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1xb/IAg+hSeKJvClpdae0VNMj9nVUQF3YDuc9FjI4M55wM5H+gs9+uOFw/TqNZf1qi5TrGcJ1OtDk/2zscP6BWQfLOlBf7rolmcT+zm7XyYQrA4Q/clfzXC8C0/PCjNt7IqlGOU7LXjXZSxTedvtWl+W3xVF4U6H44q4HV9jG/vNGlPC1yDFuvt0sARNm8sDsb2SaJ8fDnpWKpBoBP91TBMGgpuY+dVGIDLVFMVVk3JZ0m1lwcDpT5DBvch9NNg5DlHAXgx2VsvfFKVq4+OYpO0my2u+0PF7YTY/ZsuVxn+hGRUYOXrdWeLoK5FcX4UiNYjvn5G1ZsEEsvswQrZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVT2/XfvDLOONNRRbqQoXdnfe4kGHRiB3XwG8KFuzRw=;
 b=ixMjwbbcCThTxvFmNWQw3LnNgaER440+waHnaCrvMQB4dWQjB7tEiI4YFvAA0+EPMG7gJLhPafabkFUTP95sYXBMRfB0MeBhUEFDJ+nqt2B5zk37nvRNVWeCYaVaO3JIKK8ApOf7xwwNKCiShgCqiRzxqwaglmYIfTygm3FBsN4X2WQmnenMobO5LPxYuHol+xYZ0AyC+3uf4HNc1WY7jW75JJ21Ar0xHYzj46RgBL+H8+6ytV0pC9voCdEtYMxJAHx5+iLov/c5V98ywsLnCpsJb9+tch+kC5ww+S/exjnk0OUqhZVVncm66LzYGR9VpVlxt3fUZpG5sGFCjT1MPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVT2/XfvDLOONNRRbqQoXdnfe4kGHRiB3XwG8KFuzRw=;
 b=DGczYj6XRQnenxuTX5pvyWdb9etxFvbY1nV4lsZwydchh0A04N2c1eE0/MHu0/TWFpQaH8v1OCqD5Hw3yJ0UQsBe0AwmpyWbH8AQ962oUzTvcDhSUBOq8z72p5JhALhcchUtG3daNgcffPVuRou5QSmYLg/i4sfNz8Ki/VLZl64=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:29 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:29 +0000
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
Subject: [PATCH v4 2/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Sat,  8 Apr 2023 13:47:55 -0700
Message-Id: <20230408204759.14902-3-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: b4a7e90e-5a5b-40db-1ccb-08db3872bf74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QeQB5t8UhgsHBREUSi62NOrBAra7aqz8Yomn3kf5l6qHDtIuqJ6HuHK1x3SNXhfKcw0ewrAI4lggDS0RD5UYnkqbKpgN7S4AFF0wAbWYfBd1Nbc2JR8nOXApYJCV6bV9+tguEV/iQ9dsVBd9gFGx8bNy8T9yzAYOC7BwfwAWLBMV3sKNKKxiThdCTFddo1pwjifbbmi11cXBYrO+OBlys9jlRtbExLM10nk2uQG/AsVe8u+KQRRcwUMR8U7xI+9GOj73tjhjIkPrEWFfJruza/APOkqE4zADnv3jfuX3BeF7fWniDMeI/e29bcbOj429le8xKt/qkzYWibp369aGxLVMHI85U0NyoMIeU69QDABM0wSb90DLHb1e7h2jdEyxVCq5Z6dklWce0tD06pC2E3q+0V18IYbrrLXDZ0gjrKFE72MPXLNVMyzc8wQi/yDWEFi6ucQz8d9P6fYab8Tlo5czcM3gyUbqrEhpGHLf9WxdX2uX9BNvi5eMYAXT4flBFrvxDQNDJW/56eD+98J99RwvZE6d7C9Vlt4piHodkVgVpHOrVtwi2FlmC+Z6zGIx/o6I1rCNXUZwqUsZexoKCzORU2YMCtrAF90GZ8dMwcyrFIegIRejEvPtGQW///wmtRkpwplvxFljd3EY8bauKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uDrLcmSmaVB8rEWl+TJk2FAsLplsaWG19iAO2F4KL7PzYZwo1SkbAM+crRWE?=
 =?us-ascii?Q?KTScjGAWXU+Hkg1Xm+bQUCOroW2/UwCRFnEsUyaXP7+UidVnPy7OhipYTpN5?=
 =?us-ascii?Q?ZWblAsrRI9eoFIU9QIZ4CluC/Yh8H7mnzshFAGbgFfPBOEgW5YlwOtvgQaBP?=
 =?us-ascii?Q?vUs/ejp7CLQiLpUwzuUT8HRR++YzfD3Ql0CEsXtj9cjeQE1FH6wRlXWpY0ug?=
 =?us-ascii?Q?HUjKDBSb2085FRBaxa+UdB2zFUOGXCn+qDpt1puMo9R3od1c//sQLtjpRR6p?=
 =?us-ascii?Q?m2YNDqreETO8WDSIBDRLjVsZTUUNBNQChnf0sS2fhYbzfHx3rtsENwgrdVLx?=
 =?us-ascii?Q?NXkJs5UJIJXozcM91MXc1jxCo6+isW29HfaEGvhtGTQwlHytAf63htsdE0xP?=
 =?us-ascii?Q?ANDpQ/I0O7L8+hEGGTsV3+Ahf0lV6YL7sH//HCH+0ohqTgEsmY26F1fWyuaJ?=
 =?us-ascii?Q?IPFQ2r8PKMg23mYC2wC2Ih/BEyKnblf0jhPQOANeIEwGJ7p/v7rUBSz9ZtlU?=
 =?us-ascii?Q?DS39dR95r/Fl3QtJjYozAAyvi/i4tgWhAnzQE5ghbPyl+tiJi8HhAIh/GwYJ?=
 =?us-ascii?Q?d7N8TVzElbkENZj4ZqKaWDia2EAvV/e7yJU3p+nWqiE6fHNKOsE5piuSxfP4?=
 =?us-ascii?Q?NChTKg+ypSbFPY4LjP6X6Ny2SLbrCftporyQ2XlFWyf8nX5FbTgc9F8Cza9K?=
 =?us-ascii?Q?gYazTUe2Va9ED5+rWWDg/lih/6QUBQ8mS4BBHy+LbqNMEzKSv3ocK9qNf4uc?=
 =?us-ascii?Q?GJv3pQFdoTAhR8i3yw8JDuLNFFDqjpejEamZz914ICRGqd740a9i9L0bg+Xt?=
 =?us-ascii?Q?WaJNBxhP5iO7mql0PNaVe9xCa3tSQIhZuiYsXuiOCklbqVleXhXukFGuWGlK?=
 =?us-ascii?Q?Sw1NlULH9/HP5fuVX1kOCwQpMTQLMcHFhOxuFfH8MSDMZQvDAx/+urVXn42G?=
 =?us-ascii?Q?8F0f/nsv11dQiFGXeei6judKdDmcr+K1cEswXbpU642J7eZKDIoF8L6PqX6N?=
 =?us-ascii?Q?W7FlmNiNjlWp8mtsdPpYkrsZrcLxkVTr6SktEVTLDAjsIlA/yrhkPT0/z3Sc?=
 =?us-ascii?Q?31bRfHbCSD/bOkUTjLh6S/tctzXurAUSnUtn2tQIC0qkk2AAKQ8S61BYynLe?=
 =?us-ascii?Q?rkmmNwohu+9MFSSwbN0uXD+Sizs3gkO68rf/j3jEsI8l41A08Sq1DUiV4ndt?=
 =?us-ascii?Q?0bzo3yJCZqEIYnIWHWh8+WMWoG/cfMS20KBCfimOcph8RIQ2cKaUrzihMEY3?=
 =?us-ascii?Q?pUkyVOvjf8QilvzJWMKQCRuv8jBE9CC1MsHFGw9HAS2er/e8Aaz51rESl8E+?=
 =?us-ascii?Q?3gSubHGLZ8Bms/QxO9SLeu5QuTKzruhU/MJHgCtLEnDOhxthloJETQjq4hLA?=
 =?us-ascii?Q?r6/Fuokot74LmJaoWVoQTwSlJC6NpTnT1swuJtO4meLmPHuL/shJ/K0QGE9e?=
 =?us-ascii?Q?jVGc8BzgMpruvqDWxh5JLp8hAqQP/up89P4N+rTBko4J0abek42l+BZulpHu?=
 =?us-ascii?Q?O/PbCbgLoUg7qpj0uh3lcV2tGHtptCLlj8pIeKITrPwrKH185SiU8HEDGAuy?=
 =?us-ascii?Q?HoJ/2mpFELm3niIjdkQyPwYudTRWdTowapHyne84MlWgYEldzdb5hJ6whzgo?=
 =?us-ascii?Q?zCrECahNlpnvo6J/I7z6a/dae8qq/6rn4wjTXFuF2GvM?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7e90e-5a5b-40db-1ccb-08db3872bf74
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:29.4714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v7QuuG7d4bMcSANPvQHEyHHvdQqQ+ENwOxNucHodB7O4KWZW0RzALqp3zff2vV26uPxTZk0vQhsvjQV/AIatyg==
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

When a TDX guest runs on Hyper-V, the hv_netvsc driver's netvsc_init_buf()
allocates buffers using vzalloc(), and needs to share the buffers with the
host OS by calling set_memory_decrypted(), which is not working for
vmalloc() yet. Add the support by handling the pages one by one.

Co-developed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/coco/tdx/tdx.c | 76 ++++++++++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 24 deletions(-)

Changes in v2:
  Changed tdx_enc_status_changed() in place.

Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
how to get the underlying huge page info (if huge page is in use) and
try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
underlying page allocation info is internal to the mm code, and there
is no mm API to for me get the info in tdx_enc_status_changed().

Changes in v3:
  No change since v2.

Changes in v4:
  Added Kirill's Co-developed-by since Kirill helped to improve the
    code by adding tdx_enc_status_changed_phys().

  Thanks Kirill for the clarification on load_unaligned_zeropad()!

  The vzalloc() usage in drivers/net/hyperv/netvsc.c: netvsc_init_buf()
    remains the same. It may not worth it to "allocate a vmalloc region,
    allocate pages manually", because we have to consider the worst case
    where the system is sufferiing from severe memory fragmentation and
    we can only allocate multiple single pages. We may not want to
    complicate the code in netvsc_init_buf(). We'll support NIC SR-IOV
    for TDX VMs on Hyper-V, so the netvsc send/recv buffers won't be
    used when the VF NIC is up.

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 5574c91541a2d..731be50b3d093 100644
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
@@ -789,6 +790,34 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -838,6 +867,19 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
 	return !ret;
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
@@ -845,37 +887,23 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
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

