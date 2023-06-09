Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 670657293C8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbjFIIxF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbjFIIwd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:52:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7521FEC;
        Fri,  9 Jun 2023 01:52:27 -0700 (PDT)
X-UUID: efa7cd4806a211eeb20a276fd37b9834-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=g0zoqrDULwaDrqDtdyH49UjywourFY759BoSUsW4U8o=;
        b=spXegZlrYutB2TSg8Iix4RxlasQZHduebpyioJaWFxLbTOUSyjdrfX7BItA8a+qbEKdMzbrQ8d59dgSXiHsqBxrAWynFX3I1FJ67QcpJcAD53j+TFhIl1FDu/scfqnOyOOiNfdDsE7WNdV0DFk7+qR68YS0m9kDTh0hnU/IUWSo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:883f3655-51b0-435b-ba30-6b68c90906d1,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:a1f8ea3d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: efa7cd4806a211eeb20a276fd37b9834-20230609
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1768483243; Fri, 09 Jun 2023 16:52:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 16:52:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 16:52:15 +0800
From:   Yi-De Wu <yi-de.wu@mediatek.com>
To:     Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arch@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        David Bradil <dbrazdil@google.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
Subject: [PATCH v4 4/9] virt: geniezone: Add irqchip support for virtual interrupt injection
Date:   Fri, 9 Jun 2023 16:52:09 +0800
Message-ID: <20230609085214.31071-5-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230609085214.31071-1-yi-de.wu@mediatek.com>
References: <20230609085214.31071-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>

Enable GenieZone to handle virtual interrupt injection request.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |  2 +-
 arch/arm64/geniezone/vgic.c             | 89 +++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/gzvm_arch.h |  4 ++
 drivers/virt/geniezone/Makefile         |  2 +-
 drivers/virt/geniezone/gzvm_common.h    | 12 ++++
 drivers/virt/geniezone/gzvm_irqchip.c   | 13 ++++
 drivers/virt/geniezone/gzvm_vm.c        | 77 +++++++++++++++++++++
 include/linux/gzvm_drv.h                |  4 ++
 include/uapi/linux/gzvm.h               | 53 +++++++++++++++
 9 files changed, 254 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/geniezone/vgic.c
 create mode 100644 drivers/virt/geniezone/gzvm_common.h
 create mode 100644 drivers/virt/geniezone/gzvm_irqchip.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 69b0a4abeab0..0e4f1087f9de 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o vcpu.o
+gzvm-y += vm.o vcpu.o vgic.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/vgic.c b/arch/arm64/geniezone/vgic.c
new file mode 100644
index 000000000000..9fe5049be122
--- /dev/null
+++ b/arch/arm64/geniezone/vgic.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/irqchip/arm-gic-v3.h>
+#include <linux/gzvm.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
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
+		if (likely(irq >= GZVM_VGIC_NR_SGIS && irq < GZVM_VGIC_NR_PRIVATE_IRQS))
+			return true;
+		break;
+	case GZVM_IRQ_TYPE_SPI:
+		/* 32 ~ : SPT */
+		if (likely(irq >= GZVM_VGIC_NR_PRIVATE_IRQS))
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
+static int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+				u32 irq, bool level)
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
+static int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
+				u32 spi_irq, bool level)
+{
+	return gzvm_vgic_inject_irq(gzvm, 0, GZVM_IRQ_TYPE_SPI,
+				    spi_irq + GZVM_VGIC_NR_PRIVATE_IRQS, level);
+}
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
diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
index e45e8e9e1bea..efee0354711e 100644
--- a/arch/arm64/include/uapi/asm/gzvm_arch.h
+++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
@@ -46,4 +46,8 @@
 #define GZVM_REG_ARM_CORE		(0x0010 << GZVM_REG_ARM_COPROC_SHIFT)
 #define GZVM_REG_ARM_CORE_REG(name)	(offsetof(struct gzvm_regs, name) / sizeof(__u32))
 
+#define GZVM_VGIC_NR_SGIS		16
+#define GZVM_VGIC_NR_PPIS		16
+#define GZVM_VGIC_NR_PRIVATE_IRQS	(GZVM_VGIC_NR_SGIS + GZVM_VGIC_NR_PPIS)
+
 #endif /* __GZVM_ARCH_H__ */
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 8ebf2db0c970..67ba3ed76ea7 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,5 +7,5 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
-	  $(GZVM_DIR)/gzvm_vcpu.o
+	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqchip.o
 
diff --git a/drivers/virt/geniezone/gzvm_common.h b/drivers/virt/geniezone/gzvm_common.h
new file mode 100644
index 000000000000..d0e39ded79e6
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#ifndef __GZ_COMMON_H__
+#define __GZ_COMMON_H__
+
+int gzvm_irqchip_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			    u32 irq_type, u32 irq, bool level);
+
+#endif /* __GZVM_COMMON_H__ */
diff --git a/drivers/virt/geniezone/gzvm_irqchip.c b/drivers/virt/geniezone/gzvm_irqchip.c
new file mode 100644
index 000000000000..134bca3ab247
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_irqchip.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
+
+int gzvm_irqchip_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			    u32 irq_type, u32 irq, bool level)
+{
+	return gzvm_arch_inject_irq(gzvm, vcpu_idx, irq_type, irq, level);
+}
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index f777c3bdb5ac..0cab67b0bdf8 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
 
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
@@ -250,6 +251,68 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
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
+	return gzvm_irqchip_inject_irq(gzvm, vcpu_idx, irq_type, irq_num,
+				       level);
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
@@ -284,6 +347,20 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
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
index 7768bd35113a..842a026df9f3 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -109,6 +109,10 @@ int gzvm_arch_create_vcpu(gzvm_id_t vm_id, int vcpuid, void *run);
 int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(gzvm_id_t vm_id, int vcpuid);
 
+int gzvm_arch_create_device(gzvm_id_t vm_id, struct gzvm_create_device *gzvm_dev);
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
+			 u32 irq, bool level);
+
 extern struct miscdevice *gzvm_debug_dev;
 
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 38b3f20114ab..279b52192366 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -61,6 +61,59 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/* for GZVM_IRQ_LINE, irq field index values */
+#define GZVM_IRQ_VCPU2_SHIFT		28
+#define GZVM_IRQ_VCPU2_MASK		0xf
+#define GZVM_IRQ_TYPE_SHIFT		24
+#define GZVM_IRQ_TYPE_MASK		0xf
+#define GZVM_IRQ_VCPU_SHIFT		16
+#define GZVM_IRQ_VCPU_MASK		0xff
+#define GZVM_IRQ_NUM_SHIFT		0
+#define GZVM_IRQ_NUM_MASK		0xffff
+
+/* irq_type field */
+#define GZVM_IRQ_TYPE_CPU		0
+#define GZVM_IRQ_TYPE_SPI		1
+#define GZVM_IRQ_TYPE_PPI		2
+
+/* out-of-kernel GIC cpu interrupt injection irq_number field */
+#define GZVM_IRQ_CPU_IRQ		0
+#define GZVM_IRQ_CPU_FIQ		1
+
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
 /**
  * ioctls for vcpu fds
  */
-- 
2.18.0

