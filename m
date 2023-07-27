Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C413E7649C7
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjG0ID5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbjG0ICu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D114EC8;
        Thu, 27 Jul 2023 01:00:22 -0700 (PDT)
X-UUID: 9fba05d62c5311ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JajbX1Okju+0tr5aqbH4Ib57jLX1HZ9NfnHfbV9V2II=;
        b=JxIXttrdTcG3y21qQTvuuuzxzO+gPA65r0P96e62b8RdeBAfIqggFYCK4DPB0uyqsil7HfHt/3hVWj5WJZR6Z5rTGMjP2rd5pqWTLXb0inG/o1DbqfITVv7xTZziO0SHIn7z93Z4sh1E+lTq0n29YRzySLqYIBuHygEemwCsv8I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:b51d582e-525a-4850-b671-b546e96228d5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:e7562a7,CLOUDID:46a862d2-cd77-4e67-bbfd-aa4eaace762f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 9fba05d62c5311ee9cb5633481061a41-20230727
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1208337025; Thu, 27 Jul 2023 16:00:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Jul 2023 16:00:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Jul 2023 16:00:15 +0800
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
Subject: [PATCH v5 12/12] virt: geniezone: Add memory pin/unpin support
Date:   Thu, 27 Jul 2023 16:00:05 +0800
Message-ID: <20230727080005.14474-13-yi-de.wu@mediatek.com>
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

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Implement memory pin/unpin.
- use rb_tree to store pinned memory page
- pin page when handling page fault
- unpin page when handling relinquish or destroy

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 drivers/virt/geniezone/Makefile         |   3 +-
 drivers/virt/geniezone/gzvm_exception.c |  32 ----
 drivers/virt/geniezone/gzvm_hvc.c       |  34 ++++
 drivers/virt/geniezone/gzvm_mmu.c       | 210 ++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      |   4 +-
 drivers/virt/geniezone/gzvm_vm.c        | 113 +++----------
 include/linux/gzvm_drv.h                |  19 ++-
 include/uapi/linux/gzvm.h               |   5 +
 8 files changed, 291 insertions(+), 129 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_hvc.c
 create mode 100644 drivers/virt/geniezone/gzvm_mmu.c

diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index e1299f99df76..ca4b84630573 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -8,4 +8,5 @@ GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
 	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o \
-	  $(GZVM_DIR)/gzvm_ioeventfd.o $(GZVM_DIR)/gzvm_exception.o
+	  $(GZVM_DIR)/gzvm_ioeventfd.o $(GZVM_DIR)/gzvm_exception.o \
+	  $(GZVM_DIR)/gzvm_hvc.o $(GZVM_DIR)/gzvm_mmu.o
diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
index c2cab1472d2f..8c413815369b 100644
--- a/drivers/virt/geniezone/gzvm_exception.c
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -6,38 +6,6 @@
 #include <linux/device.h>
 #include <linux/gzvm_drv.h>
 
