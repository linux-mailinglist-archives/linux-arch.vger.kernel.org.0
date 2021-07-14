Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798D63C8B00
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbhGNSiE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 14:38:04 -0400
Received: from mail-bn7nam10on2104.outbound.protection.outlook.com ([40.107.92.104]:37967
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229806AbhGNSiD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Jul 2021 14:38:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSNCcxdXhQZrt1ienDkJapAnobh/dmSbAGBRWI685pqHnTISY92L1tXi2i0TFigTC8h96R7neXrBEwJVBC1/BEqmwUb6W3CupvGWmseee5ByeTaEm1tDBMtoYb7ctjiI/C/0Af9EPod/NgooGrl6geRoY7aGdmGnq2fFtXZNN7O/1OlWqiglNeTcxLfjzDjtl2jCOL0d/Tzh7RvYRxNdKxtGC6O1KTrKrdFIq5AsjEoFs6bsnC/jiAckexspTDHmjqMLEny0JMmuV9w7S84N1JFp4xiNP2UtYRWWnsCatVwnxyB0SPuEgg8dW3G7c16Vbm0uCtN7HDSyjwvfNMmCBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psSEh10hg81LQotXaDBpWztSNJkxMlHLxULGjpz4pCE=;
 b=oUT7aPxXNDnSu7D8ggn6CVMGIOXXqQ8Tyr1f5HAkbfecePGW3slch2u94zNZuc64F1ijkwmL9un+/3V9iqE5lECmv46wBd+VfXKJtTulZE5kn1EHZ6TXTHTUV7LhaJjhmajL0xPi7OfxQT4PYMfyezxm/76HAL+BwBEqLo/69kqxtriZy5rfmoLysBhqsrzxbcpjpvAJLeGtsDhBMdjNees8ENSUlYz3JFp3W+lNQplNJ1l7m8UiceX/iuT8icB+hh+QJPpG3qxRFLfTiIOVgfuIz7Sxzsfa5PACYCl5BLTTECsPSkz9gVtk9m3iiuW78lKa1yiKLXqn8RMa4WDiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psSEh10hg81LQotXaDBpWztSNJkxMlHLxULGjpz4pCE=;
 b=BUe0vE5rtKy69zx8ZDGICUNFM2OtSSS656D9tqskIBNT4E/kBtOEEM/b4mbjCWETjBam06tnR49FzrjfUCA8BNCp8MjjaGNian0w214E/db79d4RqX8udH2A/2N9PI9E1HH8WcMAMMADZ+i/76QIAAd7eF1tzM0ilTpa9vv5dPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB1061.namprd21.prod.outlook.com (2603:10b6:4:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Wed, 14 Jul
 2021 18:35:09 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::95e7:356d:2d7d:5a89%6]) with mapi id 15.20.4352.008; Wed, 14 Jul 2021
 18:35:09 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-arch@vger.kernel.org
