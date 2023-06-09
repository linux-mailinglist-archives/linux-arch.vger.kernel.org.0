Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A617293B8
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239469AbjFIIwz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239953AbjFIIw1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:52:27 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8096173A;
        Fri,  9 Jun 2023 01:52:25 -0700 (PDT)
X-UUID: f0a37bf206a211ee9cb5633481061a41-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=EIUqCM6uV08j23+ms0Il6VpldEmAn0HvRqmQNNz91rY=;
        b=ZJHFp2G+Fi4VYoFuB30yIW/5RCtP9TwGXATQrEo5ThZZHRpD9hrTudPf6a9tsuLdk6KCDecwjfS0G1scvjodtX86GLWAvXCMITeKes+krQiS8l49gDpOAhbx7/aBT1iMJVrGIH0j05WGsJaxQojahEagXB8DoYuCRxV4y5OtNHg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:d629a266-9fe3-4c26-8a4d-2c06590a3a76,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:89f8ea3d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f0a37bf206a211ee9cb5633481061a41-20230609
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 186619215; Fri, 09 Jun 2023 16:52:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 16:52:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 16:52:16 +0800
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
        "Conor Dooley" <conor.dooley@microchip.com>,
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
        "Willix Yeh" <chi-shen.yeh@mediatek.com>
Subject: [PATCH v4 9/9] virt: geniezone: Add virtual timer support
Date:   Fri, 9 Jun 2023 16:52:14 +0800
Message-ID: <20230609085214.31071-10-yi-de.wu@mediatek.com>
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

From: "Willix Yeh" <chi-shen.yeh@mediatek.com>

Implement vtimer migration handler.
- Using hrtimer for guest vtimer migration
- Identify migrate flag to do register hrtimer

Signed-off-by: Willix Yeh <chi-shen.yeh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
 arch/arm64/geniezone/vcpu.c             | 40 +++++++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vcpu.c      | 34 +++++++++++++++++++++
 drivers/virt/geniezone/gzvm_vm.c        | 10 +++++++
 include/linux/gzvm_drv.h                |  9 ++++++
 include/uapi/linux/gzvm.h               |  2 ++
 6 files changed, 97 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index ccd2a7516eeb..a7ee6b959c18 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -80,6 +80,8 @@ static inline gzvm_vcpu_id_t get_vcpuid_from_tuple(unsigned int tuple)
 struct gzvm_vcpu_hwstate {
 	__u32 nr_lrs;
 	__u64 lr[GIC_V3_NR_LRS];
+	__u64 vtimer_delay;
+	__u32 vtimer_migrate;
 };
 
 static inline unsigned int
diff --git a/arch/arm64/geniezone/vcpu.c b/arch/arm64/geniezone/vcpu.c
index 8d2572bdf053..b26393a355bd 100644
--- a/arch/arm64/geniezone/vcpu.c
+++ b/arch/arm64/geniezone/vcpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/clocksource.h>
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
@@ -40,15 +41,54 @@ int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
 	return ret;
 }
 
+static void clear_migrate_state(struct gzvm_vcpu *vcpu)
+{
+	vcpu->hwstate->vtimer_migrate = 0;
+	vcpu->hwstate->vtimer_delay = 0;
+}
+
+static u64 gzvm_mtimer_delay_time(u64 delay)
+{
+	u64 ns;
+
+	ns = clocksource_cyc2ns(delay, timecycle.mult, timecycle.shift);
+
+	return ns;
+}
+
+static void gzvm_mtimer_release(struct gzvm_vcpu *vcpu)
+{
+	hrtimer_cancel(&vcpu->gzvm_mtimer);
+
+	clear_migrate_state(vcpu);
+}
+
+static void gzvm_mtimer_catch(struct hrtimer *hrt, u64 delay)
+{
+	u64 ns;
+
+	ns = gzvm_mtimer_delay_time(delay);
+	hrtimer_start(hrt, ktime_add_ns(ktime_get(), ns), HRTIMER_MODE_ABS_HARD);
+}
+
 int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason)
 {
 	struct arm_smccc_res res;
 	unsigned long a1;
 	int ret;
 
+	/* hrtimer cancel and clear migrate state */
+	if (vcpu->hwstate->vtimer_migrate)
+		gzvm_mtimer_release(vcpu);
+
 	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
 	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_RUN, a1, 0, 0, 0, 0, 0,
 				   0, &res);
+
+	/* hrtimer register if migration needed */
+	if (vcpu->hwstate->vtimer_migrate)
+		gzvm_mtimer_catch(&vcpu->gzvm_mtimer, vcpu->hwstate->vtimer_delay);
+
 	*exit_reason = res.a1;
 	return ret;
 }
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 40b57d85eaa2..74001589571e 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -5,12 +5,14 @@
 
 #include <asm/sysreg.h>
 #include <linux/anon_inodes.h>
+#include <linux/clocksource.h>
 #include <linux/device.h>
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/gzvm_drv.h>
+#include "gzvm_common.h"
 
 /* maximum size needed for holding an integer */
 #define ITOA_MAX_LEN 12
@@ -73,6 +75,33 @@ static bool gzvm_vcpu_handle_mmio(struct gzvm_vcpu *vcpu)
 	return gzvm_ioevent_write(vcpu, addr, len, val_ptr);
 }
 
