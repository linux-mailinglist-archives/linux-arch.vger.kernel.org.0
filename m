Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97121781FCA
	for <lists+linux-arch@lfdr.de>; Sun, 20 Aug 2023 22:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjHTUdK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 20 Aug 2023 16:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjHTUdD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 20 Aug 2023 16:33:03 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F5B99;
        Sun, 20 Aug 2023 13:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1SLThxgSLRpcvKGAmvRpGy3yVQ8xpZol+PM3Fa9U+v/PcGkGG6Ag3g7mmdyA5iaCVkiq/ZwOid+8Dw6PG9i5HVE3REdkMM96HDi3NN4fHKgK0OPpJvWHrRGPP9MfaX4tJHPNL/eviUDIhkmQwVRed18KkFIWazvuztMiE8xA5miBiHnc3oI52dZx62HFAW2iexpBkx0o7Gv1u2yblOi8vu36J7ZsbfdgJFnkqiMeupz4n1QKTHYCXCJIIpL3Cl+S4IUFJIWYHMK3GqmE7QWRiBOqVClAbKNnScl0o2cyjp0bbT726EyoxvSquYG9rQCtsO9ytE9CIhTFSTvfi7fvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDrFU6441ndD8TW3ehUPzj60YK3s0Vsch0PJkARrrx4=;
 b=nLbjOrNm+a8kiUDdKf9oDfGeYzJ6IWG1SFhHBaERsRQlmIn44RxcjtbpkSVaNiBF7uR+UusXlwm1PDSZ0KZU8ttvhVwwlIzJwcj0VQQz31LcyVzHq4Zs84funN54yOYgydvEUmz4O9UaRalxIhMqZeAZ+ZCokYzcH9joB+FcXqrqb8iVteoR0jKKhn6AhMVT3ney6JKx0sCTEPiO3fKLT1+Mxeux3/gJRwkKOef6QG95P4JrqmEI4f8thT5PIf0plbyAUQdijnNTp7TUiGNvtiqhVU/Zu2LagJGCMrmg0bs+/nomHrsQTDXIKRicHxZs9ig75DMzC9GjA+cvJ2kdcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDrFU6441ndD8TW3ehUPzj60YK3s0Vsch0PJkARrrx4=;
 b=dwY7qIBsoW+4Ak2Cd15xhY/ELSZBHXQDpHUja4ZhXnBG8qektu11e5sMlLJ/uQsawtjyBhwY5OXa/n7H3BQaC4Ps1mATDFEZumaQHzR509bippfzlQfYjX01tMr23f2PdWQ+nVSJnbjRPQTi23gGRlSf61kh2dF9ACySRuUZ1QA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by MW4PR21MB2075.namprd21.prod.outlook.com
 (2603:10b6:303:122::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.3; Sun, 20 Aug
 2023 20:27:59 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.001; Sun, 20 Aug 2023
 20:27:59 +0000
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
Subject: [PATCH v2 3/9] Drivers: hv: vmbus: Support fully enlightened TDX guests
Date:   Sun, 20 Aug 2023 13:27:09 -0700
Message-Id: <20230820202715.29006-4-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230820202715.29006-1-decui@microsoft.com>
References: <20230820202715.29006-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:303:8f::10) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|MW4PR21MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d0f38d-8a46-40f6-6e52-08dba1bbf181
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6xRSAP3kl32Q29r0w/J8RB8AyA5ZnQYhifgI6rifOMPLtpSAGMSgfx5KqMCmP0f6bVXQJiIisWIzI1o1S78CA4ed37uqqSR5f8v3OSLRum93SscyaW8pQG4bgqNc9/KF5I4arfnNFI4i1epjIZRGCsqqrVRFZoivIBZKO0p9LfO8vb2z2daKbhSHFKoJKeaX9TWtXKt96YS8xPlopkGVq/TnRZXjYaTweZBJOD9e5OBHgdoKWSKjjyHUmXeQWernDJNCL4UQPSytsb9R2lEeCNfMTrlwgOtZC0jnID3v3JjdnQnsjLC3q3JHyaz/e6aTx5sE4c7ZMCxz+nFlIProO45l/U5tCBZmVHbM2IVIw/Y/lJkG1cNJ0zsQbg+FlSbemoAkQOd30gdrdrW65OYMzeJPupcbL5FgqNK8Egop68hLSA0Vw/He35MuUfatBRdTXUlhk2EKGTkCbssQ7ezLBFqCKv40E36qW8OlyAbHPCSnbGk9F3XsHjVmQRrIeJBuw2noMdhRGvWL7i8NojdbDNdLjU+gJJZtbTSkV+7HG0b3CeqDoZK52W9KPAkzKzjCFvjIaCDz6ETSbt0APx5lsl0+IJ1cbYOmYWGFM7+PUiYSIfG2lDwbBFuHHHKZdw0s6OZE/7KM7z+EUzmDLHQEBIATZ4p/26wklk/Z2Uny7ygkgK7ZzSCQN+yC4aKOSPc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(6512007)(6666004)(7416002)(7406005)(52116002)(2906002)(6506007)(6486002)(1076003)(2616005)(107886003)(86362001)(38100700002)(66946007)(66556008)(66476007)(316002)(6636002)(82960400001)(36756003)(41300700001)(478600001)(8936002)(921005)(8676002)(4326008)(82950400001)(5660300002)(10290500003)(83380400001)(12101799020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vQlf9m5JbCMrfx1RtUr9EuxwZWCoThmZu7ZhjIi0CwwHV5Osm+mR3JOurGYm?=
 =?us-ascii?Q?zm2GZdx0wrPuwD0BbrEKA1aCRukHqfS60ExQYwkvNZDDtGrtacuVpi/SqYLP?=
 =?us-ascii?Q?wgsDxY1ztLQ0X2vfQ9f9s6pUlIOp62JGjuLKqwqrJ53PYRAzHbqIsLpg7W7B?=
 =?us-ascii?Q?ffhTtrvlaXiE8OSuPw1ro8kooaust8VmHuIebjkI/3Bww0ZD9iQuvw0iy/tr?=
 =?us-ascii?Q?lR2NELfBy8UWcBWOFMVQ0Sgk0/mYngalEuDVbehzD0rQeASI65v/z9I8sW5z?=
 =?us-ascii?Q?WkmdDYyAMvlllvroZWSSPhuu/2fKTQoAZLChvL5tPRIc1N93scOn8EuK+e9V?=
 =?us-ascii?Q?3xV1gw7x4/1d8/ehXnLDeyIj9OUwUlfVsdMxozLnyHfpEKUVUYBDead1l07d?=
 =?us-ascii?Q?pNuOEMLiMbpTUhypP+CojaRICL2UrzCLuxJOXI1sdqZhkNR7Hdk4jLwJ5lGw?=
 =?us-ascii?Q?hKxuWNl/CuN1BE0prPTksZIexZtIXAJVDAEZnBn6vl6/YypwVELJejAv6t4t?=
 =?us-ascii?Q?+MQIJXX6uIQuweZeQttOgDSOL+dhMxJVaOpr7lfEhU101X3ij7+w4Kk/Dp5X?=
 =?us-ascii?Q?qrR/2V2Q17sYw0gN//phePkMx4H6QLs2/JHce9uifq45eJEQuabcGSGw3C8u?=
 =?us-ascii?Q?scm9twgg0/JISFyFSb8PvjYj6mrvTrbEmtLVkUY8mTfcvlcjRgKjqichrIO+?=
 =?us-ascii?Q?aqOPbMFvwAqEMK7HildFqk4FLk6tvRowt66el0umft2JZBB2Lr4IrocYcRPo?=
 =?us-ascii?Q?bS3PuwRGtaZxYwz2KuS7hFLwPrpiWo6k53XkGwPYfj39sS1OCJPnSvbMPtVS?=
 =?us-ascii?Q?wE/irJILVx2LBRAlF8JWIeToQ1YC5yTGMBiOsI9/zsUWKyNlYwR2+ysf87l0?=
 =?us-ascii?Q?Bsy8HZmP3wPI41sa7P2dtYb45JzGlfTxjygci0juAMOZiq0yq3noIj0o8j5E?=
 =?us-ascii?Q?Uutsr8pqwgQnzCPegywAoTsG/XNzHjqsTBiOMPFi16dKHklU9v40U+DraThz?=
 =?us-ascii?Q?pCzfrB+MTN3lW87v5rhbBOdCFk85By390pd4uhF/AXLr6CzDD0zb1CrLzB3Q?=
 =?us-ascii?Q?51kG0BBMnak/FqSXU4pL6KQYtTtYir1zzT3Wlwdov/pWD8fhQwHd7cwVRjMD?=
 =?us-ascii?Q?+xbnBdl8wH79g0fhi6PdzxWy+9y5MRuJjoc5lLOuevHTQwjGBPP3DhHyiZVj?=
 =?us-ascii?Q?tbxBe7GnjrBKCkFoQKDmZmd5c6yKWN7+oM04+bRKJm2gdVF7bqAF4LM5+qxE?=
 =?us-ascii?Q?EBo6JN6EuA0ovMLuvKzWBkPJHWc353ZwpHw6rNBeKQ+YUnm08regjYWaFEB7?=
 =?us-ascii?Q?8y9alCTu9srtyAOjccXg0EH6qjHDBBV70LXjpAHKYmqbqb9ML/riQCx6Z8gu?=
 =?us-ascii?Q?pntokWLs39iF78ibzOpbzSsEUnyymDtE9UB3diWUj/fjUP2R6/PrRGl98xWR?=
 =?us-ascii?Q?hsutARsTw3M7LWxHA+pEczvFwgwpkMNZ0eXxtz0GZYAZiCb3Wy1KXazfdcNZ?=
 =?us-ascii?Q?zr76sbWznu6mIfTVs2tjdiiiGS4di1SFxTzROM3My7TbZgpNMgilqniLi1hc?=
 =?us-ascii?Q?vqROtEP6oZrWB9IY7exhTP7e2IU//6HlMT/v8rqFEeDZLqkjjzXi2mFzmZaL?=
 =?us-ascii?Q?FKv86lBMXflw1gJHNZm8TZhWT9D1yx/WPIoWT4W5QA6w?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d0f38d-8a46-40f6-6e52-08dba1bbf181
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2023 20:27:58.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OprJQqL53mlvTGuF/gOE1f/WlfI4vNyybJbvYk5V+meyLTCaVD2qmc11vM8rVToc6DI4S/BgjNQHHoPGxx9unQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2075
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add Hyper-V specific code so that a fully enlightened TDX guest (i.e.
without the paravisor) can run on Hyper-V:
  Don't use hv_vp_assist_page. Use GHCI instead.
  Don't try to use the unsupported HV_REGISTER_CRASH_CTL.
  Don't trust (use) Hyper-V's TLB-flushing hypercalls.
  Don't use lazy EOI.
  Share the SynIC Event/Message pages with the hypervisor.
  Don't use the Hyper-V TSC page for now, because non-trivial work is
    required to share the page with the hypervisor.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2: None

 arch/x86/hyperv/hv_apic.c      | 15 ++++++++++++---
 arch/x86/hyperv/hv_init.c      | 19 +++++++++++++++----
 arch/x86/kernel/cpu/mshyperv.c | 23 +++++++++++++++++++++++
 drivers/hv/hv.c                | 17 +++++++++++++++--
 4 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 1fbda2f94184e..cb7429046d18d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -177,8 +177,11 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 	    (exclude_self && weight == 1 && cpumask_test_cpu(this_cpu, mask)))
 		return true;
 
