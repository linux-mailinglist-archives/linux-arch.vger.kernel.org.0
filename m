Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8070C7293BB
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jun 2023 10:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbjFIIwy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jun 2023 04:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbjFIIwZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jun 2023 04:52:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8FB95;
        Fri,  9 Jun 2023 01:52:21 -0700 (PDT)
X-UUID: ef24577406a211ee9cb5633481061a41-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dLIYRoXshZCYjSVWIjyzdBAAVLO0fisUp3j6Z8T0P4A=;
        b=WJcos5W5Et208j+7Ov+VCgujf7AwzkGwRkTxArFJGzYkL8TAaLTC4lMzBwC7fgJes8ALOKUW7INM3bjiqWljN23pNxG7wtFKdtuZDpzS9U4lRTo9P7w0+emRgTROjmpYTABl4Er5ZBZAbYrxhQ+CMbQo2nKlmiB53O5S7C1AiH8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:70af0df7-d156-4991-861e-a728b95b32fb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:47,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:47
X-CID-INFO: VERSION:1.1.26,REQID:70af0df7-d156-4991-861e-a728b95b32fb,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:47,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:47
X-CID-META: VersionHash:cb9a4e1,CLOUDID:15f8ea3d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230609165216951NQGEH,BulkQuantity:0,Recheck:0,SF:48|101|38|29|28|100
        |17|19|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:ni
        l,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: ef24577406a211ee9cb5633481061a41-20230609
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yi-de.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1656020971; Fri, 09 Jun 2023 16:52:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 16:52:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 16:52:15 +0800
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
Subject: [PATCH v4 1/9] docs: geniezone: Introduce GenieZone hypervisor
Date:   Fri, 9 Jun 2023 16:52:06 +0800
Message-ID: <20230609085214.31071-2-yi-de.wu@mediatek.com>
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

From: "Yi-De Wu" <yi-de.wu@mediatek.com>

GenieZone is MediaTek proprietary hypervisor solution, and it is running
in EL2 stand alone as a type-I hypervisor. It is a pure EL2
implementation which implies it does not rely any specific host VM, and
this behavior improves GenieZone's security as it limits its interface.

Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Signed-off-by: Liju Chen <liju-clr.chen@mediatek.com>
Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
---
 Documentation/virt/geniezone/introduction.rst | 79 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 85 insertions(+)
 create mode 100644 Documentation/virt/geniezone/introduction.rst

diff --git a/Documentation/virt/geniezone/introduction.rst b/Documentation/virt/geniezone/introduction.rst
new file mode 100644
index 000000000000..872c66f60e7f
--- /dev/null
+++ b/Documentation/virt/geniezone/introduction.rst
@@ -0,0 +1,79 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+GenieZone Introduction
+======================
+
+Overview
+========
+
+GenieZone hypervisor(gzvm) is a type-1 hypervisor that supports various virtual
+machine types and provides security features such as TEE-like scenarios and
+secure boot. It can create guest VMs for security use cases and has
+virtualization capabilities for both platform and interrupt. Although the
+hypervisor can be booted independently, it requires the assistance of GenieZone
+hypervisor kernel driver(gzvm-ko) to leverage the ability of Linux kernel for
+vCPU scheduling, memory management, inter-VM communication and virtio backend
+support.
+
+Supported Architecture
+======================
+
+GenieZone now only supports MediaTek ARM64 SoC.
+
+Features
+========
+
+- vCPU Management
+VM manager aims to provide vCPUs on the basis of time sharing on physical CPUs.
+It requires Linux kernel in host VM for vCPU scheduling and VM power management.
+
+- Memory Management
+Direct use of physical memory from VMs is forbidden and designed to be dictated
+to the privilege models managed by GenieZone hypervisor for security reason.
+With the help of gzvm-ko, the hypervisor would be able to manipulate memory as
+objects.
+
+- Virtual Platform
+We manage to emulate a virtual mobile platform for guest OS running on guest
+VM. The platform supports various architecture-defined devices, such as
+virtual virtual arch timer, GIC, MMIO, PSCI, and exception watching...etc.
+
+- Inter-VM Communication
+Communication among guest VMs was provided mainly on RPC. More communication
+mechanisms were to be provided in the future based on VirtIO-vsock.
+
+- Device Virtualization
+The solution is provided using the well-known VirtIO. The gzvm-ko would
+redirect MMIO traps back to VMM where the virtual devices are mostly emulated.
+Ioeventfd is implemented using eventfd for signaling host VM that some IO
+events in guest VMs need to be processed.
+
+- Interrupt virtualization
+All Interrupts during some guest VMs running would be handled by GenieZone
+hypervisor with the help of gzvm-ko, both virtual and physical ones. In case
+there's no guest VM running out there, physical interrupts would be handled by
+host VM directly for performance reason. Irqfd is also implemented using
+eventfd for accepting vIRQ requests in gzvm-ko.
+
+Platform architecture component
+===============================
+
+- vm
+The vm component is responsible for setting up the capability and memory
+management for the protected VMs. The capability is mainly about the lifecycle
+control and boot context initialization. And the memory management is highly
+integrated with ARM 2-stage translation tables to convert VA to IPA to PA under
+proper security measures required by protected VMs.
+
+- vcpu
+The vcpu component is the core of virtualizing aarch64 physical CPU runnable,
+and it controls the vCPU lifecycle including creating, running and destroying.
+With self-defined exit handler, the vm component would be able to act
+accordingly before terminated.
+
+- vgic
+The vgic component exposes control interfaces to Linux kernel via irqchip, and
+we intend to support all SPI, PPI, and SGI. When it comes to virtual
+interrupts, the GenieZone hypervisor would write to list registers and trigger
+vIRQ injection in guest VMs via GIC.
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a05599017b4..1b1db2073f8b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8745,6 +8745,12 @@ F:	include/vdso/
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

