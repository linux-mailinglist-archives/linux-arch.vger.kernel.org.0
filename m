Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A781034D1
	for <lists+linux-arch@lfdr.de>; Wed, 20 Nov 2019 08:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfKTHJ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Nov 2019 02:09:26 -0500
Received: from mail-eopbgr770104.outbound.protection.outlook.com ([40.107.77.104]:34030
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfKTHJ0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Nov 2019 02:09:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4mya0Wa0F+qQRQs9iH6dmtBRup6AwM5PJE8iO1RYW+nGUb54AuQym2TJihA3jwdlH674w+bGShJ5RQdsfwbf4LSju7bXE1bwyBdq5tc0KtjPWTO0scQz7JbR0k8zCsTbLUUPf4Olm0TB1xnZWHeU+pJtx2Xy8dTyjJs3mo66U8jnvjMae5/cJFsJiZ5sNM30sKFI0jww+JfE3KwSC4Hj1QKIUCv/AVAg44FZMcdYXLsVQ2RudC/T6RzpUdhsjnvBQof18nWp3IHoZEqchX/vW676LGImCV+6Iujn30SKzDwPaYIkJo9v7K5ZLmiI6xldzhgAhbzrDdb3O7A7M53YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rWXqaA9BDeb4W0MowjqtCEy8/0QhOpnWQvxEmyDiXU=;
 b=CJp5n3t4ILVuArWs5kkaRx3NJXy73vi1Hfr4Vc/yP+75P0MLY/tpgOA/v/gD372f/+hgZ9FqX05Z22LlQWs62B2raYbGbyf4CPXJEPbiKzSIW2w1yDs4r2wQ57gA7KNd7xHumQ9wgD0WlJ/MR1GzV6+Ry5SQKU4sKwFLJldpykytrU0Z/Aq3LqiB6DA28HYrGDLt5VXjBNPyGXCztg4poqmhfcPQO77Eiyjman23zeU8oPOeibBxGzJmIRNz2gBTJsU7vmNvDynqF2KkE53ncRQqp8+9HBT+5+vkjuS0jEmM6fKTrkbGiyVCsNjoy7z3hGK7rnxIx21WQH9FyXWHOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3rWXqaA9BDeb4W0MowjqtCEy8/0QhOpnWQvxEmyDiXU=;
 b=IlcCUEX7n5ARigZhdkYHWeKTsOk951yT/RoNsQwcioTsoN9Vn9xtZhxjLtioL/Brf+cJ6V7NMTMuLTn1WbiOWxxyrHxTvcQ29hT3YcOCo8oKoonQzimXDTm3zUrMG3fJDRYZAyJGSjphYkToPrs5Tt+IbhZ/bPi5DNYYbepAC8M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from BN8PR21MB1137.namprd21.prod.outlook.com (20.179.72.96) by
 BN8PR21MB1186.namprd21.prod.outlook.com (20.179.73.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.3; Wed, 20 Nov 2019 07:09:23 +0000
Received: from BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d]) by BN8PR21MB1137.namprd21.prod.outlook.com
 ([fe80::c596:ecf5:7a6:734d%2]) with mapi id 15.20.2495.006; Wed, 20 Nov 2019
 07:09:23 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v6] x86/hyperv: Suspend/resume the hypercall page for hibernation
Date:   Tue, 19 Nov 2019 23:09:02 -0800
Message-Id: <1574233742-47794-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR2001CA0015.namprd20.prod.outlook.com
 (2603:10b6:301:15::25) To BN8PR21MB1137.namprd21.prod.outlook.com
 (2603:10b6:408:71::32)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR2001CA0015.namprd20.prod.outlook.com (2603:10b6:301:15::25) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 20 Nov 2019 07:09:21 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a3b54bf7-ddcc-4aed-90db-08d76d8891e2
