Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE97869A8
	for <lists+linux-arch@lfdr.de>; Thu, 24 Aug 2023 10:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbjHXIKa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Aug 2023 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240506AbjHXIKM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Aug 2023 04:10:12 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-cusazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c111::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F411996;
        Thu, 24 Aug 2023 01:09:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHNJr2VTULa5RAoieo+EsHMB7S1v82xhpOMi7bSK1jot50SL7ZJmyT+g1qcxhN3vDikcAFc/sCu5BJyGquBhtw5SPBpstJ4WR+IRg+7TIEi4Wdti/B4bqatdt2ND+sBLPu1MUAMjkTf2jgQtL92oCMI9cJT8qlT9T5ebzP+uv7pyqu8XHWadNDiiz4k/7wdWJ0hbxiRcwnurAS+Nn1SAkjab98JUu8a36fpK6DxBTsC/8D07JLXo5fX1+48LGmlE1xG/B3IlhyGLay6UOS4a3P6fF1vtsr86jgyK0wcZ0h5XHPCMisvyiDpk3Mpt+IzV6Tt1B/ZMnp3bvhhsZNr0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sOR0U/hkfJWQyo6zXruH5ZA7YPT3OD8Z9w0mxOjzn1U=;
 b=GLHS9bBstDjU49yBlDaTccmCbaaXZ4w5ijOzAKdq5UfMCZ7qY8tdGekkiuxIXDUB3TbQYC8sUFx+bBI7Bu30orQioOocHN09/X9Ld8YTJ+pbzn9nHY1Jb/IkrJJaSlsoBvYp/+qybJJpzMPaZpB5S7F4n9RCoIbBICGYFYwuXJBAvEW5GMIC4VRnkcyfFH2a+Ax5dZYpQRJSA4VKfh3VOjOhtBj9K4PWOZAlKsD1VZKb2gkzUVPymFN+mQI3gT17IysMDSVDs1dn1OCw9UPP8BzJMYW7dgrevNbLunihxzzWtFRZxHVNgcLw5Qosh0i9ksUUeNlFTXm7WOu88O4h1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOR0U/hkfJWQyo6zXruH5ZA7YPT3OD8Z9w0mxOjzn1U=;
 b=JpmKx1dNHVoPcvDwUx8YGnXd54l4/a3Mfx+i159VmXqLOe5PpXwCZsC5PbHiF48AZxeUP4AU+7GesUso0sMJbCxD9W6D7mTmCt5Qj97IxVuBlgOpbJm4cVVRPegkruJulPDks1a/EUVp2T4nTDSvJXZb0ZxEz0IB5BV6KsqHVB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by PH8PR21MB3901.namprd21.prod.outlook.com
 (2603:10b6:510:23a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.4; Thu, 24 Aug
 2023 08:08:00 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::b3df:a8e9:52dd:dfad%5]) with mapi id 15.20.6745.006; Thu, 24 Aug 2023
 08:08:00 +0000
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
Subject: [PATCH v3 03/10] Drivers: hv: vmbus: Support fully enlightened TDX guests
Date:   Thu, 24 Aug 2023 01:07:05 -0700
Message-Id: <20230824080712.30327-4-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230824080712.30327-1-decui@microsoft.com>
References: <20230824080712.30327-1-decui@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0175.namprd15.prod.outlook.com
 (2603:10b6:930:81::20) To BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR2101MB1092:EE_|PH8PR21MB3901:EE_
