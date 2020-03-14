Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7830F185726
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbgCOBbs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:31:48 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbgCOBbr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZUqJ8+eA8hUyqZ43gerALXM1dyMVoxUjgsvAJCQM3mnCZSWNT4MM5Rli03ev8n9OQYj/UaOZwUYBLmdymDVOQZCzcD7ncKrQG1HawPhHYs5Gbqcapt4SUP/sMtDZv+ZHUh7h7NVhnEOwQZbMKhR6Ce5AL7cHfabIHqkeo3uoMQsYLbxeBhK2Dp3chTQ0EqPcXkiWEECEZtd4gaV1cEXAdoW4bR6zOuu8Q9wFsrhyGHIqnVIjuHKf1VZMuWVKEmEkxffJ2VHhoIwPAeZFFehNxxwBsKDAnqWKFMvdy+6Lo+TedN+hoIFlDOaMOC3T7Mdt3+F3OL2gCUmxOOxqmdPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HY2jmpnXj4QFkoZRyzN8sK+fGwe2kEsfoV1rfliB98=;
 b=fPhjRQiihFeEKucagvD9nl1M/en+B3G8UQ770v8l/LOK7vtosEp7en1lyLl6BBBeHt3K6lbD2IwmLGdMi7A5ZkenO1S4vkpfbOtnr2/bRcVIYTX8P0AR+apztKeI2FX3+8bVnQ3XiG0Gi2+Asm2bbBNSRKofiGSdvGPczKIJ1ePo1QuyHMRbqytsNvH9Tbv53lcOZkFbcCS7aO/qSwiUJTdIdpn8LksNSKEoT3TXWyhOu1qfJtE4M1GjFTI1AiukXLiza1l7hn+wwV+W8Egy31V+BCLMQl91MePpVMJ4sJsT2s2fyCOGtCYlP2TIzMj7exp5XiJOXGueBei2ZiBMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HY2jmpnXj4QFkoZRyzN8sK+fGwe2kEsfoV1rfliB98=;
 b=BaKg0vYs1vpIQq24k0lIrNbl9lyRRxl1ubYX9aHoNUC9X0iwCxzBnqpk5vYbLLlfrPUkHpHE90Ai2nKScZ5P3E1NIBRCO/8FjKa2Wms5tpsiJbGfR7F8qoUgCfHBFncRL/LHO9E7vCoVuPxvlrw/0BnINxw5nEcjf5rC2uRHSC0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:05 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:05 +0000
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
Subject: [PATCH v6 03/10] arm64: hyperv: Add hypercall and register access functions
Date:   Sat, 14 Mar 2020 08:35:12 -0700
Message-Id: <1584200119-18594-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:04 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 296d400a-de3d-470e-841e-08d7c82d68bb
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB16322C45A64D742DF848688AD7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(6666004)(5660300002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ok8FefDuarPhTpEDFd2tGbFTijr9z64PohOucW/sFUfa0pxKZ8sygE0y3cxNBJjlq9Y3NRxzhVUL40ITxfSg5xhPHpGZfvfWx0+eebUIpavfKKkIfZh8Ehlf44hz/o4ydFIULbAXGJvOu+aQavU/RrM+uYys1vYenZHyKe7El1DRPqLvJxc1lmh7alwH23KnneY/LELpPnxYmtCwJ4b+9J3uvt7WcD5mbUCKUhHjCujoJQes/kIuuWGDn9d4CFP1BkIH7KxztscDSliiwoCQL6yvMg6T2chpkxe0qKTPuRm1aspbaBXdr6+7eugXMXlmY8DdrT0Z50OdTlNliEiCxJSLGmnC3ERMikhNXCjJ79+mG0TaIc+jvJ6nUm10n2RzOkYEpFQq0tBeR7AX1koPCmPqnnkKLCKaUKJbVa873FdC2QlDUCein4QbG8GWihOHrvWslr9ySxa1IBctJIPSlMVCrXFindQ0JgCr7+kBf8oQk+FB8gSKQ55Wh+CfXtMf
X-MS-Exchange-AntiSpam-MessageData: unB1MjOcD9nJuiPsC0j5SIP3nubCdE1kR0tupy3XD3UKo3j4xj+pZ6c2Yb6sfMdWOHCOlmJkXZb5ec8+j86UO2UK3iJYH5TT49Gz7VYcDCfGaBS/msfS4qUqSem99Qhtn81OLD4EU5kOkdr28ecZEQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296d400a-de3d-470e-841e-08d7c82d68bb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:05.3906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VaQLiK4BVdxoApHpiU8uwix3ZFI/M5AH5jXUKRMoEeiJDZIPToIyUTv3dUeN6f8C7VSLzbZMtVjTnHFejdhexw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add ARM64-specific code to make Hyper-V hypercalls and to
access virtual processor synthetic registers via hypercalls.
Hypercalls follow the SMC Calling Convention spec v1.1.

This code is architecture dependent and is mostly driven by
architecture independent code in the VMbus driver and the
Hyper-V timer clocksource driver.

This code is built only when CONFIG_HYPERV is enabled.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 MAINTAINERS                 |   1 +
 arch/arm64/Kbuild           |   1 +
 arch/arm64/hyperv/Makefile  |   2 +
 arch/arm64/hyperv/hv_core.c | 167 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 398cfdb..64ad2bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7811,6 +7811,7 @@ F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
 F:	arch/arm64/include/asm/hyperv-tlfs.h
 F:	arch/arm64/include/asm/mshyperv.h
+F:	arch/arm64/hyperv
 F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
diff --git a/arch/arm64/Kbuild b/arch/arm64/Kbuild
index d646582..7a37608 100644
--- a/arch/arm64/Kbuild
+++ b/arch/arm64/Kbuild
@@ -3,4 +3,5 @@ obj-y			+= kernel/ mm/
 obj-$(CONFIG_NET)	+= net/
 obj-$(CONFIG_KVM)	+= kvm/
 obj-$(CONFIG_XEN)	+= xen/
+obj-$(subst m,y,$(CONFIG_HYPERV))	+= hyperv/
 obj-$(CONFIG_CRYPTO)	+= crypto/
diff --git a/arch/arm64/hyperv/Makefile b/arch/arm64/hyperv/Makefile
new file mode 100644
index 0000000..1697d30
--- /dev/null
+++ b/arch/arm64/hyperv/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-y		:= hv_core.o
diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
new file mode 100644
index 0000000..272c348
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Initialization of the interface with Microsoft's Hyper-V hypervisor,
+ * and various low level utility routines for interacting with Hyper-V.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/export.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/hyperv.h>
+#include <linux/arm-smccc.h>
+#include <asm-generic/bug.h>
+#include <asm/hyperv-tlfs.h>
+#include <asm/mshyperv.h>
+
+
+/*
+ * hv_do_hypercall- Invoke the specified hypercall
+ */
+u64 hv_do_hypercall(u64 control, void *input, void *output)
+{
+	u64 input_address;
+	u64 output_address;
+	struct arm_smccc_res res;
+
+	input_address = input ? virt_to_phys(input) : 0;
+	output_address = output ? virt_to_phys(output) : 0;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control,
+			  input_address, output_address, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_hypercall);
+
+/*
+ * hv_do_fast_hypercall8 -- Invoke the specified hypercall
+ * with arguments in registers instead of physical memory.
+ * Avoids the overhead of virt_to_phys for simple hypercalls.
+ */
+
+u64 hv_do_fast_hypercall8(u16 code, u64 input)
+{
+	u64 control;
+	struct arm_smccc_res res;
+
+	control = (u64)code | HV_HYPERCALL_FAST_BIT;
+
+	arm_smccc_1_1_hvc(HV_FUNC_ID, control, input, &res);
+	return res.a0;
+}
+EXPORT_SYMBOL_GPL(hv_do_fast_hypercall8);
+
+
+/*
+ * Set a single VP register to a 64-bit value.
+ */
+void hv_set_vpreg(u32 msr, u64 value)
+{
+	union hv_hypercall_status status;
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(
+		HV_FUNC_ID,
+		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COUNT_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		value,
+		0,
+		&res);
+	status.as_uint64 = res.a0;
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * setting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+}
+EXPORT_SYMBOL_GPL(hv_set_vpreg);
+
+/*
+ * Get the value of a single VP register.  One version
+ * returns just 64 bits and another returns the full 128 bits.
+ * The two versions are separate to avoid complicating the
+ * calling sequence for the more frequently used 64 bit version.
+ */
+
+/*
+ * Input and output memory allocation sizes are rounded up to a power
+ * of 2 so kmalloc() will guarantee alignment. In turn, the alignment
+ * ensures that the allocations don't cross a page boundary, which is
+ * required by the hypercall interface.
+ */
+#define INPUTSIZE (4 * sizeof(u64))
+#define OUTPUTSIZE (2 * sizeof(u64))
+
+static void __hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *res)
+{
+	union hv_hypercall_status		status;
+	struct hv_get_vp_register_input		*input;
+
+	BUILD_BUG_ON(sizeof(*input) > INPUTSIZE);
+
+	input = kzalloc(INPUTSIZE, GFP_ATOMIC);
+
+	input->partitionid = HV_PARTITION_ID_SELF;
+	input->vpindex = HV_VP_INDEX_SELF;
+	input->inputvtl = 0;
+	input->name0 = msr;
+	input->name1 = 0;
+
+
+	status.as_uint64 = hv_do_hypercall(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COUNT_1,
+		input, res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON(status.status != HV_STATUS_SUCCESS);
+
+	kfree(input);
+}
+
+u64 hv_get_vpreg(u32 msr)
+{
+	struct hv_get_vp_register_output	*output;
+	u64					result;
+
+	BUILD_BUG_ON(sizeof(*output) > OUTPUTSIZE);
+	output = kmalloc(OUTPUTSIZE, GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, output);
+
+	result = output->registervaluelow;
+	kfree(output);
+	return result;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_register_output *res)
+{
+	struct hv_get_vp_register_output	*output;
+
+	BUILD_BUG_ON(sizeof(*output) > OUTPUTSIZE);
+	output = kmalloc(OUTPUTSIZE, GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, output);
+
+	res->registervaluelow = output->registervaluelow;
+	res->registervaluehigh = output->registervaluehigh;
+	kfree(output);
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
-- 
1.8.3.1

