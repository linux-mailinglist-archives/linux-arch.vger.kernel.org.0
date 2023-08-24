Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D488C7869A4
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjHXIJ6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbjHXIJy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:09:54 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020019.outbound.protection.outlook.com [52.101.61.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B919B4;
        Thu, 24 Aug 2023 01:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVYrxRefmJZozrH7k77l+o8ObLzlFO/OVysvc2rITpeiqxAkKUcd1kWUyeScg/eezfBgJki4lV3D1y2bdlSgkAWSYeIHG3TX9NaDdByGKllRRH4K8PDK6dSemT5tqRXTlkrTUUrWkPxfADZ33Jo59XtoOfEetplm8WaKTLYKYXUUMa4mvQ2vC/kMxwfv6mJz0BNmZPtDq/pmImXdtiMyvSudXcHnkh+fncff41nX0vV+r66mPdiIOR2AYH1V9CbP7BL5bTWaaXFlfF0hy20Y4/Qx5IxcvGiGRz8iVQ0r6NYwOCp/mEv26Ro4L8RerPx8yaQ5bhig7woOrSn61WoYGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNnCWruRzaVzMVsHevd9qI5PkSxJpdgik0ZgJNbUbt8=;
 b=VQivQCGx74AO/KELMsvsDPOY75IAAjMoBvCwqQWZJIK5DU3JJFDN3HRjd+aE0Ufs9+yn4MBJ+l7HAuAjWnzRLj93uVJpcqL4TfLdn2GZ9T/peY7eh6slSOr+G4daAcj/7lIHa9HQQtbZJmLTS8ps4js3mlOssIA44smDV7GvSd/9cuafzCOk5qKEJmH554kw21mxzon+4nAifQmYnspuZdS4D1Csv6j83QsMPNLMiibTIUNxJ5NNAL8LDURavXYd3P78tTo3pByyoXBx5vPMauhIfRqBfyaWczb5EW1owIQXeL3AbZ8SYn+fuj/iElb49ScgXoL0D5foHG7u9e7KKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNnCWruRzaVzMVsHevd9qI5PkSxJpdgik0ZgJNbUbt8=;
 b=X8PgTiXiGd4VpFcBEFCWSpUwtZ9qKoLUQU2aQNDy4ZsDky1nCx80m6Z2dFlAvzJqp1tG6lnfrhlpd2vlCXEBQCZLcjR5zL1ybKezYwkh3WPeQ0huPKXcENm0i+0x+3EE5RLt0923XxUIxQ7m1AO7mxxlq39e5VKcIxhko4WRq/U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:07:54 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:07:54 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     ak@linux.intel.com, arnd@arndb.de, bp@alien8.de,
        brijesh.singh@amd.com, dan.j.williams@intel.com,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        haiyangz@microsoft.com, hpa@zytor.com, jane.chu@oracle.com,
        kirill.shutemov@linux.intel.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, rostedt@goodmis.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, seanjc@google.com,
        tglx@linutronix.de, tony.luck@intel.com, wei.liu@kernel.org,
        Jason@zx2c4.com, nik.borisov@suse.com, mikelley@microsoft.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Tianyu.Lan@microsoft.com,
        rick.p.edgecombe@intel.com, andavis@redhat.com, mheslin@redhat.com,
        vkuznets@redhat.com, xiaoyao.li@intel.com,
        Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v3 01/10] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Thu, 24 Aug 2023 01:07:03 -0700
