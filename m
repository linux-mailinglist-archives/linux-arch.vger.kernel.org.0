Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D129E131BBB
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 23:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgAFWnr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jan 2020 17:43:47 -0500
Received: from mail-dm6nam10on2110.outbound.protection.outlook.com ([40.107.93.110]:33472
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726794AbgAFWnr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jan 2020 17:43:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6jJnhk7E5NxbO/Bc9hiMTYMdef0mA3d2lHQEmfnjMkHqDR+ZOJSxyAEjg6flU/p/2PhRSowgFCuSPqJtlUpa24FGAoTOrXgtqT5Mnth5RnQOe5FDewWkswvWgiJVvx2KH2Sa8fhrKU8ZGhg1CxNn+jHZH7qm3Rz67Rg2oHkTlX+2fw2MtsdOBDwa3MBnIuid6LEp5d9jtxwbqZlxh9JzU4/vYX8+6s1FUKg5neZFrro4TvY1d00ekrWoq7U/vWyaiy9qE/ihMg6nlaYemMUyn9q0UoFzZaEj4O+9YKWWTAIxodLThmtNTH2AIQnsjnYnfF6E+vsU2AXiQMsJFG9hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujW3zXlqKOUPvi4sSRjcJ1VQDlqIkTXbcPltiQ2ux9o=;
 b=DdRmdQWsdKYEaqLmxSuWsFfe9znHWTE/LB8uOOmdnIzdAxjmZNts0KKcQVOjwyu0McT0Jxi/saD9IXZEODhXV4E9z07iCP/wnuyB7FZ1bZPcwigKh/CCd09rcRcuBw2vee5MoRhhEBgpZpMKGiTYvip4ksgNpUYgPC/Njx2kyK0/12PBnCLOzaOCt9gkNcVm1o2ytE44o61hrF5etvOOJvaF63MtrTe4hr9uOzuExmFAIv4p0taerNk3UOmo+8V7eIS6UV8d4PfIPEZuCQEUSb9U5VwZGT52NOACyGC/Mi3CM9jr+RMwlJ+N5xH04POCfdGQijlYpdwqn0UhDDEPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujW3zXlqKOUPvi4sSRjcJ1VQDlqIkTXbcPltiQ2ux9o=;
 b=Hhq0yaM7yTvQNz2qmDZ7I6nEWmPK9iWnX0NXBBbg1rrNBmSMc8eilOpTTYlS7Sou1ey5edGwM+MVJ4q2kX4+yjuVGwGq7o00d/CUC0litiH0Xh8TijpTaAx9PEtqGei2p33AWR4WVevmCfK4wdmt3Pix0alq3TkA9NAkqb5GYj8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) by
 CY4PR21MB0471.namprd21.prod.outlook.com (10.172.121.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.3; Mon, 6 Jan 2020 22:43:45 +0000
Received: from CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b]) by CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b%8]) with mapi id 15.20.2644.002; Mon, 6 Jan 2020
 22:43:45 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v6][RESEND] clocksource/drivers: Suspend/resume Hyper-V clocksource for hibernation
