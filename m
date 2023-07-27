Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEAE7649DB
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjG0IEB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjG0IC5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:57 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F992D6A;
        Thu, 27 Jul 2023 01:00:27 -0700 (PDT)
X-UUID: a1dbd9162c5311eeb20a276fd37b9834-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=p2GyGPgxhUeib9OzFY8+R6HPXaYfHL3ozLtu4OzCty4=;
        b=n07PUM5w1eAiE320ivZfzyQM5kv87YfxBIi7zh9U5sG3eZ1q7jujNLF0yolHctFAMbtn6LYNZ7oVImNRpE2EwSFsHzXzE8DmpyUKZyl4PyDnGdFNqsCOhz+/uKYnt6B22d/l650IWmeLSkdEelVe45jFmCre1giONGjLWuZBt4s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:52686774-fb4b-4ce3-ab36-65c38278dd11,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.29,REQID:52686774-fb4b-4ce3-ab36-65c38278dd11,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:e7562a7,CLOUDID:c3998342-d291-4e62-b539-43d7d78362ba,B
        ulkID:230727160017RU7JY85L,BulkQuantity:1,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
        OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,
        TF_CID_SPAM_FAS
X-UUID: a1dbd9162c5311eeb20a276fd37b9834-20230727
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1083839230; Thu, 27 Jul 2023 16:00:20 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
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
Subject: [PATCH v5 10/12] virt: geniezone: Add virtual timer support
Date:   Thu, 27 Jul 2023 16:00:03 +0800
Message-ID: <20230727080005.14474-11-yi-de.wu@mediatek.com>
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

From: "Willix Yeh" <chi-shen.yeh@mediatek.com>

Implement vtimer migration handler.
- Using hrtimer for guest vtimer migration
- Identify migrate flag to do register hrtimer

Signed-off-by: Willix Yeh <chi-shen.yeh@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/Makefile           |  2 +-
 arch/arm64/geniezone/driver.c           | 26 ++++++++
 arch/arm64/geniezone/gzvm_arch_common.h | 18 ++++++
 arch/arm64/geniezone/vcpu.c             | 83 ++++++++++++++++++++++---
 arch/arm64/geniezone/vgic.c             | 16 +++++
 drivers/virt/geniezone/gzvm_main.c      |  5 ++
 drivers/virt/geniezone/gzvm_vcpu.c      |  4 +-
 include/linux/gzvm_drv.h                |  8 ++-
 8 files changed, 149 insertions(+), 13 deletions(-)
 create mode 100644 arch/arm64/geniezone/driver.c

diff --git a/arch/arm64/geniezone/Makefile b/arch/arm64/geniezone/Makefile
index 0e4f1087f9de..59e04cc0a000 100644
--- a/arch/arm64/geniezone/Makefile
+++ b/arch/arm64/geniezone/Makefile
@@ -4,6 +4,6 @@
 #
 include $(srctree)/drivers/virt/geniezone/Makefile
 
-gzvm-y += vm.o vcpu.o vgic.o
+gzvm-y += vm.o vcpu.o vgic.o driver.o
 
 obj-$(CONFIG_MTK_GZVM) += gzvm.o
diff --git a/arch/arm64/geniezone/driver.c b/arch/arm64/geniezone/driver.c
new file mode 100644
index 000000000000..fb6ec0fed4d8
--- /dev/null
+++ b/arch/arm64/geniezone/driver.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 MediaTek Inc.
+ */
+
+#include <linux/clocksource.h>
+#include <linux/gzvm_drv.h>
+#include "gzvm_arch_common.h"
+
+struct timecycle clock_scale_factor;
+
+int gzvm_arch_drv_init(void)
+{
+	/* clock_scale_factor init mult shift */
+	clocks_calc_mult_shift(&clock_scale_factor.mult,
+			       &clock_scale_factor.shift,
+			       arch_timer_get_cntfrq(),
+			       NSEC_PER_SEC,
+			       10);
+
+	return 0;
+}
+
+void gzvm_arch_drv_exit(void)
+{
+}
diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 82d2c44e819b..e51310be2376 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -51,6 +51,13 @@ enum {
 
 #define GIC_V3_NR_LRS			16
 
+struct timecycle {
+	u32 mult;
+	u32 shift;
+};
+
+extern struct timecycle clock_scale_factor;
+
 /**
  * gzvm_hypcall_wrapper() - the wrapper for hvc calls
  * @a0-a7: arguments passed in registers 0 to 7
@@ -84,14 +91,22 @@ static inline u16 get_vcpuid_from_tuple(unsigned int tuple)
  * @__pad: add an explicit '__u32 __pad;' in the middle to make it clear
  *         what the actual layout is.
  * @lr: The array of LRs(list registers).
+ * @vtimer_delay: The remaining time until the next tick of guest VM.
+ * @vtimer_migrate: The switch flag used for guest VM to do vtimer migration or not.
+ * @vtimer_irq_num: vtimer irq number.
  *
  * - Keep the same layout of hypervisor data struct.
  * - Sync list registers back for acking virtual device interrupt status.
+ * - Sync timer registers back for migrating timer to host's hwtimer to keep
+ *   timer working in background.
  */
 struct gzvm_vcpu_hwstate {
 	__le32 nr_lrs;
 	__le32 __pad;
 	__le64 lr[GIC_V3_NR_LRS];
+	__le64 vtimer_delay;
+	__le32 vtimer_migrate;
+	__le32 vtimer_irq_num;
 };
 
 static inline unsigned int
@@ -107,4 +122,7 @@ disassemble_vm_vcpu_tuple(unsigned int tuple, u16 *vmid, u16 *vcpuid)
 	*vcpuid = get_vcpuid_from_tuple(tuple);
 }
 
