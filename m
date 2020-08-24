Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B462503EE
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgHXQxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 12:53:43 -0400
Received: from mail-dm6nam12on2118.outbound.protection.outlook.com ([40.107.243.118]:61408
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728745AbgHXQsI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 12:48:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXtdlGIc60rR9Dgw12ZJsRetmU8/hyJ9roe+2QIT1KvxXjFA1cNqzVjctUB865P6Hn1Wuvq4tc8vCyVHjVRz32m7+UCRN0LedKcGWGOYikf4vyY1Ru2Y6s3fj66pulbFCUEF88vG19AoA1p2KqaXCaxAcp/ymRSKoqLaOt9+aoTxyQUYGbC3Clo6Me8HX2wAEqPPPqgNvB5smjhm57UopYovrNUDJOebit2Un0URKo0BLClh9pooalO6bwQzjVAwgUm20/PFu4g597FpALkDZfKsCmNH6ylokqPgJSwSu/+n0K+gE2hosTHxISns/yDAX/10SlZVJdtfW7n9HoBcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcCR/WoCm5Jo6xIeBKedm97HiNYcdoR2x1QnnxGq4IM=;
 b=dYa0o4d7Pj4+Z0GmtWWFLbF7AKEEMFlcp9BT8K4jmdSQxrIDMax/d/q3keaMYPNeRyUtwjTG6K3o71OMSI/elPmn1Dzc3vBNqET4IbHo440lAgQvZ0/gBvlBVsFNVRY7xVcamKcpS7q/6Ka6ohrk44twOpgwEpX/6tbBHdExac621OP70JzvPURTDf6Ub1yBBNfCFRtcxx86PzEzszPfBwzKq6zptYP7+m6bWldP/jl6M2SeYzYCA5y6jhU7MH0gdvPE7T4jm2Y7ICUzpgR5KL69y5tGCx8EMHZaNJIW2KKa1JHtrvo8lpYe9LIc4r0386edUMpD1wJDAf/PKnZNlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcCR/WoCm5Jo6xIeBKedm97HiNYcdoR2x1QnnxGq4IM=;
 b=Ehe3dkegZLKCfDM00R+zIxx5VxEIR2nm8ObiVn06n+r6BpijshxbtTJ7fdhKxC+Qgy/yELOXQk9acvK8TRXMMR9+6lU7YowwUwvzLbQgSXshFSYj6SNphqVhdy2fTgBsMD1XVkJzLVI4U9GPBADh3yMtSnWqwlNHiYaCk9pZX5E=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
Received: from BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
 by BN6PR21MB0753.namprd21.prod.outlook.com (2603:10b6:404:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.4; Mon, 24 Aug
 2020 16:47:45 +0000
Received: from BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615]) by BN8PR21MB1281.namprd21.prod.outlook.com
 ([fe80::e0c9:2634:6fb1:5615%3]) with mapi id 15.20.3326.012; Mon, 24 Aug 2020
 16:47:45 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     will@kernel.org, ardb@kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, mark.rutland@arm.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arch@vger.kernel.org,
        wei.liu@kernel.org, vkuznets@redhat.com, kys@microsoft.com
Cc:     mikelley@microsoft.com, sunilmut@microsoft.com,
        boqun.feng@gmail.com