-/**
- * gzvm_handle_page_fault() - Handle guest page fault, find corresponding page
- *                            for the faulting gpa
- * @vcpu: Pointer to struct gzvm_vcpu_run of the faulting vcpu
- *
- * Return:
- * * 0			- Success to handle guest page fault
- * * -EFAULT		- Failed to map phys addr to guest's GPA
- */
-static int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
-{
-	struct gzvm *vm = vcpu->gzvm;
-	int memslot_id;
-	u64 pfn, gfn;
-	int ret;
-
-	gfn = PHYS_PFN(vcpu->run->exception.fault_gpa);
-	memslot_id = gzvm_find_memslot(vm, gfn);
-	if (unlikely(memslot_id < 0))
-		return -EFAULT;
-
-	ret = gzvm_gfn_to_pfn_memslot(&vm->memslot[memslot_id], gfn, &pfn);
-	if (unlikely(ret))
-		return -EFAULT;
-
-	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
-	if (unlikely(ret))
-		return -EFAULT;
-
-	return 0;
-}
-
 /**
  * gzvm_handle_guest_exception() - Handle guest exception
  * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
diff --git a/drivers/virt/geniezone/gzvm_hvc.c b/drivers/virt/geniezone/gzvm_hvc.c
new file mode 100644
index 000000000000..d8854eeec04e
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_hvc.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/gzvm_drv.h>
+
+/**
+ * gzvm_handle_guest_hvc() - Handle guest hvc
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * Return:
+ * * true - This hvc has been processed, no need to back to VMM.
+ * * false - This hvc has not been processed, require userspace.
+ */
+bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu)
+{
+	int ret;
+	unsigned long ipa;
+
+	switch (vcpu->run->hypercall.args[0]) {
+	case GZVM_HVC_MEM_RELINQUISH:
+		ipa = vcpu->run->hypercall.args[1];
+		ret = gzvm_handle_relinquish(vcpu, ipa);
+		break;
+	default:
+		ret = false;
+		break;
+	}
+
+	if (!ret)
+		return true;
+	else
+		return false;
+}
diff --git a/drivers/virt/geniezone/gzvm_mmu.c b/drivers/virt/geniezone/gzvm_mmu.c
new file mode 100644
index 000000000000..4c2c7da7f929
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_mmu.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/gzvm_drv.h>
+
+/**
+ * hva_to_pa_fast() - converts hva to pa in generic fast way
+ * @hva: Host virtual address.
+ *
+ * Return: 0 if translation error
+ */
+u64 hva_to_pa_fast(u64 hva)
+{
+	struct page *page[1];
+
+	u64 pfn;
+
+	if (get_user_page_fast_only(hva, 0, page)) {
+		pfn = page_to_phys(page[0]);
+		put_page((struct page *)page);
+		return pfn;
+	} else {
+		return 0;
+	}
+}
+
+/**
+ * hva_to_pa_slow() - note that this function may sleep
+ * @hva: Host virtual address.
+ *
+ * Return: 0 if translation error
+ */
+u64 hva_to_pa_slow(u64 hva)
+{
+	struct page *page = NULL;
+	u64 pfn = 0;
+	int npages;
+
+	npages = get_user_pages_unlocked(hva, 1, &page, 0);
+	if (npages != 1)
+		return 0;
+
+	if (page) {
+		pfn = page_to_phys(page);
+		put_page(page);
+	}
+
+	return pfn;
+}
+
+static u64 __gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn)
+{
+	u64 hva, pa;
+
+	hva = gzvm_gfn_to_hva_memslot(memslot, gfn);
+
+	pa = gzvm_hva_to_pa_arch(hva);
+	if (pa != 0)
+		return PHYS_PFN(pa);
+
+	pa = hva_to_pa_fast(hva);
+	if (pa)
+		return PHYS_PFN(pa);
+
+	pa = hva_to_pa_slow(hva);
+	if (pa)
+		return PHYS_PFN(pa);
+
+	return 0;
+}
+
+/**
+ * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host pa),
+ *			       result is in @pfn
+ * @memslot: Pointer to struct gzvm_memslot.
+ * @gfn: Guest frame number.
+ * @pfn: Host page frame number.
+ *
+ * Return:
+ * * 0			- Succeed
+ * * -EFAULT		- Failed to convert
+ */
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
+{
+	u64 __pfn;
+
+	if (!memslot)
+		return -EFAULT;
+
+	__pfn = __gzvm_gfn_to_pfn_memslot(memslot, gfn);
+	if (__pfn == 0) {
+		*pfn = 0;
+		return -EFAULT;
+	}
+
+	*pfn = __pfn;
+
+	return 0;
+}
+
+static int cmp_ppages(struct rb_node *node, const struct rb_node *parent)
+{
+	struct gzvm_pinned_page *a = container_of(node, struct gzvm_pinned_page, node);
+	struct gzvm_pinned_page *b = container_of(parent, struct gzvm_pinned_page, node);
+
+	if (a->ipa < b->ipa)
+		return -1;
+	if (a->ipa > b->ipa)
+		return 1;
+	return 0;
+}
+
+static int rb_ppage_cmp(const void *key, const struct rb_node *node)
+{
+	struct gzvm_pinned_page *p = container_of(node, struct gzvm_pinned_page, node);
+	phys_addr_t ipa = (phys_addr_t)key;
+
+	return (ipa < p->ipa) ? -1 : (ipa > p->ipa);
+}
+
+static int gzvm_insert_ppage(struct gzvm *vm, struct gzvm_pinned_page *ppage)
+{
+	if (rb_find_add(&ppage->node, &vm->pinned_pages, cmp_ppages))
+		return -EEXIST;
+	return 0;
+}
+
+static int pin_one_page(unsigned long hva, struct page **page)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned int flags = FOLL_HWPOISON | FOLL_LONGTERM | FOLL_WRITE;
+
+	mmap_read_lock(mm);
+	pin_user_pages(hva, 1, flags, page);
+	mmap_read_unlock(mm);
+
+	return 0;
+}
+
+/**
+ * gzvm_handle_relinquish() - Handle memory relinquish request from hypervisor
+ *
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * @ipa: Start address(gpa) of a reclaimed page
+ */
+int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa)
+{
+	struct gzvm_pinned_page *ppage;
+	struct rb_node *node;
+	struct gzvm *vm = vcpu->gzvm;
+
+	node = rb_find((void *)ipa, &vm->pinned_pages, rb_ppage_cmp);
+
+	if (node)
+		rb_erase(node, &vm->pinned_pages);
+	else
+		return 0;
+
+	ppage = container_of(node, struct gzvm_pinned_page, node);
+	unpin_user_pages_dirty_lock(&ppage->page, 1, true);
+	kfree(ppage);
+	return 0;
+}
+
+/**
+ * gzvm_handle_page_fault() - Handle guest page fault, find corresponding page
+ * for the faulting gpa
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ */
+int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
+{
+	struct gzvm *vm = vcpu->gzvm;
+	int memslot_id;
+	u64 pfn, gfn;
+	unsigned long hva;
+	struct gzvm_pinned_page *ppage = NULL;
+	struct page *page = NULL;
+	int ret;
+
+	gfn = PHYS_PFN(vcpu->run->exception.fault_gpa);
+	memslot_id = gzvm_find_memslot(vm, gfn);
+	if (unlikely(memslot_id < 0))
+		return -EFAULT;
+
+	ret = gzvm_gfn_to_pfn_memslot(&vm->memslot[memslot_id], gfn, &pfn);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	ret = gzvm_arch_map_guest(vm->vm_id, memslot_id, pfn, gfn, 1);
+	if (unlikely(ret))
+		return -EFAULT;
+
+	hva = gzvm_gfn_to_hva_memslot(&vm->memslot[memslot_id], gfn);
+	pin_one_page(hva, &page);
+
+	if (!page)
+		return -EFAULT;
+
+	ppage = kmalloc(sizeof(*ppage), GFP_KERNEL_ACCOUNT);
+	if (!ppage)
+		return -ENOMEM;
+
+	ppage->page = page;
+	ppage->ipa = vcpu->run->exception.fault_gpa;
+	gzvm_insert_ppage(vm, ppage);
+
+	return 0;
+}
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 794b24da40e2..964e18ff0d2a 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -117,7 +117,9 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 				need_userspace = true;
 			break;
 		case GZVM_EXIT_HYPERCALL:
