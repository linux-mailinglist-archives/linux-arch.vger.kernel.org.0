Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9BD7649E0
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233780AbjG0IED (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjG0ICz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D082D67;
        Thu, 27 Jul 2023 01:00:26 -0700 (PDT)
X-UUID: a1d70fbc2c5311eeb20a276fd37b9834-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=FgfBAzQoHFTaH2qCFD7VJQbtWH4Cthq+FXUmtuZGzHk=;
        b=ThnPt9zCSQkcf0vttgSuPwiJkevJ8xAi0jvgOBvdf623DqQmd/5ZhUu2X6a6pzCROJIpEuXgq8dSkQnE2p18axKJ0LrlO4PnCtPKzm0dmWM5rqASews9rBFumphCv9CWFXEiFByqJ7V9gKBQBUF56Ghhq9j3Lx8qjyqZO0YHtP8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:38bc736a-aa25-4bb5-aa4e-670ae929811c,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.29,REQID:38bc736a-aa25-4bb5-aa4e-670ae929811c,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:e7562a7,CLOUDID:c4998342-d291-4e62-b539-43d7d78362ba,B
        ulkID:230727160017RU7JY85L,BulkQuantity:2,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: a1d70fbc2c5311eeb20a276fd37b9834-20230727
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1359804051; Thu, 27 Jul 2023 16:00:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 16:00:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 16:00:14 +0800
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
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        Jade Shih <jades.shih@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>,
        Willix Yeh <chi-shen.yeh@mediatek.com>
Subject: [PATCH v5 05/12] virt: geniezone: Add irqchip support for virtual interrupt injection
Date:   Thu, 27 Jul 2023 15:59:58 +0800
Message-ID: <20230727080005.14474-6-yi-de.wu@mediatek.com>
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

Enable GenieZone to handle virtual interrupt injection request.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |   2 +-
 arch/arm64/geniezone/vgic.c             | 108 ++++++++++++++++++++++++
 arch/arm64/include/uapi/asm/gzvm_arch.h |   4 +
 drivers/virt/geniezone/gzvm_common.h    |  12 +++
 drivers/virt/geniezone/gzvm_vm.c        |  82 ++++++++++++++++++
 include/linux/gzvm_drv.h                |   4 +
 include/uapi/linux/gzvm.h               |  66 +++++++++++++++
 7 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/geniezone/vgic.c
 create mode 100644 drivers/virt/geniezone/gzvm_common.h

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
index 000000000000..3746e0c9e247
--- /dev/null
+++ b/arch/arm64/geniezone/vgic.c
@@ -0,0 +1,108 @@
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
+/**
+ * is_irq_valid() - Check the irq number and irq_type are matched
+ * @irq:		interrupt number
+ * @irq_type:		interrupt type
+ *
+ * Return:
+ * true if irq is valid else false.
+ */
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
+		if (likely(irq >= GZVM_VGIC_NR_SGIS &&
+			   irq < GZVM_VGIC_NR_PRIVATE_IRQS))
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
+ * @gzvm: Pointer to struct gzvm
+ * @vcpu_idx: vcpu index, only valid if PPI
+ * @irq_type: Interrupt type
+ * @irq: irq number
+ * @level: 1 if true else 0
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
+ */
+static int gzvm_vgic_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+				u32 irq_type, u32 irq, bool level)
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
+ * @gzvm: Pointer to struct gzvm
+ * @vcpu_idx: vcpu index
+ * @spi_irq: This is spi interrupt number (starts from 0 instead of 32)
+ * @level: 1 if true else 0
+ *
+ * Return:
+ * * 0 if succeed else other negative values indicating each errors
+ */
+static int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
+				u32 spi_irq, bool level)
+{
+	return gzvm_vgic_inject_irq(gzvm, 0, GZVM_IRQ_TYPE_SPI,
+				    spi_irq + GZVM_VGIC_NR_PRIVATE_IRQS,
+				    level);
+}
+
+int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_DEVICE, vm_id,
+				    virt_to_phys(gzvm_dev), 0, 0, 0, 0, 0,
+				    &res);
+}
+
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 irq_type, u32 irq, bool level)
+{
+	/* default use spi */
+	return gzvm_vgic_inject_spi(gzvm, vcpu_idx, irq, level);
+}
diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
index e56b4700e07e..acfe9be0f849 100644
--- a/arch/arm64/include/uapi/asm/gzvm_arch.h
+++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
@@ -47,4 +47,8 @@
 #define GZVM_REG_ARM_CORE_REG(name)	\
 	(offsetof(struct gzvm_regs, name) / sizeof(__u32))
 
