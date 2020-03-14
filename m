Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67682185711
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgCOBb5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:31:57 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbgCOBb5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cojJv3p/eR1ANc5gSYB1my+VEV/vInaL85afCoHVcqPA5HAncSFCBjeC3aQXu0A+iCiYgde1EcBCq+PXQ6w91lrHQ3v49Asd/vW5ZLPGoKXZ5ZfZmNgh4YeO9bDwtl1cXvsDCcL9Pp8l5M1h0AhywOr43GIlr2BUrgXFr91hUWcWaTLew19jzB+YPHIe9u3BalPl3oyK23cmjQshAP0+MsJJ/uLQKnykWOljdNZmteatGGrd11aoQ9yjsEhMzRyJ5+BYH5AMDuO5u9fJKJKV/+UDvmVHfcf4xzFDxBGfR87Q+P3CC5E+S2+1tQmENPe9Z48+A/ZjuGli+ypQ92DKig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnmV7RNIdWV2USjZcsgo2mBK+tzYMj8qzsEyTKRcY2I=;
 b=j6xmT8W3bv1Hem40NOedh33mhXuIzei45vy5DnhsA0dJ785Cu9Ldev8n+kD+Oa2xhJZ5eK22XPfFJbqKyH0/dfYbjjURyxZoGfsIGCgnTRHPFmij9Tb4bi6VDBKiKVzHUKeRgvntiGq41RhuxJdC7b2QnUkS9JOCM/l5Ok6C0lK3iN/Y+n7sNrohIfQrCcSD9QatiRCFbS/379EJBSaWBI+PBVOoZ46bbMW66r7SFkZkAlkjnVY9UAS9cQfZH12hosipJfyv+FOCfybsGt+FExPTVQEi/tbZWJWHnf14/6jjlP0C8aS+Y+c05O1MCWWuMMAJVn158E/Hke4DkFOZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lnmV7RNIdWV2USjZcsgo2mBK+tzYMj8qzsEyTKRcY2I=;
 b=M6RYQ184Qs+iE8y4mil0q+mpFM6T8wby56frsdwITcFLPPAMZgLZrdXOTkknyeUAjVZBEh55FWrmUf7p8SpkpofFc2531c+53P5xEUzv7htxGVSHS9kBE4ObVfahegVpojRvCrb6Vaw3EpRmuZLfXnrXLeASUAhRPrQ+pnGKs+s=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:08 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:08 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        olaf@aepfle.de, apw@canonical.com, vkuznets@redhat.com,
        jasowang@redhat.com, marcelo.cerri@canonical.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v6 05/10] arm64: hyperv: Add interrupt handlers for VMbus and stimer
Date:   Sat, 14 Mar 2020 08:35:14 -0700
Message-Id: <1584200119-18594-6-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:07 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c1db6e2-a6d5-483c-94f5-08d7c82d6a79
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB1632D8FCD9721C8BF4C46D8FD7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(6666004)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aoFXnvcDiFaFyVwZQSQIlyuSQSTa7+7p7MlAp2HghkvnbIw7f6GV65YI7ohg8/VdZ7fK/ElMR8M6Xe2pbjzH1Drvo7YqNU3WYzBHHyAW9kGmcrZpk7BoDBBzH/no+BXoZ8yumxie3fgX8Q3bdauxqbNQVLIR9AWXpV6QShXnRwT8vJQreth7IuuMverjQa4WFs9DAWkpF+KWHfLjrQqUXiw3fXSiCeRlMaZA46zQ1HI8IsBBmnD2/5Ug8UhHdWC8OqDUtCu4j3oyEY+vao8evu45fRFSvZolk8rlnS8vUBsujD1LtTdcSqdy/ZUkiY6YaSDz0btlTflmD0n76KEHk06p2mXXRpdcM9tN9wFU0ebRhJ1mnFUtd555v1TZQp3Yw/AD+23CNE1oybljM4fpfHhI11b+HQRpGxcxqGT6EIPckJ6VNpzT/61hHRQRiVAtWQFmMFSw9J2a2ygnLDPqAOi1ZYJRrHp4Gl+vt9yc59m85WsWMvauLgrVij4QflzL
X-MS-Exchange-AntiSpam-MessageData: wuB6xx4jInRHd1pTkyLDxLhdDoOnRuur4OBCFBdWwqYNV1sFN80XzXfzGR9ZRdTeLG/wCMjX0gH7E6iA6g41K2FA6uUGDZYnzEmTrg7+0w5LDM5Q4YOa54sD4ECA64TKuk1Hvh2RcU5jrLMD0hTqbg==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1db6e2-a6d5-483c-94f5-08d7c82d6a79
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:08.3569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOq98IYyJLYDe8gN18irsZ/Zo+wEk0U5INplR5ZqDEf8JS0oGVxmWPWM4zte9ujpt/rI5TY6mTL4+N9OyCwjuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add ARM64-specific code to set up and handle the interrupts
generated by Hyper-V for VMbus messages and for stimer expiration.