Message-Id: <20230824080712.30327-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
References: <20230824080712.30327-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: b853fe43-fd60-46c3-7077-08dba4793833
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMUYeegFSFKKuokF/6XUpczy5VLus+6u5zv5nWteesFxdmeYJcvnxvgobLRF+hts8CzT4zLFJA/NYaPv5q/0wTJ5lsSlc8GjIAAh7F6aEbO6OQr6e8BoXQ30WWc+L0Swdm2sn7ON6SHTTC9BYOBGQJMNbUDxHpkBfIJemsPERtenwSv8azxmYzh+PwS5+wzVlOi7iCG9ybGwiDMEOzw/4NJtCKYjzpT5OLc0GxhFh6di/I+RScQznmnm2Omwiujm/BLHGbR/SEUq8vPyhN+fOqP7n8ZmPk3Glch0DhK8w8O6ponYcd+D9GR85H4yqlQKtRK7haJM/LSccEqUCE8BnPgBvgGhszQARSUlep/ukNEumEZV26XubOjbkupjy8lYySHETtFwXox7vk/DbVS9p7+sS2smdb+gcI6qpvB+oEA6FQ5lrFsQeWZ8elUtEX3/jvQuIG5bvew+N/pzELgO3LixDTytPVu21m+gs7lyplZQZtYaAvf30X4/mybgOgHydqqTq4OCO3jyUUXAg/OdMuaoBLXlfEUL2Pp25BpYsTbNUis3EP1++qSw1587bKGK4KElfhz9nVkOW2W/m6c2GNSv6PqzK3+JGJDDoQvfpavhTfKjEQB8Lb7+4klK4ahWJYA33gtWMweibgeqm7II+BLniivgWpssmWtyaQR3tfSSjV65jQPlcGa16+WdkvkD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(6666004)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UhB5yoM3OfhLEv49I5KIY3EskLiBRWaC3W7U6kQ9cxDyDF60Aw2UvJQJ5PdD?=
 =?us-ascii?Q?Qb0UA31pbgLo7OioOT/loZ2KaS5u/HrRqgBeD3G6AgFjHvq04oIdQ588BecC?=
 =?us-ascii?Q?uPzppzOzLhh0IT5ccV98VL7SPr7R1yDFFVAgWMELJD46bBCN/umpXCEa2qq4?=
 =?us-ascii?Q?Q1NnlI9Kz5lTcs5DGWQKqEoQKIHBXkHa+p5eNPGUE484aQjzH3Bo08l/Q12+?=
 =?us-ascii?Q?ATR5fhAMCZzOHX9jPa+t+2fUxxvnmSpGhj7aZScxOjz4YKiH1QBpGjtHZQGg?=
 =?us-ascii?Q?38ZjpmRn25xAxkIeFfVtXYXmvwpTM5LuU0f8PPg8FlgGBXnhBhHg7gyTZYWT?=
 =?us-ascii?Q?IkLo2mnXw+l3i4bel4MJ03EE6zx2hZU7ca0hiZbfx7e2X6v1gB2+jTldwFhi?=
 =?us-ascii?Q?3RI42tH9mqv9elOPxNm25iOAuL7W4WFDRWhMKh6Z6BlaUaF1AdQPVpvRGIDL?=
 =?us-ascii?Q?9NsIztMrcWZSD09tBXBhoYNQP2mBy9N2XqHfIk8hDt+EpSe8nAHPYTUrdI89?=
 =?us-ascii?Q?4HaQ+mU62/sgAwwCZNMRSISIrzgc2BL2gjJdMcv6dDUIENaiQjlU5qk2KhyU?=
 =?us-ascii?Q?NQabc12n5t/LPSmyz+xl2DJP9RN5IKog4HQzrAtyo5wbJ7wczKSzFk3k20BK?=
 =?us-ascii?Q?9y7pFbtgolgi5K/tpQxH7Y7ZAG9qXAYzcAFItMWxrL2WpmcpYDmDI/m29yda?=
 =?us-ascii?Q?hSE3oEySfn/tIt1VhhmPZkPhrpgLvIBK/k+0ML+vKUbfTBJDEcYCEJ7534s9?=
 =?us-ascii?Q?OZrgyxfWiWsfM7e7hd31i4yAwjMnWas3xOsW/q6TERivwA/LBRpoiUOx2wbk?=
 =?us-ascii?Q?P09Y1NQiv4p63MD8E9ItM8PDuu6NL6v3qXdBEmJp7tZf0Brc+Q43JA1eHNgv?=
 =?us-ascii?Q?yPQsBxGqlHaXCdOr+A5qx2SNMbVoqgLhcWz74OIxqThzh6wBXnDEiG2T9Miw?=
 =?us-ascii?Q?QWeOKC9392pCMFH03bwnBb96/45YpyjC3BYUO2RhWRMZ0Qc0boPz34uCaY5m?=
 =?us-ascii?Q?0lkeEiskU1g6gpMklz7/taLF4jAsgeuQX7UrS0zwhHcpw9j+BVgtUCmRa/oy?=
 =?us-ascii?Q?eQoHMz4+PV2ma6AiWUgSSGoXOLYxLGT22nMVztMUYcVMDWdZpsbj/3eOm/jg?=
 =?us-ascii?Q?INInOY1pbuSla3IwjUpgw0aG6QRrCVhmP3sqt/v8VqNrYkU+zMoWviMmWGY7?=
 =?us-ascii?Q?afBomg7i3Wp2ltGrPPjLC19101ldG4IGbFB9hKmYy5329VtCMtXK9qXTkLZ1?=
 =?us-ascii?Q?mPR30JTLzTY3U4aEiO5Bef/+IWNwBczP5639W7ZZbanJKWoqUaWKAO9fYxsN?=
 =?us-ascii?Q?XIDVmHXI2fJponCxCfKbPUkRyseLf9wD94YSfQ++Nt3husyOEulX1c6czfmi?=
 =?us-ascii?Q?jZjst1RN7KMG4Xm4Aoq10qx52M3OhH6GjvZGLl+5sTb2CvkdL6Emdzx6y/k0?=
 =?us-ascii?Q?6SFrdxONcmAQhNKRZY8+p/JLrhST/692miGUpneZHL9Ffe9W/bUjouKf1vhQ?=
 =?us-ascii?Q?hTSK49mhXVwCF0jvxwJSUvQ0uibDtN5XmAordfbj5QihhJyViwUuYB5TOEjs?=
 =?us-ascii?Q?kiGcHSmxpEgNGal9VD80MxEpVaFImyhGhJOnEliEiwW0eLgCONNZWxLwRRDK?=
 =?us-ascii?Q?vb6eostmjcOwqA0TLd5nDOZRfxCNxybFrOpJVxKTy0rk?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b853fe43-fd60-46c3-7077-08dba4793833
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:07:54.6826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YyS563LN4h41YPtf/Ia+cTYsyAwzanLeXWtAYEHN/x8gtTglhG3/NBU4Fuza+/VGj0QxCu5JPmka1/TaCxK+sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

