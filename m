Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2927131BB5
	for <lists+linux-arch@lfdr.de>; Mon,  6 Jan 2020 23:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgAFWna (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Jan 2020 17:43:30 -0500
Received: from mail-dm6nam10on2136.outbound.protection.outlook.com ([40.107.93.136]:22150
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbgAFWna (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 6 Jan 2020 17:43:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DM38UKINbX51s0nUK8IOlWDdctGf3P6fJn5oMvVPRmmkWigbXpl/aKFc5gbDLPcCatkHQzXVXEU0piGKIqRQHuF6XtrrXTwWUtz6u4CImmiN5Ze/ADFZt1FnLVbHQgS/555+Yu3aB5bw/z1b7/ho8F6AZEMAF3hRc1uAUWJMF9wwsK5taFSVYwM8bDkUZhW129NfrNQVDOwHAz7POrcN5xD2kkTHb3xUF8aU1rq10SfDKzAuK4uS6zWX8cl3oqeimvCazmppxU6AjHqIfTmibvSPpoWM0e+T7WEtHfeaOdADJsUSYTqzGj699pqa/O4QNolFn1NrRB4lkvUI8ASTMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCgJOcCj17EAGRsOkG92QqjGFbp62fRnm8CK5T6ZfCY=;
 b=VuWWE4KHgRPP/iVS5MprxAY5gXnbD10SCvzeTbxxMQZozPj10N9icRb9M2JIwxcymEq0pvxw8tEOPR1GJbupcVFx3gsFPH0UVVqgSk5MAaKgInckLmg1JW8FeGEn8tiPp6gp8gBlup+Jg0o6Z2YUznNhElnToOHMweoM3xka4NvnZWYFTEyyXOj/IA5XxyTlxoQeDUpSUHg1iRQGl/DX2j3gOLi28tnqa9y9j0UdSgqaL67hjbLhHCXeXPlpbI5jIpcMObGgbRZHjhuXnt5HUQIp2X3tIIhqsNdoozI9+wt/hCzrSxgOzQaFthIxOHJS5jKvLJOF1JaAsqb5vtZNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCgJOcCj17EAGRsOkG92QqjGFbp62fRnm8CK5T6ZfCY=;
 b=T5V4Hy7GHhKXd9uYrGiL7174wufRMFb73GqsQFRQlZsCjpKMD899nRX9QuCbYA6uv0XEvKaQUXyUU9LvOyWO0Je1EK7R5uwWi7l2dD1EdkFTIQPgBll6oVCBhurX90WiF7hY8BwcbJNqLYF7lMAShYHPHJ8x0AO0QgaSacVfJz8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com; 
Received: from CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) by
 CY4PR21MB0182.namprd21.prod.outlook.com (10.173.193.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.4; Mon, 6 Jan 2020 22:42:46 +0000
Received: from CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b]) by CY4PR21MB0775.namprd21.prod.outlook.com
 ([fe80::6155:bc1d:1d39:977b%8]) with mapi id 15.20.2644.002; Mon, 6 Jan 2020
 22:42:46 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     arnd@arndb.de, bp@alien8.de, daniel.lezcano@linaro.org,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, sashal@kernel.org, sthemmin@microsoft.com,
        tglx@linutronix.de, x86@kernel.org, mikelley@microsoft.com,
        Alexander.Levin@microsoft.com, vkuznets@redhat.com
Cc:     linux-arch@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v6][RESEND] x86/hyperv: Suspend/resume the hypercall page for hibernation
Date:   Mon,  6 Jan 2020 14:42:39 -0800
Message-Id: <1578350559-130275-1-git-send-email-decui@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Reply-To: decui@microsoft.com
Content-Type: text/plain
X-ClientProxiedBy: MWHPR12CA0038.namprd12.prod.outlook.com
 (2603:10b6:301:2::24) To CY4PR21MB0775.namprd21.prod.outlook.com
 (2603:10b6:903:b8::21)
MIME-Version: 1.0
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (13.77.154.182) by MWHPR12CA0038.namprd12.prod.outlook.com (2603:10b6:301:2::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.12 via Frontend Transport; Mon, 6 Jan 2020 22:42:45 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [13.77.154.182]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb2495d9-9584-4a4d-eb0f-08d792f9bfbc
X-MS-TrafficTypeDiagnostic: CY4PR21MB0182:|CY4PR21MB0182:|CY4PR21MB0182:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <CY4PR21MB01822EB28F4FF96349F1FA34BF3C0@CY4PR21MB0182.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0274272F87
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(346002)(396003)(136003)(189003)(199004)(5660300002)(966005)(107886003)(15650500001)(10290500003)(2906002)(3450700001)(478600001)(4326008)(6512007)(316002)(186003)(6486002)(16526019)(26005)(6666004)(956004)(81166006)(81156014)(8676002)(2616005)(8936002)(6506007)(86362001)(7416002)(66946007)(66476007)(66556008)(52116002)(36756003)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0182;H:CY4PR21MB0775.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LphRne6k8wsntp8nqM/w6rSUHnBCS8tuWwrsVFZlzTfdCDVwWC1v6YjJ+SqRwVeMyKdA+3zq6W4WnXFsrlD+KoAYBe7AHCtwnspHIrkGbNNoMwgHjoD9fPrd/2lxyyojwc/OquUy2ai2qWDt4uZrHw2pohBohmJvOiv3XkDudRysju3MVKx4S73lR+Y9kZypCzdVhXbL44COwuHZY6Atxr9uVf/laA1fJ/+MGLXVtAylHrcMBQEezlYUQ8/vTqbBJ0oCjxYCX4/W9SxEIJ+aHeISh39K6RFafqFWDaDB84kp+6Wv3NOdA5VcndrxQ1kRuPDtGXKs1YnEA1/DooUPdItOs54X2Yg9AGoFzP9LKb1DbIiEsaxKYpY52eo+/r4F6MN7gJ9j6GXMz1f78CWK8g9MJnBCzetcXWAetSx8hCh9UXr3oD4fnL5mMU3N/qQ/g+U97uNWoKSFFCeP6iOuB1iR8nzr/IU9+h+Pd5MNtm51KWpXQRNlsOEIwIdXq/vz0YjsRaP0eqTtOc4beh8rgfnVdI27yIqg7RUAD7QLv3gy+IFTqkO/mhHY28U5ocQxlB/DHVo7xSeXoUG+PpQATQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2495d9-9584-4a4d-eb0f-08d792f9bfbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2020 22:42:45.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AK2owzNt8jeYWm3hXkcUb0HTgwJnx4hC7PocRhhHb1oz+ARDFlJ/dsJrRW3x3qwUaY/5of0c7VVZjqvYhDta/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0182
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

This is a RESEND of https://lkml.org/lkml/2019/11/20/68 .

Please review.

If it looks good, can you please pick it up through the tip.git tree?


 arch/x86/hyperv/hv_init.c | 48 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index caaf4dce99bf..24a62d33067c 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -21,11 +21,15 @@
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
 
@@ -246,6 +250,46 @@ static int __init hv_pci_init(void)
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
@@ -330,6 +374,8 @@ void __init hyperv_init(void)
 
 	x86_init.pci.arch_init = hv_pci_init;
 
+	register_syscore_ops(&hv_syscore_ops);
+
 	return;
 
 remove_cpuhp_state:
@@ -349,6 +395,8 @@ void hyperv_cleanup(void)
 {
 	union hv_x64_msr_hypercall_contents hypercall_msr;
 
+	unregister_syscore_ops(&hv_syscore_ops);
+
 	/* Reset our OS id */
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 
-- 
2.19.1

