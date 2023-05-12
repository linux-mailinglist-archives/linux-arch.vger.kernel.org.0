Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564D270022A
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240381AbjELIFZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 04:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240398AbjELIEr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 04:04:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E0D106C7;
        Fri, 12 May 2023 01:04:15 -0700 (PDT)
X-UUID: 92b2b07af09b11ed9cb5633481061a41-20230512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nAUmtovh2BSgF+M7TxMbWY5EpQy5nM1PKExUhM4zzcI=;
        b=WGyb10Qxzps3F8ljlrsj47rkATsuMPV56TNIH0KxTACPv7+58i5GOjoLw37/OcfiOPrVE/Wo4zdd5hOclFX26x10ePeYzPHtwouSw14UDdUJYj7eUFHD7UB8p6u/cffDAb7nW3O78OhRCLirFUmiPYGdSyrCyXp3BJthHKoffXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:777c7dcc-a9d0-42d1-8504-6a72770b2228,IP:0,U
        RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-META: VersionHash:178d4d4,CLOUDID:be64f53a-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 92b2b07af09b11ed9cb5633481061a41-20230512
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 838509526; Fri, 12 May 2023 16:04:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.194) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 May 2023 16:04:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 May 2023 16:04:07 +0800
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
Subject: [PATCH v3 1/7] docs: geniezone: Introduce GenieZone hypervisor
Date:   Fri, 12 May 2023 16:03:59 +0800
Message-ID: <20230512080405.12043-2-yi-de.wu@mediatek.com>
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

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 Documentation/virt/geniezone/introduction.rst | 34 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 40 insertions(+)
 create mode 100644 Documentation/virt/geniezone/introduction.rst

diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
new file mode 100644
index 000000000000..1fffd6cbb4db
--- /dev/null
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,34 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+
+Overview
+========
+GenieZone is MediaTek proprietary hypervisor solution, and it is running in EL2
+stand alone as a type-I hypervisor. It is a pure EL2 implementation which
+implies it does not rely any specific host VM, and this behavior improves
+GenieZone's security as it limits its interface.
+
+To enable guest VMs running, a driver (gzvm) is provided for VMM (virtual
+machine monitor) to operate. Currently, the gzvm driver supports only crosvm.
+
+
+Supported Architecture
+======================
+GenieZone now only supports MediaTek arm64 SoC.
+
+
+Platform Virtualization
+=======================
+We leverages arm64's timer virtualization and gic virtualization for timer and
+interrupts controller.
+
+
+Device Virtualizaton
+====================
+We adopts VMM's virtio devices emulations by passing io trap to VMM, and virtio
+is a well-known and widely used virtual device implementation.
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 7a91f14cad2e..523246ff3d15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8705,6 +8705,12 @@ F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
 
+GENIEZONE HYPERVISOR DRIVER
+M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
+M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
+M:	Yi-De Wu <yi-de.wu@mediatek.com>
+F:	Documentation/virt/geniezone/
+
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>
 S:	Supported
-- 
2.18.0

