Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA2C6DBD10
	for <lists+linux-arch@lfdr.de>; Sat,  8 Apr 2023 22:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjDHUtu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 8 Apr 2023 16:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjDHUtl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Apr 2023 16:49:41 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020025.outbound.protection.outlook.com [52.101.56.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F88F8A6B;
        Sat,  8 Apr 2023 13:49:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4hyVOBZ9R0Xq03egIB+qm5NekFgkbyqUB2wQKPMpD4T3L0cd22WLDPKiWCDnn4Uck1QGr9nH7dMOm2kC0MYjuXuc7oVTAbUQrCn+SkvxxOg/b783GEPwpfnihSDAnVpsZOQtSzQmNaJqSfmSRIXzYVj+uj0Cw2sN22hJKTMcuBJZhgPkYlRe4x59qGMMwmeaVOkJ80tq6nJS0UsLxxDUzU5SrVp7LE4AGz9gTSzQZQ+HNwfOQRltWmp04ii+9IMrbTe50hok1NJtN44XWM9qb8hrpm+uYE/51T3NdCkmJ8Z5/Qe1lv7mHOYgOO+3w5wgfpQ+vvPS4mrII+qLJSIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpXPJ/kRHe0EDqAWprInMLd4/U8d1OjQTIC5kuFLCpE=;
 b=YRjX4Zdoql2woOfr7KUIeSeZJrJVBS9cTmEoV15STubGwx+FhA/mpSUy8jS244QkdEUROIL2dRnawXHo0QsX48WKYG72SsNzk4kIuQcxDcgDXQegBwu3K1kxGe+ADkytucT53Il1JAvhg3JL3e578APn4THzOA3tpA4RZzLjwtQ/44wcJxHIkwb2NPsGsKLbruteydfYXq6IqtAL0aQ1i9Q37TA9SxSlI9eS95Y1c/OsS8EUUXpJhsqxEDtry70EfqCfrchg3iLEkyPSlh+gPQh9yxtvUMptRx931e2Rk/cDHj7mdea4ZHceGL/3vtTZ+FWEQy92M/nKsXMLuy/rlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpXPJ/kRHe0EDqAWprInMLd4/U8d1OjQTIC5kuFLCpE=;
 b=Y7Z27MldmZct+u2+3RyGV5DWay8DOhgO/h+IEd/p800VwiUCqiS7uDJUKZgvzJUn97B5K3hEWWKFgXLPohNJQmIEzBCAtuD7FxpPU9Icnm3YpXJOLolnAwEJ3tnvnxkuunPRXxE6JPbL95KDRGnA5F+Bj9NoiCxOQG2Rg7uo8PM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by BYAPR21MB1336.namprd21.prod.outlook.com
 (2603:10b6:a03:115::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.1; Sat, 8 Apr
 2023 20:49:36 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::97b2:25ca:c44:9b7%6]) with mapi id 15.20.6298.017; Sat, 8 Apr 2023
 20:49:36 +0000
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
Subject: [PATCH v4 5/6] Drivers: hv: vmbus: Support TDX guests
Date:   Sat,  8 Apr 2023 13:47:58 -0700
Message-Id: <20230408204759.14902-6-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 77806ffc-93ee-404a-8bcf-08db3872c364
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j2/KWTjiA4MNBK1bcnedWW4FLWbXZCtKopeG5KTwSHafvnwTng3jD1ziNrYaka7jGtL3SlfCY/aJFYC6pdGXD6076Wn/WmTgq3kqR7mNraGQqd8JouXjQvZWdjLPwmr4GZSAuYxtcMqZzIPy+Uj13yGe9xaQFsXtRYOs2X1JVtdZff/4M6uw1avmckfpxJyfBRDyjmHnLMiar3dWvVT6ywP1+TBcQlqiAzXXrXsQuadOO/EVwRYfBdObUAmv1TVhbVp5JoZXfRGdrfTDC/epZxECtTfQpzuHdUFRlI+tUmNkaw90rkd5aIHQv90cLBIFsddC25vTBovI6J/uZI3o5jNWtSLkIZfcA0WOvGmSI6fUTs28WZ5loz4nEDGKRDDz1sDdE9DEmav4foL20tObFL31Xs/nFva1/k5LPbz6RoCrzlxJVsR0NfqhATwXIy0hjRRZ2yoai2K2/caFv0wOWjaEgZshFc+ihowAzc+rdLkOTiT71TIpB+nfQXKeSN10Ipnnx1zST/Sjuz1+R+HHE+0YpZ05cBKJyrLfcd+Wb/tU/xBhXnq+ayI1ofpvsNPHHdIjvsbgN4NbUWoycgnfgFHmI2x+ZuGrooKDw56atdK/By/SUl8wYAliHbFnmpRIk5jjry2SBkocDYCVuiyDkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199021)(786003)(66946007)(66556008)(66476007)(4326008)(478600001)(316002)(6636002)(5660300002)(7416002)(38100700002)(41300700001)(921005)(82950400001)(82960400001)(8936002)(8676002)(186003)(83380400001)(2616005)(6486002)(6666004)(52116002)(10290500003)(107886003)(6512007)(6506007)(1076003)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6+3aqubf54jT9CMHX0ZdqJ18yD5fq7a3dpJ1oEbQGkMiShsyx+Q/obM7qYk?=
 =?us-ascii?Q?fUC8/bA6y/jiw8XPV08OiCsGtvjdXi0K30+OicD2itQTV1a3bBPNCIxnMLCs?=
 =?us-ascii?Q?hCDj3bzY0GX7SHDFTzmByDIhRDTgVqOCimp/nJixt3thi187UNNFMaQb90SD?=
 =?us-ascii?Q?UCGRTMkbmJxFuticS9wLm6N9OTNQ7HeAOhLdptpWChTg4xd9/RwYKaxw6Lrh?=
 =?us-ascii?Q?oIhZCTJewsmkRd+naEDPNSihHVkVu5OD5qL+dV1HFTglYD1YBhtEcaO9PNVd?=
 =?us-ascii?Q?1jhmEq5Z0MTYx6ZTo9VRyN00U8bX0HIwoPDpyV4yGcwByGt1FRGVpScDO7lK?=
 =?us-ascii?Q?ZvbG8UAD2cVu2+IbS9/AntO+AinEdOomrzzg0g0J1xIDmf381sGL5yDDUn28?=
 =?us-ascii?Q?+jsGjfyh75kw3knmRmtA4hpBbD+2wYdf/v0X4pAkPIUOjCjHkCqXMHeiOlJz?=
 =?us-ascii?Q?XZQwvrBP1SWrquGCjNDFBvjVNg1qN4OEybtjfJahGgRtuu1fNcT4oNPBPrJZ?=
 =?us-ascii?Q?87l9ZYCSLwdVuZWoIuNWFn59V9c+phkNuDuOADqA9v/+IT9dfup61iGM0775?=
 =?us-ascii?Q?IEIQozrDUQ5KL/nX+XFdm/sAozVzGrZf/tGzbOJxfK9jxtX3wt1K9DZzY/dc?=
 =?us-ascii?Q?i4jcd89ATiW0F0i0oSQDDbu0etb4ZBzFH5VhV0r/1tXtpT21eQraYWJrFayZ?=
 =?us-ascii?Q?fSc6tye3Alqa3EeWRGXmaSkLDAcRPsO8TTO6Ior9UlardXeck5A6sqDO60MP?=
 =?us-ascii?Q?YKyNLIjP8DNvCQN3ZQNYFvT7s986VJwZRomN51Qd9DtqBWbKZ+Wl9wN2BMvq?=
 =?us-ascii?Q?w9TExezfU2A/qYJV0+hSuifX3JYJPV1PnZD6NEyE0fGm6EeNJeaCB2Ldz+IU?=
 =?us-ascii?Q?fFepglRlUoP8lZZltScFAngC6/0VL1YuJZi1BP9CUE00mgnUAQLrVVG8wCkh?=
 =?us-ascii?Q?p2XtDeJ/o1OGEMOzFxKJrqMxpqCY2pvA6Xzq1PDcXXBwLWs5X5rj2f9NexPB?=
 =?us-ascii?Q?/AO1gcx8eqzhKE9pKNaWm9+uVL57IM5oyFcyxctqz0jHeaMfsb2vzpdmibSS?=
 =?us-ascii?Q?RpeIJjVFWW49M3nYoXSvod2WwG/JA8C9xvoj/KXDMKYQmR1ceTqD64ylVjG7?=
 =?us-ascii?Q?ZLPKAbYzmxnwg/ddCNA+jYbjnrQwPN71d13SM1i8aIeMqFqgr9k7G++KZaN1?=
 =?us-ascii?Q?3dyUU6cgs0oaoXB8aBX0EcglAnSF3jyZOf6WxKzz0cUd1qGqchwkIkckNpq8?=
 =?us-ascii?Q?SPKAiNGytiE0iZFrYnUWDpJ7MO1XknpYtZzu9jzPNtcWpf5jLtJBpbxVlWID?=
 =?us-ascii?Q?doOPKsW/Qk9H3lKY097aTqYsRBwJJ997siqTPRMZTcBn1lZqg93leD2CgHY7?=
 =?us-ascii?Q?HOOPmna0/RWo3+jJvrKSd5kpGII2NwKb7OfTqkCejHzY+X0NuiSfMwU5U1vT?=
 =?us-ascii?Q?yuc4U0FialJL52WFARl1qWV4/fnmhsVmSKlpOIGPTS/32mcJ/5Gxi2RgK7De?=
 =?us-ascii?Q?+/9Ucmf364nLlyOPP1F6FnrO9JdIvuDFK/k6ZHF6kDSvQwNs6fXvAIkDzg59?=
 =?us-ascii?Q?G0nAVDDnTk42OiRlkg2NLhRLxrk6Db7BIa+kETngjpUWsRd1G9VO1BgPVtg1?=
 =?us-ascii?Q?NIY0AibpigzjvWSrSEjnG2wbjF3waO0zIOnVrovJTk8y?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77806ffc-93ee-404a-8bcf-08db3872c364
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2023 20:49:36.0075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbvDAV+ocnI4+0+Scs9GULdwm6DapBI7bJmM3b2HxE20pJGJyqVr2UoX4UTfdqs8n89vHCtB7McUhXE9pUj7nA==
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

Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
  No need to use hv_vp_assist_page.
  Don't use the unsafe Hyper-V TSC page.
  Don't try to use HV_REGISTER_CRASH_CTL.
  Don't trust Hyper-V's TLB-flushing hypercalls.
  Don't use lazy EOI.
  Share SynIC Event/Message pages and VMBus Monitor pages with the host.
  Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().

