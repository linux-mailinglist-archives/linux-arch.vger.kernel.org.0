Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6490645069
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:35:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiLGAfU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiLGAev (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:34:51 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022019.outbound.protection.outlook.com [52.101.63.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B48A44B;
        Tue,  6 Dec 2022 16:34:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LRrKMwbq17pes8Dq0kHYpw/FpnJAbj1HreQfjtBT3w1DskxqEA1SotiBG7GV+6qxL13CyDSgFQuWZZkfiRvaQSGnekbAN2J60Slqy7fOZe6f5hVnJgQq0oIsFC6G/91fw5Gr4g8WGm6oBEoNwtaVRW7A+8t3mC96Jbt+ikLaZDtn455mRYQBr2JyS5NoJ4Qv+vucWI69gO3h2aK2+ANxdkf01jUOCAnbYK6nrkSzD4uiMEQumQNOTkylvGGGNrQqspFcUA5PwbkdkXIAZOpsdzT3adUQXZ4ehpjemmoV6yzH9vV2v3pqJ9g5oSvu1cUdG/qLg0hZMHk14yUFYUotpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zDue8PCiTOkMr2a1ym+6XeSAT80kB0o/W8Hf3Yc+c/c=;
 b=V4QM4c+gpHAoYWUNyzcxP/+ceqynQ57r3XHr9RRzZ9BAP60PejfKCZ2hSe0ZNSlhg/XzHSFIjWocHNYCNZ1+WxRfKCTWVCjkZ5LNUp6zLxX5zVIvn9U24oW+ZSS3B3Gt0RBLRCta4NsdouUsbEJ7gGHoFqNqytRQEuUwV56xESL+ozgA7l+NcLvM6uAALqO9cAv57PsAR1PCsH+T/OGeXyh9B07dq8TfqPfcuHOam194mUAU5Jq2hZ2HM1bsN6Qr0IWDDxo6B3LHDc21cLM9Kd6MXOgPubNmHixkDXK0+OBVAiHRK165x000/vWbpiBf7rF4bleXi9Cdj1uoqg1xGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zDue8PCiTOkMr2a1ym+6XeSAT80kB0o/W8Hf3Yc+c/c=;
 b=A4HcRDDd+Z4+wqerRNsKicAbbdQJ1FiAH5fQguWm6nIvhg/8FkuS6TOONgBrgLnJUjyIEeM3p/h5nqq8AT7zUDaMYVcS4T0tQA4Giv9n2l5Vyjb93AMLc9sPi91Jd5ka/+o9Gv/hD7kvbvJY+xKkXEd0I8zvT6CGyD9GhmqxzR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:45 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:45 +0000
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
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v2 2/6] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Date:   Tue,  6 Dec 2022 16:33:21 -0800
Message-Id: <20221207003325.21503-3-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221207003325.21503-1-decui@microsoft.com>
References: <20221207003325.21503-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0001.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::6) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|CY8PR21MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ef96a8-edce-477c-1be6-08dad7ead6cf
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPYTkyCRK6DWyKelBHTQ0JH73J+A0ZpjU7FbxKJhf3ApWPoErUzbb5RG6PcRRDsiAkgtaDj5RcqOoaYPU53JCSCwtOD/4UpEA2BP7jls26wdziBKAajkNmLWxjLVzP2UVbxEuCogVMak2F6qgN2U2Zxa8/zfH4+s0cJFwqx5mLPBFcL2DMox4YX55ungTGhcltL7plyU0zALbvDvn/dksxL4QBdc39QxGskZI9cK5cRw/lPoMa+cCUnOkxWy8LTZ4QcI/OgR7TqPIhtsxZIKrmji+y0lloYDufVUV7QRtJn+SAqSkTsPaQpo7UPVttBGkwhffo3Fn0TzDnUEt8G7o3V+LdtrWih15ql6hW9+6XwcJMn8ZtL9wStUHgq3MzLwy+DU6DfO6XYt88MODxWN6lv+oc/2t1h3OtLWYTcnMK/opg0DVIwL2MvSOpXm++2p7TeqAo2WCQIgAA3oi3Wc0HTts0vJWpBVHg4967JxbQ783QzG2qDd4RT4tKXfE1kH0nDt5tdWhO98W5ZbTw7rgSQnrzUaf91El0BH1kzXOshpkhUCOCUt5cvCvB9u39Yq9oZTW1RUveuAt5HiWOSOH0/+L/7mC7V/1Gh2jk8+XsSawUJWLKrh7wOGHfwS/CPtEa+kBEAMcS/1jCvyM/nuKG4+4M1F5ClR4hiWU1ROG8TLp1NV0rluh9AdyvRxcWw+AmlkV9YWgV8mZ4kaCnu7wvUVWDoqaF1bNV2vfL6x4hk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(107886003)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0QpJDUbjUSeFLRXitrJlplCcjXoaPiHZNw0yA2RHq04G+hjYs6D1FK9BbhrP?=
 =?us-ascii?Q?ofcHta7A5oys5ZHRFVzUtyHyBTdZPoBvgJ8/qn6n8oQhh2wRayysFua0Ii16?=
 =?us-ascii?Q?8K/fJx722v1wu0yE+lE8WTDEQCSBqo6vgSwyjEu6BZXM0ZJIo7XzBj391QjV?=
 =?us-ascii?Q?KK5PfqiU8nXg1peLgwtTfiiGpSW672arwPMajiPei4B3PVV/SzeUVimzn/xj?=
 =?us-ascii?Q?xLZuiOZDvpkdbliUBUX8TU4fEvUCna6GDun+qzls54hpvDVMTBEJmn1vL3k2?=
 =?us-ascii?Q?CZl6inHVXfw09TDfPAkqE+W0kVEeQQ4RzQ4GY2i+mgrAQtLIEFdI5ghTwW/d?=
 =?us-ascii?Q?mSubQCD4G5on7XtP38vHGCC7YGUQERVl1awqqyCr8DOQrtzKr6PfGsuwh++H?=
 =?us-ascii?Q?wL/x/E7uhegdlRAPnRlky01jVuV6XVIrj6JAhbvUkcSxU1ySzGnj/M0YhtdB?=
 =?us-ascii?Q?RhOpdIo/T015k0CDbhScn+yIojZeVPGG0oOi0Z47qOQmaxvPzRHEZ1McQM/b?=
 =?us-ascii?Q?72IPadyudvcoAJbSIAbkg6M0tY1wXlfIgg30iqinYYzkEVDLcBQhL9SFrxej?=
 =?us-ascii?Q?VQriSrIpsfMAiJl8MVrSZxeWTHDcla99W9KZL0AAZLkiGztLUGACLOD8ZeiB?=
 =?us-ascii?Q?zlEoqAEElNSLw9XMnWquNSzv24Apy3tqaS8y/I7aX5t3z6uqdFs/zyCfpDu7?=
 =?us-ascii?Q?/7U2YpR/ueKdQWdNPHpv4WpR3Nf4JyDwUZZcDmMpgk1sj+GAWsUFe9uWc1dP?=
 =?us-ascii?Q?92BN9P6FJ9vB37mpPMihnzTKgeMppi1zkdyGVENBCBf7D/Sksjc4BOnIPMQE?=
 =?us-ascii?Q?OtJFfu8FuDAsY21KYc/8d4KtuSoAa06WVEf/7mgNHRC9u/rlrFwTNfzKL6iA?=
 =?us-ascii?Q?MDbu1rkrrgwCXpsQacq2RJ+AXSY8uCRmaQK8dfudSvngAfOiisX+WlpW81cM?=
 =?us-ascii?Q?0qwL8ElHvEuiaANqF4JhivINAoqDiT8widyO8ISn4bwXBDtEyx0bL1/RsfgQ?=
 =?us-ascii?Q?f7IfgQ8VUI9wr1NmkhATYLJ743mz7gLUjKJ3UnfaOBICXolJvEc0o3thqYgV?=
 =?us-ascii?Q?QZfoiGIeRmq/SJlQwq62zDC6roqi2zvA4+94eiy5MfnAYg9xKehL1EOMKwDp?=
 =?us-ascii?Q?B8LQE2L80dyhKDV9Jj5CG2xt909Kn6cqBzqnIksmZYnn0kBrN9GhQGAhpQw3?=
 =?us-ascii?Q?Wyrk2Wc3klxU2vSzAFn66JKxTNCrSJvboeA3vJuwpIdxBWSNI5007ZmpmTRV?=
 =?us-ascii?Q?YqvIJYfrHc6hDkkcmR6gwOdkmjlJ6amA6Z9jKFrMNgnIZgzVhGQ/Ecad3RTO?=
 =?us-ascii?Q?uoj4bHu8ojZYzCgJGthFFqzD5GOE/LCMzMUT0EY39lob2apWsdDeMP+kfiAn?=
 =?us-ascii?Q?7/BZBAI9FMkp18AgefL5at3uDKDdvuYu+XaQL9hVbaMKEbGxxrMsWw8zgxnQ?=
 =?us-ascii?Q?PWLycZFDd1srYhnCA7NTspRsF7vaXO65UHWM08CJODkafbZGeuYra+ibuIHi?=
 =?us-ascii?Q?6/IK3wdb6bcuftjGSoq6DJJxaWSvo5bHBT/z2CKtL8Y9Y/vv1GlfNQAI3ugX?=
 =?us-ascii?Q?P98wcu8u2SYKOjkmbWNpofZCOJI2EJcJ4I5puD87a/JIYw4XGySGo/q1AoD9?=
 =?us-ascii?Q?1XmLyA4M4G8FeIr5TEwRdz8cv/LmMLC6zNvMWBViJ1La?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ef96a8-edce-477c-1be6-08dad7ead6cf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:45.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ho/Brkh9UFBoN/HoAajaGPxbe9ZE8+uvrV8ijnQXX9RNWpT7Ml7SAj60dUmDeuOz03n8CVwJjKWb2dBqLAa6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3819
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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

