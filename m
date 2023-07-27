Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFD7649CD
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjG0ID6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbjG0ICu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D480126A8;
        Thu, 27 Jul 2023 01:00:21 -0700 (PDT)
X-UUID: 9f41a47e2c5311ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=1sbzAAq0pL+hANw50K0jFP/mmk99nt1Mb8BD/sWj5o0=;
        b=kW9K7NEQb98srDCVoluUxHXMGt+nLRIclst7FcUTWyyXpGRUmtuSnYsysfpGxraLjNWySJalikE9mlZ4GE8RL0eepmStX5BghzNideb5cP9axdngsJaiDV6X7ju9UYWetAzGlPsOuIFyyM/98pARHZ6d4tLJkWX3qwmnCqKACVs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:18f482a3-6d8d-4f73-bfe3-9ccf4936a5db,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.29,REQID:18f482a3-6d8d-4f73-bfe3-9ccf4936a5db,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:e7562a7,CLOUDID:73998342-d291-4e62-b539-43d7d78362ba,B
        ulkID:230727160017115FM6O1,BulkQuantity:0,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 9f41a47e2c5311ee9cb5633481061a41-20230727
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 296318186; Thu, 27 Jul 2023 16:00:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
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
Subject: [PATCH v5 07/12] virt: geniezone: Add ioeventfd support
Date:   Thu, 27 Jul 2023 16:00:00 +0800
Message-ID: <20230727080005.14474-8-yi-de.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230727080005.14474-1-yi-de.wu@mediatek.com>
References: <20230727080005.14474-1-yi-de.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_ioeventfd.c | 273 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      |  27 ++-
 drivers/virt/geniezone/gzvm_vm.c        |  17 ++
 include/linux/gzvm_drv.h                |  12 ++
 include/uapi/linux/gzvm.h               |  25 +++
 6 files changed, 355 insertions(+), 2 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_ioeventfd.c

diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 19a835b0aac2..bc5ae49f2407 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,4 +7,5 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
-	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o
+	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o \
+	  $(GZVM_DIR)/gzvm_ioeventfd.o
diff --git a/drivers/virt/geniezone/gzvm_ioeventfd.c b/drivers/virt/geniezone/gzvm_ioeventfd.c
new file mode 100644
index 000000000000..8d41db16ada2
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_ioeventfd.c
@@ -0,0 +1,273 @@
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
+ *
+ * Return:
+ * * true			- collison found
+ * * false			- no collison
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
+ * Return:
+ * * true if user arguments are valid.
+ * * false if user arguments are invalid.
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
+ *
+ * Return:
+ * * 0			- Success.
+ * * Negative		- Failure.
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
+ * Return:
+ * * true if this io is already sent to ioeventfd's listener.
+ * * false if we cannot find any ioeventfd registering this mmio write.
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
index a717fc713b2e..72bd122a8be7 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -50,6 +50,30 @@ static long gzvm_vcpu_update_one_reg(struct gzvm_vcpu *vcpu,
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
@@ -81,7 +105,8 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 
 		switch (exit_reason) {
 		case GZVM_EXIT_MMIO:
-			need_userspace = true;
+			if (!gzvm_vcpu_handle_mmio(vcpu))
+				need_userspace = true;
 			break;
 		/**
 		 * it's geniezone's responsibility to fill corresponding data
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index a93f5b0e7078..60bd017e41fa 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -386,6 +386,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_irqfd(gzvm, &data);
 		break;
 	}
+	case GZVM_IOEVENTFD: {
+		struct gzvm_ioeventfd data;
+
+		if (copy_from_user(&data, argp, sizeof(data))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_ioeventfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -462,6 +472,13 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(ret);
 	}
 
+	ret = gzvm_init_ioeventfd(gzvm);
+	if (ret) {
+		pr_err("Failed to initialize ioeventfd\n");
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index af7043d66567..d2985e4df4a0 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -6,6 +6,7 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <linux/eventfd.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
@@ -89,6 +90,8 @@ struct gzvm {
 		struct mutex      resampler_lock;
 	} irqfds;
 
+	struct list_head ioevents;
+
 	struct list_head vm_list;
 	u16 vm_id;
 
@@ -138,4 +141,13 @@ void gzvm_drv_irqfd_exit(void);
 int gzvm_vm_irqfd_init(struct gzvm *gzvm);
 void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
+int gzvm_init_ioeventfd(struct gzvm *gzvm);
+int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
+bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
+			const void *val);
+void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt);
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr);
+void add_wait_queue_priority(struct wait_queue_head *wq_head,
+			     struct wait_queue_entry *wq_entry);
+
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index f4b16d70f035..506ef975de02 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -301,4 +301,29 @@ struct gzvm_irqfd {
 
 #define GZVM_IRQFD	_IOW(GZVM_IOC_MAGIC, 0x76, struct gzvm_irqfd)
 
+enum {
+	gzvm_ioeventfd_flag_nr_datamatch = 0,
+	gzvm_ioeventfd_flag_nr_pio = 1,
+	gzvm_ioeventfd_flag_nr_deassign = 2,
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
+	/* private: legal pio/mmio address */
+	__u64 addr;
+	/* private: 1, 2, 4, or 8 bytes; or 0 to ignore length */
+	__u32 len;
+	__s32 fd;
+	__u32 flags;
+	__u8  pad[36];
+};
+
+#define GZVM_IOEVENTFD	_IOW(GZVM_IOC_MAGIC, 0x79, struct gzvm_ioeventfd)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0

