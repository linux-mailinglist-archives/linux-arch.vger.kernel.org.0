Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB176F15B3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345839AbjD1Kgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 06:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjD1Kgi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 06:36:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9EF1FCB;
        Fri, 28 Apr 2023 03:36:32 -0700 (PDT)
X-UUID: 87d5a888e5b011edb20a276fd37b9834-20230428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=u3teTzXWfdZD/MAt4wIpkVkYZZzL4aWs/Dkd2xxky/Y=;
        b=fxyvhujlP3h9I2KBlu1gLBYqEiByV7aTRpDaInIzIjepikq6yQE/neAux4OAIOLCpmiAz2jMTOEn/LyGPMWjM1SkPaHzzfo7LWv58lIOVDuM5eFUKp4kxhe8eZlJ5l56/ML24vOUGCXmczjIMFXf7NNHilqSksbMj1emGhDhDFE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:e900bb1b-1d7c-4b2b-a797-c435c1400547,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:120426c,CLOUDID:72893230-6935-4eab-a959-f84f8da15543,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 87d5a888e5b011edb20a276fd37b9834-20230428
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1776837364; Fri, 28 Apr 2023 18:36:27 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: [PATCH v2 7/7] virt: geniezone: Add ioeventfd support
Date:   Fri, 28 Apr 2023 18:36:22 +0800
Message-ID: <20230428103622.18291-8-yi-de.wu@mediatek.com>
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

Ioeventfd leverages eventfd to provide asynchronous notification
mechanism for VMM. VMM can register a mmio address and bind with an
eventfd. Once a mmio trap occurs on this registered region, its
corresponding eventfd will be notified.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_ioeventfd.c | 263 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      |  29 ++-
 drivers/virt/geniezone/gzvm_vm.c        |  17 ++
 include/linux/gzvm_drv.h                |  11 +
 include/uapi/linux/gzvm.h               |  23 +++
 6 files changed, 343 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_ioeventfd.c

diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 8517549e7dfb..b1ecdd235a4e 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,5 +7,6 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
-	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o
+	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o \
+	  $(GZVM_DIR)/gzvm_ioeventfd.o
 