-			fallthrough;
+			if (!gzvm_handle_guest_hvc(vcpu))
+				need_userspace = true;
+			break;
 		case GZVM_EXIT_DEBUG:
 			fallthrough;
 		case GZVM_EXIT_FAIL_ENTRY:
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 3da5fdc141b6..6fae6bf976c8 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -16,106 +16,13 @@
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
 
-/**
- * hva_to_pa_fast() - converts hva to pa in generic fast way
- * @hva: Host virtual address.
- *
- * Return: 0 if translation error
- */
-static u64 hva_to_pa_fast(u64 hva)
-{
-	struct page *page[1];
-
-	u64 pfn;
-
-	if (get_user_page_fast_only(hva, 0, page)) {
-		pfn = page_to_phys(page[0]);
-		put_page((struct page *)page);
-		return pfn;
-	} else {
-		return 0;
-	}
-}
-
-/**
- * hva_to_pa_slow() - note that this function may sleep
- * @hva: Host virtual address.
- *
- * Return: 0 if translation error
- */
-static u64 hva_to_pa_slow(u64 hva)
-{
-	struct page *page;
-	int npages;
-	u64 pfn;
-
-	npages = get_user_pages_unlocked(hva, 1, &page, 0);
-	if (npages != 1)
-		return 0;
-
-	pfn = page_to_phys(page);
-	put_page(page);
-
-	return pfn;
-}
-
-static u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn)
+u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn)
 {
 	u64 offset = gfn - memslot->base_gfn;
 
 	return memslot->userspace_addr + offset * PAGE_SIZE;
 }
 