+static void mtimer_irq_forward(struct gzvm_vcpu *vcpu)
+{
+	struct gzvm *gzvm;
+	unsigned int irq_num, irq_type, vcpu_idx;
+
+	gzvm = vcpu->gzvm;
+
+	irq_num = (GZVM_VTIMER_IRQ >> GZVM_IRQ_NUM_SHIFT) & GZVM_IRQ_NUM_MASK;
+	irq_type = (GZVM_VTIMER_IRQ >> GZVM_IRQ_TYPE_SHIFT) & GZVM_IRQ_TYPE_MASK;
+	vcpu_idx = (GZVM_VTIMER_IRQ >> GZVM_IRQ_VCPU_SHIFT) & GZVM_IRQ_VCPU_MASK;
+	vcpu_idx += ((GZVM_VTIMER_IRQ >> GZVM_IRQ_VCPU2_SHIFT) & GZVM_IRQ_VCPU2_MASK) *
+		     (GZVM_IRQ_VCPU_MASK + 1);
+
+	gzvm_irqchip_inject_irq(gzvm, vcpu_idx, irq_type, irq_num, 1);
+}
+
+static enum hrtimer_restart gzvm_mtimer_expire(struct hrtimer *hrt)
+{
+	struct gzvm_vcpu *vcpu;
+
+	vcpu = container_of(hrt, struct gzvm_vcpu, gzvm_mtimer);
+
+	mtimer_irq_forward(vcpu);
+
+	return HRTIMER_NORESTART;
+}
+
 /**
  * gzvm_vcpu_run() - Handle vcpu run ioctl, entry point to guest and exit
  *		     point from guest
@@ -172,6 +201,7 @@ static void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
 	if (!vcpu)
 		return;
 
+	hrtimer_cancel(&vcpu->gzvm_mtimer);
 	gzvm_arch_destroy_vcpu(vcpu->gzvm->vm_id, vcpu->vcpuid);
 	/* clean guest's data */
 	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
@@ -241,6 +271,10 @@ int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
 	vcpu->gzvm = gzvm;
 	mutex_init(&vcpu->lock);
 
+	/* gzvm_mtimer init based on hrtimer */
+	hrtimer_init(&vcpu->gzvm_mtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	vcpu->gzvm_mtimer.function = gzvm_mtimer_expire;
+
 	ret = gzvm_arch_create_vcpu(gzvm->vm_id, vcpu->vcpuid, vcpu->run);
 	if (ret < 0)
 		goto free_vcpu_run;
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index d379793deace..74268d294800 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/anon_inodes.h>
+#include <linux/clocksource.h>
 #include <linux/file.h>
 #include <linux/kdev_t.h>
 #include <linux/miscdevice.h>
@@ -17,6 +18,8 @@
 static DEFINE_MUTEX(gzvm_list_lock);
 static LIST_HEAD(gzvm_list);
 
+struct timecycle timecycle;
+
 /**
  * hva_to_pa_fast() - converts hva to pa in generic fast way
  *
@@ -474,6 +477,13 @@ static struct gzvm *gzvm_create_vm(unsigned long vm_type)
 		return ERR_PTR(ret);
 	}
 
+	/* timecycle init mult shift */
+	clocks_calc_mult_shift(&timecycle.mult,
+			       &timecycle.shift,
+			       arch_timer_get_cntfrq(),
+			       NSEC_PER_SEC,
+			       10);
+
 	mutex_lock(&gzvm_list_lock);
 	list_add(&gzvm->vm_list, &gzvm_list);
 	mutex_unlock(&gzvm_list_lock);
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index e920397e83d3..5953cc1ff8fc 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -6,6 +6,7 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <asm/arch_timer.h>
 #include <linux/eventfd.h>
 #include <linux/list.h>
 #include <linux/miscdevice.h>
@@ -40,6 +41,13 @@
 
 #define GZVM_VCPU_RUN_MAP_SIZE		(PAGE_SIZE * 2)
 
+struct timecycle {
+	u32 mult;
+	u32 shift;
+};
+
+extern struct timecycle timecycle;
+
 /* struct mem_region_addr_range - Identical to ffa memory constituent */
 struct mem_region_addr_range {
 	/* the base IPA of the constituent memory region, aligned to 4 kiB */
@@ -74,6 +82,7 @@ struct gzvm_vcpu {
 	struct mutex lock;
 	struct gzvm_vcpu_run *run;
 	struct gzvm_vcpu_hwstate *hwstate;
+	struct hrtimer gzvm_mtimer;
 };
 
 struct gzvm {
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 28354c17ed9c..b1c42145823a 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -61,6 +61,8 @@ struct gzvm_userspace_memory_region {
 #define GZVM_SET_USER_MEMORY_REGION _IOW(GZVM_IOC_MAGIC, 0x46, \
 					 struct gzvm_userspace_memory_region)
 
+#define GZVM_VTIMER_IRQ			27
+
 /* for GZVM_IRQ_LINE, irq field index values */
 #define GZVM_IRQ_VCPU2_SHIFT		28
 #define GZVM_IRQ_VCPU2_MASK		0xf
-- 
2.18.0

