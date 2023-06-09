Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9DD7293C7
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbjFIIw5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239457AbjFIIw0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:52:26 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66FE1A2;
        Fri,  9 Jun 2023 01:52:24 -0700 (PDT)
X-UUID: f011916a06a211ee9cb5633481061a41-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=X7wcBrEaHWLOUtDgMILeaZX2vag11MpM/W3SGT2LI10=;
        b=giN08sQLoNSDswGv1ufrWWEnisBT/iKngLg9TrW8hN35gkyVgz620sNwTX9ST0NNyj2Rykat2UinX4XkXp3LIWZaSNgExmRZq879huxm0tAGTdmKJpEdNS/wwEvkdD4d3jTTubxh3Kx0JE4osX9exwlVMiZl7UMYLLDiWy89ucU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:b3b3e3d3-a93a-42e3-9fff-13a36ccd4b5e,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:47,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:22
X-CID-INFO: VERSION:1.1.26,REQID:b3b3e3d3-a93a-42e3-9fff-13a36ccd4b5e,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:47,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:22
X-CID-META: VersionHash:cb9a4e1,CLOUDID:facd1b3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230609165219GNSLQJB0,BulkQuantity:0,Recheck:0,SF:48|101|38|29|28|100
        |17|19|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,
        TF_CID_SPAM_SNR
X-UUID: f011916a06a211ee9cb5633481061a41-20230609
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2025850479; Fri, 09 Jun 2023 16:52:17 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
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
Subject: [PATCH v4 7/9] virt: geniezone: Add memory region support
Date:   Fri, 9 Jun 2023 16:52:12 +0800
Message-ID: <20230609085214.31071-8-yi-de.wu@mediatek.com>
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

From: "Jerry Wang" <ze-yu.wang@mediatek.com>

Hypervisor might need to know the precise purpose of each memory
region, so that it can provide specific memory protection. We add a new
uapi to pass address and size of a memory region and its purpose.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h | 2 ++
 arch/arm64/geniezone/vm.c               | 9 +++++++++
 drivers/virt/geniezone/gzvm_vm.c        | 1 +
 include/linux/gzvm_drv.h                | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 5affa28b935a..5cfeb4df84c5 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -23,6 +23,7 @@ enum {
 	GZVM_FUNC_CREATE_DEVICE,
 	GZVM_FUNC_PROBE,
 	GZVM_FUNC_ENABLE_CAP,
+	GZVM_FUNC_MEMREGION_PURPOSE,
 	NR_GZVM_FUNC
 };
 
@@ -46,6 +47,7 @@ enum {
 #define MT_HVC_GZVM_CREATE_DEVICE	GZVM_HCALL_ID(GZVM_FUNC_CREATE_DEVICE)
 #define MT_HVC_GZVM_PROBE		GZVM_HCALL_ID(GZVM_FUNC_PROBE)
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
+#define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
 #define GIC_V3_NR_LRS			16
 
 /**
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 9f1f14f71b99..e19a66d6a75d 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -97,6 +97,15 @@ int gzvm_arch_destroy_vm(gzvm_id_t vm_id)
 				    0, 0, &res);
 }
 
+int gzvm_arch_memregion_purpose(struct gzvm *gzvm, struct gzvm_userspace_memory_region *mem)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_MEMREGION_PURPOSE, gzvm->vm_id,
+				    mem->guest_phys_addr, mem->memory_size,
+				    mem->flags, 0, 0, 0, &res);
+}
+
 static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm, struct gzvm_enable_cap *cap,
 				   struct arm_smccc_res *res)
 {
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index ba5412acfa7d..3b1cb715ef34 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -248,6 +248,7 @@ gzvm_vm_ioctl_set_memory_region(struct gzvm *gzvm,
 	memslot->vma = vma;
 	memslot->flags = mem->flags;
 	memslot->slot_id = mem->slot;
+	gzvm_arch_memregion_purpose(gzvm, mem);
 	return register_memslot_addr_range(gzvm, memslot);
 }
 
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index f0a172fb0dd8..288a339bf382 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -145,6 +145,8 @@ void gzvm_sync_hwstate(struct gzvm_vcpu *vcpu);
 
 extern struct miscdevice *gzvm_debug_dev;
 
+int gzvm_arch_memregion_purpose(struct gzvm *gzvm, struct gzvm_userspace_memory_region *mem);
+
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
 bool gzvm_ioevent_write(struct gzvm_vcpu *vcpu, __u64 addr, int len,
-- 
2.18.0