Date:   Mon,  6 Jan 2020 14:43:37 -0800
Message-Id: <1578350617-130430-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR11CA0002.namprd11.prod.outlook.com
 (2603:10b6:301:1::12) To CY4PR21MB0775.namprd21.prod.outlook.com
 (2603:10b6:903:b8::21)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR11CA0002.namprd11.prod.outlook.com (2603:10b6:301:1::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Mon, 6 Jan 2020 22:43:44 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a58a8c36-02f4-4097-dba1-08d792f9e323
X-MS-TrafficTypeDiagnostic: CY4PR21MB0471:|CY4PR21MB0471:|CY4PR21MB0471:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR21MB0471E2E8C70D42D15FF97D4EBF3C0@CY4PR21MB0471.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(39860400002)(396003)(136003)(189003)(199004)(52116002)(316002)(86362001)(8936002)(10290500003)(81166006)(478600001)(16526019)(107886003)(8676002)(7416002)(81156014)(186003)(6666004)(2906002)(26005)(66946007)(66556008)(66476007)(6486002)(6506007)(15650500001)(6512007)(956004)(5660300002)(4326008)(36756003)(3450700001)(2616005)(966005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0471;H:CY4PR21MB0775.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zkN+Iza95EQLQcQcrVN0jAHWM03ajPrjckMXUlaVbS9cuccMtgt102xuyERPzEKfpHzVRHQmuRT2MXE1SDZ30F+Zj2o6uGrJ/0g9BWfsomyPUxBRApKD5DtMpmYU6v8FLWZ8My8UtulMg1Vpix+3DwKA5zVS+BtN7hi79vZE7wVlRODg4To82BNPpJft9f70bkeFA7Mi9CJjkUYvhD+l+arvZ/M9wc/JhSX3kwdwYmvrLTu6idXIyDT2xm26qz8O6TeVtIYmyN/3FrvOPbnkTF2MvOtHr8qEArwCMWPrlxV93RCIDU0Gf613XRu5SBz21tZRnsCykSHTWD1u1Baw3R/EDhavVGVaSklTbBHmFHJ/8zUx96dqEPbg5fn+A3JFrkpnTP5KRA51SYNSUbnZfO9sZ6fqG0Mfw/g99Szj4rqyEVBwpvQr9B65p6gHoXa1lo4eyacanpaysi3IlFpXPRlMUeBrgg0k0wTb8n1zVYZWVtlrETltxxMVW+N/xeTUL7QAc6BH6W3KDMpBkYIVmRc2QEAieF821sjHBoSRkpPvnVhrKd4IXhaoKGZovZhPqhLGbrZLhzF4e/JyI38QjA==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58a8c36-02f4-4097-dba1-08d792f9e323
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 22:43:45.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FN6QqSYulpuhvmLbusnTHjRXveULcr8Lz8FKxNg2o788U8CikT+HM3BS/vAzHC4GxUkt5nTjYleL/chw1pVu2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0471
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's TSC page and then resume the old kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

This is a RESEND of https://lore.kernel.org/patchwork/patch/1156212/ .

Daniel Lezcano said "Applied, thanks!" on 12/4/2019 (see the above link),
but I still can not find it in the mainline tree, or the tip tree. 

So, let me resend it just in case.

 drivers/clocksource/hyperv_timer.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 287d8d58c21a..1aec08e82b7a 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -330,12 +330,37 @@ static u64 read_hv_sched_clock_tsc(void)
 	return read_hv_clock_tsc(NULL) - hv_sched_clock_offset;
 }
 
+static void suspend_hv_clock_tsc(struct clocksource *arg)
+{
+	u64 tsc_msr;
+
+	/* Disable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= ~BIT_ULL(0);
+	hv_set_reference_tsc(tsc_msr);
+}
+
+
+static void resume_hv_clock_tsc(struct clocksource *arg)
+{
+	phys_addr_t phys_addr = virt_to_phys(&tsc_pg);
+	u64 tsc_msr;
+
+	/* Re-enable the TSC page */
+	hv_get_reference_tsc(tsc_msr);
+	tsc_msr &= GENMASK_ULL(11, 0);
+	tsc_msr |= BIT_ULL(0) | (u64)phys_addr;
+	hv_set_reference_tsc(tsc_msr);
+}
+
 static struct clocksource hyperv_cs_tsc = {
 	.name	= "hyperv_clocksource_tsc_page",
 	.rating	= 400,
 	.read	= read_hv_clock_tsc,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+	.suspend= suspend_hv_clock_tsc,
+	.resume	= resume_hv_clock_tsc,
 };
 
 static u64 notrace read_hv_clock_msr(struct clocksource *arg)
-- 
2.19.1