Changes in v2:
  Changed tdx_enc_status_changed() in place.
  
Hi, Dave, I checked the huge vmalloc mapping code, but still don't know
how to get the underlying huge page info (if huge page is in use) and
try to use PG_LEVEL_2M/1G in try_accept_page() for vmalloc: I checked
is_vm_area_hugepages() and  __vfree() -> __vunmap(), and I think the
underlying page allocation info is internal to the mm code, and there
is no mm API to for me get the info in tdx_enc_status_changed().

Hi, Kirill, the load_unaligned_zeropad() issue is not addressed in
this patch. The issue looks like a generic issue that also happens to
AMD SNP vTOM mode and C-bit mode. Will need to figure out how to
address the issue. If we decide to adjust direct mapping to have the
shared bit set, it lools like we need to do the below for each
'start_va' vmalloc page:
  pa = slow_virt_to_phys(start_va);
  set_memory_decrypted(phys_to_virt(pa), 1); -- this line calls
tdx_enc_status_changed() the second time for the page, which is bad.
It looks like we need to find a way to reuse the cpa_flush() related
code in __set_memory_enc_pgtable() and make sure we call
tdx_enc_status_changed() only once for a vmalloc page?

  
 arch/x86/coco/tdx/tdx.c | 69 ++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index cdeda698d308..795ac56f06b8 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -5,6 +5,7 @@
 #define pr_fmt(fmt)     "tdx: " fmt
 
 #include <linux/cpufeature.h>
