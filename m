Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AA46DBD09
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjDHUto (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDHUtf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:35 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B8183FB;
        Sat,  8 Apr 2023 13:49:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSPpW5sDXoNeFKb2lFQuZ5XmuRHUTzoP1JPygzss1Mf0BR5qNHMGW/u+2/0zXp9SZKpZGPJRnHEqA/dmAytGILYyu97WXFEo/xA1lxNQfaSbZMEi7vZxIm09LBGZiBYrWkxEX1PsGwDstA2c9CbaZJExHyJpillb2y0HPELVRrf1VU3lnLe39GeAFfH896tZ6WIJrYe/Qxf45oVLm+19evagpb5EYsgDcYbutU+FoiPM/5Q1dICOy5UCXQI5z+SY+5aQ2FiFYJ/5u5KJqixnhPpxYpu1jBAFWXnDS1CGSSYXhRK97kZstnUM4DOpj4JDqze+fDUJyB6pcDSPUAEA5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ZXiZxZlx2fISptxhEnU2NFhYM+c4xokvq0nlIwOIAE=;
 b=HF+h8uxLv3LWYcGkzS2PmESuSHmmzUx+Tec4EoJduGjTHG1yMGO+sxCBDJyJwVfcpem4vCEUF6oQgCiW9f90T690cHr6TKprfplaBo+Ds5othohuFX8SOfww5aY+3ljPDiF6y2LjIrbSIx7LZcfBMmvB19FwYnejiz+aveeZ9TBbYPcB8Qip6+WdMht+KixN4cVozHovylIrNum9D3rjZSlzRcIPAO0BgVfTmHBUXcgTbVoh8Jr8e+7s4g6ztX26LWWi6wzm9WRsHnofyy8WWHrJetaN2ouhUk03u9IIZCOHuIECRA1u6fyR/q6X3ik2Fn1VQfLgRVzrfHikQ02XYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ZXiZxZlx2fISptxhEnU2NFhYM+c4xokvq0nlIwOIAE=;
 b=brCiCQtqLD/uMUV5NDqwqMvTHKGuEgShYYQVpnxfGU1f/TLNEjshuLiRhO8UYdfeXQrPxfxcTdLkkjatudjA4gwP03cmRZn2EhTMdB/Pxr9Wc6jqDeflXiUcw+pzJU9nQ7vTrHfOc8pDwgYT1afvXznmyMM/I65EIri9f2YZJZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:31 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:31 +0000
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
Subject: [PATCH v4 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Sat,  8 Apr 2023 13:47:56 -0700
Message-Id: <20230408204759.14902-4-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8e098525-6759-459e-a417-08db3872c0c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeq999l4kiaiux5vWKCMV7sIw4Cr6BxasJ6z30HIv1yVMEYglfoZrJOvuZzhHT+bWKIseV1tDIV7N0z/0QKrGo5NHjJylhtFaktcAPS7kQJrpZD70lkA5HHGFTE6mJBAVxMFWKw8R0ZmVZTvoWTsts1TK+VmuYwX1dQlOTVcP3/DHxQBT2VN/4MZlEgz1KM2h+lv4I7sYPG/nPHvpv8nXUGmiKCNBMmavLyM7czr4ABZfiUh0LZ87X6Dk/43OPoKNE9AAwi/br1O2XJnxDJbFc6EEQKqdvZewpjSuDfLhgE0CBHIJBSrcgDsZOYw32lQ93N3mURTzSufiT59POAIz1qGZJGBbhziHmlZVNQ6wjkPoF3kGLPf71XYmyfJijrygETf+meljVCmnTgCi2ejCLYTTmdjmax9Euit1dEVA/vDJkKRe9h7d+LAC3UJL8f/FxEXuSvvmBgNefl+e8bhmbXOJ7i6lklO5rqWVpkglgMK4N4qhtDQNF8na399FvdOwOH7U/byIXbCrL6UgfJP8rTbHCxAD3jaHJkiRDJLAsPQlRa0ZtqR/4Co83g7ShMOvo9koy5YM+WdRQoFwY7tC101bhri1H9zR8ZuQs1yHjEfQQkTxHbig6FW7UeYBX6BFf2t2kWC1XgDDsCGF/puKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yJx8T+AizIyx0YICr6edZa3SUlwPcbpQV/KeisWzMe7fWc7fZb/gYM86mWic?=
 =?us-ascii?Q?CdYnxlVNj2tHV5zbfIxclW15Y5HTmTJAIywWsoqG1tPtDEIMZhey1l6DH6bv?=
 =?us-ascii?Q?8Luaf6XyNtwcJpXhKnjk2FJ7PBmkx5FjTL149gZ9t8qX0kRnHVEUH0Q0aXpz?=
 =?us-ascii?Q?SzNpf71hn1tWuJ4cbni0M/IAiNNrsF1v6zjsOyglF9SKCXGs2CsqfCAIbI4+?=
 =?us-ascii?Q?OFAcVIyND8Ju2JBCuXtGKVwWOORxXqfuxfl5/1vA7yb3eoT46jkn9PXDHRMS?=
 =?us-ascii?Q?TKRHenoJzKAH77v+neA7W/46n/hzVYaAJyBvtNcCMi3HiXVWdbUN9J9dBbml?=
 =?us-ascii?Q?cIZodFXhalbA8wYi3818tUWswyVdOgWPAUpWYCLcbu6kZX6GUQnqtDcGga89?=
 =?us-ascii?Q?pMEmBGRnYzy1O91PdO9puuzRqxU6ivoumklpz89wYYJpvWR67U6n1Q9OP0xx?=
 =?us-ascii?Q?tCFjQVCmICV98PU6/unJ+KP4afQV4R7wEqLvtCz4pHy6k+dmFbM6OoV73Fmp?=
 =?us-ascii?Q?oqEJSZtaXupquIKlLb7pIu1+WzIp9j3svWnU5fMAq6vl/1UfIvOZmkrrlgXX?=
 =?us-ascii?Q?Edy3cjg0nq9Fvy6F3YqHoxJDuo7odqKrHbScb7VHAG0vlj15pfD+sKEhXXYJ?=
 =?us-ascii?Q?dzxqtjDO0M8/1FJLk2UAVBSmbX7Jdf9uxujmSpL2Dq56zU8yRNge9/p9Mdo2?=
 =?us-ascii?Q?DAGPddXLEIrLxpqAVMYPVrGzrokAikbNK2UPBYwBlj0xz/LcSFMNGKIaYgrH?=
 =?us-ascii?Q?RFiRpBcyA3CFxsljOHO8VAvQum2m7q9AyFbZ6l+oBMzIOiJTJuvOefBtzhPk?=
 =?us-ascii?Q?ClivP71V/tl2J5Vk4VQUDS39B+c2O7KOvpedHHfDylNE3UqS1pDD8EGBoG4f?=
 =?us-ascii?Q?7dyHa05VCCmhj5jLX+z4V5j9RPbVr+uUXTEGywRUjFK/MlJ6Kfi+HElRCQxt?=
 =?us-ascii?Q?sVmXYe6WJ6/iF1MR8kyYUHdLOGzvh9zyyUW6ALwjmrslGeMhCCpZEWtqztb2?=
 =?us-ascii?Q?1GNQyDluEkcXAxCe6qk8D8bli9kYA+hoBCDl4UyOe5qvCAQSo59iaEm5bA8+?=
 =?us-ascii?Q?gLKGbrZTfbwva35lLm3+ZyoW4I0sTLXx9Is78jcZHmIeAHVAs3cbdSzpBEDO?=
 =?us-ascii?Q?O1YPA+o4WM8GIpSbX0AhgXAPOFSo3mX3dmcIv4dvDUi4Jx1X5eTdFTgdp7ex?=
 =?us-ascii?Q?1kcyccVyKbzYv+sqVa8/OGOBbMd0fIi7VAVDrQRnaWRv8m72WHlhZMMko4aw?=
 =?us-ascii?Q?qINuJBwWZ+XPWyw5sa1FfF0V+r+26lq/m+/zhnaiAU9vv7/cZK68fWYlp3u3?=
 =?us-ascii?Q?MlS1sOj/oRW+xIWrop9rMfUHtO/yYkVYzda2+iN9qZkEuBhPFnlG0jGybOw3?=
 =?us-ascii?Q?I2MUYC3rFUpcbeionXrh4Ee2YrXeLQTGJs6zFdEsYO0QNHs+K/emV9+6wcYK?=
 =?us-ascii?Q?CK0k7Ka4KA4cFFGWk/llDOKwh9H4eqP6p5SwDP2Mx3gELEdeljHZd04L93HF?=
 =?us-ascii?Q?6mQwz3lKIs+bkeRnoY7ekH6vYoaC4trL3lHKPUVZK/fDJA85nfQ31Aq5Jt84?=
 =?us-ascii?Q?NPc25Rqj2OOhhXTAop2xjhKmQqbToNnYfYiFpAh8Om9VjPFUtCvsvWrrsVpA?=
 =?us-ascii?Q?F59iCvd0C5T8t1WgSy74Md7C78LD9mFkaOdird1g1kKR?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e098525-6759-459e-a417-08db3872c0c6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:31.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tEiU03XUZbi3yCrMcbCA5DQPAarKdIoSlVn2CEpGcj5GUcMLzTvt/cfGzxP3NuqtAA0lIxAFZZ0xB6+gi7/6Dg==
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

No logic change to SNP/VBS guests.

hv_isolation_type_tdx() wil be used to instruct a TDX guest on Hyper-V to
do some TDX-specific operations, e.g. hv_do_hypercall() should use
__tdx_hypercall(), and a TDX guest on Hyper-V should handle the Hyper-V
Event/Message/Monitor pages specially.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/ivm.c              | 6 ++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 ++
 drivers/hv/hv_common.c             | 6 ++++++
 5 files changed, 19 insertions(+), 1 deletion(-)

Changes in v2:
  Added "#ifdef CONFIG_INTEL_TDX_GUEST and #endif" for
    hv_isolation_type_tdx() in arch/x86/hyperv/ivm.c.

    Simplified the changes in ms_hyperv_init_platform().

Changes in v3:
  Added Kuppuswamy's Reviewed-by.

Changes in v4:
  A minor rebase to Michael's v7 DDA patchset.

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 127d5b7b63de1..3658ade4f4121 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -400,6 +400,7 @@ bool hv_is_isolation_supported(void)
 }
 
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
+DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 /*
  * hv_isolation_type_snp - Check system runs in the AMD SEV-SNP based
@@ -409,3 +410,8 @@ bool hv_isolation_type_snp(void)
 {
 	return static_branch_unlikely(&isolation_type_snp);
 }
+
+bool hv_isolation_type_tdx(void)
+{
+	return static_branch_unlikely(&isolation_type_tdx);
+}
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index b4fb75bd10138..338f383c721c9 100644
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
index e3cef98a01420..de7ceae9e65e9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -22,6 +22,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -38,6 +39,8 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern bool hv_isolation_type_tdx(void);
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index ff348ebb6ae28..a87fb934cd4b4 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -405,6 +405,8 @@ static void __init ms_hyperv_init_platform(void)
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
 			static_branch_enable(&isolation_type_snp);
+		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+			static_branch_enable(&isolation_type_tdx);
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6d40b6c7b23b9..c55db7ea6580b 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -271,6 +271,12 @@ bool __weak hv_isolation_type_snp(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_snp);
 
+bool __weak hv_isolation_type_tdx(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
-- 
2.25.1

