Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECB27649D3
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjG0ID7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjG0ICx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:53 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3F4ECE;
        Thu, 27 Jul 2023 01:00:23 -0700 (PDT)
X-UUID: 9f464f922c5311ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=devMYFzSoIEuCUsRGn+dCzHOaJhS9a71RW/2r1uCPF0=;
        b=Rj3UAqPXTg3YP2Dp01YVXt1CwgxCEZSV8R/ovQgYjtjyLr62SaSxUu58Nbv5lki51tbTAV7UWPwAsiPLHlO6GcN4iuW8ySm5HrvG9xFNSeQC2Y4rHGnVHCL7ySjVosxzMphakATOqPs/978KlIfNQimtdoJypuA7pfrScbc7S1Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:078d6cb6-3c49-4daf-aa24-ae5ab05120bd,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.29,REQID:078d6cb6-3c49-4daf-aa24-ae5ab05120bd,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:e7562a7,CLOUDID:781e97a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230727160017QDW4XJ1U,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_SNR
X-UUID: 9f464f922c5311ee9cb5633481061a41-20230727
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1391972622; Thu, 27 Jul 2023 16:00:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
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
Subject: [PATCH v5 11/12] virt: geniezone: Add guest page fault handler
Date:   Thu, 27 Jul 2023 16:00:04 +0800
Message-ID: <20230727080005.14474-12-yi-de.wu@mediatek.com>
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

This page fault handler helps GenieZone hypervisor to do demand paging.
On a lower level translation fault, GenieZone hypervisor will first
check the fault GPA (guest physical address or IPA in ARM) is valid
e.g. within the registered memory region, then it will setup the
vcpu_run->exit_reason with necessary information for returning to
gzvm driver.

With the fault information, the gzvm driver looks up the physical
address and call the MT_HVC_GZVM_MAP_GUEST to request the hypervisor
maps the found PA to the fault GPA (IPA).

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 +
 arch/arm64/geniezone/vm.c               |  9 ++++
 arch/arm64/include/uapi/asm/gzvm_arch.h |  4 ++
 drivers/virt/geniezone/Makefile         |  2 +-
 drivers/virt/geniezone/gzvm_exception.c | 66 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_main.c      |  2 +
 drivers/virt/geniezone/gzvm_vcpu.c      |  6 ++-
 drivers/virt/geniezone/gzvm_vm.c        | 28 ++++++++++-
 include/linux/gzvm_drv.h                |  7 +++
 include/uapi/asm-generic/gzvm_arch.h    |  3 ++
 include/uapi/linux/gzvm.h               | 14 ++++++
 11 files changed, 138 insertions(+), 5 deletions(-)
 create mode 100644 drivers/virt/geniezone/gzvm_exception.c

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index e51310be2376..d4db0ee7bcb8 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -24,6 +24,7 @@ enum {
 	GZVM_FUNC_INFORM_EXIT = 14,
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
 	GZVM_FUNC_SET_DTB_CONFIG = 16,
+	GZVM_FUNC_MAP_GUEST = 17,
 	NR_GZVM_FUNC,
 };
 
@@ -48,6 +49,7 @@ enum {
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 #define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
+#define MT_HVC_GZVM_MAP_GUEST		GZVM_HCALL_ID(GZVM_FUNC_MAP_GUEST)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index a47e1d60dc1f..9d6b22bd1d70 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -240,3 +240,12 @@ u64 gzvm_hva_to_pa_arch(u64 hva)
 
 	return par & PAR_PA47_MASK;
 }
+
+int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
+			u64 nr_pages)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MAP_GUEST, vm_id, memslot_id,
+				    pfn, gfn, nr_pages, 0, 0, &res);
+}
diff --git a/arch/arm64/include/uapi/asm/gzvm_arch.h b/arch/arm64/include/uapi/asm/gzvm_arch.h
index acfe9be0f849..ebb136c2a57a 100644
--- a/arch/arm64/include/uapi/asm/gzvm_arch.h
+++ b/arch/arm64/include/uapi/asm/gzvm_arch.h
@@ -51,4 +51,8 @@
 #define GZVM_VGIC_NR_PPIS		16
 #define GZVM_VGIC_NR_PRIVATE_IRQS	(GZVM_VGIC_NR_SGIS + GZVM_VGIC_NR_PPIS)
 
+struct gzvm_arch_exception {
+	__u64 esr_el2;
+};
+
 #endif /* __GZVM_ARCH_H__ */