X-MS-Office365-Filtering-Correlation-Id: c258cfe1-ef4c-4295-d70d-08dba4793b75
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vBOAFbLNQUly4idqJpSoThFx8ivPol/49COQD4nqTeKkj6h+g3vWUwD7dr7ZckV8y5NG17SDZVkS2s5FWMraGKojRMSQAPN3gCiHnxIlW0I6/Bz7z0VRhjuZY9v7VQPJ84rujTZdJBcp4kOUo9YcrxRyBESiItgS5e6M98GSIj1699mLrfTOBZyUz8fH6HouKmQG5uzZTEdnre10FV4KVEGB90osFh/xLFqkVg8gPRyP28Pgqif8cZQgHavivRO38GQ+NNpOGfhecb94aFpwVUf9/w6Gzu1miJwzxJGl7M0louoDKa1n8W0PMLPyE8Q71FVqlo0MZmL6HT7x6JB0gDpnaNWsi7dcC7kzGdrpvw+bnyqcptsOeQotTWUqbpeCC3qWYCKLLe5CDG7kBk2QPg2IJ4p1rw/6JJXQfK8ms/Ygx8DQ9nu8BG52dNHhPK8oHtQ2pJlqomuwOCeOVcCUn84fvNHQv1GG0vU6uY1KZUJVvV2zwT/V9lqVMxNQd2NQyonue3sunwxlse3X/TDSvK0WnzobSSIGyozHB8RAwLHEZuf4zuBKLYvIJ4nzl5GoNcHiFe6YVTGavABhXIQtjm+KbSUIsEkRXtxv6L9u2qsMbAsMBodfiF81KVvgA980nCZ0eSalsCNjSWl4WVYGBAUQF1DnNxAU8tACZNECpTuYrSzG54NI1sc+pZtVktSR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(346002)(39860400002)(136003)(451199024)(1800799009)(186009)(12101799020)(478600001)(6486002)(10290500003)(83380400001)(38100700002)(7406005)(82950400001)(921005)(2906002)(52116002)(7416002)(4326008)(1076003)(6506007)(2616005)(107886003)(6512007)(66556008)(36756003)(66476007)(86362001)(82960400001)(5660300002)(316002)(8676002)(8936002)(6636002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dghLLZb7tKANvVdO1GZs2B2j0N9vG1Zp2mnkWmCxxolG1yz5nqT42CHmg8et?=
 =?us-ascii?Q?wqPwub+rHEwZJXZU8cmRI2WvpKmCi+oNpDdwUTX/Zc3vaBmd4iKCvF2fwnT1?=
 =?us-ascii?Q?/5zTOpnKkq/ejPZNw6YpmW4pHbk4e3G1gfZ0xi0hAsZvafAzYIxhCfb4HXp2?=
 =?us-ascii?Q?1nKBEJ33IKtVlCX/4rZTnCGO0NEAYyvKGSdOlFyYAhiL7uHCrXLqg6XLnGW9?=
 =?us-ascii?Q?x2QUvW+eRBCeRkJt7v/wyxxWB4zYdmOH5MqLmYvUUlCcEhDZ2oxsf0iMhchC?=
 =?us-ascii?Q?A5k8pfn4L8GBUaBNfPgJvl5foiaB2BGWp8IOz7XOtKhnaykANqqNetv2P389?=
 =?us-ascii?Q?pWrmGt6l7lUZh6RQWVZUsyf+Am6ziYTNlalrRRflsLsB95RDJ9lzB508QX/w?=
 =?us-ascii?Q?nnQtp6W0sNExQ2KxXwtnghhflJDtM1UvKfRgkRc0xya8GD/1WJFUAyQuyEGt?=
 =?us-ascii?Q?qdRk1qsFfIf74nfsvoGTzk28o4EgFcShTN7YGWSEq6F69cNJ2+zDYElkWmhy?=
 =?us-ascii?Q?rPaFTha919VOGDXIrWAeigjIgXz0Jg8Aqt9USwy1G4JwkC3YZtqgTS9srTmI?=
 =?us-ascii?Q?J1gao3SE0ReHtoBGXsrwuSZeEpWXNr9PWkyPjJZ3hICES7r64VEfy+plQM/A?=
 =?us-ascii?Q?X5a/Z8onk+l8mNEYzJjzIlaVaBgUlCOTwT3mX2O8meMEzzywGrP2CszYuvTX?=
 =?us-ascii?Q?5hzmuiSnrUsm+HNLQHJxQ96QLr/IYF2BrFc0XfOaKNeTwhKLByRiGpLh7ohP?=
 =?us-ascii?Q?MgAUIg1Edaz3nFZnOo00KlY6vM7KyUL+Sot6qUwufkMD3Mfqe0ppcqsYTN/S?=
 =?us-ascii?Q?9CifmjntEZHBzzwNSyhIOZaV6+IukLfkfuZgI7N8q2FFwEyXR9gdIuvfC9Jo?=
 =?us-ascii?Q?ApJXBxm+tPAnyKa7yo5TX7uESRBOWK5WJh0xAmFeXNI5HB8tAdUH2ZFHdXdD?=
 =?us-ascii?Q?cAhblBAbcuTc9hM26/uKwqANwynx2d59kB927nOPEYVkqhSWEZrALkDPVBec?=
 =?us-ascii?Q?+3ut4JAcexFO2MfWpyzGuwXv+87sQHMhUESX70AvAb+3LE0At1xaBARRKtYA?=
 =?us-ascii?Q?CUG+uE5YrxkP9mdLPXF6EealZlogFSJzKPjy1hYwP/zeTmaPAUkN23VpNs79?=
 =?us-ascii?Q?TP/rwykYuQyBeil2S/k8VdG0DzUlIsSQaTSq7jufCrxQFcXcbKRoBeVDZ6wS?=
 =?us-ascii?Q?WzsL3lxDrhSkG/9dlAp+Zn86PwWh6QiZkNQ2otXaNhmbIUvKKawok+1EMMnL?=
 =?us-ascii?Q?ph7OltKxnT7ZhybZiN+QAtjGGB1TNA6sv8KpaWbivmJuo4rhvO64zmGstwDN?=
 =?us-ascii?Q?yl9RwGnVWU1061NJdrXZ09fo2oGvtsVuJSJkEC6gbjRE4mbS6dyJqDQwHs9a?=
 =?us-ascii?Q?svCHCaDnNfT4BnH1no/XT4lsm4UA18D/y8meOV+O1F6c3YScm6tJdJQG4p3y?=
 =?us-ascii?Q?QE7rE96IOQowT+xnaSndgKs1NV4sHCCjjIbdJXndSebvcOGZtxo2e00qJN0D?=
 =?us-ascii?Q?hE8dTVlBz7bDuNJUrrmJfUwdoXUdAmhnkxZhGPayMbuuU+MUvvQ+/fgNtIwr?=
 =?us-ascii?Q?iaLT7TmETZaLsKesD96ngLS2iQlxWOJYky2cmYLi/sK3fnJm2+yqvFKe+42J?=
 =?us-ascii?Q?0RFbobcwgK9Zg7jUd46w3HuUsEmTlKzZHP1UOhGPOI8z?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c258cfe1-ef4c-4295-d70d-08dba4793b75
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 08:08:00.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iJTLKFvtq8H8E9mh1ul2fEJSdSCB9h9TK4cl3tPajKMbCDh7vfA4zHmgvy2aPj4uOxg3QhAP8wIdIh2Si9uGEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3901
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Changes in v3:
  ms_hyperv_init_platform(): Removed cc_mkdec(0).
  hv_synic_alloc(), hv_synic_enable_regs():
    Removed "|= ms_hyperv.shared_gpa_boundary": No longer needed on GA Hyper-V.

 arch/x86/hyperv/hv_apic.c      | 15 ++++++++++++---
 arch/x86/hyperv/hv_init.c      | 19 +++++++++++++++----
 arch/x86/kernel/cpu/mshyperv.c | 14 ++++++++++++++
 drivers/hv/hv.c                |  9 +++++++--
 4 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 1fbda2f94184..cb7429046d18 100644
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
index 255e02ec467e..c1c1b4e1502f 100644
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
index 63093870ec33..ff3d9c5de19c 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -420,6 +420,20 @@ static void __init ms_hyperv_init_platform(void)
 				static_branch_enable(&isolation_type_en_snp);
 		} else if (hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
+
+			/* A TDX VM must use x2APIC and doesn't use lazy EOI. */
+			ms_hyperv.hints &= ~HV_X64_APIC_ACCESS_RECOMMENDED;
+
+			if (!ms_hyperv.paravisor_present) {
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
index ec6e35a0d9bf..d1064118a72f 100644
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
-- 
2.25.1