-static u64 __gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn)
-{
-	u64 hva, pa;
-
-	hva = gzvm_gfn_to_hva_memslot(memslot, gfn);
-
-	pa = gzvm_hva_to_pa_arch(hva);
-	if (pa != 0)
-		return PHYS_PFN(pa);
-
-	pa = hva_to_pa_fast(hva);
-	if (pa)
-		return PHYS_PFN(pa);
-
-	pa = hva_to_pa_slow(hva);
-	if (pa)
-		return PHYS_PFN(pa);
-
-	return 0;
-}
-
-/**
- * gzvm_gfn_to_pfn_memslot() - Translate gfn (guest ipa) to pfn (host pa),
- *			       result is in @pfn
- * @memslot: Pointer to struct gzvm_memslot.
- * @gfn: Guest frame number.
- * @pfn: Host page frame number.
- *
- * Return:
- * * 0			- Succeed
- * * -EFAULT		- Failed to convert
- */
-int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
-{
-	u64 __pfn;
-
-	if (!memslot)
-		return -EFAULT;
-
-	__pfn = __gzvm_gfn_to_pfn_memslot(memslot, gfn);
-	if (__pfn == 0) {
-		*pfn = 0;
-		return -EFAULT;
-	}
-
-	*pfn = __pfn;
-
-	return 0;
-}
-
 /**
  * gzvm_find_memslot() - Find memslot containing this @gpa
  * @vm: Pointer to struct gzvm
@@ -454,6 +361,21 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 	return ret;
 }
 
+static void gzvm_destroy_ppage(struct gzvm *gzvm)
+{
+	struct gzvm_pinned_page *ppage;
+	struct rb_node *node;
+
+	node = rb_first(&gzvm->pinned_pages);
+	while (node) {
+		ppage = rb_entry(node, struct gzvm_pinned_page, node);
+		unpin_user_pages_dirty_lock(&ppage->page, 1, true);
+		node = rb_next(node);
+		rb_erase(&ppage->node, &gzvm->pinned_pages);
+		kfree(ppage);
+	}
+}
+
 static void gzvm_destroy_vm(struct gzvm *gzvm)
 {
 	pr_debug("VM-%u is going to be destroyed\n", gzvm->vm_id);
@@ -470,6 +392,8 @@ static void gzvm_destroy_vm(struct gzvm *gzvm)
 
 	mutex_unlock(&gzvm->lock);
 
+	gzvm_destroy_ppage(gzvm);
+
 	kfree(gzvm);
 }
 
@@ -505,6 +429,7 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 	gzvm->vm_id = ret;
 	gzvm->mm = current->mm;
 	mutex_init(&gzvm->lock);
+	gzvm->pinned_pages = RB_ROOT;
 
 	ret = gzvm_vm_irqfd_init(gzvm);
 	if (ret) {
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index d7838679c700..a0bc3b4244cc 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -12,6 +12,8 @@
 #include <linux/mutex.h>
 #include <linux/gzvm.h>
 #include <linux/srcu.h>
+#include <linux/rbtree.h>
+#include <linux/mm.h>
 
 #define GZVM_VCPU_MMAP_SIZE  PAGE_SIZE
 #define INVALID_VM_ID   0xffff
@@ -76,6 +78,12 @@ struct gzvm_vcpu {
 	struct hrtimer gzvm_mtimer;
 };
 
+struct gzvm_pinned_page {
+	struct rb_node node;
+	struct page *page;
+	u64 ipa;
+};
+
 struct gzvm {
 	struct gzvm_vcpu *vcpus[GZVM_MAX_VCPUS];
 	/* userspace tied to this vm */
@@ -102,6 +110,9 @@ struct gzvm {
 	struct srcu_struct irq_srcu;
 	/* lock for irq injection */
 	struct mutex irq_lock;
+
+	/* Use rb-tree to record pin/unpin page */
+	struct rb_root pinned_pages;
 };
 
 long gzvm_dev_ioctl_check_extension(struct gzvm *gzvm, unsigned long args);
@@ -137,9 +148,15 @@ int gzvm_arch_inform_exit(u16 vm_id);
 int gzvm_arch_drv_init(void);
 void gzvm_arch_drv_exit(void);
 
-int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
 int gzvm_find_memslot(struct gzvm *vm, u64 gpa);
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
+u64 gzvm_gfn_to_hva_memslot(struct gzvm_memslot *memslot, u64 gfn);
+u64 hva_to_pa_fast(u64 hva);
+u64 hva_to_pa_slow(u64 hva);
+int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu);
+int gzvm_handle_relinquish(struct gzvm_vcpu *vcpu, phys_addr_t ipa);
 bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
+bool gzvm_handle_guest_hvc(struct gzvm_vcpu *vcpu);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index a3329b713089..74b959994c4a 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -156,6 +156,11 @@ enum {
 	GZVM_EXCEPTION_PAGE_FAULT = 0x1,
 };
 
+/* hypercall definitions of GZVM_EXIT_HYPERCALL */
+enum {
+	GZVM_HVC_MEM_RELINQUISH = 0xc6000009,
+};
+
 /**
  * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
  *			shared between userspace, kernel and
-- 
2.18.0

