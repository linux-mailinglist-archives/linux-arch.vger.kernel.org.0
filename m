Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001246F15BA
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 12:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbjD1Kgp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345549AbjD1Kgj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 06:36:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204582D65;
        Fri, 28 Apr 2023 03:36:33 -0700 (PDT)
X-UUID: 877d4026e5b011ed9cb5633481061a41-20230428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vm6bLzcTtoYa7jL2OxIanDFVUZxQ35kV0FV9Z298RGs=;
        b=AGzmmg6Ud5eKzab9g+dQaiIxi2B8Ejvn45L/x50z958XwCa8lQmfm7usyhSZsTqL4GP3xsHxKT/Gfcc1y34qe74z0z5pqEJ6Bmrr4eEuEM/PDyZVlh04cMjDh8AYKp1V2ZVu8fhwfvDYEZ3LkzuK96yhYQpLw6FbyF2t/z4WGWs=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:54a2786f-35e5-493b-ba9b-c8e54fed3775,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.22,REQID:54a2786f-35e5-493b-ba9b-c8e54fed3775,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:120426c,CLOUDID:dd2d386a-2f20-4998-991c-3b78627e4938,B
        ulkID:230428183628UC86YHEU,BulkQuantity:0,Recheck:0,SF:38|29|28|16|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 877d4026e5b011ed9cb5633481061a41-20230428
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 812517668; Fri, 28 Apr 2023 18:36:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Apr 2023 18:36:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 28 Apr 2023 18:36:26 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        "David Bradil" <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: [PATCH v2 5/7] virt: geniezone: Add irqchip support for virtual interrupt injection
Date:   Fri, 28 Apr 2023 18:36:20 +0800
Message-ID: <20230428103622.18291-6-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230428103622.18291-1-yi-de.wu@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
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

Enable GenieZone to handle virtual interrupt injection request.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile       |  2 +-
 arch/arm64/geniezone/gzvm_arch.c    | 24 ++++++--
 arch/arm64/geniezone/gzvm_arch.h    | 11 ++++
 arch/arm64/geniezone/gzvm_irqchip.c | 88 +++++++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c    | 75 ++++++++++++++++++++++++
 include/linux/gzvm_drv.h            |  4 ++
 include/uapi/linux/gzvm.h           | 38 ++++++++++++-
 7 files changed, 235 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm64/geniezone/gzvm_irqchip.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 5720c076d73c..82af1ed870bc 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += gzvm_arch.o
+gzvm-y += gzvm_arch.o gzvm_irqchip.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/gzvm_arch.c b/arch/arm64/geniezone/gzvm_arch.c
index 3c91f3f1ae50..16ab5d4fd5b8 100644
--- a/arch/arm64/geniezone/gzvm_arch.c
+++ b/arch/arm64/geniezone/gzvm_arch.c
@@ -16,11 +16,10 @@
  *
  * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
  */
-static int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1,
-				unsigned long a2, unsigned long a3,
-				unsigned long a4, unsigned long a5,
-				unsigned long a6, unsigned long a7,
-				struct arm_smccc_res *res)
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
+			 unsigned long a3, unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res)
 {
 	arm_smccc_hvc(a0, a1, a2, a3, a4, a5, a6, a7, res);
 	return gz_err_to_errno(res->a0);
@@ -259,3 +258,18 @@ int gzvm_arch_create_vcpu(gzvm_id_t vm_id, int vcpuid, void *run)
 
 	return ret;
 }
+
+int gzvm_arch_create_device(gzvm_id_t vm_id, struct gzvm_create_device *gzvm_dev)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_DEVICE, vm_id,
+				    virt_to_phys(gzvm_dev), 0, 0, 0, 0, 0, &res);
+}
+
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level)
+{
+	/* default use spi */
+	return gzvm_vgic_inject_spi(gzvm, vcpu_idx, irq, level);
+}
diff --git a/arch/arm64/geniezone/gzvm_arch.h b/arch/arm64/geniezone/gzvm_arch.h
index ecc24ff4e244..205bd0901333 100644
--- a/arch/arm64/geniezone/gzvm_arch.h
+++ b/arch/arm64/geniezone/gzvm_arch.h
@@ -71,4 +71,15 @@ disassemble_vm_vcpu_tuple(unsigned int tuple, gzvm_id_t *vmid,
 	*vcpuid = get_vcpuid_from_tuple(tuple);
 }
 
