Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAA6700234
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 10:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240262AbjELIFk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 04:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240406AbjELIEv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 04:04:51 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC2E11B76;
        Fri, 12 May 2023 01:04:16 -0700 (PDT)
X-UUID: 928013aef09b11ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=SZY0EaUbust7jmxOY5euJ9ZzloZigi5isqey/wvrlb4=;
        b=STFq+H0BdqC4UCnYfm5DY6xN0mbWKj7BoSxSmW8wNR3CRvE1iSriGGaY7qE0CkbIKCCNNumf0xI1moiR3mp/gtxIzxZScdNVoM/CGGVE0clGUokb4CJA5a6PrJS8au8gyUiYrpq3X2t2DPk5XvD36D2y5zIN/HTKPAsi8cbK83k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:1fbb8cba-4b29-46e7-aa69-55d4f039f503,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:178d4d4,CLOUDID:165f9a6b-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 928013aef09b11ed9cb5633481061a41-20230512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1639560628; Fri, 12 May 2023 16:04:08 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 16:04:08 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 16:04:08 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: [PATCH v3 4/7] virt: geniezone: Add vcpu support
Date:   Fri, 12 May 2023 16:04:02 +0800
Message-ID: <20230512080405.12043-5-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230512080405.12043-1-yi-de.wu@mediatek.com>
References: <20230512080405.12043-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

VMM use this interface to create vcpu instance which is a fd, and this
fd will be for any vcpu operations, such as setting vcpu registers and
accepts the most important ioctl GZVM_VCPU_RUN which requests GenieZone
hypervisor to do context switch to execute VM's vcpu context.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |   2 +-
 arch/arm64/geniezone/gzvm_arch_common.h |  24 +++
 arch/arm64/geniezone/vcpu.c             |  84 +++++++++
 arch/arm64/include/uapi/asm/gzvm_arch.h |  29 +++
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_vcpu.c      | 234 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c        |  47 +++--
 include/linux/gzvm_drv.h                |  26 ++-
 include/uapi/linux/gzvm.h               | 130 +++++++++++--
 9 files changed, 531 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/geniezone/vcpu.c
 create mode 100644 drivers/virt/geniezone/gzvm_vcpu.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 2957898cdd05..69b0a4abeab0 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o
+gzvm-y += vm.o vcpu.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index f5dde1024d52..1b315264bf24 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -62,4 +62,28 @@ static int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
 	return gz_err_to_errno(res->a0);
 }
 
+static inline gzvm_id_t get_vmid_from_tuple(unsigned int tuple)
+{
+	return (gzvm_id_t)(tuple >> 16);
+}
+
+static inline gzvm_vcpu_id_t get_vcpuid_from_tuple(unsigned int tuple)
+{
+	return (gzvm_vcpu_id_t)(tuple & 0xffff);
+}
+
+static inline unsigned int
+assemble_vm_vcpu_tuple(gzvm_id_t vmid, gzvm_vcpu_id_t vcpuid)
+{
+	return ((unsigned int)vmid << 16 | vcpuid);
+}
+
+static inline void
+disassemble_vm_vcpu_tuple(unsigned int tuple, gzvm_id_t *vmid,
+			  gzvm_vcpu_id_t *vcpuid)
+{
+	*vmid = get_vmid_from_tuple(tuple);
+	*vcpuid = get_vcpuid_from_tuple(tuple);
+}
+
 #endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vcpu.c b/arch/arm64/geniezone/vcpu.c