+#define GZVM_VGIC_NR_SGIS		16
+#define GZVM_VGIC_NR_PPIS		16
+#define GZVM_VGIC_NR_PRIVATE_IRQS	(GZVM_VGIC_NR_SGIS + GZVM_VGIC_NR_PPIS)
+
 #endif /* __GZVM_ARCH_H__ */
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
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index aea99d050653..b1397180cd02 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
 
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
@@ -260,6 +261,73 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
+int gzvm_irqchip_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			    u32 irq_type, u32 irq, bool level)
+{
+	return gzvm_arch_inject_irq(gzvm, vcpu_idx, irq_type, irq, level);
+}
+
+static int gzvm_vm_ioctl_irq_line(struct gzvm *gzvm,
+				  struct gzvm_irq_level *irq_level)
+{
+	u32 irq = irq_level->irq;
+	u32 irq_type, vcpu_idx, vcpu2_idx, irq_num;
+	bool level = irq_level->level;
+
+	irq_type = FIELD_GET(GZVM_IRQ_LINE_TYPE, irq);
+	vcpu_idx = FIELD_GET(GZVM_IRQ_LINE_VCPU, irq);
+	vcpu2_idx = FIELD_GET(GZVM_IRQ_LINE_VCPU2, irq) * (GZVM_IRQ_VCPU_MASK + 1);
+	irq_num = FIELD_GET(GZVM_IRQ_LINE_NUM, irq);
+
+	return gzvm_irqchip_inject_irq(gzvm, vcpu_idx + vcpu2_idx, irq_type, irq_num,
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
@@ -294,6 +362,20 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_set_memory_region(gzvm, &userspace_mem);
 		break;
 	}
+	case GZVM_IRQ_LINE: {
+		struct gzvm_irq_level irq_event;
+
+		if (copy_from_user(&irq_event, argp, sizeof(irq_event))) {
+			ret = -EFAULT;
+			goto out;
+		}
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
index c42edb4345cc..d86885d46195 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -108,4 +108,8 @@ int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
 int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
 int gzvm_arch_inform_exit(u16 vm_id);
 
+int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
+int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 irq_type, u32 irq, bool level);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 4814c82b0dff..fb019d232a98 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -64,6 +64,72 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+/* for GZVM_IRQ_LINE, irq field index values */
+#define GZVM_IRQ_VCPU_MASK		0xff
+#define GZVM_IRQ_LINE_TYPE		GENMASK(27, 24)
+#define GZVM_IRQ_LINE_VCPU		GENMASK(23, 16)
+#define GZVM_IRQ_LINE_VCPU2		GENMASK(31, 28)
+#define GZVM_IRQ_LINE_NUM		GENMASK(15, 0)
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
+	GZVM_DEV_TYPE_ARM_VGIC_V3_DIST = 0,
+	GZVM_DEV_TYPE_ARM_VGIC_V3_REDIST = 1,
+	GZVM_DEV_TYPE_MAX,
+};
+
+/**
+ * struct gzvm_create_device: For GZVM_CREATE_DEVICE.
+ * @dev_type: Device type.
+ * @id: Device id.
+ * @flags: Bypass to hypervisor to handle them and these are flags of virtual
+ *         devices.
+ * @dev_addr: Device ipa address in VM's view.
+ * @dev_reg_size: Device register range size.
+ * @attr_addr: If user -> kernel, this is user virtual address of device
+ *             specific attributes (if needed). If kernel->hypervisor,
+ *             this is ipa.
+ * @attr_size: This attr_size is the buffer size in bytes of each attribute
+ *             needed from various devices. The attribute here refers to the
+ *             additional data passed from VMM(e.g. Crosvm) to GenieZone
+ *             hypervisor when virtual devices were to be created. Thus,
+ *             we need attr_addr and attr_size in the gzvm_create_device
+ *             structure to keep track of the attribute mentioned.
+ *
+ * Store information needed to create device.
+ */
+struct gzvm_create_device {
+	__u32 dev_type;
+	__u32 id;
+	__u64 flags;
+	__u64 dev_addr;
+	__u64 dev_reg_size;
+	__u64 attr_addr;
+	__u64 attr_size;
+};
+
+#define GZVM_CREATE_DEVICE	   _IOWR(GZVM_IOC_MAGIC,  0xe0, \
+					struct gzvm_create_device)
+
 /*
  * ioctls for vcpu fds
  */
-- 
2.18.0

