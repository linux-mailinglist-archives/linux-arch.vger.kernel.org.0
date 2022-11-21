Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5AB632D66
	for <lists+linux-arch@lfdr.de>; Mon, 21 Nov 2022 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiKUTxe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Nov 2022 14:53:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbiKUTxK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 21 Nov 2022 14:53:10 -0500
Received: from na01-obe.outbound.protection.outlook.com (mail-eastusazon11022024.outbound.protection.outlook.com [52.101.53.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401BB7EAD;
        Mon, 21 Nov 2022 11:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=akOshGiJYHNlu8O/cWNR+cs9PPEwLAq7QdJR5J+m6wilqW1+JncGt7PXOgixP0Z6Ru7So4VBEiiRtOxcxJKySX0/7v0LyPANW6TikEXfWbFVtwtThvxeR0Sw3mF2iHfHqfqbSTdd02/EH8Y9VZ4FneLKj8yt43RN4/ZnA6xektUT6Pzm1pXMUSwLUD6mhquZZ8jQx9H36tXE9phO42w3bBeCZ4GKECfbF/McPNEHtOoA1K7qutB6UyqNlMZd7L4GipRZhlqYRRNHn3nMZu0zzcRIswdW5bFWXQQKlr3TdUObqmvx3lc6K+RTgj0Ef5hKywR005Wl/iITZErDZzm0vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgYfMXk7zCZD22uzpi5M+jBRlsI28SBPGNnSrAPMfR0=;
 b=NNE6TI+0WSVdFZhelhTpnSSSOTf0kqbRmi+Uj7zVW1AjGqmB7/msa4W0PjJqns25kle1vJXNdIFs7Rit7b6LfJU/1EspjZkBMBp+QbzK8FJpIysi+CfAslT5i0vHSUM4bVwQBdQMso4GSBP7xvYJ9VdYypzO7NgjULFPru0hUlasNXwfkURICfdZwEMLsJYzCkw4UPl3V+q2MLJmNFhJ50nMadpOzF5m+K0g5XJqo7+RakrlEePb1Ad507qsu4KLTerSyg+VsUqOze6RFbHojueppP7ogVL/YaOWLEeVElTQH+upYfDAd6oU53PryiofFR7Lh4QAGeXn1ffeDd4O6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgYfMXk7zCZD22uzpi5M+jBRlsI28SBPGNnSrAPMfR0=;
 b=Uv+fOadHv1TjLM0SrCay6mOhZ+H7E8ZSyrx5tXq83fRtNtxvfePDjfiTG/I8CYcVTSckEPLwCc1X54UiCD3KTVu8r6RDGSsw2QF3K3Y0k6/xEQpU1kVpmukRobd02JHvClsB7yV2yBQInv6NI7dYabf8gFayUMzF4etlNfh5dM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BL1PR21MB3280.namprd21.prod.outlook.com
 (2603:10b6:208:398::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.2; Mon, 21 Nov
 2022 19:53:03 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%7]) with mapi id 15.20.5880.001; Mon, 21 Nov 2022
 19:53:03 +0000
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
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 6/6] Drivers: hv: vmbus: Support TDX guests
Date:   Mon, 21 Nov 2022 11:51:51 -0800
Message-Id: <20221121195151.21812-7-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121195151.21812-1-decui@microsoft.com>
References: <20221121195151.21812-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::32) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|BL1PR21MB3280:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a5fc50-3c0d-43ad-8274-08dacbfa0031
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XPhqZNnog6EHNh6//PITMQXTLouygSgnMlRUZghJSZKe4CN/ksOCu5MAHo1woJUSMPLRCrM/VcxDPhdtS6xd2PLKZIpeegyyBZFMvHEUtilB9TwBXqTi2hT7hfTAmgDD/JJNmRtYn6Wz0ZZocllI6QhnJsbf5ntDQdGRWo7NL4XLeLrbYAHpoRzgxbAPUygHy272qJUsgNoZhiWQp+d8FbdunjG/4q/4iU73VckxAJoHc5SMwuJYMridsp0gyiZXiLpcuNVqnRFM7IKtUOzQCcx0lJrPJ7exk4hu2nTCnA1D8I2M/EeLVqbeyAJE9x5XMOszvZch56WaclbE3+W0+OwuwyFG59sqMrTt5+uHL1yrcUCWSF+cRqOx+gDHUPFkEWyz9SWxYLsWfD0qAX2TVf/peXSmFfASYAjPAl8nfKp4zG5oogw5R+q+DoaZf1XYmvgc813G+CKdophIbXgMa3C9XXBRriN934oXWB3XGh/xhhuVvQWI5r82+nIYrhUDvMsvFSNSOVSMLVD6/Ixn5CXOcAbSA3eigYmEhmHpjT9HONHWK5dW5C5rOKynDvx+kmMMbBaPz98plL6+qdFJPueXpR/5RRDJYtNOd0NQoONpnl3+zo7whk+YavswKzWrCDlkW+R0v4xzkRSbitCTR5ao/hWEhDUsdk1sXAn9KvSRHlvsnWn+HxvtPNUNPRYPNsaOieUFtfqv4zWZcstiQ6vxE6F7ldLP7cq28zxfhz8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(451199015)(83380400001)(2906002)(7416002)(5660300002)(8936002)(2616005)(186003)(1076003)(36756003)(86362001)(41300700001)(82950400001)(38100700002)(921005)(82960400001)(6666004)(10290500003)(107886003)(6506007)(52116002)(6512007)(316002)(478600001)(66556008)(8676002)(66946007)(66476007)(6486002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rTMVx7+DCPnjJ4Ib3HojHSjYQEV8ohuGDlvGAL6WC+mBDIB/Oy5VyFYnvRQf?=
 =?us-ascii?Q?qaiRSRphIEZ1AflikRrgzJrCLQu+Fwcm5H7ZuSP34LvwC9xAvQ5LEM4prrtL?=
 =?us-ascii?Q?4Qtsgmlkqp44JRZjDiWaLXNsgy9JoGR5NaJN1jL1u6pCuPCuhlQva8tlV0jB?=
 =?us-ascii?Q?129aP/m9T+CFqMD2PzNzWW5uGcaF0AM0dxf3KLSYJv5o4BGb1bl/sbUhxort?=
 =?us-ascii?Q?9e95U+Vaj+XUywxgqLYGm7/K93lvszBFPhbelgkf7hYA9qkZNfHkPV9XFeHq?=
 =?us-ascii?Q?ml1fvtD56+OoAHQHO9fiMR5d+DTEYx/BKYXYCMcKuevik4frNOOLCC03Foh8?=
 =?us-ascii?Q?wifY5s3a2r33JFshOjUStvnVfEwDMHy2v+8IufeSXx11hWUZeW4HDWI52/Os?=
 =?us-ascii?Q?j9ydwigkRfaCOL946HEV+z/tvkq9VMHMuAWa7es6JXp+M1iiBHdlgBE86ZHu?=
 =?us-ascii?Q?jtNhaSCSlwBe3rvs1RY5/YBclUVeDwss86bl9TH2DFe8ZuEmzZ7ApwAxdcOk?=
 =?us-ascii?Q?E6DD8HEv2MhvfC6dOT/eAwRCgdVVqks0whalpOpps00s8DrgYSdIjwUtMug2?=
 =?us-ascii?Q?CJmbbccAl24twVMNpL+GAe7PfRoTgit2OcaGIm6uCDN5o+X/s7Zp+9KwuzAJ?=
 =?us-ascii?Q?kcj7yLDxZg8nxvWD0UdGfvsUroY++rXF3uVPanlgKXo3DdwM1/xYmv/jhj+8?=
 =?us-ascii?Q?vh00AhhwPfnHJADVhHjSWXKIOWvXXSuE6noTvSYzfik8H9ZF2yLN6j8kyjHM?=
 =?us-ascii?Q?bnkWLEeHxLVKmt3xeDQoH1SRYXED33RnoY+Q/rk7z1r2lXFsjrgW1mgexl0q?=
 =?us-ascii?Q?V5AZfPxg5iGE9wiVuRaoa2TOCqynOljyt/2tbnQeSiDHQTlVGT/c9PutH2Ar?=
 =?us-ascii?Q?KVNGbhnN+QESDJTgJcuTgmSVZx24cQp1oclR1ewI0RF8SvarHJSXBIyhDb2r?=
 =?us-ascii?Q?cMh8JAGVQznNcYe40VlCNR+Vz03Wyi/0D4zM0V8Kwj70lVvY8WfzFjgBGd63?=
 =?us-ascii?Q?XGa+DyxEOu2N/STzPMVguf/zL9xH4ODgQ9EtnEI0YImdpOLC5EnJa01L538j?=
 =?us-ascii?Q?EqPw//6JPQlf9M2s/Jkb2N4adoCARzWjNfORPkrIOwFTlyKE+9MPfbN7lrfj?=
 =?us-ascii?Q?U55mS/RVHc0ZSj0s+KP2AeyvHqcwkObRXhdKEQAZLorUfPNa7rsnqHYkOEeT?=
 =?us-ascii?Q?75v1BRQ7HaJ3V44kShZMqCBDLlPWvvA7D+Gqg4plvaNmZBbiQW63eXWctKJ8?=
 =?us-ascii?Q?kx6YTxs41Pd1vrsTp8lKy8k+Y1i9zg9GdbCtCV5M8UpmpTwXu8yVOVRK9cf0?=
 =?us-ascii?Q?td29XU0tNqPFrYqmL4XxCrAvjpc9faOk3A4vexNVy4gp8FcFjtrZ6EYZPhYX?=
 =?us-ascii?Q?gts8bYkhK7xxJ64VrNKUgio9ccHFSNdXNT2W8Lq1nHaPZ9dXWQJR2l8WkeW4?=
 =?us-ascii?Q?jB9cU8zTEkZq0t2KZ+9ZvUFb6xu30y9FWP3IumOUdxjk9B0AUZruKKslN20/?=
 =?us-ascii?Q?bpOBGEoRHeg5Z2mxfaXyYhVyiAbHV/44IMvfBbGHGDXKqZlUTwEuhMC4/Psv?=
 =?us-ascii?Q?FcRaib/XOiY7v3zUt6lKhGuzQ4AURbpQqe0TQ6pFLvXnOYG4jspfRdHvRVyt?=
 =?us-ascii?Q?oHzZu8y5cQc/3zNiu+ervyCy/SJX6wPe4vx7iMqI04cF?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a5fc50-3c0d-43ad-8274-08dacbfa0031
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 19:53:03.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rjY8z7ouiBCGXNuZqjA2IV7ZSwTtccqr/LF3oMryUpGf5IZ5x9HAUW1Lq+5JsabUyK/RH6D4OiYxUG/udhv2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR21MB3280
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Intel folks added the generic code to support a TDX guest in April, 2022.
This commit and some earlier commits from me add the Hyper-V specific
code so that a TDX guest can run on Hyper-V.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 19 +++++++++++++++----
 arch/x86/kernel/cpu/mshyperv.c | 10 ++++++++++
 arch/x86/mm/pat/set_memory.c   |  2 +-
 drivers/hv/connection.c        |  4 +++-
 drivers/hv/hv.c                | 25 +++++++++++++++++++++++++
 drivers/hv/ring_buffer.c       |  2 +-
 6 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 05682c4e327f..694f7fb04e5d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