diff --git a/drivers/virt/geniezone/Makefile b/drivers/virt/geniezone/Makefile
index bc5ae49f2407..e1299f99df76 100644
--- a/drivers/virt/geniezone/Makefile
+++ b/drivers/virt/geniezone/Makefile
@@ -8,4 +8,4 @@ GZVM_DIR ?= ../../../drivers/virt/geniezone
 
 gzvm-y := $(GZVM_DIR)/gzvm_main.o $(GZVM_DIR)/gzvm_vm.o \
 	  $(GZVM_DIR)/gzvm_vcpu.o $(GZVM_DIR)/gzvm_irqfd.o \
-	  $(GZVM_DIR)/gzvm_ioeventfd.o
+	  $(GZVM_DIR)/gzvm_ioeventfd.o $(GZVM_DIR)/gzvm_exception.o
diff --git a/drivers/virt/geniezone/gzvm_exception.c b/drivers/virt/geniezone/gzvm_exception.c
new file mode 100644
index 000000000000..c2cab1472d2f
--- /dev/null
+++ b/drivers/virt/geniezone/gzvm_exception.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/gzvm_drv.h>
+
+/**
+ * gzvm_handle_page_fault() - Handle guest page fault, find corresponding page
+ *                            for the faulting gpa
+ * @vcpu: Pointer to struct gzvm_vcpu_run of the faulting vcpu
+ *
+ * Return:
+ * * 0			- Success to handle guest page fault
+ * * -EFAULT		- Failed to map phys addr to guest's GPA
+ */
+static int gzvm_handle_page_fault(struct gzvm_vcpu *vcpu)
+{
+	struct gzvm *vm = vcpu->gzvm;
+	int memslot_id;
+	u64 pfn, gfn;
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
+	return 0;
+}
+
+/**
+ * gzvm_handle_guest_exception() - Handle guest exception
+ * @vcpu: Pointer to struct gzvm_vcpu_run in userspace
+ * Return:
+ * * true - This exception has been processed, no need to back to VMM.
+ * * false - This exception has not been processed, require userspace.
+ */
+bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu)
+{
+	int ret;
+
+	switch (vcpu->run->exception.exception) {
+	case GZVM_EXCEPTION_PAGE_FAULT:
+		ret = gzvm_handle_page_fault(vcpu);
+		break;
+	case GZVM_EXCEPTION_UNKNOWN:
+		fallthrough;
+	default:
+		ret = -EFAULT;
+	}
+
+	if (!ret)
+		return true;
+	else
+		return false;
+}
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index a4c235f3ff01..933146f79d4f 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -30,6 +30,8 @@ int gzvm_err_to_errno(unsigned long err)
 		return 0;
 	case ERR_NO_MEMORY:
 		return -ENOMEM;
+	case ERR_INVALID_ARGS:
+		return -EINVAL;
 	case ERR_NOT_SUPPORTED:
 		return -EOPNOTSUPP;
 	case ERR_NOT_IMPLEMENTED:
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 8dac8ba4c0cf..794b24da40e2 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -112,9 +112,11 @@ static long gzvm_vcpu_run(struct gzvm_vcpu *vcpu, void * __user argp)
 		 * it's geniezone's responsibility to fill corresponding data
 		 * structure
 		 */
-		case GZVM_EXIT_HYPERCALL:
-			fallthrough;
 		case GZVM_EXIT_EXCEPTION:
+			if (!gzvm_handle_guest_exception(vcpu))
+				need_userspace = true;
+			break;
+		case GZVM_EXIT_HYPERCALL:
 			fallthrough;
 		case GZVM_EXIT_DEBUG:
 			fallthrough;
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index 8e9967b754df..3da5fdc141b6 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -98,8 +98,7 @@ static u64 __gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn)
  * * 0			- Succeed
  * * -EFAULT		- Failed to convert
  */
-static int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
-				   u64 *pfn)
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn)
 {
 	u64 __pfn;
 
@@ -117,6 +116,31 @@ static int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn,
 	return 0;
 }
 
