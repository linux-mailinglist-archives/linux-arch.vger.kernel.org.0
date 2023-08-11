Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10DA779A96
	for <lists+linux-arch@lfdr.de>; Sat, 12 Aug 2023 00:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjHKWUA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Aug 2023 18:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjHKWTn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Aug 2023 18:19:43 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021018.outbound.protection.outlook.com [52.101.57.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1F62112;
        Fri, 11 Aug 2023 15:19:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mZv3gRxngOaqaTIfi50YUSFat+90vXAlMO5RxjbnsPjVtWrUC9BEDEac5idFqxPVfWIcEEe2hfSPKTQ7i3cvWfdJ+CoHMAh13rdqzMF9QkIbE8P5kebjZQUM1uyVafXjT7nAgeeKpa2XEJ8nfkO8Sl6bJnjA1XTFSvzIvx10HvcNyYe/JxE7W2y6SnoQM406pICcjqNRxaecTokGrs+tNdCwKsM5cpVzlrlhU6/kynn6aYc4zQowhDxUwFGu0Eak8m0k9K0b6ZEvkePKqb50Z8OPgnqtyyGh8S0Y/l16EWb/fPwfBd/epnlh9oXONtBIpmbGe6eKSq4lWswYxgy8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9lZqK+cEA0T0J10/4vf1a6UqJ8X1i3s9TKQyPp5MvA=;
 b=W41GN0xtVDgu/YNFctIEmIQsvnWIapXDTLFxHJb73T2bOgn2xRnR0xQLMSF4iQf2xWOCpinqX/nxxCnm2wjD4GBap50qJa7Zzg+Bqdl+NBFik1a4JHLuII3EZT8Tkt23VVn4vLreZqZxN1j+bqmqCt9Hof4/z4LIGCocfQwtz4eg0Qo5fwkzABDu8r4sdp6uAfDJIGO2jBwCZK7g8SQuu80GDApYrCrIMVfuWvWr6aBOugZQlqPNaLWhBWCYIDKNdxQy6YatpcFTr7jCRiFxmabpwJ3firhjpUc4w/5Y8m3UOlxOBNNhiugKylrHmZ1w/WUKVGF59ZHCjoYGWHxe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9lZqK+cEA0T0J10/4vf1a6UqJ8X1i3s9TKQyPp5MvA=;
 b=OvQELrr5+KVy+AqK29b2tSOIGjApQKwrusEEg5Mty5q7dHx0IvmFWnvStqGKcSK0LTR6/pTt238DMNfJPDmSTIb7412/U+crdBebN4qC3cpAObdE8X5StiRqn5TUnmcz2jvHD1dNSmaGAINrSy977v9RFHH67QdBMGuzDqHoi/k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com (2603:10b6:302:4::29)
 by DM4PR21MB3417.namprd21.prod.outlook.com (2603:10b6:8:b1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.9; Fri, 11 Aug 2023 22:19:38 +0000
Received: from MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba]) by MW2PR2101MB1099.namprd21.prod.outlook.com
 ([fe80::5feb:7d06:e396:fdba%4]) with mapi id 15.20.6699.008; Fri, 11 Aug 2023
 22:19:37 +0000
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
Subject: [PATCH 3/9] Drivers: hv: vmbus: Support fully enlightened TDX guests
Date:   Fri, 11 Aug 2023 15:18:45 -0700
Message-Id: <20230811221851.10244-4-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 392147c8-6711-409a-eeac-08db9ab90ca5
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: utp+PutqGdqL+dDjryAsq4c3pYER30kgmPnvqbe9RZ6VmE+UiBmqOhN1WhSI1QqolAc5DQ9A5TcKPpY0wTkP1WKNYavXPimSDmxEntP5nD/hIei5fpMFtp5gyiVbEmsw2EtRCED3O/PTN8CuZlP4ZXqd3og/Lwy9Z0aB4GQ96xUEWtz6i4Q1ITvY4K0JMSBUm6I4e/5GfBBI0oAPFY8eAXyzTUAad+YH567fEJuXAR4mY1daJ7s+VL8SVEAMTCnDz6lPNEZ5CaCqwhUcThJYXnKx2xocaScorC/Y9wyUTqPR5/wnY183ZGrrBHzCuFIcotEBXMuAfqr3FbprWRn/fCnr/MuEW+wgpdSlTdZu/V5Ic3wB9BzMzSJ9Kifr87CTag8vC199rxsPr5wA8L8E8dVO0hP2DMVHJooOFQX9z5wFw+mvRQal66CicSGagtUCSqfvunA2uQohwAkLkmKkOy7e+j7R/gf0hT+L3mx0WrETMYW7uMo7BlH2cWi4EvL0f8gn+EIxwFfWUCZsl4iYhaKRse2Lc5o27ehLNx6Ily5568nisHmE6/TZIsLBhokrJT7/ZkLxI/Ua5dvUGJNrRvgHY5jdFekUa+blbyh58+jd3ft+xUTrq38rHfkxQc1z8pQgPDemi78UvG2g5Ovyujv4ib3f17CRSbYPAy8jRMnHSmFwHD31n+rHXRum4fC8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1099.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(376002)(396003)(1800799006)(451199021)(186006)(2906002)(12101799016)(36756003)(2616005)(86362001)(41300700001)(83380400001)(5660300002)(8676002)(8936002)(6506007)(1076003)(107886003)(6512007)(6486002)(4326008)(6636002)(316002)(52116002)(478600001)(10290500003)(66946007)(66476007)(66556008)(6666004)(921005)(7416002)(7406005)(82960400001)(82950400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5lzu9Da0q42NaSCdqmXq3nREOHWttFYBwffqNkmjZq10eg9mIWeUkydUimsS?=
 =?us-ascii?Q?Rt3mECk4hc+/1k2n5mdhEzBa1Q8wVsb+Qr4poQwZRltl2vgEmG/apybGzAuL?=
 =?us-ascii?Q?SCNha5NwIQZPg0d6bln3HeX7LxSS8bmUUXNp8ZfVvRuVKeqaHadTx/cK5+KA?=
 =?us-ascii?Q?uuTK/mh8z3hqpRNCVNtkGW/D0kZg7Wg+j6bpUhBGyOhjgvYAgx0I0K32mxAP?=
 =?us-ascii?Q?YAa5H6+xs8wZk6E15u+oGii9+R6Qr7ETShyIPsJ1bMP0psd/jcuoVI2YKFmZ?=
 =?us-ascii?Q?8SFoyn6ur0XHU5sZEJpeilDI0u9+0JThIBzjry1joSr5MFWPXgwaKE4Nf0ys?=
 =?us-ascii?Q?WTj6I6paKZdi4nfysnQEgBla3U3i32EvGS56n3zIHmVIFTLnhEbRforv1QB0?=
 =?us-ascii?Q?XfwtlZw/yQbehgUCw+NTnzebrdQq9SFZQQ+LQGQfxaoE6eszVP8dFw0TmaAQ?=
 =?us-ascii?Q?Kc8C9+carKBFbdBctFuRhwg4jWytN3eQvp/REr1gV1T4YJEDOQWYsueJlacS?=
 =?us-ascii?Q?dPR2cUZ+hpcZU/AVyj0CJZLPBl0Z66vi3X2xtB5u7amETzXCgavaNvXQTvHT?=
 =?us-ascii?Q?leUCcU2L8GWqrxplh2m8ltnUv0EttCo9Bim80XQ+iorwDveYtSvNrXs4gtHu?=
 =?us-ascii?Q?sH6AnTHFcJxf6/NCCXZo5N4PVoYvlgTr2T1Vd9VwYRkREXgEnpmOquye4D9J?=
 =?us-ascii?Q?exP+8dJl7/17q+s6wZL0DtyiIW7gag/I8vfyJ/NFEaYpjlNChc0baEQTOVh/?=
 =?us-ascii?Q?6MmGgzwCu0kPshUUwU3+KkATmgVGwKGBRb9QwF85Y/d3KMMzPv9bdg1atdx4?=
 =?us-ascii?Q?tb7wgeJCWvNevZIMHaItAUZMC+I8ILXfXhroKHUSwg3f02IADGKAn+x2YV67?=
 =?us-ascii?Q?ONTeZ85C2pihClz6Y+qRMezcwXtH7842FPLh2LdLhlEW2kXd6s8FQ6dMFsj/?=
 =?us-ascii?Q?LKygHnzl5u9Lfm+BqJjDfvgG6iyqetU6SQ2BaV3/SX0OOcxuCKz8Sv28jg7a?=
 =?us-ascii?Q?Ydp7srZO1jWdWJKyXJ1kUvHadDelck271JCIfcKLC3omPsteg9OggsJeWuxl?=
 =?us-ascii?Q?BE+1cu6UW2hpH3SQqZx6JJ5Hi7X1nGtIqPnGynBOQa0jUMUcRJ9TQC7pRmtS?=
 =?us-ascii?Q?sN5HhEBXiXzWUPLnqsqu5N97n+yox6Hstzot1j8EC0YN+flZg6ERN8PrfnDS?=
 =?us-ascii?Q?VYl5O11CpszAB1Bh2/JiOZEqk3XV2loVFZRDgWDqld1r5N0Ljof3kB8PWFCh?=
 =?us-ascii?Q?whbuc5VmaNXoL8S1mi5Y3R00V1lpRbkYhEEHHbZTPygfz8Ua12VhhF4X87MA?=
 =?us-ascii?Q?Kjt+5j5+iOFxsM1lV55iGd3Gfp8FSpV7uZ35y6anbuL0YuAuKqtcGdqqljKC?=
 =?us-ascii?Q?D2NIoXkdKBIVvrR7f5l71trbK6p8fAUSpWjeQH+VOO3cW8KFDIbXz7z/QqJi?=
 =?us-ascii?Q?nNH1BVj6xSGV24gWPp3UZ9K/HTV1oiv/iGN4r+JWzahxofL7RWeUoI+yaFyS?=
 =?us-ascii?Q?X7OaTJuI/4oxjrLcNq3GsttSXXqP7EBwqQr3aXlVIRdaDXkvPd4UZhsfJeE4?=
 =?us-ascii?Q?dd6jhDRdpeoYKysaNuu8ZsL9XmQeaJHTaD8z1yh04dJgQgaRyzIu2FwVpB4w?=
 =?us-ascii?Q?cjqZ7x2RXYk+W/W6LwTX4MN0naFi0s5xjARP+bpG7rZn?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 392147c8-6711-409a-eeac-08db9ab90ca5
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1099.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 22:19:37.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xhnx9XcWBUeexCj2PrtRmrycBAkRtGp5qkMHa6f9Jg1VR2Mo9sTgf5eSb1aJh/nNYS1m9N+dcSnjHqyUCyLFKQ==
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
index d8ea54663113c..4bcd0a6f94760 100644
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
@@ -447,11 +448,21 @@ void __init hyperv_init(void)
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
index a50fd3650ea9b..507df0f64ae18 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -420,6 +420,29 @@ static void __init ms_hyperv_init_platform(void)
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

