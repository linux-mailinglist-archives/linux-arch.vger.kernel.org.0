Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6C2503E9
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgHXQxm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:53:42 -0400
Received: from mail-dm6nam12on2120.outbound.protection.outlook.com ([40.107.243.120]:2560
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728693AbgHXQsI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY1g8XQiB/oy2ZmGf4fV67VPcYuUH2kBnxkKJTn4FbyGHWYrqLra2zg5kyMzGSG+XGXSqWzUgcm1EBxYCdWzzPDH6ROQIC2zBheyZ6U3VFmjMkHiKrWu5EzDZMWaLoub6YGL09/iowWD4pJ/eqAVSvnEHnr/D4VqFUZ0vIwK8xBLuBq7DFM0p62N7JRxw8EHbawZIkDl0wxNeQxSJZ7e3FlIjDujcot7qe2p/lbl1SRAZ5nhT7zGYmK9VowP+W+lLd/y2V4k7EleZU3FM5JbnIiaTmXgTZ6f6jzBSRPX/AOsMvtvprSXZFPkUnb6sPtNd7NSUyGWwjQ52TgakGuZAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPEJ0LhBMi11K0Ceh46uoxwvptx+cBGqVsPdtnOFmDs=;
 b=Qo0Rvh1VACgjPuDRvNrGtqLOamEEzFRMISslMpz38z4nwz4NGD0h9VIrnqx7Hs1h4oHkpRmjFn/qBwFrrgUhfNKZw/WtEhq4aEIVMyXKw7nKyUpNWANL8PqrZwtvgyUM+wxj8XyoFlcxtXGJ6gNn2/Km2/BucJrG+2d38usqi8RzqkLz3l7Sx9iL3u5E0QkEAiKl5BRhki8HDjL6of53z5afebMb0FqtoJgUR2Jws6vLad3YdLtMtZGx1c0elcNSl8mnNb75LTpXSJ8P0wlCTD3SJE+sYH5gp0YbM37I1Yb5MtI23iY1uch1LjJNoIO1aWh2U/1F02Hkqtdn3uN/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VPEJ0LhBMi11K0Ceh46uoxwvptx+cBGqVsPdtnOFmDs=;
 b=Ltt4zHfUQjH5WsGVRj1yxuy4je+4/z+1z4hseDgPq6KycR0hfJoOJo3V+mLLrRwalHuE/espKmPqBeqJET82brTLoVCyXePxuXTyNxLyV2SLST/D+XgDoTdfpHf6PfN+tNE8lWkKMlJ1wo5l8iaPo0e/KfygIK2Y9ywBvsAJP+I=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:47:47 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:47:47 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 03/10] arm64: hyperv: Add hypercall and register access functions
