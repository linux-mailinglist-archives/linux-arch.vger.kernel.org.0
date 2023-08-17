Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6BA7800A9
	for <lists+linux-arch@lfdr.de>; Fri, 18 Aug 2023 00:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355549AbjHQWCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Aug 2023 18:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355511AbjHQWCH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Aug 2023 18:02:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F1563595;
        Thu, 17 Aug 2023 15:02:02 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 27BD9211F926;
        Thu, 17 Aug 2023 15:02:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 27BD9211F926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692309720;
        bh=ljjteIo5yqZhRuroS4s4lx/7RztreHwNkCjHvI7Fbls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoprImcjcwGCrjL4sIDeB3OpvdK5ch9duyLe7tdwjuO8yjEWmWDGX3wqZe4oNSpLs
         dHfTgOuEeftJGA5Y/AvjOt4h7SD+Et65ndRRBilkFFLMuXseJjSuJZ11/mM75eArbc
         A4cS/oiLoPSv2J6XGPzVtg5V7jQe5WFSY8bcbx54=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h, hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Date:   Thu, 17 Aug 2023 15:01:49 -0700
Message-Id: <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Containing hypervisor ABI definitions to use in mshv driver.

Version numbers for each file:
hvhdk.h		25212
hvhdk_mini.h	25294
hvgdk.h		25125
hvgdk_mini.h	25294

These are unstable interfaces and as such must be compiled independently
from published interfaces found in hyperv-tlfs.h.

These are in uapi because they will be used in the mshv ioctl API.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 include/uapi/hyperv/hvgdk.h      |   41 +
 include/uapi/hyperv/hvgdk_mini.h | 1077 ++++++++++++++++++++++++
 include/uapi/hyperv/hvhdk.h      | 1352 ++++++++++++++++++++++++++++++
 include/uapi/hyperv/hvhdk_mini.h |  164 ++++
 4 files changed, 2634 insertions(+)
 create mode 100644 include/uapi/hyperv/hvgdk.h
 create mode 100644 include/uapi/hyperv/hvgdk_mini.h
 create mode 100644 include/uapi/hyperv/hvhdk.h
 create mode 100644 include/uapi/hyperv/hvhdk_mini.h

