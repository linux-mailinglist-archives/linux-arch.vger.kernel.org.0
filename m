Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39596645072
	for <lists+linux-arch@lfdr.de>; Wed,  7 Dec 2022 01:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiLGAf0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 19:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiLGAfB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 19:35:01 -0500
Received: from DM4PR02CU001-vft-obe.outbound.protection.outlook.com (mail-centralusazon11022027.outbound.protection.outlook.com [52.101.63.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3F30576;
        Tue,  6 Dec 2022 16:34:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrSuJHWZrZNjgwRSOfrmBHAuMZ56Eje+uhws3gufx5G/jEtttMxa+XZbYxLT82NKBtF9wwV7V1V7dyqLTxNMorYs9Pp44IBdRfLpjjZAxZ4Q6nQ70I5pVK6cnHM8l4lvXkkARXDtDhPPQn4h2AYW91KzofTU1ziaDtbyRqL3/iNwkNd+RYSFDybF9Twf4u84oer9MMyVxTe3q4FO0eIT3MmYhLrkunS6h3uxrYNlX4e7TfSM+W8B8i8wnF1cJxPhKlcHntZXS0iECNR8E8RjDeeqLd9Hb3Am/1sdJHJMR7nvQurcCrrVKR9j9SmjaN07TWU8xnfHJbjCUXJVG3zp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUTRmA60Vq98IDE01EHjU8BeZhqfiuuHC4LL83YbCd0=;
 b=Pxq4B/AAwGV6dkHK6eUyWjtiKicfiFWZVMw6jqzNEXx3e2B3pjl5SpQV2CFJXmNU/RvGWfos1tE2btLWIuGoghfD01MTJt/kche2/buWSx92WSSfgCyIxmGs3aKUdXW6SdzNVF6801AA7Yf0nBSjcAZeDwqShNqZRB2D3vv+dFhrXc3SBQgDIPo8iT15hKLlALjgU+3GaAu7MjeSwBichcNrKANx7tqw8hCqPN1gCAx3aCpk06n6bT6eNs4f99vOgpssw7iP1OAgMuzFH8aYwi6udQmvAYqFDTFec8DsXXQai1fye9AB+mtTF8Q6HYMwIQE/1Xz4lfhK7q01Kr8bKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUTRmA60Vq98IDE01EHjU8BeZhqfiuuHC4LL83YbCd0=;
 b=K6cCTiLkaJYyhKzF7g7kAM6yZ89O3YHeQFnWncpozgM2Ksdbvw+al6qc9oF0ImQSK6Rwpr/bNZQohq537JztK/i1ppsMbM3Z6Sp/EgvwNeAQtPVRR6THTmMgSd1DFz/0guYeeXhI4YDVs9xNp7MD4ELvfQI6qwX8HG2hqnBT9iY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 (2603:10b6:207:30::23) by CY8PR21MB3819.namprd21.prod.outlook.com
 (2603:10b6:930:51::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.4; Wed, 7 Dec
 2022 00:34:55 +0000
Received: from BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020]) by BL0PR2101MB1092.namprd21.prod.outlook.com
 ([fe80::ae03:5b1e:755c:a020%8]) with mapi id 15.20.5924.004; Wed, 7 Dec 2022
 00:34:55 +0000
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
Subject: [PATCH v2 6/6] Drivers: hv: vmbus: Support TDX guests
Date:   Tue,  6 Dec 2022 16:33:25 -0800
Message-Id: <20221207003325.21503-7-decui@microsoft.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f3fd2d9-7240-43b1-d591-08dad7eadc76
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzuZDPjUW/7oqeRfo+IBVt9A4ZuHKG/TzdMN/FWevsCXYKDWWfVSURkvYlziRrrNuq7xRtt9qAWgvr8ZYTCoS3vXecMdsBV/ADh8nPg3NRbWcNeK6UygtWfI+v3krMg1OWZBjdrjL+p9wghVUqwzzALq7vmlL6m6Jejw9hZk10T45Nu7QRlAfpRzdSihQ6+gl8fPoOU7hmv7ny6qn4Arx7P40ZiuJDapGsRrdwdbWp79sJG5nnPs063eGdyQY78cFYvxpV7NbAP96TOOQ08y08/dYuCle9TrptGo5qweRiHZGnOm0FiZKWd8yDLPAyL10aLiPNRNmXADbS4pwLWqINHXkc+AECHbnd72Nd2r/Yrh/HK/Rqdcj8h/xGg5GI2TqtYOTPeKRyS28MYq/8ApGuxsyaPQLJZ8MeK9nhJ18QyGVQa+APPduGds/KdT9GafpoGAHq1rIx6TBGdsqVqgeo9EoJ4ScgX6QSuBwgxueuPdIemvrXSXSkvy1/QQUYuMFhQJwVjfy346kob21LT0dPh6Vt5SEmkRM5YbsZfACsfEtISAc/XZbk4HQT22OliskU/S2QnYDQJi3ALzPnpAzp9BPAIx9vqqI1dxHh64sPgwId3+XYor7p53r0B4xqlqHd49gHu4f704F3ShHbG9G2GYpYSalJ6eAbq0cpNHBBagaJDT1rfWID5CQTrq/7F5f0/qCKuZCgznW8vY1HAaC70iRPHVuQmCtvoRANvJoqo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR2101MB1092.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(451199015)(1076003)(83380400001)(6512007)(2616005)(82960400001)(186003)(82950400001)(6506007)(6666004)(107886003)(52116002)(38100700002)(478600001)(6636002)(41300700001)(6486002)(2906002)(316002)(66946007)(66556008)(8676002)(4326008)(8936002)(10290500003)(86362001)(921005)(7416002)(5660300002)(36756003)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w0ih4t2fvw5FwJE8F+WwzF5vWkL/tza0Q8HaUlnrfLgLZPTwQWFvgF6P4HTO?=
 =?us-ascii?Q?HPkLyjjuHLsWAXaP1bUHr7sf3MOIQfNeab3P9Trv1dcwu+dEy9bM+++xf4lO?=
 =?us-ascii?Q?GBkUFXYh73lyBhLCTr2NpYyFCApRIMky7UVlwM/1B9r11S0EFF0m3MHb0bb2?=
 =?us-ascii?Q?hBlALkVvx5bwOJA7QdNyWq5zWTCr/2K/RMiqMfoeR0618Mmo5QrQ/pAQeIZB?=
 =?us-ascii?Q?nd7B9cflTtij5EsxOIsx6zrTVVGnp0bF1qZObkJ+D5bgkVf5fyNhtj96goAf?=
 =?us-ascii?Q?pxveawhAMfYOoNk2W1rDypcNtMxyAl+2KIKseQjO6zQy+OhbaNSJG4EoZfZa?=
 =?us-ascii?Q?dDSz+PmwkAwfk2qumXWQhnubiqjYmjRGczNpzUZgG0WWrylcggDp7k6rw0qb?=
 =?us-ascii?Q?LKzQ1r1i2rx4wIRrhF6nAmP6g681i7kn8+PZvrrC0moV1TVlkMVJEXXOfhpa?=
 =?us-ascii?Q?JtCH9BIbqXPuq7qAifu6X83VSDXsjm7KQgIB2jHb6h31CcX9XzvEbP2lN9Wj?=
 =?us-ascii?Q?nLtuv5h0Jj+U+2TJpUQQgNYC+SwT3lObkmM6pYZAyB+iYWDPEpqTqQTObpXc?=
 =?us-ascii?Q?HvoJWsTAN8YYc6CTnHlq327QhSmlCD75rA5moj/umKX19zEpOmAdJ+kGmPmt?=
 =?us-ascii?Q?3WO0Tg6ymp0wrBqWeMgqGYNkU2HrNse6DaJOQWDCLo8d1Wan/iZyXYWrAzsx?=
 =?us-ascii?Q?WUPKZCzl4FKRb4xwSJzEePhxj6Bkd+JJ1PL4ipLV0I2CZW9mn/eLKl5VTCR5?=
 =?us-ascii?Q?8VPPTv2NZPSWK1V0+hntBpkPMKPpbYAtwap9g7457kjIlEGYxrE59V9Jpxr3?=
 =?us-ascii?Q?KrdqGY2U+CZBgSd88DvNfK4Hockuqh1N//2pSdjVPDtTc8LfEZ8RrAybH6dd?=
 =?us-ascii?Q?7LBIxW4VhXnFOLtYN03VAJ617o466eFgwtoFw3SrAYwIqb0fvSVPiRuSVuoa?=
 =?us-ascii?Q?F8VOCWGfO9DkldPehpz8H1UWAdLO1C5iEm0hWSVPstKz5sCogdOw6/aA97uL?=
 =?us-ascii?Q?kL4JCIfDdCpnanl3Fk9Tyrr2zfkhRvNnlB/+sVCUVZd5Ag3NHjwfsokVRvd4?=
 =?us-ascii?Q?0V7ywAD5FoCstKNNE+IeZpX0gCWykoFmNp+xQk0WaQOlsWCSh4WhW5yix7dk?=
 =?us-ascii?Q?lmuok5klLCof1lZHARqCyMdBdW/g02v3OiKpB+1nM87Hy0VT1s8w2Y4v3oKE?=
 =?us-ascii?Q?YqyNO79nCL7C7JmOGocNJTN7GkK9ZPclxPtmYA1YLbyhiSsaezw2DRDdpKf6?=
 =?us-ascii?Q?4iWTiPD9FsZZltK9qEkoqh4K3RVJyzBvZmsLT5Ishlkauuuh3GLkO4k4PYde?=
 =?us-ascii?Q?bCQC1f04we5vf9tw3iPv4xU6J4B4ZAsuCd3YJyEjeccl72+zqm7DXN3ZzkN8?=
 =?us-ascii?Q?cMZqK3qHw0snc1MM7L4E+jGwcnTG+VDpFA1bWKq+dTHGkMyypGcYpVyr2duS?=
 =?us-ascii?Q?WH+NeS7LIrFH5o0/+rQcJMLToLZJ8NVqlkW3E7eBBwp8y9kwwNcXbksMcCIx?=
 =?us-ascii?Q?XKX1tOYQEwdZJElFOF12oaegclkZZFbOTHIn8JcRK6u/HMxPUR4y/qMDC/mF?=
 =?us-ascii?Q?Z810gdHxjtL3DnCvR+bnzvGNUROCCrT+BI9vPWKLvcAcj89nPv4EZ+HB7YHS?=
 =?us-ascii?Q?jkFAyys7wkCl9n+fo4uZmYsCSdP+9JYuiPdwOS4Q2sE9?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f3fd2d9-7240-43b1-d591-08dad7eadc76
X-MS-Exchange-CrossTenant-AuthSource: BL0PR2101MB1092.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 00:34:54.9628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wecoCl2D21A/lPARNbjeO7uylYo4Cnw0PReqeTlDzjCZX1+vQRcE592R8ql0oOrV2UfSbZ1qWTjkajMzdS4GuA==
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

Add Hyper-V specific code so that a TDX guest can run on Hyper-V:
  No need to use hv_vp_assist_page.
  Don't use the unsafe Hyper-V TSC page.
  Don't try to use HV_REGISTER_CRASH_CTL.
  Share SynIC Event/Message pages and VMBus Monitor pages with the host.
  Use pgprot_decrypted(PAGE_KERNEL_NOENC))in hv_ringbuffer_init().