Signed-off-by: Dexuan Cui <decui@microsoft.com>
---

Changes in v2:
  Used a new function hv_set_memory_enc_dec_needed() in
    __set_memory_enc_pgtable().
  Added the missing set_memory_encrypted() in hv_synic_free().

Changes in v3:
  Use pgprot_decrypted(PAGE_KERNEL)in hv_ringbuffer_init().
  (Do not use PAGE_KERNEL_NOENC, which doesn't exist for ARM64).

  Used cc_mkdec() in hv_synic_enable_regs().

  ms_hyperv_init_platform():
    Explicitly do not use HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED.
    Explicitly do not use HV_X64_APIC_ACCESS_RECOMMENDED.

  Enabled __send_ipi_mask() and __send_ipi_one() for TDX guests.

Changes in v4:
  A minor rebase to Michael's v7 DDA patchset. I'm very happy that
    I can drop my v3 change to arch/x86/mm/pat/set_memory.c due to
    Michael's work.

 arch/x86/hyperv/hv_apic.c      |  6 ++--
 arch/x86/hyperv/hv_init.c      | 19 ++++++++---
 arch/x86/kernel/cpu/mshyperv.c | 21 +++++++++++-
 drivers/hv/hv.c                | 62 +++++++++++++++++++++++++++++++---
 4 files changed, 96 insertions(+), 12 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index fb8b2c088681a..16919c7b3196e 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -173,7 +173,8 @@ static bool __send_ipi_mask(const struct cpumask *mask, int vector,
 	    (exclude_self && weight == 1 && cpumask_test_cpu(this_cpu, mask)))
 		return true;
 
-	if (!hv_hypercall_pg)
+	/* A TDX guest doesn't use hv_hypercall_pg. */
+	if (!hv_isolation_type_tdx() && !hv_hypercall_pg)
 		return false;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
@@ -227,7 +228,8 @@ static bool __send_ipi_one(int cpu, int vector)
 
 	trace_hyperv_send_ipi_one(cpu, vector);
 
-	if (!hv_hypercall_pg || (vp == VP_INVAL))
+	/* A TDX guest doesn't use hv_hypercall_pg. */
+	if ((!hv_isolation_type_tdx() && !hv_hypercall_pg) || (vp == VP_INVAL))
 		return false;
 
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f175e0de821c3..f28357ecad7d9 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -79,7 +79,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
+	struct hv_vp_assist_page **hvp;
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -89,6 +89,7 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
+	hvp = &hv_vp_assist_page[cpu];
 	if (hv_root_partition) {
 		/*
 		 * For root partition we get the hypervisor provided VP assist
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
index a87fb934cd4b4..e9106c9d92f81 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -405,8 +405,27 @@ static void __init ms_hyperv_init_platform(void)
 
 		if (hv_get_isolation_type() == HV_ISOLATION_TYPE_SNP)
 			static_branch_enable(&isolation_type_snp);
-		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+		else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
+
+			/*
+			 * The GPAs of SynIC Event/Message pages and VMBus
+			 * Moniter pages need to be added by this offset.
+			 */
+			ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
+
+			/* Don't use the unsafe Hyper-V TSC page */
+			ms_hyperv.features &= ~HV_MSR_REFERENCE_TSC_AVAILABLE;
+
+			/* HV_REGISTER_CRASH_CTL is unsupported */
+			ms_hyperv.misc_features &= ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+
+			/* Don't trust Hyper-V's TLB-flushing hypercalls */
+			ms_hyperv.hints &= ~HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED;
+
+			/* A TDX VM must use x2APIC and doesn't use lazy EOI */
+			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 008234894d287..22ecb79d21efd 100644
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
+	int ret = -ENOMEM;
 
 	/*
 	 * First, zero all per-cpu memory areas so hv_synic_free() can
@@ -168,6 +170,30 @@ int hv_synic_alloc(void)
 			pr_err("Unable to allocate post msg page\n");
 			goto err;
 		}
+
+
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC msg page\n");
+				goto err;
+			}
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt SYNIC event page\n");
+				goto err;
+			}
+
+			ret = set_memory_decrypted(
+				(unsigned long)hv_cpu->post_msg_page, 1);
+			if (ret) {
+				pr_err("Failed to decrypt post msg page\n");
+				goto err;
+			}
+		}
 	}
 
 	return 0;
@@ -176,18 +202,42 @@ int hv_synic_alloc(void)
 	 * Any memory allocations that succeeded will be freed when
 	 * the caller cleans up by calling hv_synic_free()
 	 */
-	return -ENOMEM;
+	return ret;
 }
 
 
 void hv_synic_free(void)
 {
 	int cpu;
+	int ret;
 
 	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+		if (hv_isolation_type_tdx()) {
+			ret = set_memory_encrypted(
+				(unsigned long)hv_cpu->synic_message_page, 1);
+			if (ret) {
+				pr_err("Failed to encrypt SYNIC msg page\n");
+				continue;
+			}
+
+			ret = set_memory_encrypted(
+				(unsigned long)hv_cpu->synic_event_page, 1);
+			if (ret) {
+				pr_err("Failed to encrypt SYNIC event page\n");
+				continue;
+			}
+
+			ret = set_memory_encrypted(
+				(unsigned long)hv_cpu->post_msg_page, 1);
+			if (ret) {
+				pr_err("Failed to encrypt post msg page\n");
+				continue;
+			}
+		}
+
 		free_page((unsigned long)hv_cpu->synic_event_page);
 		free_page((unsigned long)hv_cpu->synic_message_page);
 		free_page((unsigned long)hv_cpu->post_msg_page);
@@ -225,8 +275,9 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_message_page)
 			pr_err("Fail to map synic message page.\n");
 	} else {
-		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
-			>> HV_HYP_PAGE_SHIFT;
+		simp.base_simp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_message_page)) >>
+			HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
@@ -244,8 +295,9 @@ void hv_synic_enable_regs(unsigned int cpu)
 		if (!hv_cpu->synic_event_page)
 			pr_err("Fail to map synic event page.\n");
 	} else {
-		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
-			>> HV_HYP_PAGE_SHIFT;
+		siefp.base_siefp_gpa =
+			cc_mkdec(virt_to_phys(hv_cpu->synic_event_page)) >>
+			HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
-- 
2.25.1

