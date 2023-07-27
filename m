Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02FD7649EA
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjG0IEG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbjG0ICy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5255A4EC0;
        Thu, 27 Jul 2023 01:00:22 -0700 (PDT)
X-UUID: 9e4a2f962c5311eeb20a276fd37b9834-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5OOJvZYewRp0q0mDAVnzzzSVH5FNYBOlKNtYiAdgrwE=;
        b=mJKzGVNnBtKpGpQsVQdi1/TIRSHbJXCucT3HWcfFNmBcGtkxVlHRmsfTBBvFdoDegTsaow6G32Wcvc1APBNczEykxpdNDzjccfBtiVQykqtbr+ueR0+fPR0+ELGfnqexHO+60HTgdupNNCcyzIsnFetVqHYythQLZj2MOZ/RVsU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:fea3ed0a-f357-4d4b-b90e-47a714896c9a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.29,REQID:fea3ed0a-f357-4d4b-b90e-47a714896c9a,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:e7562a7,CLOUDID:24a862d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:230727160015Q42B2ZOO,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 9e4a2f962c5311eeb20a276fd37b9834-20230727
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1730346221; Thu, 27 Jul 2023 16:00:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 16:00:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 16:00:13 +0800
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
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        "David Bradil" <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Ivan Tseng" <ivan.tseng@mediatek.com>,
        Jade Shih <jades.shih@mediatek.com>,
        "My Chuang" <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
Subject: [PATCH v5 04/12] virt: geniezone: Add vcpu support
Date:   Thu, 27 Jul 2023 15:59:57 +0800
Message-ID: <20230727080005.14474-5-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230727080005.14474-1-yi-de.wu@mediatek.com>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
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
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |   2 +-
 arch/arm64/geniezone/gzvm_arch_common.h |  20 ++
 arch/arm64/geniezone/vcpu.c             |  88 +++++++++
 arch/arm64/geniezone/vm.c               |  11 ++
 arch/arm64/include/uapi/asm/gzvm_arch.h |  30 +++
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_vcpu.c      | 250 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c        |   5 +
 include/linux/gzvm_drv.h                |  21 ++
 include/uapi/linux/gzvm.h               | 136 +++++++++++++
 10 files changed, 564 insertions(+), 2 deletions(-)
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
index fdb95d619102..9be9cf77faa3 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -21,6 +21,7 @@ enum {
 	GZVM_FUNC_CREATE_DEVICE = 11,
 	GZVM_FUNC_PROBE = 12,
 	GZVM_FUNC_ENABLE_CAP = 13,
+	GZVM_FUNC_INFORM_EXIT = 14,
 	NR_GZVM_FUNC,
 };
 
@@ -42,6 +43,7 @@ enum {
 #define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
+#define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
@@ -65,4 +67,22 @@ static inline u16 get_vmid_from_tuple(unsigned int tuple)
 	return (u16)(tuple >> 16);
 }
 
+static inline u16 get_vcpuid_from_tuple(unsigned int tuple)
+{
+	return (u16)(tuple & 0xffff);
+}
+
+static inline unsigned int
+assemble_vm_vcpu_tuple(u16 vmid, u16 vcpuid)
+{
+	return ((unsigned int)vmid << 16 | vcpuid);
+}
+
+static inline void
+disassemble_vm_vcpu_tuple(unsigned int tuple, u16 *vmid, u16 *vcpuid)
+{
+	*vmid = get_vmid_from_tuple(tuple);
+	*vcpuid = get_vcpuid_from_tuple(tuple);
+}
+
 #endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vcpu.c b/arch/arm64/geniezone/vcpu.c
new file mode 100644
index 000000000000..95681fd66656
--- /dev/null
+++ b/arch/arm64/geniezone/vcpu.c
@@ -0,0 +1,88 @@
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
+int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid)
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
+ * @vm_id: vm id
+ * @vcpuid: vcpu id
+ * @run: Virtual address of vcpu->run
+ *
+ * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
+ */
+int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run)
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
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index e35751b21821..2df321f13057 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -14,6 +14,17 @@
 
 #define PAR_PA47_MASK ((((1UL << 48) - 1) >> 12) << 12)
 