new file mode 100644
index 000000000000..8d2572bdf053
--- /dev/null
+++ b/arch/arm64/geniezone/vcpu.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/err.h>
+#include <linux/uaccess.h>
+
+#include <linux/gzvm.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
+				  bool is_write, __u64 *data)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+	int ret;
+
+	/* reg id follows KVM's encoding */
+	switch (reg_id & GZVM_REG_ARM_COPROC_MASK) {
+	case GZVM_REG_ARM_CORE:
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	if (!is_write) {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_GET_ONE_REG,
+					   a1, reg_id, 0, 0, 0, 0, 0, &res);
+		if (ret == 0)
+			*data = res.a1;
+	} else {
+		ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_ONE_REG,
+					   a1, reg_id, *data, 0, 0, 0, 0, &res);
+	}
+
+	return ret;
+}
+
+int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_RUN, a1, 0, 0, 0, 0, 0,
+				   0, &res);
+	*exit_reason = res.a1;
+	return ret;
+}
+
+int gzvm_arch_destroy_vcpu(gzvm_id_t vm_id, int vcpuid)
+{
+	struct arm_smccc_res res;
+	unsigned long a1;
+
+	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VCPU, a1, 0, 0, 0, 0, 0, 0,
+			     &res);
+
+	return 0;
+}
+
+/**
+ * gzvm_arch_create_vcpu() - Call smc to gz hypervisor to create vcpu
+ * @run: Virtual address of vcpu->run
+ */
+int gzvm_arch_create_vcpu(gzvm_id_t vm_id, int vcpuid, void *run)
+{
+	struct arm_smccc_res res;
+	unsigned long a1, a2;
+	int ret;
+
+	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	a2 = (__u64)virt_to_phys(run);
+	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VCPU, a1, a2, 0, 0, 0, 0,
+				   0, &res);
+
+	return ret;
+}
diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
index e7927f3dcb11..3e66087f635f 100644
--- a/arch/arm64/include/uapi/asm/gzvm_arch.h
+++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
@@ -15,4 +15,33 @@
 #define GZVM_CAP_ARM_PVM_SET_PVMFW_IPA		0
 #define GZVM_CAP_ARM_PVM_GET_PVMFW_SIZE		1
 