X-MS-TrafficTypeDiagnostic: BN8PR21MB1186:|BN8PR21MB1186:|BN8PR21MB1186:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN8PR21MB1186CE61A2CCC1676C1EFEF1BF4F0@BN8PR21MB1186.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02272225C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(136003)(366004)(39860400002)(396003)(346002)(189003)(199004)(6506007)(478600001)(386003)(316002)(43066004)(48376002)(3450700001)(5660300002)(16586007)(66066001)(15650500001)(8676002)(50466002)(966005)(8936002)(25786009)(22452003)(1511001)(7736002)(6486002)(66556008)(66476007)(2906002)(66946007)(51416003)(52116002)(14444005)(107886003)(476003)(2616005)(186003)(47776003)(956004)(36756003)(6436002)(6666004)(3846002)(10290500003)(305945005)(10090500001)(86362001)(26005)(81156014)(81166006)(4720700003)(6116002)(50226002)(486006)(4326008)(7416002)(6306002)(16526019)(6512007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR21MB1186;H:BN8PR21MB1137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E2m6bIUZX8AJUSW65mL5xWqLvKmaE8unFMbiwBgKreglSV1Ol0n7WETT7r4LWuiPbB34wn0VG5YEoO/LGqD6bTesuxC3vVQmgANGNhyN7/D+/FPtfQMAh3JdS1ZNQ5xQRCIJwT0qMA4gqSP7qcDikI35d4xr8qKJC4qehMvM31NjV0+/ePDODTtRohu5Db1ofPhIacAY5joZjo89K6383asDsaZGYafREVlpi88m8WUOaynODxadoMia+PC2AERTu+cEl/jkMGjPXvvt83hBe3dVJZOR7reOGO4y7cWsGryhiSFIM/KNP0evej0m48QQG091cCHMtWt8bcKUIbDkH5XCJzEeJEpoN2niLXkkdTsw8OXX9S+YInAsFTGezroN/aqoQzeJUipbtVZ3tGdWE5UaS8LmWfL+wv6DDNN2Yk0Rppu8dDbwh6zS0xIVX0LNk0UCPx+noLHPsEhkiNua6wKKH8TGN2wciyGNb9lq/eE=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b54bf7-ddcc-4aed-90db-08d76d8891e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2019 07:09:23.0881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZlGLT1oyoCDP6WFEbJhLDq4AI4fpVv6C48gfBiVNyzNpCcFhIBDo3uYUpjbR5z0BHMKFKdNIaiD+MEj/7Vd5LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR21MB1186
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is needed for hibernation, e.g. when we resume the old kernel, we need
to disable the "current" kernel's hypercall page and then resume the old
kernel's.

Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---

This patch is part of the v5 patchset:
  https://lkml.org/lkml/2019/9/5/1158
  https://lkml.org/lkml/2019/9/5/1159 

  The change is: I set 'hv_hypercall_pg' to NULL in hv_suspend(), and
restore it in hv_resume(). This is suggested by Vitaly Kuznetsov.

  There is no other change, compared to v1 (v2~v5 were posted with the other
patches).

  Please pick up this patch onto the tip.git tree's branch x86/hyperv.

 arch/x86/hyperv/hv_init.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 426dc8b78193..c170653da589 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -20,11 +20,15 @@
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
+#include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
+/* Save the hypercall page temporarily for hibernation */
+static void *hv_hypercall_pg_saved;
+
 u32 *hv_vp_index;
 EXPORT_SYMBOL_GPL(hv_vp_index);
 
@@ -245,6 +249,46 @@ static int __init hv_pci_init(void)
 	return 1;
 }
 
+static int hv_suspend(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/*
+	 * Reset hypercall page reference before reset the page,
+	 * let hypercall operations fail safely rather than
+	 * panic the kernel for using invalid hypercall page
+	 */
+	hv_hypercall_pg_saved = hv_hypercall_pg;
+	hv_hypercall_pg = NULL;
+
+	/* Reset the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 0;
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	return 0;
+}
+
+static void hv_resume(void)
+{
+	union hv_x64_msr_hypercall_contents hypercall_msr;
+
+	/* Re-enable the hypercall page */
+	rdmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+	hypercall_msr.enable = 1;
+	hypercall_msr.guest_physical_address =
+		vmalloc_to_pfn(hv_hypercall_pg_saved);
+	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
+
+	hv_hypercall_pg = hv_hypercall_pg_saved;
+	hv_hypercall_pg_saved = NULL;
+}
+
+static struct syscore_ops hv_syscore_ops = {
+	.suspend = hv_suspend,
+	.resume = hv_resume,
+};
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -329,6 +373,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
 
 remove_cpuhp_state:
@@ -348,6 +394,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
-- 
2.19.1

