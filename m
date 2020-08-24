Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D413A2503B2
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgHXQtY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:49:24 -0400
Received: from mail-dm6nam12on2120.outbound.protection.outlook.com ([40.107.243.120]:2560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728646AbgHXQtC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:49:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eIc/GZEm0bwpuS3UiNCb5b/izN40EvYsE9mHOo8idVwlPHyrbX6h1aepRZnYwD9pFxBsGDE+u34sxW3fQ/8W5eFNxNS3dp+FgYdiyP9kTzvLBGUXZDtzr73/KkHplWJ+uLF7CpmrzPjfPYzOOrfDP7opOxHEKe1D8PR7d9a5xuEgkZL2eH73vq6yyQMDnZunuFJytFXarCnVuTCgFT1d1hHWKOv/WPnSxyPw7DfTGdaJKcr0/4B6McY/ttLFAwsa7sLeSHHGRRQ+C6c4Ktv6O4f7FVWROUR3qB0mv3GLGBzlQHkpBSF+HynUS/BIPgAUQ3UYBwwhvVJgKKgPGUAC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPH8n0MDHAr0BMdP5ZWvamaCLXQHnKmSR1JTns0c0qA=;
 b=an8vtdtxV9qFa2G0h3SJT9TSwLG3W907u987aQAQU553Cr8E/d4TIhFCXq1MFzS+BzVOw9TZ/sB1LCt/MAw4RrpfqIssTQMnbiujZAimfjm4jTXSpmkZwU5VN68jWziKaM/lz/mYXn3/+9VuF3m7HZMPI6F9gv4PHTL7GckgwYJsikXoLr+LhqEQyRr4vwfe3nnK2a37BCfMgUfef2LHl9jx0fn0twNgPAzRTfL3s8AuJ7MJrMcAUTVnF/QU3mCYLzIPdtoGET2DBuUOi2wRdNonCeXM31uxhvvy7mqa9fMzRfvjMfEO5T9ex85cqZtriqzgZGRYX1fm5cqrcLatWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RPH8n0MDHAr0BMdP5ZWvamaCLXQHnKmSR1JTns0c0qA=;
 b=hmo+51QFBbrb/eTnT/QwwynFiKiVSucF2r1eQk1Pg2wDXgottjKNDdxdEpel/FTQQGFtP209yExTA9uigcvHgPELh/ZCmne9RZEYLGpI+n5KOTDXTuP6W7Li19DqCWwrTeaU5Yo84fHEISJD/QB6ihVK9dbMKAL+RbQVfEFHA1o=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:48:02 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:48:01 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 06/10] arm64: hyperv: Add kexec and panic handlers
Date:   Mon, 24 Aug 2020 09:46:19 -0700
Message-Id: <1598287583-71762-7-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:50 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7c824e2-2bc7-4409-479e-08d8484d7147
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB075389CB1DAD77828C3CB7B5D7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OUeZJ9VM4fnR2dDfQTS5FhCYKaI5vFTS5hEQf52KRFqdHj1X1MEQKHe6thcAIExfi4tUxgeH6KKug0b6PBi8+b9DSycvcUmerWk3NfIRXSbdQzxNFEAMwPowUrMMfkbK9d7wwGZvxvxgJhd6GqwJryeDnmLENJnGoagJkxB1LZhyrNMF+Md2SDFPVyBJcwlUgJTpNAnlQt3XdIkcd2JDyM+/Ke9k0rIARHwBm+OrckI/020wo+TBuK7HSj1RNo49Rms7LPMj46o1R8NVuEaVnY0uOq2YLslzFqWh/rvgtw4UrMKle2DIQ0Li0eBk4PLNlB178K+soCztBLupGCIjdrMS6/js5lWzsNRPMh8dwrGLNA4ayWho/Nv9KtfVirBd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: cAnz1lYZGeu1vrsU3dHrNXThtW0qooajjk8Zg8Rf9tn5m6Fe/WCLzI65Ia3DAKzaSWh9li0rxXx4yxmgNr8oW45cTvPJPg0jNiRgfYWkGiFr4VSSXfuH9j3HFTv70r9YdD0jqSBJFrLBZFYMoeQeLOzhrt/Zm/mpL3q6RgadDeVszBXhYqyCuHu24P/udcrY34V61tj7dmuQArKk8AytwerQWVJnW+utgMPAnyuFTopT5Z9Dn9Z5nfz4sm0m77f1wN4ImyPy4U/q8E9eDFvB7Hkwab0+fKJdLvU4YiIZ+4IyMi8wD644pEkqBfNWmmGPqdTzlhStSK2HHW63sjZyua/aGTf3XLSara5lgflY1l8JJYZ8JtghaMZNsHsr4YA6uxkz7MGs2vgKWA+ZwXWvSbN3/8U1O4qCYQahkeYm0eZChX5ycfC/w6rwez/mSOEn3BlayySYCZ56rcbWLuuiqXZH0g4k8ImH6VaBxfzn6gSMvKbH1fxhnIvCog70bovjRKy9JV5WUE26GIs3aUvOFu4jGhbNOeCv4Gjxaut5IfuxDSMIKBLgSdGwG1pGkrV3JtXoUjZFjR8s4ODe6ffPY0A6EbC3YZPx8Tca+5gVeIYpuGGZow6lFpyCPsv6UrpD0XS+/qI/ODvZfvpDDbTFrw==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c824e2-2bc7-4409-479e-08d8484d7147
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:52.5832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QnTbd+5UrGqRPNWgLISULISu8lmPYCkRqSUVVlfWkRYXaoAh4oXMH0xPJaPTz5pnAgrDjEJUUjf5up4YKsdG3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add functions to set up and remove kexec and panic
handlers, and to inform Hyper-V about a guest panic.
These functions are called from architecture independent
code in the VMbus driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/hv_core.c       | 80 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/hyperv/mshyperv.c      | 26 +++++++++++++
 arch/arm64/include/asm/mshyperv.h |  2 +
 3 files changed, 108 insertions(+)

diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
index 14e41b7..966d815 100644
--- a/arch/arm64/hyperv/hv_core.c
+++ b/arch/arm64/hyperv/hv_core.c
@@ -211,3 +211,83 @@ void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
 	kfree(output);
 }
 EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
+
+
+/*
+ * hyperv_report_panic - report a panic to Hyper-V.  This function uses
+ * the older version of the Hyper-V interface that admittedly doesn't
+ * pass enough information to be useful beyond just recording the
+ * occurrence of a panic. The parallel hyperv_report_panic_msg() uses the
+ * new interface that allows reporting 4 Kbytes of data, which is much
+ * more useful. Hyper-V on ARM64 always supports the newer interface, but
+ * we retain support for the older version because the sysadmin is allowed
+ * to disable the newer version via sysctl in case of information security
+ * concerns about the more verbose version.
+ */
+void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die)
+{
+	static bool panic_reported;
+	u64 guest_id;
+
+	/* Don't report a panic to Hyper-V if we're not going to panic */
+	if (in_die && !panic_on_oops)
+		return;
+
+	/*
+	 * We prefer to report panic on 'die' chain as we have proper
+	 * registers to report, but if we miss it (e.g. on BUG()) we need
+	 * to report it on 'panic'.
+	 *
+	 * Calling code in the 'die' and 'panic' paths ensures that only
+	 * one CPU is running this code, so no atomicity is needed.
+	 */
+	if (panic_reported)
+		return;
+	panic_reported = true;
+
+	guest_id = hv_get_vpreg(HV_REGISTER_GUEST_OSID);
+
+	/*
+	 * Hyper-V provides the ability to store only 5 values.
+	 * Pick the passed in error value, the guest_id, and the PC.
+	 * The first two general registers are added arbitrarily.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, err);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, guest_id);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, regs->pc);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, regs->regs[0]);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, regs->regs[1]);
+
+	/*
+	 * Let Hyper-V know there is crash data available
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL, HV_CRASH_CTL_CRASH_NOTIFY);
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic);
+
+/*
+ * hyperv_report_panic_msg - report panic message to Hyper-V
+ * @pa: physical address of the panic page containing the message
+ * @size: size of the message in the page
+ */
+void hyperv_report_panic_msg(phys_addr_t pa, size_t size)
+{
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_P0, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P1, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P2, 0);
+	hv_set_vpreg(HV_REGISTER_CRASH_P3, pa);
+	hv_set_vpreg(HV_REGISTER_CRASH_P4, size);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	hv_set_vpreg(HV_REGISTER_CRASH_CTL,
+	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+}
+EXPORT_SYMBOL_GPL(hyperv_report_panic_msg);
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index be2cd2f..5bd39cb 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -23,6 +23,8 @@
 
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
+static void (*hv_kexec_handler)(void);
+static void (*hv_crash_handler)(struct pt_regs *regs);
 
 static int vmbus_irq;
 static long __percpu *vmbus_evt;
@@ -131,3 +133,27 @@ void hv_remove_stimer0_irq(int irq)
 	}
 }
 EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
+
+void hv_setup_kexec_handler(void (*handler)(void))
+{
+	hv_kexec_handler = handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
+
+void hv_remove_kexec_handler(void)
+{
+	hv_kexec_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
+
+void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
+{
+	hv_crash_handler = handler;
+}
+EXPORT_SYMBOL_GPL(hv_setup_crash_handler);
+
+void hv_remove_crash_handler(void)
+{
+	hv_crash_handler = NULL;
+}
+EXPORT_SYMBOL_GPL(hv_remove_crash_handler);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 2ea64e54..5df96a5 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -149,6 +149,8 @@ static inline int hv_get_vector(void)
 	return vmbus_interrupt;
 }
 
+#define hv_get_crash_ctl(val) \
+		(val = hv_get_vpreg(HV_REGISTER_CRASH_CTL))
 
 /* SMCCC hypercall parameters */
 #define HV_SMCCC_FUNC_NUMBER	1
-- 
1.8.3.1

