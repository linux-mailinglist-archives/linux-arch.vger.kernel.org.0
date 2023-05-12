Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AEE700238
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240405AbjELIFu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 04:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240413AbjELIEy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 04:04:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A8211B78;
        Fri, 12 May 2023 01:04:16 -0700 (PDT)
X-UUID: 932c4fc0f09b11edb20a276fd37b9834-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WvavxkIXfFSmquLoSHWtRn8G3Upwg2chJaG1DCsaQQk=;
        b=Ra6jF50PgSzauvfm38De24ftn08tmNcMZCKhADH8DAO6LvBS87uKTlsRVyK9FY0YhYD8cduLrFQH/7q+8LAEJMkOJobmU+rWp4f0R8ecO8cW/+undQxPXWuaMiUGQl1xQ7ZXRZpZoz+IhQJig1okbSM6mSqOTBdZbyThem26c/E=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:d4ec292b-d171-4d74-848a-35241cee5577,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.24,REQID:d4ec292b-d171-4d74-848a-35241cee5577,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:178d4d4,CLOUDID:1365f53a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230512160411S4XULEVQ,BulkQuantity:1,Recheck:0,SF:19|48|38|29|28|17,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 932c4fc0f09b11edb20a276fd37b9834-20230512
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 85647774; Fri, 12 May 2023 16:04:09 +0800
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
Subject: [PATCH v3 6/7] virt: geniezone: Add irqfd support
Date:   Fri, 12 May 2023 16:04:04 +0800
Message-ID: <20230512080405.12043-7-yi-de.wu@mediatek.com>
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

