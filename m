Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6802E6F15B5
	for <lists+linux-arch@lfdr.de>; Fri, 28 Apr 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjD1Kgm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Apr 2023 06:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjD1Kgi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Apr 2023 06:36:38 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7822D63;
        Fri, 28 Apr 2023 03:36:32 -0700 (PDT)
X-UUID: 877a8930e5b011ed9cb5633481061a41-20230428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=VrvPzdjmykf8LV0rQWRvkadsxeoVqDc5y4VYgRUobMA=;
        b=toQ/bRcn4XI3A+YzC3WoIt25El9oad8+7OxrBDqu6DIZUBnu0GRGBLEwldq28l4WSCUASX2a1ybC1s9FUXrucu8oY4Nv+FqOmeuB9WhMy6I1ZyOSFWmivyjoxIlAE+colf7/YJW6XcetcE6+tHxLTSmQ37OMzz8ITXz8M3e01QU=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.22,REQID:c5b30537-f9e8-48b8-8488-76e94e8215f0,IP:0,U
        RL:25,TC:0,Content:59,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,A
        CTION:quarantine,TS:184
X-CID-INFO: VERSION:1.1.22,REQID:c5b30537-f9e8-48b8-8488-76e94e8215f0,IP:0,URL
        :25,TC:0,Content:59,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_US65DF41,ACT
        ION:quarantine,TS:184
X-CID-META: VersionHash:120426c,CLOUDID:8e723fbf-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:230428183627KXSYCWYN,BulkQuantity:0,Recheck:0,SF:48|38|29|28|16|19|8
        01,TC:nil,Content:3,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 877a8930e5b011ed9cb5633481061a41-20230428
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1373314300; Fri, 28 Apr 2023 18:36:26 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Apr 2023 18:36:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 28 Apr 2023 18:36:25 +0800
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
        "David Bradil" <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
Subject: [PATCH v2 2/7] dt-bindings: hypervisor: Add MediaTek GenieZone hypervisor
Date:   Fri, 28 Apr 2023 18:36:17 +0800
Message-ID: <20230428103622.18291-3-yi-de.wu@mediatek.com>
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

Add documentation for GenieZone(gzvm) node. This node informs gzvm
driver to start probing if geniezone hypervisor is available and
able to do virtual machine operations.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 .../hypervisor/mediatek,geniezone-hyp.yaml    | 31 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml

diff --git a/Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml b/Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
new file mode 100644
index 000000000000..9dc0831cf175
--- /dev/null
+++ b/Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
@@ -0,0 +1,31 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hypervisor/mediatek,gzvm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek GenieZone hypervisor
+
+maintainers:
+  - Yingshiuan Pan <yingshiuan.pan@mediatek.com>
+
+description:
+  This interface is designed for integrating GenieZone hypervisor into Android
+  Virtualization Framework(AVF) along with Crosvm as a VMM.
+  It acts like a wrapper for every hypercalls to GenieZone hypervisor in
+  order to control guest VM lifecycles and virtual interrupt injections.
+
+properties:
+  compatible:
+    const: mediatek,geniezone-hyp
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    hypervisor {
+        compatible = "mediatek,geniezone-hyp";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index db8915114b86..1e911d1d9741 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8698,6 +8698,7 @@ GENIEZONE HYPERVISOR DRIVER
 M:	Yingshiuan Pan <yingshiuan.pan@mediatek.com>
 M:	Ze-Yu Wang <ze-yu.wang@mediatek.com>
 M:	Yi-De Wu <yi-de.wu@mediatek.com>
+F:	Documentation/devicetree/bindings/hypervisor/mediatek,geniezone-hyp.yaml
 F:	Documentation/virt/geniezone/
 
 GENWQE (IBM Generic Workqueue Card)
-- 
2.18.0