+int gzvm_arch_inform_exit(u16 vm_id)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_hvc(MT_HVC_GZVM_INFORM_EXIT, vm_id, 0, 0, 0, 0, 0, 0, &res);
+	if (res.a0 == 0)
+		return 0;
+
+	return -ENXIO;
+}
+
 int gzvm_arch_probe(void)
 {
 	struct arm_smccc_res res;
diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
index 847bb627a65d..e56b4700e07e 100644
--- a/arch/arm64/include/uapi/asm/gzvm_arch.h
+++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
@@ -17,4 +17,34 @@
 /* GZVM_CAP_ARM_PVM_SET_PROTECTED_VM only sets protected but not load pvmfw */
 #define GZVM_CAP_ARM_PVM_SET_PROTECTED_VM	2
 
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
+#define GZVM_REG_ARM_CORE_REG(name)	\
+	(offsetof(struct gzvm_regs, name) / sizeof(__u32))
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
index 000000000000..e051343f2b0e
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -0,0 +1,250 @@
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
+static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
+				     void * __user argp,
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
+ * @vcpu: Pointer to struct gzvm_vcpu
+ * @argp: Pointer to struct gzvm_vcpu_run in userspace
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ */
+static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
+{
+	bool need_userspace = false;
+	u64 exit_reason = 0;
+
+	if (copy_from_user(vcpu->run, argp, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+
+	for (int i = 0; i < ARRAY_SIZE(vcpu->run->padding1); i++) {
+		if (vcpu->run->padding1[i])
+			return -EINVAL;
+	}
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
+			fallthrough;
+		case GZVM_EXIT_GZ:
+			break;
+		case GZVM_EXIT_UNKNOWN:
+			fallthrough;
+		default:
+			pr_err("vcpu unknown exit\n");
+			need_userspace = true;
+			goto out;
+		}
+	}
+
+out:
+	if (copy_to_user(argp, vcpu->run, sizeof(struct gzvm_vcpu_run)))
+		return -EFAULT;
+	if (signal_pending(current)) {
+		// invoke hvc to inform gz to map memory
+		gzvm_arch_inform_exit(vcpu->gzvm->vm_id);
+		return -ERESTARTSYS;
+	}
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
+ * gzvm_vm_ioctl_create_vcpu() - for GZVM_CREATE_VCPU
+ * @gzvm: Pointer to struct gzvm
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
index ee751369fd4b..aea99d050653 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -280,6 +280,10 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_dev_ioctl_check_extension(gzvm, arg);
 		break;
 	}
+	case GZVM_CREATE_VCPU: {
+		ret = gzvm_vm_ioctl_create_vcpu(gzvm, arg);
+		break;
+	}
 	case GZVM_SET_USER_MEMORY_REGION: {
 		struct gzvm_userspace_memory_region userspace_mem;
 
@@ -313,6 +317,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_lock(&gzvm->lock);
 
+	gzvm_destroy_vcpus(gzvm);
 	gzvm_arch_destroy_vm(gzvm->vm_id);
 
 	mutex_lock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 4fd52fcbd5a8..c42edb4345cc 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -31,6 +31,8 @@
 #define GZVM_MAX_VCPUS		 8
 #define GZVM_MAX_MEM_REGION	10
 
+#define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
+
 /* struct mem_region_addr_range - Identical to ffa memory constituent */
 struct mem_region_addr_range {
 	/* the base IPA of the constituent memory region, aligned to 4 kiB */
@@ -58,7 +60,16 @@ struct gzvm_memslot {
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
@@ -75,6 +86,8 @@ int gzvm_err_to_errno(unsigned long err);
 
 void gzvm_destroy_all_vms(void);
 
+void gzvm_destroy_vcpus(struct gzvm *gzvm);
+
 /* arch-dependant functions */
 int gzvm_arch_probe(void);
 int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
@@ -85,6 +98,14 @@ int gzvm_arch_destroy_vm(u16 vm_id);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
+
 u64 gzvm_hva_to_pa_arch(u64 hva);
+int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
+int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
+				  bool is_write, __u64 *data);
+int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run);
+int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
+int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
+int gzvm_arch_inform_exit(u16 vm_id);
 
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 99730c142b0e..4814c82b0dff 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -44,6 +44,11 @@ struct gzvm_memory_region {
 
 #define GZVM_SET_MEMORY_REGION     _IOW(GZVM_IOC_MAGIC,  0x40, \
 					struct gzvm_memory_region)
+/*
+ * GZVM_CREATE_VCPU receives as a parameter the vcpu slot,
+ * and returns a vcpu fd.
+ */
+#define GZVM_CREATE_VCPU           _IO(GZVM_IOC_MAGIC,   0x41)
 
 /* for GZVM_SET_USER_MEMORY_REGION */
 struct gzvm_userspace_memory_region {
@@ -59,6 +64,124 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/*
+ * ioctls for vcpu fds
+ */
+#define GZVM_RUN                   _IO(GZVM_IOC_MAGIC,   0x80)
+
+/* VM exit reason */
+enum {
+	GZVM_EXIT_UNKNOWN = 0x92920000,
+	GZVM_EXIT_MMIO = 0x92920001,
+	GZVM_EXIT_HYPERCALL = 0x92920002,
+	GZVM_EXIT_IRQ = 0x92920003,
+	GZVM_EXIT_EXCEPTION = 0x92920004,
+	GZVM_EXIT_DEBUG = 0x92920005,
+	GZVM_EXIT_FAIL_ENTRY = 0x92920006,
+	GZVM_EXIT_INTERNAL_ERROR = 0x92920007,
+	GZVM_EXIT_SYSTEM_EVENT = 0x92920008,
+	GZVM_EXIT_SHUTDOWN = 0x92920009,
+	GZVM_EXIT_GZ = 0x9292000a,
+};
+
+/**
+ * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
+ *			shared between userspace, kernel and
+ *			GenieZone hypervisor
+ * @exit_reason: The reason why gzvm_vcpu_run has stopped running the vCPU
+ * @immediate_exit: Polled when the vcpu is scheduled.
+ *                  If set, immediately returns -EINTR
+ * @padding1: Reserved for future-proof and must be zero filled
+ * @mmio: The nested struct in anonymous union. Handle mmio in host side
+ * @phys_addr: The address guest tries to access
+ * @data: The value to be written (is_write is 1) or
+ *        be filled by user for reads (is_write is 0)
+ * @size: The size of written data.
+ *        Only the first `size` bytes of `data` are handled
+ * @reg_nr: The register number where the data is stored
+ * @is_write: 1 for VM to perform a write or 0 for VM to perform a read
+ * @fail_entry: The nested struct in anonymous union.
+ *              Handle invalid entry address at the first run
+ * @hardware_entry_failure_reason: The reason codes about hardware entry failure
+ * @cpu: The current processor number via smp_processor_id()
+ * @exception: The nested struct in anonymous union.
+ *             Handle exception occurred in VM
+ * @exception: Which exception vector
+ * @error_code: Exception error codes
+ * @hypercall: The nested struct in anonymous union.
+ *             Some hypercalls issued from VM must be handled
+ * @args: The hypercall's arguments
+ * @internal: The nested struct in anonymous union. The errors from hypervisor
+ * @suberror: The errors codes about GZVM_EXIT_INTERNAL_ERROR
+ * @ndata: The number of elements used in data[]
+ * @data: Keep the detailed information about GZVM_EXIT_INTERNAL_ERROR
+ * @system_event: The nested struct in anonymous union.
+ *                VM's PSCI must be handled by host
+ * @type: System event type.
+ *        Ex. GZVM_SYSTEM_EVENT_SHUTDOWN or GZVM_SYSTEM_EVENT_RESET...etc.
+ * @ndata: The number of elements used in data[]
+ * @data: Keep the detailed information about GZVM_EXIT_SYSTEM_EVENT
+ * @padding: Fix it to a reasonable size future-proof for keeping the same
+ *           struct size when adding new variables in the union is needed
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
+		char padding[256];
+	};
+};
+
 /* for GZVM_ENABLE_CAP */
 struct gzvm_enable_cap {
 	/* in */
@@ -73,4 +196,17 @@ struct gzvm_enable_cap {
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
+
 #endif /* __GZVM_H__ */
-- 
2.18.0