diff --git a/include/uapi/hyperv/hvgdk.h b/include/uapi/hyperv/hvgdk.h
new file mode 100644
index 000000000000..9bcbb7d902b2
--- /dev/null
+++ b/include/uapi/hyperv/hvgdk.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * These files (hvhdk.h, hvhdk_mini.h, hvgdk.h, hvgdk_mini.h) define APIs for
+ * communicating with the Microsoft Hypervisor.
+ *
+ * These definitions are subject to change across hypervisor versions, and as
+ * such are separate and independent from hyperv-tlfs.h.
+ *
+ * The naming of these headers reflects conventions used in the Microsoft
+ * Hypervisor.
+ */
+#ifndef _UAPI_HV_HVGDK_H
+#define _UAPI_HV_HVGDK_H
+
+#include "hvgdk_mini.h"
+
+enum hv_unimplemented_msr_action {
+	HV_UNIMPLEMENTED_MSR_ACTION_FAULT = 0,
+	HV_UNIMPLEMENTED_MSR_ACTION_IGNORE_WRITE_READ_ZERO = 1,
+	HV_UNIMPLEMENTED_MSR_ACTION_COUNT = 2,
+};
+
+/* Define connection identifier type. */
+union hv_connection_id {
+	__u32 asu32;
+	struct {
+		__u32 id:24;
+		__u32 reserved:8;
+	} __packed u;
+};
+
+struct hv_input_unmap_gpa_pages {
+	__u64 target_partition_id;
+	__u64 target_gpa_base;
+	__u32 unmap_flags;
+	__u32 padding;
+} __packed;
+
+#endif /* #ifndef _UAPI_HV_HVGDK_H */
diff --git a/include/uapi/hyperv/hvgdk_mini.h b/include/uapi/hyperv/hvgdk_mini.h
new file mode 100644
index 000000000000..86d825ef6062
--- /dev/null
+++ b/include/uapi/hyperv/hvgdk_mini.h
@@ -0,0 +1,1077 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * These files (hvhdk.h, hvhdk_mini.h, hvgdk.h, hvgdk_mini.h) define APIs for
+ * communicating with the Microsoft Hypervisor.
+ *
+ * These definitions are subject to change across hypervisor versions, and as
+ * such are separate and independent from hyperv-tlfs.h.
+ *
+ * The naming of these headers reflects conventions used in the Microsoft
+ * Hypervisor.
+ */
+#ifndef _UAPI_HV_HVGDK_MINI_H
+#define _UAPI_HV_HVGDK_MINI_H
+
+struct hv_u128 {
+	__u64 low_part;
+	__u64 high_part;
+} __packed;
+
+/* hypercall status code */
+#define __HV_STATUS_DEF(OP) \
+	OP(HV_STATUS_SUCCESS,				0x0) \
+	OP(HV_STATUS_INVALID_HYPERCALL_CODE,		0x2) \
+	OP(HV_STATUS_INVALID_HYPERCALL_INPUT,		0x3) \
+	OP(HV_STATUS_INVALID_ALIGNMENT,			0x4) \
+	OP(HV_STATUS_INVALID_PARAMETER,			0x5) \
+	OP(HV_STATUS_ACCESS_DENIED,			0x6) \
+	OP(HV_STATUS_INVALID_PARTITION_STATE,		0x7) \
+	OP(HV_STATUS_OPERATION_DENIED,			0x8) \
+	OP(HV_STATUS_UNKNOWN_PROPERTY,			0x9) \
+	OP(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	0xA) \
+	OP(HV_STATUS_INSUFFICIENT_MEMORY,		0xB) \
+	OP(HV_STATUS_INVALID_PARTITION_ID,		0xD) \
+	OP(HV_STATUS_INVALID_VP_INDEX,			0xE) \
+	OP(HV_STATUS_NOT_FOUND,				0x10) \
+	OP(HV_STATUS_INVALID_PORT_ID,			0x11) \
+	OP(HV_STATUS_INVALID_CONNECTION_ID,		0x12) \
+	OP(HV_STATUS_INSUFFICIENT_BUFFERS,		0x13) \
+	OP(HV_STATUS_NOT_ACKNOWLEDGED,			0x14) \
+	OP(HV_STATUS_INVALID_VP_STATE,			0x15) \
+	OP(HV_STATUS_NO_RESOURCES,			0x1D) \
+	OP(HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED,	0x20) \
+	OP(HV_STATUS_INVALID_LP_INDEX,			0x41) \
+	OP(HV_STATUS_INVALID_REGISTER_VALUE,		0x50) \
+	OP(HV_STATUS_CALL_PENDING,			0x79)
+
+#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME = (VAL),
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);
+
+enum hv_status {
+	__HV_STATUS_DEF(__HV_MAKE_HV_STATUS_ENUM)
+};
+
+/* TODO not in hv headers */
+#define HV_LINUX_VENDOR_ID              0x8100
+#define HV_HYP_PAGE_SHIFT		12
+#define HV_HYP_PAGE_SIZE		BIT(HV_HYP_PAGE_SHIFT)
+#define HV_HYP_PAGE_MASK		(~(HV_HYP_PAGE_SIZE - 1))
+
+#define HV_PARTITION_ID_INVALID		((__u64) 0)
+#define HV_PARTITION_ID_SELF		((__u64)-1)
+
+/* Hyper-V specific model specific registers (MSRs) */
+
+/* HV_X64_SYNTHETIC_MSR */
+/* MSR used to identify the guest OS. */
+#define HV_X64_MSR_GUEST_OS_ID			0x40000000
+
+/* MSR used to setup pages used to communicate with the hypervisor. */
+#define HV_X64_MSR_HYPERCALL			0x40000001
+
+/* MSR used to provide vcpu index */
+#define HV_X64_MSR_VP_INDEX			0x40000002
+
+/* MSR used to reset the guest OS. */
+#define HV_X64_MSR_RESET			0x40000003
+
+/* MSR used to provide vcpu runtime in 100ns units */
+#define HV_X64_MSR_VP_RUNTIME			0x40000010
+
+/* MSR used to read the per-partition time reference counter */
+#define HV_X64_MSR_TIME_REF_COUNT		0x40000020
+
+/* A partition's reference time stamp counter (TSC) page */
+#define HV_X64_MSR_REFERENCE_TSC		0x40000021
+
+/* MSR used to retrieve the TSC frequency */
+#define HV_X64_MSR_TSC_FREQUENCY		0x40000022
+
+/* MSR used to retrieve the local APIC timer frequency */
+#define HV_X64_MSR_APIC_FREQUENCY		0x40000023
+
+/* Define the virtual APIC registers */
+#define HV_X64_MSR_EOI				0x40000070
+#define HV_X64_MSR_ICR				0x40000071
+#define HV_X64_MSR_TPR				0x40000072
+#define HV_X64_MSR_VP_ASSIST_PAGE		0x40000073
+
+/* Define synthetic interrupt controller model specific registers. */
+#define HV_X64_MSR_SCONTROL			0x40000080
+#define HV_X64_MSR_SVERSION			0x40000081
+#define HV_X64_MSR_SIEFP			0x40000082
+#define HV_X64_MSR_SIMP				0x40000083
+#define HV_X64_MSR_EOM				0x40000084
+#define HV_X64_MSR_SIRBP			0x40000085
+#define HV_X64_MSR_SINT0			0x40000090
+#define HV_X64_MSR_SINT1			0x40000091
+#define HV_X64_MSR_SINT2			0x40000092
+#define HV_X64_MSR_SINT3			0x40000093
+#define HV_X64_MSR_SINT4			0x40000094
+#define HV_X64_MSR_SINT5			0x40000095
+#define HV_X64_MSR_SINT6			0x40000096
+#define HV_X64_MSR_SINT7			0x40000097
+#define HV_X64_MSR_SINT8			0x40000098
+#define HV_X64_MSR_SINT9			0x40000099
+#define HV_X64_MSR_SINT10			0x4000009A
+#define HV_X64_MSR_SINT11			0x4000009B
+#define HV_X64_MSR_SINT12			0x4000009C
+#define HV_X64_MSR_SINT13			0x4000009D
+#define HV_X64_MSR_SINT14			0x4000009E
+#define HV_X64_MSR_SINT15			0x4000009F
+
+/* Define synthetic interrupt controller model specific registers for nested hypervisor */
+#define HV_X64_MSR_NESTED_SCONTROL		0x40001080
+#define HV_X64_MSR_NESTED_SVERSION		0x40001081
+#define HV_X64_MSR_NESTED_SIEFP			0x40001082
+#define HV_X64_MSR_NESTED_SIMP			0x40001083
+#define HV_X64_MSR_NESTED_EOM			0x40001084
+#define HV_X64_MSR_NESTED_SINT0			0x40001090
+
+/*
+ * Synthetic Timer MSRs. Four timers per vcpu.
+ */
+#define HV_X64_MSR_STIMER0_CONFIG		0x400000B0
+#define HV_X64_MSR_STIMER0_COUNT		0x400000B1
+#define HV_X64_MSR_STIMER1_CONFIG		0x400000B2
+#define HV_X64_MSR_STIMER1_COUNT		0x400000B3
+#define HV_X64_MSR_STIMER2_CONFIG		0x400000B4
+#define HV_X64_MSR_STIMER2_COUNT		0x400000B5
+#define HV_X64_MSR_STIMER3_CONFIG		0x400000B6
+#define HV_X64_MSR_STIMER3_COUNT		0x400000B7
+
+/* Hyper-V guest idle MSR */
+#define HV_X64_MSR_GUEST_IDLE			0x400000F0
+
+/* Hyper-V guest crash notification MSR's */
+#define HV_X64_MSR_CRASH_P0			0x40000100
+#define HV_X64_MSR_CRASH_P1			0x40000101
+#define HV_X64_MSR_CRASH_P2			0x40000102
+#define HV_X64_MSR_CRASH_P3			0x40000103
+#define HV_X64_MSR_CRASH_P4			0x40000104
+#define HV_X64_MSR_CRASH_CTL			0x40000105
+
+/* TSC emulation after migration */
+#define HV_X64_MSR_REENLIGHTENMENT_CONTROL	0x40000106
+#define HV_X64_MSR_TSC_EMULATION_CONTROL	0x40000107
+#define HV_X64_MSR_TSC_EMULATION_STATUS		0x40000108
+
+/* TSC invariant control */
+#define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
+
+/*
+ * Version info reported by hypervisor
+ * Changed to a union for convenience
+ */
+union hv_hypervisor_version_info {
+	struct {
+		__u32 build_number;
+
+		__u32 minor_version : 16;
+		__u32 major_version : 16;
+
+		__u32 service_pack;
+
+		__u32 service_number : 24;
+		__u32 service_branch : 8;
+	};
+	struct {
+		__u32 eax;
+		__u32 ebx;
+		__u32 ecx;
+		__u32 edx;
+	};
+};
+
+/* HV_CPUID_FUNCTION */
+#define HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS	0x40000000
+#define HYPERV_CPUID_VERSION			0x40000002
+
+/* HV_X64_ENLIGHTENMENT_INFORMATION */
+
+/* DeprecateAutoEoi */
+#define HV_DEPRECATING_AEOI_RECOMMENDED		BIT(9)
+
+#define HV_MAXIMUM_PROCESSORS       2048
+
+#define HV_MAX_VP_INDEX			(HV_MAXIMUM_PROCESSORS - 1)
+#define HV_VP_INDEX_SELF		((__u32)-2)
+#define HV_ANY_VP			((__u32)-1)
+
+/* Declare the various hypercall operations. */
+/* HV_CALL_CODE */
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE	0x0002
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST	0x0003
+#define HVCALL_NOTIFY_LONG_SPIN_WAIT		0x0008
+#define HVCALL_SEND_IPI				0x000b
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
+#define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
+#define HVCALL_SEND_IPI_EX			0x0015
+#define HVCALL_CREATE_PARTITION			0x0040
+#define HVCALL_INITIALIZE_PARTITION		0x0041
+#define HVCALL_FINALIZE_PARTITION		0x0042
+#define HVCALL_DELETE_PARTITION			0x0043
+#define HVCALL_GET_PARTITION_PROPERTY		0x0044
+#define HVCALL_SET_PARTITION_PROPERTY		0x0045
+#define HVCALL_GET_PARTITION_ID			0x0046
+#define HVCALL_DEPOSIT_MEMORY			0x0048
+#define HVCALL_WITHDRAW_MEMORY			0x0049
+#define HVCALL_MAP_GPA_PAGES			0x004b
+#define HVCALL_UNMAP_GPA_PAGES			0x004c
+#define HVCALL_INSTALL_INTERCEPT		0x004d
+#define HVCALL_CREATE_VP			0x004e
+#define HVCALL_GET_VP_REGISTERS			0x0050
+#define HVCALL_SET_VP_REGISTERS			0x0051
+#define HVCALL_TRANSLATE_VIRTUAL_ADDRESS	0x0052
+#define HVCALL_CLEAR_VIRTUAL_INTERRUPT		0x0056
+#define HVCALL_DELETE_PORT			0x0058
+#define HVCALL_DISCONNECT_PORT			0x005b
+#define HVCALL_POST_MESSAGE			0x005c
+#define HVCALL_SIGNAL_EVENT			0x005d
+#define HVCALL_POST_DEBUG_DATA			0x0069
+#define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
+#define HVCALL_RESET_DEBUG_SESSION		0x006b
+#define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
+#define HVCALL_GET_SYSTEM_PROPERTY		0x007b
+#define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
+#define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
+#define HVCALL_RETARGET_INTERRUPT		0x007e
+#define HVCALL_NOTIFY_PORT_RING_EMPTY		0x008b
+#define HVCALL_REGISTER_INTERCEPT_RESULT	0x0091
+#define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
+#define HVCALL_CREATE_PORT			0x0095
+#define HVCALL_CONNECT_PORT			0x0096
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
+#define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST	0x00b0
+#define HVCALL_GET_GPA_PAGES_ACCESS_STATES	0x00c9
+#define HVCALL_SIGNAL_EVENT_DIRECT		0x00c0
+#define HVCALL_POST_MESSAGE_DIRECT		0x00c1
+#define HVCALL_DISPATCH_VP			0x00c2
+#define HVCALL_MAP_VP_STATE_PAGE		0x00e1
+#define HVCALL_UNMAP_VP_STATE_PAGE		0x00e2
+#define HVCALL_GET_VP_STATE			0x00e3
+#define HVCALL_SET_VP_STATE			0x00e4
+#define HVCALL_GET_VP_CPUID_VALUES		0x00f4
+
+/*
+ * Some macros - i.e. GENMASK_ULL and BIT_ULL - are not currently supported by
+ * userspace rust bindings generation tool.
+ * As the below are not currently needed in userspace, don't export them and
+ * avoid the issue altogether for now.
+ */
+#if defined(__KERNEL__)
+
+/* HV_HYPERCALL_INPUT */
+#define HV_HYPERCALL_RESULT_MASK	GENMASK_ULL(15, 0)
+#define HV_HYPERCALL_FAST_BIT		BIT(16)
+#define HV_HYPERCALL_VARHEAD_OFFSET	17
+#define HV_HYPERCALL_NESTED		BIT(31)
+#define HV_HYPERCALL_REP_COMP_OFFSET	32
+#define HV_HYPERCALL_REP_COMP_1		BIT_ULL(32)
+#define HV_HYPERCALL_REP_COMP_MASK	GENMASK_ULL(43, 32)
+#define HV_HYPERCALL_REP_START_OFFSET	48
+#define HV_HYPERCALL_REP_START_MASK	GENMASK_ULL(59, 48)
+
+#endif /* __KERNEL__ */
+
+union hv_gpa_page_range {
+	u64 address_space;
+	struct {
+		u64 additional_pages:11;
+		u64 largepage:1;
+		u64 basepfn:52;
+	} page;
+	struct {
+		u64 reserved:12;
+		u64 page_size:1;
+		u64 reserved1:8;
+		u64 base_large_pfn:43;
+	};
+};
+
+/* Define the number of synthetic interrupt sources. */
+#define HV_SYNIC_SINT_COUNT (16)
+
+/* Hyper-V defined statically assigned SINTs */
+#define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
+#define HV_SYNIC_IOMMU_FAULT_SINT_INDEX  0x00000001
+#define HV_SYNIC_VMBUS_SINT_INDEX        0x00000002
+#define HV_SYNIC_FIRST_UNUSED_SINT_INDEX 0x00000005
+
+/* mshv assigned SINT for doorbell */
+#define HV_SYNIC_DOORBELL_SINT_INDEX     HV_SYNIC_FIRST_UNUSED_SINT_INDEX
+
+enum hv_interrupt_type {
+	HV_X64_INTERRUPT_TYPE_FIXED		= 0x0000,
+	HV_X64_INTERRUPT_TYPE_LOWESTPRIORITY	= 0x0001,
+	HV_X64_INTERRUPT_TYPE_SMI		= 0x0002,
+	HV_X64_INTERRUPT_TYPE_REMOTEREAD	= 0x0003,
+	HV_X64_INTERRUPT_TYPE_NMI		= 0x0004,
+	HV_X64_INTERRUPT_TYPE_INIT		= 0x0005,
+	HV_X64_INTERRUPT_TYPE_SIPI		= 0x0006,
+	HV_X64_INTERRUPT_TYPE_EXTINT		= 0x0007,
+	HV_X64_INTERRUPT_TYPE_LOCALINT0		= 0x0008,
+	HV_X64_INTERRUPT_TYPE_LOCALINT1		= 0x0009,
+	HV_X64_INTERRUPT_TYPE_MAXIMUM		= 0x000A,
+};
+
+/* Define synthetic interrupt source. */
+union hv_synic_sint {
+	__u64 as_uint64;
+	struct {
+		__u64 vector : 8;
+		__u64 reserved1 : 8;
+		__u64 masked : 1;
+		__u64 auto_eoi : 1;
+		__u64 polling : 1;
+		__u64 as_intercept : 1;
+		__u64 proxy : 1;
+		__u64 reserved2 : 43;
+	} __packed;
+};
+
+union hv_x64_xsave_xfem_register {
+	__u64 as_uint64;
+	struct {
+		__u32 low_uint32;
+		__u32 high_uint32;
+	} __packed;
+	struct {
+		__u64 legacy_x87 : 1;
+		__u64 legacy_sse : 1;
+		__u64 avx : 1;
+		__u64 mpx_bndreg : 1;
+		__u64 mpx_bndcsr : 1;
+		__u64 avx_512_op_mask : 1;
+		__u64 avx_512_zmmhi : 1;
+		__u64 avx_512_zmm16_31 : 1;
+		__u64 rsvd8_9 : 2;
+		__u64 pasid : 1;
+		__u64 cet_u : 1;
+		__u64 cet_s : 1;
+		__u64 rsvd13_16 : 4;
+		__u64 xtile_cfg : 1;
+		__u64 xtile_data : 1;
+		__u64 rsvd19_63 : 45;
+	} __packed;
+};
+
+/* Define the number of synthetic timers */
+#define HV_SYNIC_STIMER_COUNT	(4)
+
+/* Define port identifier type. */
+union hv_port_id {
+	__u32 asu32;
+	struct {
+		__u32 id : 24;
+		__u32 reserved : 8;
+	} __packed u; // TODO remove this u
+};
+
+#define HV_MESSAGE_SIZE			(256)
+#define HV_MESSAGE_PAYLOAD_BYTE_COUNT	(240)
+#define HV_MESSAGE_PAYLOAD_QWORD_COUNT	(30)
+
+/* Define hypervisor message types. */
+enum hv_message_type {
+	HVMSG_NONE				= 0x00000000,
+
+	/* Memory access messages. */
+	HVMSG_UNMAPPED_GPA			= 0x80000000,
+	HVMSG_GPA_INTERCEPT			= 0x80000001,
+
+	/* Timer notification messages. */
+	HVMSG_TIMER_EXPIRED			= 0x80000010,
+
+	/* Error messages. */
+	HVMSG_INVALID_VP_REGISTER_VALUE		= 0x80000020,
+	HVMSG_UNRECOVERABLE_EXCEPTION		= 0x80000021,
+	HVMSG_UNSUPPORTED_FEATURE		= 0x80000022,
+
+	/*
+	 * Opaque intercept message. The original intercept message is only
+	 * accessible from the mapped intercept message page.
+	 */
+	HVMSG_OPAQUE_INTERCEPT			= 0x8000003F,
+
+	/* Trace buffer complete messages. */
+	HVMSG_EVENTLOG_BUFFERCOMPLETE		= 0x80000040,
+
+	/* Hypercall intercept */
+	HVMSG_HYPERCALL_INTERCEPT		= 0x80000050,
+
+	/* SynIC intercepts */
+	HVMSG_SYNIC_EVENT_INTERCEPT		= 0x80000060,
+	HVMSG_SYNIC_SINT_INTERCEPT		= 0x80000061,
+	HVMSG_SYNIC_SINT_DELIVERABLE	= 0x80000062,
+
+	/* Async call completion intercept */
+	HVMSG_ASYNC_CALL_COMPLETION		= 0x80000070,
+
+	/* Root scheduler messages */
+	HVMSG_SCHEDULER_VP_SIGNAL_BITSET	= 0x80000100,
+	HVMSG_SCHEDULER_VP_SIGNAL_PAIR		= 0x80000101,
+
+	/* Platform-specific processor intercept messages. */
+	HVMSG_X64_IO_PORT_INTERCEPT		= 0x80010000,
+	HVMSG_X64_MSR_INTERCEPT			= 0x80010001,
+	HVMSG_X64_CPUID_INTERCEPT		= 0x80010002,
+	HVMSG_X64_EXCEPTION_INTERCEPT		= 0x80010003,
+	HVMSG_X64_APIC_EOI			= 0x80010004,
+	HVMSG_X64_LEGACY_FP_ERROR		= 0x80010005,
+	HVMSG_X64_IOMMU_PRQ			= 0x80010006,
+	HVMSG_X64_HALT				= 0x80010007,
+	HVMSG_X64_INTERRUPTION_DELIVERABLE	= 0x80010008,
+	HVMSG_X64_SIPI_INTERCEPT		= 0x80010009,
+};
+
+/* Define the format of the SIMP register */
+union hv_synic_simp {
+	__u64 as_uint64;
+	struct {
+		__u64 simp_enabled : 1;
+		__u64 preserved : 11;
+		__u64 base_simp_gpa : 52;
+	} __packed;
+};
+
+union hv_message_flags {
+	__u8 asu8;
+	struct {
+		__u8 msg_pending : 1;
+		__u8 reserved : 7;
+	} __packed;
+};
+
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
+/*
+ * Message format for notifications delivered via
+ * intercept message(as_intercept=1)
+ */
+struct hv_notification_message_payload {
+	__u32 sint_index;
+} __packed;
+
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
+struct hv_x64_segment_register {
+	__u64 base;
+	__u32 limit;
+	__u16 selector;
+	union {
+		struct {
+			__u16 segment_type : 4;
+			__u16 non_system_segment : 1;
+			__u16 descriptor_privilege_level : 2;
+			__u16 present : 1;
+			__u16 reserved : 4;
+			__u16 available : 1;
+			__u16 _long : 1;
+			__u16 _default : 1;
+			__u16 granularity : 1;
+		} __packed;
+		__u16 attributes;
+	};
+} __packed;
+
+struct hv_x64_table_register {
+	__u16 pad[3];
+	__u16 limit;
+	__u64 base;
+} __packed;
+
+union hv_x64_fp_control_status_register {
+	struct hv_u128 as_uint128;
+	struct {
+		__u16 fp_control;
+		__u16 fp_status;
+		__u8 fp_tag;
+		__u8 reserved;
+		__u16 last_fp_op;
+		union {
+			/* long mode */
+			__u64 last_fp_rip;
+			/* 32 bit mode */
+			struct {
+				__u32 last_fp_eip;
+				__u16 last_fp_cs;
+				__u16 padding;
+			} __packed;
+		};
+	} __packed;
+} __packed;
+
+union hv_x64_xmm_control_status_register {
+	struct hv_u128 as_uint128;
+	struct {
+		union {
+			/* long mode */
+			__u64 last_fp_rdp;
+			/* 32 bit mode */
+			struct {
+				__u32 last_fp_dp;
+				__u16 last_fp_ds;
+				__u16 padding;
+			} __packed;
+		};
+		__u32 xmm_status_control;
+		__u32 xmm_status_control_mask;
+	} __packed;
+} __packed;
+
+union hv_x64_fp_register {
+	struct hv_u128 as_uint128;
+	struct {
+		__u64 mantissa;
+		__u64 biased_exponent : 15;
+		__u64 sign : 1;
+		__u64 reserved : 48;
+	} __packed;
+} __packed;
+
+union hv_x64_msr_npiep_config_contents {
+	__u64 as_uint64;
+	struct {
+		/*
+		 * These bits enable instruction execution prevention for
+		 * specific instructions.
+		 */
+		__u64 prevents_gdt : 1;
+		__u64 prevents_idt : 1;
+		__u64 prevents_ldt : 1;
+		__u64 prevents_tr : 1;
+
+		/* The reserved bits must always be 0. */
+		__u64 reserved : 60;
+	} __packed;
+};
+
+union hv_input_vtl {
+	__u8 as_uint8;
+	struct {
+		__u8 target_vtl : 4;
+		__u8 use_target_vtl : 1;
+		__u8 reserved_z : 3;
+	};
+} __packed;
+
+/* Note: not in hvgdk_mini.h */
+#define HV_SUPPORTS_REGISTER_DELIVERABILITY_NOTIFICATIONS
+
+union hv_register_vsm_partition_config {
+	__u64 as_u64;
+	struct {
+		__u64 enable_vtl_protection : 1;
+		__u64 default_vtl_protection_mask : 4;
+		__u64 zero_memory_on_reset : 1;
+		__u64 deny_lower_vtl_startup : 1;
+		__u64 intercept_acceptance : 1;
+		__u64 intercept_enable_vtl_protection : 1;
+		__u64 intercept_vp_startup : 1;
+		__u64 intercept_cpuid_unimplemented : 1;
+		__u64 intercept_unrecoverable_exception : 1;
+		__u64 intercept_page : 1;
+		__u64 mbz : 51;
+	};
+};
+
+struct hv_nested_enlightenments_control {
+	struct {
+		__u32 directhypercall : 1;
+		__u32 reserved : 31;
+	} __packed features;
+	struct {
+		__u32 inter_partition_comm : 1;
+		__u32 reserved : 31;
+	} __packed hypercall_controls;
+} __packed;
+
+/* Define virtual processor assist page structure. */
+struct hv_vp_assist_page {
+	__u32 apic_assist;
+	__u32 reserved1;
+	__u32 vtl_entry_reason;
+	__u32 vtl_reserved;
+	__u64 vtl_ret_x64rax;
+	__u64 vtl_ret_x64rcx;
+	struct hv_nested_enlightenments_control nested_control;
+	__u8 enlighten_vmentry;
+	__u8 reserved2[7];
+	__u64 current_nested_vmcs;
+	__u8 synthetic_time_unhalted_timer_expired;
+	__u8 reserved3[7];
+	__u8 virtualization_fault_information[40];
+	__u8 reserved4[8];
+	__u8 intercept_message[256];
+	__u8 vtl_ret_actions[256];
+} __packed;
+
+enum hv_register_name {
+	/* Suspend Registers */
+	HV_REGISTER_EXPLICIT_SUSPEND		= 0x00000000,
+	HV_REGISTER_INTERCEPT_SUSPEND		= 0x00000001,
+	HV_REGISTER_DISPATCH_SUSPEND		= 0x00000003,
+
+	HV_REGISTER_VP_ROOT_SIGNAL_COUNT        = 0x00090014,
+
+	/* Synthetic VSM registers */
+	HV_REGISTER_VSM_CODE_PAGE_OFFSETS	= 0x000D0002,
+	HV_REGISTER_VSM_CAPABILITIES		= 0x000D0006,
+	HV_REGISTER_VSM_PARTITION_CONFIG	= 0x000D0007,
+
+	/* Interruptible notification register */
+	HV_X64_REGISTER_DELIVERABILITY_NOTIFICATIONS	= 0x00010006,
+
+	/* X64 User-Mode Registers */
+	HV_X64_REGISTER_RAX	= 0x00020000,
+	HV_X64_REGISTER_RCX	= 0x00020001,
+	HV_X64_REGISTER_RDX	= 0x00020002,
+	HV_X64_REGISTER_RBX	= 0x00020003,
+	HV_X64_REGISTER_RSP	= 0x00020004,
+	HV_X64_REGISTER_RBP	= 0x00020005,
+	HV_X64_REGISTER_RSI	= 0x00020006,
+	HV_X64_REGISTER_RDI	= 0x00020007,
+	HV_X64_REGISTER_R8	= 0x00020008,
+	HV_X64_REGISTER_R9	= 0x00020009,
+	HV_X64_REGISTER_R10	= 0x0002000A,
+	HV_X64_REGISTER_R11	= 0x0002000B,
+	HV_X64_REGISTER_R12	= 0x0002000C,
+	HV_X64_REGISTER_R13	= 0x0002000D,
+	HV_X64_REGISTER_R14	= 0x0002000E,
+	HV_X64_REGISTER_R15	= 0x0002000F,
+	HV_X64_REGISTER_RIP	= 0x00020010,
+	HV_X64_REGISTER_RFLAGS	= 0x00020011,
+
+	/* X64 Floating Point and Vector Registers */
+	HV_X64_REGISTER_XMM0			= 0x00030000,
+	HV_X64_REGISTER_XMM1			= 0x00030001,
+	HV_X64_REGISTER_XMM2			= 0x00030002,
+	HV_X64_REGISTER_XMM3			= 0x00030003,
+	HV_X64_REGISTER_XMM4			= 0x00030004,
+	HV_X64_REGISTER_XMM5			= 0x00030005,
+	HV_X64_REGISTER_XMM6			= 0x00030006,
+	HV_X64_REGISTER_XMM7			= 0x00030007,
+	HV_X64_REGISTER_XMM8			= 0x00030008,
+	HV_X64_REGISTER_XMM9			= 0x00030009,
+	HV_X64_REGISTER_XMM10			= 0x0003000A,
+	HV_X64_REGISTER_XMM11			= 0x0003000B,
+	HV_X64_REGISTER_XMM12			= 0x0003000C,
+	HV_X64_REGISTER_XMM13			= 0x0003000D,
+	HV_X64_REGISTER_XMM14			= 0x0003000E,
+	HV_X64_REGISTER_XMM15			= 0x0003000F,
+	HV_X64_REGISTER_FP_MMX0			= 0x00030010,
+	HV_X64_REGISTER_FP_MMX1			= 0x00030011,
+	HV_X64_REGISTER_FP_MMX2			= 0x00030012,
+	HV_X64_REGISTER_FP_MMX3			= 0x00030013,
+	HV_X64_REGISTER_FP_MMX4			= 0x00030014,
+	HV_X64_REGISTER_FP_MMX5			= 0x00030015,
+	HV_X64_REGISTER_FP_MMX6			= 0x00030016,
+	HV_X64_REGISTER_FP_MMX7			= 0x00030017,
+	HV_X64_REGISTER_FP_CONTROL_STATUS	= 0x00030018,
+	HV_X64_REGISTER_XMM_CONTROL_STATUS	= 0x00030019,
+
+	/* X64 Control Registers */
+	HV_X64_REGISTER_CR0	= 0x00040000,
+	HV_X64_REGISTER_CR2	= 0x00040001,
+	HV_X64_REGISTER_CR3	= 0x00040002,
+	HV_X64_REGISTER_CR4	= 0x00040003,
+	HV_X64_REGISTER_CR8	= 0x00040004,
+	HV_X64_REGISTER_XFEM	= 0x00040005,
+
+	/* X64 Intermediate Control Registers */
+	HV_X64_REGISTER_INTERMEDIATE_CR0	= 0x00041000,
+	HV_X64_REGISTER_INTERMEDIATE_CR4	= 0x00041003,
+	HV_X64_REGISTER_INTERMEDIATE_CR8	= 0x00041004,
+
+	/* X64 Debug Registers */
+	HV_X64_REGISTER_DR0	= 0x00050000,
+	HV_X64_REGISTER_DR1	= 0x00050001,
+	HV_X64_REGISTER_DR2	= 0x00050002,
+	HV_X64_REGISTER_DR3	= 0x00050003,
+	HV_X64_REGISTER_DR6	= 0x00050004,
+	HV_X64_REGISTER_DR7	= 0x00050005,
+
+	/* X64 Segment Registers */
+	HV_X64_REGISTER_ES	= 0x00060000,
+	HV_X64_REGISTER_CS	= 0x00060001,
+	HV_X64_REGISTER_SS	= 0x00060002,
+	HV_X64_REGISTER_DS	= 0x00060003,
+	HV_X64_REGISTER_FS	= 0x00060004,
+	HV_X64_REGISTER_GS	= 0x00060005,
+	HV_X64_REGISTER_LDTR	= 0x00060006,
+	HV_X64_REGISTER_TR	= 0x00060007,
+
+	/* X64 Table Registers */
+	HV_X64_REGISTER_IDTR	= 0x00070000,
+	HV_X64_REGISTER_GDTR	= 0x00070001,
+
+	/* X64 Virtualized MSRs */
+	HV_X64_REGISTER_TSC		= 0x00080000,
+	HV_X64_REGISTER_EFER		= 0x00080001,
+	HV_X64_REGISTER_KERNEL_GS_BASE	= 0x00080002,
+	HV_X64_REGISTER_APIC_BASE	= 0x00080003,
+	HV_X64_REGISTER_PAT		= 0x00080004,
+	HV_X64_REGISTER_SYSENTER_CS	= 0x00080005,
+	HV_X64_REGISTER_SYSENTER_EIP	= 0x00080006,
+	HV_X64_REGISTER_SYSENTER_ESP	= 0x00080007,
+	HV_X64_REGISTER_STAR		= 0x00080008,
+	HV_X64_REGISTER_LSTAR		= 0x00080009,
+	HV_X64_REGISTER_CSTAR		= 0x0008000A,
+	HV_X64_REGISTER_SFMASK		= 0x0008000B,
+	HV_X64_REGISTER_INITIAL_APIC_ID	= 0x0008000C,
+
+	/* X64 Cache control MSRs */
+	HV_X64_REGISTER_MSR_MTRR_CAP		= 0x0008000D,
+	HV_X64_REGISTER_MSR_MTRR_DEF_TYPE	= 0x0008000E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE0	= 0x00080010,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE1	= 0x00080011,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE2	= 0x00080012,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE3	= 0x00080013,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE4	= 0x00080014,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE5	= 0x00080015,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE6	= 0x00080016,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE7	= 0x00080017,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE8	= 0x00080018,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASE9	= 0x00080019,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEA	= 0x0008001A,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEB	= 0x0008001B,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEC	= 0x0008001C,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASED	= 0x0008001D,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEE	= 0x0008001E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_BASEF	= 0x0008001F,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK0	= 0x00080040,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK1	= 0x00080041,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK2	= 0x00080042,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK3	= 0x00080043,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK4	= 0x00080044,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK5	= 0x00080045,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK6	= 0x00080046,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK7	= 0x00080047,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK8	= 0x00080048,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASK9	= 0x00080049,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKA	= 0x0008004A,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKB	= 0x0008004B,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKC	= 0x0008004C,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKD	= 0x0008004D,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKE	= 0x0008004E,
+	HV_X64_REGISTER_MSR_MTRR_PHYS_MASKF	= 0x0008004F,
+	HV_X64_REGISTER_MSR_MTRR_FIX64K00000	= 0x00080070,
+	HV_X64_REGISTER_MSR_MTRR_FIX16K80000	= 0x00080071,
+	HV_X64_REGISTER_MSR_MTRR_FIX16KA0000	= 0x00080072,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KC0000	= 0x00080073,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KC8000	= 0x00080074,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KD0000	= 0x00080075,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KD8000	= 0x00080076,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KE0000	= 0x00080077,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KE8000	= 0x00080078,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KF0000	= 0x00080079,
+	HV_X64_REGISTER_MSR_MTRR_FIX4KF8000	= 0x0008007A,
+
+	HV_X64_REGISTER_TSC_AUX		= 0x0008007B,
+	HV_X64_REGISTER_BNDCFGS		= 0x0008007C,
+	HV_X64_REGISTER_DEBUG_CTL	= 0x0008007D,
+
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL0	= 0x00080080,
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL1	= 0x00080081,
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL2	= 0x00080082,
+	HV_X64_REGISTER_SGX_LAUNCH_CONTROL3	= 0x00080083,
+	HV_X64_REGISTER_SPEC_CTRL		= 0x00080084,
+	HV_X64_REGISTER_PRED_CMD		= 0x00080085,
+	HV_X64_REGISTER_VIRT_SPEC_CTRL		= 0x00080086,
+	HV_X64_REGISTER_TSC_ADJUST		= 0x00080096,
+
+	/* Other MSRs */
+	HV_X64_REGISTER_MSR_IA32_MISC_ENABLE		= 0x000800A0,
+	HV_X64_REGISTER_IA32_FEATURE_CONTROL		= 0x000800A1,
+	HV_X64_REGISTER_IA32_VMX_BASIC			= 0x000800A2,
+	HV_X64_REGISTER_IA32_VMX_PINBASED_CTLS		= 0x000800A3,
+	HV_X64_REGISTER_IA32_VMX_PROCBASED_CTLS		= 0x000800A4,
+	HV_X64_REGISTER_IA32_VMX_EXIT_CTLS		= 0x000800A5,
+	HV_X64_REGISTER_IA32_VMX_ENTRY_CTLS		= 0x000800A6,
+	HV_X64_REGISTER_IA32_VMX_MISC			= 0x000800A7,
+	HV_X64_REGISTER_IA32_VMX_CR0_FIXED0		= 0x000800A8,
+	HV_X64_REGISTER_IA32_VMX_CR0_FIXED1		= 0x000800A9,
+	HV_X64_REGISTER_IA32_VMX_CR4_FIXED0		= 0x000800AA,
+	HV_X64_REGISTER_IA32_VMX_CR4_FIXED1		= 0x000800AB,
+	HV_X64_REGISTER_IA32_VMX_VMCS_ENUM		= 0x000800AC,
+	HV_X64_REGISTER_IA32_VMX_PROCBASED_CTLS2	= 0x000800AD,
+	HV_X64_REGISTER_IA32_VMX_EPT_VPID_CAP		= 0x000800AE,
+	HV_X64_REGISTER_IA32_VMX_TRUE_PINBASED_CTLS	= 0x000800AF,
+	HV_X64_REGISTER_IA32_VMX_TRUE_PROCBASED_CTLS	= 0x000800B0,
+	HV_X64_REGISTER_IA32_VMX_TRUE_EXIT_CTLS		= 0x000800B1,
+	HV_X64_REGISTER_IA32_VMX_TRUE_ENTRY_CTLS	= 0x000800B2,
+
+	HV_X64_REGISTER_REG_PAGE	= 0x0009001C,
+};
+
+
+/*
+ * Arch compatibility regs for use with hv_set/get_register
+ */
+#define HV_MSR_VP_INDEX		(HV_X64_MSR_VP_INDEX)
+#define HV_MSR_TIME_REF_COUNT	(HV_X64_MSR_TIME_REF_COUNT)
+#define HV_MSR_REFERENCE_TSC	(HV_X64_MSR_REFERENCE_TSC)
+#define HV_MSR_STIMER0_CONFIG	(HV_X64_MSR_STIMER0_CONFIG)
+#define HV_MSR_STIMER0_COUNT	(HV_X64_MSR_STIMER0_COUNT)
+
+#define HV_MSR_SCONTROL		(HV_X64_MSR_SCONTROL)
+#define HV_MSR_SIEFP		(HV_X64_MSR_SIEFP)
+#define HV_MSR_SIMP		(HV_X64_MSR_SIMP)
+#define HV_MSR_SIRBP		(HV_X64_MSR_SIRBP)
+#define HV_MSR_EOM		(HV_X64_MSR_EOM)
+#define HV_MSR_SINT0		(HV_X64_MSR_SINT0)
+
+#define HV_MSR_NESTED_SCONTROL	(HV_X64_MSR_NESTED_SCONTROL)
+#define HV_MSR_NESTED_SIEFP	(HV_X64_MSR_NESTED_SIEFP)
+#define HV_MSR_NESTED_SIMP	(HV_X64_MSR_NESTED_SIMP)
+#define HV_MSR_NESTED_EOM	(HV_X64_MSR_NESTED_EOM)
+#define HV_MSR_NESTED_SINT0	(HV_X64_MSR_NESTED_SINT0)
+
+#define HV_MSR_CRASH_P0		(HV_X64_MSR_CRASH_P0)
+#define HV_MSR_CRASH_P1		(HV_X64_MSR_CRASH_P1)
+#define HV_MSR_CRASH_P2		(HV_X64_MSR_CRASH_P2)
+#define HV_MSR_CRASH_P3		(HV_X64_MSR_CRASH_P3)
+#define HV_MSR_CRASH_P4		(HV_X64_MSR_CRASH_P4)
+#define HV_MSR_CRASH_CTL	(HV_X64_MSR_CRASH_CTL)
+
+/* General Hypervisor Register Content Definitions */
+
+union hv_explicit_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	} __packed;
+};
+
+union hv_intercept_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	} __packed;
+};
+
+union hv_dispatch_suspend_register {
+	__u64 as_uint64;
+	struct {
+		__u64 suspended : 1;
+		__u64 reserved : 63;
+	} __packed;
+};
+
+union hv_x64_interrupt_state_register {
+	__u64 as_uint64;
+	struct {
+		__u64 interrupt_shadow : 1;
+		__u64 nmi_masked : 1;
+		__u64 reserved : 62;
+	} __packed;
+};
+
+union hv_x64_pending_exception_event {
+	__u64 as_uint64[2];
+	struct {
+		__u32 event_pending : 1;
+		__u32 event_type : 3;
+		__u32 reserved0 : 4;
+		__u32 deliver_error_code : 1;
+		__u32 reserved1 : 7;
+		__u32 vector : 16;
+		__u32 error_code;
+		__u64 exception_parameter;
+	} __packed;
+};
+
+union hv_x64_pending_virtualization_fault_event {
+	__u64 as_uint64[2];
+	struct {
+		__u32 event_pending : 1;
+		__u32 event_type : 3;
+		__u32 reserved0 : 4;
+		__u32 reserved1 : 8;
+		__u32 parameter0 : 16;
+		__u32 code;
+		__u64 parameter1;
+	} __packed;
+};
+
+// bunch of stuff in between
+
+union hv_x64_pending_interruption_register {
+	__u64 as_uint64;
+	struct {
+		__u32 interruption_pending : 1;
+		__u32 interruption_type : 3;
+		__u32 deliver_error_code : 1;
+		__u32 instruction_length : 4;
+		__u32 nested_event : 1;
+		__u32 reserved : 6;
+		__u32 interruption_vector : 16;
+		__u32 error_code;
+	} __packed;
+};
+
+union hv_register_value {
+	struct hv_u128 reg128;
+	__u64 reg64;
+	__u32 reg32;
+	__u16 reg16;
+	__u8 reg8;
+
+	union hv_x64_fp_register fp;
+	union hv_x64_fp_control_status_register fp_control_status;
+	union hv_x64_xmm_control_status_register xmm_control_status;
+	struct hv_x64_segment_register segment;
+	struct hv_x64_table_register table;
+	union hv_explicit_suspend_register explicit_suspend;
+	union hv_intercept_suspend_register intercept_suspend;
+	union hv_dispatch_suspend_register dispatch_suspend;
+	union hv_x64_interrupt_state_register interrupt_state;
+	union hv_x64_pending_interruption_register pending_interruption;
+	union hv_x64_msr_npiep_config_contents npiep_config;
+	union hv_x64_pending_exception_event pending_exception_event;
+	union hv_x64_pending_virtualization_fault_event
+		pending_virtualization_fault_event;
+};
+
+struct hv_register_assoc {
+	__u32 name;			/* enum hv_register_name */
+	__u32 reserved1;
+	__u64 reserved2;
+	union hv_register_value value;
+} __packed;
+
+struct hv_input_get_vp_registers {
+	__u64 partition_id;
+	__u32 vp_index;
+	union hv_input_vtl input_vtl;
+	__u8  rsvd_z8;
+	__u16 rsvd_z16;
+	__u32 names[];
+} __packed;
+
+struct hv_input_set_vp_registers {
+	__u64 partition_id;
+	__u32 vp_index;
+	union hv_input_vtl input_vtl;
+	__u8  rsvd_z8;
+	__u16 rsvd_z16;
+	struct hv_register_assoc elements[];
+} __packed;
+
+union hv_msi_entry {
+	u64 as_uint64;
+	struct {
+		u32 address;
+		u32 data;
+	} __packed;
+};
+
+enum hv_interrupt_source {
+	HV_INTERRUPT_SOURCE_MSI = 1, /* MSI and MSI-X */
+	HV_INTERRUPT_SOURCE_IOAPIC,
+};
+
+union hv_ioapic_rte {
+	u64 as_uint64;
+
+	struct {
+		u32 vector:8;
+		u32 delivery_mode:3;
+		u32 destination_mode:1;
+		u32 delivery_status:1;
+		u32 interrupt_polarity:1;
+		u32 remote_irr:1;
+		u32 trigger_mode:1;
+		u32 interrupt_mask:1;
+		u32 reserved1:15;
+
+		u32 reserved2:24;
+		u32 destination_id:8;
+	};
+
+	struct {
+		u32 low_uint32;
+		u32 high_uint32;
+	};
+} __packed;
+
+struct hv_interrupt_entry {
+	u32 source; /* enum hv_interrupt_source */
+	u32 reserved1;
+	union {
+		union hv_msi_entry msi_entry;
+		union hv_ioapic_rte ioapic_rte;
+	};
+} __packed;
+
+enum hv_intercept_type {
+	HV_INTERCEPT_TYPE_X64_IO_PORT			= 0X00000000,
+	HV_INTERCEPT_TYPE_X64_MSR			= 0X00000001,
+	HV_INTERCEPT_TYPE_X64_CPUID			= 0X00000002,
+	HV_INTERCEPT_TYPE_EXCEPTION			= 0X00000003,
+	HV_INTERCEPT_TYPE_REGISTER			= 0X00000004,
+	HV_INTERCEPT_TYPE_MMIO				= 0X00000005,
+	HV_INTERCEPT_TYPE_X64_GLOBAL_CPUID		= 0X00000006,
+	HV_INTERCEPT_TYPE_X64_APIC_SMI			= 0X00000007,
+	HV_INTERCEPT_TYPE_HYPERCALL			= 0X00000008,
+	HV_INTERCEPT_TYPE_X64_APIC_INIT_SIPI		= 0X00000009,
+	HV_INTERCEPT_TYPE_X64_APIC_WRITE		= 0X0000000B,
+	HV_INTERCEPT_TYPE_X64_MSR_INDEX			= 0X0000000C,
+	HV_INTERCEPT_TYPE_MAX,
+	HV_INTERCEPT_TYPE_INVALID			= 0XFFFFFFFF,
+};
+
+union hv_intercept_parameters {
+	/*  HV_INTERCEPT_PARAMETERS is defined to be an 8-byte field. */
+	__u64 as_uint64;
+	/* HV_INTERCEPT_TYPE_X64_IO_PORT */
+	__u16 io_port;
+	/* HV_INTERCEPT_TYPE_X64_CPUID */
+	__u32 cpuid_index;
+	/* HV_INTERCEPT_TYPE_X64_APIC_WRITE */
+	__u32 apic_write_mask;
+	/* HV_INTERCEPT_TYPE_EXCEPTION */
+	__u16 exception_vector;
+	/* HV_INTERCEPT_TYPE_X64_MSR_INDEX */
+	__u32 msr_index;
+	/* N.B. Other intercept types do not have any parameters. */
+};
+
+/* Access types for the install intercept hypercall parameter */
+#define HV_INTERCEPT_ACCESS_MASK_NONE		0x00
+#define HV_INTERCEPT_ACCESS_MASK_READ		0X01
+#define HV_INTERCEPT_ACCESS_MASK_WRITE		0x02
+#define HV_INTERCEPT_ACCESS_MASK_EXECUTE	0x04
+
+struct hv_input_install_intercept {
+	__u64 partition_id;
+	__u32 access_type;	/* mask */
+	__u32 intercept_type;	/* hv_intercept_type */
+	union hv_intercept_parameters intercept_parameter;
+} __packed;
+
+#endif /* _UAPI_HV_HVGDK_MINI_H */
diff --git a/include/uapi/hyperv/hvhdk.h b/include/uapi/hyperv/hvhdk.h
new file mode 100644
index 000000000000..90184628db8b
--- /dev/null
+++ b/include/uapi/hyperv/hvhdk.h
@@ -0,0 +1,1352 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * These files (hvhdk.h, hvhdk_mini.h, hvgdk.h, hvgdk_mini.h) define APIs for
+ * communicating with the Microsoft Hypervisor.
+ *
+ * These definitions are subject to change across hypervisor versions, and as
+ * such are separate and independent from hyperv-tlfs.h.
+ *
+ * The naming of these headers reflects conventions used in the Microsoft
+ * Hypervisor.
+ */
+#ifndef _UAPI_HV_HVHDK_H
+#define _UAPI_HV_HVHDK_H
+
+#include "hvhdk_mini.h"
+#include "hvgdk.h"
+
+/* Bits for dirty mask of hv_vp_register_page */
+#define HV_X64_REGISTER_CLASS_GENERAL	0
+#define HV_X64_REGISTER_CLASS_IP	1
+#define HV_X64_REGISTER_CLASS_XMM	2
+#define HV_X64_REGISTER_CLASS_SEGMENT	3
+#define HV_X64_REGISTER_CLASS_FLAGS	4
+
+#define HV_VP_REGISTER_PAGE_VERSION_1	1u
+
+struct hv_vp_register_page {
+	__u16 version;
+	__u8 isvalid;
+	__u8 rsvdz;
+	__u32 dirty;
+	union {
+		struct {
+			/* General purpose registers
+			 * (HV_X64_REGISTER_CLASS_GENERAL)
+			 */
+			union {
+				struct {
+					__u64 rax;
+					__u64 rcx;
+					__u64 rdx;
+					__u64 rbx;
+					__u64 rsp;
+					__u64 rbp;
+					__u64 rsi;
+					__u64 rdi;
+					__u64 r8;
+					__u64 r9;
+					__u64 r10;
+					__u64 r11;
+					__u64 r12;
+					__u64 r13;
+					__u64 r14;
+					__u64 r15;
+				} __packed;
+
+				__u64 gp_registers[16];
+			};
+			/* Instruction pointer (HV_X64_REGISTER_CLASS_IP) */
+			__u64 rip;
+			/* Flags (HV_X64_REGISTER_CLASS_FLAGS) */
+			__u64 rflags;
+		} __packed;
+
+		__u64 registers[18];
+	};
+	/* Volatile XMM registers (HV_X64_REGISTER_CLASS_XMM) */
+	union {
+		struct {
+			struct hv_u128 xmm0;
+			struct hv_u128 xmm1;
+			struct hv_u128 xmm2;
+			struct hv_u128 xmm3;
+			struct hv_u128 xmm4;
+			struct hv_u128 xmm5;
+		} __packed;
+
+		struct hv_u128 xmm_registers[6];
+	};
+	/* Segment registers (HV_X64_REGISTER_CLASS_SEGMENT) */
+	union {
+		struct {
+			struct hv_x64_segment_register es;
+			struct hv_x64_segment_register cs;
+			struct hv_x64_segment_register ss;
+			struct hv_x64_segment_register ds;
+			struct hv_x64_segment_register fs;
+			struct hv_x64_segment_register gs;
+		} __packed;
+
+		struct hv_x64_segment_register segment_registers[6];
+	};
+	/* Misc. control registers (cannot be set via this interface) */
+	__u64 cr0;
+	__u64 cr3;
+	__u64 cr4;
+	__u64 cr8;
+	__u64 efer;
+	__u64 dr7;
+	union hv_x64_pending_interruption_register pending_interruption;
+	union hv_x64_interrupt_state_register interrupt_state;
+	__u64 instruction_emulation_hints;
+} __packed;
+
+#define HV_PARTITION_PROCESSOR_FEATURES_BANKS 2
+
+union hv_partition_processor_features {
+	__u64 as_uint64[HV_PARTITION_PROCESSOR_FEATURES_BANKS];
+	struct {
+		__u64 sse3_support:1;
+		__u64 lahf_sahf_support:1;
+		__u64 ssse3_support:1;
+		__u64 sse4_1_support:1;
+		__u64 sse4_2_support:1;
+		__u64 sse4a_support:1;
+		__u64 xop_support:1;
+		__u64 pop_cnt_support:1;
+		__u64 cmpxchg16b_support:1;
+		__u64 altmovcr8_support:1;
+		__u64 lzcnt_support:1;
+		__u64 mis_align_sse_support:1;
+		__u64 mmx_ext_support:1;
+		__u64 amd3dnow_support:1;
+		__u64 extended_amd3dnow_support:1;
+		__u64 page_1gb_support:1;
+		__u64 aes_support:1;
+		__u64 pclmulqdq_support:1;
+		__u64 pcid_support:1;
+		__u64 fma4_support:1;
+		__u64 f16c_support:1;
+		__u64 rd_rand_support:1;
+		__u64 rd_wr_fs_gs_support:1;
+		__u64 smep_support:1;
+		__u64 enhanced_fast_string_support:1;
+		__u64 bmi1_support:1;
+		__u64 bmi2_support:1;
+		__u64 hle_support_deprecated:1;
+		__u64 rtm_support_deprecated:1;
+		__u64 movbe_support:1;
+		__u64 npiep1_support:1;
+		__u64 dep_x87_fpu_save_support:1;
+		__u64 rd_seed_support:1;
+		__u64 adx_support:1;
+		__u64 intel_prefetch_support:1;
+		__u64 smap_support:1;
+		__u64 hle_support:1;
+		__u64 rtm_support:1;
+		__u64 rdtscp_support:1;
+		__u64 clflushopt_support:1;
+		__u64 clwb_support:1;
+		__u64 sha_support:1;
+		__u64 x87_pointers_saved_support:1;
+		__u64 invpcid_support:1;
+		__u64 ibrs_support:1;
+		__u64 stibp_support:1;
+		__u64 ibpb_support: 1;
+		__u64 unrestricted_guest_support:1;
+		__u64 mdd_support:1;
+		__u64 fast_short_rep_mov_support:1;
+		__u64 l1dcache_flush_support:1;
+		__u64 rdcl_no_support:1;
+		__u64 ibrs_all_support:1;
+		__u64 skip_l1df_support:1;
+		__u64 ssb_no_support:1;
+		__u64 rsb_a_no_support:1;
+		__u64 virt_spec_ctrl_support:1;
+		__u64 rd_pid_support:1;
+		__u64 umip_support:1;
+		__u64 mbs_no_support:1;
+		__u64 mb_clear_support:1;
+		__u64 taa_no_support:1;
+		__u64 tsx_ctrl_support:1;
+		/*
+		 * N.B. The final processor feature bit in bank 0 is reserved to
+		 * simplify potential downlevel backports.
+		 */
+		__u64 reserved_bank0:1;
+
+		/* N.B. Begin bank 1 processor features. */
+		__u64 acount_mcount_support:1;
+		__u64 tsc_invariant_support:1;
+		__u64 cl_zero_support:1;
+		__u64 rdpru_support:1;
+		__u64 la57_support:1;
+		__u64 mbec_support:1;
+		__u64 nested_virt_support:1;
+		__u64 psfd_support:1;
+		__u64 cet_ss_support:1;
+		__u64 cet_ibt_support:1;
+		__u64 vmx_exception_inject_support:1;
+		__u64 enqcmd_support:1;
+		__u64 umwait_tpause_support:1;
+		__u64 movdiri_support:1;
+		__u64 movdir64b_support:1;
+		__u64 cldemote_support:1;
+		__u64 serialize_support:1;
+		__u64 tsc_deadline_tmr_support:1;
+		__u64 tsc_adjust_support:1;
+		__u64 fzlrep_movsb:1;
+		__u64 fsrep_stosb:1;
+		__u64 fsrep_cmpsb:1;
+		__u64 reserved_bank1:42;
+	} __packed;
+};
+
+union hv_partition_processor_xsave_features {
+	struct {
+		__u64 xsave_support : 1;
+		__u64 xsaveopt_support : 1;
+		__u64 avx_support : 1;
+		__u64 reserved1 : 61;
+	} __packed;
+	__u64 as_uint64;
+};
+
+struct hv_partition_creation_properties {
+	union hv_partition_processor_features disabled_processor_features;
+	union hv_partition_processor_xsave_features
+		disabled_processor_xsave_features;
+} __packed;
+
+
+/*
+ * Definition of the partition isolation state. Used for
+ * HV_PARTITION_PROPERTY_ISOLATION_STATE.
+ *
+ *
+ * The isolation states (hv_partition_isolation_state) are sub-states of
+ * ObPartitionActive that apply to VBS and hardware isolated partitions.
+ * For VBS isolation, the trusted host VTL 1 component uses the isolation
+ * state to establish a binding between a hypervisor partition and its
+ * own partition context, and to enforce certain invariants.
+ *
+ * Hardware-isolated partitions (including partitions that simulate
+ * hardware isolation) also use isolation states to track the progression
+ * of the partition security state through the architectural state machine.
+ * Insecure states indicate that there is no architectural state
+ * associated with the partition, and Secure indicates that the partition
+ * has secure architectural state.
+ *
+ * ObPartitionRestoring is treated differently for isolated partitions.
+ * Only the trusted host component is allowed to restore partition state,
+ * and ObPartitionRestoring can only transition directly to/from secure.
+ *
+ *
+ * ..................................................................
+ * .         UNINITIALIZED     FINALIZED                            .
+ * .               |           ^       ^                            .
+ * .    Initialize |          /         \                           .
+ * .               |         /           \                          .
+ * . --------------|--------/--- ACTIVE --\------------------------ .
+ * . |             |       /               \                      | .
+ * . |             |      / Finalize        \ Finalize            | .
+ * . |             v     /                   \                    | .
+ * . |       INSECURE-CLEAN <---------------- INSECURE-DIRTY      | .
+ * . |                   \        Scrub      ^                    | .
+ * . |                    \                 /                     | .
+ * . |                     \               /                      | .
+ * . |               Secure \             / Unsecure              | .
+ * . |                       \           /                        | .
+ * . |                        \         /                         | .
+ * . |                         v       /                          | .
+ * . |                           SECURE                           | .
+ * . |                             ^                              | .
+ * . |_____________________________|______________________________| .
+ * .                               |                                .
+ * .                               v                                .
+ * .                           RESTORING                            .
+ * ..................................................................
+ */
+enum hv_partition_isolation_state {
+	/*
+	 * Initial and final state for all non-isolated partitions.
+	 */
+	HV_PARTITION_ISOLATION_INVALID             = 0,
+
+	/*
+	 * An "Insecure" partition is not being used by the trusted host
+	 * component. In this state, VPs can be created and deleted. VPs cannot
+	 * be started, and VP registers cannot be modified.
+
+	 * Initial state of an isolated partition as result of Initialize or
+	 * Scrub hypercalls. Guest-visible partition and VP state is considered
+	 * "clean", in the sense that a call to ObScrubPartition should not
+	 * result in any changes. Also, there are no accepted or confidential
+	 * pages assigned to the partition. InsecureRundown is enabled.
+	 */
+	HV_PARTITION_ISOLATION_INSECURE_CLEAN       = 1,
+
+	/*
+	 * Guest-visible partition and VP state is not "clean". Hence it must
+	 * be scrubbed first. One of 2 explicit states the trusted host
+	 * component can request. It cannot transition the state to Secure. In
+	 * this state,
+	 *  - IsolationControl is clear.
+	 *  - Secure rundowns are completely disabled.
+	 *  - No assigned pages exist.
+	 */
+	HV_PARTITION_ISOLATION_INSECURE_DIRTY       = 2,
+
+	/*
+	 * The partition is being used by the trusted host component (and is
+	 * typically bound to a single partition context in that component).
+	 * One of 2 explicit states the trusted host component can request. In
+	 * this state,
+	 *  - VPs cannot be created or deleted.
+	 *  - Partition cannot be finalized, scrubbed.
+	 *  - Insecure rundowns are completely disabled.
+	 */
+	HV_PARTITION_ISOLATION_SECURE              = 3,
+
+	/*
+	 * Represents a failed attempt to transition to Secure state. Partition
+	 * in this state cannot be finalized, scrubbed since one or more pages
+	 * may be assigned.
+	 */
+	HV_PARTITION_ISOLATION_SECURE_DIRTY         = 4,
+
+	/*
+	 * An internal state indicating that a partition is in the process of
+	 * transitioning from Secure to InsecureDirty.
+	 */
+	HV_PARTITION_ISOLATION_SECURE_TERMINATING   = 5,
+};
+
+
+#define HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS 1
+
+union hv_partition_synthetic_processor_features {
+	__u64 as_uint64[HV_PARTITION_SYNTHETIC_PROCESSOR_FEATURES_BANKS];
+
+	struct {
+		/* Report a hypervisor is present. CPUID leaves
+		 * 0x40000000 and 0x40000001 are supported.
+		 */
+		__u64 hypervisor_present:1;
+
+		/*
+		 * Features associated with HV#1:
+		 */
+
+		/* Report support for Hv1 (CPUID leaves 0x40000000 - 0x40000006). */
+		__u64 hv1:1;
+
+		/* Access to HV_X64_MSR_VP_RUNTIME.
+		 * Corresponds to access_vp_run_time_reg privilege.
+		 */
+		__u64 access_vp_run_time_reg:1;
+
+		/* Access to HV_X64_MSR_TIME_REF_COUNT.
+		 * Corresponds to access_partition_reference_counter privilege.
+		 */
+		__u64 access_partition_reference_counter:1;
+
+		/* Access to SINT-related registers (HV_X64_MSR_SCONTROL through
+		 * HV_X64_MSR_EOM and HV_X64_MSR_SINT0 through HV_X64_MSR_SINT15).
+		 * Corresponds to access_synic_regs privilege.
+		 */
+		__u64 access_synic_regs:1;
+
+		/* Access to synthetic timers and associated MSRs
+		 * (HV_X64_MSR_STIMER0_CONFIG through HV_X64_MSR_STIMER3_COUNT).
+		 * Corresponds to access_synthetic_timer_regs privilege.
+		 */
+		__u64 access_synthetic_timer_regs:1;
+
+		/* Access to APIC MSRs (HV_X64_MSR_EOI, HV_X64_MSR_ICR and HV_X64_MSR_TPR)
+		 * as well as the VP assist page.
+		 * Corresponds to access_intr_ctrl_regs privilege.
+		 */
+		__u64 access_intr_ctrl_regs:1;
+
+		/* Access to registers associated with hypercalls (HV_X64_MSR_GUEST_OS_ID
+		 * and HV_X64_MSR_HYPERCALL).
+		 * Corresponds to access_hypercall_msrs privilege.
+		 */
+		__u64 access_hypercall_regs:1;
+
+		/* VP index can be queried. corresponds to access_vp_index privilege. */
+		__u64 access_vp_index:1;
+
+		/* Access to the reference TSC. Corresponds to access_partition_reference_tsc
+		 * privilege.
+		 */
+		__u64 access_partition_reference_tsc:1;
+
+		/* Partition has access to the guest idle reg. Corresponds to
+		 * access_guest_idle_reg privilege.
+		 */
+		__u64 access_guest_idle_reg:1;
+
+		/* Partition has access to frequency regs. corresponds to access_frequency_regs
+		 * privilege.
+		 */
+		__u64 access_frequency_regs:1;
+
+		__u64 reserved_z12:1; /* Reserved for access_reenlightenment_controls. */
+		__u64 reserved_z13:1; /* Reserved for access_root_scheduler_reg. */
+		__u64 reserved_z14:1; /* Reserved for access_tsc_invariant_controls. */
+
+		/* Extended GVA ranges for HvCallFlushVirtualAddressList hypercall.
+		 * Corresponds to privilege.
+		 */
+		__u64 enable_extended_gva_ranges_for_flush_virtual_address_list:1;
+
+		__u64 reserved_z16:1; /* Reserved for access_vsm. */
+		__u64 reserved_z17:1; /* Reserved for access_vp_registers. */
+
+		/* Use fast hypercall output. Corresponds to privilege. */
+		__u64 fast_hypercall_output:1;
+
+		__u64 reserved_z19:1; /* Reserved for enable_extended_hypercalls. */
+
+		/*
+		 * HvStartVirtualProcessor can be used to start virtual processors.
+		 * Corresponds to privilege.
+		 */
+		__u64 start_virtual_processor:1;
+
+		__u64 reserved_z21:1; /* Reserved for Isolation. */
+
+		/* Synthetic timers in direct mode. */
+		__u64 direct_synthetic_timers:1;
+
+		__u64 reserved_z23:1; /* Reserved for synthetic time unhalted timer */
+
+		/* Use extended processor masks. */
+		__u64 extended_processor_masks:1;
+
+		/* HvCallFlushVirtualAddressSpace / HvCallFlushVirtualAddressList are supported. */
+		__u64 tb_flush_hypercalls:1;
+
+		/* HvCallSendSyntheticClusterIpi is supported. */
+		__u64 synthetic_cluster_ipi:1;
+
+		/* HvCallNotifyLongSpinWait is supported. */
+		__u64 notify_long_spin_wait:1;
+
+		/* HvCallQueryNumaDistance is supported. */
+		__u64 query_numa_distance:1;
+
+		/* HvCallSignalEvent is supported. Corresponds to privilege. */
+		__u64 signal_events:1;
+
+		/* HvCallRetargetDeviceInterrupt is supported. */
+		__u64 retarget_device_interrupt:1;
+
+		/* HvCallRestorePartitionTime is supported. */
+		__u64 restore_time:1;
+
+		/* EnlightenedVmcs nested enlightenment is supported. */
+		__u64 enlightened_vmcs:1;
+
+		__u64 reserved:31;
+	} __packed;
+};
+
+#define HV_MAKE_COMPATIBILITY_VERSION(major_, minor_)	\
+	((__u32)((major_) << 8 | (minor_)))
+
+#define HV_COMPATIBILITY_21_H2		HV_MAKE_COMPATIBILITY_VERSION(0X6, 0X9)
+
+union hv_partition_isolation_properties {
+	__u64 as_uint64;
+	struct {
+		__u64 isolation_type: 5;
+		__u64 isolation_host_type : 2;
+		__u64 rsvd_z: 5;
+		__u64 shared_gpa_boundary_page_number: 52;
+	} __packed;
+};
+
+/*
+ * Various isolation types supported by MSHV.
+ */
+#define HV_PARTITION_ISOLATION_TYPE_NONE            0
+#define HV_PARTITION_ISOLATION_TYPE_SNP             2
+#define HV_PARTITION_ISOLATION_TYPE_TDX             3
+
+/*
+ * Various host isolation types supported by MSHV.
+ */
+#define HV_PARTITION_ISOLATION_HOST_TYPE_NONE       0x0
+#define HV_PARTITION_ISOLATION_HOST_TYPE_HARDWARE   0x1
+#define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
+
+/* Note: Exo partition is enabled by default */
+#define HV_PARTITION_CREATION_FLAG_EXO_PARTITION                    (1 << 8)
+#define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED                    (1 << 13)
+#define HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED   (1 << 19)
+#define HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE                   (1 << 22)
+
+struct hv_input_create_partition {
+	__u64 flags;
+	union hv_proximity_domain_info proximity_domain_info;
+	__u32 compatibility_version;
+	__u32 padding;
+	struct hv_partition_creation_properties partition_creation_properties;
+	union hv_partition_isolation_properties isolation_properties;
+} __packed;
+
+struct hv_output_create_partition {
+	__u64 partition_id;
+} __packed;
+
+struct hv_input_initialize_partition {
+	__u64 partition_id;
+} __packed;
+
+struct hv_input_finalize_partition {
+	__u64 partition_id;
+} __packed;
+
+struct hv_input_delete_partition {
+	__u64 partition_id;
+} __packed;
+
+struct hv_input_get_partition_property {
+	__u64 partition_id;
+	__u32 property_code; /* enum hv_partition_property_code */
+	__u32 padding;
+} __packed;
+
+struct hv_output_get_partition_property {
+	__u64 property_value;
+} __packed;
+
+struct hv_input_set_partition_property {
+	__u64 partition_id;
+	__u32 property_code; /* enum hv_partition_property_code */
+	__u32 padding;
+	__u64 property_value;
+} __packed;
+
+enum hv_vp_state_page_type {
+	HV_VP_STATE_PAGE_REGISTERS = 0,
+	HV_VP_STATE_PAGE_INTERCEPT_MESSAGE = 1,
+	HV_VP_STATE_PAGE_COUNT
+};
+
+struct hv_input_map_vp_state_page {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u32 type; /* enum hv_vp_state_page_type */
+} __packed;
+
+struct hv_output_map_vp_state_page {
+	__u64 map_location; /* GPA page number */
+} __packed;
+
+struct hv_input_unmap_vp_state_page {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u32 type; /* enum hv_vp_state_page_type */
+} __packed;
+
+struct hv_cpuid_leaf_info {
+	__u32 eax;
+	__u32 ecx;
+	__u64 xfem;
+	__u64 xss;
+} __packed;
+
+union hv_get_vp_cpuid_values_flags {
+	__u32 as_uint32;
+	struct {
+		__u32 use_vp_xfem_xss: 1;
+		__u32 apply_registered_values: 1;
+		__u32 reserved: 30;
+	} __packed;
+} __packed;
+
+struct hv_input_get_vp_cpuid_values {
+	__u64 partition_id;
+	__u32 vp_index;
+	union hv_get_vp_cpuid_values_flags flags;
+	__u32 reserved;
+	__u32 padding;
+	struct hv_cpuid_leaf_info cpuid_leaf_info[];
+} __packed;
+
+// NOTE: Not in hvhdk headers
+union hv_output_get_vp_cpuid_values {
+	__u32 as_uint32[4];
+	struct {
+		__u32 eax;
+		__u32 ebx;
+		__u32 ecx;
+		__u32 edx;
+	} __packed;
+};
+
+enum hv_translate_gva_result_code {
+	HV_TRANSLATE_GVA_SUCCESS			= 0,
+
+	/* Translation failures. */
+	HV_TRANSLATE_GVA_PAGE_NOT_PRESENT		= 1,
+	HV_TRANSLATE_GVA_PRIVILEGE_VIOLATION		= 2,
+	HV_TRANSLATE_GVA_INVALID_PAGE_TABLE_FLAGS	= 3,
+
+	/* GPA access failures. */
+	HV_TRANSLATE_GVA_GPA_UNMAPPED			= 4,
+	HV_TRANSLATE_GVA_GPA_NO_READ_ACCESS		= 5,
+	HV_TRANSLATE_GVA_GPA_NO_WRITE_ACCESS		= 6,
+	HV_TRANSLATE_GVA_GPA_ILLEGAL_OVERLAY_ACCESS	= 7,
+
+	/*
+	 * Intercept for memory access by either
+	 *  - a higher VTL
+	 *  - a nested hypervisor (due to a violation of the nested page table)
+	 */
+	HV_TRANSLATE_GVA_INTERCEPT			= 8,
+
+	HV_TRANSLATE_GVA_GPA_UNACCEPTED			= 9,
+};
+
+union hv_translate_gva_result {
+	__u64 as_uint64;
+	struct {
+		__u32 result_code; /* enum hv_translate_hva_result_code */
+		__u32 cache_type : 8;
+		__u32 overlay_page : 1;
+		__u32 reserved : 23;
+	} __packed;
+};
+
+/* Define synthetic interrupt controller flag constants. */
+#define HV_EVENT_FLAGS_COUNT		(256 * 8)
+#define HV_EVENT_FLAGS_BYTE_COUNT	(256)
+#define HV_EVENT_FLAGS_LONG_COUNT	(256 / sizeof(__u32))
+
+struct hv_x64_apic_eoi_message {
+	__u32 vp_index;
+	__u32 interrupt_vector;
+} __packed;
+
+static inline int hv_get_interrupt_vector_from_payload(__u64 payload)
+{
+	struct hv_x64_apic_eoi_message *eoi_msg =
+		(struct hv_x64_apic_eoi_message *)payload;
+
+	return eoi_msg->interrupt_vector;
+}
+
+struct hv_opaque_intercept_message {
+	__u32 vp_index;
+} __packed;
+
+enum hv_port_type {
+	HV_PORT_TYPE_MESSAGE = 1,
+	HV_PORT_TYPE_EVENT   = 2,
+	HV_PORT_TYPE_MONITOR = 3,
+	HV_PORT_TYPE_DOORBELL = 4	/* Root Partition only */
+};
+
+struct hv_port_info {
+	__u32 port_type; /* enum hv_port_type */
+	__u32 padding;
+	union {
+		struct {
+			__u32 target_sint;
+			__u32 target_vp;
+			__u64 rsvdz;
+		} message_port_info;
+		struct {
+			__u32 target_sint;
+			__u32 target_vp;
+			__u16 base_flag_number;
+			__u16 flag_count;
+			__u32 rsvdz;
+		} event_port_info;
+		struct {
+			__u64 monitor_address;
+			__u64 rsvdz;
+		} monitor_port_info;
+		struct {
+			__u32 target_sint;
+			__u32 target_vp;
+			__u64 rsvdz;
+		} doorbell_port_info;
+	};
+} __packed;
+
+struct hv_connection_info {
+	__u32 port_type;
+	__u32 padding;
+	union {
+		struct {
+			__u64 rsvdz;
+		} message_connection_info;
+		struct {
+			__u64 rsvdz;
+		} event_connection_info;
+		struct {
+			__u64 monitor_address;
+		} monitor_connection_info;
+		struct {
+			__u64 gpa;
+			__u64 trigger_value;
+			__u64 flags;
+		} doorbell_connection_info;
+	};
+} __packed;
+
+/* Define the synthetic interrupt controller event flags format. */
+union hv_synic_event_flags {
+	unsigned char flags8[HV_EVENT_FLAGS_BYTE_COUNT];
+	unsigned long flags[HV_EVENT_FLAGS_LONG_COUNT];
+};
+
+struct hv_synic_event_flags_page {
+	union hv_synic_event_flags event_flags[HV_SYNIC_SINT_COUNT];
+};
+
+#define HV_SYNIC_EVENT_RING_MESSAGE_COUNT 63
+
+struct hv_synic_event_ring {
+	__u8  signal_masked;
+	__u8  ring_full;
+	__u16 reserved_z;
+	__u32 data[HV_SYNIC_EVENT_RING_MESSAGE_COUNT];
+} __packed;
+
+struct hv_synic_event_ring_page {
+	struct hv_synic_event_ring sint_event_ring[HV_SYNIC_SINT_COUNT];
+};
+
+union hv_synic_scontrol {
+	__u64 as_uint64;
+	struct {
+		__u64 enable:1;
+		__u64 reserved:63;
+	} __packed;
+};
+
+union hv_synic_siefp {
+	__u64 as_uint64;
+	struct {
+		__u64 siefp_enabled:1;
+		__u64 preserved:11;
+		__u64 base_siefp_gpa:52;
+	} __packed;
+};
+
+union hv_synic_sirbp {
+	__u64 as_uint64;
+	struct {
+		__u64 sirbp_enabled:1;
+		__u64 preserved:11;
+		__u64 base_sirbp_gpa:52;
+	} __packed;
+};
+
+union hv_interrupt_control {
+	__u64 as_uint64;
+	struct {
+		__u32 interrupt_type; /* enum hv_interrupt type */
+		__u32 level_triggered : 1;
+		__u32 logical_dest_mode : 1;
+		__u32 rsvd : 30;
+	} __packed;
+};
+
+struct hv_local_interrupt_controller_state {
+	/* HV_X64_INTERRUPT_CONTROLLER_STATE */
+	__u32 apic_id;
+	__u32 apic_version;
+	__u32 apic_ldr;
+	__u32 apic_dfr;
+	__u32 apic_spurious;
+	__u32 apic_isr[8];
+	__u32 apic_tmr[8];
+	__u32 apic_irr[8];
+	__u32 apic_esr;
+	__u32 apic_icr_high;
+	__u32 apic_icr_low;
+	__u32 apic_lvt_timer;
+	__u32 apic_lvt_thermal;
+	__u32 apic_lvt_perfmon;
+	__u32 apic_lvt_lint0;
+	__u32 apic_lvt_lint1;
+	__u32 apic_lvt_error;
+	__u32 apic_lvt_cmci;
+	__u32 apic_error_status;
+	__u32 apic_initial_count;
+	__u32 apic_counter_value;
+	__u32 apic_divide_configuration;
+	__u32 apic_remote_read;
+} __packed;
+
+struct hv_stimer_state {
+	struct {
+		/*
+		 * Indicates if there is an undelivered timer expiry message.
+		 */
+		__u32 undelivered_msg_pending:1;
+		__u32 reserved:31;
+	} __packed flags;
+
+	__u32 resvd;
+
+	/* Timer configuration and count. */
+	__u64 config;
+	__u64 count;
+
+	/* Timer adjustment. */
+	__u64 adjustment;
+
+	/* Expiration time of the undelivered message. */
+	__u64 undelivered_exp_time;
+} __packed;
+
+struct hv_synthetic_timers_state {
+	struct hv_stimer_state timers[HV_SYNIC_STIMER_COUNT];
+
+	/* Reserved space for time unhalted timer. */
+	__u64 reserved[5];
+} __packed;
+
+union hv_x64_vp_execution_state {
+	__u16 as_uint16;
+	struct {
+		__u16 cpl:2;
+		__u16 cr0_pe:1;
+		__u16 cr0_am:1;
+		__u16 efer_lma:1;
+		__u16 debug_active:1;
+		__u16 interruption_pending:1;
+		__u16 vtl:4;
+		__u16 enclave_mode:1;
+		__u16 interrupt_shadow:1;
+		__u16 virtualization_fault_active:1;
+		__u16 reserved:2;
+	} __packed;
+};
+
+struct hv_x64_intercept_message_header {
+	__u32 vp_index;
+	__u8 instruction_length:4;
+	__u8 cr8:4; /* Only set for exo partitions */
+	__u8 intercept_access_type;
+	union hv_x64_vp_execution_state execution_state;
+	struct hv_x64_segment_register cs_segment;
+	__u64 rip;
+	__u64 rflags;
+} __packed;
+
+#define HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS 6
+
+struct hv_x64_hypercall_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u64 rax;
+	__u64 rbx;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 r8;
+	__u64 rsi;
+	__u64 rdi;
+	struct hv_u128 xmmregisters[HV_HYPERCALL_INTERCEPT_MAX_XMM_REGISTERS];
+	struct {
+		__u32 isolated:1;
+		__u32 reserved:31;
+	} __packed;
+} __packed;
+
+union hv_x64_register_access_info {
+	union hv_register_value source_value;
+	__u32 destination_register;
+	__u64 source_address;
+	__u64 destination_address;
+};
+
+struct hv_x64_register_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	struct {
+		__u8 is_memory_op:1;
+		__u8 reserved:7;
+	} __packed;
+	__u8 reserved8;
+	__u16 reserved16;
+	__u32 register_name;
+	union hv_x64_register_access_info access_info;
+} __packed;
+
+union hv_x64_memory_access_info {
+	__u8 as_uint8;
+	struct {
+		__u8 gva_valid:1;
+		__u8 gva_gpa_valid:1;
+		__u8 hypercall_output_pending:1;
+		__u8 tlb_locked_no_overlay:1;
+		__u8 reserved:4;
+	} __packed;
+};
+
+union hv_x64_io_port_access_info {
+	__u8 as_uint8;
+	struct {
+		__u8 access_size:3;
+		__u8 string_op:1;
+		__u8 rep_prefix:1;
+		__u8 reserved:3;
+	} __packed;
+};
+
+union hv_x64_exception_info {
+	__u8 as_uint8;
+	struct {
+		__u8 error_code_valid:1;
+		__u8 software_exception:1;
+		__u8 reserved:6;
+	} __packed;
+};
+
+struct hv_x64_memory_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 cache_type; /* enum hv_cache_type */
+	__u8 instruction_byte_count;
+	union hv_x64_memory_access_info memory_access_info;
+	__u8 tpr_priority;
+	__u8 reserved1;
+	__u64 guest_virtual_address;
+	__u64 guest_physical_address;
+	__u8 instruction_bytes[16];
+} __packed;
+
+struct hv_x64_cpuid_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u64 rax;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 rbx;
+	__u64 default_result_rax;
+	__u64 default_result_rcx;
+	__u64 default_result_rdx;
+	__u64 default_result_rbx;
+} __packed;
+
+struct hv_x64_msr_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 msr_number;
+	__u32 reserved;
+	__u64 rdx;
+	__u64 rax;
+} __packed;
+
+struct hv_x64_io_port_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u16 port_number;
+	union hv_x64_io_port_access_info access_info;
+	__u8 instruction_byte_count;
+	__u32 reserved;
+	__u64 rax;
+	__u8 instruction_bytes[16];
+	struct hv_x64_segment_register ds_segment;
+	struct hv_x64_segment_register es_segment;
+	__u64 rcx;
+	__u64 rsi;
+	__u64 rdi;
+} __packed;
+
+struct hv_x64_exception_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u16 exception_vector;
+	union hv_x64_exception_info exception_info;
+	__u8 instruction_byte_count;
+	__u32 error_code;
+	__u64 exception_parameter;
+	__u64 reserved;
+	__u8 instruction_bytes[16];
+	struct hv_x64_segment_register ds_segment;
+	struct hv_x64_segment_register ss_segment;
+	__u64 rax;
+	__u64 rcx;
+	__u64 rdx;
+	__u64 rbx;
+	__u64 rsp;
+	__u64 rbp;
+	__u64 rsi;
+	__u64 rdi;
+	__u64 r8;
+	__u64 r9;
+	__u64 r10;
+	__u64 r11;
+	__u64 r12;
+	__u64 r13;
+	__u64 r14;
+	__u64 r15;
+} __packed;
+
+struct hv_x64_invalid_vp_register_message {
+	__u32 vp_index;
+	__u32 reserved;
+} __packed;
+
+struct hv_x64_unrecoverable_exception_message {
+	struct hv_x64_intercept_message_header header;
+} __packed;
+
+#define HV_UNSUPPORTED_FEATURE_INTERCEPT	1
+#define HV_UNSUPPORTED_FEATURE_TASK_SWITCH_TSS	2
+
+struct hv_x64_unsupported_feature_message {
+	__u32 vp_index;
+	__u32 feature_code;
+	__u64 feature_parameter;
+} __packed;
+
+struct hv_x64_halt_message {
+	struct hv_x64_intercept_message_header header;
+} __packed;
+
+#define HV_X64_PENDING_INTERRUPT	0
+#define HV_X64_PENDING_NMI		2
+#define HV_X64_PENDING_EXCEPTION	3
+
+struct hv_x64_interruption_deliverable_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 deliverable_type; /* pending interruption type */
+	__u32 rsvd;
+} __packed;
+
+struct hv_x64_sint_deliverable_message {
+	struct hv_x64_intercept_message_header header;
+	__u16 deliverable_sints;
+	__u16 rsvd1;
+	__u32 rsvd2;
+} __packed;
+
+struct hv_x64_sipi_intercept_message {
+	struct hv_x64_intercept_message_header header;
+	__u32 target_vp_index;
+	__u32 interrupt_vector;
+} __packed;
+
+struct hv_register_x64_cpuid_result_parameters {
+	struct {
+		__u32 eax;
+		__u32 ecx;
+		__u8 subleaf_specific;
+		__u8 always_override;
+		__u16 padding;
+	} __packed input;
+	struct {
+		__u32 eax;
+		__u32 eax_mask;
+		__u32 ebx;
+		__u32 ebx_mask;
+		__u32 ecx;
+		__u32 ecx_mask;
+		__u32 edx;
+		__u32 edx_mask;
+	} __packed result;
+} __packed;
+
+struct hv_register_x64_msr_result_parameters {
+	__u32 msr_index;
+	__u32 access_type;
+	__u32 action; /* enum hv_unimplemented_msr_action */
+} __packed;
+
+union hv_register_intercept_result_parameters {
+	struct hv_register_x64_cpuid_result_parameters cpuid;
+	struct hv_register_x64_msr_result_parameters msr;
+} __packed;
+
+struct hv_async_completion_message_payload {
+	__u64 partition_id;
+	__u32 status;
+	__u32 completion_count;
+	__u64 sub_status;
+} __packed;
+
+struct hv_input_translate_virtual_address {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u32 padding;
+	__u64 control_flags;
+	__u64 gva_page;
+} __packed;
+
+struct hv_output_translate_virtual_address {
+	union hv_translate_gva_result translation_result;
+	__u64 gpa_page;
+} __packed;
+
+enum hv_cache_type {
+	HV_CACHE_TYPE_UNCACHED		= 0,
+	HV_CACHE_TYPE_WRITE_COMBINING	= 1,
+	HV_CACHE_TYPE_WRITE_THROUGH	= 4,
+	HV_CACHE_TYPE_WRITE_PROTECTED	= 5,
+	HV_CACHE_TYPE_WRITE_BACK	= 6,
+};
+
+#define HV_SUPPORTS_REGISTER_INTERCEPT
+
+struct hv_input_register_intercept_result {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u32 intercept_type; /* enum hv_intercept_type */
+	union hv_register_intercept_result_parameters parameters;
+} __packed;
+
+struct hv_input_assert_virtual_interrupt {
+	__u64 partition_id;
+	union hv_interrupt_control control;
+	__u64 dest_addr; /* cpu's apic id */
+	__u32 vector;
+	__u8 target_vtl;
+	__u8 rsvd_z0;
+	__u16 rsvd_z1;
+} __packed;
+
+struct hv_input_create_port {
+	__u64 port_partition_id;
+	union hv_port_id port_id;
+	__u8 port_vtl;
+	__u8 min_connection_vtl;
+	__u16 padding;
+	__u64 connection_partition_id;
+	struct hv_port_info port_info;
+	union hv_proximity_domain_info proximity_domain_info;
+} __packed;
+
+union hv_input_delete_port {
+	__u64 as_uint64[2];
+	struct {
+		__u64 port_partition_id;
+		union hv_port_id port_id;
+		__u32 reserved;
+	};
+} __packed;
+
+struct hv_input_connect_port {
+	__u64 connection_partition_id;
+	union hv_connection_id connection_id;
+	__u8 connection_vtl;
+	__u8 rsvdz0;
+	__u16 rsvdz1;
+	__u64 port_partition_id;
+	union hv_port_id port_id;
+	__u32 reserved2;
+	struct hv_connection_info connection_info;
+	union hv_proximity_domain_info proximity_domain_info;
+} __packed;
+
+union hv_input_disconnect_port {
+	__u64 as_uint64[2];
+	struct {
+		__u64 connection_partition_id;
+		union hv_connection_id connection_id;
+		__u32 is_doorbell: 1;
+		__u32 reserved: 31;
+	} __packed;
+} __packed;
+
+union hv_input_notify_port_ring_empty {
+	__u64 as_uint64;
+	struct {
+		__u32 sint_index;
+		__u32 reserved;
+	};
+} __packed;
+
+struct hv_input_signal_event_direct {
+	__u64 target_partition;
+	__u32 target_vp;
+	__u8  target_vtl;
+	__u8  target_sint;
+	__u16 flag_number;
+} __packed;
+
+struct hv_output_signal_event_direct {
+	__u8	newly_signaled;
+	__u8	reserved[7];
+} __packed;
+
+struct hv_input_post_message_direct {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u8  vtl;
+	__u8  padding[3];
+	__u32 sint_index;
+	__u8  message[HV_MESSAGE_SIZE];
+	__u32 padding2;
+} __packed;
+
+struct hv_guest_mapping_flush_list { /* HV_INPUT_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST */
+	u64 address_space;
+	u64 flags;
+	union hv_gpa_page_range gpa_list[];
+};
+
+#define HV_SUPPORTS_VP_STATE
+
+struct hv_vp_state_data_xsave {
+	__u64 flags;
+	union hv_x64_xsave_xfem_register states;
+} __packed;
+
+/*
+ * For getting and setting VP state, there are two options based on the state type:
+ *
+ *     1.) Data that is accessed by PFNs in the input hypercall page. This is used
+ *         for state which may not fit into the hypercall pages.
+ *     2.) Data that is accessed directly in the input\output hypercall pages.
+ *         This is used for state that will always fit into the hypercall pages.
+ *
+ * In the future this could be dynamic based on the size if needed.
+ *
+ * Note these hypercalls have an 8-byte aligned variable header size as per the tlfs
+ */
+
+#define HV_GET_SET_VP_STATE_TYPE_PFN	(1 << 31)
+
+enum hv_get_set_vp_state_type {
+	HV_GET_SET_VP_STATE_LOCAL_INTERRUPT_CONTROLLER_STATE = 0 | HV_GET_SET_VP_STATE_TYPE_PFN,
+
+	HV_GET_SET_VP_STATE_XSAVE		= 1 | HV_GET_SET_VP_STATE_TYPE_PFN,
+	/* Synthetic message page */
+	HV_GET_SET_VP_STATE_SIM_PAGE		= 2 | HV_GET_SET_VP_STATE_TYPE_PFN,
+	/* Synthetic interrupt event flags page. */
+	HV_GET_SET_VP_STATE_SIEF_PAGE		= 3 | HV_GET_SET_VP_STATE_TYPE_PFN,
+
+	/* Synthetic timers. */
+	HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS	= 4,
+};
+
+struct hv_vp_state_data {
+	__u32 type;
+	__u32 rsvd;
+	struct hv_vp_state_data_xsave xsave;
+} __packed;
+
+struct hv_input_get_vp_state {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u8 input_vtl;
+	__u8 rsvd0;
+	__u16 rsvd1;
+	struct hv_vp_state_data state_data;
+	__u64 output_data_pfns[];
+} __packed;
+
+union hv_output_get_vp_state {
+	struct hv_local_interrupt_controller_state interrupt_controller_state;
+	struct hv_synthetic_timers_state synthetic_timers_state;
+} __packed;
+
+union hv_input_set_vp_state_data {
+	__u64 pfns;
+	__u8 bytes;
+} __packed;
+
+struct hv_input_set_vp_state {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u8 input_vtl;
+	__u8 rsvd0;
+	__u16 rsvd1;
+	struct hv_vp_state_data state_data;
+	union hv_input_set_vp_state_data data[];
+} __packed;
+
+/*
+ * Dispatch state for the VP communicated by the hypervisor to the
+ * VP-dispatching thread in the root on return from HVCALL_DISPATCH_VP.
+ */
+enum hv_vp_dispatch_state {
+	HV_VP_DISPATCH_STATE_INVALID = 0,
+	HV_VP_DISPATCH_STATE_BLOCKED = 1,
+	HV_VP_DISPATCH_STATE_READY = 2,
+};
+
+/*
+ * Dispatch event that caused the current dispatch state on return from
+ * HVCALL_DISPATCH_VP.
+ */
+enum hv_vp_dispatch_event {
+	HV_VP_DISPATCH_EVENT_INVALID =	0x00000000,
+	HV_VP_DISPATCH_EVENT_SUSPEND = 0x00000001,
+	HV_VP_DISPATCH_EVENT_INTERCEPT = 0x00000002,
+};
+
+#define HV_ROOT_SCHEDULER_MAX_VPS_PER_CHILD_PARTITION   1024
+/* The maximum array size of HV_GENERIC_SET (vp_set) buffer */
+#define HV_GENERIC_SET_QWORD_COUNT(max) (((((max) - 1) >> 6) + 1) + 2)
+
+struct hv_vp_signal_bitset_scheduler_message {
+	__u64 partition_id;
+	__u32 overflow_count;
+	__u16 vp_count;
+	__u16 reserved;
+
+#define BITSET_BUFFER_SIZE \
+	HV_GENERIC_SET_QWORD_COUNT(HV_ROOT_SCHEDULER_MAX_VPS_PER_CHILD_PARTITION)
+	union {
+		struct hv_vpset bitset;
+		__u64 bitset_buffer[BITSET_BUFFER_SIZE];
+	} vp_bitset;
+#undef BITSET_BUFFER_SIZE
+} __packed;
+
+#if defined(__KERNEL__)
+static_assert(sizeof(struct hv_vp_signal_bitset_scheduler_message) <=
+	(sizeof(struct hv_message) - sizeof(struct hv_message_header)));
+#endif
+
+#define HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT \
+	(((sizeof(struct hv_message) - sizeof(struct hv_message_header)) / \
+	 (sizeof(__u64 /* partition id */) + sizeof(__u32 /* vp index */))) - 1)
+
+struct hv_vp_signal_pair_scheduler_message {
+	__u32 overflow_count;
+	__u8 vp_count;
+	__u8 reserved1[3];
+
+	__u64 partition_ids[HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT];
+	__u32 vp_indexes[HV_MESSAGE_MAX_PARTITION_VP_PAIR_COUNT];
+
+	__u8 reserved2[4];
+} __packed;
+
+#if defined(__KERNEL__)
+static_assert(sizeof(struct hv_vp_signal_pair_scheduler_message) ==
+	(sizeof(struct hv_message) - sizeof(struct hv_message_header)));
+#endif
+
+/* Input and output structures for HVCALL_DISPATCH_VP */
+#define HV_DISPATCH_VP_FLAG_CLEAR_INTERCEPT_SUSPEND 0x1
+#define HV_DISPATCH_VP_FLAG_ENABLE_CALLER_INTERRUPTS 0x2
+#define HV_DISPATCH_VP_FLAG_SET_CALLER_SPEC_CTRL 0x4
+#define HV_DISPATCH_VP_FLAG_SKIP_VP_SPEC_FLUSH 0x8
+#define HV_DISPATCH_VP_FLAG_SKIP_CALLER_SPEC_FLUSH 0x10
+#define HV_DISPATCH_VP_FLAG_SKIP_CALLER_USER_SPEC_FLUSH 0x20
+
+struct hv_input_dispatch_vp {
+	__u64 partition_id;
+	__u32 vp_index;
+	__u32 flags;
+	__u64 time_slice; /* in 100ns */
+	__u64 spec_ctrl;
+} __packed;
+
+struct hv_output_dispatch_vp {
+	__u32 dispatch_state; /* enum hv_vp_dispatch_state */
+	__u32 dispatch_event; /* enum hv_vp_dispatch_event */
+} __packed;
+
+#endif /* _UAPI_HV_HVHDK_H */
diff --git a/include/uapi/hyperv/hvhdk_mini.h b/include/uapi/hyperv/hvhdk_mini.h
new file mode 100644
index 000000000000..c1c1cae127e5
--- /dev/null
+++ b/include/uapi/hyperv/hvhdk_mini.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * These files (hvhdk.h, hvhdk_mini.h, hvgdk.h, hvgdk_mini.h) define APIs for
+ * communicating with the Microsoft Hypervisor.
+ *
+ * These definitions are subject to change across hypervisor versions, and as
+ * such are separate and independent from hyperv-tlfs.h.
+ *
+ * The naming of these headers reflects conventions used in the Microsoft
+ * Hypervisor.
+ */
+#ifndef _UAPI_HV_HVHDK_MINI_H
+#define _UAPI_HV_HVHDK_MINI_H
+
+#include "hvgdk_mini.h"
+
+/*
+ * Doorbell connection_info flags.
+ */
+#define HV_DOORBELL_FLAG_TRIGGER_SIZE_MASK  0x00000007
+#define HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY   0x00000000
+#define HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE  0x00000001
+#define HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD  0x00000002
+#define HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD 0x00000003
+#define HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD 0x00000004
+#define HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE  0x80000000
+
+/* Each generic set contains 64 elements */
+#define HV_GENERIC_SET_SHIFT		(6)
+#define HV_GENERIC_SET_MASK		(63)
+
+enum hv_generic_set_format {
+	HV_GENERIC_SET_SPARSE_4K,
+	HV_GENERIC_SET_ALL,
+};
+
+
+/* NOTE: following two #defines are not defined in Hyper-V code */
+/* The maximum number of sparse vCPU banks which can be encoded by 'struct hv_vpset' */
+#define HV_MAX_SPARSE_VCPU_BANKS (64)
+/* The number of vCPUs in one sparse bank */
+#define HV_VCPUS_PER_SPARSE_BANK (64)
+
+enum hv_scheduler_type {
+	HV_SCHEDULER_TYPE_LP = 1, /* Classic scheduler w/o SMT */
+	HV_SCHEDULER_TYPE_LP_SMT = 2, /* Classic scheduler w/ SMT */
+	HV_SCHEDULER_TYPE_CORE_SMT = 3, /* Core scheduler */
+	HV_SCHEDULER_TYPE_ROOT = 4, /* Root / integrated scheduler */
+	HV_SCHEDULER_TYPE_MAX
+};
+
+struct hv_vpset {		/* HV_VP_SET */
+	__u64 format;
+	__u64 valid_bank_mask;
+	__u64 bank_contents[];
+} __packed;
+
+enum hv_partition_property_code {
+	/* Privilege properties */
+	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS				= 0x00010000,
+	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES			= 0x00010001,
+
+	/* Resource properties */
+	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING			= 0x00050005,
+	HV_PARTITION_PROPERTY_ISOLATION_STATE				= 0x0005000c,
+	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION                  = 0x00050017,
+
+	/* Compatibility properties */
+	HV_PARTITION_PROPERTY_PROCESSOR_XSAVE_FEATURES			= 0x00060002,
+	HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE			= 0x00060008,
+	HV_PARTITION_PROPERTY_PROCESSOR_CLOCK_FREQUENCY			= 0x00060009,
+};
+
+enum hv_system_property {
+	/* Add more values when needed */
+	HV_SYSTEM_PROPERTY_SCHEDULER_TYPE = 15,
+};
+struct hv_input_get_system_property {
+	__u32 property_id; /* enum hv_system_property */
+	union {
+		__u32 as_uint32;
+		/* More fields to be filled in when needed */
+	};
+} __packed;
+
+struct hv_output_get_system_property {
+	union {
+		__u32 scheduler_type; /* enum hv_scheduler_type */
+	};
+} __packed;
+
+struct hv_proximity_domain_flags {
+	__u32 proximity_preferred : 1;
+	__u32 reserved : 30;
+	__u32 proximity_info_valid : 1;
+} __packed;
+
+/* Not a union in windows but useful for zeroing */
+union hv_proximity_domain_info {
+	struct {
+		__u32 domain_id;
+		struct hv_proximity_domain_flags flags;
+	};
+	__u64 as_uint64;
+} __packed;
+
+struct hv_input_withdraw_memory {
+	__u64 partition_id;
+	union hv_proximity_domain_info proximity_domain_info;
+} __packed;
+
+struct hv_output_withdraw_memory {
+	/* Hack - compiler doesn't like empty array size
+	 * in struct with no other members
+	 */
+	__u64 gpa_page_list[0];
+} __packed;
+
+/* HV Map GPA (Guest Physical Address) Flags */
+#define HV_MAP_GPA_PERMISSIONS_NONE     0x0
+#define HV_MAP_GPA_READABLE             0x1
+#define HV_MAP_GPA_WRITABLE             0x2
+#define HV_MAP_GPA_KERNEL_EXECUTABLE    0x4
+#define HV_MAP_GPA_USER_EXECUTABLE      0x8
+#define HV_MAP_GPA_EXECUTABLE           0xC
+#define HV_MAP_GPA_PERMISSIONS_MASK     0xF
+
+struct hv_input_map_gpa_pages {
+	__u64 target_partition_id;
+	__u64 target_gpa_base;
+	__u32 map_flags;
+	__u32 padding;
+	__u64 source_gpa_page_list[];
+} __packed;
+
+union hv_gpa_page_access_state_flags {
+	struct {
+		__u64 clear_accessed : 1;
+		__u64 set_access : 1;
+		__u64 clear_dirty : 1;
+		__u64 set_dirty : 1;
+		__u64 reserved : 60;
+	} __packed;
+	__u64 as_uint64;
+};
+
+struct hv_input_get_gpa_pages_access_state {
+	__u64  partition_id;
+	union hv_gpa_page_access_state_flags flags;
+	__u64 hv_gpa_page_number;
+} __packed;
+
+union hv_gpa_page_access_state {
+	struct {
+		__u8 accessed : 1;
+		__u8 dirty : 1;
+		__u8 reserved: 6;
+	};
+	__u8 as_uint8;
+} __packed;
+
+#endif /* _UAPI_HV_HVHDK_MINI_H */
-- 
2.25.1

