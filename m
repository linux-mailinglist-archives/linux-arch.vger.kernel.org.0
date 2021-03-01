Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D83275CD
	for <lists+linux-arch@lfdr.de>; Mon,  1 Mar 2021 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbhCABRd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Feb 2021 20:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbhCABR0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2021 20:17:26 -0500
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-co1nam04on0714.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe4d::714])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D87CC061786;
        Sun, 28 Feb 2021 17:16:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fIw9+Nk/ofKeGQvXugJ5jTrM3Os0qd7QRtFSvcnQOFCgdM2duvYMDTnUoUc+1Pv6b6KeJqtVDfQ+uARCFm3RYeqNP35gPYjcSfMXgX0oN/wrGIBBk3VhPPRY1IPa3xpjIPx8F9YXcXdPteFbkrf1/M73JiS4noIColHrx50pJmwf6K6We16Fv2cDLFfl00xiIG3R0MiB/F3MaoBcPwA6sDVDn2FIx/If2TDjwpOKJ5Ci32RVZgG77qomiohRWJ+GTNvL71HTfmZPTONx+fNhELrQSsCCdRy90dnIJ8JhBkB58oi/aZw7Gur/jNCOuSfbibX/ub6USf5sQ5O33WwCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm/ZqKjR2PGVRWZcobPLl1OUbrN2ehr1X9YGSJ62bu4=;
 b=bcEGwlWsF5zGPKXgmfKWhiinKHH3Jov/0Qeu+XWKc91pyBwaoe9S0l/unu+IFEGh6Q4p9PWxAxLxIXmTRjz1wyov6LYSrj7qmsCUJRqeYj2wOcF620Ck999qfpHngCSGzFDaDUNrW+8oSriqV7kURKqFqyDZ07JoDxwHsM/wmkmk2FzwTD1WCdWOwlcDy2F54Xn7X9R4vKig2ZBeKbrfEyRCLK/3c0rLogcccS/KrZC1OKsQr4jAsnQMFx6PnrlwHI3iAsxAGf//rOCOE/iBVpuVUe2pj8lzqBoLShCRIIg4+ypwJMGKTZspo1+WanIJwKHLEuLJAcBLCL9S70nnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm/ZqKjR2PGVRWZcobPLl1OUbrN2ehr1X9YGSJ62bu4=;
 b=Qts/dF4s5Phxd4NDSETsun8YD5cLEqeWDWG0Fnr2IM8d674EcQyvbnvaoZgcVKECAd3YyG8YztH8yb6CazmWsRYQtxujs+hpDUiMUDSx4bHSrj05M4HYhk9pf+gnBIoTZS0rTmB2O15XODaP2e66FrZM0OKC8rU2PQIUcy1Z29Q=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM5PR2101MB0981.namprd21.prod.outlook.com (2603:10b6:4:a8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4; Mon, 1 Mar
 2021 01:16:05 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Mon, 1 Mar 2021
 01:16:05 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 04/10] Drivers: hv: vmbus: Move hyperv_report_panic_msg to arch neutral code