+int gzvm_hypcall_wrapper(unsigned long a0, unsigned long a1, unsigned long a2,
+			 unsigned long a3, unsigned long a4, unsigned long a5,
+			 unsigned long a6, unsigned long a7,
+			 struct arm_smccc_res *res);
+
+void gzvm_sync_vgic_state(struct gzvm_vcpu *vcpu);
+int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level);
+int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 spi_irq, bool level);
+
 #endif /* __GZVM_ARCH_H__ */
diff --git a/arch/arm64/geniezone/gzvm_irqchip.c b/arch/arm64/geniezone/gzvm_irqchip.c
new file mode 100644
index 000000000000..c46bd34fee1b
--- /dev/null
+++ b/arch/arm64/geniezone/gzvm_irqchip.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/irqchip/arm-gic-v3.h>
+#include <kvm/arm_vgic.h>
+
+#include <linux/gzvm.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch.h"
+
+/**
+ * gzvm_sync_vgic_state() - Check all LRs synced from gz hypervisor
+ *
+ * Traverse all LRs, see if any EOIed vint, notify_acked_irq if any.
+ * GZ does not fold/unfold everytime KVM_RUN, so we have to traverse all saved
+ * LRs. It will not takes much more time comparing to fold/unfold everytime
+ * GZVM_RUN, because there are only few LRs.
+ */
+void gzvm_sync_vgic_state(struct gzvm_vcpu *vcpu)
+{
+}
+
+/* is_irq_valid() - Check the irq number and irq_type are matched */
+static bool is_irq_valid(u32 irq, u32 irq_type)
+{
+	switch (irq_type) {
+	case GZVM_IRQ_TYPE_CPU:
+		/*  0 ~ 15: SGI */
+		if (likely(irq <= GZVM_IRQ_CPU_FIQ))
+			return true;
+		break;
+	case GZVM_IRQ_TYPE_PPI:
+		/* 16 ~ 31: PPI */
+		if (likely(irq >= VGIC_NR_SGIS && irq < VGIC_NR_PRIVATE_IRQS))
+			return true;
+		break;
+	case GZVM_IRQ_TYPE_SPI:
+		/* 32 ~ : SPT */
+		if (likely(irq >= VGIC_NR_PRIVATE_IRQS))
+			return true;
+		break;
+	default:
+		return false;
+	}
+	return false;
+}
+
+/**
+ * gzvm_vgic_inject_irq() - Inject virtual interrupt to a VM
+ * @vcpu_idx: vcpu index, only valid if PPI
+ * @irq: irq number
+ * @level: 1 if true else 0
+ */
+int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level)
+{
+	unsigned long a1 = assemble_vm_vcpu_tuple(gzvm->vm_id, vcpu_idx);
+	struct arm_smccc_res res;
+
+	if (!unlikely(is_irq_valid(irq, irq_type)))
+		return -EINVAL;
+
+	gzvm_hypcall_wrapper(MT_HVC_GZVM_IRQ_LINE, a1, irq, level,
+			     0, 0, 0, 0, &res);
+	if (res.a0) {
+		pr_err("Failed to set IRQ level (%d) to irq#%u on vcpu %d with ret=%d\n",
+		       level, irq, vcpu_idx, (int)res.a0);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+/**
+ * gzvm_vgic_inject_spi() - Inject virtual spi interrupt
+ *
+ * @spi_irq: This is spi interrupt number (starts from 0 instead of 32)
+ *
+ * Return 0 if succeed else other negative values indicating each errors
+ */
+int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 spi_irq, bool level)
+{
+	return gzvm_vgic_inject_irq(gzvm, 0, GZVM_IRQ_TYPE_SPI,
+				    spi_irq + VGIC_NR_PRIVATE_IRQS, level);
+}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 5542065e82c6..a5444541b745 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -186,6 +186,67 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+static int gzvm_vm_ioctl_irq_line(struct gzvm *gzvm,
+				  struct gzvm_irq_level *irq_level)
+{
+	u32 irq = irq_level->irq;
+	unsigned int irq_type, vcpu_idx, irq_num;
+	bool level = irq_level->level;
+
+	irq_type = (irq >> GZVM_IRQ_TYPE_SHIFT) & GZVM_IRQ_TYPE_MASK;
+	vcpu_idx = (irq >> GZVM_IRQ_VCPU_SHIFT) & GZVM_IRQ_VCPU_MASK;
+	vcpu_idx += ((irq >> GZVM_IRQ_VCPU2_SHIFT) & GZVM_IRQ_VCPU2_MASK) *
+		(GZVM_IRQ_VCPU_MASK + 1);
+	irq_num = (irq >> GZVM_IRQ_NUM_SHIFT) & GZVM_IRQ_NUM_MASK;
+
+	return gzvm_arch_inject_irq(gzvm, vcpu_idx, irq_num, irq_type, level);
+}
+
+static int gzvm_vm_ioctl_create_device(struct gzvm *gzvm, void __user *argp)
+{
+	struct gzvm_create_device *gzvm_dev;
+	void *dev_data = NULL;
+	int ret;
+
+	gzvm_dev = (struct gzvm_create_device *)alloc_pages_exact(PAGE_SIZE,
+								  GFP_KERNEL);
+	if (!gzvm_dev)
+		return -ENOMEM;
+	if (copy_from_user(gzvm_dev, argp, sizeof(*gzvm_dev))) {
+		ret = -EFAULT;
+		goto err_free_dev;
+	}
+
+	if (gzvm_dev->attr_addr != 0 && gzvm_dev->attr_size != 0) {
+		size_t attr_size = gzvm_dev->attr_size;
+		void __user *attr_addr = (void __user *)gzvm_dev->attr_addr;
+
+		/* Size of device specific data should not be over a page. */
+		if (attr_size > PAGE_SIZE)
+			return -EINVAL;
+
+		dev_data = alloc_pages_exact(attr_size, GFP_KERNEL);
+		if (!dev_data) {
+			ret = -ENOMEM;
+			goto err_free_dev;
+		}
+
+		if (copy_from_user(dev_data, attr_addr, attr_size)) {
+			ret = -EFAULT;
+			goto err_free_dev_data;
+		}
+		gzvm_dev->attr_addr = virt_to_phys(dev_data);
+	}
+
+	ret = gzvm_arch_create_device(gzvm->vm_id, gzvm_dev);
+err_free_dev_data:
+	if (dev_data)
+		free_pages_exact(dev_data, 0);
+err_free_dev:
+	free_pages_exact(gzvm_dev, 0);
+	return ret;
+}
+
 static int gzvm_vm_ioctl_enable_cap(struct gzvm *gzvm,
 				    struct gzvm_enable_cap *cap,
 				    void __user *argp)
@@ -220,6 +281,20 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_IRQ_LINE: {
+		struct gzvm_irq_level irq_event;
+
+		ret = -EFAULT;
+		if (copy_from_user(&irq_event, argp, sizeof(irq_event)))
+			goto out;
+
+		ret = gzvm_vm_ioctl_irq_line(gzvm, &irq_event);
+		break;
+	}
+	case GZVM_CREATE_DEVICE: {
+		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 5736ddf97741..1e7c81597e9a 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -107,6 +107,10 @@ int gzvm_arch_create_vcpu(gzvm_id_t vm_id, int vcpuid, void *run);
 int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(gzvm_id_t vm_id, int vcpuid);
 
+int gzvm_arch_create_device(gzvm_id_t vm_id, struct gzvm_create_device *gzvm_dev);
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level);
+
 extern struct platform_device *gzvm_debug_dev;
 
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 6462961299eb..2f56a53efb27 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -87,7 +87,43 @@ struct gzvm_userspace_memory_region {
 #define GZVM_IRQ_CPU_IRQ		0
 #define GZVM_IRQ_CPU_FIQ		1
 
-/* ioctls for vcpu fds */
+struct gzvm_irq_level {
+	union {
+		__u32 irq;
+		__s32 status;
+	};
+	__u32 level;
+};
+
+#define GZVM_IRQ_LINE              _IOW(GZVM_IOC_MAGIC,  0x61, \
+					struct gzvm_irq_level)
+
+enum gzvm_device_type {
+	GZVM_DEV_TYPE_ARM_VGIC_V3_DIST,
+	GZVM_DEV_TYPE_ARM_VGIC_V3_REDIST,
+	GZVM_DEV_TYPE_MAX,
+};
+
+struct gzvm_create_device {
+	__u32 dev_type;			/* device type */
+	__u32 id;			/* out: device id */
+	__u64 flags;			/* device specific flags */
+	__u64 dev_addr;			/* device ipa address in VM's view */
+	__u64 dev_reg_size;		/* device register range size */
+	/*
+	 * If user -> kernel, this is user virtual address of device specific
+	 * attributes (if needed). If kernel->hypervisor, this is ipa.
+	 */
+	__u64 attr_addr;
+	__u64 attr_size;		/* size of device specific attributes */
+};
+
+#define GZVM_CREATE_DEVICE	   _IOWR(GZVM_IOC_MAGIC,  0xe0, \
+					struct gzvm_create_device)
+
+/*
+ * ioctls for vcpu fds
+ */
 #define GZVM_RUN                   _IO(GZVM_IOC_MAGIC,   0x80)
 
 /* VM exit reason */
-- 
2.18.0