+int gzvm_vgic_inject_ppi(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 irq, bool level);
+
 #endif /* __GZVM_ARCH_COMMON_H__ */
diff --git a/arch/arm64/geniezone/vcpu.c b/arch/arm64/geniezone/vcpu.c
index 95681fd66656..b26bbadf10a0 100644
--- a/arch/arm64/geniezone/vcpu.c
+++ b/arch/arm64/geniezone/vcpu.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/clocksource.h>
 #include <linux/err.h>
 #include <linux/uaccess.h>
 
@@ -40,25 +41,91 @@ int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
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
+	ns = clocksource_cyc2ns(delay, clock_scale_factor.mult,
+				clock_scale_factor.shift);
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
+static void mtimer_irq_forward(struct gzvm_vcpu *vcpu)
+{
+	gzvm_vgic_inject_ppi(vcpu->gzvm, vcpu->vcpuid,
+			     vcpu->hwstate->vtimer_irq_num, 1);
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
+static void vtimer_init(struct gzvm_vcpu *vcpu)
+{
+	/* gzvm_mtimer init based on hrtimer */
+	hrtimer_init(&vcpu->gzvm_mtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_HARD);
+	vcpu->gzvm_mtimer.function = gzvm_mtimer_expire;
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
 
-int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid)
+int gzvm_arch_destroy_vcpu(struct gzvm_vcpu *vcpu)
 {
 	struct arm_smccc_res res;
 	unsigned long a1;
 
-	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
+	hrtimer_cancel(&vcpu->gzvm_mtimer);
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
 	gzvm_hypcall_wrapper(MT_HVC_GZVM_DESTROY_VCPU, a1, 0, 0, 0, 0, 0, 0,
 			     &res);
 
@@ -67,20 +134,20 @@ int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid)
 
 /**
  * gzvm_arch_create_vcpu() - Call smc to gz hypervisor to create vcpu
- * @vm_id: vm id
- * @vcpuid: vcpu id
- * @run: Virtual address of vcpu->run
+ * @vcpu: Pointer to struct gzvm_vcpu
  *
  * Return: The wrapper helps caller to convert geniezone errno to Linux errno.
  */
-int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run)
+int gzvm_arch_create_vcpu(struct gzvm_vcpu *vcpu)
 {
 	struct arm_smccc_res res;
 	unsigned long a1, a2;
 	int ret;
 
-	a1 = assemble_vm_vcpu_tuple(vm_id, vcpuid);
-	a2 = (__u64)virt_to_phys(run);
+	vtimer_init(vcpu);
+
+	a1 = assemble_vm_vcpu_tuple(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	a2 = (__u64)virt_to_phys(vcpu->run);
 	ret = gzvm_hypcall_wrapper(MT_HVC_GZVM_CREATE_VCPU, a1, a2, 0, 0, 0, 0,
 				   0, &res);
 
diff --git a/arch/arm64/geniezone/vgic.c b/arch/arm64/geniezone/vgic.c
index 3746e0c9e247..e24728997b57 100644
--- a/arch/arm64/geniezone/vgic.c
+++ b/arch/arm64/geniezone/vgic.c
@@ -91,6 +91,22 @@ static int gzvm_vgic_inject_spi(struct gzvm *gzvm, unsigned int vcpu_idx,
 				    level);
 }
 
+/**
+ * gzvm_vgic_inject_ppi() - Inject virtual ppi interrupt
+ * @gzvm: Pointer to struct gzvm
+ * @vcpu_idx: vcpu index
+ * @irq: This is spi interrupt number (starts from 0 instead of 32)
+ * @level: 1 if true else 0
+ *
+ * Return:
+ * * 0 if succeed else other negative values indicating each errors
+ */
+int gzvm_vgic_inject_ppi(struct gzvm *gzvm, unsigned int vcpu_idx,
+			 u32 irq, bool level)
+{
+	return gzvm_vgic_inject_irq(gzvm, 0, GZVM_IRQ_TYPE_PPI, irq, level);
+}
+
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev)
 {
 	struct arm_smccc_res res;
diff --git a/drivers/virt/geniezone/gzvm_main.c b/drivers/virt/geniezone/gzvm_main.c
index d4d5d75d3660..a4c235f3ff01 100644
--- a/drivers/virt/geniezone/gzvm_main.c
+++ b/drivers/virt/geniezone/gzvm_main.c
@@ -106,6 +106,10 @@ static int gzvm_drv_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	ret = gzvm_arch_drv_init();
+	if (ret)
+		return ret;
+
 	ret = misc_register(&gzvm_dev);
 	if (ret)
 		return ret;
@@ -121,6 +125,7 @@ static int gzvm_drv_remove(struct platform_device *pdev)
 	gzvm_drv_irqfd_exit();
 	gzvm_destroy_all_vms();
 	misc_deregister(&gzvm_dev);
+	gzvm_arch_drv_exit();
 	return 0;
 }
 