Subject: [PATCH v7 02/10] arm64: hyperv: Add core Hyper-V include files
Date:   Mon, 24 Aug 2020 09:46:15 -0700
Message-Id: <1598287583-71762-3-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23)
 To BN8PR21MB1281.namprd21.prod.outlook.com (2603:10b6:408:a2::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by CO2PR04CA0145.namprd04.prod.outlook.com (2603:10b6:104::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Mon, 24 Aug 2020 16:47:43 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.16]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8658d2c-1323-418f-5f7e-08d8484d6ce1
X-MS-TrafficTypeDiagnostic: BN6PR21MB0753:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR21MB0753DA24B234D5095C929DF7D7560@BN6PR21MB0753.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LaTUmnHsLYcuM241Bk0CtarUyCJ7NxqX+UwP2q4CQ3YdBzJoKlOKVhaQM1Yk68ap4gpVsl4zxEP5IY7s/xKuisNQgZxH8y19OSId1kQ3/T3RFzc4O/O9XQv0CirDwDLgNi/wdDmUaRCaHpWKz+Vj37cSk05fjU3dHgC2JszXAE7Lw7GLN7V5E2E731TkrUVW9b9ssPWLcEyM0GMDc6h6JVr87cNo24GuGue9ahwAx8J9BYsUy9qIua2A5RJuLv7hypmFCZCC+asKnk4eaZ7Jh20ZgeXv9bHvv5WCG6eT7xvVOgagwyP4RRfYbwOvyRSUdsTEJnH/2QdGY0n7TufEkNzUkzjSgiK5YcF9a8TxNKKX3ei2DUhEikmRneK4Oh6eWvFxYhsMvWRfjW54JNvML+LKsnLIJzii4QyMw4BOmODGmxT5f32sSYaqta8LIKm+gbbUK1MMHyWRjRLNAKW0FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR21MB1281.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(8676002)(86362001)(2616005)(956004)(2906002)(6486002)(8936002)(52116002)(10290500003)(5660300002)(66946007)(16576012)(66556008)(4326008)(6636002)(316002)(36756003)(186003)(82950400001)(478600001)(26005)(6666004)(66476007)(82960400001)(83380400001)(7416002)(966005)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: tPggJf7ehwhRHGhkYrFFhZbQ0rsYLoEzozKz5mZEMoJANKb6ImKztAXNKAroq+xqeVeWxqJaovba+IO7vcj8Dl8iKSbW1qp5Nut1mtUKoDWeYt0B+ZRqQujH8kXugVgVzYwgqvQfePN8q051cjPoBcI/cGK7xcX97TAk7Jk0OdBnGvsdiN3x64cnmFHEffxvX7Z8E4EqhTnYJc217A60sIRtwfAhpEaiO6yB+HpMmRPQsrZ7ORbQiITDI80JAULp0L2c/zpI/mz9dZJW5Atro2KhpJs6oum/vQasCflwIeMz+NIjTLcwDL4bcL4NoKTA1tL9PdB+QZsg1qikYLUuoEkMwPPw333Nq0Y5kiQaR9s05i2Sxr89/+VAiLnISx7x2r8FOVWBXYfwurMpTAu/q+98+4Z71DbUZnHNZrwzxPF3PDT0DyNJRdHI1ks6NXLbLX04g+srlyiU9fRkSpliU+SUsXK0x/6AxxKeuzfbcJm6LCHqms6xeSmM6CZomSbfiB/oTxV5dwV9INCla6DL2ryZ6wEwfFTdxNGw8kVrXZWWTAQaFiCz6SUmo+8Bfdo8LbAQiQF0nr2eRNM9kSxW14XBOUIm5M3FPb8p7eUhg1g5gQ97nF7Ed+B/QWgzlNjXgiBHjCN0eLwZ2OOF9cNa1Q==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8658d2c-1323-418f-5f7e-08d8484d6ce1
X-MS-Exchange-CrossTenant-AuthSource: BN8PR21MB1281.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 16:47:45.0605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ryetExZqn4dJUxrljnL0fXmIS4ck29PSy2ThmW5LZrwIyaTSPlN39z7Eyi6nM4aJx5VmU4UV47+y4AyybPrXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0753
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
Functional Spec (TLFS), and #includes the architecture-independent
part of hyperv-tlfs.h in include/asm-generic.  The published TLFS
is distinctly oriented to x86/x64, so the ARM64-specific
hyperv-tlfs.h includes information for ARM64 that is not yet formally
published. The TLFS is available here:

  docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

mshyperv.h defines Linux-specific structures and routines for
interacting with Hyper-V on ARM64, and #includes the architecture-
independent part of mshyperv.h in include/asm-generic.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 MAINTAINERS                          |  2 +
 arch/arm64/include/asm/hyperv-tlfs.h | 94 ++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    | 76 +++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4179dfa..803bade 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8054,6 +8054,8 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
+F:	arch/arm64/include/asm/hyperv-tlfs.h
+F:	arch/arm64/include/asm/mshyperv.h
 F:	arch/x86/hyperv
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/include/asm/mshyperv.h
diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
new file mode 100644
index 0000000..09f5228
--- /dev/null
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file contains definitions from the Hyper-V Hypervisor Top-Level
+ * Functional Specification (TLFS):
+ * https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#ifndef _ASM_HYPERV_TLFS_H
+#define _ASM_HYPERV_TLFS_H
+
+#include <linux/types.h>
+
+/*
+ * All data structures defined in the TLFS that are shared between Hyper-V
+ * and a guest VM use Little Endian byte ordering.  This matches the default
+ * byte ordering of Linux running on ARM64, so no special handling is required.
+ */
+
+/*
+ * These Hyper-V registers provide information equivalent to the CPUID
+ * instruction on x86/x64.
+ */
+#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
+#define HV_REGISTER_FEATURES			0x00000200 /*CPUID 0x40000003 */
+#define HV_REGISTER_ENLIGHTENMENTS		0x00000201 /*CPUID 0x40000004 */
+
+/*
+ * Group C Features. See the asm-generic version of hyperv-tlfs.h
+ * for a description of Feature Groups.
+ */
+
+/* Crash MSRs available */
+#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
+
+/* STIMER direct mode is available */
+#define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
+
+/*
+ * Synthetic register definitions equivalent to MSRs on x86/x64
+ */
+#define HV_REGISTER_CRASH_P0		0x00000210
+#define HV_REGISTER_CRASH_P1		0x00000211
+#define HV_REGISTER_CRASH_P2		0x00000212
+#define HV_REGISTER_CRASH_P3		0x00000213
+#define HV_REGISTER_CRASH_P4		0x00000214
+#define HV_REGISTER_CRASH_CTL		0x00000215
+
+#define HV_REGISTER_GUEST_OSID		0x00090002
+#define HV_REGISTER_VPINDEX		0x00090003
+#define HV_REGISTER_TIME_REFCOUNT	0x00090004
+#define HV_REGISTER_REFERENCE_TSC	0x00090017
+
+#define HV_REGISTER_SINT0		0x000A0000
+#define HV_REGISTER_SCONTROL		0x000A0010
+#define HV_REGISTER_SIFP		0x000A0012
+#define HV_REGISTER_SIPP		0x000A0013
+#define HV_REGISTER_EOM			0x000A0014
+
+#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
+#define HV_REGISTER_STIMER0_COUNT	0x000B0001
+
+/*
+ * Define hypervisor message types. These must be
+ * included in the architecture specific hyperv-tlfs.h
+ * because there are processor specific values on the
+ * x86 side.
+ */
+enum hv_message_type {
+	HVMSG_NONE			= 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA		= 0x80000000,
+	HVMSG_GPA_INTERCEPT		= 0x80000001,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED		= 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE	= 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION	= 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE	= 0x80000022,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE	= 0x80000040,
+};
+
+#include <asm-generic/hyperv-tlfs.h>
+
+#endif
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
new file mode 100644
index 0000000..6b1f26c
--- /dev/null
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Linux-specific definitions for managing interactions with Microsoft's
+ * Hyper-V hypervisor. The definitions in this file are specific to
+ * the ARM64 architecture.  See include/asm-generic/mshyperv.h for
+ * definitions are that architecture independent.
+ *
+ * Definitions that are specified in the Hyper-V Top Level Functional
+ * Spec (TLFS) should not go in this file, but should instead go in
+ * hyperv-tlfs.h.
+ *
+ * Copyright (C) 2019, Microsoft, Inc.
+ *
+ * Author : Michael Kelley <mikelley@microsoft.com>
+ */
+
+#ifndef _ASM_MSHYPERV_H
+#define _ASM_MSHYPERV_H
+
+#include <linux/types.h>
+#include <linux/interrupt.h>
+#include <linux/clocksource.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
+#include <linux/arm-smccc.h>
+#include <asm/hyperv-tlfs.h>
+
+/* Access various Hyper-V synthetic registers */
+static inline void hv_set_simp(u64 val)
+{
+	hv_set_vpreg(HV_REGISTER_SIPP, val);
+}
+
+#define hv_get_simp(val) (val = hv_get_vpreg(HV_REGISTER_SIPP))
+
+static inline void hv_set_siefp(u64 val)
+{
+	hv_set_vpreg(HV_REGISTER_SIFP, val);
+}
+
+#define hv_get_siefp(val) (val = hv_get_vpreg(HV_REGISTER_SIFP))
+
+static inline void hv_set_synic_state(u64 val)
+{
+	hv_set_vpreg(HV_REGISTER_SCONTROL, val);
+}
+
+#define hv_get_synic_state(val) (val = hv_get_vpreg(HV_REGISTER_SCONTROL))
+
+static inline bool hv_recommend_using_aeoi(void)
+{
+	return false;
+}
+
+static inline void hv_signal_eom(void)
+{
+	hv_set_vpreg(HV_REGISTER_EOM, 0);
+}
+
+/*
+ * Hyper-V SINT registers are numbered sequentially, so we can just
+ * add the SINT number to the register number of SINT0
+ */
+
+static inline void hv_set_synint_state(u32 sint_num, u64 val)
+{
+	hv_set_vpreg(HV_REGISTER_SINT0 + sint_num, val);
+}
+
+#define hv_get_synint_state(sint_num, val) \
+		(val = hv_get_vpreg(HV_REGISTER_SINT0 + sint_num))
+
+#include <asm-generic/mshyperv.h>
+
+#endif
-- 
1.8.3.1