+/*
+ * Architecture specific registers are to be defined in arch headers and
+ * ORed with the arch identifier.
+ */
+#define GZVM_REG_ARM		0x4000000000000000ULL
+#define GZVM_REG_ARM64		0x6000000000000000ULL
+
+#define GZVM_REG_SIZE_SHIFT	52
+#define GZVM_REG_SIZE_MASK	0x00f0000000000000ULL
+#define GZVM_REG_SIZE_U8	0x0000000000000000ULL
+#define GZVM_REG_SIZE_U16	0x0010000000000000ULL
+#define GZVM_REG_SIZE_U32	0x0020000000000000ULL
+#define GZVM_REG_SIZE_U64	0x0030000000000000ULL
+#define GZVM_REG_SIZE_U128	0x0040000000000000ULL
+#define GZVM_REG_SIZE_U256	0x0050000000000000ULL
+#define GZVM_REG_SIZE_U512	0x0060000000000000ULL
+#define GZVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define GZVM_REG_SIZE_U2048	0x0080000000000000ULL
+
+#define GZVM_REG_ARCH_MASK	0xff00000000000000ULL
+
+/* If you need to interpret the index values, here is the key: */
+#define GZVM_REG_ARM_COPROC_MASK	0x000000000FFF0000
+#define GZVM_REG_ARM_COPROC_SHIFT	16
+
+/* Normal registers are mapped as coprocessor 16. */
+#define GZVM_REG_ARM_CORE		(0x0010 << GZVM_REG_ARM_COPROC_SHIFT)
+#define GZVM_REG_ARM_CORE_REG(name)	(offsetof(struct gzvm_regs, name) / sizeof(__u32))
+
 #endif /* __GZVM_ARCH_H__ */
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 066efddc0b9c..8ebf2db0c970 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -6,5 +6,6 @@
 
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
-gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o
+gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
+	  $(GZVM_DIR)/gzvm_vcpu.o
 
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
new file mode 100644
index 000000000000..d1bb2cba1893
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <asm/sysreg.h>
+#include <linux/anon_inodes.h>
+#include <linux/device.h>
+#include <linux/file.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/gzvm_drv.h>
+
+/* maximum size needed for holding an integer */
+#define ITOA_MAX_LEN 12
+
+static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, void * __user argp,
+				     bool is_write)
+{
+	struct gzvm_one_reg reg;
+	void __user *reg_addr;
+	u64 data = 0;
+	u64 reg_size;
+	long ret;
+
+	if (copy_from_user(&reg, argp, sizeof(reg)))
+		return -EFAULT;
+
+	reg_addr = (void __user *)reg.addr;
+	reg_size = (reg.id & GZVM_REG_SIZE_MASK) >> GZVM_REG_SIZE_SHIFT;
+	reg_size = BIT(reg_size);
+
+	if (is_write) {
+		if (copy_from_user(&data, reg_addr, reg_size))
+			return -EFAULT;
+	}
+
+	ret = gzvm_arch_vcpu_update_one_reg(vcpu, reg.id, is_write, &data);
+
+	if (ret)
+		return ret;
+
+	if (!is_write) {
+		if (copy_to_user(reg_addr, &data, reg_size))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
+/**
+ * gzvm_vcpu_run() - Handle vcpu run ioctl, entry point to guest and exit
+ *		     point from guest
+ * @argp: pointer to struct gzvm_vcpu_run in userspace
+ */
+static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
+{
+	bool need_userspace = false;
+	u64 exit_reason;
+
+	if (copy_from_user(vcpu->run, argp, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+
+	if (vcpu->run->immediate_exit == 1)
+		return -EINTR;
+
+	while (!need_userspace && !signal_pending(current)) {
+		gzvm_arch_vcpu_run(vcpu, &exit_reason);
+
+		switch (exit_reason) {
+		case GZVM_EXIT_MMIO:
+			need_userspace = true;
+			break;
+		/**
+		 * it's geniezone's responsibility to fill corresponding data
+		 * structure
+		 */
+		case GZVM_EXIT_HYPERCALL:
+			fallthrough;
+		case GZVM_EXIT_EXCEPTION:
+			fallthrough;
+		case GZVM_EXIT_DEBUG:
+			fallthrough;
+		case GZVM_EXIT_FAIL_ENTRY:
+			fallthrough;
+		case GZVM_EXIT_INTERNAL_ERROR:
+			fallthrough;
+		case GZVM_EXIT_SYSTEM_EVENT:
+			fallthrough;
+		case GZVM_EXIT_SHUTDOWN:
+			need_userspace = true;
+			break;
+		case GZVM_EXIT_IRQ:
+			break;
+		case GZVM_EXIT_UNKNOWN:
+			fallthrough;
+		default:
+			dev_err(&gzvm_debug_dev->dev, "vcpu unknown exit\n");
+			need_userspace = true;
+			goto out;
+		}
+	}
+
+out:
+	if (copy_to_user(argp, vcpu->run, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+	if (signal_pending(current))
+		return -ERESTARTSYS;
+	return 0;
+}
+
+static long gzvm_vcpu_ioctl(struct file *filp, unsigned int ioctl,
+			    unsigned long arg)
+{
+	int ret = -ENOTTY;
+	void __user *argp = (void __user *)arg;
+	struct gzvm_vcpu *vcpu = filp->private_data;
+
+	switch (ioctl) {
+	case GZVM_RUN:
+		ret = gzvm_vcpu_run(vcpu, argp);
+		break;
+	case GZVM_GET_ONE_REG:
+		/* is_write */
+		ret = gzvm_vcpu_update_one_reg(vcpu, argp, false);
+		break;
+	case GZVM_SET_ONE_REG:
+		/* is_write */
+		ret = gzvm_vcpu_update_one_reg(vcpu, argp, true);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static const struct file_operations gzvm_vcpu_fops = {
+	.unlocked_ioctl = gzvm_vcpu_ioctl,
+	.llseek		= noop_llseek,
+};
+
+/* caller must hold the vm lock */
+static void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
+{
+	if (!vcpu)
+		return;
+
+	gzvm_arch_destroy_vcpu(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	/* clean guest's data */
+	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
+	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
+	kfree(vcpu);
+}
+
+/**
+ * gzvm_destroy_vcpus() - Destroy all vcpus, caller has to hold the vm lock
+ *
+ * @gzvm: vm struct that owns the vcpus
+ */
+void gzvm_destroy_vcpus(struct gzvm *gzvm)
+{
+	int i;
+
+	for (i = 0; i < GZVM_MAX_VCPUS; i++) {
+		gzvm_destroy_vcpu(gzvm->vcpus[i]);
+		gzvm->vcpus[i] = NULL;
+	}
+}
+
+/* create_vcpu_fd() - Allocates an inode for the vcpu. */
+static int create_vcpu_fd(struct gzvm_vcpu *vcpu)
+{
+	/* sizeof("gzvm-vcpu:") + max(strlen(itoa(vcpuid))) + null */
+	char name[10 + ITOA_MAX_LEN + 1];
+
+	snprintf(name, sizeof(name), "gzvm-vcpu:%d", vcpu->vcpuid);
+	return anon_inode_getfd(name, &gzvm_vcpu_fops, vcpu, O_RDWR | O_CLOEXEC);
+}
+
+/**
+ * gzvm_vm_ioctl_create_vcpu()
+ *
+ * @cpuid: equals arg
+ *
+ * Return: Fd of vcpu, negative errno if error occurs
+ */
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
+{
+	struct gzvm_vcpu *vcpu;
+	int ret;
+
+	if (cpuid >= GZVM_MAX_VCPUS)
+		return -EINVAL;
+
+	vcpu = kzalloc(sizeof(*vcpu), GFP_KERNEL);
+	if (!vcpu)
+		return -ENOMEM;
+
+	/**
+	 * Allocate 2 pages for data sharing between driver and gz hypervisor
+	 *
+	 * |- page 0           -|- page 1      -|
+	 * |gzvm_vcpu_run|......|hwstate|.......|
+	 *
+	 */
+	vcpu->run = alloc_pages_exact(GZVM_VCPU_RUN_MAP_SIZE,
+				      GFP_KERNEL_ACCOUNT | __GFP_ZERO);
+	if (!vcpu->run) {
+		ret = -ENOMEM;
+		goto free_vcpu;
+	}
+	vcpu->vcpuid = cpuid;
+	vcpu->gzvm = gzvm;
+	mutex_init(&vcpu->lock);
+
+	ret = gzvm_arch_create_vcpu(gzvm->vm_id, vcpu->vcpuid, vcpu->run);
+	if (ret < 0)
+		goto free_vcpu_run;
+
+	ret = create_vcpu_fd(vcpu);
+	if (ret < 0)
+		goto free_vcpu_run;
+	gzvm->vcpus[cpuid] = vcpu;
+
+	return ret;
+
+free_vcpu_run:
+	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
+free_vcpu:
+	kfree(vcpu);
+	return ret;
+}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 58471dd899fb..dc9992f0c68a 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -9,6 +9,7 @@
 #include <linux/kvm_host.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gzvm_drv.h>
 
@@ -59,9 +60,10 @@ static int fill_constituents(struct mem_region_addr_range *consti,
 			     int *consti_cnt, int max_nr_consti, gfn_t gfn,
 			     u32 total_pages, struct gzvm_memslot *slot)
 {
-	int i, nr_pages;
 	hfn_t pfn, prev_pfn;
 	gfn_t gfn_end;
+	int nr_pages = 1;
+	int i = 0;
 
 	if (unlikely(total_pages == 0))
 		return -EINVAL;
@@ -74,8 +76,6 @@ static int fill_constituents(struct mem_region_addr_range *consti,
 	consti[0].pg_cnt = 1;
 	gfn++;
 	prev_pfn = pfn;
-	i = 0;
-	nr_pages = 1;
 	while (i < max_nr_consti && gfn < gfn_end) {
 		if (gzvm_gfn_to_pfn_memslot(slot, gfn, &pfn) != 0)
 			return -EFAULT;
@@ -92,10 +92,10 @@ static int fill_constituents(struct mem_region_addr_range *consti,
 		gfn++;
 		nr_pages++;
 	}
-	if (i == max_nr_consti)
-		*consti_cnt = i;
-	else
-		*consti_cnt = (i + 1);
+
+	if (i != max_nr_consti)
+		i++;
+	*consti_cnt = i;
 
 	return nr_pages;
 }
@@ -105,9 +105,9 @@ static int
 register_memslot_addr_range(struct gzvm *gzvm, struct gzvm_memslot *memslot)
 {
 	struct gzvm_memory_region_ranges *region;
-	u32 buf_size;
-	int max_nr_consti, remain_pages;
 	gfn_t gfn, gfn_end;
+	int max_nr_consti, remain_pages;
+	u32 buf_size;
 
 	buf_size = PAGE_SIZE * 2;
 	region = alloc_pages_exact(buf_size, GFP_KERNEL);
@@ -206,6 +206,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
 		break;
 	}
+	case GZVM_CREATE_VCPU: {
+		ret = gzvm_vm_ioctl_create_vcpu(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -240,6 +244,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_lock(&gzvm->lock);
 
+	gzvm_destroy_vcpus(gzvm);
 	gzvm_arch_destroy_vm(gzvm->vm_id);
 
 	mutex_lock(&gzvm_list_lock);
@@ -275,8 +280,10 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(-ENOMEM);
 
 	ret = gzvm_arch_create_vm();
-	if (ret < 0)
-		goto err;
+	if (ret < 0) {
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
 
 	gzvm->vm_id = ret;
 	gzvm->mm = current->mm;
@@ -289,10 +296,6 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	pr_info("VM-%u is created\n", gzvm->vm_id);
 
 	return gzvm;
-
-err:
-	kfree(gzvm);
-	return ERR_PTR(ret);
 }
 
 /**
@@ -306,18 +309,14 @@ int gzvm_dev_ioctl_create_vm(unsigned long vm_type)
 	int ret;
 
 	gzvm = gzvm_create_vm(vm_type);
-	if (IS_ERR(gzvm)) {
-		ret = PTR_ERR(gzvm);
-		goto error;
-	}
+	if (IS_ERR(gzvm))
+		return PTR_ERR(gzvm);
 
 	ret = anon_inode_getfd("gzvm-vm", &gzvm_vm_fops, gzvm,
 			       O_RDWR | O_CLOEXEC);
-	if (ret < 0)
-		goto error;
-
-error:
-	return ret;
+	if (ret)
+		return ret;
+	return 0;
 }
 
 void destroy_all_vm(void)
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index f2cfbf87c113..5736ddf97741 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -26,18 +26,15 @@
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
 
-static inline gzvm_id_t get_vmid_from_tuple(unsigned int tuple)
-{
-	return (gzvm_id_t)(tuple >> 16);
-}
-
-/**
+/*
  * The following data structures are for data transferring between driver and
  * hypervisor, and they're aligned with hypervisor definitions
  */
 #define GZVM_MAX_VCPUS		 8
 #define GZVM_MAX_MEM_REGION	10
 
+#define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
+
 /* struct mem_region_addr_range - Identical to ffa memory constituent */
 struct mem_region_addr_range {
 	/* the base IPA of the constituent memory region, aligned to 4 kiB */
@@ -65,7 +62,16 @@ struct gzvm_memslot {
 	u32 slot_id;
 };
 
+struct gzvm_vcpu {
+	struct gzvm *gzvm;
+	int vcpuid;
+	/* lock of vcpu*/
+	struct mutex lock;
+	struct gzvm_vcpu_run *run;
+};
+
 struct gzvm {
+	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
 	/* userspace tied to this vm */
 	struct mm_struct *mm;
 	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
@@ -82,6 +88,8 @@ int gz_err_to_errno(unsigned long err);
 
 void destroy_all_vm(void);
 
+void gzvm_destroy_vcpus(struct gzvm *gzvm);
+
 /* arch-dependant functions */
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(gzvm_id_t vm_id, size_t buf_size,
@@ -92,6 +100,12 @@ int gzvm_arch_destroy_vm(gzvm_id_t vm_id);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
+int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
+				  bool is_write, __u64 *data);
+int gzvm_arch_create_vcpu(gzvm_id_t vm_id, int vcpuid, void *run);
+int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
+int gzvm_arch_destroy_vcpu(gzvm_id_t vm_id, int vcpuid);
 
 extern struct platform_device *gzvm_debug_dev;
 
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index b25ea78fe2d7..dbf74d63379b 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -3,6 +3,12 @@
  * Copyright (c) 2023 MediaTek Inc.
  */
 
+/**
+ * DOC: UAPI of GenieZone Hypervisor
+ *
+ * This file declares common data structure shared among user space,
+ * kernel space, and GenieZone hypervisor.
+ */
 #ifndef __GZVM_H__
 #define __GZVM_H__
 
@@ -12,11 +18,6 @@
 
 #include <asm/gzvm_arch.h>
 
-/**
- * DOC: This file declares common data structure shared between userspace,
- *	kernel space, and GZ.
- */
-
 typedef __u16 gzvm_id_t;
 typedef __u16 gzvm_vcpu_id_t;
 
@@ -40,26 +41,30 @@ struct gzvm_memory_region {
 
 #define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
 					struct gzvm_memory_region)
-/*
- * GZVM_CREATE_VCPU receives as a parameter the vcpu slot, and returns
- * a vcpu fd.
+/**
+ * for irqfd, GZVM_CREATE_VCPU receives as a parameter the vcpu slot,
+ * and returns a vcpu fd.
  */
 #define GZVM_CREATE_VCPU           _IO(GZVM_IOC_MAGIC,   0x41)
 
+#define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
+					struct gzvm_enable_cap)
+
 /* for GZVM_SET_USER_MEMORY_REGION */
 struct gzvm_userspace_memory_region {
 	__u32 slot;
 	__u32 flags;
 	__u64 guest_phys_addr;
-	__u64 memory_size; /* bytes */
-	__u64 userspace_addr; /* start of the userspace allocated memory */
+	/* bytes */
+	__u64 memory_size;
+	/* start of the userspace allocated memory */
+	__u64 userspace_addr;
 };
 
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					struct gzvm_userspace_memory_region)
 
-/* for GZVM_IRQ_LINE */
-/* GZVM_IRQ_LINE irq field index values */
+/* for GZVM_IRQ_LINE, irq field index values */
 #define GZVM_IRQ_VCPU2_SHIFT		28
 #define GZVM_IRQ_VCPU2_MASK		0xf
 #define GZVM_IRQ_TYPE_SHIFT		24
@@ -81,15 +86,108 @@ struct gzvm_userspace_memory_region {
 /* ioctls for vcpu fds */
 #define GZVM_RUN                   _IO(GZVM_IOC_MAGIC,   0x80)
 
+/* VM exit reason */
+enum {
+	GZVM_EXIT_UNKNOWN = 0x92920000,
+	GZVM_EXIT_MMIO,
+	GZVM_EXIT_HYPERCALL,
+	GZVM_EXIT_IRQ,
+	GZVM_EXIT_EXCEPTION,
+	GZVM_EXIT_DEBUG,
+	GZVM_EXIT_FAIL_ENTRY,
+	GZVM_EXIT_INTERNAL_ERROR,
+	GZVM_EXIT_SYSTEM_EVENT,
+	GZVM_EXIT_SHUTDOWN,
+};
+
+/**
+ * struct gzvm_cpu_run: Same purpose as kvm_run, this struct is
+ *			shared between userspace, kernel and
+ *			GenieZone hypervisor
+ *
+ * Keep identical layout between the 3 modules
+ */
+struct gzvm_vcpu_run {
+	/* to userspace */
+	__u32 exit_reason;
+	__u8 immediate_exit;
+	__u8 padding1[3];
+	/* union structure of collection of guest exit reason */
+	union {
+		/* GZVM_EXIT_MMIO */
+		struct {
+			/* from FAR_EL2 */
+			__u64 phys_addr;
+			__u8 data[8];
+			/* from ESR_EL2 as */
+			__u64 size;
+			/* from ESR_EL2 */
+			__u32 reg_nr;
+			/* from ESR_EL2 */
+			__u8 is_write;
+		} mmio;
+		/* GZVM_EXIT_FAIL_ENTRY */
+		struct {
+			__u64 hardware_entry_failure_reason;
+			__u32 cpu;
+		} fail_entry;
+		/* GZVM_EXIT_EXCEPTION */
+		struct {
+			__u32 exception;
+			__u32 error_code;
+		} exception;
+		/* GZVM_EXIT_HYPERCALL */
+		struct {
+			__u64 args[8];	/* in-out */
+		} hypercall;
+		/* GZVM_EXIT_INTERNAL_ERROR */
+		struct {
+			__u32 suberror;
+			__u32 ndata;
+			__u64 data[16];
+		} internal;
+		/* GZVM_EXIT_SYSTEM_EVENT */
+		struct {
+#define GZVM_SYSTEM_EVENT_SHUTDOWN       1
+#define GZVM_SYSTEM_EVENT_RESET          2
+#define GZVM_SYSTEM_EVENT_CRASH          3
+#define GZVM_SYSTEM_EVENT_WAKEUP         4
+#define GZVM_SYSTEM_EVENT_SUSPEND        5
+#define GZVM_SYSTEM_EVENT_SEV_TERM       6
+#define GZVM_SYSTEM_EVENT_S2IDLE         7
+			__u32 type;
+			__u32 ndata;
+			__u64 data[16];
+		} system_event;
+		/* Fix the size of the union. */
+		char padding[256];
+	};
+};
+
 /* for GZVM_ENABLE_CAP */
 struct gzvm_enable_cap {
-	/* in */
-	__u64 cap;
-	/* we have total 5 (8 - 3) registers can be used for additional args */
-	__u64 args[5];
+			 /* in */
+			__u64 cap;
+			/**
+			 * we have total 5 (8 - 3) registers can be used for
+			 * additional args
+			 */
+			 __u64 args[5];
 };
 
 #define GZVM_ENABLE_CAP            _IOW(GZVM_IOC_MAGIC,  0xa3, \
 					struct gzvm_enable_cap)
+/* for GZVM_GET/SET_ONE_REG */
+struct gzvm_one_reg {
+	__u64 id;
+	__u64 addr;
+};
+
+#define GZVM_GET_ONE_REG	   _IOW(GZVM_IOC_MAGIC,  0xab, \
+					struct gzvm_one_reg)
+#define GZVM_SET_ONE_REG	   _IOW(GZVM_IOC_MAGIC,  0xac, \
+					struct gzvm_one_reg)
+
+#define GZVM_REG_GENERIC	   0x0000000000000000ULL
 
 #endif /* __GZVM_H__ */
-- 
2.18.0

