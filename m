Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0CB7649C2
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 10:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjG0IDz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233707AbjG0ICs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 04:02:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9062D5A;
        Thu, 27 Jul 2023 01:00:20 -0700 (PDT)
X-UUID: 9f4421722c5311ee9cb5633481061a41-20230727
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kuvjqFeF2PX7vJRe4rtgoeugWCnXwTtRWu4h4iMaJ5o=;
        b=ei2dpNuX1a+xRLXubZ4j4KT9t50jBJDV+LgYaiGAnpFMAMRiQ8WDLod1U8yF98ljZwcUDg+StSD/O7B6DZJ+GqYyb0QESW9uReM5pR2v0N9p+y7nKmhQZL7zJlA5zT6Jv0kN3ALX0muLCINVf9SN5k+4HQ1MHdSHNPZ34Icn8JE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.29,REQID:080bfffa-ac64-43ed-8822-622ad87de04b,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.29,REQID:080bfffa-ac64-43ed-8822-622ad87de04b,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:e7562a7,CLOUDID:72998342-d291-4e62-b539-43d7d78362ba,B
        ulkID:2307271600176C3W07Z1,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: 9f4421722c5311ee9cb5633481061a41-20230727
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 218634451; Thu, 27 Jul 2023 16:00:16 +0800
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
Subject: [PATCH v5 09/12] virt: geniezone: Add dtb config support
Date:   Thu, 27 Jul 2023 16:00:02 +0800
Message-ID: <20230727080005.14474-10-yi-de.wu@mediatek.com>
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

Hypervisor might need to know the accurate address and size of dtb
passed from userspace. And then hypervisor would parse the dtb and get
vm information.

Signed-off-by: Jerry Wang <ze-yu.wang@mediatek.com>
Signed-off-by: Liju-clr Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 arch/arm64/geniezone/gzvm_arch_common.h |  2 ++
 arch/arm64/geniezone/vm.c               |  9 +++++++++
 drivers/virt/geniezone/gzvm_vm.c        | 10 ++++++++++
 include/linux/gzvm_drv.h                |  1 +
 include/uapi/linux/gzvm.h               | 14 ++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/arch/arm64/geniezone/gzvm_arch_common.h b/arch/arm64/geniezone/gzvm_arch_common.h
index 321f5dbcd616..82d2c44e819b 100644
--- a/arch/arm64/geniezone/gzvm_arch_common.h
+++ b/arch/arm64/geniezone/gzvm_arch_common.h
@@ -23,6 +23,7 @@ enum {
 	GZVM_FUNC_ENABLE_CAP = 13,
 	GZVM_FUNC_INFORM_EXIT = 14,
 	GZVM_FUNC_MEMREGION_PURPOSE = 15,
+	GZVM_FUNC_SET_DTB_CONFIG = 16,
 	NR_GZVM_FUNC,
 };
 
@@ -46,6 +47,7 @@ enum {
 #define MT_HVC_GZVM_ENABLE_CAP		GZVM_HCALL_ID(GZVM_FUNC_ENABLE_CAP)
 #define MT_HVC_GZVM_INFORM_EXIT		GZVM_HCALL_ID(GZVM_FUNC_INFORM_EXIT)
 #define MT_HVC_GZVM_MEMREGION_PURPOSE	GZVM_HCALL_ID(GZVM_FUNC_MEMREGION_PURPOSE)
+#define MT_HVC_GZVM_SET_DTB_CONFIG	GZVM_HCALL_ID(GZVM_FUNC_SET_DTB_CONFIG)
 
 #define GIC_V3_NR_LRS			16
 
diff --git a/arch/arm64/geniezone/vm.c b/arch/arm64/geniezone/vm.c
index 17327081eb27..a47e1d60dc1f 100644
--- a/arch/arm64/geniezone/vm.c
+++ b/arch/arm64/geniezone/vm.c
@@ -119,6 +119,15 @@ int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
 				    mem->flags, 0, 0, 0, &res);
 }
 
+int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *cfg)
+{
+	struct arm_smccc_res res;
+
+	return gzvm_hypcall_wrapper(MT_HVC_GZVM_SET_DTB_CONFIG, gzvm->vm_id,
+				    cfg->dtb_addr, cfg->dtb_size, 0, 0, 0, 0,
+				    &res);
+}
+
 static int gzvm_vm_arch_enable_cap(struct gzvm *gzvm,
 				   struct gzvm_enable_cap *cap,
 				   struct arm_smccc_res *res)
diff --git a/drivers/virt/geniezone/gzvm_vm.c b/drivers/virt/geniezone/gzvm_vm.c
index a1cf970e4c91..8e9967b754df 100644
--- a/drivers/virt/geniezone/gzvm_vm.c
+++ b/drivers/virt/geniezone/gzvm_vm.c
@@ -413,6 +413,16 @@ static long gzvm_vm_ioctl(struct file *filp, unsigned int ioctl,
 		ret = gzvm_vm_ioctl_enable_cap(gzvm, &cap, argp);
 		break;
 	}
+	case GZVM_SET_DTB_CONFIG: {
+		struct gzvm_dtb_config cfg;
+
+		if (copy_from_user(&cfg, argp, sizeof(cfg))) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = gzvm_arch_set_dtb_config(gzvm, &cfg);
+		break;
+	}
 	default:
 		ret = -ENOTTY;
 	}
diff --git a/include/linux/gzvm_drv.h b/include/linux/gzvm_drv.h
index 369c3df6c0b5..7bc00218dce6 100644
--- a/include/linux/gzvm_drv.h
+++ b/include/linux/gzvm_drv.h
@@ -143,6 +143,7 @@ void gzvm_vm_irqfd_release(struct gzvm *gzvm);
 
 int gzvm_arch_memregion_purpose(struct gzvm *gzvm,
 				struct gzvm_userspace_memory_region *mem);
+int gzvm_arch_set_dtb_config(struct gzvm *gzvm, struct gzvm_dtb_config *args);
 
 int gzvm_init_ioeventfd(struct gzvm *gzvm);
 int gzvm_ioeventfd(struct gzvm *gzvm, struct gzvm_ioeventfd *args);
diff --git a/include/uapi/linux/gzvm.h b/include/uapi/linux/gzvm.h
index 506ef975de02..d37be00fbeea 100644
--- a/include/uapi/linux/gzvm.h
+++ b/include/uapi/linux/gzvm.h
@@ -326,4 +326,18 @@ struct gzvm_ioeventfd {
 
 #define GZVM_IOEVENTFD	_IOW(GZVM_IOC_MAGIC, 0x79, struct gzvm_ioeventfd)
 
+/**
+ * struct gzvm_dtb_config: store address and size of dtb passed from userspace
+ *
+ * @dtb_addr: dtb address set by VMM (guset memory)
+ * @dtb_size: dtb size
+ */
+struct gzvm_dtb_config {
+	__u64 dtb_addr;
+	__u64 dtb_size;
+};
+
+#define GZVM_SET_DTB_CONFIG       _IOW(GZVM_IOC_MAGIC, 0xff, \
+				       struct gzvm_dtb_config)
+
 #endif /* __GZVM_H__ */
-- 
2.18.0