No logic change to SNP/VBS guests.

hv_isolation_type_tdx() will be used to instruct a TDX guest on Hyper-V to
do some TDX-specific operations, e.g. for a fully enlightened TDX guest
(i.e. without the paravisor), hv_do_hypercall() should use
__tdx_hypercall() and such a guest on Hyper-V should handle the Hyper-V
Event/Message/Monitor pages specially.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Added Tianyu's Reviewed-by.

Changes in v3: None.

 arch/x86/hyperv/ivm.c              | 9 +++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 ++
 drivers/hv/hv_common.c             | 6 ++++++
 include/asm-generic/mshyperv.h     | 1 +
 6 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cbbd3af4c3da..afdae1a8a117 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -562,3 +562,12 @@ bool hv_isolation_type_en_snp(void)
 	return static_branch_unlikely(&isolation_type_en_snp);
 }
 
+DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
+/*
+ * hv_isolation_type_tdx - Check if the system runs in an Intel TDX based
+ * isolated VM.
+ */
+bool hv_isolation_type_tdx(void)
+{
+	return static_branch_unlikely(&isolation_type_tdx);
+}
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 4bf0b315b0ce..2ff26f53cd62 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -169,7 +169,8 @@
 enum hv_isolation_type {
 	HV_ISOLATION_TYPE_NONE	= 0,
 	HV_ISOLATION_TYPE_VBS	= 1,
-	HV_ISOLATION_TYPE_SNP	= 2
+	HV_ISOLATION_TYPE_SNP	= 2,
+	HV_ISOLATION_TYPE_TDX	= 3
 };
 
 /* Hyper-V specific model specific registers (MSRs) */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index b6be267ff3d0..3feb4e36851e 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,6 +27,7 @@ union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
 DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -49,6 +50,8 @@ extern u64 hv_current_partition_id;
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
 extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_tdx(void);
+
 /*
  * DEFAULT INIT GPAT and SEGMENT LIMIT value in struct VMSA
  * to start AP in enlightened SEV guest.
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c8d3ca2b0e0e..63093870ec33 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -418,6 +418,8 @@ static void __init ms_hyperv_init_platform(void)
 				static_branch_enable(&isolation_type_snp);
 			else
 				static_branch_enable(&isolation_type_en_snp);
+		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
+			static_branch_enable(&isolation_type_tdx);
 		}
 	}
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2d43ba2bc925..da3307533f4d 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -521,6 +521,12 @@ bool __weak hv_isolation_type_en_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_en_snp);
 
+bool __weak hv_isolation_type_tdx(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index efd0d2aedad3..82eba2d5fc4c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -66,6 +66,7 @@ extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
 extern bool hv_isolation_type_en_snp(void);
+bool hv_isolation_type_tdx(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