This code is architecture dependent and is mostly driven by
architecture independent code in the VMbus driver and the
Hyper-V timer clocksource driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/arm64/hyperv/Makefile   |   2 +-
 arch/arm64/hyperv/mshyperv.c | 139 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 140 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/hyperv/mshyperv.c

diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
index 1697d30..87c31c0 100644
--- a/arch/arm64/hyperv/Makefile
+++ b/arch/arm64/hyperv/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y		:= hv_core.o
+obj-y		:= hv_core.o mshyperv.o
diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
new file mode 100644
index 0000000..ae6ece6
--- /dev/null
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Core routines for interacting with Microsoft's Hyper-V hypervisor,
+ * including setting up VMbus and STIMER interrupts, and handling
+ * crashes and kexecs. These interactions are through a set of
+ * static "handler" variables set by the architecture independent
+ * VMbus and STIMER drivers.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/interrupt.h>
+#include <linux/kexec.h>
+#include <linux/acpi.h>
+#include <linux/ptrace.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+static void (*vmbus_handler)(void);
+static void (*hv_stimer0_handler)(void);
+
+static int vmbus_irq;
+static long __percpu *vmbus_evt;
+static long __percpu *stimer0_evt;
+
+irqreturn_t hyperv_vector_handler(int irq, void *dev_id)
+{
+	vmbus_handler();
+	return IRQ_HANDLED;
+}
+
+/* Must be done just once */
+void hv_setup_vmbus_irq(void (*handler)(void))
+{
+	int result;
+
+	vmbus_handler = handler;
+	vmbus_irq = acpi_register_gsi(NULL, HYPERVISOR_CALLBACK_VECTOR,
+				 ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (vmbus_irq <= 0) {
+		pr_err("Can't register Hyper-V VMBus GSI. Error %d",
+			vmbus_irq);
+		vmbus_irq = 0;
+		return;
+	}
+	vmbus_evt = alloc_percpu(long);
+	result = request_percpu_irq(vmbus_irq, hyperv_vector_handler,
+			"Hyper-V VMbus", vmbus_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V VMBus IRQ %d. Error %d",
+			vmbus_irq, result);
+		free_percpu(vmbus_evt);
+		acpi_unregister_gsi(vmbus_irq);
+		vmbus_irq = 0;
+	}
+}
+EXPORT_SYMBOL_GPL(hv_setup_vmbus_irq);
+
+/* Must be done just once */
+void hv_remove_vmbus_irq(void)
+{
+	if (vmbus_irq) {
+		free_percpu_irq(vmbus_irq, vmbus_evt);
+		free_percpu(vmbus_evt);
+		acpi_unregister_gsi(vmbus_irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_enable_vmbus_irq(void)
+{
+	enable_percpu_irq(vmbus_irq, 0);
+}
+EXPORT_SYMBOL_GPL(hv_enable_vmbus_irq);
+
+/* Must be done by each CPU */
+void hv_disable_vmbus_irq(void)
+{
+	disable_percpu_irq(vmbus_irq);
+}
+EXPORT_SYMBOL_GPL(hv_disable_vmbus_irq);
+
+/* Routines to do per-architecture handling of STIMER0 when in Direct Mode */
+
+static irqreturn_t hv_stimer0_vector_handler(int irq, void *dev_id)
+{
+	if (hv_stimer0_handler)
+		hv_stimer0_handler();
+	return IRQ_HANDLED;
+}
+
+int hv_setup_stimer0_irq(int *irq, int *vector, void (*handler)(void))
+{
+	int localirq;
+	int result;
+
+	localirq = acpi_register_gsi(NULL, HV_STIMER0_IRQNR,
+			ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
+	if (localirq <= 0) {
+		pr_err("Can't register Hyper-V stimer0 GSI. Error %d",
+			localirq);
+		*irq = 0;
+		return -1;
+	}
+	stimer0_evt = alloc_percpu(long);
+	result = request_percpu_irq(localirq, hv_stimer0_vector_handler,
+					 "Hyper-V stimer0", stimer0_evt);
+	if (result) {
+		pr_err("Can't request Hyper-V stimer0 IRQ %d. Error %d",
+			localirq, result);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(localirq);
+		*irq = 0;
+		return -1;
+	}
+
+	hv_stimer0_handler = handler;
+	*vector = HV_STIMER0_IRQNR;
+	*irq = localirq;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_setup_stimer0_irq);
+
+void hv_remove_stimer0_irq(int irq)
+{
+	hv_stimer0_handler = NULL;
+	if (irq) {
+		free_percpu_irq(irq, stimer0_evt);
+		free_percpu(stimer0_evt);
+		acpi_unregister_gsi(irq);
+	}
+}
+EXPORT_SYMBOL_GPL(hv_remove_stimer0_irq);
-- 
1.8.3.1

