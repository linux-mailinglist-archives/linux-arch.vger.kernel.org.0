Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FD1306516
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhA0U0T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 15:26:19 -0500
Received: from mail-bn7nam10on2103.outbound.protection.outlook.com ([40.107.92.103]:44481
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232802AbhA0UZq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 15:25:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQ5RYO0k1QBwsLWsm1Pc4XuvQNMHWWMIa8NcZN34ETn+8NQr98yvCrixKmDQBwV+nDhAdr5wPtUNTjXTrKm72lWru53vXYrgXflAmSofoRNQVouxtnCaTYqhKOfzmNiFjra2zzvFvW/Lj/TRu2yhIku3maWWbvCN/QGnVweIMDh+cgjEjurxoKRRPH+fupvZCxdTX9qmGy8xu6RkeTcPK3FYVY94tWl2nNt3zF92jCRu2ztLmiijXazb07nOV9NrbVnjWsK/78a+2vCu3UVqTrKb4BrepqJcvUZLjZQfVSyX9Y6fsq0DTbbG3omDb/RmZpMWFqpTRovn5bu0DFAU4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45vkY94gFbnhEFAYv3fO7hYMNp362IV8YhXZQG3CmT4=;
 b=FVURqkzqZPaKoNZk0gdwhUX0xN6BzQy5HzblnwwlM7S0bbsP1IeJrttvaBKO93ocZJVHTsAjPZBPvin+XmQUo+RCMRTVEFYQkwU/0f0kdHmN3oumfAeYpaDoXdBboAFRi94RURBWW9BD+2sMZI/YyeUJW57d2wolkHNfxX7URslfzJNfPxy+/na3nUDPIwr91b30Lc+RdjQoo3Ebf5IQtUf7fGakBpkcq2YGhO4GZGxL/5pVPdHu4C/qFw/Rk2N6TPBACxLY3hxDmGYYdQPF8h+jBtpECHna879GLO7VZkgad6zDFkehrI2QJecgfdxFjC2vU2yhPo3tlodTnxiJrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45vkY94gFbnhEFAYv3fO7hYMNp362IV8YhXZQG3CmT4=;
 b=UFQHjMg1cu4WsBPDAwVGL+Yl8BREBl+wtRpZIYMYOSi8leJ+x/PqlLUv3rkX7705gGwdCeokUiIeEclEqZz1Pl0MfnvqgBvbdv82HuUDetCygi+goIQ4+W1UMWRWmZBy7lPfJY8kzBeSVxwWYPBPLPl1WPHM7KjMxGZs5Eyil8U=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from (2603:10b6:208:3a::13) by
 MN2PR21MB1215.namprd21.prod.outlook.com (2603:10b6:208:3a::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.6; Wed, 27 Jan 2021 20:24:23 +0000
Received: from MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05]) by MN2PR21MB1213.namprd21.prod.outlook.com
 ([fe80::91f:e9a:5737:3a05%9]) with mapi id 15.20.3825.006; Wed, 27 Jan 2021
 20:24:23 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH 04/10] Drivers: hv: vmbus: Move hyperv_report_panic_msg to arch neutral code