Subject: [PATCH v2 1/3] Drivers: hv: Make portions of Hyper-V init code be arch neutral
Date:   Wed, 14 Jul 2021 11:34:45 -0700
Message-Id: <1626287687-2045-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
References: <1626287687-2045-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.160.16) by MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend Transport; Wed, 14 Jul 2021 18:35:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18036930-856f-4b4e-36d8-08d946f61bd8
X-MS-TrafficTypeDiagnostic: DM5PR2101MB1061:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB10611230A6D85078C78B353CD7139@DM5PR2101MB1061.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZGm6Jn2ojZYDse5NxY3W6KEsEdiT6geHcAQ7j5/FnglOds7IDZ+YIWKixthsVDy6BQuibm/EJ8/iiZkvwbfXf8ptQF8f+iCRqVPBQyvP/WC+CvBl5uAEfwNiymmkddHcsmrRfDC6QZmR6ncT31WLwwrK5EuuwnvAX6b4omPdCEC5O6sUg/rO9Q/+2QsWXzB+zCtw7Y3I6IEtlLyFH/7ZEKAdiIapXFUqp074xeLbfrYFqEXdfGM0Ym7j1pZ63GAiR7Om/o6dPT8MMi9Da14rUZnDgvSiwLno7ef5TDfyiK2bVKs0ltbjN9omP9k9zOAFM4hgh7rpEzBIaOWaAKkVWfAhlV46CiiqFJ5aHLksy/xy4rJfL0n2v8tE7TDZzQ+bUxoFBM6JxyTLTk4vNYrV3nf4PWAaiUd03AbC27RinHWpIHS0KAdLfqN4N9T8XfDw8N3Rm3ax97jY++UiXfNxpZ90s20jzdNqXpYvk9h/13KwRE1oLVQghfzcCDpCquF9jubb+0Fse0huQD5fNAYvDbAckZE+Kr0ABSYpg3O4h9Pd2mQzoOMJu2XKqiKCRuT2Nix4qpOAklF61ARC0Zrc/7qo0h8p6VdGr0WMadiPzU71JQD3EmOEnyNLDC7y0tI9c72aswGqjD0nJfvf1KY4cZ1oJ3rBOnQBOiO47hEekdjGulQuCtGaEXu3RLJ+crt9kEYmn+HNGJLeIah4Jv0fcj91Z7QztcTkRPXxJt60Rhp1zMuTqMjerbHz1rRhkaA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(83380400001)(38350700002)(36756003)(6666004)(30864003)(66476007)(316002)(10290500003)(26005)(921005)(38100700002)(5660300002)(82960400001)(6486002)(7696005)(66556008)(82950400001)(2616005)(956004)(4326008)(8676002)(86362001)(186003)(52116002)(2906002)(8936002)(478600001)(7416002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oo3qYL0fN4wilIu3KUUlLgxezjwsQy6VFvuMNRigOTUbHyfVYJtpa9MKDM+j?=
 =?us-ascii?Q?uykA9hwKNoRj/pyZ6Br58BiNNE87p02XGFVhpkUXPQX0VvabDyZ6VRA2ZfRj?=
 =?us-ascii?Q?NWoQB+wiSU9nn+yoZPQdgbxzN4qfz1tUEL1qtlXiciy9jLph0lV5WkCTjoBu?=
 =?us-ascii?Q?AMMPunOED0lffxH8wGcbJupAJrgF0HxBDD4ed1eWlKEVGSo7XlC8eZtr6Y2w?=
 =?us-ascii?Q?C6JV+VUrDLszLot7SUQgMdf1SLZIuywIXdptBaxx1smmkNt12eGPAH9ypk0M?=
 =?us-ascii?Q?wJ5mxCRKNIY4l8SXRZbIYBAWG6KtfUckgSeFweibr457Owa/GbbEjWLRWWA8?=
 =?us-ascii?Q?tv8UTH+GSXSFuNP//OQe4igUJHqqbcmHY2wQgUkG2+Ml2Zq2YgPDS2Bs6Mni?=
 =?us-ascii?Q?N4uY4kqfd8WA9KjamWAQ+SbmzmYi6PQ4ecwSa/ZVRrIaea8Tv9m82+usxT8t?=
 =?us-ascii?Q?3dUtic3Bh44HDvC85wcEZxvdB+d46OCy34QUgAeBLq/lQL21YbPfjxv8QJek?=
 =?us-ascii?Q?pJH30B5wm692hx4e82TyWDJ5Q+tp1WSQUSIzADOjT1OeyCa1J4HZxTcxbJJV?=
 =?us-ascii?Q?Ad+U//i8+v8PMvwIRIEdw6oPivsFYd1YFmZUQiFBjD1de8znqrgYa1xBbqMG?=
 =?us-ascii?Q?TEvcalncJWdjFF3WgpdMxEn8odc/7ktKYwu7YbcsRFngOVBt9iX661WtnaPO?=
 =?us-ascii?Q?LSeQj9ai9WGN79sv2MXunzg3Qj8scoIQqy7rXB26SI23HY+5O8AvSyvDxI5W?=
 =?us-ascii?Q?0E/c5XpknH04ZkmZNHFT2OCpx/F6B8iOgj0Gi9cYFUQ0OfYFCbdqOs9GWCTT?=
 =?us-ascii?Q?MfQebbzoVJhoT7rA9bJKl9uGkCPNzLvorS+uKJVjds09glObFcylK3wV0KRo?=
 =?us-ascii?Q?jumQSKmKPq0Lb3iNWgMkwzpNzL5gRiEO2HH7dmPeZal1Svarf3CsHTh7hXhS?=
 =?us-ascii?Q?zG7qdrnVebnu80eOZ6FublmtcXJZgJG4Ooh8D4qMfpvmAgGjzpr/FKlutlzV?=
 =?us-ascii?Q?1xgSH3P3zuFwoXOcgp1uNgx/dTXkipRmnJzxUVGE3+zq+6PAZ46xw/167ODw?=
 =?us-ascii?Q?21VMBwQ8KdjTIyKnxdBWcjzFjt86rafY9Vo2opqW2f8Gv3IB4CK/JYdZD1pi?=
 =?us-ascii?Q?e2jKwCxxUf5oBR5aBk9av3XokeAZxc3R5wkiaw5JK7LLSX7GOQabX7ZqZFIO?=
 =?us-ascii?Q?vGYwx+MwEJ8cZkH5VBbU+FSSwfJio1ZmSHequIBUuM1MVA/LcmL9lgofLeZp?=
 =?us-ascii?Q?vaAoZUBrtJXRsG/1RyGH72yNkFipHaYLckjULtYyo+xXIXd02np6w72+bI5o?=
 =?us-ascii?Q?Uc0+r38vDwlGayUMWxtVIi3f?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18036930-856f-4b4e-36d8-08d946f61bd8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 18:35:09.3864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9P8dRt0FqEaZ0sjCXevTCT4HBwrpC2wibkcqigTGuC8+vjfEgkZzjybrVhNSyWNrsQplO4y9FkM1zi13xmAgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1061
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The code to allocate and initialize the hv_vp_index array is
architecture neutral. Similarly, the code to allocate and
populate the hypercall input and output arg pages is architecture
neutral.  Move both sets of code out from arch/x86 and into
utility functions in drivers/hv/hv_common.c that can be shared
by Hyper-V initialization on ARM64.

No functional changes. However, the allocation of the hypercall
input and output arg pages is done differently so that the
size is always the Hyper-V page size, even if not the same as
the guest page size (such as with ARM64's 64K page size).

Signed-off-by: Michael Kelley <mikelley@microsoft.com>

---
Changes in v2:
* Re-added definitions of hv_root_partition and ms_hyperv in
  arch/x86/kernel/cpu/mshyperv.c so that it will compile
  even when CONFIG_HYPERV=n. But also kept definitions in
  hv_common.c (marked as __weak) since this is really where
  they should live for sharing across architectures.  At
  some point in the future we may revisit the assumptions on
  the x86 side that lead to them being needed even when
  CONFIG_HYPERV=n.

---
 arch/x86/hyperv/hv_init.c       |  91 +++-----------------------
 arch/x86/include/asm/mshyperv.h |   4 --
 arch/x86/kernel/cpu/mshyperv.c  |   3 -
 drivers/hv/hv_common.c          | 138 ++++++++++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |  10 +++
 5 files changed, 158 insertions(+), 88 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6952e21..5cc0c0f 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -39,48 +39,17 @@
 /* Storage to save the hypercall page temporarily for hibernation */
 static void *hv_hypercall_pg_saved;
 
-u32 *hv_vp_index;
-EXPORT_SYMBOL_GPL(hv_vp_index);
-
 struct hv_vp_assist_page **hv_vp_assist_page;
 EXPORT_SYMBOL_GPL(hv_vp_assist_page);
 
-void  __percpu **hyperv_pcpu_input_arg;
-EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
-
-void  __percpu **hyperv_pcpu_output_arg;
-EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
-
-u32 hv_max_vp_index;
-EXPORT_SYMBOL_GPL(hv_max_vp_index);
-
 static int hv_cpu_init(unsigned int cpu)
 {
-	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
-	void **input_arg;
-	struct page *pg;
-
-	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
-	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ? 1 : 0);
-	if (unlikely(!pg))
-		return -ENOMEM;
-
-	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*input_arg = page_address(pg);
-	if (hv_root_partition) {
-		void **output_arg;
-
-		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*output_arg = page_address(pg + 1);
-	}
-
-	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
-
-	hv_vp_index[smp_processor_id()] = msr_vp_index;
+	int ret;
 
-	if (msr_vp_index > hv_max_vp_index)
-		hv_max_vp_index = msr_vp_index;
+	ret = hv_common_cpu_init(cpu);
+	if (ret)
+		return ret;
 
 	if (!hv_vp_assist_page)
 		return 0;
@@ -198,25 +167,8 @@ static int hv_cpu_die(unsigned int cpu)
 {
 	struct hv_reenlightenment_control re_ctrl;
 	unsigned int new_cpu;
-	unsigned long flags;
-	void **input_arg;
-	void *pg;
 
-	local_irq_save(flags);
-	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	pg = *input_arg;
-	*input_arg = NULL;
-
-	if (hv_root_partition) {
-		void **output_arg;
-
-		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
-		*output_arg = NULL;
-	}
-
-	local_irq_restore(flags);
-
-	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
+	hv_common_cpu_die(cpu);
 
 	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
 		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
@@ -368,7 +320,7 @@ void __init hyperv_init(void)
 {
 	u64 guest_id, required_msrs;
 	union hv_x64_msr_hypercall_contents hypercall_msr;
-	int cpuhp, i;
+	int cpuhp;
 
 	if (x86_hyper_type != X86_HYPER_MS_HYPERV)
 		return;
@@ -380,36 +332,14 @@ void __init hyperv_init(void)
 	if ((ms_hyperv.features & required_msrs) != required_msrs)
 		return;
 
-	/*
-	 * Allocate the per-CPU state for the hypercall input arg.
-	 * If this allocation fails, we will not be able to setup
-	 * (per-CPU) hypercall input page and thus this failure is
-	 * fatal on Hyper-V.
-	 */
-	hyperv_pcpu_input_arg = alloc_percpu(void  *);
-
-	BUG_ON(hyperv_pcpu_input_arg == NULL);
-
-	/* Allocate the per-CPU state for output arg for root */
-	if (hv_root_partition) {
-		hyperv_pcpu_output_arg = alloc_percpu(void *);
-		BUG_ON(hyperv_pcpu_output_arg == NULL);
-	}
-
-	/* Allocate percpu VP index */
-	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
-				    GFP_KERNEL);
-	if (!hv_vp_index)
+	if (hv_common_init())
 		return;
 
-	for (i = 0; i < num_possible_cpus(); i++)
-		hv_vp_index[i] = VP_INVAL;
-
 	hv_vp_assist_page = kcalloc(num_possible_cpus(),
 				    sizeof(*hv_vp_assist_page), GFP_KERNEL);
 	if (!hv_vp_assist_page) {
 		ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
-		goto free_vp_index;
+		goto common_free;
 	}
 
 	cpuhp = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "x86/hyperv_init:online",
@@ -507,9 +437,8 @@ void __init hyperv_init(void)
 free_vp_assist_page:
 	kfree(hv_vp_assist_page);
 	hv_vp_assist_page = NULL;
-free_vp_index:
-	kfree(hv_vp_index);
-	hv_vp_index = NULL;
+common_free:
+	hv_common_free();
 }
 
 /*
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 67ff0d6..adccbc20 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -36,8 +36,6 @@ static inline u64 hv_get_register(unsigned int reg)
 extern int hyperv_init_cpuhp;
 
 extern void *hv_hypercall_pg;
-extern void  __percpu  **hyperv_pcpu_input_arg;
-extern void  __percpu  **hyperv_pcpu_output_arg;
 
 extern u64 hv_current_partition_id;
 
@@ -170,8 +168,6 @@ int hyperv_fill_flush_guest_mapping_list(
 		struct hv_guest_mapping_flush_list *flush,
 		u64 start_gfn, u64 end_gfn);
 
-extern bool hv_root_partition;
-
 #ifdef CONFIG_X86_64
 void hv_apic_init(void);
 void __init hv_init_spinlocks(void);
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index cc8f177..4e78643 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -36,10 +36,7 @@
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
-EXPORT_SYMBOL_GPL(hv_root_partition);
-
 struct ms_hyperv_info ms_hyperv;
-EXPORT_SYMBOL_GPL(ms_hyperv);
 
 #if IS_ENABLED(CONFIG_HYPERV)
 static void (*vmbus_handler)(void);
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 7f42da9..e836002b 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -15,9 +15,147 @@
 #include <linux/types.h>
 #include <linux/export.h>
 #include <linux/bitfield.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 #include <asm/hyperv-tlfs.h>
 #include <asm/mshyperv.h>
 
+/*
+ * hv_root_partition and ms_hyperv are defined here with other Hyper-V
+ * specific globals so they are shared across all architectures and are
+ * built only when CONFIG_HYPERV is defined.  But on x86,
+ * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
+ * defined, and it uses these two variables.  So mark them as __weak
+ * here, allowing for an overriding definition in the module containing
+ * ms_hyperv_init_platform().
+ */
+bool __weak hv_root_partition;
+EXPORT_SYMBOL_GPL(hv_root_partition);
+
+struct ms_hyperv_info __weak ms_hyperv;
+EXPORT_SYMBOL_GPL(ms_hyperv);
+
+u32 *hv_vp_index;
+EXPORT_SYMBOL_GPL(hv_vp_index);
+
+u32 hv_max_vp_index;
+EXPORT_SYMBOL_GPL(hv_max_vp_index);
+
+void  __percpu **hyperv_pcpu_input_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
+
+void  __percpu **hyperv_pcpu_output_arg;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
+
+/*
+ * Hyper-V specific initialization and shutdown code that is
+ * common across all architectures.  Called from architecture
+ * specific initialization functions.
+ */
+
+void __init hv_common_free(void)
+{
+	kfree(hv_vp_index);
+	hv_vp_index = NULL;
+
+	free_percpu(hyperv_pcpu_output_arg);
+	hyperv_pcpu_output_arg = NULL;
+
+	free_percpu(hyperv_pcpu_input_arg);
+	hyperv_pcpu_input_arg = NULL;
+}
+
+int __init hv_common_init(void)
+{
+	int i;
+
+	/*
+	 * Allocate the per-CPU state for the hypercall input arg.
+	 * If this allocation fails, we will not be able to setup
+	 * (per-CPU) hypercall input page and thus this failure is
+	 * fatal on Hyper-V.
+	 */
+	hyperv_pcpu_input_arg = alloc_percpu(void  *);
+	BUG_ON(!hyperv_pcpu_input_arg);
+
+	/* Allocate the per-CPU state for output arg for root */
+	if (hv_root_partition) {
+		hyperv_pcpu_output_arg = alloc_percpu(void *);
+		BUG_ON(!hyperv_pcpu_output_arg);
+	}
+
+	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
+				    GFP_KERNEL);
+	if (!hv_vp_index) {
+		hv_common_free();
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < num_possible_cpus(); i++)
+		hv_vp_index[i] = VP_INVAL;
+
+	return 0;
+}
+
+/*
+ * Hyper-V specific initialization and die code for
+ * individual CPUs that is common across all architectures.
+ * Called by the CPU hotplug mechanism.
+ */
+
+int hv_common_cpu_init(unsigned int cpu)
+{
+	void **inputarg, **outputarg;
+	u64 msr_vp_index;
+	gfp_t flags;
+	int pgcount = hv_root_partition ? 2 : 1;
+
+	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
+	flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
+
+	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	*inputarg = kmalloc(pgcount * HV_HYP_PAGE_SIZE, flags);
+	if (!(*inputarg))
+		return -ENOMEM;
+
+	if (hv_root_partition) {
+		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*outputarg = (char *)(*inputarg) + HV_HYP_PAGE_SIZE;
+	}
+
+	msr_vp_index = hv_get_register(HV_REGISTER_VP_INDEX);
+
+	hv_vp_index[cpu] = msr_vp_index;
+
+	if (msr_vp_index > hv_max_vp_index)
+		hv_max_vp_index = msr_vp_index;
+
+	return 0;
+}
+
+int hv_common_cpu_die(unsigned int cpu)
+{
+	unsigned long flags;
+	void **inputarg, **outputarg;
+	void *mem;
+
+	local_irq_save(flags);
+
+	inputarg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
+	mem = *inputarg;
+	*inputarg = NULL;
+
+	if (hv_root_partition) {
+		outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
+		*outputarg = NULL;
+	}
+
+	local_irq_restore(flags);
+
+	kfree(mem);
+
+	return 0;
+}
 
 /* Bit mask of the extended capability to query: see HV_EXT_CAPABILITY_xxx */
 bool hv_query_ext_cap(u64 cap_query)
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 9a000ba..2a187fe 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -38,6 +38,9 @@ struct ms_hyperv_info {
 };
 extern struct ms_hyperv_info ms_hyperv;
 
+extern void  __percpu  **hyperv_pcpu_input_arg;
+extern void  __percpu  **hyperv_pcpu_output_arg;
+
 extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 
@@ -151,6 +154,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 extern int vmbus_interrupt;
 extern int vmbus_irq;
 
+extern bool hv_root_partition;
+
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
  * Hypervisor's notion of virtual processor ID is different from
@@ -164,6 +169,11 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 /* Sentinel value for an uninitialized entry in hv_vp_index array */
 #define VP_INVAL	U32_MAX
 
+int __init hv_common_init(void);
+void __init hv_common_free(void);
+int hv_common_cpu_init(unsigned int cpu);
+int hv_common_cpu_die(unsigned int cpu);
+
 void *hv_alloc_hyperv_page(void);
 void *hv_alloc_hyperv_zeroed_page(void);
 void hv_free_hyperv_page(unsigned long addr);
-- 
1.8.3.1

