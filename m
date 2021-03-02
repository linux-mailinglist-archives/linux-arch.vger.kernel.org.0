Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E814C32B4E0
	for <lists+linux-arch@lfdr.de>; Wed,  3 Mar 2021 06:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1450148AbhCCFan (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Mar 2021 00:30:43 -0500
Received: from mail-bn7nam10on2125.outbound.protection.outlook.com ([40.107.92.125]:6488
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1351038AbhCBVmN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Mar 2021 16:42:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjjdtKJAJOCFx2Jftus4kpVC9FibNZWMOWj1wRrV3gfEsxJQkr4d2ToG2MoyoKTHu0BEKbFdiFWiOyQPudkyn4O2+tY6fAdREXkOkb2igjyJWvlVcEbNC+iIIpa375KAHfJ0HH3qtjYjnT2KmyCkdnA82sOr1RPUZBoWaVOA29FgWgYQPUARUzDJELAJFcTCZNGp4unMDbSPSXOvB1zGZps5eH4dKEjhY8BXRBWf9cteZdGIEV9xzbAvAO0zATwvxdpVXUHjMkGVL1vUtPYUygfvSFfTfayqnWzYR8jTzHQYtmkeEhxklEujY4xGU8V/eDqWDUWwtFgjyo3zzRz9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm/ZqKjR2PGVRWZcobPLl1OUbrN2ehr1X9YGSJ62bu4=;
 b=EpbEX5qzX/IClzyy0k8qAl30X/1bTwOoFKddx3lNIhM2TgDW31U+eqFe8XGuBgj/Vrl35Ed/u7cwk0oSpegqyRWVJb10D/XeyAgDXgUD8b0KrbG1d5fLvYz/f5DdRhxGCAmj7wHgbcUglOD6PiFEbECbHVtjsaTGfQoAQZNLzLnKPXWEuBo36And0k5fWfAWCxzBZtwNPnNmyRAgner3bHx0tibQBGr6SsHq6bDG+Bt/hD3eBaLK/BPY3v7lifXoqOAdmc0DzgfwJDNJ0cYpvrAwUDDkLRQHmUL6b3U5h2VKWqjIrLR/MQ73iL/n/0fRnEORoDH8OVnEy29o3t3KoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm/ZqKjR2PGVRWZcobPLl1OUbrN2ehr1X9YGSJ62bu4=;
 b=U4Bc/Ouv7IWQKG7474c51aMkMn8JgOBtRV7uPk3PhL8+1Kr3S1RdnZsefbZW48HJTPQMGJ4oPrk3/5/0cl0uzJ92D0WtzcFQe5g5F/O3njVZ6nKq79C/EzrhbGa9xOQ5rWmMhi+vEVwwfnBaWTzpPqbK5BnhGY2HeIR2le7OXms=
Authentication-Results: microsoft.com; dkim=none (message not signed)
 header.d=none;microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by DM6PR21MB1739.namprd21.prod.outlook.com (2603:10b6:5:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.1; Tue, 2 Mar
 2021 21:38:52 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::1c32:e52a:6a36:3ff%4]) with mapi id 15.20.3912.016; Tue, 2 Mar 2021
 21:38:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        daniel.lezcano@linaro.org, arnd@arndb.de,
        linux-hyperv@vger.kernel.org
Cc:     mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 04/10] Drivers: hv: vmbus: Move hyperv_report_panic_msg to arch neutral code
Date:   Tue,  2 Mar 2021 13:38:16 -0800
Message-Id: <1614721102-2241-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
References: <1614721102-2241-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-Originating-IP: [131.107.159.16]
X-ClientProxiedBy: MWHPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:300:117::15) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkdev.corp.microsoft.com (131.107.159.16) by MWHPR03CA0005.namprd03.prod.outlook.com (2603:10b6:300:117::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 21:38:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aad929ff-59fd-4ab8-8189-08d8ddc392e9
X-MS-TrafficTypeDiagnostic: DM6PR21MB1739:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR21MB1739BA8BA398B52A608935B9D7999@DM6PR21MB1739.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dioBfylwqdFr122g6t8vC4VZ1B+XnSFs6rDeu2KnwsmKwI/2z7MB6us1CGAodmC3sLMUkF286Ts+yUMgPPXX5qWMBbXaD8u+iV72vUa/x4aZWGN8wSS17WsrcI8cdYEYJ6L55plMm9UZaLYHaUWNudC2ZFqzR9MUrrRcPDhSAiCUMEAYhonM3nYxKXeQGgfkHO8Tai//J2DJPpKQOvwgm0x9CcLHekz21AMxyJulBU9wnOcI6sX3W2qbY1Q9yU9589D2L9XfEYHacCDL++0d4994nF3ew0khpeBPQyeSpgAzbd0pRPDp/zB/iKlswLFwafpsXkI2x+2LH+7F5oe80zeS3bj9b30Jl4fprDL0s2XRlvkZAA+DYwYZx/WEpVgLTFTDi9uy7oQp82/n8pPARHXQzItjQ8IaYXAN8Rtpzs4c1Z3XGYliEmZe864y9QjS/tuaouXrrC/6uSRzaRPYVUHnMOjmgr5tW25E16/v5V0FwVQy+wt+TtullFhVGSN1DcuHzKzEWHnYp5065YyKBML8hgdiOYuiqTCRrxpPpUQqDp25veFlInKbvEgYAaaK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR21MB1514.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(82960400001)(956004)(36756003)(82950400001)(8676002)(66476007)(6666004)(921005)(26005)(83380400001)(66946007)(478600001)(186003)(6486002)(7696005)(16526019)(8936002)(316002)(2616005)(52116002)(4326008)(2906002)(5660300002)(10290500003)(7416002)(86362001)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0aRKkdJUPe2VDLGWS9wqXpWcYASyNmjohFw3t1NdRI0piXJAwGx3r63KlxzJ?=
 =?us-ascii?Q?xvH9+FpPhl/Ix3uD3+6gXlnlQV4KLe2648SGo2MJ146Vu0kA9dbAkICxeGXF?=
 =?us-ascii?Q?nK99hprNJc98b8g6CJo0SWYaC9OJ6nWmRKvohJwvlw/2F1sg5EktwmOM2Qwm?=
 =?us-ascii?Q?OWhj31dfHi6JpAoS2DpzQPD0s2MZVu6h/NETtfvWRIDWYIqfXTWquC4B9L5X?=
 =?us-ascii?Q?rcTjL/GBXkBiCuGX+Sx+a+UJRp5/wTD86lkusXPGgW1j5cMvp2Bsf8LtJnz/?=
 =?us-ascii?Q?4/QDYctwd4PbxfiDdl895mD+15E/V75LUYSvLW8A847ezxlANBFgrHOmJSyd?=
 =?us-ascii?Q?IzD5C9SxwTt1ZaUFzTauZn+GXYTk7J+pohIbbZMz6KzMNC+sIFQe/Gs1iENT?=
 =?us-ascii?Q?A+vUxZMA++Byu5F27Ycs1v0HcfqLLulPjwvpCkFLDGhpPEPiMMm2pUsH9UdL?=
 =?us-ascii?Q?vxvDn/KcIQbh8m/CAua51nz1sIslkBkyi56VGPzZrbctIQteq+OeFYYgv9Du?=
 =?us-ascii?Q?WrCp6bPbrVSV2cuRhxJ1LUAWJq9wMbXMrHl5BQlD6U7fPzpYOT8qZl6xApiL?=
 =?us-ascii?Q?0IOaBzv41JTSqInYVwkciNM/imTapT4bDWFBDwbAfkhyZOdQP7t6h29e7Bma?=
 =?us-ascii?Q?SiYQ8vRmvjwbjo8ZO05byVJsqg4ThBautDtHC8nShHkL29haohs5snWbNV0t?=
 =?us-ascii?Q?n6z+jSU5xtuyUZLqSr6CvSOt2a/3i6QqceINWGwLZiGePxwEOooN9T6ztxDo?=
 =?us-ascii?Q?XkmKnwtuV9q07vMemP+X9GEsnZSdEfOcvZ4GCd1En650rPE4p3Wgb+gYao4F?=
 =?us-ascii?Q?Cy0u87ZlCk5dnfKIRC5tVg6aH/jfd8ezIWyhjQvkau39yqQQnZ7kNHAdCLrL?=
 =?us-ascii?Q?7BzDH6qsgcNNN74e/OuDljv8rGM7hUitNa3c6Grdwf3BkrgO7Gl307nBKcQE?=
 =?us-ascii?Q?hkAfAq2Y0DEsyNVJvF6aUtEZ2KxHyE6lvKSNR89aSta3ODzXy/3OOaQgjX8v?=
 =?us-ascii?Q?gi0c2xgszra52K/+5RGGaKgeXAKLHTQkN1fgKPp8HbioZD9Z2dQkS2yKHJ/d?=
 =?us-ascii?Q?AQ9dETz4JLqY60S5pK7TrMdbzCew4+V8S4Inzfs24+mjF49jATf3scf6K9Bk?=
 =?us-ascii?Q?H4Uetvpoi3JLlEgpN1QJ0YoApOnTACpSdc5VWD7pnXgxcm9jVnTyyopI2Twa?=
 =?us-ascii?Q?U9cogxYzN/tHGk1S3MbLPbptOtFowqUym+VgLbhbyRzMTTaBmo4gfiQbEOC3?=
 =?us-ascii?Q?WyADDRcwy2aKpJgJNvxughWKVQO+UfWceWswUePD+nCy1R34uDyc2XyU7MnW?=
 =?us-ascii?Q?JmXumvLBRIdXa1a0WcTnTpGc?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aad929ff-59fd-4ab8-8189-08d8ddc392e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 21:38:52.7675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EkKIyvlXjeqTY/f5tv4lld+3dJYKNWTq3ozhI+uMH/CO1k2u5v3/egzjM5TM9AIRRuFxOvdo8KShWbNS/z5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1739
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