Date:   Sun, 28 Feb 2021 17:15:26 -0800
Message-Id: <1614561332-2523-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
References: <1614561332-2523-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.144]
X-ClientProxiedBy: MWHPR14CA0008.namprd14.prod.outlook.com
 (2603:10b6:300:ae::18) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.144) by MWHPR14CA0008.namprd14.prod.outlook.com (2603:10b6:300:ae::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.25 via Frontend Transport; Mon, 1 Mar 2021 01:16:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 134aed85-034c-48d4-6f3f-08d8dc4f95ec
X-MS-TrafficTypeDiagnostic: DM5PR2101MB0981:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR2101MB0981BF56BE23A2ADB769F9EAD79A9@DM5PR2101MB0981.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qmOBHZDbw9XCQk5QwYkmG/QKz3SsrLsb44imqGNN9MZvJd4DqK+5whkKRIApFWYJnk1+GTomyypgXkO0XwEb5TQ4B9FBFxxF9HpsLFf64cslQcECJSSkIgQwqgTqNfubMbTdl9aLuwgmtP47mdT6xMu3WRn9sOoci8rXVhwcTZc4mQU93uflkm1Q05naj8HO+7Ta4U6glnw9iUCiPr9Xd1UtX+a9/hknZqkclC2FE61Rd2T5s8Zus0EfqOZuHxZtCWxAv3bn9HJI6TY7UbIu3Y56KNe8fL7Qd7ZBseyid5t8XB5F/WCkVll6c1XBHsZW+qZs/NMfu/TUwqvBbgSXvojrqI85cSlU/+Oji76gOnWC90GaXkuUtW9dnDmSMbA/f0XKimtS7SrzhA2RhzaMb8rG593AD5qoIii5w85sedLIpI5jow1BHJEp/URYQi6d1GX9IDzvPohIi3q82vCDyuc+w5kdk1cublTLl7od4UmfMV2vFqccauUitJmOI7IqR9ASVgAWmq4Uzgyu04NRduwjvzrxyKwUKYALLRQI04m1VevoiXyFY5cM1CrvDiA9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(83380400001)(8676002)(186003)(4326008)(66946007)(956004)(86362001)(52116002)(921005)(26005)(2906002)(82960400001)(478600001)(66476007)(16526019)(6666004)(66556008)(6486002)(8936002)(316002)(7416002)(10290500003)(2616005)(7696005)(82950400001)(36756003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c9VW5ADHNAd0ufwAAeWqTAevxiR4XByE/X4DVyS4Pzii5+qDbxDkgIv3xqdA?=
 =?us-ascii?Q?kgZm6R8KI8h3a2L7UVW55GbFdMeNefjXv4J97oZt4321/PynmpjBiIZjiKwe?=
 =?us-ascii?Q?S3hmYRvOr+fdNxZozHjIHR+dVuMKevhlNA004x3Hk0kVgTnb3zvyrWPd4ji2?=
 =?us-ascii?Q?3nSc0Xr5OARSNb6KXRD1PMKiv5QOScCRNNAWgHfmCUY73LHeXKA+aIZURaqv?=
 =?us-ascii?Q?XDecV616F2etHX4+NtFlFzZVkD8ImuCHnt4OAUqE266GuP2HnUY5YJqOu+zt?=
 =?us-ascii?Q?jOYIZsdggXizZRihY2QMikDAMeAu0HTEN9D2cY9X5kYktob6QjbkobXfrY5x?=
 =?us-ascii?Q?jr5uImrOyuzU3KmjceCM0kKfVPrarkyVgTRTRoi3yTY8jztzCgZqLbjTN8qA?=
 =?us-ascii?Q?eun7qhHZE2ShhEYI6GcyrYlf1Uia8VLv/gMr1dcx23IEU+lMz7YF/XE3+F2V?=
 =?us-ascii?Q?gdhyM4I9Ej0j5ET29afyBFc/h8GXvkMCmDTv+majdIk14DcJ3HNJnOy9Ow0/?=
 =?us-ascii?Q?ULzmUHP+QRq2IE3hbS0xEbk9nG5xsnywNg1mRc6TfLsNjU2W7U2cT+EuCAri?=
 =?us-ascii?Q?8mL9kl7gtYKvG2MUsWtDIX0ceiPCNVeNEVH7eJ8bl0NQ1Z05I2TSpdrLIMWH?=
 =?us-ascii?Q?kQYgHPTeQPLLH728zcSl5PRuih9HgQVPkTcE0XvKx7JdTNpkj2qZlq4BHNYy?=
 =?us-ascii?Q?hBpGktrOKzNPade865rgR3ftre7GNNOPC0zK2YKDWMhY8FaZfsZkc8p754mp?=
 =?us-ascii?Q?oYN4VLcmqu6xPrzZzwrKgHMBkDdNi2pQL8NMqakQwqeJkXiKTZ9tEDV07bi5?=
 =?us-ascii?Q?vgCw46+YmhBHu8sGM2dBY6SMv4bJYCb0TKwlPR2FrbC/4ZhidYVDeFBrMmUO?=
 =?us-ascii?Q?CoppsHznMpUuEpzBr126Ggyw5HoXbS7GrmbwQKJ8SLQc97stADFZ54GUwKJM?=
 =?us-ascii?Q?PoBBwIga0nOCae3RoXCh3biz8WsYjBDGEOyfvI7Np8hNj885hdG66kbo3+XG?=
 =?us-ascii?Q?BkYl7b6QFU57lT5kGR6D+wvSOpTKEePyM+yieRApUU14i2QRzthwhPaDoTL5?=
 =?us-ascii?Q?0O+DPvzdaUs/GDsWlTnQyNOIYm+N3N4680Y7u9zGoLGRXow8U+lcBykw2pfp?=
 =?us-ascii?Q?oofaxE8BN7YtR7LJapUefBz06IpMvEkoCY1xmqjwfBlXWHZlKSCnLtOJiB2p?=
 =?us-ascii?Q?Wsn2E4dYIRR1bYF5DBFkwlGNTezY0YCHxpS4ZJZqSEYmw0JXPI1I6ymLNxWG?=
 =?us-ascii?Q?ryAhjOxa8f04QEFsfn9Xrhi6YExO0cMLdVlE1B64W7L2D/eVNKttto+7taBg?=
 =?us-ascii?Q?n0l5pA2X/dOU8PasrPszI7/C?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 134aed85-034c-48d4-6f3f-08d8dc4f95ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 01:16:05.0285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrQ8Oz1Ye4DV+rUWrsIMgNEoVWGPTPdruacTdov3nXvBPgwlS2sAe1MbY4djLONzU3d6jExIgyTnIULfbBU/uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0981
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the new Hyper-V MSR set function, hyperv_report_panic_msg() can be
architecture neutral, so move it out from under arch/x86 and merge into
hv_kmsg_dump(). This move also avoids needing a separate implementation
under arch/arm64.

No functional change.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
 arch/x86/hyperv/hv_init.c      | 27 ---------------------------
 drivers/hv/vmbus_drv.c         | 24 +++++++++++++++++++-----
 include/asm-generic/mshyperv.h |  1 -
 3 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 94d52c5..9af4f8a 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -571,33 +571,6 @@ void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
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
index 9e63170..7524d71 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1392,22 +1392,36 @@ static void hv_kmsg_dump(struct kmsg_dumper *dumper,
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
index 163d8b0..70b798d 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -173,7 +173,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 }
 
 void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
-void hyperv_report_panic_msg(phys_addr_t pa, size_t size);
 bool hv_is_hyperv_initialized(void);
 bool hv_is_hibernation_supported(void);
 enum hv_isolation_type hv_get_isolation_type(void);
-- 
1.8.3.1

