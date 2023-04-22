Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D346EB6C7
	for <lists+linux-arch@lfdr.de>; Sat, 22 Apr 2023 04:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjDVCTj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Apr 2023 22:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjDVCTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Apr 2023 22:19:37 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE62736;
        Fri, 21 Apr 2023 19:19:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRLrZnfaeVF/GsLWuf3hud6okirM9ImirG2nkNv8Tyq+Fabv9lJaeegB2RoIFB7OhnTKQyf7YLMHhyeizyu4KbZc4K0XzlDqhBst3ZmZpBubHMtpLFeuoggCdXGd3mJQb9wsHEIbGI3GoDBWV5oZXTVmLO4gYx56T4sIg+xfdesfuhhL69Y2CBDrulL3lHczCgr/AezCxubsx66Ub2PHUMvBM7ubi70aHP5nK+0Wbh3+kGw/34SWwYZW04tVmAT69TgWeWkJiGLa3p/R8Y1V5xbSNlg8N39tW6dedCkHo9sxPwqJWpOnCpQ7+C8CAYRtvmbi+ucvFtuzaHKQZIFD/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBwoM/LjwXJvKSX67F+QWcIsJfdYlo2EH5x5qfdR5fI=;
 b=iyzM3l84scMzdtGBRRxShywRk2D8gv1KGVyIxw/b2FzWmAqh/cagw6K0qr8owdVIpVw+AReO1GhLM/h0CrlyqWQj/kqy2Ce71ZliQB051meMnEuTntzhFrWOVfLY2vF6Vid9laHawW/CDo8FHJVfYq3hPW7Hc6KY/e1Gir7haDFOGbJHQDWO/f/jglWAdxZDlhiyN+Ma5ksJqRCsOvXZ2Zp95ZAx5syibimZw6waA+JE6hiunk3euWNqYiFJUfBz2vXS/rknd4h7khIxiX6KF+DtiRcb5+FNM1qS292tL35pujRPpkRW4ZMZ8lYth/uCHrH+ydDy98QgCMu26QXW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBwoM/LjwXJvKSX67F+QWcIsJfdYlo2EH5x5qfdR5fI=;
 b=Wc4QwVR8Ep6jkOO9r+M+UAoLbMJakLiuF5gbnxI1yXzloJE+VoixqC6S/yVXgSa1FYejfaIkRjdSj1l0+uBUUU0ZaFliPCcTjmzzEwrRY3BKvzM4z9W5hRirR+iU60XQMibGhbtvTLmVEJc2tcsrY/vSxPC/Zhr5/yg245BAA2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by DM6PR21MB1418.namprd21.prod.outlook.com
 (2603:10b6:5:25c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.11; Sat, 22 Apr
 2023 02:19:33 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::932e:24fe:fc1b:5d30%5]) with mapi id 15.20.6340.014; Sat, 22 Apr 2023
 02:19:33 +0000
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
Subject: [PATCH v5 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Fri, 21 Apr 2023 19:17:32 -0700
Message-Id: <20230422021735.27698-4-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230422021735.27698-1-decui@microsoft.com>
References: <20230422021735.27698-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:930:8::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|DM6PR21MB1418:EE_
X-MS-Office365-Filtering-Correlation-Id: 486e1cf6-2c77-4cfc-070c-08db42d802fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +y6RW3Xh9d+suZBQQ+Sskin1l0kK8pjKSRSvpXVCspNFmPc7SwKc3u+31nJwBCpa5AqiTq44ImwsV0ZzOM+VeaeiDiXuH2qdJwFqozw9XbqTChHAY0Gg08Qp2YMqYJwzGu7byB/07Z7wO0lBzl++EsQ92R32YgBitTssYMQFZ+0tkFNECPjSOf3Ycz/T5F6XAqqRAlsnFdQsAtmdNSdgxoEdxgQUMcYWJw7LarRBuHfE/85go2OZpnyn+5qN+BovqpIdVAZdAcvR31aUkVBxSmL1CcVgpgRts0qcwE9TfwdySGfUjHCo4hSISYCD3y/NW/JnzXI6qSRtjoR9ArLHU8+j75CnRaKFuj3qrGgzWuWw2I8MhYF3eTl/+/KL/c4zFZxgcdqj/acdtav6c+DcWvWs4njguaFqWgcMiGMMU6OuILXDkbQcQx1PYH0uu7fMYCzrOYtkfCz1y5Ty7DJR8AttIkEFjxRu0fUMQ6SNeQh6vFBDRLEY6E1lXykjeAOD6/0CerlPMOgX+3Gcr/GNtmsCxMJnll1IBQIeFXT78bguRCRLLNNwAks34pRaXbnzSSU7m5VPnnviLXyeAugVrpLVFNENKgaUeF1LfgZDr/LviaDfjE9YwZBy54VvjXyiEORecpqlhh3itqOJMZkApA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(83380400001)(2616005)(86362001)(107886003)(6512007)(6506007)(1076003)(36756003)(52116002)(478600001)(6486002)(66476007)(4326008)(66946007)(41300700001)(82950400001)(82960400001)(921005)(66556008)(316002)(786003)(6636002)(8936002)(8676002)(38100700002)(10290500003)(7416002)(186003)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xhdu4EcfaQ5bdp+xmJBzeYPP3iCwWctpI9n+mwrSzi+dFQSgEbccjxA47AF8?=
 =?us-ascii?Q?u23uk6tq/BZ60apzWIH1FtGxriX85JmCLUIzSpxY9ApvVHpETgiFkE+jd0/E?=
 =?us-ascii?Q?bPPy1YfIUIiNcH9V6xKoRkkB7z7rRIqd08c9RKSdWf/SsmueYp/8wyU1xJoa?=
 =?us-ascii?Q?baTX1INB8fLLP/hZAmVfvl3mvDQm+6kiPPaMFbhRoDaclu9707UsS9EhRdGF?=
 =?us-ascii?Q?tZFFjZFUQHOHYkC4jac/wSLa/hQMcNIeN6WPjLv4jdhtmVum58mvR2LcFeYR?=
 =?us-ascii?Q?M9cZTL7sA61lHrSrjhRnLJSFDPsGE4JWY/WFyH+q3e3IwSVPmu4qB4GRDXjy?=
 =?us-ascii?Q?O2YujJDB2ocxGnzsBpK6l8IbwD7O4cOuPjQlf9gEdp+OQ0BvDWcF4pz5bRST?=
 =?us-ascii?Q?Vo+w4mv0Hw9675FSQbbyQ4NBzNdY81cNL+mYDWH7iJVl7LWSBo9ArkldyQ7f?=
 =?us-ascii?Q?ESkCGkVKbqo2nzAH+n+vMp1mPq5mKFzN0VGVU9CsYQdK/tpZHDQlR0V27XGv?=
 =?us-ascii?Q?zlC6CEhgaq5zO3OPq1jpKHT8qF2HbGm0rlLmLQsF+yoJ6z1GvMSALool3yxG?=
 =?us-ascii?Q?QX7YD2+bRO+NsRGFE3PMdgZdXXy8nsan6HzkQD7zTr6hX0XTRZuMcuXljpwP?=
 =?us-ascii?Q?uSSP4Rx9awhR/dqO7MEaR690hofdsYGjtZrDkN1BPsIET9lcqjeibLaiWXfD?=
 =?us-ascii?Q?XtYTwjy1HcQ7YkrAEq+50iPXWt8BY3XNnp4lXv4p5+XwwqahG8UdQvVZdH4O?=
 =?us-ascii?Q?lhLuFkiFxKAWZ8NNu9PDIDo4JUyw9XHYXD6agPfNAonLFHhXIsdhWbNk3Uxi?=
 =?us-ascii?Q?/TLnMW7CRqZQ1TnQExFP0s3UHYa7sGIWZdyY0kwaRPiYo6Yg1Xhymth7hChh?=
 =?us-ascii?Q?lEM7yZvM6/d8LKF4tfWbPlQn97sydqVLRSxcNB45NNsY/6pGyEY4O7gfYhVO?=
 =?us-ascii?Q?iJvalzR3/qYVJV6OgZAyOMAcQhb/F0F+nqlutww/2VRIMwivl0Dku4moPJZr?=
 =?us-ascii?Q?wiLcuij186HD49U9DSKeSTjwUAKMBfbbjHb5Eh3y2AzgUxY3gCUR7Yhe0ttS?=
 =?us-ascii?Q?Idpy2zulzQAhokzsDUrwaQ3gHcC8k+Vml4WxzvbXD34kpN05mEuwdkntO7Gn?=
 =?us-ascii?Q?/Ynoawxnid5gtEDTmp0mjAYs3xGkDn/CwXjipgMYLUE0cMbCpaj4P8y+xwX1?=
 =?us-ascii?Q?dcokrijr/I2Bwly3XouMb0082CdWC7zcEtAOld/25ebbDkSdEQYJt9WxqeOp?=
 =?us-ascii?Q?Bytcrbmwhybjm8jlyeIX/3T/e1KWJjZn4O5gHUk+Pq3//wnykFoaemOxghkX?=
 =?us-ascii?Q?o0dbD8+redjqtydHRcDok2bsVmrA4bTvd2VhNmu69NygG9lozQzEYhEXpEeR?=
 =?us-ascii?Q?632t29EW4QefbF/VRtBXv8vP7DHa1cI1liW9WdFNy+GNNWNx8V5bdB3cUCQQ?=
 =?us-ascii?Q?3HIfTBjxMDPAIy5BLy9bChRQEKR6wwPc/7XmrBgDmiXN6WrfrTmhYjVRL5T1?=
 =?us-ascii?Q?Bn+tyTDMwc3BMgZDRvs0eLQnJww45UIpWrFv/PXEOQ1YhFUeHGngMcDOdvEQ?=
 =?us-ascii?Q?0ODcPUHWDZ44LWT1AR4M7ufBsgHKJU973pbYEP0ntEvkhVxCvlqaYbnD81cP?=
 =?us-ascii?Q?FXA0WuYKso0EJ0sdpuboS+GZZs4SZ/Vf4HRvzbfR3GVL?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 486e1cf6-2c77-4cfc-070c-08db42d802fb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 02:19:33.4969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vNBs4IREa7vyIsq/gjao+qYGLZEyXEgQRuSkNbiT072ASDkC1zNQjWH2oF9FgBBTSoJXAp6Xm5TW5Rq/37UrZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1418
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/ivm.c              | 6 ++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 ++
 drivers/hv/hv_common.c             | 6 ++++++
 include/asm-generic/mshyperv.h     | 1 +
 6 files changed, 20 insertions(+), 1 deletion(-)

Changes in v2:
  Added "#ifdef CONFIG_INTEL_TDX_GUEST and #endif" for
    hv_isolation_type_tdx() in arch/x86/hyperv/ivm.c.

    Simplified the changes in ms_hyperv_init_platform().

Changes in v3:
  Added Kuppuswamy's Reviewed-by.

Changes in v4:
  A minor rebase to Michael's v7 DDA patchset.

Changes in v5:
  Added Michael's Reviewed-by.

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 127d5b7b63de..3658ade4f412 100644
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
index b4fb75bd1013..338f383c721c 100644
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
index e3cef98a0142..de7ceae9e65e 100644
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
index ff348ebb6ae2..a87fb934cd4b 100644
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
index 6d40b6c7b23b..c55db7ea6580 100644
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
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index afcd9ae9588c..83e56ebe0cb7 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -58,6 +58,7 @@ extern void * __percpu *hyperv_pcpu_output_arg;
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
+extern bool hv_isolation_type_tdx(void);
 
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
-- 
2.25.1