diff --git a/drivers/virt/geniezone/gzvm_vcpu.c b/drivers/virt/geniezone/gzvm_vcpu.c
index 72bd122a8be7..8dac8ba4c0cf 100644
--- a/drivers/virt/geniezone/gzvm_vcpu.c
+++ b/drivers/virt/geniezone/gzvm_vcpu.c
@@ -188,7 +188,7 @@ static void gzvm_destroy_vcpu(struct gzvm_vcpu *vcpu)
 	if (!vcpu)
 		return;
 
-	gzvm_arch_destroy_vcpu(vcpu->gzvm->vm_id, vcpu->vcpuid);
+	gzvm_arch_destroy_vcpu(vcpu);
 	/* clean guest's data */
 	memset(vcpu->run, 0, GZVM_VCPU_RUN_MAP_SIZE);
 	free_pages_exact(vcpu->run, GZVM_VCPU_RUN_MAP_SIZE);
@@ -257,7 +257,7 @@ int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid)
 	vcpu->gzvm = gzvm;
 	mutex_init(&vcpu->lock);
 
-	ret = gzvm_arch_create_vcpu(gzvm->vm_id, vcpu->vcpuid, vcpu->run);
+	ret = gzvm_arch_create_vcpu(vcpu);
 	if (ret < 0)
 		goto free_vcpu_run;
 
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 7bc00218dce6..e5b21ac9215b 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -6,6 +6,7 @@
 #ifndef __GZVM_DRV_H__
 #define __GZVM_DRV_H__
 
+#include <asm/arch_timer.h>
 #include <linux/eventfd.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -71,6 +72,7 @@ struct gzvm_vcpu {
 	struct mutex lock;
 	struct gzvm_vcpu_run *run;
 	struct gzvm_vcpu_hwstate *hwstate;
+	struct hrtimer gzvm_mtimer;
 };
 
 struct gzvm {
@@ -125,10 +127,12 @@ u64 gzvm_hva_to_pa_arch(u64 hva);
 int gzvm_vm_ioctl_create_vcpu(struct gzvm *gzvm, u32 cpuid);
 int gzvm_arch_vcpu_update_one_reg(struct gzvm_vcpu *vcpu, __u64 reg_id,
 				  bool is_write, __u64 *data);
-int gzvm_arch_create_vcpu(u16 vm_id, int vcpuid, void *run);
+int gzvm_arch_create_vcpu(struct gzvm_vcpu *vcpu);
 int gzvm_arch_vcpu_run(struct gzvm_vcpu *vcpu, __u64 *exit_reason);
-int gzvm_arch_destroy_vcpu(u16 vm_id, int vcpuid);
+int gzvm_arch_destroy_vcpu(struct gzvm_vcpu *vcpu);
 int gzvm_arch_inform_exit(u16 vm_id);
+int gzvm_arch_drv_init(void);
+void gzvm_arch_drv_exit(void);
 
 int gzvm_arch_create_device(u16 vm_id, struct gzvm_create_device *gzvm_dev);
 int gzvm_arch_inject_irq(struct gzvm *gzvm, unsigned int vcpu_idx,
-- 
2.18.0