-	if (!hv_hypercall_pg)
-		return false;
+	/* A fully enlightened TDX VM uses GHCI rather than hv_hypercall_pg. */
+	if (!hv_hypercall_pg) {
+		if (ms_hyperv.paravisor_present || !hv_isolation_type_tdx())
+			return false;
+	}
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return false;
@@ -231,9 +234,15 @@ static bool __send_ipi_one(int cpu, int vector)
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
-	if (!hv_hypercall_pg || (vp == VP_INVAL))
+	if (vp == VP_INVAL)
 		return false;
 
+	/* A fully enlightened TDX VM uses GHCI rather than hv_hypercall_pg. */
+	if (!hv_hypercall_pg) {
+		if (ms_hyperv.paravisor_present || !hv_isolation_type_tdx())
+			return false;
+	}
+
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return false;
 
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 255e02ec467eb..c1c1b4e1502f0 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -80,7 +80,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
+	struct hv_vp_assist_page **hvp;
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -90,6 +90,7 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
+	hvp = &hv_vp_assist_page[cpu];
 	if (hv_root_partition) {
 		/*
 		 * For root partition we get the hypervisor provided VP assist
@@ -442,11 +443,21 @@ void __init hyperv_init(void)
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
index e0640fe6f6b82..2282f91716100 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -419,6 +419,29 @@ static void __init ms_hyperv_init_platform(void)
 			static_branch_enable(&isolation_type_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
+
+			/* A TDX VM must use x2APIC and doesn't use lazy EOI. */
+			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+
+			if (!ms_hyperv.paravisor_present) {
+				/*
+				 * The ms_hyperv.shared_gpa_boundary_active in
+				 * a fully enlightened TDX VM is 0, but the GPAs
+				 * of the SynIC Event/Message pages and VMBus
+				 * Moniter pages in such a VM still need to be
+				 * added by this offset.
+				 */
+				ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
+
+				/* To be supported: more work is required.  */
+				ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
+
+				/* HV_REGISTER_CRASH_CTL is unsupported. */
+				ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+
+				/* Don't trust Hyper-V's TLB-flushing hypercalls. */
+				ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+			}
 		}
 	}
 
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index ec6e35a0d9bf6..28bbb354324d6 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -121,11 +121,15 @@ int hv_synic_alloc(void)
 				(void *)get_zeroed_page(GFP_ATOMIC);
 			if (hv_cpu->synic_event_page == NULL) {
 				pr_err("Unable to allocate SYNIC event page\n");
+
+				free_page((unsigned long)hv_cpu->synic_message_page);
+				hv_cpu->synic_message_page = NULL;
 				goto err;
 			}
 		}
 
-		if (hv_isolation_type_en_snp()) {
+		if (!ms_hyperv.paravisor_present &&
+		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			ret = set_memory_decrypted((unsigned long)
 				hv_cpu->synic_message_page, 1);
 			if (ret) {
@@ -174,7 +178,8 @@ void hv_synic_free(void)
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		/* It's better to leak the page if the encryption fails. */
-		if (hv_isolation_type_en_snp()) {
+		if (!ms_hyperv.paravisor_present &&
+		    (hv_isolation_type_en_snp() || hv_isolation_type_tdx())) {
 			if (hv_cpu->synic_message_page) {
 				ret = set_memory_encrypted((unsigned long)
 					hv_cpu->synic_message_page, 1);
@@ -232,6 +237,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	} else {
 		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
 			>> HV_HYP_PAGE_SHIFT;
+
+		if (hv_isolation_type_tdx())
+			simp.base_simp_gpa |= ms_hyperv.shared_gpa_boundary
+				>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
@@ -251,6 +260,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	} else {
 		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
 			>> HV_HYP_PAGE_SHIFT;
+
+		if (hv_isolation_type_tdx())
+			siefp.base_siefp_gpa |= ms_hyperv.shared_gpa_boundary
+				>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
-- 
2.25.1

