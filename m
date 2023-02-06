Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0C68C6C2
	for <lists+linux-arch@lfdr.de>; Mon,  6 Feb 2023 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjBFT0s (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Feb 2023 14:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjBFT0g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Feb 2023 14:26:36 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021018.outbound.protection.outlook.com [52.101.62.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9E11C5B1;
        Mon,  6 Feb 2023 11:26:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l8vDx8m7kAwLmzBsNbPYR/2/+Y0Q/lsBp2EOPVB6Jo2IOBIP3NgIpnqChB6zkIUM81tG9zS1RfS2hv5TEX3ofo2x1msokUFwkHZw43LqFVXGnwjlp9a51495/y5qyxmVkOdXTc72NPNZJstME2eil1OKHqGGqqu1yW9TgDUZUCckwbJsqLynsE9HNhpBHTQKDCBVC3k9MXgtUZ30w48tiOplpDZhBAnt+mOwjGQM7nvEYxaU1Dh7jT5S/DFw3zUQwVF22vV5yKru9R159j8B6au1Pt8bK4SHrd3qxvHOhjOjgW676zxCAlfwPFbeFW+/WNeJsm9aEU1rBjs4MDsJWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/CdUqvKL0+3PJGL/KZKMmxA51bjOe0RjhhrsygGdaE=;
 b=Gu4PMsshBkyP0w5JH0EEc2W1RbWnwYIoYWxNtayXuXSi5vt6K05E/Iam7toZtkPzZ57rvdi1bQm7lxUsk3nDdkJ9CBp6eUMtB1RPZ2lcJnvBhN5KAe6xo5ciXds+S3s85E6zxPJZDoqo1TJFlZtMepPsLZKGPo8rMem7EChhOkM6g6SRLgEzxhY8XcvOAsrc75zBi/T3aCJd6NRXPVmwKxeAicpJZwtrHOCuiDOP52hLToHN8H/rpB0/ikbhq4wvCblx+AYX7wvKTwdDhgwf9dh2is+8d4S0VDS9hG7zdZJtR1u0lJ8heiG5yl5FdkhwAXgBo3bOwRgvyptHo2qvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MWH0PFEDFF6182D.namprd21.prod.outlook.com
 (2603:10b6:30f:fff1:0:3:0:14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3; Mon, 6 Feb
 2023 19:26:24 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::89ed:fe4d:920a:1dd5%3]) with mapi id 15.20.6086.011; Mon, 6 Feb 2023
 19:26:24 +0000
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
Subject: [PATCH v3 3/6] x86/hyperv: Add hv_isolation_type_tdx() to detect TDX guests
Date:   Mon,  6 Feb 2023 11:24:16 -0800
Message-Id: <20230206192419.24525-4-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230206192419.24525-1-decui@microsoft.com>
References: <20230206192419.24525-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0267.namprd04.prod.outlook.com
 (2603:10b6:303:88::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MWH0PFEDFF6182D:EE_
X-MS-Office365-Filtering-Correlation-Id: 3352d0d7-fadf-4957-40e4-08db087808d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMooSq8EI5XQG96AsjCMgs60IHK/CMNmp0SL/WTWdutpODOgpsgnnCbxfhz/nSmOihBl6GVbXE8BcCs0L1CCTJftR2o8HLCGZy2SOMX0zQiUh7zlnn4msVZMwHWBtO0geDEizkA/DSN2hQCn2mxjSS6BsxSaCovt6eHotQFNmpc0woMC7Uzf2iGWYr7ZhAmtX2m6ihdFqgRox3yvB4JL1GTHYSvWN4UdjPaSVTIFTzs/zSeJmI550IH6Hm64q2Y07He+D+c85WNuU8qKyCR4jioRe1rVFc/vvHFkI1JjgNLhaE+tpnDu5He5FbFzOyikuWPZfgpiA0SSTPD3u6tNJ9mJcmF9wAt/B+PVoUR3iQNR5n8WBqPhiV6/tyWCyYpu3KM9py0HNF1NN/u+3Fcp8gzSvrmRZ+R3GI2LfwSbP/n95ZKV76obYzeO36FSLDh+cQryyandv1eAIhDqR5P/i7BmqriADdTGRr4N54nCHUODHHTRO4QmnGFtpTZmPPCqH8TncobyKTBd6/U01+CdE6uKIq2G+cYRJ3CYuiZRG9x7Fh4U9vb6YgYECv7bqclyun/r7PgkaIzfFV88VS2d3j6tlSxWeds3zvcY/yKficyiV2vqcFtiGiNnn1QG5OOl7A52KyyIjmCHBTSBepefWomyNSyonKAYFRBdR3MDN/XU4nD+e8IakmdxckCQkwOI3mfFd3t3EN5c7Y1uvyKIUds2vn3iWv8t8Op3nQGu5vU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199018)(6512007)(2616005)(2906002)(107886003)(6666004)(83380400001)(316002)(6636002)(921005)(36756003)(5660300002)(10290500003)(41300700001)(8676002)(86362001)(8936002)(66476007)(4326008)(1076003)(478600001)(66946007)(7416002)(66556008)(6486002)(38100700002)(52116002)(82960400001)(82950400001)(6506007)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2c7aYzbMYGD227p/QrgGWTcD+JOrZaAjGAfb6S0jFyyic62k/sS/usppP9fq?=
 =?us-ascii?Q?zAEuQDs4EIW1swGxUe+ajGdMsdov5UvSGKDUo8/2vhok+btSMNHX2tNo0Kh8?=
 =?us-ascii?Q?FB3W2Q1X6xtipc63Hu2IATLCXRPsgKnL8SJfXO/9TAlmh9mHQQ69UlX2PKtS?=
 =?us-ascii?Q?IUvk9rTWtFIzdVY5B647SxXYIpq8BmYXQB84i5zt2RWNn6/q7niOT9esVL88?=
 =?us-ascii?Q?/DBFYkDYGPtsA7bhjrs6G1DK3arE5WLF73JNUDcMA0fbaa29UG57B/eX/eBv?=
 =?us-ascii?Q?osz/hTEn2z1UXgAVl4MBdPPtJgadvRA0HJeYDKUcRxuWn3+haDbAbUHdT+0H?=
 =?us-ascii?Q?buQ6W5wjHqBxcqdWbiodIYsSUjKAt6uaHquy1LfgY4+kCCGBoM2IrVC+ilCZ?=
 =?us-ascii?Q?uN+RAMt+O/uswGCvbmeniUu7flh0FqNPNOXHReazBhJ+yAq6w9uYtECuABWr?=
 =?us-ascii?Q?ENJsNer6Ue9zJkYsuV40ZmeTgnp4tgx+Heb64g/kwi8DDdijVb3O7QLrXFg5?=
 =?us-ascii?Q?Hx20vrQKjWfteVnKuAZliDUp/ovjdT3lRM4jyzeytfgZRmaW7FBg694jfw8D?=
 =?us-ascii?Q?aEom2+K9DdAVC+AySnrjetLlH1ts/jGj7W3eitcmhS0bhZI+KkDVq+8xxG/k?=
 =?us-ascii?Q?Dz9jUvNsYh+guZPekRYRob2fY0g1Xi9wdWaAgbikY2Lb7QtlytHsurQHiaaH?=
 =?us-ascii?Q?NB1YNG7a+L0We3RVfE3k7HcG7KMXkdzSJIGUErzsWFhoBOJNi+2VUP/OpmLj?=
 =?us-ascii?Q?kOVehPSQ23gyHEM8yeQycfYHiIOIA8qTUQrNVD6PHjuBYjj/VKvSXBgnFA/h?=
 =?us-ascii?Q?r5Zlc7iljGGR3tZgCm6qeMDr8liDXHQxvtqmYuGfP3naDRBWZscDBSoAjHAB?=
 =?us-ascii?Q?tKSCZf9pbpMVngzglUDMg4eGFVURlLPo2MEGnZjDboEdSodlZAJGkzbkJRvk?=
 =?us-ascii?Q?GOJMi3MENNp39DEZuvvagaFespkCutBodkkgiLw0D/AmjOS/KYsaPWS7CSOW?=
 =?us-ascii?Q?z3ks7ND4WMfhTQNXxFkK5TS50jzSY3ZQaFKCZR95NOLZbCJitHfqmOthdcTV?=
 =?us-ascii?Q?7WdP1+LxxcTy+MqgjWLj2bgL+YEuZmxBUfyGIkX4WtZEz3ziO0SH2g+ND9Yd?=
 =?us-ascii?Q?oxvXRS2kRZScVJyN+n09kAj00w4nl257whM+k7nu83X05LEm/GgyK9yWbUnn?=
 =?us-ascii?Q?HYT6c6kJ7u3DW3wNszDXKSln0I4eymaE18qJ785ImZts5t+7RrD6CthVelYI?=
 =?us-ascii?Q?kob3PJw9QghI6wAvDmURJA690YUu1PqzAsizjX1CifuoOL86JguQ6XANQI+F?=
 =?us-ascii?Q?w5Pf2DU4VhePc1+jBffar1IBdLnuXqr/CTlUmdfh8/aLDD/r01di7s9VKug0?=
 =?us-ascii?Q?hGvw46KzpRSYLq96c5xIkUnL7F/ZI+bJl5TPjN+P2yDxc5qSdtqbYLnkMTbJ?=
 =?us-ascii?Q?56H86s2tyJI9lTrcj0RwAZ5gXA9K2c0eAaIo3oX9ijJQqv3/WI0x+UmE6xju?=
 =?us-ascii?Q?MAcOmoVF0Ri1Y1z42t3sbe8NyTHh3Ek4ercCyvwPZq0KjChHoKkt2fuSO0se?=
 =?us-ascii?Q?TCiCnnZYwT0KsvhrE2jXLzTL4g4/Zu0cwSs0yUAY01nZhi5XjtKvHRvtLxcd?=
 =?us-ascii?Q?DOrd5bFNzRzbV8GHXUt75IFGoL6KeWx6r0Rd9nvwflYJ?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3352d0d7-fadf-4957-40e4-08db087808d3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 19:26:24.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCHzSo2L7KPgIJv96VD42d6dgBpn7bvhwG6pjAv3qXhm43VtVf4Z6C9y8K8APRNoOU1WHDX5r+FKosLB67cx4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWH0PFEDFF6182D
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

---

Changes in v2:
  Added "#ifdef CONFIG_INTEL_TDX_GUEST and #endif" for
    hv_isolation_type_tdx() in arch/x86/hyperv/ivm.c.

    Simplified the changes in ms_hyperv_init_platform().

Changes in v3:
  Added Kuppuswamy's Reviewed-by.

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
index 08e822bd7aa6..1f4a967b48c5 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -163,7 +163,8 @@
 enum hv_isolation_type {
 	HV_ISOLATION_TYPE_NONE	= 0,
 	HV_ISOLATION_TYPE_VBS	= 1,
-	HV_ISOLATION_TYPE_SNP	= 2
+	HV_ISOLATION_TYPE_SNP	= 2,
+	HV_ISOLATION_TYPE_TDX	= 3
 };
 
 /* Hyper-V specific model specific registers (MSRs) */
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 6d502f3efb0f..49bca07bbd2c 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -14,6 +14,7 @@
 union hv_ghcb;
 
 DECLARE_STATIC_KEY_FALSE(isolation_type_snp);
+DECLARE_STATIC_KEY_FALSE(isolation_type_tdx);
 
 typedef int (*hyperv_fill_flush_list_func)(
 		struct hv_guest_mapping_flush_list *flush,
@@ -30,6 +31,8 @@ extern u64 hv_current_partition_id;
 
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

