Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738E0779A93
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjHKWTo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjHKWTl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:41 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23458171D;
        Fri, 11 Aug 2023 15:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTrG+BrUJOE1WkX+G7x69/H1HN7IIJsJXegznZdCXXZ+Tuk/3bMvH+rt28LmMgb2UfgHo6vtc4w0QN68JuAzB+AGTcqOAwPoXceqcw0v9+HAfR8w8Nfj2t7AC1kYE8/ih/MeDPIhKEM+uJ2rIx8XqfKRX+K8G0+G/Rk8g6PuhL1QDCn/0hNRzVeqDXeDHs7ljq/QWfjU782eZ9Ci+89L+jOA0nKgSjOGhCh7x6ZcES9AWRJ5/9dG9XmxDKKFaOVZBS/e6O9qJ+4PrnVZbeFwRL4pFCVFBcifCYyq5QvxukOesTAxDEoFGgHr/dGbm16GQuyo+hO75Zlgb32UC5H/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jsxlGNyHyZGJSfOYcfINkAYvGjJ2EkDOAZy3Aj2hJq8=;
 b=iN4q2+L22WyhNznDT8AvsZ/wdrRvY51aoyBMmvls7rp3an6+kgRKJc6GbbAwifYd1ogngE71fxEESJbo1Ut220onOGZhX8kr6dCluPknGcciaVqeH7X7p+xF9Q4acZidggi9VdpTVDfgxphp+CFTMncBac8nyg/go8N21XLRFuRPhtiopc5lmFwzOeWN1phzmpApQY0dNCkRh2EI6+Gk8DztZz/bucN362tCHATJAfYSoFVOry8l7VlYVEuqrn/Vz6EHA3MxA9vtm3pSXAeb231q0r3P+Ku+mn7RiupXiAQlnqyerOYK6d2tKlgR1to3F27tsozoywZ65Q0ELw52gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsxlGNyHyZGJSfOYcfINkAYvGjJ2EkDOAZy3Aj2hJq8=;
 b=DfL/5TZh5QWvy4sSFQduntVAI80D4jBH4HOGrc4rRtilitBTDZwGh9hDQEDZKX3r+lflVnDqeQEhYC1vND37+W4neQmS4v0spr6a7NqzwIaIngdAEM5VCbkr37uofnRPCSkt88IaTCGxIfgSb4PNtw1hCDH7tuPPCbeEHAri3Ck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:36 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:36 +0000
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
Subject: [PATCH 1/9] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Fri, 11 Aug 2023 15:18:43 -0700
Message-Id: <20230811221851.10244-2-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230811221851.10244-1-decui@microsoft.com>
References: <20230811221851.10244-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW2PR16CA0047.namprd16.prod.outlook.com
 (2603:10b6:907:1::24) To MW2PR2101MB1099.namprd21.prod.outlook.com
 (2603:10b6:302:4::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2PR2101MB1099:EE_|DM4PR21MB3417:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c3f884-0dc6-463d-8162-08db9ab90c14
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qjkXXPE15Pzg3qj4UBz1o1q0O+FN0XAe2BkHrIdskw8QxIZNzQRGZuumk/4gqnq+I/hKzchsnCe0LvwyTkDqo6/NdL9L8saOCwqJ+bwrYEnz8E8WPBKL5r1EQ7WYuD0OXM95Oy671YwH2B7Y6FCa07HKsvuP9vBQ3xgIzghJr7COxbxDqonWVZo7Y5klH4aYnCdwTdhSRKkEPyqSrXBQ77YXhdZC40CUUXxlFdUNF15M9DEgd9aj2ORJkAmyJnS4UPAWStsmbPeuPt3QlWxij5uenPpeOrCb7jvvx6QHYH6Eslom5cvTu+RbRLYBrVdXzH1E0mdm5E0dZDp/7pLKGnt+s2iaj6tKoESj2ewfLIa6K/OgRh6E2YxetrVh9tHnClAbnjmL2d3V0uv9i/M0vOIpFK1qlUoq9l65DC+gJcLXJCFZNnoPeavJOiSAK3oCw/cWbUCPtVncMdu0UiqqIg9+5sg/Pov9qH28UoTdrJqhR139+aBEQdMh/Ya+n8W2QDzKuuuP5Uh/v+xpYoaebbIMDQRKu3X533Buub/2qkCCkJpQfx1rnW5hpw0/4gcBbanhjWX/6EYlV/LpnwjZlEzhCBn0E51tVNI+wFTLadfToowdHwlaTln9N+pE5sGIlERrVrjtaGICvK3AwBFXk13aXDQftVkjF7QXXQPZn1Q7OOcm8Msb3H7cCCERZmQ+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZYGJH57yc9dPVvwbKw99IxOAwoFiz4+XgnGVy+NO+pDHJf9k8GL5o6RUMV37?=
 =?us-ascii?Q?u8D3tEijcm3aSG2pFlgbk9ktr4eIh3/iZ1LBcLp/kvBWdj0Xj0HI+sIdK6jH?=
 =?us-ascii?Q?dmTVL5UvDY3RfrDldbaBaakjSz7XmdROuut3XVYoURb1U8rkcnp9aH+Yb9SP?=
 =?us-ascii?Q?++35oHwxIWyOWwNAHQ3ciaWDuFTbtq9AVy03ehW7+H4vXG4lc2TzNbWTnysZ?=
 =?us-ascii?Q?y7cyfTUxvpIYt5nbmWKI+8N9HTokYrZ7uXuFb6j7rjUziI0/5PE86dXhR7pt?=
 =?us-ascii?Q?llVWPS48sWV3pFmOAaT8CUr5U6Y9Yubw5scuB4zDJ1LBss2xEAtemdg2uf4g?=
 =?us-ascii?Q?lkTIgqUUoc9qUHp/qJoblWkR12IHOlpnKm7hcaQknjw3HWDfzvLK7p8HFTxq?=
 =?us-ascii?Q?QYFOA8fxuFA3cE9GjHPL5xXJDAtLP0ppaH3nM5u88Sa9fdk5E1fvLt4DEoGs?=
 =?us-ascii?Q?jMXPuPuA43Fy/rLSmXyEkXYAcKsdnuVf1zLekqO1+yfVC/9WB1bHAA4e/MfD?=
 =?us-ascii?Q?GPPixjlS1T5tnmpCaWEKUkkZ2I1oYajGh6bZd1Nyz+OSfYhnw26u3ZziApPq?=
 =?us-ascii?Q?V92YQrOa2/Ux3L2x+0je70c2vufcrDmDd0Z4SV3R9rUmPx+8qT4k9VAiuifu?=
 =?us-ascii?Q?xIIARlVWzgyxfFl3/M1aPv7EfMEVFmAiopQkOT3uzUjuY/dDndjnhhjYjtSZ?=
 =?us-ascii?Q?xm9wezC8CJO2j3eqgZBORsOKiL8LRL3PKDjBki/51BrechvGUhYzWiRVlzGI?=
 =?us-ascii?Q?vXr4yLfc/uaDYBqjrqa0GZLek00IcZeiDAol9a6qjmG71Izd3iaBz9RQDldI?=
 =?us-ascii?Q?IsK70fVh+NAwJBHOxKKXUjBj+V/WyWhBIufJFLnIy6asiWDhvMKzSIlTmBYP?=
 =?us-ascii?Q?n4cs8xMsNcrLppGZN7kSBR8OojGosKbvBLDCTZnJLzaqcanpp9jPJGdUjcpy?=
 =?us-ascii?Q?EYPMqV07Ym915ZYrVKCSfwwKYF+2CKQt1w5tTH8WZxejL9JxQCd8OF+eYgO6?=
 =?us-ascii?Q?cQztDhdhkqx/3l2QFYfPZq53u7lba8vtmTOmZNH+Sz4NIQRpxX1/Fho0OT4r?=
 =?us-ascii?Q?7aHz2/vsQueYO/eKDodjJv7lmEswTWWGfj1ImYi2A1cAL6svJ1r054qCBV9x?=
 =?us-ascii?Q?Kxulf7UBGOvjT21O0QMPap51a176XUdI+9jKWZgsLy4OzyxD36Z2K4QW5GYt?=
 =?us-ascii?Q?EgSa5AJjOw53Gm6JAOvplkBatioC/I66zf4iAqwXYX5qDgT7n/cEOqbCG13E?=
 =?us-ascii?Q?L3bMDNv6wRQpOdBJx6uRjoPzBJcRDuJ9KDBOUacBuwUiTA9Zsx/pjbBH/+MW?=
 =?us-ascii?Q?fmVB2saEq+UsYRpKjGUl+HMDYspbyiER0X+IljReWSp3vXkJfffFfFhdzvTL?=
 =?us-ascii?Q?EOx6laVqgdfX8UC3NAwt1HbytZnsaasGk1WaA5gZNOoW3/qEMoA4cJ91hcTn?=
 =?us-ascii?Q?2aTyN8Y5gktjEk06ZHNP9twr2KX2K/eyIUnTc9AtjxmPabBT78ZUQa5HxQV8?=
 =?us-ascii?Q?Zqfwlj1eEDIeHW7sHU/VTHmZfV9FESs70/LxXvX/rfNMrgiGl7CWaQIos3zO?=
 =?us-ascii?Q?ktDNRcR71hNbUzldRYNH7l+1tb4tLAZ0czaSuXKPU9lZCsQsy5nw0KeI1tEg?=
 =?us-ascii?Q?hY+sRWnm5qp8Cx+wdel1Fxae8xE88G+T7BXtSmU8pzs4?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c3f884-0dc6-463d-8162-08db9ab90c14
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:36.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FJb8SiW+sW0yBlI+FxtcNP9Kqh1zxyrsG9nR7qmDDz4AnBDxyPXX2VI9q2482UEUVvrxEdXcBMDTA/LkgN6rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3417
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
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/ivm.c              | 9 +++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 ++
 drivers/hv/hv_common.c             | 6 ++++++
 include/asm-generic/mshyperv.h     | 1 +
 6 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index ee08a0cd6da38..d4aafe8b6b50d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -524,3 +524,12 @@ bool hv_isolation_type_en_snp(void)
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
index 4bf0b315b0ce9..2ff26f53cd624 100644
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
index 0b0d1eb249d0a..83fc3a79f1557 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -27,6 +27,7 @@ union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
 DECLARE_STATIC_KEY_FALSE(isolation_type_en_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -59,6 +60,8 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
+bool hv_isolation_type_tdx(void);
+
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b7d73f3107c63..a50fd3650ea9b 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -418,6 +418,8 @@ static void __init ms_hyperv_init_platform(void)
 			static_branch_enable(&isolation_type_en_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP) {
 			static_branch_enable(&isolation_type_snp);
+		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
+			static_branch_enable(&isolation_type_tdx);
 		}
 	}
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 2d43ba2bc925d..da3307533f4d7 100644
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
index efd0d2aedad39..c5e657c3cdf4c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -66,6 +66,7 @@ extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
 extern bool hv_isolation_type_en_snp(void);
+extern bool hv_isolation_type_tdx(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