+/**
+ * gzvm_find_memslot() - Find memslot containing this @gpa
+ * @vm: Pointer to struct gzvm
+ * @gfn: Guest frame number
+ *
+ * Return:
+ * * >=0		- Index of memslot
+ * * -EFAULT		- Not found
+ */
+int gzvm_find_memslot(struct gzvm *vm, u64 gfn)
+{
+	int i;
+
+	for (i = 0; i < GZVM_MAX_MEM_REGION; i++) {
+		if (vm->memslot[i].npages == 0)
+			continue;
+
+		if (gfn >= vm->memslot[i].base_gfn &&
+		    gfn < vm->memslot[i].base_gfn + vm->memslot[i].npages)
+			return i;
+	}
+
+	return -EFAULT;
+}
+
 /**
  * fill_constituents() - Populate pa to buffer until full
  * @consti: Pointer to struct mem_region_addr_range.
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index e5b21ac9215b..d7838679c700 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -23,6 +23,7 @@
  */
 #define NO_ERROR                (0)
 #define ERR_NO_MEMORY           (-5)
+#define ERR_INVALID_ARGS        (-8)
 #define ERR_NOT_SUPPORTED       (-24)
 #define ERR_NOT_IMPLEMENTED     (-27)
 #define ERR_FAULT               (-40)
@@ -119,6 +120,8 @@ int gzvm_arch_set_memregion(u16 vm_id, size_t buf_size,
 int gzvm_arch_check_extension(struct gzvm *gzvm, __u64 cap, void __user *argp);
 int gzvm_arch_create_vm(unsigned long vm_type);
 int gzvm_arch_destroy_vm(u16 vm_id);
+int gzvm_arch_map_guest(u16 vm_id, int memslot_id, u64 pfn, u64 gfn,
+			u64 nr_pages);
 int gzvm_vm_ioctl_arch_enable_cap(struct gzvm *gzvm,
 				  struct gzvm_enable_cap *cap,
 				  void __user *argp);
@@ -134,6 +137,10 @@ int gzvm_arch_inform_exit(u16 vm_id);
 int gzvm_arch_drv_init(void);
 void gzvm_arch_drv_exit(void);
 
+int gzvm_gfn_to_pfn_memslot(struct gzvm_memslot *memslot, u64 gfn, u64 *pfn);
+int gzvm_find_memslot(struct gzvm *vm, u64 gpa);
+bool gzvm_handle_guest_exception(struct gzvm_vcpu *vcpu);
+
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
 			 u32 irq_type, u32 irq, bool level);
diff --git a/include/uapi/asm-generic/gzvm_arch.h b/include/uapi/asm-generic/gzvm_arch.h
index c4cc12716c91..0b2cde406f5a 100644
--- a/include/uapi/asm-generic/gzvm_arch.h
+++ b/include/uapi/asm-generic/gzvm_arch.h
@@ -5,6 +5,9 @@
 
 #ifndef __ASM_GENERIC_GZVM_ARCH_H
 #define __ASM_GENERIC_GZVM_ARCH_H
+
 /* geniezone only supports aarch64 platform for now */
+struct gzvm_arch_exception {
+};
 
 #endif /* __ASM_GENERIC_GZVM_ARCH_H */
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index d37be00fbeea..a3329b713089 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -150,6 +150,12 @@ enum {
 	GZVM_EXIT_GZ = 0x9292000a,
 };
 
+/* exception definitions of GZVM_EXIT_EXCEPTION */
+enum {
+	GZVM_EXCEPTION_UNKNOWN = 0x0,
+	GZVM_EXCEPTION_PAGE_FAULT = 0x1,
+};
+
 /**
  * struct gzvm_vcpu_run: Same purpose as kvm_run, this struct is
  *			shared between userspace, kernel and
@@ -174,6 +180,11 @@ enum {
  *             Handle exception occurred in VM
  * @exception: Which exception vector
  * @error_code: Exception error codes
+ * @fault_gpa: Fault GPA (guest physical address or IPA in ARM)
+ * @reserved: Future-proof reservation and should be zeroed, and this can also
+ *            fix the offset of `gzvm_arch_exception`
+ * @arch: struct gzvm_arch_exception, architecture information for guest
+ *        exception
  * @hypercall: The nested struct in anonymous union.
  *             Some hypercalls issued from VM must be handled
  * @args: The hypercall's arguments
@@ -220,6 +231,9 @@ struct gzvm_vcpu_run {
 		struct {
 			__u32 exception;
 			__u32 error_code;
+			__u64 fault_gpa;
+			__u64 reserved[6];
+			struct gzvm_arch_exception arch;
 		} exception;
 		/* GZVM_EXIT_HYPERCALL */
 		struct {
-- 
2.18.0