diff --git a/drivers/virt/geniezone/gzvm_ioeventfd.c b/drivers/virt/geniezone/gzvm_ioeventfd.c
new file mode 100644
index 000000000000..f5664cab98c3
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_ioeventfd.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/file.h>
+#include <linux/syscalls.h>
+#include <linux/gzvm.h>
+#include <linux/gzvm_drv.h>
+#include <linux/wait.h>
+#include <linux/poll.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+struct gzvm_ioevent {
+	struct list_head list;
+	__u64 addr;
+	__u32 len;
+	struct eventfd_ctx  *evt_ctx;
+	__u64 datamatch;
+	bool wildcard;
+};
+
+/**
+ * ioeventfd_check_collision() - Check collison assumes gzvm->slots_lock held.
+ * @gzvm: Pointer to gzvm.
+ * @p: Pointer to gzvm_ioevent.
+ */
+static bool ioeventfd_check_collision(struct gzvm *gzvm, struct gzvm_ioevent *p)
+{
+	struct gzvm_ioevent *_p;
+
+	list_for_each_entry(_p, &gzvm->ioevents, list)
+		if (_p->addr == p->addr &&
+		    (!_p->len || !p->len ||
+		     (_p->len == p->len &&
+		      (_p->wildcard || p->wildcard ||
+		       _p->datamatch == p->datamatch))))
+			return true;
+
+	return false;
+}
+
+static void gzvm_ioevent_release(struct gzvm_ioevent *p)
+{
+	eventfd_ctx_put(p->evt_ctx);
+	list_del(&p->list);
+	kfree(p);
+}
+
+static bool gzvm_ioevent_in_range(struct gzvm_ioevent *p, __u64 addr, int len,
+				  const void *val)
+{
+	u64 _val;
+
+	if (addr != p->addr)
+		/* address must be precise for a hit */
+		return false;
+
+	if (!p->len)
+		/* length = 0 means only look at the address, so always a hit */
+		return true;
+
+	if (len != p->len)
+		/* address-range must be precise for a hit */
+		return false;
+
+	if (p->wildcard)
+		/* all else equal, wildcard is always a hit */
+		return true;
+
+	/* otherwise, we have to actually compare the data */
+
+	WARN_ON_ONCE(!IS_ALIGNED((unsigned long)val, len));
+
+	switch (len) {
+	case 1:
+		_val = *(u8 *)val;
+		break;
+	case 2:
+		_val = *(u16 *)val;
+		break;
+	case 4:
+		_val = *(u32 *)val;
+		break;
+	case 8:
+		_val = *(u64 *)val;
+		break;
+	default:
+		return false;
+	}
+
+	return _val == p->datamatch;
+}
+
+static int gzvm_deassign_ioeventfd(struct gzvm *gzvm,
+				   struct gzvm_ioeventfd *args)
+{
+	struct gzvm_ioevent *p, *tmp;
+	struct eventfd_ctx *evt_ctx;
+	int ret = -ENOENT;
+	bool wildcard;
+
+	evt_ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(evt_ctx))
+		return PTR_ERR(evt_ctx);
+
+	wildcard = !(args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH);
+
+	mutex_lock(&gzvm->lock);
+
+	list_for_each_entry_safe(p, tmp, &gzvm->ioevents, list) {
+		if (p->evt_ctx != evt_ctx  ||
+		    p->addr != args->addr  ||
+		    p->len != args->len ||
+		    p->wildcard != wildcard)
+			continue;
+
+		if (!p->wildcard && p->datamatch != args->datamatch)
+			continue;
+
+		gzvm_ioevent_release(p);
+		ret = 0;
+		break;
+	}
+
+	mutex_unlock(&gzvm->lock);
+
+	/* got in the front of this function */
+	eventfd_ctx_put(evt_ctx);
+
+	return ret;
+}
+
+static int gzvm_assign_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args)
+{
+	struct eventfd_ctx *evt_ctx;
+	struct gzvm_ioevent *evt;
+	int ret;
+
+	evt_ctx = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(evt_ctx))
+		return PTR_ERR(evt_ctx);
+
+	evt = kmalloc(sizeof(*evt), GFP_KERNEL);
+	if (!evt)
+		return -ENOMEM;
+	*evt = (struct gzvm_ioevent) {
+		.addr = args->addr,
+		.len = args->len,
+		.evt_ctx = evt_ctx,
+	};
+	if (args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH) {
+		evt->datamatch = args->datamatch;
+		evt->wildcard = false;
+	} else {
+		evt->wildcard = true;
+	}
+
+	if (ioeventfd_check_collision(gzvm, evt)) {
+		ret = -EEXIST;
+		goto err_free;
+	}
+
+	mutex_lock(&gzvm->lock);
+	list_add_tail(&evt->list, &gzvm->ioevents);
+	mutex_unlock(&gzvm->lock);
+
+	return 0;
+
+err_free:
+	kfree(evt);
+	eventfd_ctx_put(evt_ctx);
+	return ret;
+}
+
+/**
+ * gzvm_ioeventfd_check_valid() - Check user arguments is valid.
+ * @args: Pointer to gzvm_ioeventfd.
+ *
+ * Return true if user arguments are valid.
+ * Return false if user arguments are invalid.
+ */
+static bool gzvm_ioeventfd_check_valid(struct gzvm_ioeventfd *args)
+{
+	/* must be natural-word sized, or 0 to ignore length */
+	switch (args->len) {
+	case 0:
+	case 1:
+	case 2:
+	case 4:
+	case 8:
+		break;
+	default:
+		return false;
+	}
+
+	/* check for range overflow */
+	if (args->addr + args->len < args->addr)
+		return false;
+
+	/* check for extra flags that we don't understand */
+	if (args->flags & ~GZVM_IOEVENTFD_VALID_FLAG_MASK)
+		return false;
+
+	/* ioeventfd with no length can't be combined with DATAMATCH */
+	if (!args->len && (args->flags & GZVM_IOEVENTFD_FLAG_DATAMATCH))
+		return false;
+
+	/* gzvm does not support pio bus ioeventfd */
+	if (args->flags & GZVM_IOEVENTFD_FLAG_PIO)
+		return false;
+
+	return true;
+}
+
+/**
+ * gzvm_ioeventfd() - Register ioevent to ioevent list.
+ * @gzvm: Pointer to gzvm.
+ * @args: Pointer to gzvm_ioeventfd.
+ */
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args)
+{
+	if (gzvm_ioeventfd_check_valid(args) == false)
+		return -EINVAL;
+
+	if (args->flags & GZVM_IOEVENTFD_FLAG_DEASSIGN)
+		return gzvm_deassign_ioeventfd(gzvm, args);
+	return gzvm_assign_ioeventfd(gzvm, args);
+}
+
+/**
+ * gzvm_ioevent_write() - Travers this vm's registered ioeventfd to see if
+ *			  need notifying it.
+ * @vcpu: Pointer to vcpu.
+ * @addr: mmio address.
+ * @len: mmio size.
+ * @val: Pointer to void.
+ *
+ * Return true if this io is already sent to ioeventfd's listener.
+ * Return false if we cannot find any ioeventfd registering this mmio write.
+ */
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val)
+{
+	struct gzvm_ioevent *e;
+
+	list_for_each_entry(e, &vcpu->gzvm->ioevents, list) {
+		if (gzvm_ioevent_in_range(e, addr, len, val)) {
+			eventfd_signal(e->evt_ctx, 1);
+			return true;
+		}
+	}
+	return false;
+}
+
+int gzvm_init_ioeventfd(struct gzvm *gzvm)
+{
+	INIT_LIST_HEAD(&gzvm->ioevents);
+
+	return 0;
+}
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index faee2ee64639..cd5f5735ec3b 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -49,10 +49,34 @@ static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, void * __user argp,
 	return 0;
 }
 