Date:   Mon, 24 Aug 2020 09:46:16 -0700
Message-Id: <1598287583-71762-4-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:45 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7a6c7132-c485-482a-7f73-08d8484d6dfb
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB07533D716FC9234FA8AD5C21D7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NKLnWbe3nG96eEVc/lwsVnRi494T20LfGTLTZO26q2NnISbO+DZFK+vTJgMhQos9C+0YkKHUbCqi5yMAg3CzIApwTOfH9A6IeAlx9uBcz7wc/AxwyC5XQEpz5uPbc+o/8Oa6YL2qTxUa826fXDEjP4Gp1vqGC+lg7Bv3XXT6hferMcpfubG18VvtBoMOxIgBCEWLSjboSRtBvhRDUHxtJzBPkQJsJTfWOYbLg2jhccBihhAuuuoaAJChHTiykArkY2pA/RCPhce5TPz4NvI8BZ6byxDNQskeMJ4z3pynuXAo/BBi3lMXN2fcwPFvQQb7qahGqCG53G6XCO4s4vkjaA+4GhRFG5njyElBjVbQbmhqLKau/DJME0mnaM4BdKYd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: oDZda5zL9jVjdJihUxd60n/KWejz+XQDuq6G60DtfamhU8kPUARDNywpYLYoLtwoIO7Dg4HtpQBFDRH4u9iDCVEVLajp+AZ9Nr7SqKW4l3G3WhaPhLGZdqaVGy51uupA3cAbt0hk56Zuj1c/wIEmDhV1eTP5gMtANLkCp01jLWAhfDmVwCa4PyT0yn5Gzj5jyUY3q4BJYDXqkHRVIc0Czcywxo4gVfOfRbOjwwxIoC7g5T4/EDml2/9B7zByzmqXCAHDRM6LbusWRqhlO+ajWvHZmIC62IIuZUueb+0+nrU7X6aVHlotEdfCqakACzpsW1/iqHDB//0GEyds+1Zatt1A7mBQfcGOkwEOF9f46V4/A+X/lLCou47evSRHgGqp/8eYGiailUIt/Nek/VdmPxL8O6mSfle5XZKeW5lcyvQBPaLjbUvz3KgbnO8QYps1y0uMk7V2zB52iar9f6WeQQBvkaDMZ6n/cElKumVgPYCGj1OCpJ9u+7FZhE6+7cavNTxQ9AZZChnTYykm4g5UUxN+EH2snsZrXtbGQNN0v1R8oA1tfOTV5N28v+t8A8f39Uujj+gCAkWQj6hMpU/3aSioD5CWvxXyKw3b7+6MzwGr77FYofz76Tgb5ZSw5Uu3eA+KAj9RkoWoESJNYwnnyQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6c7132-c485-482a-7f73-08d8484d6dfb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:46.9044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zd5xBIA/OY6yc0m10dkWU++ye8n43jFacXJBpAScP9kcmb3oVog2eEWZC93K19I2jomNYZInZA5xqvUwIIiymA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
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
 MAINTAINERS                       |   1 +
 arch/arm64/Kbuild                 |   1 +
 arch/arm64/hyperv/Makefile        |   2 +
 arch/arm64/hyperv/hv_core.c       | 170 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h |  17 ++++
 5 files changed, 191 insertions(+)
 create mode 100644 arch/arm64/hyperv/Makefile
 create mode 100644 arch/arm64/hyperv/hv_core.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 803bade..f67d208 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8054,6 +8054,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+F:	arch/arm64/hyperv
 F:	arch/arm64/include/asm/hyperv-tlfs.h
 F:	arch/arm64/include/asm/mshyperv.h
 F:	arch/x86/hyperv
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
index 0000000..9b35011
--- /dev/null
+++ b/arch/arm64/hyperv/hv_core.c
@@ -0,0 +1,170 @@
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
+#include <linux/log2.h>
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
+	struct arm_smccc_res res;
+
+	arm_smccc_1_1_hvc(
+		HV_FUNC_ID,
+		HVCALL_SET_VP_REGISTERS | HV_HYPERCALL_FAST_BIT |
+			HV_HYPERCALL_REP_COMP_1,
+		HV_PARTITION_ID_SELF,
+		HV_VP_INDEX_SELF,
+		msr,
+		0,
+		value,
+		0,
+		&res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * setting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON((res.a0 & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS);
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
+static void __hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
+{
+	struct hv_get_vp_registers_input	*input;
+	u64					status;
+
+	/*
+	 * Allocate a power of 2 size so alignment to that size is
+	 * guaranteed, since the hypercall input area must not cross
+	 * a page boundary.
+	 */
+
+	input = kzalloc(roundup_pow_of_two(sizeof(input->header) +
+				sizeof(input->element[0])), GFP_ATOMIC);
+
+	input->header.partitionid = HV_PARTITION_ID_SELF;
+	input->header.vpindex = HV_VP_INDEX_SELF;
+	input->header.inputvtl = 0;
+	input->element[0].name0 = msr;
+	input->element[0].name1 = 0;
+
+
+	status = hv_do_hypercall(
+		HVCALL_GET_VP_REGISTERS | HV_HYPERCALL_REP_COMP_1,
+		input, res);
+
+	/*
+	 * Something is fundamentally broken in the hypervisor if
+	 * getting a VP register fails. There's really no way to
+	 * continue as a guest VM, so panic.
+	 */
+	BUG_ON((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS);
+
+	kfree(input);
+}
+
+u64 hv_get_vpreg(u32 msr)
+{
+	struct hv_get_vp_registers_output	*output;
+	u64					result;
+
+	/*
+	 * Allocate a power of 2 size so alignment to that size is
+	 * guaranteed, since the hypercall output area must not cross
+	 * a page boundary.
+	 */
+	output = kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, output);
+
+	result = output->as64.low;
+	kfree(output);
+	return result;
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg);
+
+void hv_get_vpreg_128(u32 msr, struct hv_get_vp_registers_output *res)
+{
+	struct hv_get_vp_registers_output	*output;
+
+	/*
+	 * Allocate a power of 2 size so alignment to that size is
+	 * guaranteed, since the hypercall output area must not cross
+	 * a page boundary.
+	 */
+	output = kmalloc(roundup_pow_of_two(sizeof(*output)), GFP_ATOMIC);
+
+	__hv_get_vpreg_128(msr, output);
+
+	res->as64.low = output->as64.low;
+	res->as64.high = output->as64.high;
+	kfree(output);
+}
+EXPORT_SYMBOL_GPL(hv_get_vpreg_128);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index 6b1f26c..b17d4a1 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -26,6 +26,14 @@
 #include <linux/arm-smccc.h>
 #include <asm/hyperv-tlfs.h>
 
+/*
+ * Declare calls to get and set Hyper-V VP register values on ARM64, which
+ * requires a hypercall.
+ */
+extern void hv_set_vpreg(u32 reg, u64 value);
+extern u64 hv_get_vpreg(u32 reg);
+extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_registers_output *result);
+
 /* Access various Hyper-V synthetic registers */
 static inline void hv_set_simp(u64 val)
 {
@@ -71,6 +79,15 @@ static inline void hv_set_synint_state(u32 sint_num, u64 val)
 #define hv_get_synint_state(sint_num, val) \
 		(val = hv_get_vpreg(HV_REGISTER_SINT0 + sint_num))
 
+
+/* SMCCC hypercall parameters */
+#define HV_SMCCC_FUNC_NUMBER	1
+#define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
+				ARM_SMCCC_STD_CALL,		\
+				ARM_SMCCC_SMC_64,		\
+				ARM_SMCCC_OWNER_VENDOR_HYP,	\
+				HV_SMCCC_FUNC_NUMBER)
+
 #include <asm-generic/mshyperv.h>
 
 #endif
-- 
1.8.3.1

