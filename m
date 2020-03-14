Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C221E185703
	for <lists+linux-arch@lfdr.de>; Sun, 15 Mar 2020 02:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCOBbq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 14 Mar 2020 21:31:46 -0400
Received: from mail-mw2nam10on2123.outbound.protection.outlook.com ([40.107.94.123]:18974
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726130AbgCOBbp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 14 Mar 2020 21:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hl/TJWcr1PBX0fjpqqIKJ/Hk1WjDmPFuPSf11pCS7FFoodT2bPQPre5xcMIPNkISPMVph/5M3qvpajiNeHv3WsUz8DDNhCjQEN4XLG14KidEwx0CzkvctKRkDeH2HLStQJauhPVqC4AQywIOHnPAgHyqupkeF1uQJuXRUvRZ/knywgr1mnO+67l0heRUcfTlHbPSRtGQhX04IPfOqdmA8Eeu8oGABrQWGBaXZEeoPVbrHOnAvJ4MxOuJ/SKztTeP0UfVHnXBmO2WgD3IIzlNrs04CodwZO8x4WfFyOM/4BbeT9E/tse6N5JOhQ11uhDAPCQhf4wvSgQDlGLpnmrVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QanxFk025vxiIsqiN1eETAqk8VAxsxtaXEMDhGDsyTI=;
 b=iH6JXPv2E0sOJ7GvbNlbVyhUsAnhpKbJvJvPGsdy1f93HcZ9Buy7OXku8BoiDvdYsWNkzowk+A80WTeEKTKLxnEfUp9A9UJzDdcJD57hw0QvUCB9GhOOVsRdpMBUO9Fr7COjVhc+c0BKHJbQOFWd4cBseciuf0xLaWmGeG2osf7ynLAbfNyvXatg7F6D4jFSMHtIIkngHdJEK07nPeTHHLj/yaBoUzAg2wy+lEXajAr1NlgcKqWAzD6d7NqHya7TFnuvdm5cZ7FxABFySK4OiNNWVKpZXeBtfueQNUvgwXSRpPi8QCE4bgRJTbqeDpn415SJEgAoUtbZCNPkl6FBrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QanxFk025vxiIsqiN1eETAqk8VAxsxtaXEMDhGDsyTI=;
 b=TWv593b+6JnswzbA/3DH+v4aaKq6GrqDFbRULalqsZ/3RbteUTDoIx14DaDvXEGUsJP9gNKIzZ3Ch2jdicGmYVZVNVpH174voGqT0uXBn6P9ENDEOWjoJABLwnfkc9PILfkN1I7DyaRpYIghNQHeAkYM4VVWXu5Hs2Kn8UMWRsY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com (2603:10b6:805:a::18)
 by SN6PR2101MB1632.namprd21.prod.outlook.com (2603:10b6:805:53::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.4; Sat, 14 Mar
 2020 15:36:02 +0000
Received: from SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3]) by SN6PR2101MB0927.namprd21.prod.outlook.com
 ([fe80::a819:6437:1733:17b3%9]) with mapi id 15.20.2835.008; Sat, 14 Mar 2020
 15:36:02 +0000
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
Subject: [PATCH v6 01/10] arm64: hyperv: Add core Hyper-V include files
Date:   Sat, 14 Mar 2020 08:35:10 -0700
Message-Id: <1584200119-18594-2-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
Content-Type: text/plain
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To SN6PR2101MB0927.namprd21.prod.outlook.com
 (2603:10b6:805:a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mhkkerneltest.corp.microsoft.com (131.107.159.247) by MWHPR22CA0047.namprd22.prod.outlook.com (2603:10b6:300:69::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Sat, 14 Mar 2020 15:36:01 +0000
X-Mailer: git-send-email 1.8.3.1
X-Originating-IP: [131.107.159.247]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 976b9e1c-da56-4073-515d-08d7c82d66f2
X-MS-TrafficTypeDiagnostic: SN6PR2101MB1632:|SN6PR2101MB1632:|SN6PR2101MB1632:
X-MS-Exchange-Transport-Forked: True
X-LD-Processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR2101MB16320E9EF5BDACE2F4F39CF7D7FB0@SN6PR2101MB1632.namprd21.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 034215E98F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(199004)(10290500003)(478600001)(2906002)(6486002)(36756003)(8936002)(66946007)(26005)(86362001)(2616005)(16526019)(186003)(956004)(66556008)(6636002)(66476007)(4326008)(7416002)(316002)(81166006)(8676002)(81156014)(52116002)(7696005)(6666004)(30864003)(5660300002)(966005)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB1632;H:SN6PR2101MB0927.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HWnhxky0iKetAWvqO5ph89GCUWx0Bq5GXXI8Q651DJOEL+ixo3h3YS+UEGkq05VvSkiDQ3aYbs/Zs0yWlH1ZpXsARRY6uFkbR5u4T2GEP5GM+a2R1fnNGz6xINz7v7tho/7KHUZc6eZIuS/llgO1qDwZ65nKEbH3EaY+/MytS+n81b52whrrtDsMIksBp73y9Jx8pTeD6h03fnH2k6fTt4YKrQFUaAP0rYKVzykPfPyUtgsfw8sKc5XgoE7G3F8njU3Vj1Vut2pd0dp3qtRBXvxMs6EMj3MMvEZxamUlIneT2eaKAQ67j4ORbS+UQ5fHrG+kjEUHpuz6YS/eY0lf97bvtTlkKgcApBvrwrph97rlywnbrBXRLk57i0Av9zzJdToJQcTa9HitHxrmrmlAsGuYr7pteAk5j9yubXN8Xb0KPM9N3EbLKAVzCyLTwXyoG73cS9Er203KP3fVmgmc/Qr5Iz9PnV3s2n626NooHkcph+4BkElqVfwtwy3jlMDLx3aOov5TFnUcuDUv5qXybHy4ccklf/bc/YMr3ty1BGVvxzpyJc3JjZtIm5wt3SDXV9dPOUYJJEXFtYS5A2IyIQ==
X-MS-Exchange-AntiSpam-MessageData: 7ZFgasucW1Foy1fi519/2RzIecjDzkBeqNmI3V/hZXKLNm3Ob1VZSqG8V7/H2y/TOoA2NJ54KCv4gHNP2FpW7suC6xVgG8DwfcOiZTrkfkZLnU1mP6LX3hEx1kKuTC6W9zri8rArxoDNxs8Ff4LIgQ==
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 976b9e1c-da56-4073-515d-08d7c82d66f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2020 15:36:02.4073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: stDyU91WUvWd8krvAX5+h4AXGbb6/lr5cpCKzBGbuUoamNwxa7px5eYe9aGPiM2S6jj1m3FoHZ9Lm2esNEy5ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1632
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
Functional Spec (TLFS). The TLFS is distinctly oriented to x86/x64,
and Hyper-V has not separated out the architecture-dependent parts into
x86/x64 vs. ARM64. So hyperv-tlfs.h includes information for ARM64
that is not yet formally published. The TLFS is available here:

  docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs

mshyperv.h defines Linux-specific structures and routines for
interacting with Hyper-V on ARM64, and #includes the architecture-
independent part of mshyperv.h in include/asm-generic.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 MAINTAINERS                          |   2 +
 arch/arm64/include/asm/hyperv-tlfs.h | 413 +++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/mshyperv.h    | 115 ++++++++++
 3 files changed, 530 insertions(+)
 create mode 100644 arch/arm64/include/asm/hyperv-tlfs.h
 create mode 100644 arch/arm64/include/asm/mshyperv.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 58bb5c4..398cfdb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7809,6 +7809,8 @@ F:	arch/x86/include/asm/trace/hyperv.h
 F:	arch/x86/include/asm/hyperv-tlfs.h
 F:	arch/x86/kernel/cpu/mshyperv.c
 F:	arch/x86/hyperv
+F:	arch/arm64/include/asm/hyperv-tlfs.h
+F:	arch/arm64/include/asm/mshyperv.h
 F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
diff --git a/arch/arm64/include/asm/hyperv-tlfs.h b/arch/arm64/include/asm/hyperv-tlfs.h
new file mode 100644
index 0000000..5e6a087
--- /dev/null
+++ b/arch/arm64/include/asm/hyperv-tlfs.h
@@ -0,0 +1,413 @@
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
+
+/*
+ * While not explicitly listed in the TLFS, Hyper-V always runs with a page
+ * size of 4096. These definitions are used when communicating with Hyper-V
+ * using guest physical pages and guest physical page addresses, since the
+ * guest page size may not be 4096 on ARM64.
+ */
+#define HV_HYP_PAGE_SHIFT	12
+#define HV_HYP_PAGE_SIZE	(1 << HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK	(~(HV_HYP_PAGE_SIZE - 1))
+
+/*
+ * These Hyper-V registers provide information equivalent to the CPUID
+ * instruction on x86/x64.
+ */
+#define HV_REGISTER_HYPERVISOR_VERSION		0x00000100 /*CPUID 0x40000002 */
+#define	HV_REGISTER_PRIVILEGES_AND_FEATURES	0x00000200 /*CPUID 0x40000003 */
+#define	HV_REGISTER_FEATURES			0x00000201 /*CPUID 0x40000004 */
+#define	HV_REGISTER_IMPLEMENTATION_LIMITS	0x00000202 /*CPUID 0x40000005 */
+#define HV_ARM64_REGISTER_INTERFACE_VERSION	0x00090006 /*CPUID 0x40000001 */
+
+/*
+ * Feature identification. HvRegisterPrivilegesAndFeaturesInfo returns a
+ * 128-bit value with flags indicating which features are available to the
+ * partition based upon the current partition privileges. The 128-bit
+ * value is broken up with different portions stored in different 32-bit
+ * fields in the ms_hyperv structure.
+ */
+
+/* Partition Reference Counter available*/
+#define HV_MSR_TIME_REF_COUNT_AVAILABLE		BIT(1)
+
+/* Synthetic Timers available */
+#define HV_MSR_SYNTIMER_AVAILABLE		BIT(3)
+
+/* Reference TSC available */
+#define HV_MSR_REFERENCE_TSC_AVAILABLE		BIT(9)
+
+
+/*
+ * This group of flags is in the high order 64-bits of the returned
+ * 128-bit value. Note that this set of bit positions differs from what
+ * is used on x86/x64 architecture.
+ */
+
+/* Crash MSRs available */
+#define HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE	BIT(8)
+
+/* STIMER direct mode is available */
+#define HV_STIMER_DIRECT_MODE_AVAILABLE		BIT(13)
+
+/*
+ * Implementation recommendations in register
+ * HvRegisterFeaturesInfo. Indicates which behaviors the hypervisor
+ * recommends the OS implement for optimal performance.
+ */
+
+/*
+ * Recommend not using Auto EOI
+ */
+#define HV_DEPRECATING_AEOI_RECOMMENDED		BIT(9)
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
+#define HV_REGISTER_SINT1		0x000A0001
+#define HV_REGISTER_SINT2		0x000A0002
+#define HV_REGISTER_SINT3		0x000A0003
+#define HV_REGISTER_SINT4		0x000A0004
+#define HV_REGISTER_SINT5		0x000A0005
+#define HV_REGISTER_SINT6		0x000A0006
+#define HV_REGISTER_SINT7		0x000A0007
+#define HV_REGISTER_SINT8		0x000A0008
+#define HV_REGISTER_SINT9		0x000A0009
+#define HV_REGISTER_SINT10		0x000A000A
+#define HV_REGISTER_SINT11		0x000A000B
+#define HV_REGISTER_SINT12		0x000A000C
+#define HV_REGISTER_SINT13		0x000A000D
+#define HV_REGISTER_SINT14		0x000A000E
+#define HV_REGISTER_SINT15		0x000A000F
+#define HV_REGISTER_SCONTROL		0x000A0010
+#define HV_REGISTER_SVERSION		0x000A0011
+#define HV_REGISTER_SIFP		0x000A0012
+#define HV_REGISTER_SIPP		0x000A0013
+#define HV_REGISTER_EOM			0x000A0014
+#define HV_REGISTER_SIRBP		0x000A0015
+
+#define HV_REGISTER_STIMER0_CONFIG	0x000B0000
+#define HV_REGISTER_STIMER0_COUNT	0x000B0001
+#define HV_REGISTER_STIMER1_CONFIG	0x000B0002
+#define HV_REGISTER_STIMER1_COUNT	0x000B0003
+#define HV_REGISTER_STIMER2_CONFIG	0x000B0004
+#define HV_REGISTER_STIMER2_COUNT	0x000B0005
+#define HV_REGISTER_STIMER3_CONFIG	0x000B0006
+#define HV_REGISTER_STIMER3_COUNT	0x000B0007
+
+/*
+ * Crash notification flags.
+ */
+#define HV_CRASH_CTL_CRASH_NOTIFY_MSG	BIT_ULL(62)
+#define HV_CRASH_CTL_CRASH_NOTIFY	BIT_ULL(63)
+
+/*
+ * The guest OS needs to register the guest ID with the hypervisor.
+ * The guest ID is a 64 bit entity and the structure of this ID is
+ * specified in the Hyper-V TLFS.
+ */
+#define HV_LINUX_VENDOR_ID              0x8100
+
+/* Declare the various hypercall operations. */
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
+#define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
+#define HVCALL_SEND_IPI				0x000b
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
+#define HVCALL_GET_VP_REGISTERS			0x0050
+#define HVCALL_SET_VP_REGISTERS			0x0051
+#define HVCALL_POST_MESSAGE			0x005c
+#define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_START_VIRTUAL_PROCESSOR		0x0099
+
+/* Declare standard hypercall field values. */
+#define HV_PARTITION_ID_SELF                    ((u64)-1)
+#define HV_VP_INDEX_SELF                        ((u32)-2)
+
+#define HV_HYPERCALL_FAST_BIT                   BIT(16)
+#define HV_HYPERCALL_REP_COUNT_1                BIT_ULL(32)
+#define HV_HYPERCALL_RESULT_MASK                GENMASK_ULL(15, 0)
+
+/* Define the hypercall status result */
+
+union hv_hypercall_status {
+	u64 as_uint64;
+	struct {
+		u16 status;
+		u16 reserved;
+		u16 reps_completed;  /* Low 12 bits */
+		u16 reserved2;
+	};
+};
+
+/* hypercall status code */
+#define HV_STATUS_SUCCESS			0
+#define HV_STATUS_INVALID_HYPERCALL_CODE	2
+#define HV_STATUS_INVALID_HYPERCALL_INPUT	3
+#define HV_STATUS_INVALID_ALIGNMENT		4
+#define HV_STATUS_INSUFFICIENT_MEMORY		11
+#define HV_STATUS_INVALID_CONNECTION_ID		18
+#define HV_STATUS_INSUFFICIENT_BUFFERS		19
+
+/* Define input and output layout for Get VP Register hypercall */
+struct hv_get_vp_register_input {
+	u64 partitionid;
+	u32 vpindex;
+	u8  inputvtl;
+	u8  padding[3];
+	u32 name0;
+	u32 name1;
+} __packed;
+
+struct hv_get_vp_register_output {
+	u64 registervaluelow;
+	u64 registervaluehigh;
+} __packed;
+
+#define HV_FLUSH_ALL_PROCESSORS			BIT(0)
+#define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
+#define HV_FLUSH_NON_GLOBAL_MAPPINGS_ONLY	BIT(2)
+#define HV_FLUSH_USE_EXTENDED_RANGE_FORMAT	BIT(3)
+
+enum HV_GENERIC_SET_FORMAT {
+	HV_GENERIC_SET_SPARSE_4K,
+	HV_GENERIC_SET_ALL,
+};
+
+/*
+ * The Hyper-V TimeRefCount register and the TSC
+ * page provide a guest VM clock with 100ns tick rate
+ */
+#define HV_CLOCK_HZ (NSEC_PER_SEC/100)
+
+/*
+ * The fields in this structure are set by Hyper-V and read
+ * by the Linux guest.  They should be accessed with READ_ONCE()
+ * so the compiler doesn't optimize in a way that will cause
+ * problems.  The union pads the size out to the page size
+ * used to communicate with Hyper-V.
+ */
+struct ms_hyperv_tsc_page {
+	union {
+		struct {
+			u32 tsc_sequence;
+			u32 reserved1;
+			u64 tsc_scale;
+			s64 tsc_offset;
+		} __packed;
+		u8 reserved2[HV_HYP_PAGE_SIZE];
+	};
+};
+
+/* Define the number of synthetic interrupt sources. */
+#define HV_SYNIC_SINT_COUNT		(16)
+/* Define the expected SynIC version. */
+#define HV_SYNIC_VERSION_1		(0x1)
+
+#define HV_SYNIC_CONTROL_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIMP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SIEFP_ENABLE		(1ULL << 0)
+#define HV_SYNIC_SINT_MASKED		(1ULL << 16)
+#define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
+#define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
+
+#define HV_SYNIC_STIMER_COUNT		(4)
+
+/* Define synthetic interrupt controller message constants. */
+#define HV_MESSAGE_SIZE			(256)
+#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
+#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+
+/* Define hypervisor message types. */
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
+/* Define synthetic interrupt controller message flags. */
+union hv_message_flags {
+	__u8 asu8;
+	struct {
+		__u8 msg_pending:1;
+		__u8 reserved:7;
+	} __packed;
+};
+
+/* Define port identifier type. */
+union hv_port_id {
+	__u32 asu32;
+	struct {
+		__u32 id:24;
+		__u32 reserved:8;
+	}  __packed u;
+};
+
+/* Define synthetic interrupt controller message header. */
+struct hv_message_header {
+	__u32 message_type;
+	__u8 payload_size;
+	union hv_message_flags message_flags;
+	__u8 reserved[2];
+	union {
+		__u64 sender;
+		union hv_port_id port;
+	};
+} __packed;
+
+/* Define synthetic interrupt controller message format. */
+struct hv_message {
+	struct hv_message_header header;
+	union {
+		__u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
+	} u;
+} __packed;
+
+/* Define the synthetic interrupt message page layout. */
+struct hv_message_page {
+	struct hv_message sint_message[HV_SYNIC_SINT_COUNT];
+} __packed;
+
+/* Define timer message payload structure. */
+struct hv_timer_message_payload {
+	__u32 timer_index;
+	__u32 reserved;
+	__u64 expiration_time;	/* When the timer expired */
+	__u64 delivery_time;	/* When the message was delivered */
+} __packed;
+
+#define HV_STIMER_ENABLE		(1ULL << 0)
+#define HV_STIMER_PERIODIC		(1ULL << 1)
+#define HV_STIMER_LAZY			(1ULL << 2)
+#define HV_STIMER_AUTOENABLE		(1ULL << 3)
+#define HV_STIMER_SINT(config)		(__u8)(((config) >> 16) & 0x0F)
+
+
+/* Define synthetic interrupt controller flag constants. */
+#define HV_EVENT_FLAGS_COUNT		(256 * 8)
+#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(unsigned long))
+
+/*
+ * Timer configuration register.
+ */
+union hv_stimer_config {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 periodic:1;
+		u64 lazy:1;
+		u64 auto_enable:1;
+		u64 apic_vector:8;
+		u64 direct_mode:1;
+		u64 reserved_z0:3;
+		u64 sintx:4;
+		u64 reserved_z1:44;
+	} __packed;
+};
+
+
+/* Define the synthetic interrupt controller event flags format. */
+union hv_synic_event_flags {
+	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
+};
+
+/* Define SynIC control register. */
+union hv_synic_scontrol {
+	u64 as_uint64;
+	struct {
+		u64 enable:1;
+		u64 reserved:63;
+	} __packed;
+};
+
+/* Define synthetic interrupt source. */
+union hv_synic_sint {
+	u64 as_uint64;
+	struct {
+		u64 vector:8;
+		u64 reserved1:8;
+		u64 masked:1;
+		u64 auto_eoi:1;
+		u64 reserved2:46;
+	} __packed;
+};
+
+/* Define the format of the SIMP register */
+union hv_synic_simp {
+	u64 as_uint64;
+	struct {
+		u64 simp_enabled:1;
+		u64 preserved:11;
+		u64 base_simp_gpa:52;
+	} __packed;
+};
+
+/* Define the format of the SIEFP register */
+union hv_synic_siefp {
+	u64 as_uint64;
+	struct {
+		u64 siefp_enabled:1;
+		u64 preserved:11;
+		u64 base_siefp_gpa:52;
+	} __packed;
+};
+
+struct hv_vpset {
+	u64 format;
+	u64 valid_bank_mask;
+	u64 bank_contents[];
+} __packed;
+
+
+#endif
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
new file mode 100644
index 0000000..60b3f68
--- /dev/null
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -0,0 +1,115 @@
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
+/*
+ * Define the IRQ numbers/vectors used by Hyper-V VMbus interrupts
+ * and by STIMER0 Direct Mode interrupts. Hyper-V should be supplying
+ * these values through ACPI, but there are no other interrupting
+ * devices in a Hyper-V VM on ARM64, so it's OK to hard code for now.
+ * The "CALLBACK_VECTOR" terminology is a left-over from the x86/x64
+ * world that is used in architecture independent Hyper-V code.
+ */
+#define HYPERVISOR_CALLBACK_VECTOR 16
+#define	HV_STIMER0_IRQNR	   17
+
+extern u64 hv_do_hvc(u64 control, ...);
+extern u64 hv_do_hvc_fast_get(u64 control, u64 input1, u64 input2, u64 input3,
+		struct hv_get_vp_register_output *output);
+
+/*
+ * Declare calls to get and set Hyper-V VP register values on ARM64, which
+ * requires a hypercall.
+ */
+extern void hv_set_vpreg(u32 reg, u64 value);
+extern u64 hv_get_vpreg(u32 reg);
+extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
+
+/*
+ * Use the Hyper-V provided stimer0 as the timer that is made
+ * available to the architecture independent Hyper-V drivers.
+ */
+#define hv_init_timer(timer, tick) \
+		hv_set_vpreg(HV_REGISTER_STIMER0_COUNT + (2*timer), tick)
+#define hv_init_timer_config(timer, val) \
+		hv_set_vpreg(HV_REGISTER_STIMER0_CONFIG + (2*timer), val)
+#define hv_get_current_tick(tick) \
+		(tick = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
+
+#define hv_get_simp(val) (val = hv_get_vpreg(HV_REGISTER_SIPP))
+#define hv_set_simp(val) hv_set_vpreg(HV_REGISTER_SIPP, val)
+
+#define hv_get_siefp(val) (val = hv_get_vpreg(HV_REGISTER_SIFP))
+#define hv_set_siefp(val) hv_set_vpreg(HV_REGISTER_SIFP, val)
+
+#define hv_get_synic_state(val) (val = hv_get_vpreg(HV_REGISTER_SCONTROL))
+#define hv_set_synic_state(val) hv_set_vpreg(HV_REGISTER_SCONTROL, val)
+
+#define hv_get_vp_index(index) (index = hv_get_vpreg(HV_REGISTER_VPINDEX))
+
+#define hv_signal_eom()	hv_set_vpreg(HV_REGISTER_EOM, 0)
+
+/*
+ * Hyper-V SINT registers are numbered sequentially, so we can just
+ * add the SINT number to the register number of SINT0
+ */
+#define hv_get_synint_state(sint_num, val) \
+		(val = hv_get_vpreg(HV_REGISTER_SINT0 + sint_num))
+#define hv_set_synint_state(sint_num, val) \
+		hv_set_vpreg(HV_REGISTER_SINT0 + sint_num, val)
+
+#define hv_get_crash_ctl(val) \
+		(val = hv_get_vpreg(HV_REGISTER_CRASH_CTL))
+#define hv_get_time_ref_count(val) \
+		(val = hv_get_vpreg(HV_REGISTER_TIME_REFCOUNT))
+#define hv_get_reference_tsc(val) \
+		(val = hv_get_vpreg(HV_REGISTER_REFERENCE_TSC))
+#define hv_set_reference_tsc(val) \
+		hv_set_vpreg(HV_REGISTER_REFERENCE_TSC, val)
+#define hv_enable_vdso_clocksource()
+#define hv_set_clocksource_vdso(val) \
+		((val).vdso_clock_mode = VDSO_CLOCKMODE_NONE)
+
+#if IS_ENABLED(CONFIG_HYPERV)
+#define hv_enable_stimer0_percpu_irq(irq)	enable_percpu_irq(irq, 0)
+#define hv_disable_stimer0_percpu_irq(irq)	disable_percpu_irq(irq)
+#endif
+
+/* ARM64 specific code to read the hardware clock */
+#define hv_get_raw_timer() arch_timer_read_counter()
+
+/* SMCCC hypercall parameters */
+#define HV_SMCCC_FUNC_NUMBER	1
+#define HV_FUNC_ID	ARM_SMCCC_CALL_VAL(			\
+				ARM_SMCCC_STD_CALL,		\
+				ARM_SMCCC_SMC_64,		\
+				ARM_SMCCC_OWNER_VENDOR_HYP,	\
+				HV_SMCCC_FUNC_NUMBER)
+
+#include <asm-generic/mshyperv.h>
+
+#endif
-- 
1.8.3.1