irqfd enables other threads than vcpu threads to inject virtual
interrupt through irqfd asynchronously rather through ioctl interface.
This interface is necessary for VMM which creates separated thread for
IO handling or uses vhost devices.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |   6 +
 drivers/virt/geniezone/Makefile         |   4 +-
 drivers/virt/geniezone/gzvm_irqfd.c     | 537 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |   5 +
 drivers/virt/geniezone/gzvm_vcpu.c      |   1 +
 drivers/virt/geniezone/gzvm_vm.c        |  18 +
 include/linux/gzvm_drv.h                |  27 ++
 include/uapi/linux/gzvm.h               |  20 +-
 8 files changed, 615 insertions(+), 3 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_irqfd.c

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 1b315264bf24..5affa28b935a 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -46,6 +46,7 @@ enum {
 #define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
+#define GIC_V3_NR_LRS			16
 
 /**
  * gzvm_hypercall_wrapper()
@@ -72,6 +73,11 @@ static inline gzvm_vcpu_id_t get_vcpuid_from_tuple(unsigned int tuple)
 	return (gzvm_vcpu_id_t)(tuple & 0xffff);
 }
 
+struct gzvm_vcpu_hwstate {
+	__u32 nr_lrs;
+	__u64 lr[GIC_V3_NR_LRS];
+};
+
 static inline unsigned int
 assemble_vm_vcpu_tuple(gzvm_id_t vmid, gzvm_vcpu_id_t vcpuid)
 {
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index 67ba3ed76ea7..aa52cee3ca8e 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -7,5 +7,5 @@
 GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
-	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqchip.o
-
+	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqchip.o \
+	  $(GZVM_DIR)/gzvm_irqfd.o
diff --git a/drivers/virt/geniezone/gzvm_irqfd.c b/drivers/virt/geniezone/gzvm_irqfd.c
new file mode 100644
index 000000000000..3a395b972fdf
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_irqfd.c
@@ -0,0 +1,537 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/eventfd.h>
+#include <linux/syscalls.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
+
+struct gzvm_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned int gsi;
+	void (*irq_acked)(struct gzvm_irq_ack_notifier *ian);
+};
+
+/**
+ * struct gzvm_kernel_irqfd_resampler - irqfd resampler descriptor.
+ * @gzvm: Poiner to gzvm.
+ * @list_head list: List of resampling struct _irqfd objects sharing this gsi.
+ *		    RCU list modified under gzvm->irqfds.resampler_lock.
+ * @notifier: gzvm irq ack notifier.
+ * @list_head link: Entry in list of gzvm->irqfd.resampler_list.
+ *		    Use for sharing esamplers among irqfds on the same gsi.
+ *		    Accessed and modified under gzvm->irqfds.resampler_lock.
+ *
+ * Resampling irqfds are a special variety of irqfds used to emulate
+ * level triggered interrupts.  The interrupt is asserted on eventfd
+ * trigger.  On acknowledgment through the irq ack notifier, the
+ * interrupt is de-asserted and userspace is notified through the
+ * resamplefd.  All resamplers on the same gsi are de-asserted
+ * together, so we don't need to track the state of each individual
+ * user.  We can also therefore share the same irq source ID.
+ */
+struct gzvm_kernel_irqfd_resampler {
+	struct gzvm *gzvm;
+
+	struct list_head list;
+	struct gzvm_irq_ack_notifier notifier;
+
+	struct list_head link;
+};
+
+/**
+ * struct gzvm_kernel_irqfd: gzvm kernel irqfd descriptor.
+ * @gzvm: Pointer to gzvm.
+ * @wait: Wait queue entry.
+ * @gsi: Used for level IRQ fast-path.
+ * @resampler: The resampler used by this irqfd (resampler-only).
+ * @resamplefd: Eventfd notified on resample (resampler-only).
+ * @resampler_link: Entry in list of irqfds for a resampler (resampler-only).
+ * @eventfd: Used for setup/shutdown.
+ */
+struct gzvm_kernel_irqfd {
+	struct gzvm *gzvm;
+	wait_queue_entry_t wait;
+
+	int gsi;
+
+	struct gzvm_kernel_irqfd_resampler *resampler;
+
+	struct eventfd_ctx *resamplefd;
+
+	struct list_head resampler_link;
+
+	struct eventfd_ctx *eventfd;
+	struct list_head list;
+	poll_table pt;
+	struct work_struct shutdown;
+};
+
+static struct workqueue_struct *irqfd_cleanup_wq;
+
+/**
+ * irqfd_set_spi(): irqfd to inject virtual interrupt.
+ * @gzvm: Pointer to gzvm.
+ * @irq_source_id: irq source id.
+ * @irq: This is spi interrupt number (starts from 0 instead of 32).
+ * @level: irq triggered level.
+ * @line_status: irq status.
+ */
+static void irqfd_set_spi(struct gzvm *gzvm, int irq_source_id, u32 irq,
+			  int level, bool line_status)
+{
+	if (level)
+		gzvm_irqchip_inject_irq(gzvm, irq_source_id, 0, irq, level);
+}
+
+/**
+ * irqfd_resampler_ack() - Notify all of the resampler irqfds using this GSI
+ *			   when IRQ de-assert once.
+ * @ian: Pointer to gzvm_irq_ack_notifier.
+ *
+ * Since resampler irqfds share an IRQ source ID, we de-assert once
+ * then notify all of the resampler irqfds using this GSI.  We can't
+ * do multiple de-asserts or we risk racing with incoming re-asserts.
+ */
+static void irqfd_resampler_ack(struct gzvm_irq_ack_notifier *ian)
+{
+	struct gzvm_kernel_irqfd_resampler *resampler;
+	struct gzvm *gzvm;
+	struct gzvm_kernel_irqfd *irqfd;
+	int idx;
+
+	resampler = container_of(ian,
+				 struct gzvm_kernel_irqfd_resampler, notifier);
+	gzvm = resampler->gzvm;
+
+	irqfd_set_spi(gzvm, GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
+		      resampler->notifier.gsi, 0, false);
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+
+	list_for_each_entry_srcu(irqfd, &resampler->list, resampler_link,
+				 srcu_read_lock_held(&gzvm->irq_srcu)) {
+		eventfd_signal(irqfd->resamplefd, 1);
+	}
+
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+}
+
+static void gzvm_register_irq_ack_notifier(struct gzvm *gzvm,
+					   struct gzvm_irq_ack_notifier *ian)
+{
+	mutex_lock(&gzvm->irq_lock);
+	hlist_add_head_rcu(&ian->link, &gzvm->irq_ack_notifier_list);
+	mutex_unlock(&gzvm->irq_lock);
+}
+
+static void gzvm_unregister_irq_ack_notifier(struct gzvm *gzvm,
+					     struct gzvm_irq_ack_notifier *ian)
+{
+	mutex_lock(&gzvm->irq_lock);
+	hlist_del_init_rcu(&ian->link);
+	mutex_unlock(&gzvm->irq_lock);
+	synchronize_srcu(&gzvm->irq_srcu);
+}
+
+static void irqfd_resampler_shutdown(struct gzvm_kernel_irqfd *irqfd)
+{
+	struct gzvm_kernel_irqfd_resampler *resampler = irqfd->resampler;
+	struct gzvm *gzvm = resampler->gzvm;
+
+	mutex_lock(&gzvm->irqfds.resampler_lock);
+
+	list_del_rcu(&irqfd->resampler_link);
+	synchronize_srcu(&gzvm->irq_srcu);
+
+	if (list_empty(&resampler->list)) {
+		list_del(&resampler->link);
+		gzvm_unregister_irq_ack_notifier(gzvm, &resampler->notifier);
+		irqfd_set_spi(gzvm, GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
+			      resampler->notifier.gsi, 0, false);
+		kfree(resampler);
+	}
+
+	mutex_unlock(&gzvm->irqfds.resampler_lock);
+}
+
+/**
+ * irqfd_shutdown() - Race-free decouple logic (ordering is critical).
+ * @work: Pointer to work_struct.
+ */
+static void irqfd_shutdown(struct work_struct *work)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(work, struct gzvm_kernel_irqfd, shutdown);
+	struct gzvm *gzvm = irqfd->gzvm;
+	u64 cnt;
+
+	/* Make sure irqfd has been initialized in assign path. */
+	synchronize_srcu(&gzvm->irq_srcu);
+
+	/*
+	 * Synchronize with the wait-queue and unhook ourselves to prevent
+	 * further events.
+	 */
+	eventfd_ctx_remove_wait_queue(irqfd->eventfd, &irqfd->wait, &cnt);
+
+	if (irqfd->resampler) {
+		irqfd_resampler_shutdown(irqfd);
+		eventfd_ctx_put(irqfd->resamplefd);
+	}
+
+	/*
+	 * It is now safe to release the object's resources
+	 */
+	eventfd_ctx_put(irqfd->eventfd);
+	kfree(irqfd);
+}
+
+/**
+ * irqfd_is_active() - Assumes gzvm->irqfds.lock is held.
+ * @irqfd: Pointer to gzvm_kernel_irqfd.
+ */
+static bool irqfd_is_active(struct gzvm_kernel_irqfd *irqfd)
+{
+	return list_empty(&irqfd->list) ? false : true;
+}
+
+/**
+ * irqfd_deactivate() - Mark the irqfd as inactive and schedule it for removal.
+ *			assumes gzvm->irqfds.lock is held.
+ * @irqfd: Pointer to gzvm_kernel_irqfd.
+ */
+static void irqfd_deactivate(struct gzvm_kernel_irqfd *irqfd)
+{
+	if (!irqfd_is_active(irqfd))
+		return;
+
+	list_del_init(&irqfd->list);
+
+	queue_work(irqfd_cleanup_wq, &irqfd->shutdown);
+}
+
+/**
+ * irqfd_wakeup() - Wake up irqfd to do virtual interrupt injection.
+ * @wait: Pointer to wait_queue_entry_t.
+ * @mode:
+ * @sync:
+ * @key:
+ */
+static int irqfd_wakeup(wait_queue_entry_t *wait, unsigned int mode, int sync,
+			void *key)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(wait, struct gzvm_kernel_irqfd, wait);
+	__poll_t flags = key_to_poll(key);
+	struct gzvm *gzvm = irqfd->gzvm;
+
+	if (flags & EPOLLIN) {
+		u64 cnt;
+
+		eventfd_ctx_do_read(irqfd->eventfd, &cnt);
+		/* gzvm's irq injection is not blocked, don't need workq */
+		irqfd_set_spi(gzvm, GZVM_USERSPACE_IRQ_SOURCE_ID, irqfd->gsi,
+			      1, false);
+	}
+
+	if (flags & EPOLLHUP) {
+		/* The eventfd is closing, detach from GZVM */
+		unsigned long iflags;
+
+		spin_lock_irqsave(&gzvm->irqfds.lock, iflags);
+
+		/*
+		 * Do more check if someone deactivated the irqfd before
+		 * we could acquire the irqfds.lock.
+		 */
+		if (irqfd_is_active(irqfd))
+			irqfd_deactivate(irqfd);
+
+		spin_unlock_irqrestore(&gzvm->irqfds.lock, iflags);
+	}
+
+	return 0;
+}
+
+static void irqfd_ptable_queue_proc(struct file *file, wait_queue_head_t *wqh,
+				    poll_table *pt)
+{
+	struct gzvm_kernel_irqfd *irqfd =
+		container_of(pt, struct gzvm_kernel_irqfd, pt);
+	add_wait_queue_priority(wqh, &irqfd->wait);
+}
+
+static int gzvm_irqfd_assign(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+	struct fd f;
+	struct eventfd_ctx *eventfd = NULL, *resamplefd = NULL;
+	int ret;
+	__poll_t events;
+	int idx;
+
+	irqfd = kzalloc(sizeof(*irqfd), GFP_KERNEL_ACCOUNT);
+	if (!irqfd)
+		return -ENOMEM;
+
+	irqfd->gzvm = gzvm;
+	irqfd->gsi = args->gsi;
+	irqfd->resampler = NULL;
+
+	INIT_LIST_HEAD(&irqfd->list);
+	INIT_WORK(&irqfd->shutdown, irqfd_shutdown);
+
+	f = fdget(args->fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto out;
+	}
+
+	eventfd = eventfd_ctx_fileget(f.file);
+	if (IS_ERR(eventfd)) {
+		ret = PTR_ERR(eventfd);
+		goto fail;
+	}
+
+	irqfd->eventfd = eventfd;
+
+	if (args->flags & GZVM_IRQFD_FLAG_RESAMPLE) {
+		struct gzvm_kernel_irqfd_resampler *resampler;
+
+		resamplefd = eventfd_ctx_fdget(args->resamplefd);
+		if (IS_ERR(resamplefd)) {
+			ret = PTR_ERR(resamplefd);
+			goto fail;
+		}
+
+		irqfd->resamplefd = resamplefd;
+		INIT_LIST_HEAD(&irqfd->resampler_link);
+
+		mutex_lock(&gzvm->irqfds.resampler_lock);
+
+		list_for_each_entry(resampler,
+				    &gzvm->irqfds.resampler_list, link) {
+			if (resampler->notifier.gsi == irqfd->gsi) {
+				irqfd->resampler = resampler;
+				break;
+			}
+		}
+
+		if (!irqfd->resampler) {
+			resampler = kzalloc(sizeof(*resampler),
+					    GFP_KERNEL_ACCOUNT);
+			if (!resampler) {
+				ret = -ENOMEM;
+				mutex_unlock(&gzvm->irqfds.resampler_lock);
+				goto fail;
+			}
+
+			resampler->gzvm = gzvm;
+			INIT_LIST_HEAD(&resampler->list);
+			resampler->notifier.gsi = irqfd->gsi;
+			resampler->notifier.irq_acked = irqfd_resampler_ack;
+			INIT_LIST_HEAD(&resampler->link);
+
+			list_add(&resampler->link, &gzvm->irqfds.resampler_list);
+			gzvm_register_irq_ack_notifier(gzvm,
+						       &resampler->notifier);
+			irqfd->resampler = resampler;
+		}
+
+		list_add_rcu(&irqfd->resampler_link, &irqfd->resampler->list);
+		synchronize_srcu(&gzvm->irq_srcu);
+
+		mutex_unlock(&gzvm->irqfds.resampler_lock);
+	}
+
+	/*
+	 * Install our own custom wake-up handling so we are notified via
+	 * a callback whenever someone signals the underlying eventfd
+	 */
+	init_waitqueue_func_entry(&irqfd->wait, irqfd_wakeup);
+	init_poll_funcptr(&irqfd->pt, irqfd_ptable_queue_proc);
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	ret = 0;
+	list_for_each_entry(tmp, &gzvm->irqfds.items, list) {
+		if (irqfd->eventfd != tmp->eventfd)
+			continue;
+		/* This fd is used for another irq already. */
+		pr_err("already used: gsi=%d fd=%d\n", args->gsi, args->fd);
+		ret = -EBUSY;
+		spin_unlock_irq(&gzvm->irqfds.lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+
+	list_add_tail(&irqfd->list, &gzvm->irqfds.items);
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+
+	/*
+	 * Check if there was an event already pending on the eventfd
+	 * before we registered, and trigger it as if we didn't miss it.
+	 */
+	events = vfs_poll(f.file, &irqfd->pt);
+
+	/* In case there is already a pending event */
+	if (events & EPOLLIN)
+		irqfd_set_spi(gzvm, GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID,
+			      irqfd->gsi, 1, false);
+
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+
+	/*
+	 * do not drop the file until the irqfd is fully initialized, otherwise
+	 * we might race against the EPOLLHUP
+	 */
+	fdput(f);
+	return 0;
+
+fail:
+	if (irqfd->resampler)
+		irqfd_resampler_shutdown(irqfd);
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
+static void gzvm_notify_acked_gsi(struct gzvm *gzvm, int gsi)
+{
+	struct gzvm_irq_ack_notifier *gian;
+
+	hlist_for_each_entry_srcu(gian, &gzvm->irq_ack_notifier_list,
+				  link, srcu_read_lock_held(&gzvm->irq_srcu))
+		if (gian->gsi == gsi)
+			gian->irq_acked(gian);
+}
+
+void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi)
+{
+	int idx;
+
+	idx = srcu_read_lock(&gzvm->irq_srcu);
+	gzvm_notify_acked_gsi(gzvm, gsi);
+	srcu_read_unlock(&gzvm->irq_srcu, idx);
+}
+
+/**
+ * gzvm_irqfd_deassign() - Shutdown any irqfd's that match fd+gsi.
+ * @gzvm: Pointer to gzvm.
+ * @args: Pointer to gzvm_irqfd.
+ */
+static int gzvm_irqfd_deassign(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+	struct eventfd_ctx *eventfd;
+
+	eventfd = eventfd_ctx_fdget(args->fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list) {
+		if (irqfd->eventfd == eventfd && irqfd->gsi == args->gsi)
+			irqfd_deactivate(irqfd);
+	}
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
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
+int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args)
+{
+	if (args->flags &
+	    ~(GZVM_IRQFD_FLAG_DEASSIGN | GZVM_IRQFD_FLAG_RESAMPLE))
+		return -EINVAL;
+
+	if (args->flags & GZVM_IRQFD_FLAG_DEASSIGN)
+		return gzvm_irqfd_deassign(gzvm, args);
+
+	return gzvm_irqfd_assign(gzvm, args);
+}
+
+/**
+ * gzvm_vm_irqfd_init() - Initialize irqfd data structure per VM
+ */
+int gzvm_vm_irqfd_init(struct gzvm *gzvm)
+{
+	mutex_init(&gzvm->irq_lock);
+
+	spin_lock_init(&gzvm->irqfds.lock);
+	INIT_LIST_HEAD(&gzvm->irqfds.items);
+	INIT_LIST_HEAD(&gzvm->irqfds.resampler_list);
+	if (init_srcu_struct(&gzvm->irq_srcu))
+		return -EINVAL;
+	INIT_HLIST_HEAD(&gzvm->irq_ack_notifier_list);
+	mutex_init(&gzvm->irqfds.resampler_lock);
+
+	return 0;
+}
+
+/**
+ * gzvm_vm_irqfd_release() - This function is called as the gzvm VM fd is being
+ *			  released. Shutdown all irqfds that still remain open.
+ * @gzvm: Pointer to gzvm.
+ */
+void gzvm_vm_irqfd_release(struct gzvm *gzvm)
+{
+	struct gzvm_kernel_irqfd *irqfd, *tmp;
+
+	spin_lock_irq(&gzvm->irqfds.lock);
+
+	list_for_each_entry_safe(irqfd, tmp, &gzvm->irqfds.items, list)
+		irqfd_deactivate(irqfd);
+
+	spin_unlock_irq(&gzvm->irqfds.lock);
+
+	/*
+	 * Block until we know all outstanding shutdown jobs have completed.
+	 */
+	flush_workqueue(irqfd_cleanup_wq);
+}
+
+/**
+ * gzvm_drv_irqfd_init() - Erase flushing work items when a VM exits.
+ *
+ * Create a host-wide workqueue for issuing deferred shutdown requests
+ * aggregated from all vm* instances. We need our own isolated
+ * queue to ease flushing work items when a VM exits.
+ */
+int gzvm_drv_irqfd_init(void)
+{
+	irqfd_cleanup_wq = alloc_workqueue("gzvm-irqfd-cleanup", 0, 0);
+	if (!irqfd_cleanup_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void gzvm_drv_irqfd_exit(void)
+{
+	destroy_workqueue(irqfd_cleanup_wq);
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index e3fe3ad9ffce..121816a09c8e 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -113,11 +113,16 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 		return ret;
 	gzvm_debug_dev = pdev;
 
+	ret = gzvm_drv_irqfd_init();
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
 static int gzvm_drv_remove(struct platform_device *pdev)
 {
+	gzvm_drv_irqfd_exit();
 	destroy_all_vm();
 	misc_deregister(&gzvm_dev);
 	return 0;
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index d1bb2cba1893..fdf6e6297e66 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -211,6 +211,7 @@ int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
 		ret = -ENOMEM;
 		goto free_vcpu;
 	}
+	vcpu->hwstate = (void *)vcpu->run + PAGE_SIZE;
 	vcpu->vcpuid = cpuid;
 	vcpu->gzvm = gzvm;
 	mutex_init(&vcpu->lock);
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 7ed4e4c3c1ee..403192731597 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -298,6 +298,15 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_create_device(gzvm, argp);
 		break;
 	}
+	case GZVM_IRQFD: {
+		struct gzvm_irqfd data;
+
+		ret = -EFAULT;
+		if (copy_from_user(&data, argp, sizeof(data)))
+			goto out;
+		ret = gzvm_irqfd(gzvm, &data);
+		break;
+	}
 	case GZVM_ENABLE_CAP: {
 		struct gzvm_enable_cap cap;
 
@@ -322,6 +331,7 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_lock(&gzvm->lock);
 
+	gzvm_vm_irqfd_release(gzvm);
 	gzvm_destroy_vcpus(gzvm);
 	gzvm_arch_destroy_vm(gzvm->vm_id);
 
@@ -367,6 +377,14 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
 
+	ret = gzvm_vm_irqfd_init(gzvm);
+	if (ret) {
+		dev_err(&gzvm_debug_dev->dev,
+			"Failed to initialize irqfd\n");
+		kfree(gzvm);
+		return ERR_PTR(ret);
+	}
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 1e7c81597e9a..a54a7915c514 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -10,6 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/gzvm.h>
+#include <linux/srcu.h>
 
 #define MODULE_NAME	"gzvm"
 #define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
@@ -25,6 +26,8 @@
 #define ERR_NOT_SUPPORTED       (-24)
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
+#define GZVM_USERSPACE_IRQ_SOURCE_ID            0
+#define GZVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID       1
 
 /*
  * The following data structures are for data transferring between driver and
@@ -68,6 +71,7 @@ struct gzvm_vcpu {
 	/* lock of vcpu*/
 	struct mutex lock;
 	struct gzvm_vcpu_run *run;
+	struct gzvm_vcpu_hwstate *hwstate;
 };
 
 struct gzvm {
@@ -77,8 +81,23 @@ struct gzvm {
 	struct gzvm_memslot memslot[GZVM_MAX_MEM_REGION];
 	/* lock for list_add*/
 	struct mutex lock;
+
+	struct {
+		/* lock for irqfds list operation */
+		spinlock_t        lock;
+		struct list_head  items;
+		struct list_head  resampler_list;
+		/* lock for irqfds resampler */
+		struct mutex      resampler_lock;
+	} irqfds;
+
 	struct list_head vm_list;
 	gzvm_id_t vm_id;
+
+	struct hlist_head irq_ack_notifier_list;
+	struct srcu_struct irq_srcu;
+	/* lock for irq injection */
+	struct mutex irq_lock;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -111,6 +130,14 @@ int gzvm_arch_create_device(gzvm_id_t vm_id, struct gzvm_create_device *gzvm_dev
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx, u32 irq_type,
 			 u32 irq, bool level);
 
+void gzvm_notify_acked_irq(struct gzvm *gzvm, unsigned int gsi);
+int gzvm_irqfd(struct gzvm *gzvm, struct gzvm_irqfd *args);
+int gzvm_drv_irqfd_init(void);
+void gzvm_drv_irqfd_exit(void);
+int gzvm_vm_irqfd_init(struct gzvm *gzvm);
+void gzvm_vm_irqfd_release(struct gzvm *gzvm);
+void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu);
+
 extern struct platform_device *gzvm_debug_dev;
 
 #endif /* __GZVM_DRV_H__ */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index b39ace47d589..0751f9f4f76f 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -226,4 +226,22 @@ struct gzvm_one_reg {
 
 #define GZVM_REG_GENERIC	   0x0000000000000000ULL
 
-#endif /* __GZVM_H__ */
+#define GZVM_IRQFD_FLAG_DEASSIGN	(1 << 0)
+/**
+ * GZVM_IRQFD_FLAG_RESAMPLE indicates resamplefd is valid and specifies
+ * the irqfd to operate in resampling mode for level triggered interrupt
+ * emulation.
+ */
+#define GZVM_IRQFD_FLAG_RESAMPLE	(1 << 1)
+
+struct gzvm_irqfd {
+	__u32 fd;
+	__u32 gsi;
+	__u32 flags;
+	__u32 resamplefd;
+	__u8  pad[16];
+};
+
+#define GZVM_IRQFD	_IOW(GZVM_IOC_MAGIC, 0x76, struct gzvm_irqfd)
+
+#endif /* __GZVM__H__ */
-- 
2.18.0