Signed-off-by: Dexuan Cui <decui@microsoft.com>

Changes in v2:
  Used a new function hv_set_memory_enc_dec_needed() in
    __set_memory_enc_pgtable().
  Added the missing set_memory_encrypted() in hv_synic_free().
  
---

 arch/x86/hyperv/hv_init.c      | 19 ++++++++---
 arch/x86/hyperv/ivm.c          |  5 +++
 arch/x86/kernel/cpu/mshyperv.c | 17 +++++++++-
 arch/x86/mm/pat/set_memory.c   |  2 +-
 drivers/hv/connection.c        |  4 ++-
 drivers/hv/hv.c                | 60 +++++++++++++++++++++++++++++++++-
 drivers/hv/hv_common.c         |  6 ++++
 drivers/hv/ring_buffer.c       |  2 +-
 include/asm-generic/mshyperv.h |  2 ++
 9 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index c0ba53ad8b8e..8d7b63346194 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -77,7 +77,7 @@ static int hyperv_init_ghcb(void)
 static int hv_cpu_init(unsigned int cpu)
 {
 	union hv_vp_assist_msr_contents msr = { 0 };
-	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[cpu];
+	struct hv_vp_assist_page **hvp;
 	int ret;
 
 	ret = hv_common_cpu_init(cpu);
@@ -87,6 +87,7 @@ static int hv_cpu_init(unsigned int cpu)
 	if (!hv_vp_assist_page)
 		return 0;
 
+	hvp = &hv_vp_assist_page[cpu];
 	if (hv_root_partition) {
 		/*
 		 * For root partition we get the hypervisor provided VP assist
@@ -396,11 +397,21 @@ void __init hyperv_init(void)
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
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 07e4253b5809..4398042f10d5 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -258,6 +258,11 @@ bool hv_is_isolation_supported(void)
 	return hv_get_isolation_type() != HV_ISOLATION_TYPE_NONE;
 }
 
+bool hv_set_memory_enc_dec_needed(void)
+{
+	return hv_is_isolation_supported() && !hv_isolation_type_tdx();
+}
+
 DEFINE_STATIC_KEY_FALSE(isolation_type_snp);
 
 /*
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 941372449ff2..24569da3c1f8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -345,8 +345,23 @@ static void __init ms_hyperv_init_platform(void)
 		}
 
 		if (IS_ENABLED(CONFIG_INTEL_TDX_GUEST) &&
-		    hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX)
+		    hv_get_isolation_type() == HV_ISOLATION_TYPE_TDX) {
 			static_branch_enable(&isolation_type_tdx);
+
+			/*
+			 * The GPAs of SynIC Event/Message pages and VMBus
+			 * Moniter pages need to be added by this offset.
+			 */
+			ms_hyperv.shared_gpa_boundary = cc_mkdec(0);
+
+			/* Don't use the unsafe Hyper-V TSC page */
+			ms_hyperv.features &=
+				~HV_MSR_REFERENCE_TSC_AVAILABLE;
+
+			/* HV_REGISTER_CRASH_CTL is unsupported */
+			ms_hyperv.misc_features &=
+				 ~HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE;
+		}
 	}
 
 	if (hv_max_functions_eax >= HYPERV_CPUID_NESTED_FEATURES) {
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 2e5a045731de..5892196f8ade 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2120,7 +2120,7 @@ static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
 
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (hv_is_isolation_supported())
+	if (hv_set_memory_enc_dec_needed())
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
index 4d6480d57546..78aca415985c 100644
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
@@ -225,6 +275,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	} else {
 		simp.base_simp_gpa = virt_to_phys(hv_cpu->synic_message_page)
 			>> HV_HYP_PAGE_SHIFT;
+
+		if (hv_isolation_type_tdx())
+			simp.base_simp_gpa |= ms_hyperv.shared_gpa_boundary
+				>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIMP, simp.as_uint64);
@@ -243,6 +297,10 @@ void hv_synic_enable_regs(unsigned int cpu)
 	} else {
 		siefp.base_siefp_gpa = virt_to_phys(hv_cpu->synic_event_page)
 			>> HV_HYP_PAGE_SHIFT;
+
+		if (hv_isolation_type_tdx())
+			siefp.base_siefp_gpa |= ms_hyperv.shared_gpa_boundary
+				>> HV_HYP_PAGE_SHIFT;
 	}
 
 	hv_set_register(HV_REGISTER_SIEFP, siefp.as_uint64);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a9a03ab04b97..192dcf295dfc 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -262,6 +262,12 @@ bool __weak hv_is_isolation_supported(void)
 }
 EXPORT_SYMBOL_GPL(hv_is_isolation_supported);
 
+bool __weak hv_set_memory_enc_dec_needed(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_set_memory_enc_dec_needed);
+
 bool __weak hv_isolation_type_snp(void)
 {
 	return false;
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
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bfb9eb9d7215..b7b1b18c9854 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -262,6 +262,7 @@ bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
 bool hv_is_isolation_supported(void);
+bool hv_set_memory_enc_dec_needed(void);
 bool hv_isolation_type_snp(void);
 u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_size);
 void hyperv_cleanup(void);
@@ -274,6 +275,7 @@ static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
 static inline void hyperv_cleanup(void) {}
 static inline bool hv_is_isolation_supported(void) { return false; }
+static inline bool hv_set_memory_enc_dec_needed(void) { return false; }
 static inline enum hv_isolation_type hv_get_isolation_type(void)
 {
 	return HV_ISOLATION_TYPE_NONE;
-- 
2.25.1