+/**
+ * gzvm_vcpu_handle_mmio() - Handle mmio in kernel space.
+ * @vcpu: Pointer to vcpu.
+ *
+ * Return:
+ * * true - This mmio exit has been processed.
+ * * false - This mmio exit has not been processed, require userspace.
+ */
+static bool gzvm_vcpu_handle_mmio(struct gzvm_vcpu *vcpu)
+{
+	__u64 addr;
+	__u32 len;
+	const void *val_ptr;
+
+	/* So far, we don't have in-kernel mmio read handler */
+	if (!vcpu->run->mmio.is_write)
+		return false;
+	addr = vcpu->run->mmio.phys_addr;
+	len = vcpu->run->mmio.size;
+	val_ptr = &vcpu->run->mmio.data;
+
+	return gzvm_ioevent_write(vcpu, addr, len, val_ptr);
+}
+
 /**
  * gzvm_vcpu_run() - Handle vcpu run ioctl, entry point to guest and exit
  *		     point from guest
- * @argp: pointer to struct gzvm_vcpu_run in userspace
+ * @argp: Pointer to struct gzvm_vcpu_run in userspace
  */
 static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 {
@@ -70,7 +94,8 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 
 		switch (exit_reason) {
 		case GZVM_EXIT_MMIO:
-			need_userspace = true;
+			if (!gzvm_vcpu_handle_mmio(vcpu))
+				need_userspace = true;
 			break;
 		/**
 		 * it's geniezone's responsibility to fill corresponding data
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index eb34d7ba94a2..6d31c25cec6b 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -304,6 +304,15 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_irqfd(gzvm, &data);
 		break;
 	}
+	case GZVM_IOEVENTFD: {
+		struct gzvm_ioeventfd data;
+
+		ret = -EFAULT;
+		if (copy_from_user(&data, argp, sizeof(data)))
+			goto out;
+		ret = gzvm_ioeventfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -384,6 +393,14 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(ret);
 	}
 
+	ret = gzvm_init_ioeventfd(gzvm);
+	if (ret) {
+		dev_err(&gzvm_debug_dev->dev,
+			"Failed to initialize ioeventfd\n");
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index a54a7915c514..3c9f617d6bf1 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -6,6 +6,7 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <linux/eventfd.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
@@ -91,6 +92,8 @@ struct gzvm {
 		struct mutex      resampler_lock;
 	} irqfds;
 
+	struct list_head ioevents;
+
 	struct list_head vm_list;
 	gzvm_id_t vm_id;
 
@@ -140,4 +143,12 @@ void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu);
 
 extern struct platform_device *gzvm_debug_dev;
 
+int gzvm_init_ioeventfd(struct gzvm *gzvm);
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr);
+void add_wait_queue_priority(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index b878b25ff963..02adb0305f70 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -248,4 +248,27 @@ struct gzvm_irqfd {
 
 #define GZVM_IRQFD	_IOW(GZVM_IOC_MAGIC, 0x76, struct gzvm_irqfd)
 
+enum {
+	gzvm_ioeventfd_flag_nr_datamatch,
+	gzvm_ioeventfd_flag_nr_pio,
+	gzvm_ioeventfd_flag_nr_deassign,
+	gzvm_ioeventfd_flag_nr_max,
+};
+
+#define GZVM_IOEVENTFD_FLAG_DATAMATCH	(1 << gzvm_ioeventfd_flag_nr_datamatch)
+#define GZVM_IOEVENTFD_FLAG_PIO		(1 << gzvm_ioeventfd_flag_nr_pio)
+#define GZVM_IOEVENTFD_FLAG_DEASSIGN	(1 << gzvm_ioeventfd_flag_nr_deassign)
+#define GZVM_IOEVENTFD_VALID_FLAG_MASK	((1 << gzvm_ioeventfd_flag_nr_max) - 1)
+
+struct gzvm_ioeventfd {
+	__u64 datamatch;
+	__u64 addr;        /* legal pio/mmio address */
+	__u32 len;         /* 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__s32 fd;
+	__u32 flags;
+	__u8  pad[36];
+};
+
+#define GZVM_IOEVENTFD	_IOW(GZVM_IOC_MAGIC, 0x79, struct gzvm_ioeventfd)
+
 #endif /* __GZVM__H__ */
-- 
2.18.0

