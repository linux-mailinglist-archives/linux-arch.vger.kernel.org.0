Return-Path: <linux-arch+bounces-10836-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17699A61AB1
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 20:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E020B7ACE2E
	for <lists+linux-arch@lfdr.de>; Fri, 14 Mar 2025 19:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF6420F069;
	Fri, 14 Mar 2025 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TFrfo6vA"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8944A2054F5;
	Fri, 14 Mar 2025 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980574; cv=none; b=Ya6mN8TwAO+erF7qwaJrZ3KbfLTkv1xfQB6GRbHyDdwXKwmLQ1V1OsO/eCkPGklgAh9IvKqs5axtq/uJjVQANxwMt3NUlHS8wNEVCWYY98Sx9UuxhI0/YWxhhwOEL4RKHMnsRIXNSkjc+UyhXcK0Q+7pgwEYFUtRtSY3Xb+ccuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980574; c=relaxed/simple;
	bh=d7mDtq//3QIhqvvcn4gPOW3MKYW3DofGkaE34XolQQA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PzC1OMh0BS2m2lPbvn/0XH8JUo14r0XjiaHdR6iOIuieVf0Butg2zi0A4tO4JNcNf09RtNadawbi4OtK+zdW+ioTldaAoHFJ+Ri/GDZKA75PRp2cZ+rtnWD2epj2GrKAGiXhXH/SL4IaYLIkhD7QP1UDjfzEPzcrqCFTwvvyZCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TFrfo6vA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 348582045FF4;
	Fri, 14 Mar 2025 12:29:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 348582045FF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741980565;
	bh=RFVzYhHFCzBM8qJeETwuCmfTSP9Fw1ALdsXzJbQaBS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFrfo6vAora9XoH4nUBC7mMDGmm3S4hT/8RubmCBJCmrVRiPvicYk2ALm8TV72yoD
	 Nsu+9YJp267zQEV1CuCVteJzWaz5asVzlCjxnKqUjPVU6VQhobUpYqBhCWyFIXnsiB
	 4Jq1xMS5X6gwJQ+PewQ54DR/l72VZKcX/jGHDOFg=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com,
	ltykernel@gmail.com,
	stanislav.kinsburskiy@gmail.com,
	linux-acpi@vger.kernel.org,
	eahariha@linux.microsoft.com,
	jeff.johnson@oss.qualcomm.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@linaro.org,
	joro@8bytes.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	apais@linux.microsoft.com,
	gregkh@linuxfoundation.org,
	vkuznets@redhat.com,
	prapal@linux.microsoft.com,
	anrayabh@linux.microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	corbet@lwn.net
Subject: [PATCH v6 10/10] Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs
Date: Fri, 14 Mar 2025 12:28:56 -0700
Message-Id: <1741980536-3865-11-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

Provide a set of IOCTLs for creating and managing child partitions when
running as root partition on Hyper-V. The new driver is enabled via
CONFIG_MSHV_ROOT.

A brief overview of the interface:

MSHV_CREATE_PARTITION is the entry point, returning a file descriptor
representing a child partition. IOCTLs on this fd can be used to map
memory, create VPs, etc.

Creating a VP returns another file descriptor representing that VP which
in turn has another set of corresponding IOCTLs for running the VP,
getting/setting state, etc.

MSHV_ROOT_HVCALL is a generic "passthrough" hypercall IOCTL which can be
used for a number of partition or VP hypercalls. This is for hypercalls
that do not affect any state in the kernel driver, such as getting and
setting VP registers and partition properties, translating addresses,
etc. It is "passthrough" because the binary input and output for the
hypercall is only interpreted by the VMM - the kernel driver does
nothing but insert the VP and partition id where necessary (which are
always in the same place), and execute the hypercall.

Co-developed-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Signed-off-by: Anirudh Rayabharam <anrayabh@linux.microsoft.com>
Co-developed-by: Jinank Jain <jinankjain@microsoft.com>
Signed-off-by: Jinank Jain <jinankjain@microsoft.com>
Co-developed-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
Co-developed-by: Muminul Islam <muislam@microsoft.com>
Signed-off-by: Muminul Islam <muislam@microsoft.com>
Co-developed-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Co-developed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
 .../userspace-api/ioctl/ioctl-number.rst      |    2 +
 drivers/hv/Makefile                           |    5 +-
 drivers/hv/mshv.h                             |   30 +
 drivers/hv/mshv_common.c                      |  161 ++
 drivers/hv/mshv_eventfd.c                     |  833 ++++++
 drivers/hv/mshv_eventfd.h                     |   71 +
 drivers/hv/mshv_irq.c                         |  124 +
 drivers/hv/mshv_portid_table.c                |   84 +
 drivers/hv/mshv_root.h                        |  308 +++
 drivers/hv/mshv_root_hv_call.c                |  852 ++++++
 drivers/hv/mshv_root_main.c                   | 2333 +++++++++++++++++
 drivers/hv/mshv_synic.c                       |  665 +++++
 include/uapi/linux/mshv.h                     |  287 ++
 13 files changed, 5754 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hv/mshv.h
 create mode 100644 drivers/hv/mshv_common.c
 create mode 100644 drivers/hv/mshv_eventfd.c
 create mode 100644 drivers/hv/mshv_eventfd.h
 create mode 100644 drivers/hv/mshv_irq.c
 create mode 100644 drivers/hv/mshv_portid_table.c
 create mode 100644 drivers/hv/mshv_root.h
 create mode 100644 drivers/hv/mshv_root_hv_call.c
 create mode 100644 drivers/hv/mshv_root_main.c
 create mode 100644 drivers/hv/mshv_synic.c
 create mode 100644 include/uapi/linux/mshv.h

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 6d1465315df3..66dcfaae698b 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -370,6 +370,8 @@ Code  Seq#    Include File                                           Comments
 0xB7  all    uapi/linux/remoteproc_cdev.h                            <mailto:linux-remoteproc@vger.kernel.org>
 0xB7  all    uapi/linux/nsfs.h                                       <mailto:Andrei Vagin <avagin@openvz.org>>
 0xB8  01-02  uapi/misc/mrvl_cn10k_dpi.h                              Marvell CN10K DPI driver
+0xB8  all    uapi/linux/mshv.h                                       Microsoft Hyper-V /dev/mshv driver
+                                                                     <mailto:linux-hyperv@vger.kernel.org>
 0xC0  00-0F  linux/usb/iowarrior.h
 0xCA  00-0F  uapi/misc/cxl.h
 0xCA  10-2F  uapi/misc/ocxl.h
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 2b8dc954b350..976189c725dc 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_HYPERV)		+= hv_vmbus.o
 obj-$(CONFIG_HYPERV_UTILS)	+= hv_utils.o
 obj-$(CONFIG_HYPERV_BALLOON)	+= hv_balloon.o
+obj-$(CONFIG_MSHV_ROOT)		+= mshv_root.o
 
 CFLAGS_hv_trace.o = -I$(src)
 CFLAGS_hv_balloon.o = -I$(src)
@@ -11,7 +12,9 @@ hv_vmbus-y := vmbus_drv.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
+mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
+	       mshv_root_hv_call.o mshv_portid_table.o
 
 # Code that must be built-in
 obj-$(subst m,y,$(CONFIG_HYPERV)) += hv_common.o
-obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o
+obj-$(subst m,y,$(CONFIG_MSHV_ROOT)) += hv_proc.o mshv_common.o
diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
new file mode 100644
index 000000000000..0340a67acd0a
--- /dev/null
+++ b/drivers/hv/mshv.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ */
+
+#ifndef _MSHV_H_
+#define _MSHV_H_
+
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <hyperv/hvhdk.h>
+
+#define mshv_field_nonzero(STRUCT, MEMBER) \
+	memchr_inv(&((STRUCT).MEMBER), \
+		   0, sizeof_field(typeof(STRUCT), MEMBER))
+
+int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers);
+
+int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers);
+
+int hv_call_get_partition_property(u64 partition_id, u64 property_code,
+				   u64 *property_value);
+
+int mshv_do_pre_guest_mode_work(ulong th_flags);
+
+#endif /* _MSHV_H */
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
new file mode 100644
index 000000000000..2575e6d7a71f
--- /dev/null
+++ b/drivers/hv/mshv_common.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Microsoft Corporation.
+ *
+ * This file contains functions that will be called from one or more modules.
+ * If any of these modules are configured to build, this file is built and just
+ * statically linked in.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/mshyperv.h>
+#include <linux/resume_user_mode.h>
+
+#include "mshv.h"
+
+#define HV_GET_REGISTER_BATCH_SIZE	\
+	(HV_HYP_PAGE_SIZE / sizeof(union hv_register_value))
+#define HV_SET_REGISTER_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_registers)) \
+		/ sizeof(struct hv_register_assoc))
+
+int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers)
+{
+	struct hv_input_get_vp_registers *input_page;
+	union hv_register_value *output_page;
+	u16 completed = 0;
+	unsigned long remaining = count;
+	int rep_count, i;
+	u64 status = HV_STATUS_SUCCESS;
+	unsigned long flags;
+
+	local_irq_save(flags);
+
+	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	input_page->partition_id = partition_id;
+	input_page->vp_index = vp_index;
+	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
+	input_page->rsvd_z8 = 0;
+	input_page->rsvd_z16 = 0;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_GET_REGISTER_BATCH_SIZE);
+		for (i = 0; i < rep_count; ++i)
+			input_page->names[i] = registers[i].name;
+
+		status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
+					     0, input_page, output_page);
+		if (!hv_result_success(status))
+			break;
+
+		completed = hv_repcomp(status);
+		for (i = 0; i < completed; ++i)
+			registers[i].value = output_page[i];
+
+		registers += completed;
+		remaining -= completed;
+	}
+	local_irq_restore(flags);
+
+	return hv_result_to_errno(status);
+}
+EXPORT_SYMBOL_GPL(hv_call_get_vp_registers);
+
+int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+			     union hv_input_vtl input_vtl,
+			     struct hv_register_assoc *registers)
+{
+	struct hv_input_set_vp_registers *input_page;
+	u16 completed = 0;
+	unsigned long remaining = count;
+	int rep_count;
+	u64 status = HV_STATUS_SUCCESS;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	input_page->partition_id = partition_id;
+	input_page->vp_index = vp_index;
+	input_page->input_vtl.as_uint8 = input_vtl.as_uint8;
+	input_page->rsvd_z8 = 0;
+	input_page->rsvd_z16 = 0;
+
+	while (remaining) {
+		rep_count = min(remaining, HV_SET_REGISTER_BATCH_SIZE);
+		memcpy(input_page->elements, registers,
+		       sizeof(struct hv_register_assoc) * rep_count);
+
+		status = hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
+					     0, input_page, NULL);
+		if (!hv_result_success(status))
+			break;
+
+		completed = hv_repcomp(status);
+		registers += completed;
+		remaining -= completed;
+	}
+
+	local_irq_restore(flags);
+
+	return hv_result_to_errno(status);
+}
+EXPORT_SYMBOL_GPL(hv_call_set_vp_registers);
+
+int hv_call_get_partition_property(u64 partition_id,
+				   u64 property_code,
+				   u64 *property_value)
+{
+	u64 status;
+	unsigned long flags;
+	struct hv_input_get_partition_property *input;
+	struct hv_output_get_partition_property *output;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->property_code = property_code;
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_PROPERTY, input, output);
+
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		return hv_result_to_errno(status);
+	}
+	*property_value = output->property_value;
+
+	local_irq_restore(flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
+
+/*
+ * Handle any pre-processing before going into the guest mode on this cpu, most
+ * notably call schedule(). Must be invoked with both preemption and
+ * interrupts enabled.
+ *
+ * Returns: 0 on success, -errno on error.
+ */
+int mshv_do_pre_guest_mode_work(ulong th_flags)
+{
+	if (th_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
+		return -EINTR;
+
+	if (th_flags & _TIF_NEED_RESCHED)
+		schedule();
+
+	if (th_flags & _TIF_NOTIFY_RESUME)
+		resume_user_mode_work(NULL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mshv_do_pre_guest_mode_work);
diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
new file mode 100644
index 000000000000..8dd22be2ca0b
--- /dev/null
+++ b/drivers/hv/mshv_eventfd.c
@@ -0,0 +1,833 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * eventfd support for mshv
+ *
+ * Heavily inspired from KVM implementation of irqfd/ioeventfd. The basic
+ * framework code is taken from the kvm implementation.
+ *
+ * All credits to kvm developers.
+ */
+
+#include <linux/syscalls.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/file.h>
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include <linux/eventfd.h>
+
+#if IS_ENABLED(CONFIG_X86_64)
+#include <asm/apic.h>
+#endif
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+#include "mshv_root.h"
+
+static struct workqueue_struct *irqfd_cleanup_wq;
+
+void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
+				    struct mshv_irq_ack_notifier *mian)
+{
+	mutex_lock(&partition->pt_irq_lock);
+	hlist_add_head_rcu(&mian->link, &partition->irq_ack_notifier_list);
+	mutex_unlock(&partition->pt_irq_lock);
+}
+
+void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
+				      struct mshv_irq_ack_notifier *mian)
+{
+	mutex_lock(&partition->pt_irq_lock);
+	hlist_del_init_rcu(&mian->link);
+	mutex_unlock(&partition->pt_irq_lock);
+	synchronize_rcu();
+}
+
+bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi)
+{
+	struct mshv_irq_ack_notifier *mian;
+	bool acked = false;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(mian, &partition->irq_ack_notifier_list,
+				 link) {
+		if (mian->irq_ack_gsi == gsi) {
+			mian->irq_acked(mian);
+			acked = true;
+		}
+	}
+	rcu_read_unlock();
+
+	return acked;
+}
+
+#if IS_ENABLED(CONFIG_ARM64)
+static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type)
+{
+	return false;
+}
+#elif IS_ENABLED(CONFIG_X86_64)
+static inline bool hv_should_clear_interrupt(enum hv_interrupt_type type)
+{
+	return type == HV_X64_INTERRUPT_TYPE_EXTINT;
+}
+#endif
+
+static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
+{
+	struct mshv_irqfd_resampler *resampler;
+	struct mshv_partition *partition;
+	struct mshv_irqfd *irqfd;
+	int idx;
+
+	resampler = container_of(mian, struct mshv_irqfd_resampler,
+				 rsmplr_notifier);
+	partition = resampler->rsmplr_partn;
+
+	idx = srcu_read_lock(&partition->pt_irq_srcu);
+
+	hlist_for_each_entry_rcu(irqfd, &resampler->rsmplr_irqfd_list,
+				 irqfd_resampler_hnode) {
+		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
+			hv_call_clear_virtual_interrupt(partition->pt_id);
+
+		eventfd_signal(irqfd->irqfd_resamplefd);
+	}
+
+	srcu_read_unlock(&partition->pt_irq_srcu, idx);
+}
+
+#if IS_ENABLED(CONFIG_X86_64)
+static bool
+mshv_vp_irq_vector_injected(union hv_vp_register_page_interrupt_vectors iv,
+			    u32 vector)
+{
+	int i;
+
+	for (i = 0; i < iv.vector_count; i++) {
+		if (iv.vector[i] == vector)
+			return true;
+	}
+
+	return false;
+}
+
+static int mshv_vp_irq_try_set_vector(struct mshv_vp *vp, u32 vector)
+{
+	union hv_vp_register_page_interrupt_vectors iv, new_iv;
+
+	iv = vp->vp_register_page->interrupt_vectors;
+	new_iv = iv;
+
+	if (mshv_vp_irq_vector_injected(iv, vector))
+		return 0;
+
+	if (iv.vector_count >= HV_VP_REGISTER_PAGE_MAX_VECTOR_COUNT)
+		return -ENOSPC;
+
+	new_iv.vector[new_iv.vector_count++] = vector;
+
+	if (cmpxchg(&vp->vp_register_page->interrupt_vectors.as_uint64,
+		    iv.as_uint64, new_iv.as_uint64) != iv.as_uint64)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int mshv_vp_irq_set_vector(struct mshv_vp *vp, u32 vector)
+{
+	int ret;
+
+	do {
+		ret = mshv_vp_irq_try_set_vector(vp, vector);
+	} while (ret == -EAGAIN && !need_resched());
+
+	return ret;
+}
+
+/*
+ * Try to raise irq for guest via shared vector array. hyp does the actual
+ * inject of the interrupt.
+ */
+static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
+{
+	struct mshv_partition *partition = irqfd->irqfd_partn;
+	struct mshv_lapic_irq *irq = &irqfd->irqfd_lapic_irq;
+	struct mshv_vp *vp;
+
+	if (!(ms_hyperv.ext_features &
+	      HV_VP_DISPATCH_INTERRUPT_INJECTION_AVAILABLE))
+		return -EOPNOTSUPP;
+
+	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT)
+		return -EOPNOTSUPP;
+
+	if (irq->lapic_control.logical_dest_mode)
+		return -EOPNOTSUPP;
+
+	vp = partition->pt_vp_array[irq->lapic_apic_id];
+
+	if (!vp->vp_register_page)
+		return -EOPNOTSUPP;
+
+	if (mshv_vp_irq_set_vector(vp, irq->lapic_vector))
+		return -EINVAL;
+
+	if (vp->run.flags.root_sched_dispatched &&
+	    vp->vp_register_page->interrupt_vectors.as_uint64)
+		return -EBUSY;
+
+	wake_up(&vp->run.vp_suspend_queue);
+
+	return 0;
+}
+#else /* CONFIG_X86_64 */
+static int mshv_try_assert_irq_fast(struct mshv_irqfd *irqfd)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+static void mshv_assert_irq_slow(struct mshv_irqfd *irqfd)
+{
+	struct mshv_partition *partition = irqfd->irqfd_partn;
+	struct mshv_lapic_irq *irq = &irqfd->irqfd_lapic_irq;
+	unsigned int seq;
+	int idx;
+
+	WARN_ON(irqfd->irqfd_resampler &&
+		!irq->lapic_control.level_triggered);
+
+	idx = srcu_read_lock(&partition->pt_irq_srcu);
+	if (irqfd->irqfd_girq_ent.guest_irq_num) {
+		if (!irqfd->irqfd_girq_ent.girq_entry_valid) {
+			srcu_read_unlock(&partition->pt_irq_srcu, idx);
+			return;
+		}
+
+		do {
+			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+	}
+
+	hv_call_assert_virtual_interrupt(irqfd->irqfd_partn->pt_id,
+					 irq->lapic_vector, irq->lapic_apic_id,
+					 irq->lapic_control);
+	srcu_read_unlock(&partition->pt_irq_srcu, idx);
+}
+
+static void mshv_irqfd_resampler_shutdown(struct mshv_irqfd *irqfd)
+{
+	struct mshv_irqfd_resampler *rp = irqfd->irqfd_resampler;
+	struct mshv_partition *pt = rp->rsmplr_partn;
+
+	mutex_lock(&pt->irqfds_resampler_lock);
+
+	hlist_del_rcu(&irqfd->irqfd_resampler_hnode);
+	synchronize_srcu(&pt->pt_irq_srcu);
+
+	if (hlist_empty(&rp->rsmplr_irqfd_list)) {
+		hlist_del(&rp->rsmplr_hnode);
+		mshv_unregister_irq_ack_notifier(pt, &rp->rsmplr_notifier);
+		kfree(rp);
+	}
+
+	mutex_unlock(&pt->irqfds_resampler_lock);
+}
+
+/*
+ * Race-free decouple logic (ordering is critical)
+ */
+static void mshv_irqfd_shutdown(struct work_struct *work)
+{
+	struct mshv_irqfd *irqfd =
+			container_of(work, struct mshv_irqfd, irqfd_shutdown);
+
+	/*
+	 * Synchronize with the wait-queue and unhook ourselves to prevent
+	 * further events.
+	 */
+	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
+
+	if (irqfd->irqfd_resampler) {
+		mshv_irqfd_resampler_shutdown(irqfd);
+		eventfd_ctx_put(irqfd->irqfd_resamplefd);
+	}
+
+	/*
+	 * It is now safe to release the object's resources
+	 */
+	eventfd_ctx_put(irqfd->irqfd_eventfd_ctx);
+	kfree(irqfd);
+}
+
+/* assumes partition->pt_irqfds_lock is held */
+static bool mshv_irqfd_is_active(struct mshv_irqfd *irqfd)
+{
+	return !hlist_unhashed(&irqfd->irqfd_hnode);
+}
+
+/*
+ * Mark the irqfd as inactive and schedule it for removal
+ *
+ * assumes partition->pt_irqfds_lock is held
+ */
+static void mshv_irqfd_deactivate(struct mshv_irqfd *irqfd)
+{
+	if (!mshv_irqfd_is_active(irqfd))
+		return;
+
+	hlist_del(&irqfd->irqfd_hnode);
+
+	queue_work(irqfd_cleanup_wq, &irqfd->irqfd_shutdown);
+}
+
+/*
+ * Called with wqh->lock held and interrupts disabled
+ */
+static int mshv_irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode,
+			     int sync, void *key)
+{
+	struct mshv_irqfd *irqfd = container_of(wait, struct mshv_irqfd,
+						irqfd_wait);
+	unsigned long flags = (unsigned long)key;
+	int idx;
+	unsigned int seq;
+	struct mshv_partition *pt = irqfd->irqfd_partn;
+	int ret = 0;
+
+	if (flags & POLLIN) {
+		u64 cnt;
+
+		eventfd_ctx_do_read(irqfd->irqfd_eventfd_ctx, &cnt);
+		idx = srcu_read_lock(&pt->pt_irq_srcu);
+		do {
+			seq = read_seqcount_begin(&irqfd->irqfd_irqe_sc);
+		} while (read_seqcount_retry(&irqfd->irqfd_irqe_sc, seq));
+
+		/* An event has been signaled, raise an interrupt */
+		ret = mshv_try_assert_irq_fast(irqfd);
+		if (ret)
+			mshv_assert_irq_slow(irqfd);
+
+		srcu_read_unlock(&pt->pt_irq_srcu, idx);
+
+		ret = 1;
+	}
+
+	if (flags & POLLHUP) {
+		/* The eventfd is closing, detach from the partition */
+		unsigned long flags;
+
+		spin_lock_irqsave(&pt->pt_irqfds_lock, flags);
+
+		/*
+		 * We must check if someone deactivated the irqfd before
+		 * we could acquire the pt_irqfds_lock since the item is
+		 * deactivated from the mshv side before it is unhooked from
+		 * the wait-queue.  If it is already deactivated, we can
+		 * simply return knowing the other side will cleanup for us.
+		 * We cannot race against the irqfd going away since the
+		 * other side is required to acquire wqh->lock, which we hold
+		 */
+		if (mshv_irqfd_is_active(irqfd))
+			mshv_irqfd_deactivate(irqfd);
+
+		spin_unlock_irqrestore(&pt->pt_irqfds_lock, flags);
+	}
+
+	return ret;
+}
+
+/* Must be called under pt_irqfds_lock */
+static void mshv_irqfd_update(struct mshv_partition *pt,
+			      struct mshv_irqfd *irqfd)
+{
+	write_seqcount_begin(&irqfd->irqfd_irqe_sc);
+	irqfd->irqfd_girq_ent = mshv_ret_girq_entry(pt,
+						    irqfd->irqfd_irqnum);
+	mshv_copy_girq_info(&irqfd->irqfd_girq_ent, &irqfd->irqfd_lapic_irq);
+	write_seqcount_end(&irqfd->irqfd_irqe_sc);
+}
+
+void mshv_irqfd_routing_update(struct mshv_partition *pt)
+{
+	struct mshv_irqfd *irqfd;
+
+	spin_lock_irq(&pt->pt_irqfds_lock);
+	hlist_for_each_entry(irqfd, &pt->pt_irqfds_list, irqfd_hnode)
+		mshv_irqfd_update(pt, irqfd);
+	spin_unlock_irq(&pt->pt_irqfds_lock);
+}
+
+static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
+				  poll_table *polltbl)
+{
+	struct mshv_irqfd *irqfd =
+			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
+
+	irqfd->irqfd_wqh = wqh;
+	add_wait_queue_priority(wqh, &irqfd->irqfd_wait);
+}
+
+static int mshv_irqfd_assign(struct mshv_partition *pt,
+			     struct mshv_user_irqfd *args)
+{
+	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
+	struct mshv_irqfd *irqfd, *tmp;
+	unsigned int events;
+	struct fd f;
+	int ret;
+	int idx;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->irqfd_partn = pt;
+	irqfd->irqfd_irqnum = args->gsi;
+	INIT_WORK(&irqfd->irqfd_shutdown, mshv_irqfd_shutdown);
+	seqcount_spinlock_init(&irqfd->irqfd_irqe_sc, &pt->pt_irqfds_lock);
+
+	f = fdget(args->fd);
+	if (!fd_file(f)) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(fd_file(f));
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->irqfd_eventfd_ctx = eventfd;
+
+	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE)) {
+		struct mshv_irqfd_resampler *rp;
+
+		resamplefd = eventfd_ctx_fdget(args->resamplefd);
+		if (IS_ERR(resamplefd)) {
+			ret = PTR_ERR(resamplefd);
+			goto fail;
+		}
+
+		irqfd->irqfd_resamplefd = resamplefd;
+
+		mutex_lock(&pt->irqfds_resampler_lock);
+
+		hlist_for_each_entry(rp, &pt->irqfds_resampler_list,
+				     rsmplr_hnode) {
+			if (rp->rsmplr_notifier.irq_ack_gsi ==
+							 irqfd->irqfd_irqnum) {
+				irqfd->irqfd_resampler = rp;
+				break;
+			}
+		}
+
+		if (!irqfd->irqfd_resampler) {
+			rp = kzalloc(sizeof(*rp), GFP_KERNEL_ACCOUNT);
+			if (!rp) {
+				ret = -ENOMEM;
+				mutex_unlock(&pt->irqfds_resampler_lock);
+				goto fail;
+			}
+
+			rp->rsmplr_partn = pt;
+			INIT_HLIST_HEAD(&rp->rsmplr_irqfd_list);
+			rp->rsmplr_notifier.irq_ack_gsi = irqfd->irqfd_irqnum;
+			rp->rsmplr_notifier.irq_acked =
+						      mshv_irqfd_resampler_ack;
+
+			hlist_add_head(&rp->rsmplr_hnode,
+				       &pt->irqfds_resampler_list);
+			mshv_register_irq_ack_notifier(pt,
+						       &rp->rsmplr_notifier);
+			irqfd->irqfd_resampler = rp;
+		}
+
+		hlist_add_head_rcu(&irqfd->irqfd_resampler_hnode,
+				   &irqfd->irqfd_resampler->rsmplr_irqfd_list);
+
+		mutex_unlock(&pt->irqfds_resampler_lock);
+	}
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via
+	 * a callback whenever someone signals the underlying eventfd
+	 */
+	init_waitqueue_func_entry(&irqfd->irqfd_wait, mshv_irqfd_wakeup);
+	init_poll_funcptr(&irqfd->irqfd_polltbl, mshv_irqfd_queue_proc);
+
+	spin_lock_irq(&pt->pt_irqfds_lock);
+	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
+	    !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {
+		/*
+		 * Resample Fd must be for level triggered interrupt
+		 * Otherwise return with failure
+		 */
+		spin_unlock_irq(&pt->pt_irqfds_lock);
+		ret = -EINVAL;
+		goto fail;
+	}
+	ret = 0;
+	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
+		if (irqfd->irqfd_eventfd_ctx != tmp->irqfd_eventfd_ctx)
+			continue;
+		/* This fd is used for another irq already. */
+		ret = -EBUSY;
+		spin_unlock_irq(&pt->pt_irqfds_lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&pt->pt_irq_srcu);
+	mshv_irqfd_update(pt, irqfd);
+	hlist_add_head(&irqfd->irqfd_hnode, &pt->pt_irqfds_list);
+	spin_unlock_irq(&pt->pt_irqfds_lock);
+
+	/*
+	 * Check if there was an event already pending on the eventfd
+	 * before we registered, and trigger it as if we didn't miss it.
+	 */
+	events = vfs_poll(fd_file(f), &irqfd->irqfd_polltbl);
+
+	if (events & POLLIN)
+		mshv_assert_irq_slow(irqfd);
+
+	srcu_read_unlock(&pt->pt_irq_srcu, idx);
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the POLLHUP
+	 */
+	fdput(f);
+
+	return 0;
+
+fail:
+	if (irqfd->irqfd_resampler)
+		mshv_irqfd_resampler_shutdown(irqfd);
+
+	if (resamplefd && !IS_ERR(resamplefd))
+		eventfd_ctx_put(resamplefd);
+
+	if (eventfd && !IS_ERR(eventfd))
+		eventfd_ctx_put(eventfd);
+
+	fdput(f);
+
+out:
+	kfree(irqfd);
+	return ret;
+}
+
+/*
+ * shutdown any irqfd's that match fd+gsi
+ */
+static int mshv_irqfd_deassign(struct mshv_partition *pt,
+			       struct mshv_user_irqfd *args)
+{
+	struct mshv_irqfd *irqfd;
+	struct hlist_node *n;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	hlist_for_each_entry_safe(irqfd, n, &pt->pt_irqfds_list,
+				  irqfd_hnode) {
+		if (irqfd->irqfd_eventfd_ctx == eventfd &&
+		    irqfd->irqfd_irqnum == args->gsi)
+
+			mshv_irqfd_deactivate(irqfd);
+	}
+
+	eventfd_ctx_put(eventfd);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * so that we guarantee there will not be any more interrupts on this
+	 * gsi once this deassign function returns.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+
+	return 0;
+}
+
+int mshv_set_unset_irqfd(struct mshv_partition *pt,
+			 struct mshv_user_irqfd *args)
+{
+	if (args->flags & ~MSHV_IRQFD_FLAGS_MASK)
+		return -EINVAL;
+
+	if (args->flags & BIT(MSHV_IRQFD_BIT_DEASSIGN))
+		return mshv_irqfd_deassign(pt, args);
+
+	return mshv_irqfd_assign(pt, args);
+}
+
+/*
+ * This function is called as the mshv VM fd is being released.
+ * Shutdown all irqfds that still remain open
+ */
+static void mshv_irqfd_release(struct mshv_partition *pt)
+{
+	struct mshv_irqfd *irqfd;
+	struct hlist_node *n;
+
+	spin_lock_irq(&pt->pt_irqfds_lock);
+
+	hlist_for_each_entry_safe(irqfd, n, &pt->pt_irqfds_list, irqfd_hnode)
+		mshv_irqfd_deactivate(irqfd);
+
+	spin_unlock_irq(&pt->pt_irqfds_lock);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed
+	 * since we do not take a mshv_partition* reference.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+}
+
+int mshv_irqfd_wq_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void mshv_irqfd_wq_cleanup(void)
+{
+	destroy_workqueue(irqfd_cleanup_wq);
+}
+
+/*
+ * --------------------------------------------------------------------
+ * ioeventfd: translate a MMIO memory write to an eventfd signal.
+ *
+ * userspace can register a MMIO address with an eventfd for receiving
+ * notification when the memory has been touched.
+ * --------------------------------------------------------------------
+ */
+
+static void ioeventfd_release(struct mshv_ioeventfd *p, u64 partition_id)
+{
+	if (p->iovntfd_doorbell_id > 0)
+		mshv_unregister_doorbell(partition_id, p->iovntfd_doorbell_id);
+	eventfd_ctx_put(p->iovntfd_eventfd);
+	kfree(p);
+}
+
+/* MMIO writes trigger an event if the addr/val match */
+static void ioeventfd_mmio_write(int doorbell_id, void *data)
+{
+	struct mshv_partition *partition = (struct mshv_partition *)data;
+	struct mshv_ioeventfd *p;
+
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(p, &partition->ioeventfds_list, iovntfd_hnode)
+		if (p->iovntfd_doorbell_id == doorbell_id) {
+			eventfd_signal(p->iovntfd_eventfd);
+			break;
+		}
+
+	rcu_read_unlock();
+}
+
+static bool ioeventfd_check_collision(struct mshv_partition *pt,
+				      struct mshv_ioeventfd *p)
+	__must_hold(&pt->mutex)
+{
+	struct mshv_ioeventfd *_p;
+
+	hlist_for_each_entry(_p, &pt->ioeventfds_list, iovntfd_hnode)
+		if (_p->iovntfd_addr == p->iovntfd_addr &&
+		    _p->iovntfd_length == p->iovntfd_length &&
+		    (_p->iovntfd_wildcard || p->iovntfd_wildcard ||
+		     _p->iovntfd_datamatch == p->iovntfd_datamatch))
+			return true;
+
+	return false;
+}
+
+static int mshv_assign_ioeventfd(struct mshv_partition *pt,
+				 struct mshv_user_ioeventfd *args)
+	__must_hold(&pt->mutex)
+{
+	struct mshv_ioeventfd *p;
+	struct eventfd_ctx *eventfd;
+	u64 doorbell_flags = 0;
+	int ret;
+
+	/* This mutex is currently protecting ioeventfd.items list */
+	WARN_ON_ONCE(!mutex_is_locked(&pt->pt_mutex));
+
+	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_PIO))
+		return -EOPNOTSUPP;
+
+	/* must be natural-word sized */
+	switch (args->len) {
+	case 0:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY;
+		break;
+	case 1:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE;
+		break;
+	case 2:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD;
+		break;
+	case 4:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD;
+		break;
+	case 8:
+		doorbell_flags = HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return -EINVAL;
+
+	/* check for extra flags that we don't understand */
+	if (args->flags & ~MSHV_IOEVENTFD_FLAGS_MASK)
+		return -EINVAL;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	p = kzalloc(sizeof(*p), GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	p->iovntfd_addr = args->addr;
+	p->iovntfd_length  = args->len;
+	p->iovntfd_eventfd = eventfd;
+
+	/* The datamatch feature is optional, otherwise this is a wildcard */
+	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_DATAMATCH)) {
+		p->iovntfd_datamatch = args->datamatch;
+	} else {
+		p->iovntfd_wildcard = true;
+		doorbell_flags |= HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE;
+	}
+
+	if (ioeventfd_check_collision(pt, p)) {
+		ret = -EEXIST;
+		goto unlock_fail;
+	}
+
+	ret = mshv_register_doorbell(pt->pt_id, ioeventfd_mmio_write,
+				     (void *)pt, p->iovntfd_addr,
+				     p->iovntfd_datamatch, doorbell_flags);
+	if (ret < 0)
+		goto unlock_fail;
+
+	p->iovntfd_doorbell_id = ret;
+
+	hlist_add_head_rcu(&p->iovntfd_hnode, &pt->ioeventfds_list);
+
+	return 0;
+
+unlock_fail:
+	kfree(p);
+
+fail:
+	eventfd_ctx_put(eventfd);
+
+	return ret;
+}
+
+static int mshv_deassign_ioeventfd(struct mshv_partition *pt,
+				   struct mshv_user_ioeventfd *args)
+	__must_hold(&pt->mutex)
+{
+	struct mshv_ioeventfd *p;
+	struct eventfd_ctx *eventfd;
+	struct hlist_node *n;
+	int ret = -ENOENT;
+
+	/* This mutex is currently protecting ioeventfd.items list */
+	WARN_ON_ONCE(!mutex_is_locked(&pt->pt_mutex));
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	hlist_for_each_entry_safe(p, n, &pt->ioeventfds_list, iovntfd_hnode) {
+		bool wildcard = !(args->flags & BIT(MSHV_IOEVENTFD_BIT_DATAMATCH));
+
+		if (p->iovntfd_eventfd != eventfd  ||
+		    p->iovntfd_addr != args->addr  ||
+		    p->iovntfd_length != args->len ||
+		    p->iovntfd_wildcard != wildcard)
+			continue;
+
+		if (!p->iovntfd_wildcard &&
+		    p->iovntfd_datamatch != args->datamatch)
+			continue;
+
+		hlist_del_rcu(&p->iovntfd_hnode);
+		synchronize_rcu();
+		ioeventfd_release(p, pt->pt_id);
+		ret = 0;
+		break;
+	}
+
+	eventfd_ctx_put(eventfd);
+
+	return ret;
+}
+
+int mshv_set_unset_ioeventfd(struct mshv_partition *pt,
+			     struct mshv_user_ioeventfd *args)
+	__must_hold(&pt->mutex)
+{
+	if ((args->flags & ~MSHV_IOEVENTFD_FLAGS_MASK) ||
+	    mshv_field_nonzero(*args, rsvd))
+		return -EINVAL;
+
+	/* PIO not yet implemented */
+	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_PIO))
+		return -EOPNOTSUPP;
+
+	if (args->flags & BIT(MSHV_IOEVENTFD_BIT_DEASSIGN))
+		return mshv_deassign_ioeventfd(pt, args);
+
+	return mshv_assign_ioeventfd(pt, args);
+}
+
+void mshv_eventfd_init(struct mshv_partition *pt)
+{
+	spin_lock_init(&pt->pt_irqfds_lock);
+	INIT_HLIST_HEAD(&pt->pt_irqfds_list);
+
+	INIT_HLIST_HEAD(&pt->irqfds_resampler_list);
+	mutex_init(&pt->irqfds_resampler_lock);
+
+	INIT_HLIST_HEAD(&pt->ioeventfds_list);
+}
+
+void mshv_eventfd_release(struct mshv_partition *pt)
+{
+	struct hlist_head items;
+	struct hlist_node *n;
+	struct mshv_ioeventfd *p;
+
+	hlist_move_list(&pt->ioeventfds_list, &items);
+	synchronize_rcu();
+
+	hlist_for_each_entry_safe(p, n, &items, iovntfd_hnode) {
+		hlist_del(&p->iovntfd_hnode);
+		ioeventfd_release(p, pt->pt_id);
+	}
+
+	mshv_irqfd_release(pt);
+}
diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
new file mode 100644
index 000000000000..332e7670a344
--- /dev/null
+++ b/drivers/hv/mshv_eventfd.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * irqfd: Allows an fd to be used to inject an interrupt to the guest.
+ * ioeventfd: Allow an fd to be used to receive a signal from the guest.
+ * All credit goes to kvm developers.
+ */
+
+#ifndef __LINUX_MSHV_EVENTFD_H
+#define __LINUX_MSHV_EVENTFD_H
+
+#include <linux/poll.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+/* struct to contain list of irqfds sharing an irq. Updates are protected by
+ * partition.irqfds.resampler_lock
+ */
+struct mshv_irqfd_resampler {
+	struct mshv_partition	    *rsmplr_partn;
+	struct hlist_head	     rsmplr_irqfd_list;
+	struct mshv_irq_ack_notifier rsmplr_notifier;
+	struct hlist_node	     rsmplr_hnode;
+};
+
+struct mshv_irqfd {
+	struct mshv_partition		    *irqfd_partn;
+	struct eventfd_ctx		    *irqfd_eventfd_ctx;
+	struct mshv_guest_irq_ent	     irqfd_girq_ent;
+	seqcount_spinlock_t		     irqfd_irqe_sc;
+	u32				     irqfd_irqnum;
+	struct mshv_lapic_irq		     irqfd_lapic_irq;
+	struct hlist_node		     irqfd_hnode;
+	poll_table			     irqfd_polltbl;
+	wait_queue_head_t		    *irqfd_wqh;
+	wait_queue_entry_t		     irqfd_wait;
+	struct work_struct		     irqfd_shutdown;
+	struct mshv_irqfd_resampler	    *irqfd_resampler;
+	struct eventfd_ctx		    *irqfd_resamplefd;
+	struct hlist_node		     irqfd_resampler_hnode;
+};
+
+void mshv_eventfd_init(struct mshv_partition *partition);
+void mshv_eventfd_release(struct mshv_partition *partition);
+
+void mshv_register_irq_ack_notifier(struct mshv_partition *partition,
+				    struct mshv_irq_ack_notifier *mian);
+void mshv_unregister_irq_ack_notifier(struct mshv_partition *partition,
+				      struct mshv_irq_ack_notifier *mian);
+bool mshv_notify_acked_gsi(struct mshv_partition *partition, int gsi);
+
+int mshv_set_unset_irqfd(struct mshv_partition *partition,
+			 struct mshv_user_irqfd *args);
+
+int mshv_irqfd_wq_init(void);
+void mshv_irqfd_wq_cleanup(void);
+
+struct mshv_ioeventfd {
+	struct hlist_node    iovntfd_hnode;
+	u64		     iovntfd_addr;
+	int		     iovntfd_length;
+	struct eventfd_ctx  *iovntfd_eventfd;
+	u64		     iovntfd_datamatch;
+	int		     iovntfd_doorbell_id;
+	bool		     iovntfd_wildcard;
+};
+
+int mshv_set_unset_ioeventfd(struct mshv_partition *pt,
+			     struct mshv_user_ioeventfd *args);
+
+#endif /* __LINUX_MSHV_EVENTFD_H */
diff --git a/drivers/hv/mshv_irq.c b/drivers/hv/mshv_irq.c
new file mode 100644
index 000000000000..d0fb9ef734f4
--- /dev/null
+++ b/drivers/hv/mshv_irq.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+#include "mshv_root.h"
+
+/* called from the ioctl code, user wants to update the guest irq table */
+int mshv_update_routing_table(struct mshv_partition *partition,
+			      const struct mshv_user_irq_entry *ue,
+			      unsigned int numents)
+{
+	struct mshv_girq_routing_table *new = NULL, *old;
+	u32 i, nr_rt_entries = 0;
+	int r = 0;
+
+	if (numents == 0)
+		goto swap_routes;
+
+	for (i = 0; i < numents; i++) {
+		if (ue[i].gsi >= MSHV_MAX_GUEST_IRQS)
+			return -EINVAL;
+
+		if (ue[i].address_hi)
+			return -EINVAL;
+
+		nr_rt_entries = max(nr_rt_entries, ue[i].gsi);
+	}
+	nr_rt_entries += 1;
+
+	new = kzalloc(struct_size(new, mshv_girq_info_tbl, nr_rt_entries),
+		      GFP_KERNEL_ACCOUNT);
+	if (!new)
+		return -ENOMEM;
+
+	new->num_rt_entries = nr_rt_entries;
+	for (i = 0; i < numents; i++) {
+		struct mshv_guest_irq_ent *girq;
+
+		girq = &new->mshv_girq_info_tbl[ue[i].gsi];
+
+		/*
+		 * Allow only one to one mapping between GSI and MSI routing.
+		 */
+		if (girq->guest_irq_num != 0) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		girq->guest_irq_num = ue[i].gsi;
+		girq->girq_addr_lo = ue[i].address_lo;
+		girq->girq_addr_hi = ue[i].address_hi;
+		girq->girq_irq_data = ue[i].data;
+		girq->girq_entry_valid = true;
+	}
+
+swap_routes:
+	mutex_lock(&partition->pt_irq_lock);
+	old = rcu_dereference_protected(partition->pt_girq_tbl, 1);
+	rcu_assign_pointer(partition->pt_girq_tbl, new);
+	mshv_irqfd_routing_update(partition);
+	mutex_unlock(&partition->pt_irq_lock);
+
+	synchronize_srcu_expedited(&partition->pt_irq_srcu);
+	new = old;
+
+out:
+	kfree(new);
+
+	return r;
+}
+
+/* vm is going away, kfree the irq routing table */
+void mshv_free_routing_table(struct mshv_partition *partition)
+{
+	struct mshv_girq_routing_table *rt =
+				   rcu_access_pointer(partition->pt_girq_tbl);
+
+	kfree(rt);
+}
+
+struct mshv_guest_irq_ent
+mshv_ret_girq_entry(struct mshv_partition *partition, u32 irqnum)
+{
+	struct mshv_guest_irq_ent entry = { 0 };
+	struct mshv_girq_routing_table *girq_tbl;
+
+	girq_tbl = srcu_dereference_check(partition->pt_girq_tbl,
+					  &partition->pt_irq_srcu,
+					  lockdep_is_held(&partition->pt_irq_lock));
+	if (!girq_tbl || irqnum >= girq_tbl->num_rt_entries) {
+		/*
+		 * Premature register_irqfd, setting valid_entry = 0
+		 * would ignore this entry anyway
+		 */
+		entry.guest_irq_num = irqnum;
+		return entry;
+	}
+
+	return girq_tbl->mshv_girq_info_tbl[irqnum];
+}
+
+void mshv_copy_girq_info(struct mshv_guest_irq_ent *ent,
+			 struct mshv_lapic_irq *lirq)
+{
+	memset(lirq, 0, sizeof(*lirq));
+	if (!ent || !ent->girq_entry_valid)
+		return;
+
+	lirq->lapic_vector = ent->girq_irq_data & 0xFF;
+	lirq->lapic_apic_id = (ent->girq_addr_lo >> 12) & 0xFF;
+	lirq->lapic_control.interrupt_type = (ent->girq_irq_data & 0x700) >> 8;
+	lirq->lapic_control.level_triggered = (ent->girq_irq_data >> 15) & 0x1;
+	lirq->lapic_control.logical_dest_mode = (ent->girq_addr_lo >> 2) & 0x1;
+}
diff --git a/drivers/hv/mshv_portid_table.c b/drivers/hv/mshv_portid_table.c
new file mode 100644
index 000000000000..a40abde6fd15
--- /dev/null
+++ b/drivers/hv/mshv_portid_table.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <asm/mshyperv.h>
+
+#include "mshv.h"
+#include "mshv_root.h"
+
+/*
+ * Ports and connections are hypervisor struct used for inter-partition
+ * communication. Port represents the source and connection represents
+ * the destination. Partitions are responsible for managing the port and
+ * connection ids.
+ *
+ */
+
+#define PORTID_MIN	1
+#define PORTID_MAX	INT_MAX
+
+static DEFINE_IDR(port_table_idr);
+
+void
+mshv_port_table_fini(void)
+{
+	struct port_table_info *port_info;
+	unsigned long i, tmp;
+
+	idr_lock(&port_table_idr);
+	if (!idr_is_empty(&port_table_idr)) {
+		idr_for_each_entry_ul(&port_table_idr, port_info, tmp, i) {
+			port_info = idr_remove(&port_table_idr, i);
+			kfree_rcu(port_info, portbl_rcu);
+		}
+	}
+	idr_unlock(&port_table_idr);
+}
+
+int
+mshv_portid_alloc(struct port_table_info *info)
+{
+	int ret = 0;
+
+	idr_lock(&port_table_idr);
+	ret = idr_alloc(&port_table_idr, info, PORTID_MIN,
+			PORTID_MAX, GFP_KERNEL);
+	idr_unlock(&port_table_idr);
+
+	return ret;
+}
+
+void
+mshv_portid_free(int port_id)
+{
+	struct port_table_info *info;
+
+	idr_lock(&port_table_idr);
+	info = idr_remove(&port_table_idr, port_id);
+	WARN_ON(!info);
+	idr_unlock(&port_table_idr);
+
+	synchronize_rcu();
+	kfree(info);
+}
+
+int
+mshv_portid_lookup(int port_id, struct port_table_info *info)
+{
+	struct port_table_info *_info;
+	int ret = -ENOENT;
+
+	rcu_read_lock();
+	_info = idr_find(&port_table_idr, port_id);
+	rcu_read_unlock();
+
+	if (_info) {
+		*info = *_info;
+		ret = 0;
+	}
+
+	return ret;
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
new file mode 100644
index 000000000000..e83b484b8ed8
--- /dev/null
+++ b/drivers/hv/mshv_root.h
@@ -0,0 +1,308 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ */
+
+#ifndef _MSHV_ROOT_H_
+#define _MSHV_ROOT_H_
+
+#include <linux/spinlock.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/sched.h>
+#include <linux/srcu.h>
+#include <linux/wait.h>
+#include <linux/hashtable.h>
+#include <linux/dev_printk.h>
+#include <uapi/linux/mshv.h>
+
+/*
+ * Hypervisor must be between these version numbers (inclusive)
+ * to guarantee compatibility
+ */
+#define MSHV_HV_MIN_VERSION		(27744)
+#define MSHV_HV_MAX_VERSION		(27751)
+
+#define MSHV_MAX_VPS			256
+
+#define MSHV_PARTITIONS_HASH_BITS	9
+
+#define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
+
+struct mshv_vp {
+	u32 vp_index;
+	struct mshv_partition *vp_partition;
+	struct mutex vp_mutex;
+	struct hv_vp_register_page *vp_register_page;
+	struct hv_message *vp_intercept_msg_page;
+	void *vp_ghcb_page;
+	struct hv_stats_page *vp_stats_pages[2];
+	struct {
+		atomic64_t vp_signaled_count;
+		struct {
+			u64 intercept_suspend: 1;
+			u64 root_sched_blocked: 1; /* root scheduler only */
+			u64 root_sched_dispatched: 1; /* root scheduler only */
+			u64 reserved: 61;
+		} flags;
+		unsigned int kicked_by_hv;
+		wait_queue_head_t vp_suspend_queue;
+	} run;
+};
+
+#define vp_fmt(fmt) "p%lluvp%u: " fmt
+#define vp_devprintk(level, v, fmt, ...) \
+do { \
+	const struct mshv_vp *__vp = (v); \
+	const struct mshv_partition *__pt = __vp->vp_partition; \
+	dev_##level(__pt->pt_module_dev, vp_fmt(fmt), __pt->pt_id, \
+		    __vp->vp_index, ##__VA_ARGS__); \
+} while (0)
+#define vp_emerg(v, fmt, ...)	vp_devprintk(emerg, v, fmt, ##__VA_ARGS__)
+#define vp_crit(v, fmt, ...)	vp_devprintk(crit, v, fmt, ##__VA_ARGS__)
+#define vp_alert(v, fmt, ...)	vp_devprintk(alert, v, fmt, ##__VA_ARGS__)
+#define vp_err(v, fmt, ...)	vp_devprintk(err, v, fmt, ##__VA_ARGS__)
+#define vp_warn(v, fmt, ...)	vp_devprintk(warn, v, fmt, ##__VA_ARGS__)
+#define vp_notice(v, fmt, ...)	vp_devprintk(notice, v, fmt, ##__VA_ARGS__)
+#define vp_info(v, fmt, ...)	vp_devprintk(info, v, fmt, ##__VA_ARGS__)
+#define vp_dbg(v, fmt, ...)	vp_devprintk(dbg, v, fmt, ##__VA_ARGS__)
+
+struct mshv_mem_region {
+	struct hlist_node hnode;
+	u64 nr_pages;
+	u64 start_gfn;
+	u64 start_uaddr;
+	u32 hv_map_flags;
+	struct {
+		u64 large_pages:  1; /* 2MiB */
+		u64 range_pinned: 1;
+		u64 reserved:	 62;
+	} flags;
+	struct mshv_partition *partition;
+	struct page *pages[];
+};
+
+struct mshv_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned int irq_ack_gsi;
+	void (*irq_acked)(struct mshv_irq_ack_notifier *mian);
+};
+
+struct mshv_partition {
+	struct device *pt_module_dev;
+
+	struct hlist_node pt_hnode;
+	u64 pt_id;
+	refcount_t pt_ref_count;
+	struct mutex pt_mutex;
+	struct hlist_head pt_mem_regions; // not ordered
+
+	u32 pt_vp_count;
+	struct mshv_vp *pt_vp_array[MSHV_MAX_VPS];
+
+	struct mutex pt_irq_lock;
+	struct srcu_struct pt_irq_srcu;
+	struct hlist_head irq_ack_notifier_list;
+
+	struct hlist_head pt_devices;
+
+	/*
+	 * MSHV does not support more than one async hypercall in flight
+	 * for a single partition. Thus, it is okay to define per partition
+	 * async hypercall status.
+	 */
+	struct completion async_hypercall;
+	u64 async_hypercall_status;
+
+	spinlock_t	  pt_irqfds_lock;
+	struct hlist_head pt_irqfds_list;
+	struct mutex	  irqfds_resampler_lock;
+	struct hlist_head irqfds_resampler_list;
+
+	struct hlist_head ioeventfds_list;
+
+	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
+	u64 isolation_type;
+	bool import_completed;
+	bool pt_initialized;
+};
+
+#define pt_fmt(fmt) "p%llu: " fmt
+#define pt_devprintk(level, p, fmt, ...) \
+do { \
+	const struct mshv_partition *__pt = (p); \
+	dev_##level(__pt->pt_module_dev, pt_fmt(fmt), __pt->pt_id, \
+		    ##__VA_ARGS__); \
+} while (0)
+#define pt_emerg(p, fmt, ...)	pt_devprintk(emerg, p, fmt, ##__VA_ARGS__)
+#define pt_crit(p, fmt, ...)	pt_devprintk(crit, p, fmt, ##__VA_ARGS__)
+#define pt_alert(p, fmt, ...)	pt_devprintk(alert, p, fmt, ##__VA_ARGS__)
+#define pt_err(p, fmt, ...)	pt_devprintk(err, p, fmt, ##__VA_ARGS__)
+#define pt_warn(p, fmt, ...)	pt_devprintk(warn, p, fmt, ##__VA_ARGS__)
+#define pt_notice(p, fmt, ...)	pt_devprintk(notice, p, fmt, ##__VA_ARGS__)
+#define pt_info(p, fmt, ...)	pt_devprintk(info, p, fmt, ##__VA_ARGS__)
+#define pt_dbg(p, fmt, ...)	pt_devprintk(dbg, p, fmt, ##__VA_ARGS__)
+
+struct mshv_lapic_irq {
+	u32 lapic_vector;
+	u64 lapic_apic_id;
+	union hv_interrupt_control lapic_control;
+};
+
+#define MSHV_MAX_GUEST_IRQS		4096
+
+/* representation of one guest irq entry, either msi or legacy */
+struct mshv_guest_irq_ent {
+	u32 girq_entry_valid;	/* vfio looks at this */
+	u32 guest_irq_num;	/* a unique number for each irq */
+	u32 girq_addr_lo;	/* guest irq msi address info */
+	u32 girq_addr_hi;
+	u32 girq_irq_data;	/* idt vector in some cases */
+};
+
+struct mshv_girq_routing_table {
+	u32 num_rt_entries;
+	struct mshv_guest_irq_ent mshv_girq_info_tbl[];
+};
+
+struct hv_synic_pages {
+	struct hv_message_page *synic_message_page;
+	struct hv_synic_event_flags_page *synic_event_flags_page;
+	struct hv_synic_event_ring_page *synic_event_ring_page;
+};
+
+struct mshv_root {
+	struct hv_synic_pages __percpu *synic_pages;
+	spinlock_t pt_ht_lock;
+	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
+};
+
+/*
+ * Callback for doorbell events.
+ * NOTE: This is called in interrupt context. Callback
+ * should defer slow and sleeping logic to later.
+ */
+typedef void (*doorbell_cb_t) (int doorbell_id, void *);
+
+/*
+ * port table information
+ */
+struct port_table_info {
+	struct rcu_head portbl_rcu;
+	enum hv_port_type hv_port_type;
+	union {
+		struct {
+			u64 reserved[2];
+		} hv_port_message;
+		struct {
+			u64 reserved[2];
+		} hv_port_event;
+		struct {
+			u64 reserved[2];
+		} hv_port_monitor;
+		struct {
+			doorbell_cb_t doorbell_cb;
+			void *data;
+		} hv_port_doorbell;
+	};
+};
+
+int mshv_update_routing_table(struct mshv_partition *partition,
+			      const struct mshv_user_irq_entry *entries,
+			      unsigned int numents);
+void mshv_free_routing_table(struct mshv_partition *partition);
+
+struct mshv_guest_irq_ent mshv_ret_girq_entry(struct mshv_partition *partition,
+					      u32 irq_num);
+
+void mshv_copy_girq_info(struct mshv_guest_irq_ent *src_irq,
+			 struct mshv_lapic_irq *dest_irq);
+
+void mshv_irqfd_routing_update(struct mshv_partition *partition);
+
+void mshv_port_table_fini(void);
+int mshv_portid_alloc(struct port_table_info *info);
+int mshv_portid_lookup(int port_id, struct port_table_info *info);
+void mshv_portid_free(int port_id);
+
+int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
+			   void *data, u64 gpa, u64 val, u64 flags);
+void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
+
+void mshv_isr(void);
+int mshv_synic_init(unsigned int cpu);
+int mshv_synic_cleanup(unsigned int cpu);
+
+static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
+{
+	return partition->isolation_type == HV_PARTITION_ISOLATION_TYPE_SNP;
+}
+
+struct mshv_partition *mshv_partition_get(struct mshv_partition *partition);
+void mshv_partition_put(struct mshv_partition *partition);
+struct mshv_partition *mshv_partition_find(u64 partition_id) __must_hold(RCU);
+
+/* hypercalls */
+
+int hv_call_withdraw_memory(u64 count, int node, u64 partition_id);
+int hv_call_create_partition(u64 flags,
+			     struct hv_partition_creation_properties creation_properties,
+			     union hv_partition_isolation_properties isolation_properties,
+			     u64 *partition_id);
+int hv_call_initialize_partition(u64 partition_id);
+int hv_call_finalize_partition(u64 partition_id);
+int hv_call_delete_partition(u64 partition_id);
+int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs);
+int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			  u32 flags, struct page **pages);
+int hv_call_unmap_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			    u32 flags);
+int hv_call_delete_vp(u64 partition_id, u32 vp_index);
+int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
+				     u64 dest_addr,
+				     union hv_interrupt_control control);
+int hv_call_clear_virtual_interrupt(u64 partition_id);
+int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
+				  union hv_gpa_page_access_state_flags state_flags,
+				  int *written_total,
+				  union hv_gpa_page_access_state *states);
+int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
+			 struct hv_vp_state_data state_data,
+			 /* Choose between pages and ret_output */
+			 u64 page_count, struct page **pages,
+			 union hv_output_get_vp_state *ret_output);
+int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
+			 /* Choose between pages and bytes */
+			 struct hv_vp_state_data state_data, u64 page_count,
+			 struct page **pages, u32 num_bytes, u8 *bytes);
+int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			      union hv_input_vtl input_vtl,
+			      struct page **state_page);
+int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+				union hv_input_vtl input_vtl);
+int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
+			u64 connection_partition_id, struct hv_port_info *port_info,
+			u8 port_vtl, u8 min_connection_vtl, int node);
+int hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id);
+int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
+			 u64 connection_partition_id,
+			 union hv_connection_id connection_id,
+			 struct hv_connection_info *connection_info,
+			 u8 connection_vtl, int node);
+int hv_call_disconnect_port(u64 connection_partition_id,
+			    union hv_connection_id connection_id);
+int hv_call_notify_port_ring_empty(u32 sint_index);
+int hv_call_map_stat_page(enum hv_stats_object_type type,
+			  const union hv_stats_object_identity *identity,
+			  void **addr);
+int hv_call_unmap_stat_page(enum hv_stats_object_type type,
+			    const union hv_stats_object_identity *identity);
+int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
+				   u64 page_struct_count, u32 host_access,
+				   u32 flags, u8 acquire);
+
+extern struct mshv_root mshv_root;
+extern enum hv_scheduler_type hv_scheduler_type;
+extern u8 * __percpu *hv_synic_eventring_tail;
+
+#endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
new file mode 100644
index 000000000000..09a0c3076d59
--- /dev/null
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -0,0 +1,852 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * Hypercall helper functions used by the mshv_root module.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_root.h"
+
+/* Determined empirically */
+#define HV_INIT_PARTITION_DEPOSIT_PAGES 208
+#define HV_MAP_GPA_DEPOSIT_PAGES	256
+#define HV_UMAP_GPA_PAGES		512
+
+#define HV_PAGE_COUNT_2M_ALIGNED(pg_count) (!((pg_count) & (0x200 - 1)))
+
+#define HV_WITHDRAW_BATCH_SIZE	(HV_HYP_PAGE_SIZE / sizeof(u64))
+#define HV_MAP_GPA_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_map_gpa_pages)) \
+		/ sizeof(u64))
+#define HV_GET_VP_STATE_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_vp_state)) \
+		/ sizeof(u64))
+#define HV_SET_VP_STATE_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_set_vp_state)) \
+		/ sizeof(u64))
+#define HV_GET_GPA_ACCESS_STATES_BATCH_SIZE	\
+	((HV_HYP_PAGE_SIZE - sizeof(union hv_gpa_page_access_state)) \
+		/ sizeof(union hv_gpa_page_access_state))
+#define HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT		       \
+	((HV_HYP_PAGE_SIZE -						       \
+	  sizeof(struct hv_input_modify_sparse_spa_page_host_access)) /        \
+	 sizeof(u64))
+
+int hv_call_withdraw_memory(u64 count, int node, u64 partition_id)
+{
+	struct hv_input_withdraw_memory *input_page;
+	struct hv_output_withdraw_memory *output_page;
+	struct page *page;
+	u16 completed;
+	unsigned long remaining = count;
+	u64 status;
+	int i;
+	unsigned long flags;
+
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	output_page = page_address(page);
+
+	while (remaining) {
+		local_irq_save(flags);
+
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		memset(input_page, 0, sizeof(*input_page));
+		input_page->partition_id = partition_id;
+		status = hv_do_rep_hypercall(HVCALL_WITHDRAW_MEMORY,
+					     min(remaining, HV_WITHDRAW_BATCH_SIZE),
+					     0, input_page, output_page);
+
+		local_irq_restore(flags);
+
+		completed = hv_repcomp(status);
+
+		for (i = 0; i < completed; i++)
+			__free_page(pfn_to_page(output_page->gpa_page_list[i]));
+
+		if (!hv_result_success(status)) {
+			if (hv_result(status) == HV_STATUS_NO_RESOURCES)
+				status = HV_STATUS_SUCCESS;
+			break;
+		}
+
+		remaining -= completed;
+	}
+	free_page((unsigned long)output_page);
+
+	return hv_result_to_errno(status);
+}
+
+int hv_call_create_partition(u64 flags,
+			     struct hv_partition_creation_properties creation_properties,
+			     union hv_partition_isolation_properties isolation_properties,
+			     u64 *partition_id)
+{
+	struct hv_input_create_partition *input;
+	struct hv_output_create_partition *output;
+	u64 status;
+	int ret;
+	unsigned long irq_flags;
+
+	do {
+		local_irq_save(irq_flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		memset(input, 0, sizeof(*input));
+		input->flags = flags;
+		input->compatibility_version = HV_COMPATIBILITY_21_H2;
+
+		memcpy(&input->partition_creation_properties, &creation_properties,
+		       sizeof(creation_properties));
+
+		memcpy(&input->isolation_properties, &isolation_properties,
+		       sizeof(isolation_properties));
+
+		status = hv_do_hypercall(HVCALL_CREATE_PARTITION,
+					 input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				*partition_id = output->partition_id;
+			local_irq_restore(irq_flags);
+			ret = hv_result_to_errno(status);
+			break;
+		}
+		local_irq_restore(irq_flags);
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    hv_current_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_initialize_partition(u64 partition_id)
+{
+	struct hv_input_initialize_partition input;
+	u64 status;
+	int ret;
+
+	input.partition_id = partition_id;
+
+	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
+				    HV_INIT_PARTITION_DEPOSIT_PAGES);
+	if (ret)
+		return ret;
+
+	do {
+		status = hv_do_fast_hypercall8(HVCALL_INITIALIZE_PARTITION,
+					       *(u64 *)&input);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_result_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_finalize_partition(u64 partition_id)
+{
+	struct hv_input_finalize_partition input;
+	u64 status;
+
+	input.partition_id = partition_id;
+	status = hv_do_fast_hypercall8(HVCALL_FINALIZE_PARTITION,
+				       *(u64 *)&input);
+
+	return hv_result_to_errno(status);
+}
+
+int hv_call_delete_partition(u64 partition_id)
+{
+	struct hv_input_delete_partition input;
+	u64 status;
+
+	input.partition_id = partition_id;
+	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64 *)&input);
+
+	return hv_result_to_errno(status);
+}
+
+/* Ask the hypervisor to map guest ram pages or the guest mmio space */
+static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
+			       u32 flags, struct page **pages, u64 mmio_spa)
+{
+	struct hv_input_map_gpa_pages *input_page;
+	u64 status, *pfnlist;
+	unsigned long irq_flags, large_shift = 0;
+	int ret = 0, done = 0;
+	u64 page_count = page_struct_count;
+
+	if (page_count == 0 || (pages && mmio_spa))
+		return -EINVAL;
+
+	if (flags & HV_MAP_GPA_LARGE_PAGE) {
+		if (mmio_spa)
+			return -EINVAL;
+
+		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
+			return -EINVAL;
+
+		large_shift = HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
+		page_count >>= large_shift;
+	}
+
+	while (done < page_count) {
+		ulong i, completed, remain = page_count - done;
+		int rep_count = min(remain, HV_MAP_GPA_BATCH_SIZE);
+
+		local_irq_save(irq_flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		input_page->target_partition_id = partition_id;
+		input_page->target_gpa_base = gfn + (done << large_shift);
+		input_page->map_flags = flags;
+		pfnlist = input_page->source_gpa_page_list;
+
+		for (i = 0; i < rep_count; i++)
+			if (flags & HV_MAP_GPA_NO_ACCESS) {
+				pfnlist[i] = 0;
+			} else if (pages) {
+				u64 index = (done + i) << large_shift;
+
+				if (index >= page_struct_count) {
+					ret = -EINVAL;
+					break;
+				}
+				pfnlist[i] = page_to_pfn(pages[index]);
+			} else {
+				pfnlist[i] = mmio_spa + done + i;
+			}
+		if (ret)
+			break;
+
+		status = hv_do_rep_hypercall(HVCALL_MAP_GPA_PAGES, rep_count, 0,
+					     input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+
+		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id,
+						    HV_MAP_GPA_DEPOSIT_PAGES);
+			if (ret)
+				break;
+
+		} else if (!hv_result_success(status)) {
+			ret = hv_result_to_errno(status);
+			break;
+		}
+
+		done += completed;
+	}
+
+	if (ret && done) {
+		u32 unmap_flags = 0;
+
+		if (flags & HV_MAP_GPA_LARGE_PAGE)
+			unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+		hv_call_unmap_gpa_pages(partition_id, gfn, done, unmap_flags);
+	}
+
+	return ret;
+}
+
+/* Ask the hypervisor to map guest ram pages */
+int hv_call_map_gpa_pages(u64 partition_id, u64 gpa_target, u64 page_count,
+			  u32 flags, struct page **pages)
+{
+	return hv_do_map_gpa_hcall(partition_id, gpa_target, page_count,
+				   flags, pages, 0);
+}
+
+/* Ask the hypervisor to map guest mmio space */
+int hv_call_map_mmio_pages(u64 partition_id, u64 gfn, u64 mmio_spa, u64 numpgs)
+{
+	int i;
+	u32 flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE |
+		    HV_MAP_GPA_NOT_CACHED;
+
+	for (i = 0; i < numpgs; i++)
+		if (page_is_ram(mmio_spa + i))
+			return -EINVAL;
+
+	return hv_do_map_gpa_hcall(partition_id, gfn, numpgs, flags, NULL,
+				   mmio_spa);
+}
+
+int hv_call_unmap_gpa_pages(u64 partition_id, u64 gfn, u64 page_count_4k,
+			    u32 flags)
+{
+	struct hv_input_unmap_gpa_pages *input_page;
+	u64 status, page_count = page_count_4k;
+	unsigned long irq_flags, large_shift = 0;
+	int ret = 0, done = 0;
+
+	if (page_count == 0)
+		return -EINVAL;
+
+	if (flags & HV_UNMAP_GPA_LARGE_PAGE) {
+		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
+			return -EINVAL;
+
+		large_shift = HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
+		page_count >>= large_shift;
+	}
+
+	while (done < page_count) {
+		ulong completed, remain = page_count - done;
+		int rep_count = min(remain, HV_UMAP_GPA_PAGES);
+
+		local_irq_save(irq_flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		input_page->target_partition_id = partition_id;
+		input_page->target_gpa_base = gfn + (done << large_shift);
+		input_page->unmap_flags = flags;
+		status = hv_do_rep_hypercall(HVCALL_UNMAP_GPA_PAGES, rep_count,
+					     0, input_page, NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+		if (!hv_result_success(status)) {
+			ret = hv_result_to_errno(status);
+			break;
+		}
+
+		done += completed;
+	}
+
+	return ret;
+}
+
+int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
+				  union hv_gpa_page_access_state_flags state_flags,
+				  int *written_total,
+				  union hv_gpa_page_access_state *states)
+{
+	struct hv_input_get_gpa_pages_access_state *input_page;
+	union hv_gpa_page_access_state *output_page;
+	int completed = 0;
+	unsigned long remaining = count;
+	int rep_count, i;
+	u64 status;
+	unsigned long flags;
+
+	*written_total = 0;
+	while (remaining) {
+		local_irq_save(flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		input_page->partition_id = partition_id;
+		input_page->hv_gpa_page_number = gpa_base_pfn + *written_total;
+		input_page->flags = state_flags;
+		rep_count = min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
+
+		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
+					     0, input_page, output_page);
+		if (!hv_result_success(status)) {
+			local_irq_restore(flags);
+			break;
+		}
+		completed = hv_repcomp(status);
+		for (i = 0; i < completed; ++i)
+			states[i].as_uint8 = output_page[i].as_uint8;
+
+		local_irq_restore(flags);
+		states += completed;
+		*written_total += completed;
+		remaining -= completed;
+	}
+
+	return hv_result_to_errno(status);
+}
+
+int hv_call_assert_virtual_interrupt(u64 partition_id, u32 vector,
+				     u64 dest_addr,
+				     union hv_interrupt_control control)
+{
+	struct hv_input_assert_virtual_interrupt *input;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	memset(input, 0, sizeof(*input));
+	input->partition_id = partition_id;
+	input->vector = vector;
+	input->dest_addr = dest_addr;
+	input->control = control;
+	status = hv_do_hypercall(HVCALL_ASSERT_VIRTUAL_INTERRUPT, input, NULL);
+	local_irq_restore(flags);
+
+	return hv_result_to_errno(status);
+}
+
+int hv_call_delete_vp(u64 partition_id, u32 vp_index)
+{
+	union hv_input_delete_vp input = {};
+	u64 status;
+
+	input.partition_id = partition_id;
+	input.vp_index = vp_index;
+
+	status = hv_do_fast_hypercall16(HVCALL_DELETE_VP,
+					input.as_uint64[0], input.as_uint64[1]);
+
+	return hv_result_to_errno(status);
+}
+EXPORT_SYMBOL_GPL(hv_call_delete_vp);
+
+int hv_call_get_vp_state(u32 vp_index, u64 partition_id,
+			 struct hv_vp_state_data state_data,
+			 /* Choose between pages and ret_output */
+			 u64 page_count, struct page **pages,
+			 union hv_output_get_vp_state *ret_output)
+{
+	struct hv_input_get_vp_state *input;
+	union hv_output_get_vp_state *output;
+	u64 status;
+	int i;
+	u64 control;
+	unsigned long flags;
+	int ret = 0;
+
+	if (page_count > HV_GET_VP_STATE_BATCH_SIZE)
+		return -EINVAL;
+
+	if (!page_count && !ret_output)
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+		memset(input, 0, sizeof(*input));
+		memset(output, 0, sizeof(*output));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data = state_data;
+		for (i = 0; i < page_count; i++)
+			input->output_data_pfns[i] = page_to_pfn(pages[i]);
+
+		control = (HVCALL_GET_VP_STATE) |
+			  (page_count << HV_HYPERCALL_VARHEAD_OFFSET);
+
+		status = hv_do_hypercall(control, input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status) && ret_output)
+				memcpy(ret_output, output, sizeof(*output));
+
+			local_irq_restore(flags);
+			ret = hv_result_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_set_vp_state(u32 vp_index, u64 partition_id,
+			 /* Choose between pages and bytes */
+			 struct hv_vp_state_data state_data, u64 page_count,
+			 struct page **pages, u32 num_bytes, u8 *bytes)
+{
+	struct hv_input_set_vp_state *input;
+	u64 status;
+	int i;
+	u64 control;
+	unsigned long flags;
+	int ret = 0;
+	u16 varhead_sz;
+
+	if (page_count > HV_SET_VP_STATE_BATCH_SIZE)
+		return -EINVAL;
+	if (sizeof(*input) + num_bytes > HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+
+	if (num_bytes)
+		/* round up to 8 and divide by 8 */
+		varhead_sz = (num_bytes + 7) >> 3;
+	else if (page_count)
+		varhead_sz = page_count;
+	else
+		return -EINVAL;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->state_data = state_data;
+		if (num_bytes) {
+			memcpy((u8 *)input->data, bytes, num_bytes);
+		} else {
+			for (i = 0; i < page_count; i++)
+				input->data[i].pfns = page_to_pfn(pages[i]);
+		}
+
+		control = (HVCALL_SET_VP_STATE) |
+			  (varhead_sz << HV_HYPERCALL_VARHEAD_OFFSET);
+
+		status = hv_do_hypercall(control, input, NULL);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			local_irq_restore(flags);
+			ret = hv_result_to_errno(status);
+			break;
+		}
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_map_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+			      union hv_input_vtl input_vtl,
+			      struct page **state_page)
+{
+	struct hv_input_map_vp_state_page *input;
+	struct hv_output_map_vp_state_page *output;
+	u64 status;
+	int ret;
+	unsigned long flags;
+
+	do {
+		local_irq_save(flags);
+
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->type = type;
+		input->input_vtl = input_vtl;
+
+		status = hv_do_hypercall(HVCALL_MAP_VP_STATE_PAGE, input, output);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				*state_page = pfn_to_page(output->map_location);
+			local_irq_restore(flags);
+			ret = hv_result_to_errno(status);
+			break;
+		}
+
+		local_irq_restore(flags);
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
+				union hv_input_vtl input_vtl)
+{
+	unsigned long flags;
+	u64 status;
+	struct hv_input_unmap_vp_state_page *input;
+
+	local_irq_save(flags);
+
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	memset(input, 0, sizeof(*input));
+
+	input->partition_id = partition_id;
+	input->vp_index = vp_index;
+	input->type = type;
+	input->input_vtl = input_vtl;
+
+	status = hv_do_hypercall(HVCALL_UNMAP_VP_STATE_PAGE, input, NULL);
+
+	local_irq_restore(flags);
+
+	return hv_result_to_errno(status);
+}
+
+int
+hv_call_clear_virtual_interrupt(u64 partition_id)
+{
+	unsigned long flags;
+	int status;
+
+	status = hv_do_fast_hypercall8(HVCALL_CLEAR_VIRTUAL_INTERRUPT,
+				       partition_id);
+
+	return hv_result_to_errno(status);
+}
+
+int
+hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
+		    u64 connection_partition_id,
+		    struct hv_port_info *port_info,
+		    u8 port_vtl, u8 min_connection_vtl, int node)
+{
+	struct hv_input_create_port *input;
+	unsigned long flags;
+	int ret = 0;
+	int status;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+
+		input->port_partition_id = port_partition_id;
+		input->port_id = port_id;
+		input->connection_partition_id = connection_partition_id;
+		input->port_info = *port_info;
+		input->port_vtl = port_vtl;
+		input->min_connection_vtl = min_connection_vtl;
+		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
+		status = hv_do_hypercall(HVCALL_CREATE_PORT, input, NULL);
+		local_irq_restore(flags);
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_result_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, port_partition_id, 1);
+
+	} while (!ret);
+
+	return ret;
+}
+
+int
+hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
+{
+	union hv_input_delete_port input = { 0 };
+	unsigned long flags;
+	int status;
+
+	input.port_partition_id = port_partition_id;
+	input.port_id = port_id;
+	status = hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
+					input.as_uint64[0],
+					input.as_uint64[1]);
+
+	return hv_result_to_errno(status);
+}
+
+int
+hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
+		     u64 connection_partition_id,
+		     union hv_connection_id connection_id,
+		     struct hv_connection_info *connection_info,
+		     u8 connection_vtl, int node)
+{
+	struct hv_input_connect_port *input;
+	unsigned long flags;
+	int ret = 0, status;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		memset(input, 0, sizeof(*input));
+		input->port_partition_id = port_partition_id;
+		input->port_id = port_id;
+		input->connection_partition_id = connection_partition_id;
+		input->connection_id = connection_id;
+		input->connection_info = *connection_info;
+		input->connection_vtl = connection_vtl;
+		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
+		status = hv_do_hypercall(HVCALL_CONNECT_PORT, input, NULL);
+
+		local_irq_restore(flags);
+		if (hv_result_success(status))
+			break;
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			ret = hv_result_to_errno(status);
+			break;
+		}
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    connection_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int
+hv_call_disconnect_port(u64 connection_partition_id,
+			union hv_connection_id connection_id)
+{
+	union hv_input_disconnect_port input = { 0 };
+	unsigned long flags;
+	int status;
+
+	input.connection_partition_id = connection_partition_id;
+	input.connection_id = connection_id;
+	input.is_doorbell = 1;
+	status = hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
+					input.as_uint64[0],
+					input.as_uint64[1]);
+
+	return hv_result_to_errno(status);
+}
+
+int
+hv_call_notify_port_ring_empty(u32 sint_index)
+{
+	union hv_input_notify_port_ring_empty input = { 0 };
+	unsigned long flags;
+	int status;
+
+	input.sint_index = sint_index;
+	status = hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
+				       input.as_uint64);
+
+	return hv_result_to_errno(status);
+}
+
+int hv_call_map_stat_page(enum hv_stats_object_type type,
+			  const union hv_stats_object_identity *identity,
+			  void **addr)
+{
+	unsigned long flags;
+	struct hv_input_map_stats_page *input;
+	struct hv_output_map_stats_page *output;
+	u64 status, pfn;
+	int ret;
+
+	do {
+		local_irq_save(flags);
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		memset(input, 0, sizeof(*input));
+		input->type = type;
+		input->identity = *identity;
+
+		status = hv_do_hypercall(HVCALL_MAP_STATS_PAGE, input, output);
+		pfn = output->map_location;
+
+		local_irq_restore(flags);
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (hv_result_success(status))
+				break;
+			return hv_result_to_errno(status);
+		}
+
+		ret = hv_call_deposit_pages(NUMA_NO_NODE,
+					    hv_current_partition_id, 1);
+		if (ret)
+			return ret;
+	} while (!ret);
+
+	*addr = page_address(pfn_to_page(pfn));
+
+	return ret;
+}
+
+int hv_call_unmap_stat_page(enum hv_stats_object_type type,
+			    const union hv_stats_object_identity *identity)
+{
+	unsigned long flags;
+	struct hv_input_unmap_stats_page *input;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->type = type;
+	input->identity = *identity;
+
+	status = hv_do_hypercall(HVCALL_UNMAP_STATS_PAGE, input, NULL);
+	local_irq_restore(flags);
+
+	return hv_result_to_errno(status);
+}
+
+int hv_call_modify_spa_host_access(u64 partition_id, struct page **pages,
+				   u64 page_struct_count, u32 host_access,
+				   u32 flags, u8 acquire)
+{
+	struct hv_input_modify_sparse_spa_page_host_access *input_page;
+	u64 status;
+	int done = 0;
+	unsigned long irq_flags, large_shift = 0;
+	u64 page_count = page_struct_count;
+	u16 code = acquire ? HVCALL_ACQUIRE_SPARSE_SPA_PAGE_HOST_ACCESS :
+			     HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_ACCESS;
+
+	if (page_count == 0)
+		return -EINVAL;
+
+	if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE) {
+		if (!HV_PAGE_COUNT_2M_ALIGNED(page_count))
+			return -EINVAL;
+		large_shift = HV_HYP_LARGE_PAGE_SHIFT - HV_HYP_PAGE_SHIFT;
+		page_count >>= large_shift;
+	}
+
+	while (done < page_count) {
+		ulong i, completed, remain = page_count - done;
+		int rep_count = min(remain,
+				    HV_MODIFY_SPARSE_SPA_PAGE_HOST_ACCESS_MAX_PAGE_COUNT);
+
+		local_irq_save(irq_flags);
+		input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		memset(input_page, 0, sizeof(*input_page));
+		/* Only set the partition id if you are making the pages
+		 * exclusive
+		 */
+		if (flags & HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE)
+			input_page->partition_id = partition_id;
+		input_page->flags = flags;
+		input_page->host_access = host_access;
+
+		for (i = 0; i < rep_count; i++) {
+			u64 index = (done + i) << large_shift;
+
+			if (index >= page_struct_count)
+				return -EINVAL;
+
+			input_page->spa_page_list[i] =
+						page_to_pfn(pages[index]);
+		}
+
+		status = hv_do_rep_hypercall(code, rep_count, 0, input_page,
+					     NULL);
+		local_irq_restore(irq_flags);
+
+		completed = hv_repcomp(status);
+
+		if (!hv_result_success(status))
+			return hv_result_to_errno(status);
+
+		done += completed;
+	}
+
+	return 0;
+}
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
new file mode 100644
index 000000000000..d6dcae176448
--- /dev/null
+++ b/drivers/hv/mshv_root_main.c
@@ -0,0 +1,2333 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Microsoft Corporation.
+ *
+ * The main part of the mshv_root module, providing APIs to create
+ * and manage guest partitions.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/slab.h>
+#include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/cpuhotplug.h>
+#include <linux/random.h>
+#include <asm/mshyperv.h>
+#include <linux/hyperv.h>
+#include <linux/notifier.h>
+#include <linux/reboot.h>
+#include <linux/kexec.h>
+#include <linux/page-flags.h>
+#include <linux/crash_dump.h>
+#include <linux/panic_notifier.h>
+#include <linux/vmalloc.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+#include "mshv_root.h"
+
+MODULE_AUTHOR("Microsoft");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
+
+/* TODO move this to mshyperv.h when needed outside driver */
+static inline bool hv_parent_partition(void)
+{
+	return hv_root_partition();
+}
+
+/* TODO move this to another file when debugfs code is added */
+enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
+#if defined(CONFIG_X86)
+	VpRootDispatchThreadBlocked			= 201,
+#elif defined(CONFIG_ARM64)
+	VpRootDispatchThreadBlocked			= 94,
+#endif
+	VpStatsMaxCounter
+};
+
+struct hv_stats_page {
+	union {
+		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
+		u8 data[HV_HYP_PAGE_SIZE];
+	};
+} __packed;
+
+struct mshv_root mshv_root = {};
+
+enum hv_scheduler_type hv_scheduler_type;
+
+/* Once we implement the fast extended hypercall ABI they can go away. */
+static void __percpu **root_scheduler_input;
+static void __percpu **root_scheduler_output;
+
+static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static int mshv_dev_open(struct inode *inode, struct file *filp);
+static int mshv_dev_release(struct inode *inode, struct file *filp);
+static int mshv_vp_release(struct inode *inode, struct file *filp);
+static long mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static int mshv_partition_release(struct inode *inode, struct file *filp);
+static long mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg);
+static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma);
+static vm_fault_t mshv_vp_fault(struct vm_fault *vmf);
+static int mshv_init_async_handler(struct mshv_partition *partition);
+static void mshv_async_hvcall_handler(void *data, u64 *status);
+
+static const struct vm_operations_struct mshv_vp_vm_ops = {
+	.fault = mshv_vp_fault,
+};
+
+static const struct file_operations mshv_vp_fops = {
+	.owner = THIS_MODULE,
+	.release = mshv_vp_release,
+	.unlocked_ioctl = mshv_vp_ioctl,
+	.llseek = noop_llseek,
+	.mmap = mshv_vp_mmap,
+};
+
+static const struct file_operations mshv_partition_fops = {
+	.owner = THIS_MODULE,
+	.release = mshv_partition_release,
+	.unlocked_ioctl = mshv_partition_ioctl,
+	.llseek = noop_llseek,
+};
+
+static const struct file_operations mshv_dev_fops = {
+	.owner = THIS_MODULE,
+	.open = mshv_dev_open,
+	.release = mshv_dev_release,
+	.unlocked_ioctl = mshv_dev_ioctl,
+	.llseek = noop_llseek,
+};
+
+static struct miscdevice mshv_dev = {
+	.minor = MISC_DYNAMIC_MINOR,
+	.name = "mshv",
+	.fops = &mshv_dev_fops,
+	.mode = 0600,
+};
+
+/*
+ * Only allow hypercalls that have a u64 partition id as the first member of
+ * the input structure.
+ * These are sorted by value.
+ */
+static u16 mshv_passthru_hvcalls[] = {
+	HVCALL_GET_PARTITION_PROPERTY,
+	HVCALL_SET_PARTITION_PROPERTY,
+	HVCALL_INSTALL_INTERCEPT,
+	HVCALL_GET_VP_REGISTERS,
+	HVCALL_SET_VP_REGISTERS,
+	HVCALL_TRANSLATE_VIRTUAL_ADDRESS,
+	HVCALL_CLEAR_VIRTUAL_INTERRUPT,
+	HVCALL_REGISTER_INTERCEPT_RESULT,
+	HVCALL_ASSERT_VIRTUAL_INTERRUPT,
+	HVCALL_GET_GPA_PAGES_ACCESS_STATES,
+	HVCALL_SIGNAL_EVENT_DIRECT,
+	HVCALL_POST_MESSAGE_DIRECT,
+	HVCALL_GET_VP_CPUID_VALUES,
+};
+
+static bool mshv_hvcall_is_async(u16 code)
+{
+	switch (code) {
+	case HVCALL_SET_PARTITION_PROPERTY:
+		return true;
+	default:
+		break;
+	}
+	return false;
+}
+
+static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
+				      bool partition_locked,
+				      void __user *user_args)
+{
+	u64 status;
+	int ret, i;
+	bool is_async;
+	struct mshv_root_hvcall args;
+	struct page *page;
+	unsigned int pages_order;
+	void *input_pg = NULL;
+	void *output_pg = NULL;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.status || !args.in_ptr || args.in_sz < sizeof(u64) ||
+	    mshv_field_nonzero(args, rsvd) || args.in_sz > HV_HYP_PAGE_SIZE)
+		return -EINVAL;
+
+	if (args.out_ptr && (!args.out_sz || args.out_sz > HV_HYP_PAGE_SIZE))
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
+		if (args.code == mshv_passthru_hvcalls[i])
+			break;
+
+	if (i >= ARRAY_SIZE(mshv_passthru_hvcalls))
+		return -EINVAL;
+
+	is_async = mshv_hvcall_is_async(args.code);
+	if (is_async) {
+		/* async hypercalls can only be called from partition fd */
+		if (!partition_locked)
+			return -EINVAL;
+		ret = mshv_init_async_handler(partition);
+		if (ret)
+			return ret;
+	}
+
+	pages_order = args.out_ptr ? 1 : 0;
+	page = alloc_pages(GFP_KERNEL, pages_order);
+	if (!page)
+		return -ENOMEM;
+	input_pg = page_address(page);
+
+	if (args.out_ptr)
+		output_pg = (char *)input_pg + PAGE_SIZE;
+	else
+		output_pg = NULL;
+
+	if (copy_from_user(input_pg, (void __user *)args.in_ptr,
+			   args.in_sz)) {
+		ret = -EFAULT;
+		goto free_pages_out;
+	}
+
+	/*
+	 * NOTE: This only works because all the allowed hypercalls' input
+	 * structs begin with a u64 partition_id field.
+	 */
+	*(u64 *)input_pg = partition->pt_id;
+
+	if (args.reps)
+		status = hv_do_rep_hypercall(args.code, args.reps, 0,
+					     input_pg, output_pg);
+	else
+		status = hv_do_hypercall(args.code, input_pg, output_pg);
+
+	if (hv_result(status) == HV_STATUS_CALL_PENDING) {
+		if (is_async) {
+			mshv_async_hvcall_handler(partition, &status);
+		} else { /* Paranoia check. This shouldn't happen! */
+			ret = -EBADFD;
+			goto free_pages_out;
+		}
+	}
+
+	if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
+		ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id, 1);
+		if (!ret)
+			ret = -EAGAIN;
+	} else if (!hv_result_success(status)) {
+		ret = hv_result_to_errno(status);
+	}
+
+	/*
+	 * Always return the status and output data regardless of result.
+	 * The VMM may need it to determine how to proceed. E.g. the status may
+	 * contain the number of reps completed if a rep hypercall partially
+	 * succeeded.
+	 */
+	args.status = hv_result(status);
+	args.reps = args.reps ? hv_repcomp(status) : 0;
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		ret = -EFAULT;
+
+	if (output_pg &&
+	    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
+		ret = -EFAULT;
+
+free_pages_out:
+	free_pages((unsigned long)input_pg, pages_order);
+
+	return ret;
+}
+
+static inline bool is_ghcb_mapping_available(void)
+{
+#if IS_ENABLED(CONFIG_X86_64)
+	return ms_hyperv.ext_features & HV_VP_GHCB_ROOT_MAPPING_AVAILABLE;
+#else
+	return 0;
+#endif
+}
+
+static int mshv_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+				 struct hv_register_assoc *registers)
+{
+	union hv_input_vtl input_vtl;
+
+	input_vtl.as_uint8 = 0;
+	return hv_call_get_vp_registers(vp_index, partition_id,
+					count, input_vtl, registers);
+}
+
+static int mshv_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
+				 struct hv_register_assoc *registers)
+{
+	union hv_input_vtl input_vtl;
+
+	input_vtl.as_uint8 = 0;
+	return hv_call_set_vp_registers(vp_index, partition_id,
+					count, input_vtl, registers);
+}
+
+/*
+ * Explicit guest vCPU suspend is asynchronous by nature (as it is requested by
+ * dom0 vCPU for guest vCPU) and thus it can race with "intercept" suspend,
+ * done by the hypervisor.
+ * "Intercept" suspend leads to asynchronous message delivery to dom0 which
+ * should be awaited to keep the VP loop consistent (i.e. no message pending
+ * upon VP resume).
+ * VP intercept suspend can't be done when the VP is explicitly suspended
+ * already, and thus can be only two possible race scenarios:
+ *   1. implicit suspend bit set -> explicit suspend bit set -> message sent
+ *   2. implicit suspend bit set -> message sent -> explicit suspend bit set
+ * Checking for implicit suspend bit set after explicit suspend request has
+ * succeeded in either case allows us to reliably identify, if there is a
+ * message to receive and deliver to VMM.
+ */
+static long
+mshv_suspend_vp(const struct mshv_vp *vp, bool *message_in_flight)
+{
+	struct hv_register_assoc explicit_suspend = {
+		.name = HV_REGISTER_EXPLICIT_SUSPEND
+	};
+	struct hv_register_assoc intercept_suspend = {
+		.name = HV_REGISTER_INTERCEPT_SUSPEND
+	};
+	union hv_explicit_suspend_register *es =
+		&explicit_suspend.value.explicit_suspend;
+	union hv_intercept_suspend_register *is =
+		&intercept_suspend.value.intercept_suspend;
+	int ret;
+
+	es->suspended = 1;
+
+	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+				    1, &explicit_suspend);
+	if (ret) {
+		vp_err(vp, "Failed to explicitly suspend vCPU\n");
+		return ret;
+	}
+
+	ret = mshv_get_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+				    1, &intercept_suspend);
+	if (ret) {
+		vp_err(vp, "Failed to get intercept suspend state\n");
+		return ret;
+	}
+
+	*message_in_flight = is->suspended;
+
+	return 0;
+}
+
+/*
+ * This function is used when VPs are scheduled by the hypervisor's
+ * scheduler.
+ *
+ * Caller has to make sure the registers contain cleared
+ * HV_REGISTER_INTERCEPT_SUSPEND and HV_REGISTER_EXPLICIT_SUSPEND registers
+ * exactly in this order (the hypervisor clears them sequentially) to avoid
+ * potential invalid clearing a newly arrived HV_REGISTER_INTERCEPT_SUSPEND
+ * after VP is released from HV_REGISTER_EXPLICIT_SUSPEND in case of the
+ * opposite order.
+ */
+static long mshv_run_vp_with_hyp_scheduler(struct mshv_vp *vp)
+{
+	long ret;
+	struct hv_register_assoc suspend_regs[2] = {
+			{ .name = HV_REGISTER_INTERCEPT_SUSPEND },
+			{ .name = HV_REGISTER_EXPLICIT_SUSPEND }
+	};
+	size_t count = ARRAY_SIZE(suspend_regs);
+
+	/* Resume VP execution */
+	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+				    count, suspend_regs);
+	if (ret) {
+		vp_err(vp, "Failed to resume vp execution. %lx\n", ret);
+		return ret;
+	}
+
+	ret = wait_event_interruptible(vp->run.vp_suspend_queue,
+				       vp->run.kicked_by_hv == 1);
+	if (ret) {
+		bool message_in_flight;
+
+		/*
+		 * Otherwise the waiting was interrupted by a signal: suspend
+		 * the vCPU explicitly and copy message in flight (if any).
+		 */
+		ret = mshv_suspend_vp(vp, &message_in_flight);
+		if (ret)
+			return ret;
+
+		/* Return if no message in flight */
+		if (!message_in_flight)
+			return -EINTR;
+
+		/* Wait for the message in flight. */
+		wait_event(vp->run.vp_suspend_queue, vp->run.kicked_by_hv == 1);
+	}
+
+	/*
+	 * Reset the flag to make the wait_event call above work
+	 * next time.
+	 */
+	vp->run.kicked_by_hv = 0;
+
+	return 0;
+}
+
+static int
+mshv_vp_dispatch(struct mshv_vp *vp, u32 flags,
+		 struct hv_output_dispatch_vp *res)
+{
+	struct hv_input_dispatch_vp *input;
+	struct hv_output_dispatch_vp *output;
+	u64 status;
+
+	preempt_disable();
+	input = *this_cpu_ptr(root_scheduler_input);
+	output = *this_cpu_ptr(root_scheduler_output);
+
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+
+	input->partition_id = vp->vp_partition->pt_id;
+	input->vp_index = vp->vp_index;
+	input->time_slice = 0; /* Run forever until something happens */
+	input->spec_ctrl = 0; /* TODO: set sensible flags */
+	input->flags = flags;
+
+	vp->run.flags.root_sched_dispatched = 1;
+	status = hv_do_hypercall(HVCALL_DISPATCH_VP, input, output);
+	vp->run.flags.root_sched_dispatched = 0;
+
+	*res = *output;
+	preempt_enable();
+
+	if (!hv_result_success(status))
+		vp_err(vp, "%s: status %s\n", __func__,
+		       hv_result_to_string(status));
+
+	return hv_result_to_errno(status);
+}
+
+static int
+mshv_vp_clear_explicit_suspend(struct mshv_vp *vp)
+{
+	struct hv_register_assoc explicit_suspend = {
+		.name = HV_REGISTER_EXPLICIT_SUSPEND,
+		.value.explicit_suspend.suspended = 0,
+	};
+	int ret;
+
+	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+				    1, &explicit_suspend);
+
+	if (ret)
+		vp_err(vp, "Failed to unsuspend\n");
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_X86_64)
+static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
+{
+	if (!vp->vp_register_page)
+		return 0;
+	return vp->vp_register_page->interrupt_vectors.as_uint64;
+}
+#else
+static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
+{
+	return 0;
+}
+#endif
+
+static bool mshv_vp_dispatch_thread_blocked(struct mshv_vp *vp)
+{
+	struct hv_stats_page **stats = vp->vp_stats_pages;
+	u64 *self_vp_cntrs = stats[HV_STATS_AREA_SELF]->vp_cntrs;
+	u64 *parent_vp_cntrs = stats[HV_STATS_AREA_PARENT]->vp_cntrs;
+
+	if (self_vp_cntrs[VpRootDispatchThreadBlocked])
+		return self_vp_cntrs[VpRootDispatchThreadBlocked];
+	return parent_vp_cntrs[VpRootDispatchThreadBlocked];
+}
+
+static int
+mshv_vp_wait_for_hv_kick(struct mshv_vp *vp)
+{
+	int ret;
+
+	ret = wait_event_interruptible(vp->run.vp_suspend_queue,
+				       (vp->run.kicked_by_hv == 1 &&
+					!mshv_vp_dispatch_thread_blocked(vp)) ||
+				       mshv_vp_interrupt_pending(vp));
+	if (ret)
+		return -EINTR;
+
+	vp->run.flags.root_sched_blocked = 0;
+	vp->run.kicked_by_hv = 0;
+
+	return 0;
+}
+
+static int mshv_pre_guest_mode_work(struct mshv_vp *vp)
+{
+	const ulong work_flags = _TIF_NOTIFY_SIGNAL | _TIF_SIGPENDING |
+				 _TIF_NEED_RESCHED  | _TIF_NOTIFY_RESUME;
+	ulong th_flags;
+
+	th_flags = read_thread_flags();
+	while (th_flags & work_flags) {
+		int ret;
+
+		/* nb: following will call schedule */
+		ret = mshv_do_pre_guest_mode_work(th_flags);
+
+		if (ret)
+			return ret;
+
+		th_flags = read_thread_flags();
+	}
+
+	return 0;
+}
+
+/* Must be called with interrupts enabled */
+static long mshv_run_vp_with_root_scheduler(struct mshv_vp *vp)
+{
+	long ret;
+
+	if (vp->run.flags.root_sched_blocked) {
+		/*
+		 * Dispatch state of this VP is blocked. Need to wait
+		 * for the hypervisor to clear the blocked state before
+		 * dispatching it.
+		 */
+		ret = mshv_vp_wait_for_hv_kick(vp);
+		if (ret)
+			return ret;
+	}
+
+	do {
+		u32 flags = 0;
+		struct hv_output_dispatch_vp output;
+
+		ret = mshv_pre_guest_mode_work(vp);
+		if (ret)
+			break;
+
+		if (vp->run.flags.intercept_suspend)
+			flags |= HV_DISPATCH_VP_FLAG_CLEAR_INTERCEPT_SUSPEND;
+
+		if (mshv_vp_interrupt_pending(vp))
+			flags |= HV_DISPATCH_VP_FLAG_SCAN_INTERRUPT_INJECTION;
+
+		ret = mshv_vp_dispatch(vp, flags, &output);
+		if (ret)
+			break;
+
+		vp->run.flags.intercept_suspend = 0;
+
+		if (output.dispatch_state == HV_VP_DISPATCH_STATE_BLOCKED) {
+			if (output.dispatch_event ==
+						HV_VP_DISPATCH_EVENT_SUSPEND) {
+				/*
+				 * TODO: remove the warning once VP canceling
+				 *	 is supported
+				 */
+				WARN_ONCE(atomic64_read(&vp->run.vp_signaled_count),
+					  "%s: vp#%d: unexpected explicit suspend\n",
+					  __func__, vp->vp_index);
+				/*
+				 * Need to clear explicit suspend before
+				 * dispatching.
+				 * Explicit suspend is either:
+				 * - set right after the first VP dispatch or
+				 * - set explicitly via hypercall
+				 * Since the latter case is not yet supported,
+				 * simply clear it here.
+				 */
+				ret = mshv_vp_clear_explicit_suspend(vp);
+				if (ret)
+					break;
+
+				ret = mshv_vp_wait_for_hv_kick(vp);
+				if (ret)
+					break;
+			} else {
+				vp->run.flags.root_sched_blocked = 1;
+				ret = mshv_vp_wait_for_hv_kick(vp);
+				if (ret)
+					break;
+			}
+		} else {
+			/* HV_VP_DISPATCH_STATE_READY */
+			if (output.dispatch_event ==
+						HV_VP_DISPATCH_EVENT_INTERCEPT)
+				vp->run.flags.intercept_suspend = 1;
+		}
+	} while (!vp->run.flags.intercept_suspend);
+
+	return ret;
+}
+
+static_assert(sizeof(struct hv_message) <= MSHV_RUN_VP_BUF_SZ,
+	      "sizeof(struct hv_message) must not exceed MSHV_RUN_VP_BUF_SZ");
+
+static long mshv_vp_ioctl_run_vp(struct mshv_vp *vp, void __user *ret_msg)
+{
+	long rc;
+	char *schednm;
+
+	schednm = hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT ? "root" : "hv";
+
+	if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
+		rc = mshv_run_vp_with_root_scheduler(vp);
+	else
+		rc = mshv_run_vp_with_hyp_scheduler(vp);
+
+	if (rc)
+		return rc;
+
+	if (copy_to_user(ret_msg, vp->vp_intercept_msg_page,
+			 sizeof(struct hv_message)))
+		rc = -EFAULT;
+
+	return rc;
+}
+
+static int
+mshv_vp_ioctl_get_set_state_pfn(struct mshv_vp *vp,
+				struct hv_vp_state_data state_data,
+				unsigned long user_pfn, size_t page_count,
+				bool is_set)
+{
+	int completed, ret = 0;
+	unsigned long check;
+	struct page **pages;
+
+	if (page_count > INT_MAX)
+		return -EINVAL;
+	/*
+	 * Check the arithmetic for wraparound/overflow.
+	 * The last page address in the buffer is:
+	 * (user_pfn + (page_count - 1)) * PAGE_SIZE
+	 */
+	if (check_add_overflow(user_pfn, (page_count - 1), &check))
+		return -EOVERFLOW;
+	if (check_mul_overflow(check, PAGE_SIZE, &check))
+		return -EOVERFLOW;
+
+	/* Pin user pages so hypervisor can copy directly to them */
+	pages = kcalloc(page_count, sizeof(struct page *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	for (completed = 0; completed < page_count; completed += ret) {
+		unsigned long user_addr = (user_pfn + completed) * PAGE_SIZE;
+		int remaining = page_count - completed;
+
+		ret = pin_user_pages_fast(user_addr, remaining, FOLL_WRITE,
+					  &pages[completed]);
+		if (ret < 0) {
+			vp_err(vp, "%s: Failed to pin user pages error %i\n",
+			       __func__, ret);
+			goto unpin_pages;
+		}
+	}
+
+	if (is_set)
+		ret = hv_call_set_vp_state(vp->vp_index,
+					   vp->vp_partition->pt_id,
+					   state_data, page_count, pages,
+					   0, NULL);
+	else
+		ret = hv_call_get_vp_state(vp->vp_index,
+					   vp->vp_partition->pt_id,
+					   state_data, page_count, pages,
+					   NULL);
+
+unpin_pages:
+	unpin_user_pages(pages, completed);
+	kfree(pages);
+	return ret;
+}
+
+static long
+mshv_vp_ioctl_get_set_state(struct mshv_vp *vp,
+			    struct mshv_get_set_vp_state __user *user_args,
+			    bool is_set)
+{
+	struct mshv_get_set_vp_state args;
+	long ret = 0;
+	union hv_output_get_vp_state vp_state;
+	u32 data_sz;
+	struct hv_vp_state_data state_data = {};
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.type >= MSHV_VP_STATE_COUNT || mshv_field_nonzero(args, rsvd) ||
+	    !args.buf_sz || !PAGE_ALIGNED(args.buf_sz) ||
+	    !PAGE_ALIGNED(args.buf_ptr))
+		return -EINVAL;
+
+	if (!access_ok((void __user *)args.buf_ptr, args.buf_sz))
+		return -EFAULT;
+
+	switch (args.type) {
+	case MSHV_VP_STATE_LAPIC:
+		state_data.type = HV_GET_SET_VP_STATE_LAPIC_STATE;
+		data_sz = HV_HYP_PAGE_SIZE;
+		break;
+	case MSHV_VP_STATE_XSAVE:
+	{
+		u64 data_sz_64;
+
+		ret = hv_call_get_partition_property(vp->vp_partition->pt_id,
+						     HV_PARTITION_PROPERTY_XSAVE_STATES,
+						     &state_data.xsave.states.as_uint64);
+		if (ret)
+			return ret;
+
+		ret = hv_call_get_partition_property(vp->vp_partition->pt_id,
+						     HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE,
+						     &data_sz_64);
+		if (ret)
+			return ret;
+
+		data_sz = (u32)data_sz_64;
+		state_data.xsave.flags = 0;
+		/* Always request legacy states */
+		state_data.xsave.states.legacy_x87 = 1;
+		state_data.xsave.states.legacy_sse = 1;
+		state_data.type = HV_GET_SET_VP_STATE_XSAVE;
+		break;
+	}
+	case MSHV_VP_STATE_SIMP:
+		state_data.type = HV_GET_SET_VP_STATE_SIM_PAGE;
+		data_sz = HV_HYP_PAGE_SIZE;
+		break;
+	case MSHV_VP_STATE_SIEFP:
+		state_data.type = HV_GET_SET_VP_STATE_SIEF_PAGE;
+		data_sz = HV_HYP_PAGE_SIZE;
+		break;
+	case MSHV_VP_STATE_SYNTHETIC_TIMERS:
+		state_data.type = HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS;
+		data_sz = sizeof(vp_state.synthetic_timers_state);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (copy_to_user(&user_args->buf_sz, &data_sz, sizeof(user_args->buf_sz)))
+		return -EFAULT;
+
+	if (data_sz > args.buf_sz)
+		return -EINVAL;
+
+	/* If the data is transmitted via pfns, delegate to helper */
+	if (state_data.type & HV_GET_SET_VP_STATE_TYPE_PFN) {
+		unsigned long user_pfn = PFN_DOWN(args.buf_ptr);
+		size_t page_count = PFN_DOWN(args.buf_sz);
+
+		return mshv_vp_ioctl_get_set_state_pfn(vp, state_data, user_pfn,
+						       page_count, is_set);
+	}
+
+	/* Paranoia check - this shouldn't happen! */
+	if (data_sz > sizeof(vp_state)) {
+		vp_err(vp, "Invalid vp state data size!\n");
+		return -EINVAL;
+	}
+
+	if (is_set) {
+		if (copy_from_user(&vp_state, (__user void *)args.buf_ptr, data_sz))
+			return -EFAULT;
+
+		return hv_call_set_vp_state(vp->vp_index,
+					    vp->vp_partition->pt_id,
+					    state_data, 0, NULL,
+					    sizeof(vp_state), (u8 *)&vp_state);
+	}
+
+	ret = hv_call_get_vp_state(vp->vp_index, vp->vp_partition->pt_id,
+				   state_data, 0, NULL, &vp_state);
+	if (ret)
+		return ret;
+
+	if (copy_to_user((void __user *)args.buf_ptr, &vp_state, data_sz))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long
+mshv_vp_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct mshv_vp *vp = filp->private_data;
+	long r = -ENOTTY;
+
+	if (mutex_lock_killable(&vp->vp_mutex))
+		return -EINTR;
+
+	switch (ioctl) {
+	case MSHV_RUN_VP:
+		r = mshv_vp_ioctl_run_vp(vp, (void __user *)arg);
+		break;
+	case MSHV_GET_VP_STATE:
+		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, false);
+		break;
+	case MSHV_SET_VP_STATE:
+		r = mshv_vp_ioctl_get_set_state(vp, (void __user *)arg, true);
+		break;
+	case MSHV_ROOT_HVCALL:
+		r = mshv_ioctl_passthru_hvcall(vp->vp_partition, false,
+					       (void __user *)arg);
+		break;
+	default:
+		vp_warn(vp, "Invalid ioctl: %#x\n", ioctl);
+		break;
+	}
+	mutex_unlock(&vp->vp_mutex);
+
+	return r;
+}
+
+static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
+{
+	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
+
+	switch (vmf->vma->vm_pgoff) {
+	case MSHV_VP_MMAP_OFFSET_REGISTERS:
+		vmf->page = virt_to_page(vp->vp_register_page);
+		break;
+	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
+		vmf->page = virt_to_page(vp->vp_intercept_msg_page);
+		break;
+	case MSHV_VP_MMAP_OFFSET_GHCB:
+		if (is_ghcb_mapping_available())
+			vmf->page = virt_to_page(vp->vp_ghcb_page);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	get_page(vmf->page);
+
+	return 0;
+}
+
+static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	struct mshv_vp *vp = file->private_data;
+
+	switch (vma->vm_pgoff) {
+	case MSHV_VP_MMAP_OFFSET_REGISTERS:
+		if (!vp->vp_register_page)
+			return -ENODEV;
+		break;
+	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
+		if (!vp->vp_intercept_msg_page)
+			return -ENODEV;
+		break;
+	case MSHV_VP_MMAP_OFFSET_GHCB:
+		if (is_ghcb_mapping_available() && !vp->vp_ghcb_page)
+			return -ENODEV;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	vma->vm_ops = &mshv_vp_vm_ops;
+	return 0;
+}
+
+static int
+mshv_vp_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_vp *vp = filp->private_data;
+
+	/* Rest of VP cleanup happens in destroy_partition() */
+	mshv_partition_put(vp->vp_partition);
+	return 0;
+}
+
+static void mshv_vp_stats_unmap(u64 partition_id, u32 vp_index)
+{
+	union hv_stats_object_identity identity = {
+		.vp.partition_id = partition_id,
+		.vp.vp_index = vp_index,
+	};
+
+	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
+	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+
+	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
+	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+}
+
+static int mshv_vp_stats_map(u64 partition_id, u32 vp_index,
+			     void *stats_pages[])
+{
+	union hv_stats_object_identity identity = {
+		.vp.partition_id = partition_id,
+		.vp.vp_index = vp_index,
+	};
+	int err;
+
+	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
+	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
+				    &stats_pages[HV_STATS_AREA_SELF]);
+	if (err)
+		return err;
+
+	identity.vp.stats_area_type = HV_STATS_AREA_PARENT;
+	err = hv_call_map_stat_page(HV_STATS_OBJECT_VP, &identity,
+				    &stats_pages[HV_STATS_AREA_PARENT]);
+	if (err)
+		goto unmap_self;
+
+	return 0;
+
+unmap_self:
+	identity.vp.stats_area_type = HV_STATS_AREA_SELF;
+	hv_call_unmap_stat_page(HV_STATS_OBJECT_VP, &identity);
+	return err;
+}
+
+static long
+mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
+			       void __user *arg)
+{
+	struct mshv_create_vp args;
+	struct mshv_vp *vp;
+	struct page *intercept_message_page, *register_page, *ghcb_page;
+	void *stats_pages[2];
+	long ret;
+	union hv_input_vtl input_vtl;
+
+	if (copy_from_user(&args, arg, sizeof(args)))
+		return -EFAULT;
+
+	if (args.vp_index >= MSHV_MAX_VPS)
+		return -EINVAL;
+
+	if (partition->pt_vp_array[args.vp_index])
+		return -EEXIST;
+
+	ret = hv_call_create_vp(NUMA_NO_NODE, partition->pt_id, args.vp_index,
+				0 /* Only valid for root partition VPs */);
+	if (ret)
+		return ret;
+
+	input_vtl.as_uint8 = 0;
+	ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
+					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+					input_vtl,
+					&intercept_message_page);
+	if (ret)
+		goto destroy_vp;
+
+	if (!mshv_partition_encrypted(partition)) {
+		input_vtl.as_uint8 = 0;
+		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
+						HV_VP_STATE_PAGE_REGISTERS,
+						input_vtl,
+						&register_page);
+		if (ret)
+			goto unmap_intercept_message_page;
+	}
+
+	if (mshv_partition_encrypted(partition) &&
+	    is_ghcb_mapping_available()) {
+		input_vtl.as_uint8 = 0;
+		input_vtl.use_target_vtl = 1;
+		input_vtl.target_vtl = HV_NORMAL_VTL;
+		ret = hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
+						HV_VP_STATE_PAGE_GHCB,
+						input_vtl,
+						&ghcb_page);
+		if (ret)
+			goto unmap_register_page;
+	}
+
+	if (hv_parent_partition()) {
+		ret = mshv_vp_stats_map(partition->pt_id, args.vp_index,
+					stats_pages);
+		if (ret)
+			goto unmap_ghcb_page;
+	}
+
+	vp = kzalloc(sizeof(*vp), GFP_KERNEL);
+	if (!vp)
+		goto unmap_stats_pages;
+
+	vp->vp_partition = mshv_partition_get(partition);
+	if (!vp->vp_partition) {
+		ret = -EBADF;
+		goto free_vp;
+	}
+
+	mutex_init(&vp->vp_mutex);
+	init_waitqueue_head(&vp->run.vp_suspend_queue);
+	atomic64_set(&vp->run.vp_signaled_count, 0);
+
+	vp->vp_index = args.vp_index;
+	vp->vp_intercept_msg_page = page_to_virt(intercept_message_page);
+	if (!mshv_partition_encrypted(partition))
+		vp->vp_register_page = page_to_virt(register_page);
+
+	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available())
+		vp->vp_ghcb_page = page_to_virt(ghcb_page);
+
+	if (hv_parent_partition())
+		memcpy(vp->vp_stats_pages, stats_pages, sizeof(stats_pages));
+
+	/*
+	 * Keep anon_inode_getfd last: it installs fd in the file struct and
+	 * thus makes the state accessible in user space.
+	 */
+	ret = anon_inode_getfd("mshv_vp", &mshv_vp_fops, vp,
+			       O_RDWR | O_CLOEXEC);
+	if (ret < 0)
+		goto put_partition;
+
+	/* already exclusive with the partition mutex for all ioctls */
+	partition->pt_vp_count++;
+	partition->pt_vp_array[args.vp_index] = vp;
+
+	return ret;
+
+put_partition:
+	mshv_partition_put(partition);
+free_vp:
+	kfree(vp);
+unmap_stats_pages:
+	if (hv_parent_partition())
+		mshv_vp_stats_unmap(partition->pt_id, args.vp_index);
+unmap_ghcb_page:
+	if (mshv_partition_encrypted(partition) && is_ghcb_mapping_available()) {
+		input_vtl.as_uint8 = 0;
+		input_vtl.use_target_vtl = 1;
+		input_vtl.target_vtl = HV_NORMAL_VTL;
+
+		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
+					    HV_VP_STATE_PAGE_GHCB, input_vtl);
+	}
+unmap_register_page:
+	if (!mshv_partition_encrypted(partition)) {
+		input_vtl.as_uint8 = 0;
+
+		hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
+					    HV_VP_STATE_PAGE_REGISTERS,
+					    input_vtl);
+	}
+unmap_intercept_message_page:
+	input_vtl.as_uint8 = 0;
+	hv_call_unmap_vp_state_page(partition->pt_id, args.vp_index,
+				    HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+				    input_vtl);
+destroy_vp:
+	hv_call_delete_vp(partition->pt_id, args.vp_index);
+	return ret;
+}
+
+static int mshv_init_async_handler(struct mshv_partition *partition)
+{
+	if (completion_done(&partition->async_hypercall)) {
+		pt_err(partition,
+		       "Cannot issue another async hypercall, while another one in progress!\n");
+		return -EPERM;
+	}
+
+	reinit_completion(&partition->async_hypercall);
+	return 0;
+}
+
+static void mshv_async_hvcall_handler(void *data, u64 *status)
+{
+	struct mshv_partition *partition = data;
+
+	wait_for_completion(&partition->async_hypercall);
+	pt_dbg(partition, "Async hypercall completed!\n");
+
+	*status = partition->async_hypercall_status;
+}
+
+static int
+mshv_partition_region_share(struct mshv_mem_region *region)
+{
+	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_SHARED;
+
+	if (region->flags.large_pages)
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+
+	return hv_call_modify_spa_host_access(region->partition->pt_id,
+			region->pages, region->nr_pages,
+			HV_MAP_GPA_READABLE | HV_MAP_GPA_WRITABLE,
+			flags, true);
+}
+
+static int
+mshv_partition_region_unshare(struct mshv_mem_region *region)
+{
+	u32 flags = HV_MODIFY_SPA_PAGE_HOST_ACCESS_MAKE_EXCLUSIVE;
+
+	if (region->flags.large_pages)
+		flags |= HV_MODIFY_SPA_PAGE_HOST_ACCESS_LARGE_PAGE;
+
+	return hv_call_modify_spa_host_access(region->partition->pt_id,
+			region->pages, region->nr_pages,
+			0,
+			flags, false);
+}
+
+static int
+mshv_region_remap_pages(struct mshv_mem_region *region, u32 map_flags,
+			u64 page_offset, u64 page_count)
+{
+	if (page_offset + page_count > region->nr_pages)
+		return -EINVAL;
+
+	if (region->flags.large_pages)
+		map_flags |= HV_MAP_GPA_LARGE_PAGE;
+
+	/* ask the hypervisor to map guest ram */
+	return hv_call_map_gpa_pages(region->partition->pt_id,
+				     region->start_gfn + page_offset,
+				     page_count, map_flags,
+				     region->pages + page_offset);
+}
+
+static int
+mshv_region_map(struct mshv_mem_region *region)
+{
+	u32 map_flags = region->hv_map_flags;
+
+	return mshv_region_remap_pages(region, map_flags,
+				       0, region->nr_pages);
+}
+
+static void
+mshv_region_evict_pages(struct mshv_mem_region *region,
+			u64 page_offset, u64 page_count)
+{
+	if (region->flags.range_pinned)
+		unpin_user_pages(region->pages + page_offset, page_count);
+
+	memset(region->pages + page_offset, 0,
+	       page_count * sizeof(struct page *));
+}
+
+static void
+mshv_region_evict(struct mshv_mem_region *region)
+{
+	mshv_region_evict_pages(region, 0, region->nr_pages);
+}
+
+static int
+mshv_region_populate_pages(struct mshv_mem_region *region,
+			   u64 page_offset, u64 page_count)
+{
+	u64 done_count, nr_pages;
+	struct page **pages;
+	__u64 userspace_addr;
+	int ret;
+
+	if (page_offset + page_count > region->nr_pages)
+		return -EINVAL;
+
+	for (done_count = 0; done_count < page_count; done_count += ret) {
+		pages = region->pages + page_offset + done_count;
+		userspace_addr = region->start_uaddr +
+				(page_offset + done_count) *
+				HV_HYP_PAGE_SIZE;
+		nr_pages = min(page_count - done_count,
+			       MSHV_PIN_PAGES_BATCH_SIZE);
+
+		/*
+		 * Pinning assuming 4k pages works for large pages too.
+		 * All page structs within the large page are returned.
+		 *
+		 * Pin requests are batched because pin_user_pages_fast
+		 * with the FOLL_LONGTERM flag does a large temporary
+		 * allocation of contiguous memory.
+		 */
+		if (region->flags.range_pinned)
+			ret = pin_user_pages_fast(userspace_addr,
+						  nr_pages,
+						  FOLL_WRITE | FOLL_LONGTERM,
+						  pages);
+		else
+			ret = -EOPNOTSUPP;
+
+		if (ret < 0)
+			goto release_pages;
+	}
+
+	if (PageHuge(region->pages[page_offset]))
+		region->flags.large_pages = true;
+
+	return 0;
+
+release_pages:
+	mshv_region_evict_pages(region, page_offset, done_count);
+	return ret;
+}
+
+static int
+mshv_region_populate(struct mshv_mem_region *region)
+{
+	return mshv_region_populate_pages(region, 0, region->nr_pages);
+}
+
+static struct mshv_mem_region *
+mshv_partition_region_by_gfn(struct mshv_partition *partition, u64 gfn)
+{
+	struct mshv_mem_region *region;
+
+	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+		if (gfn >= region->start_gfn &&
+		    gfn < region->start_gfn + region->nr_pages)
+			return region;
+	}
+
+	return NULL;
+}
+
+static struct mshv_mem_region *
+mshv_partition_region_by_uaddr(struct mshv_partition *partition, u64 uaddr)
+{
+	struct mshv_mem_region *region;
+
+	hlist_for_each_entry(region, &partition->pt_mem_regions, hnode) {
+		if (uaddr >= region->start_uaddr &&
+		    uaddr < region->start_uaddr +
+			    (region->nr_pages << HV_HYP_PAGE_SHIFT))
+			return region;
+	}
+
+	return NULL;
+}
+
+/*
+ * NB: caller checks and makes sure mem->size is page aligned
+ * Returns: 0 with regionpp updated on success, or -errno
+ */
+static int mshv_partition_create_region(struct mshv_partition *partition,
+					struct mshv_user_mem_region *mem,
+					struct mshv_mem_region **regionpp,
+					bool is_mmio)
+{
+	struct mshv_mem_region *region;
+	u64 nr_pages = HVPFN_DOWN(mem->size);
+
+	/* Reject overlapping regions */
+	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
+	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1) ||
+	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) ||
+	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + mem->size - 1))
+		return -EEXIST;
+
+	region = vzalloc(sizeof(*region) + sizeof(struct page *) * nr_pages);
+	if (!region)
+		return -ENOMEM;
+
+	region->nr_pages = nr_pages;
+	region->start_gfn = mem->guest_pfn;
+	region->start_uaddr = mem->userspace_addr;
+	region->hv_map_flags = HV_MAP_GPA_READABLE | HV_MAP_GPA_ADJUSTABLE;
+	if (mem->flags & BIT(MSHV_SET_MEM_BIT_WRITABLE))
+		region->hv_map_flags |= HV_MAP_GPA_WRITABLE;
+	if (mem->flags & BIT(MSHV_SET_MEM_BIT_EXECUTABLE))
+		region->hv_map_flags |= HV_MAP_GPA_EXECUTABLE;
+
+	/* Note: large_pages flag populated when we pin the pages */
+	if (!is_mmio)
+		region->flags.range_pinned = true;
+
+	region->partition = partition;
+
+	*regionpp = region;
+
+	return 0;
+}
+
+/*
+ * Map guest ram. if snp, make sure to release that from the host first
+ * Side Effects: In case of failure, pages are unpinned when feasible.
+ */
+static int
+mshv_partition_mem_region_map(struct mshv_mem_region *region)
+{
+	struct mshv_partition *partition = region->partition;
+	int ret;
+
+	ret = mshv_region_populate(region);
+	if (ret) {
+		pt_err(partition, "Failed to populate memory region: %d\n",
+		       ret);
+		goto err_out;
+	}
+
+	/*
+	 * For an SNP partition it is a requirement that for every memory region
+	 * that we are going to map for this partition we should make sure that
+	 * host access to that region is released. This is ensured by doing an
+	 * additional hypercall which will update the SLAT to release host
+	 * access to guest memory regions.
+	 */
+	if (mshv_partition_encrypted(partition)) {
+		ret = mshv_partition_region_unshare(region);
+		if (ret) {
+			pt_err(partition,
+			       "Failed to unshare memory region (guest_pfn: %llu): %d\n",
+			       region->start_gfn, ret);
+			goto evict_region;
+		}
+	}
+
+	ret = mshv_region_map(region);
+	if (ret && mshv_partition_encrypted(partition)) {
+		int shrc;
+
+		shrc = mshv_partition_region_share(region);
+		if (!shrc)
+			goto evict_region;
+
+		pt_err(partition,
+		       "Failed to share memory region (guest_pfn: %llu): %d\n",
+		       region->start_gfn, shrc);
+		/*
+		 * Don't unpin if marking shared failed because pages are no
+		 * longer mapped in the host, ie root, anymore.
+		 */
+		goto err_out;
+	}
+
+	return 0;
+
+evict_region:
+	mshv_region_evict(region);
+err_out:
+	return ret;
+}
+
+/*
+ * This maps two things: guest RAM and for pci passthru mmio space.
+ *
+ * mmio:
+ *  - vfio overloads vm_pgoff to store the mmio start pfn/spa.
+ *  - Two things need to happen for mapping mmio range:
+ *	1. mapped in the uaddr so VMM can access it.
+ *	2. mapped in the hwpt (gfn <-> mmio phys addr) so guest can access it.
+ *
+ *   This function takes care of the second. The first one is managed by vfio,
+ *   and hence is taken care of via vfio_pci_mmap_fault().
+ */
+static long
+mshv_map_user_memory(struct mshv_partition *partition,
+		     struct mshv_user_mem_region mem)
+{
+	struct mshv_mem_region *region;
+	struct vm_area_struct *vma;
+	bool is_mmio;
+	ulong mmio_pfn;
+	long ret;
+
+	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP) ||
+	    !access_ok((const void *)mem.userspace_addr, mem.size))
+		return -EINVAL;
+
+	mmap_read_lock(current->mm);
+	vma = vma_lookup(current->mm, mem.userspace_addr);
+	is_mmio = vma ? !!(vma->vm_flags & (VM_IO | VM_PFNMAP)) : 0;
+	mmio_pfn = is_mmio ? vma->vm_pgoff : 0;
+	mmap_read_unlock(current->mm);
+
+	if (!vma)
+		return -EINVAL;
+
+	ret = mshv_partition_create_region(partition, &mem, &region,
+					   is_mmio);
+	if (ret)
+		return ret;
+
+	if (is_mmio)
+		ret = hv_call_map_mmio_pages(partition->pt_id, mem.guest_pfn,
+					     mmio_pfn, HVPFN_DOWN(mem.size));
+	else
+		ret = mshv_partition_mem_region_map(region);
+
+	if (ret)
+		goto errout;
+
+	/* Install the new region */
+	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
+
+	return 0;
+
+errout:
+	vfree(region);
+	return ret;
+}
+
+/* Called for unmapping both the guest ram and the mmio space */
+static long
+mshv_unmap_user_memory(struct mshv_partition *partition,
+		       struct mshv_user_mem_region mem)
+{
+	struct mshv_mem_region *region;
+	u32 unmap_flags = 0;
+
+	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
+		return -EINVAL;
+
+	if (hlist_empty(&partition->pt_mem_regions))
+		return -EINVAL;
+
+	region = mshv_partition_region_by_gfn(partition, mem.guest_pfn);
+	if (!region)
+		return -EINVAL;
+
+	/* Paranoia check */
+	if (region->start_uaddr != mem.userspace_addr ||
+	    region->start_gfn != mem.guest_pfn ||
+	    region->nr_pages != HVPFN_DOWN(mem.size))
+		return -EINVAL;
+
+	hlist_del(&region->hnode);
+
+	if (region->flags.large_pages)
+		unmap_flags |= HV_UNMAP_GPA_LARGE_PAGE;
+
+	/* ignore unmap failures and continue as process may be exiting */
+	hv_call_unmap_gpa_pages(partition->pt_id, region->start_gfn,
+				region->nr_pages, unmap_flags);
+
+	mshv_region_evict(region);
+
+	vfree(region);
+	return 0;
+}
+
+static long
+mshv_partition_ioctl_set_memory(struct mshv_partition *partition,
+				struct mshv_user_mem_region __user *user_mem)
+{
+	struct mshv_user_mem_region mem;
+
+	if (copy_from_user(&mem, user_mem, sizeof(mem)))
+		return -EFAULT;
+
+	if (!mem.size ||
+	    !PAGE_ALIGNED(mem.size) ||
+	    !PAGE_ALIGNED(mem.userspace_addr) ||
+	    (mem.flags & ~MSHV_SET_MEM_FLAGS_MASK) ||
+	    mshv_field_nonzero(mem, rsvd))
+		return -EINVAL;
+
+	if (mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP))
+		return mshv_unmap_user_memory(partition, mem);
+
+	return mshv_map_user_memory(partition, mem);
+}
+
+static long
+mshv_partition_ioctl_ioeventfd(struct mshv_partition *partition,
+			       void __user *user_args)
+{
+	struct mshv_user_ioeventfd args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return mshv_set_unset_ioeventfd(partition, &args);
+}
+
+static long
+mshv_partition_ioctl_irqfd(struct mshv_partition *partition,
+			   void __user *user_args)
+{
+	struct mshv_user_irqfd args;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	return mshv_set_unset_irqfd(partition, &args);
+}
+
+static long
+mshv_partition_ioctl_get_gpap_access_bitmap(struct mshv_partition *partition,
+					    void __user *user_args)
+{
+	struct mshv_gpap_access_bitmap args;
+	union hv_gpa_page_access_state *states;
+	long ret, i;
+	union hv_gpa_page_access_state_flags hv_flags = {};
+	u8 hv_type_mask;
+	ulong bitmap_buf_sz, states_buf_sz;
+	int written = 0;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.access_type >= MSHV_GPAP_ACCESS_TYPE_COUNT ||
+	    args.access_op >= MSHV_GPAP_ACCESS_OP_COUNT ||
+	    mshv_field_nonzero(args, rsvd) || !args.page_count ||
+	    !args.bitmap_ptr)
+		return -EINVAL;
+
+	if (check_mul_overflow(args.page_count, sizeof(*states), &states_buf_sz))
+		return -E2BIG;
+
+	/* Num bytes needed to store bitmap; one bit per page rounded up */
+	bitmap_buf_sz = DIV_ROUND_UP(args.page_count, 8);
+
+	/* Sanity check */
+	if (bitmap_buf_sz > states_buf_sz)
+		return -EBADFD;
+
+	switch (args.access_type) {
+	case MSHV_GPAP_ACCESS_TYPE_ACCESSED:
+		hv_type_mask = 1;
+		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
+			hv_flags.clear_accessed = 1;
+			/* not accessed implies not dirty */
+			hv_flags.clear_dirty = 1;
+		} else { // MSHV_GPAP_ACCESS_OP_SET
+			hv_flags.set_accessed = 1;
+		}
+		break;
+	case MSHV_GPAP_ACCESS_TYPE_DIRTY:
+		hv_type_mask = 2;
+		if (args.access_op == MSHV_GPAP_ACCESS_OP_CLEAR) {
+			hv_flags.clear_dirty = 1;
+		} else { // MSHV_GPAP_ACCESS_OP_SET
+			hv_flags.set_dirty = 1;
+			/* dirty implies accessed */
+			hv_flags.set_accessed = 1;
+		}
+		break;
+	}
+
+	states = vzalloc(states_buf_sz);
+	if (!states)
+		return -ENOMEM;
+
+	ret = hv_call_get_gpa_access_states(partition->pt_id, args.page_count,
+					    args.gpap_base, hv_flags, &written,
+					    states);
+	if (ret)
+		goto free_return;
+
+	/*
+	 * Overwrite states buffer with bitmap - the bits in hv_type_mask
+	 * correspond to bitfields in hv_gpa_page_access_state
+	 */
+	for (i = 0; i < written; ++i)
+		assign_bit(i, (ulong *)states,
+			   states[i].as_uint8 & hv_type_mask);
+
+	args.page_count = written;
+
+	if (copy_to_user(user_args, &args, sizeof(args))) {
+		ret = -EFAULT;
+		goto free_return;
+	}
+	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_buf_sz))
+		ret = -EFAULT;
+
+free_return:
+	vfree(states);
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_set_msi_routing(struct mshv_partition *partition,
+				     void __user *user_args)
+{
+	struct mshv_user_irq_entry *entries = NULL;
+	struct mshv_user_irq_table args;
+	long ret;
+
+	if (copy_from_user(&args, user_args, sizeof(args)))
+		return -EFAULT;
+
+	if (args.nr > MSHV_MAX_GUEST_IRQS ||
+	    mshv_field_nonzero(args, rsvd))
+		return -EINVAL;
+
+	if (args.nr) {
+		struct mshv_user_irq_table __user *urouting = user_args;
+
+		entries = vmemdup_user(urouting->entries,
+				       array_size(sizeof(*entries),
+						  args.nr));
+		if (IS_ERR(entries))
+			return PTR_ERR(entries);
+	}
+	ret = mshv_update_routing_table(partition, entries, args.nr);
+	kvfree(entries);
+
+	return ret;
+}
+
+static long
+mshv_partition_ioctl_initialize(struct mshv_partition *partition)
+{
+	long ret;
+
+	if (partition->pt_initialized)
+		return 0;
+
+	ret = hv_call_initialize_partition(partition->pt_id);
+	if (ret)
+		goto withdraw_mem;
+
+	partition->pt_initialized = true;
+
+	return 0;
+
+withdraw_mem:
+	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
+
+	return ret;
+}
+
+static long
+mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct mshv_partition *partition = filp->private_data;
+	long ret;
+	void __user *uarg = (void __user *)arg;
+
+	if (mutex_lock_killable(&partition->pt_mutex))
+		return -EINTR;
+
+	switch (ioctl) {
+	case MSHV_INITIALIZE_PARTITION:
+		ret = mshv_partition_ioctl_initialize(partition);
+		break;
+	case MSHV_SET_GUEST_MEMORY:
+		ret = mshv_partition_ioctl_set_memory(partition, uarg);
+		break;
+	case MSHV_CREATE_VP:
+		ret = mshv_partition_ioctl_create_vp(partition, uarg);
+		break;
+	case MSHV_IRQFD:
+		ret = mshv_partition_ioctl_irqfd(partition, uarg);
+		break;
+	case MSHV_IOEVENTFD:
+		ret = mshv_partition_ioctl_ioeventfd(partition, uarg);
+		break;
+	case MSHV_SET_MSI_ROUTING:
+		ret = mshv_partition_ioctl_set_msi_routing(partition, uarg);
+		break;
+	case MSHV_GET_GPAP_ACCESS_BITMAP:
+		ret = mshv_partition_ioctl_get_gpap_access_bitmap(partition,
+								  uarg);
+		break;
+	case MSHV_ROOT_HVCALL:
+		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
+		break;
+	default:
+		ret = -ENOTTY;
+	}
+
+	mutex_unlock(&partition->pt_mutex);
+	return ret;
+}
+
+static int
+disable_vp_dispatch(struct mshv_vp *vp)
+{
+	int ret;
+	struct hv_register_assoc dispatch_suspend = {
+		.name = HV_REGISTER_DISPATCH_SUSPEND,
+		.value.dispatch_suspend.suspended = 1,
+	};
+
+	ret = mshv_set_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+				    1, &dispatch_suspend);
+	if (ret)
+		vp_err(vp, "failed to suspend\n");
+
+	return ret;
+}
+
+static int
+get_vp_signaled_count(struct mshv_vp *vp, u64 *count)
+{
+	int ret;
+	struct hv_register_assoc root_signal_count = {
+		.name = HV_REGISTER_VP_ROOT_SIGNAL_COUNT,
+	};
+
+	ret = mshv_get_vp_registers(vp->vp_index, vp->vp_partition->pt_id,
+				    1, &root_signal_count);
+
+	if (ret) {
+		vp_err(vp, "Failed to get root signal count");
+		*count = 0;
+		return ret;
+	}
+
+	*count = root_signal_count.value.reg64;
+
+	return ret;
+}
+
+static void
+drain_vp_signals(struct mshv_vp *vp)
+{
+	u64 hv_signal_count;
+	u64 vp_signal_count;
+
+	get_vp_signaled_count(vp, &hv_signal_count);
+
+	vp_signal_count = atomic64_read(&vp->run.vp_signaled_count);
+
+	/*
+	 * There should be at most 1 outstanding notification, but be extra
+	 * careful anyway.
+	 */
+	while (hv_signal_count != vp_signal_count) {
+		WARN_ON(hv_signal_count - vp_signal_count != 1);
+
+		if (wait_event_interruptible(vp->run.vp_suspend_queue,
+					     vp->run.kicked_by_hv == 1))
+			break;
+		vp->run.kicked_by_hv = 0;
+		vp_signal_count = atomic64_read(&vp->run.vp_signaled_count);
+	}
+}
+
+static void drain_all_vps(const struct mshv_partition *partition)
+{
+	int i;
+	struct mshv_vp *vp;
+
+	/*
+	 * VPs are reachable from ISR. It is safe to not take the partition
+	 * lock because nobody else can enter this function and drop the
+	 * partition from the list.
+	 */
+	for (i = 0; i < MSHV_MAX_VPS; i++) {
+		vp = partition->pt_vp_array[i];
+		if (!vp)
+			continue;
+		/*
+		 * Disable dispatching of the VP in the hypervisor. After this
+		 * the hypervisor guarantees it won't generate any signals for
+		 * the VP and the hypervisor's VP signal count won't change.
+		 */
+		disable_vp_dispatch(vp);
+		drain_vp_signals(vp);
+	}
+}
+
+static void
+remove_partition(struct mshv_partition *partition)
+{
+	spin_lock(&mshv_root.pt_ht_lock);
+	hlist_del_rcu(&partition->pt_hnode);
+	spin_unlock(&mshv_root.pt_ht_lock);
+
+	synchronize_rcu();
+}
+
+/*
+ * Tear down a partition and remove it from the list.
+ * Partition's refcount must be 0
+ */
+static void destroy_partition(struct mshv_partition *partition)
+{
+	struct mshv_vp *vp;
+	struct mshv_mem_region *region;
+	int i, ret;
+	struct hlist_node *n;
+	union hv_input_vtl input_vtl;
+
+	if (refcount_read(&partition->pt_ref_count)) {
+		pt_err(partition,
+		       "Attempt to destroy partition but refcount > 0\n");
+		return;
+	}
+
+	if (partition->pt_initialized) {
+		/*
+		 * We only need to drain signals for root scheduler. This should be
+		 * done before removing the partition from the partition list.
+		 */
+		if (hv_scheduler_type == HV_SCHEDULER_TYPE_ROOT)
+			drain_all_vps(partition);
+
+		/* Remove vps */
+		for (i = 0; i < MSHV_MAX_VPS; ++i) {
+			vp = partition->pt_vp_array[i];
+			if (!vp)
+				continue;
+
+			if (hv_parent_partition())
+				mshv_vp_stats_unmap(partition->pt_id, vp->vp_index);
+
+			if (vp->vp_register_page) {
+				input_vtl.as_uint8 = 0;
+				(void)hv_call_unmap_vp_state_page(partition->pt_id,
+								  vp->vp_index,
+								  HV_VP_STATE_PAGE_REGISTERS,
+								  input_vtl);
+				vp->vp_register_page = NULL;
+			}
+
+			input_vtl.as_uint8 = 0;
+			(void)hv_call_unmap_vp_state_page(partition->pt_id,
+							  vp->vp_index,
+							  HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
+							  input_vtl);
+			vp->vp_intercept_msg_page = NULL;
+
+			if (vp->vp_ghcb_page) {
+				input_vtl.use_target_vtl = 1;
+				input_vtl.target_vtl = HV_NORMAL_VTL;
+				(void)hv_call_unmap_vp_state_page(partition->pt_id,
+								  vp->vp_index,
+								  HV_VP_STATE_PAGE_GHCB,
+								  input_vtl);
+				vp->vp_ghcb_page = NULL;
+			}
+
+			kfree(vp);
+
+			partition->pt_vp_array[i] = NULL;
+		}
+
+		/* Deallocates and unmaps everything including vcpus, GPA mappings etc */
+		hv_call_finalize_partition(partition->pt_id);
+
+		partition->pt_initialized = false;
+	}
+
+	remove_partition(partition);
+
+	/* Remove regions, regain access to the memory and unpin the pages */
+	hlist_for_each_entry_safe(region, n, &partition->pt_mem_regions,
+				  hnode) {
+		hlist_del(&region->hnode);
+
+		if (mshv_partition_encrypted(partition)) {
+			ret = mshv_partition_region_share(region);
+			if (ret) {
+				pt_err(partition,
+				       "Failed to regain access to memory, unpinning user pages will fail and crash the host error: %d\n",
+				      ret);
+				return;
+			}
+		}
+
+		mshv_region_evict(region);
+
+		vfree(region);
+	}
+
+	/* Withdraw and free all pages we deposited */
+	hv_call_withdraw_memory(U64_MAX, NUMA_NO_NODE, partition->pt_id);
+	hv_call_delete_partition(partition->pt_id);
+
+	mshv_free_routing_table(partition);
+	kfree(partition);
+}
+
+struct
+mshv_partition *mshv_partition_get(struct mshv_partition *partition)
+{
+	if (refcount_inc_not_zero(&partition->pt_ref_count))
+		return partition;
+	return NULL;
+}
+
+struct
+mshv_partition *mshv_partition_find(u64 partition_id)
+	__must_hold(RCU)
+{
+	struct mshv_partition *p;
+
+	hash_for_each_possible_rcu(mshv_root.pt_htable, p, pt_hnode,
+				   partition_id)
+		if (p->pt_id == partition_id)
+			return p;
+
+	return NULL;
+}
+
+void
+mshv_partition_put(struct mshv_partition *partition)
+{
+	if (refcount_dec_and_test(&partition->pt_ref_count))
+		destroy_partition(partition);
+}
+
+static int
+mshv_partition_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_partition *partition = filp->private_data;
+
+	mshv_eventfd_release(partition);
+
+	cleanup_srcu_struct(&partition->pt_irq_srcu);
+
+	mshv_partition_put(partition);
+
+	return 0;
+}
+
+static int
+add_partition(struct mshv_partition *partition)
+{
+	spin_lock(&mshv_root.pt_ht_lock);
+
+	hash_add_rcu(mshv_root.pt_htable, &partition->pt_hnode,
+		     partition->pt_id);
+
+	spin_unlock(&mshv_root.pt_ht_lock);
+
+	return 0;
+}
+
+static long
+mshv_ioctl_create_partition(void __user *user_arg, struct device *module_dev)
+{
+	struct mshv_create_partition args;
+	u64 creation_flags;
+	struct hv_partition_creation_properties creation_properties = {};
+	union hv_partition_isolation_properties isolation_properties = {};
+	struct mshv_partition *partition;
+	struct file *file;
+	int fd;
+	long ret;
+
+	if (copy_from_user(&args, user_arg, sizeof(args)))
+		return -EFAULT;
+
+	if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
+	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
+		return -EINVAL;
+
+	/* Only support EXO partitions */
+	creation_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
+			 HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
+
+	if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
+		creation_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
+	if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
+		creation_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
+	if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
+		creation_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
+
+	switch (args.pt_isolation) {
+	case MSHV_PT_ISOLATION_NONE:
+		isolation_properties.isolation_type =
+			HV_PARTITION_ISOLATION_TYPE_NONE;
+		break;
+	}
+
+	partition = kzalloc(sizeof(*partition), GFP_KERNEL);
+	if (!partition)
+		return -ENOMEM;
+
+	partition->pt_module_dev = module_dev;
+	partition->isolation_type = isolation_properties.isolation_type;
+
+	refcount_set(&partition->pt_ref_count, 1);
+
+	mutex_init(&partition->pt_mutex);
+
+	mutex_init(&partition->pt_irq_lock);
+
+	init_completion(&partition->async_hypercall);
+
+	INIT_HLIST_HEAD(&partition->irq_ack_notifier_list);
+
+	INIT_HLIST_HEAD(&partition->pt_devices);
+
+	INIT_HLIST_HEAD(&partition->pt_mem_regions);
+
+	mshv_eventfd_init(partition);
+
+	ret = init_srcu_struct(&partition->pt_irq_srcu);
+	if (ret)
+		goto free_partition;
+
+	ret = hv_call_create_partition(creation_flags,
+				       creation_properties,
+				       isolation_properties,
+				       &partition->pt_id);
+	if (ret)
+		goto cleanup_irq_srcu;
+
+	ret = add_partition(partition);
+	if (ret)
+		goto delete_partition;
+
+	ret = mshv_init_async_handler(partition);
+	if (ret)
+		goto remove_partition;
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		ret = fd;
+		goto remove_partition;
+	}
+
+	file = anon_inode_getfile("mshv_partition", &mshv_partition_fops,
+				  partition, O_RDWR);
+	if (IS_ERR(file)) {
+		ret = PTR_ERR(file);
+		goto put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+
+put_fd:
+	put_unused_fd(fd);
+remove_partition:
+	remove_partition(partition);
+delete_partition:
+	hv_call_delete_partition(partition->pt_id);
+cleanup_irq_srcu:
+	cleanup_srcu_struct(&partition->pt_irq_srcu);
+free_partition:
+	kfree(partition);
+
+	return ret;
+}
+
+static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
+			   unsigned long arg)
+{
+	struct miscdevice *misc = filp->private_data;
+
+	switch (ioctl) {
+	case MSHV_CREATE_PARTITION:
+		return mshv_ioctl_create_partition((void __user *)arg,
+						misc->this_device);
+	}
+
+	return -ENOTTY;
+}
+
+static int
+mshv_dev_open(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int
+mshv_dev_release(struct inode *inode, struct file *filp)
+{
+	return 0;
+}
+
+static int mshv_cpuhp_online;
+static int mshv_root_sched_online;
+
+static const char *scheduler_type_to_string(enum hv_scheduler_type type)
+{
+	switch (type) {
+	case HV_SCHEDULER_TYPE_LP:
+		return "classic scheduler without SMT";
+	case HV_SCHEDULER_TYPE_LP_SMT:
+		return "classic scheduler with SMT";
+	case HV_SCHEDULER_TYPE_CORE_SMT:
+		return "core scheduler";
+	case HV_SCHEDULER_TYPE_ROOT:
+		return "root scheduler";
+	default:
+		return "unknown scheduler";
+	};
+}
+
+/* TODO move this to hv_common.c when needed outside */
+static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
+{
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	memset(output, 0, sizeof(*output));
+	input->property_id = HV_SYSTEM_PROPERTY_SCHEDULER_TYPE;
+
+	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		pr_err("%s: %s\n", __func__, hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	*out = output->scheduler_type;
+	local_irq_restore(flags);
+
+	return 0;
+}
+
+/* Retrieve and stash the supported scheduler type */
+static int __init mshv_retrieve_scheduler_type(struct device *dev)
+{
+	int ret;
+
+	ret = hv_retrieve_scheduler_type(&hv_scheduler_type);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "Hypervisor using %s\n",
+		 scheduler_type_to_string(hv_scheduler_type));
+
+	switch (hv_scheduler_type) {
+	case HV_SCHEDULER_TYPE_CORE_SMT:
+	case HV_SCHEDULER_TYPE_LP_SMT:
+	case HV_SCHEDULER_TYPE_ROOT:
+	case HV_SCHEDULER_TYPE_LP:
+		/* Supported scheduler, nothing to do */
+		break;
+	default:
+		dev_err(dev, "unsupported scheduler 0x%x, bailing.\n",
+			hv_scheduler_type);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int mshv_root_scheduler_init(unsigned int cpu)
+{
+	void **inputarg, **outputarg, *p;
+
+	inputarg = (void **)this_cpu_ptr(root_scheduler_input);
+	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
+
+	/* Allocate two consecutive pages. One for input, one for output. */
+	p = kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+
+	*inputarg = p;
+	*outputarg = (char *)p + HV_HYP_PAGE_SIZE;
+
+	return 0;
+}
+
+static int mshv_root_scheduler_cleanup(unsigned int cpu)
+{
+	void *p, **inputarg, **outputarg;
+
+	inputarg = (void **)this_cpu_ptr(root_scheduler_input);
+	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
+
+	p = *inputarg;
+
+	*inputarg = NULL;
+	*outputarg = NULL;
+
+	kfree(p);
+
+	return 0;
+}
+
+/* Must be called after retrieving the scheduler type */
+static int
+root_scheduler_init(struct device *dev)
+{
+	int ret;
+
+	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT)
+		return 0;
+
+	root_scheduler_input = alloc_percpu(void *);
+	root_scheduler_output = alloc_percpu(void *);
+
+	if (!root_scheduler_input || !root_scheduler_output) {
+		dev_err(dev, "Failed to allocate root scheduler buffers\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_root_sched",
+				mshv_root_scheduler_init,
+				mshv_root_scheduler_cleanup);
+
+	if (ret < 0) {
+		dev_err(dev, "Failed to setup root scheduler state: %i\n", ret);
+		goto out;
+	}
+
+	mshv_root_sched_online = ret;
+
+	return 0;
+
+out:
+	free_percpu(root_scheduler_input);
+	free_percpu(root_scheduler_output);
+	return ret;
+}
+
+static void
+root_scheduler_deinit(void)
+{
+	if (hv_scheduler_type != HV_SCHEDULER_TYPE_ROOT)
+		return;
+
+	cpuhp_remove_state(mshv_root_sched_online);
+	free_percpu(root_scheduler_input);
+	free_percpu(root_scheduler_output);
+}
+
+static int mshv_reboot_notify(struct notifier_block *nb,
+			      unsigned long code, void *unused)
+{
+	cpuhp_remove_state(mshv_cpuhp_online);
+	return 0;
+}
+
+struct notifier_block mshv_reboot_nb = {
+	.notifier_call = mshv_reboot_notify,
+};
+
+static void mshv_root_partition_exit(void)
+{
+	unregister_reboot_notifier(&mshv_reboot_nb);
+	root_scheduler_deinit();
+}
+
+static int __init mshv_root_partition_init(struct device *dev)
+{
+	int err;
+
+	if (mshv_retrieve_scheduler_type(dev))
+		return -ENODEV;
+
+	err = root_scheduler_init(dev);
+	if (err)
+		return err;
+
+	err = register_reboot_notifier(&mshv_reboot_nb);
+	if (err)
+		goto root_sched_deinit;
+
+	return 0;
+
+root_sched_deinit:
+	root_scheduler_deinit();
+	return err;
+}
+
+static int __init mshv_parent_partition_init(void)
+{
+	int ret;
+	struct device *dev;
+	union hv_hypervisor_version_info version_info;
+
+	if (!hv_root_partition() || is_kdump_kernel())
+		return -ENODEV;
+
+	if (hv_get_hypervisor_version(&version_info))
+		return -ENODEV;
+
+	ret = misc_register(&mshv_dev);
+	if (ret)
+		return ret;
+
+	dev = mshv_dev.this_device;
+
+	if (version_info.build_number < MSHV_HV_MIN_VERSION ||
+	    version_info.build_number > MSHV_HV_MAX_VERSION) {
+		dev_err(dev, "Running on unvalidated Hyper-V version\n");
+		dev_err(dev, "Versions: current: %u  min: %u  max: %u\n",
+			version_info.build_number, MSHV_HV_MIN_VERSION,
+			MSHV_HV_MAX_VERSION);
+	}
+
+	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
+	if (!mshv_root.synic_pages) {
+		dev_err(dev, "Failed to allocate percpu synic page\n");
+		ret = -ENOMEM;
+		goto device_deregister;
+	}
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
+				mshv_synic_init,
+				mshv_synic_cleanup);
+	if (ret < 0) {
+		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
+		goto free_synic_pages;
+	}
+
+	mshv_cpuhp_online = ret;
+
+	ret = mshv_root_partition_init(dev);
+	if (ret)
+		goto remove_cpu_state;
+
+	ret = mshv_irqfd_wq_init();
+	if (ret)
+		goto exit_partition;
+
+	spin_lock_init(&mshv_root.pt_ht_lock);
+	hash_init(mshv_root.pt_htable);
+
+	hv_setup_mshv_handler(mshv_isr);
+
+	return 0;
+
+exit_partition:
+	if (hv_root_partition())
+		mshv_root_partition_exit();
+remove_cpu_state:
+	cpuhp_remove_state(mshv_cpuhp_online);
+free_synic_pages:
+	free_percpu(mshv_root.synic_pages);
+device_deregister:
+	misc_deregister(&mshv_dev);
+	return ret;
+}
+
+static void __exit mshv_parent_partition_exit(void)
+{
+	hv_setup_mshv_handler(NULL);
+	mshv_port_table_fini();
+	misc_deregister(&mshv_dev);
+	mshv_irqfd_wq_cleanup();
+	if (hv_root_partition())
+		mshv_root_partition_exit();
+	cpuhp_remove_state(mshv_cpuhp_online);
+	free_percpu(mshv_root.synic_pages);
+}
+
+module_init(mshv_parent_partition_init);
+module_exit(mshv_parent_partition_exit);
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
new file mode 100644
index 000000000000..a3daedd680ff
--- /dev/null
+++ b/drivers/hv/mshv_synic.c
@@ -0,0 +1,665 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023, Microsoft Corporation.
+ *
+ * mshv_root module's main interrupt handler and associated functionality.
+ *
+ * Authors: Microsoft Linux virtualization team
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/random.h>
+#include <asm/mshyperv.h>
+
+#include "mshv_eventfd.h"
+#include "mshv.h"
+
+static u32 synic_event_ring_get_queued_port(u32 sint_index)
+{
+	struct hv_synic_event_ring_page **event_ring_page;
+	volatile struct hv_synic_event_ring *ring;
+	struct hv_synic_pages *spages;
+	u8 **synic_eventring_tail;
+	u32 message;
+	u8 tail;
+
+	spages = this_cpu_ptr(mshv_root.synic_pages);
+	event_ring_page = &spages->synic_event_ring_page;
+	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+
+	if (unlikely(!*synic_eventring_tail)) {
+		pr_debug("Missing synic event ring tail!\n");
+		return 0;
+	}
+	tail = (*synic_eventring_tail)[sint_index];
+
+	if (unlikely(!*event_ring_page)) {
+		pr_debug("Missing synic event ring page!\n");
+		return 0;
+	}
+
+	ring = &(*event_ring_page)->sint_event_ring[sint_index];
+
+	/*
+	 * Get the message.
+	 */
+	message = ring->data[tail];
+
+	if (!message) {
+		if (ring->ring_full) {
+			/*
+			 * Ring is marked full, but we would have consumed all
+			 * the messages. Notify the hypervisor that ring is now
+			 * empty and check again.
+			 */
+			ring->ring_full = 0;
+			hv_call_notify_port_ring_empty(sint_index);
+			message = ring->data[tail];
+		}
+
+		if (!message) {
+			ring->signal_masked = 0;
+			/*
+			 * Unmask the signal and sync with hypervisor
+			 * before one last check for any message.
+			 */
+			mb();
+			message = ring->data[tail];
+
+			/*
+			 * Ok, lets bail out.
+			 */
+			if (!message)
+				return 0;
+		}
+
+		ring->signal_masked = 1;
+	}
+
+	/*
+	 * Clear the message in the ring buffer.
+	 */
+	ring->data[tail] = 0;
+
+	if (++tail == HV_SYNIC_EVENT_RING_MESSAGE_COUNT)
+		tail = 0;
+
+	(*synic_eventring_tail)[sint_index] = tail;
+
+	return message;
+}
+
+static bool
+mshv_doorbell_isr(struct hv_message *msg)
+{
+	struct hv_notification_message_payload *notification;
+	u32 port;
+
+	if (msg->header.message_type != HVMSG_SYNIC_SINT_INTERCEPT)
+		return false;
+
+	notification = (struct hv_notification_message_payload *)msg->u.payload;
+	if (notification->sint_index != HV_SYNIC_DOORBELL_SINT_INDEX)
+		return false;
+
+	while ((port = synic_event_ring_get_queued_port(HV_SYNIC_DOORBELL_SINT_INDEX))) {
+		struct port_table_info ptinfo = { 0 };
+
+		if (mshv_portid_lookup(port, &ptinfo)) {
+			pr_debug("Failed to get port info from port_table!\n");
+			continue;
+		}
+
+		if (ptinfo.hv_port_type != HV_PORT_TYPE_DOORBELL) {
+			pr_debug("Not a doorbell port!, port: %d, port_type: %d\n",
+				 port, ptinfo.hv_port_type);
+			continue;
+		}
+
+		/* Invoke the callback */
+		ptinfo.hv_port_doorbell.doorbell_cb(port,
+						 ptinfo.hv_port_doorbell.data);
+	}
+
+	return true;
+}
+
+static bool mshv_async_call_completion_isr(struct hv_message *msg)
+{
+	bool handled = false;
+	struct hv_async_completion_message_payload *async_msg;
+	struct mshv_partition *partition;
+	u64 partition_id;
+
+	if (msg->header.message_type != HVMSG_ASYNC_CALL_COMPLETION)
+		goto out;
+
+	async_msg =
+		(struct hv_async_completion_message_payload *)msg->u.payload;
+
+	partition_id = async_msg->partition_id;
+
+	/*
+	 * Hold this lock for the rest of the isr, because the partition could
+	 * be released anytime.
+	 * e.g. the MSHV_RUN_VP thread could wake on another cpu; it could
+	 * release the partition unless we hold this!
+	 */
+	rcu_read_lock();
+
+	partition = mshv_partition_find(partition_id);
+	partition->async_hypercall_status = async_msg->status;
+
+	if (unlikely(!partition)) {
+		pr_debug("failed to find partition %llu\n", partition_id);
+		goto unlock_out;
+	}
+
+	complete(&partition->async_hypercall);
+
+	handled = true;
+
+unlock_out:
+	rcu_read_unlock();
+out:
+	return handled;
+}
+
+static void kick_vp(struct mshv_vp *vp)
+{
+	atomic64_inc(&vp->run.vp_signaled_count);
+	vp->run.kicked_by_hv = 1;
+	wake_up(&vp->run.vp_suspend_queue);
+}
+
+static void
+handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_message *msg)
+{
+	int bank_idx, vps_signaled = 0, bank_mask_size;
+	struct mshv_partition *partition;
+	const struct hv_vpset *vpset;
+	const u64 *bank_contents;
+	u64 partition_id = msg->partition_id;
+
+	if (msg->vp_bitset.bitset.format != HV_GENERIC_SET_SPARSE_4K) {
+		pr_debug("scheduler message format is not HV_GENERIC_SET_SPARSE_4K");
+		return;
+	}
+
+	if (msg->vp_count == 0) {
+		pr_debug("scheduler message with no VP specified");
+		return;
+	}
+
+	rcu_read_lock();
+
+	partition = mshv_partition_find(partition_id);
+	if (unlikely(!partition)) {
+		pr_debug("failed to find partition %llu\n", partition_id);
+		goto unlock_out;
+	}
+
+	vpset = &msg->vp_bitset.bitset;
+
+	bank_idx = -1;
+	bank_contents = vpset->bank_contents;
+	bank_mask_size = sizeof(vpset->valid_bank_mask) * BITS_PER_BYTE;
+
+	while (true) {
+		int vp_bank_idx = -1;
+		int vp_bank_size = sizeof(*bank_contents) * BITS_PER_BYTE;
+		int vp_index;
+
+		bank_idx = find_next_bit((unsigned long *)&vpset->valid_bank_mask,
+					 bank_mask_size, bank_idx + 1);
+		if (bank_idx == bank_mask_size)
+			break;
+
+		while (true) {
+			struct mshv_vp *vp;
+
+			vp_bank_idx = find_next_bit((unsigned long *)bank_contents,
+						    vp_bank_size, vp_bank_idx + 1);
+			if (vp_bank_idx == vp_bank_size)
+				break;
+
+			vp_index = (bank_idx << HV_GENERIC_SET_SHIFT) + vp_bank_idx;
+
+			/* This shouldn't happen, but just in case. */
+			if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+				pr_debug("VP index %u out of bounds\n",
+					 vp_index);
+				goto unlock_out;
+			}
+
+			vp = partition->pt_vp_array[vp_index];
+			if (unlikely(!vp)) {
+				pr_debug("failed to find VP %u\n", vp_index);
+				goto unlock_out;
+			}
+
+			kick_vp(vp);
+			vps_signaled++;
+		}
+
+		bank_contents++;
+	}
+
+unlock_out:
+	rcu_read_unlock();
+
+	if (vps_signaled != msg->vp_count)
+		pr_debug("asked to signal %u VPs but only did %u\n",
+			 msg->vp_count, vps_signaled);
+}
+
+static void
+handle_pair_message(const struct hv_vp_signal_pair_scheduler_message *msg)
+{
+	struct mshv_partition *partition = NULL;
+	struct mshv_vp *vp;
+	int idx;
+
+	rcu_read_lock();
+
+	for (idx = 0; idx < msg->vp_count; idx++) {
+		u64 partition_id = msg->partition_ids[idx];
+		u32 vp_index = msg->vp_indexes[idx];
+
+		if (idx == 0 || partition->pt_id != partition_id) {
+			partition = mshv_partition_find(partition_id);
+			if (unlikely(!partition)) {
+				pr_debug("failed to find partition %llu\n",
+					 partition_id);
+				break;
+			}
+		}
+
+		/* This shouldn't happen, but just in case. */
+		if (unlikely(vp_index >= MSHV_MAX_VPS)) {
+			pr_debug("VP index %u out of bounds\n", vp_index);
+			break;
+		}
+
+		vp = partition->pt_vp_array[vp_index];
+		if (!vp) {
+			pr_debug("failed to find VP %u\n", vp_index);
+			break;
+		}
+
+		kick_vp(vp);
+	}
+
+	rcu_read_unlock();
+}
+
+static bool
+mshv_scheduler_isr(struct hv_message *msg)
+{
+	if (msg->header.message_type != HVMSG_SCHEDULER_VP_SIGNAL_BITSET &&
+	    msg->header.message_type != HVMSG_SCHEDULER_VP_SIGNAL_PAIR)
+		return false;
+
+	if (msg->header.message_type == HVMSG_SCHEDULER_VP_SIGNAL_BITSET)
+		handle_bitset_message((struct hv_vp_signal_bitset_scheduler_message *)
+				      msg->u.payload);
+	else
+		handle_pair_message((struct hv_vp_signal_pair_scheduler_message *)
+				    msg->u.payload);
+
+	return true;
+}
+
+static bool
+mshv_intercept_isr(struct hv_message *msg)
+{
+	struct mshv_partition *partition;
+	bool handled = false;
+	struct mshv_vp *vp;
+	u64 partition_id;
+	u32 vp_index;
+
+	partition_id = msg->header.sender;
+
+	rcu_read_lock();
+
+	partition = mshv_partition_find(partition_id);
+	if (unlikely(!partition)) {
+		pr_debug("failed to find partition %llu\n",
+			 partition_id);
+		goto unlock_out;
+	}
+
+	if (msg->header.message_type == HVMSG_X64_APIC_EOI) {
+		/*
+		 * Check if this gsi is registered in the
+		 * ack_notifier list and invoke the callback
+		 * if registered.
+		 */
+
+		/*
+		 * If there is a notifier, the ack callback is supposed
+		 * to handle the VMEXIT. So we need not pass this message
+		 * to vcpu thread.
+		 */
+		struct hv_x64_apic_eoi_message *eoi_msg =
+			(struct hv_x64_apic_eoi_message *)&msg->u.payload[0];
+
+		if (mshv_notify_acked_gsi(partition, eoi_msg->interrupt_vector)) {
+			handled = true;
+			goto unlock_out;
+		}
+	}
+
+	/*
+	 * We should get an opaque intercept message here for all intercept
+	 * messages, since we're using the mapped VP intercept message page.
+	 *
+	 * The intercept message will have been placed in intercept message
+	 * page at this point.
+	 *
+	 * Make sure the message type matches our expectation.
+	 */
+	if (msg->header.message_type != HVMSG_OPAQUE_INTERCEPT) {
+		pr_debug("wrong message type %d", msg->header.message_type);
+		goto unlock_out;
+	}
+
+	/*
+	 * Since we directly index the vp, and it has to exist for us to be here
+	 * (because the vp is only deleted when the partition is), no additional
+	 * locking is needed here
+	 */
+	vp_index =
+	       ((struct hv_opaque_intercept_message *)msg->u.payload)->vp_index;
+	vp = partition->pt_vp_array[vp_index];
+	if (unlikely(!vp)) {
+		pr_debug("failed to find VP %u\n", vp_index);
+		goto unlock_out;
+	}
+
+	kick_vp(vp);
+
+	handled = true;
+
+unlock_out:
+	rcu_read_unlock();
+
+	return handled;
+}
+
+void mshv_isr(void)
+{
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_message *msg;
+	bool handled;
+
+	if (unlikely(!(*msg_page))) {
+		pr_debug("Missing synic page!\n");
+		return;
+	}
+
+	msg = &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
+
+	/*
+	 * If the type isn't set, there isn't really a message;
+	 * it may be some other hyperv interrupt
+	 */
+	if (msg->header.message_type == HVMSG_NONE)
+		return;
+
+	handled = mshv_doorbell_isr(msg);
+
+	if (!handled)
+		handled = mshv_scheduler_isr(msg);
+
+	if (!handled)
+		handled = mshv_async_call_completion_isr(msg);
+
+	if (!handled)
+		handled = mshv_intercept_isr(msg);
+
+	if (handled) {
+		/*
+		 * Acknowledge message with hypervisor if another message is
+		 * pending.
+		 */
+		msg->header.message_type = HVMSG_NONE;
+		/*
+		 * Ensure the write is complete so the hypervisor will deliver
+		 * the next message if available.
+		 */
+		mb();
+		if (msg->header.message_flags.msg_pending)
+			hv_set_non_nested_msr(HV_MSR_EOM, 0);
+
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+		add_interrupt_randomness(HYPERVISOR_CALLBACK_VECTOR);
+#endif
+	} else {
+		pr_warn_once("%s: unknown message type 0x%x\n", __func__,
+			     msg->header.message_type);
+	}
+}
+
+int mshv_synic_init(unsigned int cpu)
+{
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sirbp sirbp;
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+	union hv_synic_sint sint;
+#endif
+	union hv_synic_scontrol sctrl;
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_synic_event_flags_page **event_flags_page =
+			&spages->synic_event_flags_page;
+	struct hv_synic_event_ring_page **event_ring_page =
+			&spages->synic_event_ring_page;
+
+	/* Setup the Synic's message page */
+	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
+	simp.simp_enabled = true;
+	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+			     HV_HYP_PAGE_SIZE,
+			     MEMREMAP_WB);
+
+	if (!(*msg_page))
+		return -EFAULT;
+
+	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+
+	/* Setup the Synic's event flags page */
+	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
+	siefp.siefp_enabled = true;
+	*event_flags_page = memremap(siefp.base_siefp_gpa << PAGE_SHIFT,
+				     PAGE_SIZE, MEMREMAP_WB);
+
+	if (!(*event_flags_page))
+		goto cleanup;
+
+	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+
+	/* Setup the Synic's event ring page */
+	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
+	sirbp.sirbp_enabled = true;
+	*event_ring_page = memremap(sirbp.base_sirbp_gpa << PAGE_SHIFT,
+				    PAGE_SIZE, MEMREMAP_WB);
+
+	if (!(*event_ring_page))
+		goto cleanup;
+
+	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+
+#ifdef HYPERVISOR_CALLBACK_VECTOR
+	/* Enable intercepts */
+	sint.as_uint64 = 0;
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+			      sint.as_uint64);
+
+	/* Doorbell SINT */
+	sint.as_uint64 = 0;
+	sint.vector = HYPERVISOR_CALLBACK_VECTOR;
+	sint.masked = false;
+	sint.as_intercept = 1;
+	sint.auto_eoi = hv_recommend_using_aeoi();
+	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
+			      sint.as_uint64);
+#endif
+
+	/* Enable global synic bit */
+	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
+	sctrl.enable = 1;
+	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+
+	return 0;
+
+cleanup:
+	if (*event_ring_page) {
+		sirbp.sirbp_enabled = false;
+		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+		memunmap(*event_ring_page);
+	}
+	if (*event_flags_page) {
+		siefp.siefp_enabled = false;
+		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+		memunmap(*event_flags_page);
+	}
+	if (*msg_page) {
+		simp.simp_enabled = false;
+		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+		memunmap(*msg_page);
+	}
+
+	return -EFAULT;
+}
+
+int mshv_synic_cleanup(unsigned int cpu)
+{
+	union hv_synic_sint sint;
+	union hv_synic_simp simp;
+	union hv_synic_siefp siefp;
+	union hv_synic_sirbp sirbp;
+	union hv_synic_scontrol sctrl;
+	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
+	struct hv_message_page **msg_page = &spages->synic_message_page;
+	struct hv_synic_event_flags_page **event_flags_page =
+		&spages->synic_event_flags_page;
+	struct hv_synic_event_ring_page **event_ring_page =
+		&spages->synic_event_ring_page;
+
+	/* Disable the interrupt */
+	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
+	sint.masked = true;
+	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX,
+			      sint.as_uint64);
+
+	/* Disable Doorbell SINT */
+	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX);
+	sint.masked = true;
+	hv_set_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_DOORBELL_SINT_INDEX,
+			      sint.as_uint64);
+
+	/* Disable Synic's event ring page */
+	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
+	sirbp.sirbp_enabled = false;
+	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
+	memunmap(*event_ring_page);
+
+	/* Disable Synic's event flags page */
+	siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
+	siefp.siefp_enabled = false;
+	hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
+	memunmap(*event_flags_page);
+
+	/* Disable Synic's message page */
+	simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
+	simp.simp_enabled = false;
+	hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
+	memunmap(*msg_page);
+
+	/* Disable global synic bit */
+	sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
+	sctrl.enable = 0;
+	hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
+
+	return 0;
+}
+
+int
+mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb, void *data,
+		       u64 gpa, u64 val, u64 flags)
+{
+	struct hv_connection_info connection_info = { 0 };
+	union hv_connection_id connection_id = { 0 };
+	struct port_table_info *port_table_info;
+	struct hv_port_info port_info = { 0 };
+	union hv_port_id port_id = { 0 };
+	int ret;
+
+	port_table_info = kmalloc(sizeof(*port_table_info), GFP_KERNEL);
+	if (!port_table_info)
+		return -ENOMEM;
+
+	port_table_info->hv_port_type = HV_PORT_TYPE_DOORBELL;
+	port_table_info->hv_port_doorbell.doorbell_cb = doorbell_cb;
+	port_table_info->hv_port_doorbell.data = data;
+	ret = mshv_portid_alloc(port_table_info);
+	if (ret < 0) {
+		kfree(port_table_info);
+		return ret;
+	}
+
+	port_id.u.id = ret;
+	port_info.port_type = HV_PORT_TYPE_DOORBELL;
+	port_info.doorbell_port_info.target_sint = HV_SYNIC_DOORBELL_SINT_INDEX;
+	port_info.doorbell_port_info.target_vp = HV_ANY_VP;
+	ret = hv_call_create_port(hv_current_partition_id, port_id, partition_id,
+				  &port_info,
+				  0, 0, NUMA_NO_NODE);
+
+	if (ret < 0) {
+		mshv_portid_free(port_id.u.id);
+		return ret;
+	}
+
+	connection_id.u.id = port_id.u.id;
+	connection_info.port_type = HV_PORT_TYPE_DOORBELL;
+	connection_info.doorbell_connection_info.gpa = gpa;
+	connection_info.doorbell_connection_info.trigger_value = val;
+	connection_info.doorbell_connection_info.flags = flags;
+
+	ret = hv_call_connect_port(hv_current_partition_id, port_id, partition_id,
+				   connection_id, &connection_info, 0, NUMA_NO_NODE);
+	if (ret < 0) {
+		hv_call_delete_port(hv_current_partition_id, port_id);
+		mshv_portid_free(port_id.u.id);
+		return ret;
+	}
+
+	// lets use the port_id as the doorbell_id
+	return port_id.u.id;
+}
+
+void
+mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
+{
+	union hv_port_id port_id = { 0 };
+	union hv_connection_id connection_id = { 0 };
+
+	connection_id.u.id = doorbell_portid;
+	hv_call_disconnect_port(partition_id, connection_id);
+
+	port_id.u.id = doorbell_portid;
+	hv_call_delete_port(hv_current_partition_id, port_id);
+
+	mshv_portid_free(doorbell_portid);
+}
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
new file mode 100644
index 000000000000..9468f66c5658
--- /dev/null
+++ b/include/uapi/linux/mshv.h
@@ -0,0 +1,287 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interfaces for /dev/mshv* devices and derived fds
+ *
+ * This file is divided into sections containing data structures and IOCTLs for
+ * a particular set of related devices or derived file descriptors.
+ *
+ * The IOCTL definitions are at the end of each section. They are grouped by
+ * device/fd, so that new IOCTLs can easily be added with a monotonically
+ * increasing number.
+ */
+#ifndef _UAPI_LINUX_MSHV_H
+#define _UAPI_LINUX_MSHV_H
+
+#include <linux/types.h>
+
+#define MSHV_IOCTL	0xB8
+
+/*
+ *******************************************
+ * Entry point to main VMM APIs: /dev/mshv *
+ *******************************************
+ */
+
+enum {
+	MSHV_PT_BIT_LAPIC,
+	MSHV_PT_BIT_X2APIC,
+	MSHV_PT_BIT_GPA_SUPER_PAGES,
+	MSHV_PT_BIT_COUNT,
+};
+
+#define MSHV_PT_FLAGS_MASK ((1 << MSHV_PT_BIT_COUNT) - 1)
+
+enum {
+	MSHV_PT_ISOLATION_NONE,
+	MSHV_PT_ISOLATION_COUNT,
+};
+
+/**
+ * struct mshv_create_partition - arguments for MSHV_CREATE_PARTITION
+ * @pt_flags: Bitmask of 1 << MSHV_PT_BIT_*
+ * @pt_isolation: MSHV_PT_ISOLATION_*
+ *
+ * Returns a file descriptor to act as a handle to a guest partition.
+ * At this point the partition is not yet initialized in the hypervisor.
+ * Some operations must be done with the partition in this state, e.g. setting
+ * so-called "early" partition properties. The partition can then be
+ * initialized with MSHV_INITIALIZE_PARTITION.
+ */
+struct mshv_create_partition {
+	__u64 pt_flags;
+	__u64 pt_isolation;
+};
+
+/* /dev/mshv */
+#define MSHV_CREATE_PARTITION	_IOW(MSHV_IOCTL, 0x00, struct mshv_create_partition)
+
+/*
+ ************************
+ * Child partition APIs *
+ ************************
+ */
+
+struct mshv_create_vp {
+	__u32 vp_index;
+};
+
+enum {
+	MSHV_SET_MEM_BIT_WRITABLE,
+	MSHV_SET_MEM_BIT_EXECUTABLE,
+	MSHV_SET_MEM_BIT_UNMAP,
+	MSHV_SET_MEM_BIT_COUNT
+};
+
+#define MSHV_SET_MEM_FLAGS_MASK ((1 << MSHV_SET_MEM_BIT_COUNT) - 1)
+
+/**
+ * struct mshv_user_mem_region - arguments for MSHV_SET_GUEST_MEMORY
+ * @size: Size of the memory region (bytes). Must be aligned to PAGE_SIZE
+ * @guest_pfn: Base guest page number to map
+ * @userspace_addr: Base address of userspace memory. Must be aligned to
+ *                  PAGE_SIZE
+ * @flags: Bitmask of 1 << MSHV_SET_MEM_BIT_*. If (1 << MSHV_SET_MEM_BIT_UNMAP)
+ *         is set, ignore other bits.
+ * @rsvd: MBZ
+ *
+ * Map or unmap a region of userspace memory to Guest Physical Addresses (GPA).
+ * Mappings can't overlap in GPA space or userspace.
+ * To unmap, these fields must match an existing mapping.
+ */
+struct mshv_user_mem_region {
+	__u64 size;
+	__u64 guest_pfn;
+	__u64 userspace_addr;
+	__u8 flags;
+	__u8 rsvd[7];
+};
+
+enum {
+	MSHV_IRQFD_BIT_DEASSIGN,
+	MSHV_IRQFD_BIT_RESAMPLE,
+	MSHV_IRQFD_BIT_COUNT,
+};
+
+#define MSHV_IRQFD_FLAGS_MASK	((1 << MSHV_IRQFD_BIT_COUNT) - 1)
+
+struct mshv_user_irqfd {
+	__s32 fd;
+	__s32 resamplefd;
+	__u32 gsi;
+	__u32 flags;
+};
+
+enum {
+	MSHV_IOEVENTFD_BIT_DATAMATCH,
+	MSHV_IOEVENTFD_BIT_PIO,
+	MSHV_IOEVENTFD_BIT_DEASSIGN,
+	MSHV_IOEVENTFD_BIT_COUNT,
+};
+
+#define MSHV_IOEVENTFD_FLAGS_MASK	((1 << MSHV_IOEVENTFD_BIT_COUNT) - 1)
+
+struct mshv_user_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;	   /* legal pio/mmio address */
+	__u32 len;	   /* 1, 2, 4, or 8 bytes    */
+	__s32 fd;
+	__u32 flags;
+	__u8  rsvd[4];
+};
+
+struct mshv_user_irq_entry {
+	__u32 gsi;
+	__u32 address_lo;
+	__u32 address_hi;
+	__u32 data;
+};
+
+struct mshv_user_irq_table {
+	__u32 nr;
+	__u32 rsvd; /* MBZ */
+	struct mshv_user_irq_entry entries[];
+};
+
+enum {
+	MSHV_GPAP_ACCESS_TYPE_ACCESSED = 0,
+	MSHV_GPAP_ACCESS_TYPE_DIRTY,
+	MSHV_GPAP_ACCESS_TYPE_COUNT		/* Count of enum members */
+};
+
+enum {
+	MSHV_GPAP_ACCESS_OP_NOOP = 0,
+	MSHV_GPAP_ACCESS_OP_CLEAR,
+	MSHV_GPAP_ACCESS_OP_SET,
+	MSHV_GPAP_ACCESS_OP_COUNT		/* Count of enum members */
+};
+
+/**
+ * struct mshv_gpap_access_bitmap - arguments for MSHV_GET_GPAP_ACCESS_BITMAP
+ * @access_type: MSHV_GPAP_ACCESS_TYPE_* - The type of access to record in the
+ *               bitmap
+ * @access_op: MSHV_GPAP_ACCESS_OP_* - Allows an optional clear or set of all
+ *             the access states in the range, after retrieving the current
+ *             states.
+ * @rsvd: MBZ
+ * @page_count: in: number of pages
+ *              out: on error, number of states successfully written to bitmap
+ * @gpap_base: Base gpa page number
+ * @bitmap_ptr: Output buffer for bitmap, at least (page_count + 7) / 8 bytes
+ *
+ * Retrieve a bitmap of either ACCESSED or DIRTY bits for a given range of guest
+ * memory, and optionally clear or set the bits.
+ */
+struct mshv_gpap_access_bitmap {
+	__u8 access_type;
+	__u8 access_op;
+	__u8 rsvd[6];
+	__u64 page_count;
+	__u64 gpap_base;
+	__u64 bitmap_ptr;
+};
+
+/**
+ * struct mshv_root_hvcall - arguments for MSHV_ROOT_HVCALL
+ * @code: Hypercall code (HVCALL_*)
+ * @reps: in: Rep count ('repcount')
+ *	  out: Reps completed ('repcomp'). MBZ unless rep hvcall
+ * @in_sz: Size of input incl rep data. <= HV_HYP_PAGE_SIZE
+ * @out_sz: Size of output buffer. <= HV_HYP_PAGE_SIZE. MBZ if out_ptr is 0
+ * @status: in: MBZ
+ *	    out: HV_STATUS_* from hypercall
+ * @rsvd: MBZ
+ * @in_ptr: Input data buffer (struct hv_input_*). If used with partition or
+ *	    vp fd, partition id field is populated by kernel.
+ * @out_ptr: Output data buffer (optional)
+ */
+struct mshv_root_hvcall {
+	__u16 code;
+	__u16 reps;
+	__u16 in_sz;
+	__u16 out_sz;
+	__u16 status;
+	__u8 rsvd[6];
+	__u64 in_ptr;
+	__u64 out_ptr;
+};
+
+/* Partition fds created with MSHV_CREATE_PARTITION */
+#define MSHV_INITIALIZE_PARTITION	_IO(MSHV_IOCTL, 0x00)
+#define MSHV_CREATE_VP			_IOW(MSHV_IOCTL, 0x01, struct mshv_create_vp)
+#define MSHV_SET_GUEST_MEMORY		_IOW(MSHV_IOCTL, 0x02, struct mshv_user_mem_region)
+#define MSHV_IRQFD			_IOW(MSHV_IOCTL, 0x03, struct mshv_user_irqfd)
+#define MSHV_IOEVENTFD			_IOW(MSHV_IOCTL, 0x04, struct mshv_user_ioeventfd)
+#define MSHV_SET_MSI_ROUTING		_IOW(MSHV_IOCTL, 0x05, struct mshv_user_irq_table)
+#define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_gpap_access_bitmap)
+/* Generic hypercall */
+#define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+
+/*
+ ********************************
+ * VP APIs for child partitions *
+ ********************************
+ */
+
+#define MSHV_RUN_VP_BUF_SZ 256
+
+/*
+ * Map various VP state pages to userspace.
+ * Multiply the offset by PAGE_SIZE before being passed as the 'offset'
+ * argument to mmap().
+ * e.g.
+ * void *reg_page = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
+ *                       MAP_SHARED, vp_fd,
+ *                       MSHV_VP_MMAP_OFFSET_REGISTERS * PAGE_SIZE);
+ */
+enum {
+	MSHV_VP_MMAP_OFFSET_REGISTERS,
+	MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE,
+	MSHV_VP_MMAP_OFFSET_GHCB,
+	MSHV_VP_MMAP_OFFSET_COUNT
+};
+
+/**
+ * struct mshv_run_vp - argument for MSHV_RUN_VP
+ * @msg_buf: On success, the intercept message is copied here. It can be
+ *           interpreted using the relevant hypervisor definitions.
+ */
+struct mshv_run_vp {
+	__u8 msg_buf[MSHV_RUN_VP_BUF_SZ];
+};
+
+enum {
+	MSHV_VP_STATE_LAPIC,		/* Local interrupt controller state (either arch) */
+	MSHV_VP_STATE_XSAVE,		/* XSAVE data in compacted form (x86_64) */
+	MSHV_VP_STATE_SIMP,
+	MSHV_VP_STATE_SIEFP,
+	MSHV_VP_STATE_SYNTHETIC_TIMERS,
+	MSHV_VP_STATE_COUNT,
+};
+
+/**
+ * struct mshv_get_set_vp_hvcall - arguments for MSHV_[GET,SET]_VP_STATE
+ * @type: MSHV_VP_STATE_*
+ * @rsvd: MBZ
+ * @buf_sz: in: 4k page-aligned size of buffer
+ *          out: Actual size of data (on EINVAL, check this to see if buffer
+ *               was too small)
+ * @buf_ptr: 4k page-aligned data buffer
+ */
+struct mshv_get_set_vp_state {
+	__u8 type;
+	__u8 rsvd[3];
+	__u32 buf_sz;
+	__u64 buf_ptr;
+};
+
+/* VP fds created with MSHV_CREATE_VP */
+#define MSHV_RUN_VP			_IOR(MSHV_IOCTL, 0x00, struct mshv_run_vp)
+#define MSHV_GET_VP_STATE		_IOWR(MSHV_IOCTL, 0x01, struct mshv_get_set_vp_state)
+#define MSHV_SET_VP_STATE		_IOWR(MSHV_IOCTL, 0x02, struct mshv_get_set_vp_state)
+/*
+ * Generic hypercall
+ * Defined above in partition IOCTLs, avoid redefining it here
+ * #define MSHV_ROOT_HVCALL			_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcall)
+ */
+
+#endif
-- 
2.34.1