Date:   Wed, 27 Jan 2021 12:23:39 -0800
Message-Id: <1611779025-21503-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
References: <1611779025-21503-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.174.144]
X-ClientProxiedBy: MW4PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:303:8c::24) To MN2PR21MB1213.namprd21.prod.outlook.com
 (2603:10b6:208:3a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.174.144) by MW4PR03CA0139.namprd03.prod.outlook.com (2603:10b6:303:8c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 20:24:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ce091186-1b8d-4e8b-20fa-08d8c30188ae
X-MS-TrafficTypeDiagnostic: MN2PR21MB1215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR21MB121563EE65123AD76BB09174D7BB9@MN2PR21MB1215.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXwHA5BE0OWKl3Jxs49Se3/mDcY2WkMgHoKHfdqjwajPOOtdu6G3GR1blBvap4fpMawoayxf8NK2SlvXeXJYCmWdDnqfkdnuqFd7rf6IwvjhdDjba2MhsnYYLodn24tBs6ojUnVyRqY+bDtKkLhhHdOTl/P85BLlzptScvlET7KlnUNxNkSMwPUqfDo4BtBwgDFwPyIlocS/2fB2krWhvnl9V8UFy6xkqvClJN3C4VxB7oeP8uM+d4eSyYNI6AwYD6UoLGeabbHROpx83OzOf/hIXOxWoyYiUhkXPlueMWoy+m9uWJLGU1sKcgyEcLSNwPjCE3jlbnwJD/dhfgCdRRW4Bab0O8kZxkLHG2it7mqoZsI4ubTPJwExQGRJIs4r3dA+84TTydwhG2iZp1+S5nMW6mYM3FMyY7UU/luRyMGgb5v/9cwwTVycua9trdtOF3kiRVdKhhpIJ55gVuCZXKZ2rzewMNFwZLUagw45ZrS13B9PUIcLz3QMbQQ0tFNij2TRKX8fMBM5uEvriheeD2iTlJaHNLERgRkfbqLVs1FhHWdlzCXf54KsNwzcPC+n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR21MB1213.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(366004)(39860400002)(376002)(6666004)(66476007)(66946007)(956004)(26005)(66556008)(478600001)(921005)(8676002)(5660300002)(316002)(2906002)(86362001)(83380400001)(8936002)(186003)(36756003)(82960400001)(16526019)(4326008)(2616005)(6486002)(7416002)(10290500003)(82950400001)(52116002)(7696005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?qq1CNOM7Zn2bBBq1C032wgansHK4uAMQqqCXR7/Ea5Z30NLv97cL/w0q06Tb?=
 =?us-ascii?Q?w7sK+l91sl8nkzGlBpUo8KMExTYlN0YyoZQFWcXgrqL3dN3v8uXyWlIXAkrE?=
 =?us-ascii?Q?zgd/jXOUzlfiLLp/7V+OoxQ7vX7MY2+bG8P758eCecu0AXPfEh2CbmNbFCiD?=
 =?us-ascii?Q?O4zP/OtflbYaqH6dB4rKPNAkyMNVPRwDg80Ye+ukEDlCH7392cqxYca033OV?=
 =?us-ascii?Q?UNr2vsQ4Oe2oHF2yQGf+xpSlnABTk9ILyR7mW5twFQBeCo/s8YCEBER1j8TY?=
 =?us-ascii?Q?UFPiMhmrVy2EU65FguQppU7Aen+sPYs3IxFSDZJPJP3vFLR7LLSCbjaRcnb9?=
 =?us-ascii?Q?uOn4+rBQ8cz4jugozXc3RHbudag2Hexv6urgyxUqBui/UNeDHoJJx7NWfzE0?=
 =?us-ascii?Q?Y2nf8gHaoDKyNb5uCzODAT22X8BO7FPSu3wwSbo8jStyyyWh3S4edZqBBSAV?=
 =?us-ascii?Q?UZhUJbqvQqLinAsUjOgs4jElVT6H+YvLOmLoDhJjE9ewPk/4jMaDMKvnLmay?=
 =?us-ascii?Q?xaEE+BoPoxDne1rTi/ZAtpGC1TVzxHngxK5Fbf4bZvjAqHMq8dUtYO8nH1Dv?=
 =?us-ascii?Q?3Ht8AubLwkXxZ5lYhLTTB/jnI4zzTb8x4xYEBXGj2rik2I6HMD+zIuSRrTai?=
 =?us-ascii?Q?cSBr3t5f7rYrNHGfrfxoAwr1F7lKn/NJbAhKjfHoiGO6sW0VReA6fwF26DMe?=
 =?us-ascii?Q?XdjoQ8ne9wUEg2Xi/8UmprpN5jseFNkKHgyw6KQ4ASetzZ/6gwojGvngttCG?=
 =?us-ascii?Q?bPmcu+bpC2lTrd93shgLqMY2BkR4tU6Y+6kFcofXia2r3hffspMgXVbllShh?=
 =?us-ascii?Q?CxutSCbqSs67wuzgCHJUKxPVndDa851cMkhM0k0TWUdyRwxjLPR0Q34UcdSc?=
 =?us-ascii?Q?kC9R2VdwlglwEJpTA41Hj+n8zNk+Dt81CY7R/Mfwp0C0MNk6WjZcB6nlDmce?=
 =?us-ascii?Q?2qBGoU3q8maPUmQ5UxEbkv/asfdQrNNN1WwzsYcUh5VZ8qoDQgjMBjecysfg?=
 =?us-ascii?Q?Fjbt1MrMJFNunTIzuB2a01a7aZWMt6frH1DbasqX+SF0DkeL/myfr1wX3fmL?=
 =?us-ascii?Q?vjjNcq+e?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce091186-1b8d-4e8b-20fa-08d8c30188ae
X-MS-Exchange-CrossTenant-AuthSource: MN2PR21MB1213.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 20:24:23.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGKLuCl64CGpMUrWFxsoFF+kLnSl9S4y/2vzl/DrgBKamU7fQp/M7SUxL9ObEGXScaHPhfltY7xSm4XoS6Uzeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1215
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the new Hyper-V MSR set function, hyperv_report_panic_msg() can be
architecture neutral, so move it out from under arch/x86 and merge into
hv_kmsg_dump(). This move also avoids needing a separate implementation
under arch/arm64.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c      | 27 ---------------------------
 drivers/hv/vmbus_drv.c         | 24 +++++++++++++++++++-----
 include/asm-generic/mshyperv.h |  1 -
 3 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 9b2cdbe..22e9557 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -452,33 +452,6 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
 }
 EXPORT_SYMBOL_GPL(hyperv_report_panic);
 
-/**
- * hyperv_report_panic_msg - report panic message to Hyper-V
- * @pa: physical address of the panic page containing the message
- * @size: size of the message in the page
- */
-void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
-{
-	/*
-	 * P3 to contain the physical address of the panic page & P4 to
-	 * contain the size of the panic data in that page. Rest of the
-	 * registers are no-op when the NOTIFY_MSG flag is set.
-	 */
-	wrmsrl(HV_X64_MSR_CRASH_P0, 0);
-	wrmsrl(HV_X64_MSR_CRASH_P1, 0);
-	wrmsrl(HV_X64_MSR_CRASH_P2, 0);
-	wrmsrl(HV_X64_MSR_CRASH_P3, pa);
-	wrmsrl(HV_X64_MSR_CRASH_P4, size);
-
-	/*
-	 * Let Hyper-V know there is crash data available along with
-	 * the panic message.
-	 */
-	wrmsrl(HV_X64_MSR_CRASH_CTL,
-	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
-}
-EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
-
 bool hv_is_hyperv_initialized(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 089f165..8affe68 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1365,22 +1365,36 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
 			 enum kmsg_dump_reason reason)
 {
 	size_t bytes_written;
-	phys_addr_t panic_pa;
 
 	/* We are only interested in panics. */
 	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
 		return;
 
-	panic_pa = virt_to_phys(hv_panic_page);
-
 	/*
 	 * Write dump contents to the page. No need to synchronize; panic should
 	 * be single-threaded.
 	 */
 	kmsg_dump_get_buffer(dumper, false, hv_panic_page, HV_HYP_PAGE_SIZE,
 			     &bytes_written);
-	if (bytes_written)
-		hyperv_report_panic_msg(panic_pa, bytes_written);
+	if (!bytes_written)
+		return;
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	hv_set_register(HV_REGISTER_CRASH_P0, 0);
+	hv_set_register(HV_REGISTER_CRASH_P1, 0);
+	hv_set_register(HV_REGISTER_CRASH_P2, 0);
+	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
+	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	hv_set_register(HV_REGISTER_CRASH_CTL,
+	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
 }
 
 static struct kmsg_dumper hv_kmsg_dumper = {
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 10c97a9..6a8072f 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -170,7 +170,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 }
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
-void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 void hyperv_cleanup(void);
-- 
1.8.3.1

