Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E23F6F7974
	for <lists+linux-arch@lfdr.de>; Fri,  5 May 2023 00:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjEDWy6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 18:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjEDWy4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 18:54:56 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2E11DA6;
        Thu,  4 May 2023 15:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqNDVUvv1EahNpfWY86+/5plFH4IRAA4/YJsGVZasGjPKpU7K95u5oZib32JXrTK4pgP6tKfdhyJ2+YAdlpFfrTIPdsVdlB/WfzggQRyqdLx4lY0FV+CFo9xfzuwslHjIwbK+CHYd7WY2dgaa9TcMMtWTvdejmT038Y72TkhE1xNueziYtirOVcDU8ydnMYSQoJ3u3vAGK8ilxIuPnxFqEK/EhrzImK4OQOfRO7XkwGvlsoSCs2Xoe1q6BHsAQm7+Ir5gYSqvHPqiTwtIFDNmMProVhMLjxzAI4FSVPci3pSCbzXC2t6QC2+xJo12nDiQHV2NFhuT7V2E71qKfGj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HICxEjvifot0hXyluUJx+0RyHTbJjmVRE7X2xR7lbv4=;
 b=fwio32D+D2JpyZHJP+me5bFGxwjTUPPM66TOVlfLeSJ0R+MD5Ix2QZIzfDidIflSuMnB08EfamY2uvru0OH9OlAlaVhLzuJ90lxL7cGIBge6XXtOaLN4r3Xb+8y4rkN3pzPH60kpdRPndoM79XSsMG5DBir/bi8+1H5Jmvi6ZGNLQodOxRSQwJPudcxTkjdjVwzVniamCu+pehA9y3H9P5oywOfGG4qXLVa655Q1/IQ4RX9yNv/zGtPObdUs9tsJ2KoQ6HnzGhK8+ANMxlr02YcwRgNGrwYEgkDffa7KyNJRBgenKQDIlkZqHGDBYFpQtqbvQyq/uVKN9DjFoGSJRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HICxEjvifot0hXyluUJx+0RyHTbJjmVRE7X2xR7lbv4=;
 b=P9m3kxYjctlvCvlwdHgfWXXdXGOS/4i1xzWBi6D6k7wb/CJMcN8TVkDAISKyNQXw1sAg7zBRQcx7wFBBDLi0tanF4beMsGDBqQnkmjV7iLn/1v/dmAQ2yVwJiuOzVG+z/K2kGplt3TILyPMvhKoMzYy5+0XLDkkUvYmSpSLdMSo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com (2603:10b6:805:6::26)
 by SA0PR21MB1883.namprd21.prod.outlook.com (2603:10b6:806:e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.9; Thu, 4 May
 2023 22:54:52 +0000
Received: from SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274]) by SN6PR2101MB1101.namprd21.prod.outlook.com
 ([fe80::b2eb:246c:555a:b274%4]) with mapi id 15.20.6387.011; Thu, 4 May 2023
 22:54:52 +0000
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
Subject: [PATCH v6 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Thu,  4 May 2023 15:53:48 -0700
Message-Id: <20230504225351.10765-4-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230504225351.10765-1-decui@microsoft.com>
References: <20230504225351.10765-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CYXPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:930:d2::10) To SN6PR2101MB1101.namprd21.prod.outlook.com
 (2603:10b6:805:6::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1101:EE_|SA0PR21MB1883:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ac88d2-bdaa-4990-298e-08db4cf29273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRQ2fbIyIGHOhinHO4YDXgFzB6ogdwBYLDXggHHQ3+mY0xyOFhjXKCnR7FaDifF5KMeMOnXBJePLSmRGPug044SezcUGn8fGIfgrlDoPMUW5/sjOuL9Y//wxDHxhSjUjM+hAXLrW6lWWxyMKjHrz1qVPHoFVqbbxYE7NVWdqQI0Eto2kPqR1Ffef0xp0KOFefQ3CBbdiIn7pVrcp/HCT9zRKTUTV60eXdxJgmV1h5FF3th6TXQ4g0Cvd+yynHaDkeLkhXXA1MiArfkNLyeEGYP9dSJES8nHDTFMup41v9zTWoxrTwZzC4Ejn168jRSeg+jVuBt4yPVARz8ILRZ4y0wGgEXZCR0ZBxllc/I/E7YP//0lAYDpXWLO0cxAWzPlQUisUuNnozihTqyvsk9F8qbJ43lZfnncUml+a0tUZGcKBlRBHcGp9yVcdzVf1v8CqXP4JUeg1RnS9mmrlAYdXW7NrwPDvpBInhNyX9l3CBSDQK8kTxb6JTSeMyYwuAzIfoUzOd36kfyJebN32I5Ldh+LHKbInlvg7MWWgPNwpja99sX/LPJ+xFbATL+DCbolX3S3xWFOztUuLV9w+X4FVppZ36ERcUNnJCuWnEr5HEl9v1z1HrrhWAwqwd9c7XQPuItRrVdkK4XkwEG63keRgPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1101.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(39860400002)(396003)(451199021)(36756003)(86362001)(66946007)(786003)(316002)(66476007)(6666004)(66556008)(52116002)(478600001)(4326008)(6636002)(6486002)(10290500003)(2906002)(82960400001)(8936002)(5660300002)(8676002)(7416002)(38100700002)(921005)(186003)(82950400001)(107886003)(6512007)(1076003)(6506007)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wdn+iHBzZSwpEDS9ANIAqyCtUUEK8NvFqHdza3pIhfOx+DyIm/sWYZ2cn2v9?=
 =?us-ascii?Q?vZMdrY9/b2Nh7omBBAOiLlD5ebwvapju0BUZ/sV+6kx3P6PoTl1D30MU7Hqx?=
 =?us-ascii?Q?9WRdKlCik3rKPSD9V4UV2l1VCNig0QhPwZ6hB+S0FQ64mQGJgU8Xh5Fm/WJE?=
 =?us-ascii?Q?UYmCWSa3zKcNafYVcBdxsK9zi2WdTVjvg3vovX2Db7rEAP9sxeP5qBTeCx87?=
 =?us-ascii?Q?Q1MGX9n4/4rQFX4CbjNq6qdT51UBXNkQKFywEKLhrsKtOJ+yrbkaD6lgS4XC?=
 =?us-ascii?Q?wwrLFEHFVUGj8/GhFvLeACQH9BwaZo6aSwdQbxWMpTjSpOc2BNhXhmnQ/6kd?=
 =?us-ascii?Q?HsFD7RpVuSlGrpAPw3Ieo1+kZm/nJbUR0r/YyPzRwB0AezENRwr9DbMOnevE?=
 =?us-ascii?Q?ZqBxaHVhpw9jbdZDfLL1QyoI5Bzf3lw9h3BKVoEhhj1A4jDL13VociPE1KHh?=
 =?us-ascii?Q?EaANuAiQ4IvRxQiTVV58U5T3UpeC56HijhfhAtxMOCtYKya9tNM5nDASMGUc?=
 =?us-ascii?Q?ZxrtlOT1OUF5iCerQgLdaHoAPMKgSUqkJtsfNpkQoXvMKYGcBRIx3Qk1o7yr?=
 =?us-ascii?Q?rihsKiGc1HIjqBqIEkuZc7w3Gh3tWkdnh96FPX9BV18BuGCCT1FtzuqmVKCl?=
 =?us-ascii?Q?5SfxJwbiuDGqiPz46j5y34xhdY1cGwvSkYiTHHghtCaQLUEfck3LakvhGSVF?=
 =?us-ascii?Q?RNvGUPy6SeePsmVJHkEVwi5AUvKTULvv0SnyWMa/zRclO3sTL5P1c3oI2r07?=
 =?us-ascii?Q?oGWsh5ZkKTAq8uiaI++0yF4UOruPoAQbQSjnNnT99wRwN5PYZ7ZNLyT6JBp3?=
 =?us-ascii?Q?qNXLNmrS95leMiCnSV6gAAH652OShc54HuREhd3/Z0hQTj0i5CnBLEUiYKK7?=
 =?us-ascii?Q?PrY20HzlhgRH80fnGy0133ungSIZU6YiVaztlEIGYJ7rDXS+eNto4uqSwzue?=
 =?us-ascii?Q?an4xh5os4Gn0LomdcC58Ot7qRW8OCuPlF+FMUnExyyUctRqs/YifSA4W0+QZ?=
 =?us-ascii?Q?XoQX1hwOE9f24E7he3vtfhH5RFRk+0dcsF1p3r9dLAG4v6HYnbaxNWjq5QFX?=
 =?us-ascii?Q?vpcBA6h8dL3urGSqe89dTdy/QecMXVryOib1VtL1+6Cu42sUCAhK7onscyhr?=
 =?us-ascii?Q?QQbXl0tpnlV88XUuKQIdITG2NXd9K9s64wnbD9Xlt8bkQf/dYpc8PRdFzKHh?=
 =?us-ascii?Q?4pBdc8R4mkfgPmlN6I3N1GMb4Ua9N7FeDI7W74V6HVXJLvxMZAB9Ji20pgVr?=
 =?us-ascii?Q?fCzsWo1PVWLl/g3R3WZFGEl1HIZp9hFxViDbglHJvb0IpmTl/95yhkafQWKC?=
 =?us-ascii?Q?Zr86Aee7+6+ryFGLPEG3CFpNK6K6ApzsYq8pGloYc32qO9Xm4p+wyXru2mmD?=
 =?us-ascii?Q?2N1lNWvC8ztM92xvJWf87b3TnhcO6AGVqVmFizpF0H3z6SZyzT7ZE8NB72Mf?=
 =?us-ascii?Q?HbDTSsOur1KWaQNKOK49MlQFmyyaj7xUoIrCo+fyzYDqJeRUTTK7G+lfgXvY?=
 =?us-ascii?Q?flrmY3+m+nc0GvVsQ06qY0iQa6wSklE7SV9vxysoVixq3NxokKvjZk4zaakt?=
 =?us-ascii?Q?g4Ud/4PdRKta8L6xBhPmgpdoiUeFa6mFtG5ytMo9bhjnuhnvHxkyq5uPNX/J?=
 =?us-ascii?Q?lzjZ6M3liuGjHzp5KcX1Fd28vKvy7Jh1kB8zS2cwDekn?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ac88d2-bdaa-4990-298e-08db4cf29273
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1101.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2023 22:54:52.7602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuFFR1b2+iLSvnf8zlCGIwnTSpki69PTX43WNUuzayaWzwItE8W+5+8c0dFtS/OqSOJE5VZ5XbB7QJLW9N6xtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1883
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v6: None.

 arch/x86/hyperv/ivm.c              | 6 ++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 2 ++
 drivers/hv/hv_common.c             | 6 ++++++
 include/asm-generic/mshyperv.h     | 1 +
 6 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index cc92388b7a99..952117ce2d80 100644
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
index cea95dcd27c2..ebb6d24fe352 100644
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
index 49bb4f2bd300..231e56631295 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -26,6 +26,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -47,6 +48,8 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern bool hv_isolation_type_tdx(void);
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index c7969e806c64..2fd687a80033 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -404,6 +404,8 @@ static void __init ms_hyperv_init_platform(void)
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
 			static_branch_enable(&isolation_type_snp);
+		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+			static_branch_enable(&isolation_type_tdx);
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 64f9ceca887b..6156114cd9c5 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -502,6 +502,12 @@ bool __weak hv_isolation_type_snp(void)
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
index 402a8c1c202d..3449a8a27c03 100644
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