+#include <linux/mm.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -693,6 +694,34 @@ static bool try_accept_one(phys_addr_t *start, unsigned long len,
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
@@ -749,37 +778,27 @@ static bool tdx_map_gpa(phys_addr_t start, phys_addr_t end, bool enc)
  */
 static bool tdx_enc_status_changed(unsigned long vaddr, int numpages, bool enc)
 {
-	phys_addr_t start = __pa(vaddr);
-	phys_addr_t end   = __pa(vaddr + numpages * PAGE_SIZE);
+	bool is_vmalloc = is_vmalloc_addr((void *)vaddr);
+	unsigned long len = numpages * PAGE_SIZE;
+	void *start_va = (void *)vaddr, *end_va = start_va + len;
+	phys_addr_t start_pa, end_pa;
 
-	if (!tdx_map_gpa(start, end, enc))
+	if (offset_in_page(start_va) != 0)
 		return false;
 
-	/* private->shared conversion  requires only MapGPA call */
-	if (!enc)
-		return true;
-
-	/*
-	 * For shared->private conversion, accept the page using
-	 * TDX_ACCEPT_PAGE TDX module call.
-	 */
-	while (start < end) {
-		unsigned long len = end - start;
-
-		/*
-		 * Try larger accepts first. It gives chance to VMM to keep
-		 * 1G/2M SEPT entries where possible and speeds up process by
-		 * cutting number of hypercalls (if successful).
-		 */
-
-		if (try_accept_one(&start, len, PG_LEVEL_1G))
-			continue;
+	while (start_va < end_va) {
+		start_pa = is_vmalloc ? slow_virt_to_phys(start_va) :
+					__pa(start_va);
+		end_pa = start_pa + (is_vmalloc ? PAGE_SIZE : len);
 
-		if (try_accept_one(&start, len, PG_LEVEL_2M))
-			continue;
+		if (!tdx_map_gpa(start_pa, end_pa, enc))
+			return false;
 
-		if (!try_accept_one(&start, len, PG_LEVEL_4K))
+		/* private->shared conversion requires only MapGPA call */
+		if (enc && !try_accept_page(start_pa, end_pa))
 			return false;
+
+		start_va += is_vmalloc ? PAGE_SIZE : len;
 	}
 
 	return true;
-- 
2.25.1

