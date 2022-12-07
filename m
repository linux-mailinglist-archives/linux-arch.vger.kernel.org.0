Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C164506A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiLGAfY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiLGAe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:34:59 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022014.outbound.protection.outlook.com [52.101.63.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E6A1FCE1;
        Tue,  6 Dec 2022 16:34:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpjDpIsEGrRhPSgPHpsQIgUz7qz3kmfOSRrIaNLUPv8b5m4E3GIpfDTRbu4sePMGvmJWCr1dOkqTQcFc5mgOfNw161MDMWQVW8TgzhyplGCaxw5nLmwKTnJ9u1umAfvVrQVj7dVMI1GQ8/rPIl62X1trr+DD4lQ4cPTkivaqopwKSyJyKMffItvIv/ZLVK9+gPtQ2TwjCDkt1+EOorMS+xNlT/+W2BS+naHYiPmctzYfVe2Sj+32rQ2XxRoi3W+tuIOSh8dPI1X2kSeG9aZEm55Eyq0OrZ0voECJ27kd8dNLQR2U2ej1byWt3BeTVPQ5fZMT+iYj7EiyCiSQVqPpSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXNK4aUQUfr4FbGiX+X1/32TO3PF/DtSaeQbHJsLYR8=;
 b=NRFZocVSAUwAgQvGkWSxdlez8TVb4wxRgMd1kudmJApvD+8zIYEuvK5l4qGEJqRfRjc2zbWfhJosNpKpU0NZI+W1I4kVqgymWZx2qazXDlqnx6CFuSuAS1gQUtXJMLuhYZD5dRrfKQwH8gV+0GEPUDyhzUGN9S6JGfEbm3TYahz6xpKn3k10nhKp8bKoqnHNRIeHVojWCseULOXDaaBSWbAl07ZWKHxA0HGrRzRP19+C/5rV/6XKGVVhy1Xo/M2XGET3kW5OySSbuHlSOGnZgGyznRzt9277IM5gkAqZ4Vr0nXwem+96e6CRflVvs3bnkfFfhTahUZELXypcsCjwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXNK4aUQUfr4FbGiX+X1/32TO3PF/DtSaeQbHJsLYR8=;
 b=iAkaY/uQxOk4ixjHblFkpETM3WnXt9i/ki55Xvwiaf2Qv0DRuVfTIaEVFL7wjx3X3BeENKcmrJ9EkDk9WELtlTbyw/pA6WjXWURXeSZG/dCAj9F7J62Wv81Zf4U4+lVUZ5T/i1YXkE5a3Lm9sj17heMj1bx9zg/9GUOasvoF8rk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:48 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:48 +0000
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
Subject: [PATCH v2 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Tue,  6 Dec 2022 16:33:22 -0800
Message-Id: <20221207003325.21503-4-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 90c68199-d335-470a-5ba3-08dad7ead839
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: avJb+pmcQ4Xs5GlTkxvrLX9/4bt/rgW65irDZTjc6VK1bR56cnHIcJ8YZAkEDmK1ZIx8e/Kf6JO1Zf0jbYPUr0Pg9WQAYhYi/8Hbwq5n1goeBCv/xVFHUSgfqxoe1/dd4hKpSJw617vPiDr8iPJTtdfrx+i0H9KOWKAUHhKxM8VxxY+NIqh0xeJuiO1Dg31hISx2IbOY6ZYCxRPqGBzfsVxUpjU4rILiKPo79A9cL5etsCZ+nb56bzvUDGDACSga/kjY6eAEaw2EApcXKYRsAFMKWrHCGAzX6XwG+4W1ahVfm5iQ88hH8pvwW39BKyTsM6wyHc/Ph62u9PNCNNcGYIZvk/6vg1lYDBbONgMa8elEgWuxYcf/Ks56+QTt6dQet3mRXzsME8tJfj1CRhmoNQirPQSJrBVytKRsaqBjY2MvntKEvpdbdVPss+9cB9/xARbM380oNinWwUM9jGbideeygrAr7tiO5rgmNGh7gJVg1HH8fzvaFuipAtkk2tYhUxWI3f+CetLBYL+YYtWFfg0YepRPeZ2u0CY1Q3huX5PrIP7rUAvml2H4Z0T0Yjyum3ogSfP0EDLLDPRqm6e9+kx7gGXj0XgfuNLGTmIBTwDnn0ywq0zDkxmiFpSilCcwrUgqfKlajWZ2VKEPbPmIGvLshre89IMzztODxL5TGbhfRDEjWgDxnufQSO9z4nuyaAOBIK8Y7LNHt7JT4POIPlodt340HJ6KyiugwxSqH4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(107886003)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?54+4HLEHJ3CQjvRg+o+tIRtV+LSTMTHj+VkIaof5RHAWYA914jkuwvTPUp4m?=
 =?us-ascii?Q?JxtbCvF3r8Ws/x5g2RTPgjDMfn/DUwPNn8AN9JWEc8tbHVgJ7r3vWLNHoW4L?=
 =?us-ascii?Q?HrZpHoqE6ZWZRhNPFMxf5v8tRmRYh7uyfE8jOneO9PpFMkKjweTZx4GuXTyG?=
 =?us-ascii?Q?1bxXW9FGEpXOpKrE6bfSfg2EzetPaGkDbRXEHOBT5VIIrWG+E+o8iG0P+9bs?=
 =?us-ascii?Q?6QDBs5N9EXgMX25CUTCz9FmMKrBEuTqYh/kRjKNjBpJ38BURqJ5zukpc7ztR?=
 =?us-ascii?Q?6yywgGSz61wbY90DYG9cdzhTZzgEbTiNibB1M6XWvokbwjnKY2SR2zh9w7DD?=
 =?us-ascii?Q?Ve3/l6fXipEhnYWSdgLPlUSzjPUQD3EnUCh2K9vlZDwskTUaWW5ldhMnfpau?=
 =?us-ascii?Q?G6Nx/2vDDlkV8BUhJwiariRdPNfQWBRhjHFkhjhip7tqca46Jgbw21wV7VfX?=
 =?us-ascii?Q?v7u/EMk4g42wqI2AALU2LHm+McgoULcneUVWn630poAIRbIlFkWLsnPXYEII?=
 =?us-ascii?Q?ZwedGeN1c7Psv4o5zA6L5dtriu1Da26Y1Ii32TfgxfDCKyP7wuf+QkXnPD8k?=
 =?us-ascii?Q?iBFAxhhanVnLtUcBqltJ6hcCLZITsOdpMahxeo8YJ5dGj6wpaU2b9GswChBr?=
 =?us-ascii?Q?XCvf0fB3VbfD+On/WhyUVDN9eVAf2Jm87OqJa8epxPN2+jojTZSADH2NNjwU?=
 =?us-ascii?Q?CAxJPhTbk6dqolZmfAiGQTu7Cr7zFzEH8eAnp/yL1Rj9oRTeSDz+2fJqKZuC?=
 =?us-ascii?Q?o/1URzBimN11BMSs/z0OIkikk5P6ZhS8d70s8bfBEFPnInMTBRGKP8B6PAiz?=
 =?us-ascii?Q?ahJKtuB3NR86B7EWoZtNPjzFhqOLaV/3tAzsSId6EYjU7vs5VqQECDQVERQM?=
 =?us-ascii?Q?qauHHZv0uifamF3OZAaEgVhhSvmIjDte0DrgoCoK4BIWuiyOcGcpaXBN5bg6?=
 =?us-ascii?Q?ZAB4DMHRz17ksAH7+7Tk70owYdpVkwFxji+j5Y+NiOwiXz9yGyryIv3zBAXw?=
 =?us-ascii?Q?Wdh47wqP1gJGR6G6nOs4jZ7rBgW5CfEaFBcK3nEHlfyok7FtL6ZkFzjC9MPQ?=
 =?us-ascii?Q?kmklT6gLQQrD9wIrIWK5FpurVJJ++e5I2kSA4mE7dy6JWicJhnPk1QkozKCt?=
 =?us-ascii?Q?54WBw2NfxgNXf6YBxuSwfaAYxRBkmAxCHTSpoz30WaSWzYHku85lS6h9DgE9?=
 =?us-ascii?Q?pXOC64iyL7NMzkekh45PAxHjZGI8M/XrmlAjOv+EjFB/WEo/5QY0YUZhCkAK?=
 =?us-ascii?Q?ZsYvf4ZYmC297KYjjch4xFnZGi8bsp1djdcmIdNTYLdrVxQ3Nih49A7uzZMz?=
 =?us-ascii?Q?yhfyVpkcriosP695ap1ghQZ4pzyfZYpWLKj3aPLHa2JZFPzep4Y7gEtcaSDV?=
 =?us-ascii?Q?zArL3BTw1fbpxKrplV/JLTGqCXUHv3gjC0DypAYbW28v0UQ83NA3yfbcYbwW?=
 =?us-ascii?Q?ZPihjWKmLQG/R71ulq9qjfOjyQ2TCpPQq6/gsuuQHD7Ymrlgkf1u8s89Bqbp?=
 =?us-ascii?Q?pSrBOOUktIGSXr2gDR+ep9Vipd/oTfWHdsetqXoZm79QE7BIUyqVGCB+f4pY?=
 =?us-ascii?Q?+YQqRkHQIvjBmETBeIfRoi2yz0UQoJhUqjMxO4VjysP49/14lB9r9WyQ2uJ9?=
 =?us-ascii?Q?vOgR0q5CDxZ/L3Cp1JCeGwr4/ziF1jrHCvVcmpGsC2Dr?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c68199-d335-470a-5ba3-08dad7ead839
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:47.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TVLE1zm+kfvLrNpHXLqo+jM4cnDxSAlMvu5Wnz4YEAKK619QOmi2RNSaM6NIBc0SpXaYZIkUKA1G/IgMukDn7Q==
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

No logic change to SNP/VBS guests.

hv_isolation_type_tdx() wil be used to instruct a TDX guest on Hyper-V to
do some TDX-specific operations, e.g. hv_do_hypercall() should use
__tdx_hypercall(), and a TDX guest on Hyper-V should handle the Hyper-V
Event/Message/Monitor pages specially.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---

Changes in v2:
  Added "#ifdef CONFIG_INTEL_TDX_GUEST and #endif" for
    hv_isolation_type_tdx() in arch/x86/hyperv/ivm.c.

    Simplified the changes in ms_hyperv_init_platform().

 arch/x86/hyperv/ivm.c              | 9 +++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 3 ++-
 arch/x86/include/asm/mshyperv.h    | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 7 ++++++-
 drivers/hv/hv_common.c             | 6 ++++++
 5 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 1dbcbd9da74d..13ccb52eecd7 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -269,6 +269,15 @@ bool hv_isolation_type_snp(void)
 	return static_branch_unlikely(&isolation_type_snp);
 }
 
+#ifdef CONFIG_INTEL_TDX_GUEST
+DEFINE_STATIC_KEY_FALSE(isolation_type_tdx);
+
+bool hv_isolation_type_tdx(void)
+{
+	return static_branch_unlikely(&isolation_type_tdx);
+}
+#endif
+
 /*
  * hv_mark_gpa_visibility - Set pages visible to host via hvcall.
  *
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6d9368ea3701..6c0a04d078f5 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -161,7 +161,8 @@
 enum hv_isolation_type {
 	HV_ISOLATION_TYPE_NONE	= 0,
 	HV_ISOLATION_TYPE_VBS	= 1,
-	HV_ISOLATION_TYPE_SNP	= 2
+	HV_ISOLATION_TYPE_SNP	= 2,
+	HV_ISOLATION_TYPE_TDX	= 3
 };
 
 /* Hyper-V specific model specific registers (MSRs) */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..8a2cafec4675 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -14,6 +14,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -32,6 +33,8 @@ extern u64 hv_current_partition_id;
 
 extern union hv_ghcb * __percpu *hv_ghcb_pg;
 
+extern bool hv_isolation_type_tdx(void);
+
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 46668e255421..941372449ff2 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -339,9 +339,14 @@ static void __init ms_hyperv_init_platform(void)
 		}
 		/* Isolation VMs are unenlightened SEV-based VMs, thus this check: */
 		if (IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)) {
-			if (hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE)
+			if (hv_get_isolation_type() == HV_ISOLATION_TYPE_VBS ||
+			    hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
 				cc_set_vendor(CC_VENDOR_HYPERV);
 		}
+
+		if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
+		    hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+			static_branch_enable(&isolation_type_tdx);
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ae68298c0dca..a9a03ab04b97 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -268,6 +268,12 @@ bool __weak hv_isolation_type_snp(void)
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