+	struct hv_vp_assist_page **hvp;
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -87,6 +87,7 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
+	hvp = &hv_vp_assist_page[smp_processor_id()];
 	if (!*hvp) {
 		if (hv_root_partition) {
 			/*
@@ -398,11 +399,21 @@ void __init hyperv_init(void)
 	if (hv_common_init())
 		return;
 
-	hv_vp_assist_page = kcalloc(num_possible_cpus(),
-				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
+	/*
+	 * The VP assist page is useless to a TDX guest: the only use we
+	 * would have for it is lazy EOI, which can not be used with TDX.
+	 */
+	if (hv_isolation_type_tdx())
+		hv_vp_assist_page = NULL;
+	else
+		hv_vp_assist_page = kcalloc(num_possible_cpus(),
+					    sizeof(*hv_vp_assist_page),
+					    GFP_KERNEL);
 	if (!hv_vp_assist_page) {
 		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-		goto common_free;
+
+		if (!hv_isolation_type_tdx())
+			goto common_free;
 	}
 
 	if (hv_isolation_type_snp()) {
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index dddccdbc5526..6f597b23ad3e 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -350,7 +350,17 @@ static void __init ms_hyperv_init_platform(void)
 			case HV_ISOLATION_TYPE_TDX:
 				static_branch_enable(&isolation_type_tdx);
 
+				cc_set_vendor(CC_VENDOR_INTEL);
+
 				ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
+
+				/* Don't use the unsafe Hyper-V TSC page */
+				ms_hyperv.features &=
+					~HV_MSR_REFERENCE_TSC_AVAILABLE;
+
+				/* HV_REGISTER_CRASH_CTL is unsupported */
+				ms_hyperv.misc_features &=
+					~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
 				break;
 
 			default:
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2e5a045731de..bb44aaddb230 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2120,7 +2120,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (hv_is_isolation_supported())
+	if (hv_is_isolation_supported() && !hv_isolation_type_tdx())
 		return hv_set_mem_host_visibility(addr, numpages, !enc);
 
 	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9dc27e5d367a..1ecc3c29e3f7 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -250,12 +250,14 @@ int vmbus_connect(void)
 		 * Isolation VM with AMD SNP needs to access monitor page via
 		 * address space above shared gpa boundary.
 		 */
-		if (hv_isolation_type_snp()) {
+		if (hv_isolation_type_snp() || hv_isolation_type_tdx()) {
 			vmbus_connection.monitor_pages_pa[0] +=
 				ms_hyperv.shared_gpa_boundary;
 			vmbus_connection.monitor_pages_pa[1] +=
 				ms_hyperv.shared_gpa_boundary;
+		}
 
+		if (hv_isolation_type_snp()) {
 			vmbus_connection.monitor_pages[0]
 				= memremap(vmbus_connection.monitor_pages_pa[0],
 					   HV_HYP_PAGE_SIZE,
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4d6480d57546..03b3257bc1ab 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -18,6 +18,7 @@
 #include <linux/clockchips.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/set_memory.h>
 #include <clocksource/hyperv_timer.h>
 #include <asm/mshyperv.h>
 #include "hyperv_vmbus.h"
@@ -119,6 +120,7 @@ int hv_synic_alloc(void)
 {
 	int cpu;
 	struct hv_per_cpu_context *hv_cpu;
+	int ret;
 
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -168,6 +170,21 @@ int hv_synic_alloc(void)
 			pr_err("Unable to allocate post msg page\n");
 			goto err;
 		}
+
+
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			BUG_ON(ret);
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			BUG_ON(ret);
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->post_msg_page, 1);
+			BUG_ON(ret);
+		}
 	}
 
 	return 0;
@@ -225,6 +242,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	} else {
 		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
 			>> HV_HYP_PAGE_SHIFT;
+
+		if (hv_isolation_type_tdx())
+			simp.base_simp_gpa += ms_hyperv.shared_gpa_boundary
+				>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
@@ -243,6 +264,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	} else {
 		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
 			>> HV_HYP_PAGE_SHIFT;
+
+		if (hv_isolation_type_tdx())
+			siefp.base_siefp_gpa += ms_hyperv.shared_gpa_boundary
+				>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index c6692fd5ab15..a51da82316ce 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -233,7 +233,7 @@ int hv_ringbuffer_init(struct hv_ring_buffer_info *ring_info,
 
 		ring_info->ring_buffer = (struct hv_ring_buffer *)
 			vmap(pages_wraparound, page_cnt * 2 - 1, VM_MAP,
-				PAGE_KERNEL);
+				pgprot_decrypted(PAGE_KERNEL_NOENC));
 
 		kfree(pages_wraparound);
 		if (!ring_info->ring_buffer)
-- 
2.25.1

